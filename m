Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93106C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 10:48:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5409323787
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 10:48:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="teks2oFl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5409323787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60746 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jprKl-0002oc-L0
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 06:48:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37344)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1jprK9-0002JX-5e
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 06:47:41 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:41046)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1jprK7-0003nR-H1
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 06:47:40 -0400
Received: by mail-oi1-x243.google.com with SMTP id y22so1371582oie.8
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2020 03:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=5Yu72MmdSIO88CfrlpSuUghtB9AhCr4y4sn2i53CdjQ=;
 b=teks2oFl2clc7AI3V5L748/+nhUh8VFPwd80nzVz/LIk0Yevzs1NMlUymgrlPFbqAk
 ib8nTjdpOm0leUuRTkmZSBulUgkZIlkvQlRPouNxxIYZ9cdufkWCwWJKBSNjL249a6oM
 I5zXspL1hfOi+g3TSW06AHCPcAN9GHFoveBysKR5w+zVmDINJZ6Rh7I1+Cw4PqsSNz6s
 bhVWfL2AAZc4jPfxEmE4r5uIJ7lHtHvihWXAjGjqZwFfQ7tbDqu7VbvxK737t/u2hYTi
 GUPaKakSmS8s6rRi8ok32fFwb/bAjIQ6G+HMKX79DNlC8+l44NxV8stFF+lrFlJfrG+M
 OVRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=5Yu72MmdSIO88CfrlpSuUghtB9AhCr4y4sn2i53CdjQ=;
 b=LYySeemm14QF5GBJC+ImYVDaulIZt3hEFV4zOPNSvpzp3b+PbmfE0WKZ6r+HbK+3nx
 GjvXzrZloFIaT1gYx8wEeuoOuoq3MWzM9ZSeFQ6TYse+wnnVH6TlN2miBbVSrJylWVbb
 EDuNBN5vIieqBpyQK5aeGBHO+vq0jGpepBmOD6xXJzpIs/d3VRMHrZO+Otr7eeiXPTTI
 AAAZv6LfMIGkiuMb2LFVIR4oJJfyGbwbPjOmysV5eSeQ4Kl5HSyXL89OitviVe4CKybS
 CxoHCnGN+nJ3pd2tb2dM88+ewI4m51iDmeoyBtInMJtQ1IJipDFwKL/Fu9lEmIvImN8d
 +zJQ==
X-Gm-Message-State: AOAM532VIrNX6UrF3trreDrWDOrHEI2ogwk/IXUdKZGEAxtysadZyswM
 XmGgIF/OOeaHNQ3ykDC2M3raTvQ7NZn6oky131I=
X-Google-Smtp-Source: ABdhPJy2HtYmkb+f3lMJI2qGwR1pNeHI8jwf6Hj1Gwq2YF7r4WcCF427xRbZshouG/UNLbm0h2tNYF6kE87zTBJTbx8=
X-Received: by 2002:aca:e044:: with SMTP id x65mr12093644oig.56.1593427658257; 
 Mon, 29 Jun 2020 03:47:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200624185523.762240-1-ppandit@redhat.com>
 <20200624185523.762240-9-ppandit@redhat.com>
In-Reply-To: <20200624185523.762240-9-ppandit@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Mon, 29 Jun 2020 18:47:02 +0800
Message-ID: <CAKXe6SK7rK7tW0FpzWn8h-3pFyyCw-WTES5T-r8OcJO=Yd-GHg@mail.gmail.com>
Subject: Re: [PATCH v2 8/9] imx7-ccm: add digprog mmio write method
To: P J P <ppandit@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::243;
 envelope-from=liq3ea@gmail.com; helo=mail-oi1-x243.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Prasad J Pandit <pjp@fedoraproject.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Lei Sun <slei.casper@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

P J P <ppandit@redhat.com> =E4=BA=8E2020=E5=B9=B46=E6=9C=8825=E6=97=A5=E5=
=91=A8=E5=9B=9B =E4=B8=8A=E5=8D=883:01=E5=86=99=E9=81=93=EF=BC=9A
>
> From: Prasad J Pandit <pjp@fedoraproject.org>
>
> Add digprog mmio write method to avoid assert failure during
> initialisation.
>
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>

Reviewed-by: Li Qiang <liq3ea@gmail.com>

> ---
>  hw/misc/imx7_ccm.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/hw/misc/imx7_ccm.c b/hw/misc/imx7_ccm.c
> index 02fc1ae8d0..5ac5ecf74c 100644
> --- a/hw/misc/imx7_ccm.c
> +++ b/hw/misc/imx7_ccm.c
> @@ -131,8 +131,15 @@ static const struct MemoryRegionOps imx7_set_clr_tog=
_ops =3D {
>      },
>  };
>
> +static void imx7_digprog_write(void *opaque, hwaddr addr,
> +                                        uint64_t data, unsigned size)
> +{
> +    qemu_log_mask(LOG_UNIMP, "%s not implemented\n", __func__);
> +}
> +
>  static const struct MemoryRegionOps imx7_digprog_ops =3D {
>      .read =3D imx7_set_clr_tog_read,
> +    .write =3D imx7_digprog_write,
>      .endianness =3D DEVICE_NATIVE_ENDIAN,
>      .impl =3D {
>          .min_access_size =3D 4,
> --
> 2.26.2
>

