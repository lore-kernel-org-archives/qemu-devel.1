Return-Path: <SRS0=NHD5=ZG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E93E5C432C3
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 13:40:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5C91206E1
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 13:40:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MOWGY25x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5C91206E1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57638 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVFMh-0002tk-Pl
	for qemu-devel@archiver.kernel.org; Thu, 14 Nov 2019 08:40:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35387)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iVFLc-0002Km-H6
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 08:39:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iVFLb-0001E7-4U
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 08:39:44 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:36996
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iVFLb-0001Ct-12
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 08:39:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573738782;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ClrBVan3Fg0CDEoPmWmbOOVrhyovfB4+xzncxs7BKwo=;
 b=MOWGY25xR99oIK5CS0a6crAe6XhupFdWTlRTuazAIWMM0EngEs8p/Q3g90xWI2/TjgLmdU
 GG5yNFD04IPdv7JBUdGThwvG64LgurdMDp1GE0M0RFK+ukzXTtZPEc3Q87ENC+NPDqBxX3
 hvjkrKp8kDzc4ZL5z/VrAmGT4n276Es=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-47-KJHJwMG_NmaYp8McpH92sg-1; Thu, 14 Nov 2019 08:39:38 -0500
Received: by mail-wm1-f69.google.com with SMTP id y133so3353938wmd.8
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2019 05:39:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=B5jW6FDPXFMYBj9b3TfwZfQISkYOsriJXS0ILiEPXBE=;
 b=U4M+0KZz0C9YsNd+BQ0LNYcUytoX+8tz/KNLczhDyRbfb6YhdrlRSQpbHyid//TBxe
 A8HZ6XmwmoX1r+kvkIkrElqv3zVJZvAYPRQw1uO7ZY0Jpi3nH0WGtYSstwGsm+9zbR2A
 8V45a1Mb6qtzv7ppFtoSjGLyFY9iggaN8nglyEMuXjKJQpoB4UhWRDFxu/BaboY87m9d
 dCMduwx1QgdH1x4S2cFDFtw9z8bBc6zJBuwazOQ8x3g8+IlGRf2FFev2sLjThrhmWLjK
 ZXXbXYVi+DH2XnRI7sy43HuHdLh7fVMcmSnL7efk2pD+UeR9YYTErGc84XmGNnDiaMDY
 qoIw==
X-Gm-Message-State: APjAAAXKMMOyk36vWgBcGgc6MDGWGdunkxVWjscHt8GRhSd1Q6qvW/Rg
 pPF83AGnTa+HziABIGUyNqQ/sja3uukqZ05QHYI5562rF/vxMRWWStUZUBcq7KbI8QoVUYCNMCR
 nR79hJieNVE2Y2tA=
X-Received: by 2002:adf:8543:: with SMTP id 61mr8894112wrh.171.1573738777845; 
 Thu, 14 Nov 2019 05:39:37 -0800 (PST)
X-Google-Smtp-Source: APXvYqxBcTssDO54f3vHfH4VuwEE09x2P4trlar8iTZfxwWmeh2CFgryWdqQv438Dn2T1aJspxYmwQ==
X-Received: by 2002:adf:8543:: with SMTP id 61mr8894091wrh.171.1573738777595; 
 Thu, 14 Nov 2019 05:39:37 -0800 (PST)
Received: from [192.168.1.35] (170.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.170])
 by smtp.gmail.com with ESMTPSA id k1sm7481535wrp.29.2019.11.14.05.39.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Nov 2019 05:39:36 -0800 (PST)
Subject: Re: [PATCH] vfio: don't ignore return value of migrate_add_blocker
To: Jens Freimann <jfreimann@redhat.com>, qemu-devel@nongnu.org
References: <20191114133449.11536-1-jfreimann@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <532fa7be-712f-d180-a3b2-757d7c8f87b1@redhat.com>
Date: Thu, 14 Nov 2019 14:39:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191114133449.11536-1-jfreimann@redhat.com>
Content-Language: en-US
X-MC-Unique: KJHJwMG_NmaYp8McpH92sg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: alex.williamson@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/14/19 2:34 PM, Jens Freimann wrote:
> When an error occurs in migrate_add_blocker() it sets a
> negative return value and uses error pointer we pass in.
> Instead of just looking at the error pointer check for a negative return
> value and avoid a coverity error because the return value is
> set but never used. This fixes CID 1407219.
>=20
> Fixes: f045a0104c8c ("vfio: unplug failover primary device before
>    migration")
> Signed-off-by: Jens Freimann <jfreimann@redhat.com>
> ---
>   hw/vfio/pci.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index e6569a7968..ed01774673 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -2737,7 +2737,7 @@ static void vfio_realize(PCIDevice *pdev, Error **e=
rrp)
>           error_setg(&vdev->migration_blocker,
>                   "VFIO device doesn't support migration");
>           ret =3D migrate_add_blocker(vdev->migration_blocker, &err);
> -        if (err) {
> +        if (ret) {
>               error_propagate(errp, err);
>               error_free(vdev->migration_blocker);
>               return;
>=20

Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>


