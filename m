Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E38F8C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 16:06:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABBAB20760
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 16:06:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jI1VvTgi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABBAB20760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35590 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiglJ-000765-Pr
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 12:06:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42500)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jigh6-0002l3-5H
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 12:01:44 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:53845
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jigh1-0003HG-UQ
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 12:01:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591718494;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=i9mw0jwDqk9vebneZAm+rfcmH4lN//ILG94TBWdT15g=;
 b=jI1VvTgiOt/rdeNlYtQKiRcjCwMvv5xayFTf5zzsS/M9FNFc0B75EhBfnbHsnD43wE/Fn7
 XDdFFuXfkMpSaNdXDlYtTnLtzAkZ1CBOCCC8S1u3/tXxPkf79HmcfgiqPunoQUCuRR3V9/
 DXrNdvQJ6v3q4LByyqjfL7swbhFwEXc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-130-DMGFA-GQPxKd9_h0IBzVVA-1; Tue, 09 Jun 2020 12:01:33 -0400
X-MC-Unique: DMGFA-GQPxKd9_h0IBzVVA-1
Received: by mail-wm1-f71.google.com with SMTP id b63so1059685wme.1
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 09:01:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=i9mw0jwDqk9vebneZAm+rfcmH4lN//ILG94TBWdT15g=;
 b=aD23P8kPJywJBi/HR/8eMC3aDnXP13Nb9XyrnPUCIZjh7ebEgWoX8adIVdvkATdPIt
 l3cGVIQH8F6seZ4luwNVp+mhoUbLyXxcuH0isDa1v+9Rrbj0eoz+sd2EzevTVz4OQnaq
 317V4DlUYj8Kotk9QpU3QBxCGBWjA2Q9c0UCL/tzOLtAuGl9ICjrgrWHwf/xt8s4UYg/
 AkK1rz6YljN29HqGXqwet1vNO94HpCycWuqXjLvKkDWLbIj2olUg5StCXXA9RVKFRTdn
 j3Kgn6TxFKB0gFyUW05E75MLhgDfp4SmbfSBaYHXJ/O+/poDxQD4+UHCuL/jjaByVRSi
 gV6w==
X-Gm-Message-State: AOAM531pTNnsJWyZEW/jZ3jcaFQQCfdKvdf5/PrW278U1zx3bR8zfcJj
 Qt/eAyCj1C8xRv7+OCvWlxRtF2L/lhDOSGNoXrelDeOJyGSSd9bNEdUm4znn0OlWRa3EHurRKON
 2u7zyVnZVnXhldnE=
X-Received: by 2002:a5d:408e:: with SMTP id o14mr5129564wrp.84.1591718491949; 
 Tue, 09 Jun 2020 09:01:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyN/kmT1mD5DAdfc2yIoMg5h96U9lEX8srTbHpB/HM+k7YK1UiWVh8jawTjEAAcaAaiezsmhA==
X-Received: by 2002:a5d:408e:: with SMTP id o14mr5129534wrp.84.1591718491702; 
 Tue, 09 Jun 2020 09:01:31 -0700 (PDT)
Received: from redhat.com (bzq-79-181-55-232.red.bezeqint.net. [79.181.55.232])
 by smtp.gmail.com with ESMTPSA id c81sm3482604wmd.42.2020.06.09.09.01.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2020 09:01:31 -0700 (PDT)
Date: Tue, 9 Jun 2020 12:01:28 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [RFC v2 18/18] guest memory protection: Alter virtio default
 properties for protected guests
Message-ID: <20200609120011-mutt-send-email-mst@kernel.org>
References: <20200521034304.340040-1-david@gibson.dropbear.id.au>
 <20200521034304.340040-19-david@gibson.dropbear.id.au>
 <20200606162014-mutt-send-email-mst@kernel.org>
 <20200607030735.GN228651@umbus.fritz.box>
 <20200609121641.5b3ffa48.cohuck@redhat.com>
 <20200609174046.0a0d83b9.pasic@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <20200609174046.0a0d83b9.pasic@linux.ibm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 02:41:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: pair@us.ibm.com, brijesh.singh@amd.com, frankja@linux.ibm.com,
 kvm@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>, dgilbert@redhat.com,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>, mdroth@linux.vnet.ibm.com,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jun 09, 2020 at 05:40:46PM +0200, Halil Pasic wrote:
> For s390x having a memory-encryption object is not prereq for doing
> protected virtualization, so the scheme does not work for us right now.

It does make things much easier implementation-wise while just
marginally harder to use though.

-- 
MST


