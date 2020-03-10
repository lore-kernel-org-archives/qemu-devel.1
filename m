Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59B75C10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 18:05:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 230D620873
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 18:05:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JoO+4W0g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 230D620873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38028 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBjGO-00087k-Cw
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 14:05:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50816)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1jBjF8-0006mY-I5
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 14:04:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1jBjF7-0001Ke-Ji
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 14:04:38 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:46076
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1jBjF7-0001Fn-Aa
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 14:04:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583863476;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c+xOX9mv1vWnOIs8IVFTxa/x0zvudG4n7w9pUfQnze4=;
 b=JoO+4W0gWKSwKaIjisOkvP/L09nisCOs3bO3Y8FL1ES57hr5CAmYJI3s4/Et/G007shgIT
 Nqm1MGvf+4ElnT21Ey8iau79+7fcjLRb9qMQVHLwDR92K7v67D8NcGD2z7YOWXmNewEv4o
 H94QQiKzC8Memtd9gDCAvODJEOX9dOc=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-180-66Nx8vOeMWK-rC6l1rbuFQ-1; Tue, 10 Mar 2020 14:04:35 -0400
X-MC-Unique: 66Nx8vOeMWK-rC6l1rbuFQ-1
Received: by mail-qk1-f198.google.com with SMTP id b82so3317581qkc.11
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2020 11:04:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=X35yfMQwReR+oTrvPOM9crrpSHxbP8d45e9HTzSa+XQ=;
 b=sLZ4RffJy6sz7mDYuK34c5AeB7hWqPeb3vNetph961RRqGctBsPhK3o7udp5DP6PLQ
 9zBGF71N+fCGZqL3lvR2h8au+mNh5+DIPpMlMeNFkuZ1ewUPCpvSQoVNv/M0m7t2CdDI
 t+qLWUZApKCWra/tTT1lu8z4ZA7iderl3436cIP+87x4zP96yEwDb5Q4Samk3OnAhKBP
 yPTrnqv6obHF8gyrMoFjGhq6l52hGWeOqtNSkiXx2QK7NbEmvCgA1F2FA3B6vTs3071n
 L9pV9mGM+menCQHcoRskthgWCl/OeUZ52zy7uzihgE6u9wAvqFbDd9a5TDHJIDop/qtS
 C29w==
X-Gm-Message-State: ANhLgQ3SPdG6DPsA8RDVxtJSsFlKdoHZobMaYaGQotQ7OGWOMuuSvnsm
 1hsGDZ6bQ+osqHWgEnWnGLf4UKwbj4Fwx9EJnk6HeCm9EIJCaSf1stHL13Jgm+XMOn32LWH+Z7n
 1F7HLvJJVhKP91ec=
X-Received: by 2002:aed:2266:: with SMTP id o35mr20192942qtc.392.1583863474460; 
 Tue, 10 Mar 2020 11:04:34 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vupJ9MZihiUVW/UcGwd8JnUygSYSdRRMpjccDmheeO6ochpXKGqUCT2sOLtGxhjDQqYp6q3KQ==
X-Received: by 2002:aed:2266:: with SMTP id o35mr20192923qtc.392.1583863474153; 
 Tue, 10 Mar 2020 11:04:34 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
 by smtp.gmail.com with ESMTPSA id w204sm11834507qkb.133.2020.03.10.11.04.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2020 11:04:33 -0700 (PDT)
Date: Tue, 10 Mar 2020 14:04:32 -0400
From: Peter Xu <peterx@redhat.com>
To: Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [PATCH] hw/i386/intel_iommu: Fix out-of-bounds access on guest IRT
Message-ID: <20200310180432.GB479302@xz-x1>
References: <4b15b728-bdfe-3bbe-3a5c-ca3baeef3c5c@siemens.com>
MIME-Version: 1.0
In-Reply-To: <4b15b728-bdfe-3bbe-3a5c-ca3baeef3c5c@siemens.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Mar 10, 2020 at 06:42:11PM +0100, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
>=20
> vtd_irte_get failed to check the index against the configured table
> size, causing an out-of-bounds access on guest memory and potentially
> misinterpreting the result.
>=20
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

> ---
>=20
> BTW, we still miss error reporting emulation, right? Therefore, I added=
=20
> that simple error_report_once thing, like the other paths do.

Yes...

Thanks,

--=20
Peter Xu


