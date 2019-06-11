Return-Path: <SRS0=mXWu=UK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E919C43218
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 14:39:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D98CB20896
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 14:39:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D98CB20896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59732 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hahw7-0007Nq-VG
	for qemu-devel@archiver.kernel.org; Tue, 11 Jun 2019 10:39:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38525)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mst@redhat.com>) id 1hahgY-000482-EA
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 10:23:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1hahTv-0001HJ-Ol
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 10:10:38 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:46704)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1hahTl-00017E-Ms
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 10:10:27 -0400
Received: by mail-qt1-f195.google.com with SMTP id h21so14623791qtn.13
 for <qemu-devel@nongnu.org>; Tue, 11 Jun 2019 07:10:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=VE5kG7fSt4KpOcR+d0r6QKUqTv3yNwoIXRdkhjIE/3A=;
 b=Z8GAiu8hdrCKAt+sGnEdfdi7M25ojYKCOULMdiKmh7v8QZv6sWnTbxCq9tUJBHzzYf
 OrzRyExnYsgK/5+4vSWb7N6pIy3DS0gaXIQvT8OhfX5fELwah6/6eaSr+zf1g95142An
 78ltnZYFVck1U6VivSrmpLvjVGWLFwNT27j1Mfj2TIOM2CUjtJLiE7+hXVUOoTWKDOh4
 7FhbOZtX7/kniGovOY/p7StdbHG70P4GbbHkGwHBd8kj6VyQUFNbjqpZfh0ownFd3Nom
 aPHA5TyQYWHlImp/BWh2S2RWY2Ld20INVlNy4RUJOM4AmlDZSxwSZAhMBzoUSpwOMwKV
 06qg==
X-Gm-Message-State: APjAAAXvr1ARNpHOjuG2k1kHNK4AG7G5Q9pyx+XCgzioaBnPchyDGp48
 VbcIl/I5GAZFTpTMaHDNUUliog==
X-Google-Smtp-Source: APXvYqyK7J1VrIys/GIZiEcIZZDU8t/acNDX5Wo8eWYidf8aagz85b7yAtRetmcuW6PnMrDQdl8LmA==
X-Received: by 2002:aed:3987:: with SMTP id m7mr66008345qte.148.1560262218633; 
 Tue, 11 Jun 2019 07:10:18 -0700 (PDT)
Received: from redhat.com ([66.187.232.66])
 by smtp.gmail.com with ESMTPSA id c40sm2257574qtd.14.2019.06.11.07.10.16
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 11 Jun 2019 07:10:17 -0700 (PDT)
Date: Tue, 11 Jun 2019 10:10:14 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Tiwei Bie <tiwei.bie@intel.com>
Message-ID: <20190611085441-mutt-send-email-mst@kernel.org>
References: <20190611065137.16329-1-tiwei.bie@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190611065137.16329-1-tiwei.bie@intel.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.160.195
Subject: Re: [Qemu-devel] [RFC] vhost-user: don't ignore CTRL_VLAN feature
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
Cc: jasowang@redhat.com, qemu-devel@nongnu.org, qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jun 11, 2019 at 02:51:37PM +0800, Tiwei Bie wrote:
> The VIRTIO_NET_F_CTRL_VLAN feature requires the support of
> vhost-user backend. But it will be advertised to guest driver
> as long as it's enabled by users in QEMU, while it's not
> supported by vhost-user backend. This patch fixes this issue.

Fixes by making guest refuse to send vlan tags?
I agree it seems cleaner, but which guests does this actually help?

> Fixes: 72018d1e1917 ("vhost-user: ignore qemu-only features")
> Cc: qemu-stable@nongnu.org
> 
> Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>

A change like that will break migration compatibility, will it not?
Maybe we need to tie it to a machine version somehow...



> ---
> It's not clear in the spec that, whether vlan filtering is
> also best-effort:
> https://github.com/oasis-tcs/virtio-spec/blob/37057052e7/content.tex#L3372

So what breaks if we declare it best effort for now?
And does it really help if we report that vlan filtering
is not supported to guests?



>  hw/net/vhost_net.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
> index a6b719035c..1444fc9230 100644
> --- a/hw/net/vhost_net.c
> +++ b/hw/net/vhost_net.c
> @@ -75,6 +75,8 @@ static const int user_feature_bits[] = {
>      VIRTIO_NET_F_MTU,
>      VIRTIO_F_IOMMU_PLATFORM,
>  
> +    VIRTIO_NET_F_CTRL_VLAN,
> +
>      /* This bit implies RARP isn't sent by QEMU out of band */
>      VIRTIO_NET_F_GUEST_ANNOUNCE,
>  
> -- 
> 2.17.1

