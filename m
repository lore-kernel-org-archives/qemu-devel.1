Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E8FAC34031
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 22:12:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27CF8207FD
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 22:12:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QijWf5k7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27CF8207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42626 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4B6g-0007zs-BQ
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 17:12:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34320)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1j4B5k-0006oD-V3
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 17:11:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1j4B5j-0002Ee-8y
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 17:11:44 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26432
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1j4B5i-00029e-Ej
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 17:11:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582063901;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lHvW6d0yucq/956JFiSrjyIRNZSo8af1G9X+/4WTeDs=;
 b=QijWf5k7J3nqfuuntRjIHAEGvAL36X+ydiE+yI73Ot7apLs2S55inrxZKBMDgiZCfDOTB0
 /5yOL/CYPWG+7MWPGrcBbjdawFJMkzbTkCkfKaRmEfB/WGpbWL/TzRFseD1omkNKpG7biV
 K2F3MpnicDNYue/0zgLzKTb0Yy7q/Rs=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-422-F_jUNwDIN9e6OswdIXL5mg-1; Tue, 18 Feb 2020 17:11:38 -0500
Received: by mail-qt1-f199.google.com with SMTP id x8so14140268qtq.14
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2020 14:11:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=h18774Wz2exqs0j2iBMq+ye+VzTq/9nVbiRSa6r1z2o=;
 b=CcHb4/Hfk6JkQW72Uv1djK3ToqO+PShEWOkMyydOIFr0IPZLobFsNHmeik60tEzg5u
 L35H2vraYqm5RcxA0IwIjvy7kuhTjVCldRm3ml9pk4MKe6EsfHZHXVe/R6sHNvoGCKkr
 EuVdsfQHbpV0FHhW9lxd8nEx0ChLdc2EduHHBnGxOP0h0RoEyviH9CKq+YFnZhZrTxtg
 By8T3t/MZg6FM/dPXHRP0Ho02y4OEfTmk09+RAbO5HVWIVRk5pBn0sdSeeu0LjDUgl9E
 bX0Rg1K8khsCrLRBMYaR9YeTrNFFO7NGA6Daf43CreCEYIH5wHmvU8SSb0N6hK1HCxMH
 jbvw==
X-Gm-Message-State: APjAAAWBgZNVUTdAtQht+wu+HdfXjgAAqC3w2VgMohQtct1v143qtvBs
 eC46Qwxh5OljX2IwB2PjNWOX1Gnjf4LOYx66vWtooqZUG3Z8ViW0lnPGD56C0t6MySZcIySfu2T
 z85HForaxJJQ0nzI=
X-Received: by 2002:ac8:1977:: with SMTP id g52mr18977176qtk.18.1582063898218; 
 Tue, 18 Feb 2020 14:11:38 -0800 (PST)
X-Google-Smtp-Source: APXvYqxQ0PvjDyIXFqgZp+eOb96Oagtpc4mnFfhSpO0Rv3PN0ovJMqjBIBNSmajQm+CVmfWjCsxxWQ==
X-Received: by 2002:ac8:1977:: with SMTP id g52mr18977162qtk.18.1582063898000; 
 Tue, 18 Feb 2020 14:11:38 -0800 (PST)
Received: from xz-x1 ([104.156.64.74])
 by smtp.gmail.com with ESMTPSA id k4sm2502853qtj.74.2020.02.18.14.11.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Feb 2020 14:11:37 -0800 (PST)
Date: Tue, 18 Feb 2020 17:11:36 -0500
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v2 fixed 06/16] exec: Reuse qemu_ram_apply_settings() in
 qemu_ram_remap()
Message-ID: <20200218221136.GJ7090@xz-x1>
References: <20200212134254.11073-1-david@redhat.com>
 <20200212134254.11073-7-david@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200212134254.11073-7-david@redhat.com>
X-MC-Unique: F_jUNwDIN9e6OswdIXL5mg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Feb 12, 2020 at 02:42:44PM +0100, David Hildenbrand wrote:
> I don't see why we shouldn't apply all settings to make it look like the
> surrounding RAM (and enable proper VMA merging).
>=20
> Note: memory backend settings might have overridden these settings. We
> would need a callback to let the memory backend fix that up.
>=20
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Cc: Richard Henderson <rth@twiddle.net>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Igor Mammedov <imammedo@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

--=20
Peter Xu


