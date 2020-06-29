Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EB94C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 09:38:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC48223403
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 09:38:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tm+yyl+J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC48223403
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46592 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpqEq-0004oS-55
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 05:38:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47674)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1jpqDw-0003Sh-8J
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 05:37:12 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:43784)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1jpqDu-0000WG-Jk
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 05:37:11 -0400
Received: by mail-ot1-x341.google.com with SMTP id 95so4218543otw.10
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2020 02:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=CVQLX/Q43gxKRSua6KV/iIELe5WcNb8SgU6lwCP/quc=;
 b=Tm+yyl+JTezsvFovgBwpJP4lWces89bHfT1Q2G/eu76v6TbU/mtu6XeAW/U3LlDdfo
 /78zW5LviAR4b3FxK8sks6E2HzU3ECb+eGFRs08NwKEm6mNdTDixruaptRdyv3zHCZaG
 U9g7AZ4kxbh+eiwKeUx0AW3IgL+h7tXw2o2oACVrgwew58pLgy1HauGuy0u+7gwnMGlj
 F0mkf84mar5YaVmrLxqhmDgdPIayvs2lSBlS6BvjN3MohIRKhz96IK2tRbdiuNYWebxW
 bmcrUXI2GeT7wxbOjK6k2TsvaC9gACe8kgXDn9TNHTUc6HwLdyG2gwm+xKQnOdZgXPE2
 T9BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=CVQLX/Q43gxKRSua6KV/iIELe5WcNb8SgU6lwCP/quc=;
 b=nzzhZ3COr1dkjRlDEK+BxFLNJrNZy7b8deiLeRSLxJ+tlV+iHwYr3J6cprnQwCBBOZ
 F3E7grlb2pXOx3MulmTJbh61781/sG+sEyVTsp6hMSAcWHU1pZS06KO8lIwifHppdHPx
 pjk/gC3jE8u8S+bMaIFyXdxvBrqdkIRUPoKw6KOMgDHd5oyHTLu5Wtf7r45k0zgrHrv1
 tLxpK+u+kiaIpGjzSEgimBBt4fnaYx83xKmuqrp2OnaMShV1HTaUqSb2lmU4Hk5+SMwh
 Kufz+ro+d0gcHCM9FcP0fGiR5ejHQX5jjfDOQ4O8b4RlcNXypUsmAR9cDWisSx7Rwyl7
 VWng==
X-Gm-Message-State: AOAM531PzQD12UpNdIM7iJGBRtB9K+H+2K9zfmJfmTJSLDbI9b5eIA3P
 JJhaO7S+b0eme8b09NP2IMrAqv6eGooQtieQTco=
X-Google-Smtp-Source: ABdhPJxhPU0d8a16XstTWb3kn+evaH/hIdGglmhhwPv3kCJuwSdhVnItbB6MGNS4dQcaWh2XML8v/kPBDkTZKw9PPE4=
X-Received: by 2002:a9d:787:: with SMTP id 7mr338483oto.333.1593423429650;
 Mon, 29 Jun 2020 02:37:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200624185523.762240-1-ppandit@redhat.com>
 <20200624185523.762240-4-ppandit@redhat.com>
In-Reply-To: <20200624185523.762240-4-ppandit@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Mon, 29 Jun 2020 17:36:33 +0800
Message-ID: <CAKXe6S+QpdhjHi6sT4CdPzeB9sBE1y33ri5jEZd=w1MWOjo7dQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/9] vfio: add quirk device write method
To: P J P <ppandit@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::341;
 envelope-from=liq3ea@gmail.com; helo=mail-ot1-x341.google.com
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
=91=A8=E5=9B=9B =E4=B8=8A=E5=8D=882:59=E5=86=99=E9=81=93=EF=BC=9A
>
> From: Prasad J Pandit <pjp@fedoraproject.org>
>
> Add vfio quirk device mmio write method to avoid NULL pointer
> dereference issue.
>
> Reported-by: Lei Sun <slei.casper@gmail.com>
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>

Reviewed-by: Li Qiang <liq3ea@gmail.com>

> ---
>  hw/vfio/pci-quirks.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> Update v2: use LOG_GUEST_ERROR
>   -> https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg04962.html
>
> diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
> index d304c81148..cc6d5dbc23 100644
> --- a/hw/vfio/pci-quirks.c
> +++ b/hw/vfio/pci-quirks.c
> @@ -14,6 +14,7 @@
>  #include "config-devices.h"
>  #include "exec/memop.h"
>  #include "qemu/units.h"
> +#include "qemu/log.h"
>  #include "qemu/error-report.h"
>  #include "qemu/main-loop.h"
>  #include "qemu/module.h"
> @@ -264,8 +265,15 @@ static uint64_t vfio_ati_3c3_quirk_read(void *opaque=
,
>      return data;
>  }
>
> +static void vfio_ati_3c3_quirk_write(void *opaque, hwaddr addr,
> +                                        uint64_t data, unsigned size)
> +{
> +    qemu_log_mask(LOG_GUEST_ERROR, "%s not implemented\n", __func__);
> +}
> +
>  static const MemoryRegionOps vfio_ati_3c3_quirk =3D {
>      .read =3D vfio_ati_3c3_quirk_read,
> +    .write =3D vfio_ati_3c3_quirk_write,
>      .endianness =3D DEVICE_LITTLE_ENDIAN,
>  };
>
> --
> 2.26.2
>

