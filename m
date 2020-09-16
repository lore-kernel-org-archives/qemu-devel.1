Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13953C433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 15:42:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C92322288
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 15:42:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CYcV6mfc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C92322288
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38692 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIZZM-00057q-99
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 11:42:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38432)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>)
 id 1kIZYG-0003eO-2m; Wed, 16 Sep 2020 11:40:56 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:35016)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>)
 id 1kIZYD-0000bq-KP; Wed, 16 Sep 2020 11:40:55 -0400
Received: by mail-oi1-x241.google.com with SMTP id w16so8646545oia.2;
 Wed, 16 Sep 2020 08:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Z4XFpC8HVOqWVKMlwmppY/0mKycP09OAomU3WYC79XU=;
 b=CYcV6mfcbjIufDcbF7T+RF0OPA+FWGBizUr0WaY4RaMXrFKMD4+jRbEyWLdvkbmpw3
 tz/bqElibrZE88RjYm/YtAtJC2LSERlIA3SspfBJ11mq87Bs53xV4styhpVpsODbECI6
 YczyAIa2UciyH/HpRynos+272WFPkumlo3kxuAmTEJU1nBsmG1SnDIiwEivUdWezByUl
 QNGtb4jaUq3L7ROjs8eGFpxWSM1lka8006is3fv5ev4d2y1ZgfIw5TRB7U+ziLxHdgAs
 EI/3pqY0kf31jeI4jnl9lOYmfaCe0xU03oThVuzC/bqlRliR1LVMQO0ws6Uhnwfc3Op2
 YIkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Z4XFpC8HVOqWVKMlwmppY/0mKycP09OAomU3WYC79XU=;
 b=lLFNqsOsTh+TkXn/U2Hop8b9BxOIiIzMy2ZfydY6q3IsglISwp1ACUz81DbLteJhU5
 WlJa1vaprvc7ePeZsurrOHeLEOFh9xG4q836B/hCeXOLQWycGjqEJXDeB5UhHaL9EfT/
 TSVqzXInz4zQv7pHFN+Btnqm2UNI5kLkjQzvwJSWev1OaMGkSCs+17bIw+Th+fun4i3G
 UQQt3fBYADwkGLwORmFez8qDZk8XqMfX+MkxE3mZZxgELgbrpBFhEKe1D20S7gr21bqx
 z8ss31xlvAqbSfiq9/GSzBiJcho2iPnD7dMZOCzzThHO5LvjhOQoD9ienO3Fcm+OjfOE
 zKmA==
X-Gm-Message-State: AOAM532aHoKv1YSFaWtbyvZ9vesGp0Czc7hcxNefnt4lHah+6qABBGRE
 h6+rTHeLkzDI0u82VL88AvWFNl7jT1Ob/cBpuHc=
X-Google-Smtp-Source: ABdhPJxwsW02zktIRWI8ul/eqiUiPTvUishKo4PJxcm3kZ1qfbraPPRPzczrzDqroxBgaSMNSdt4Gs8GF2MsvA1puV4=
X-Received: by 2002:aca:e155:: with SMTP id y82mr3779473oig.56.1600270852227; 
 Wed, 16 Sep 2020 08:40:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200916152634.56917-1-sgarzare@redhat.com>
In-Reply-To: <20200916152634.56917-1-sgarzare@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Wed, 16 Sep 2020 23:40:16 +0800
Message-ID: <CAKXe6SKFHD2qJY+M33UQDJ2uaWH99uQk5ZOwWmck8VYE7ZyaXA@mail.gmail.com>
Subject: Re: [PATCH] vhost-vdpa: fix indentation in vdpa_ops
To: Stefano Garzarella <sgarzare@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::241;
 envelope-from=liq3ea@gmail.com; helo=mail-oi1-x241.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-trivial@nongnu.org, Qemu Developers <qemu-devel@nongnu.org>,
 Cindy Lu <lulu@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Stefano Garzarella <sgarzare@redhat.com> =E4=BA=8E2020=E5=B9=B49=E6=9C=8816=
=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=8811:27=E5=86=99=E9=81=93=EF=BC=
=9A
>
> This patch fixes wrong indentation of some vdpa_ops fields introduced
> with the initial commit 108a64818e ("vhost-vdpa: introduce vhost-vdpa
> backend")
>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>

Reviewed-by: Li Qiang <liq3ea@gmail.com>

> ---
>  hw/virtio/vhost-vdpa.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
> index 4580f3efd8..e123837a55 100644
> --- a/hw/virtio/vhost-vdpa.c
> +++ b/hw/virtio/vhost-vdpa.c
> @@ -469,6 +469,6 @@ const VhostOps vdpa_ops =3D {
>          .vhost_send_device_iotlb_msg =3D NULL,
>          .vhost_dev_start =3D vhost_vdpa_dev_start,
>          .vhost_get_device_id =3D vhost_vdpa_get_device_id,
> -         .vhost_vq_get_addr =3D vhost_vdpa_vq_get_addr,
> -         .vhost_force_iommu =3D vhost_vdpa_force_iommu,
> +        .vhost_vq_get_addr =3D vhost_vdpa_vq_get_addr,
> +        .vhost_force_iommu =3D vhost_vdpa_force_iommu,
>  };
> --
> 2.26.2
>
>

