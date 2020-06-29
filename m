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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CD22C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 09:31:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9FB020857
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 09:31:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OI7cwIma"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9FB020857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34486 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpq8h-000807-Qi
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 05:31:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46342)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1jpq7p-00077J-4k
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 05:30:53 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:42139)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1jpq7n-0007Ki-8G
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 05:30:52 -0400
Received: by mail-oi1-x244.google.com with SMTP id s21so13814871oic.9
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2020 02:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=wjK2dvgOn83MLXosC2akxLYDcXcgYuLXP0cI9yMca0g=;
 b=OI7cwImaOQJlwRFnvgu2dINuhDxKVvych4gxUxmwpug5o8zkijH9TBa+cY80VzpoZY
 +PXkudXHsU7gOj56phFtlE17mBSsqTc0haWSoYMHZJ6KggSCcolM7cKhfD0YhpvIRpSU
 bNraAmoOjicmi+y+uFI4rTTbJisLM7NoBuI7ZY3aNIcXJg4PJNoEyEQYQ/o7QOj1UVEF
 O/ceV0Vpzy21+MT4zXU97NgmVkWQNUtGjNmfW+O0MWNsEuH9FcXnRcgi+pgU9Htl67Fl
 OzaeVboIx49tVGCefbD65kLULJB3DdxNo/RxF7N06oTlXFg61LFKJeRjLxY3R7m0Q+CX
 dv3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=wjK2dvgOn83MLXosC2akxLYDcXcgYuLXP0cI9yMca0g=;
 b=EcPgOYOewBnKiU1Koa1MulR9GGd99cG0nwf+8c1MqElyw2oLwHtgJVkFqkYnap7P3V
 oe/oygSO67hrg6+t5jf9wIRwh2gpK1paiYX/PYuRt/IerUuA+itvu8Gj3hxw3zsK0O4C
 02NmfW11YzR8tVvmx0h2iruUkB+g3E6ORUpSryn1ERej/njatkSEotog9wDMqlFNU3SE
 EFWLv3YvJOeJMnq8DTNcgRZT/KUK1/4k1kdX/YYiOaE0XlrwYpop9iE0BZJuiNoRnGy2
 fBaSS/D2bpDtrQwhWeJdHrCMojTJv2+cH/g/FcnBONGpKQhgX63snBgLEjNv0FBS9/ek
 SRvw==
X-Gm-Message-State: AOAM531/nKOnIApZta0kAqw6bKoZJz3440xFb7SqLnY8Izm5EtkA07Ha
 uqE5UGRdHCTFr2o401n1y5naQMucvO6NUunspSw=
X-Google-Smtp-Source: ABdhPJyvv46DdA6ki7CgB0n82xF8oGpT5S3R3MXVtxtA/z7wtFn+RibGyh0vmAkhtKmeSFUoHfHh/BDGs0EXfglNBAo=
X-Received: by 2002:aca:524c:: with SMTP id g73mr6350369oib.150.1593423049802; 
 Mon, 29 Jun 2020 02:30:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200624185523.762240-1-ppandit@redhat.com>
 <20200624185523.762240-3-ppandit@redhat.com>
In-Reply-To: <20200624185523.762240-3-ppandit@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Mon, 29 Jun 2020 17:30:13 +0800
Message-ID: <CAKXe6SKEbi4hDquXYLOeKGcy9frcMhxd22QdUvqjutuHOkYd0g@mail.gmail.com>
Subject: Re: [PATCH v2 2/9] pci-host: add pcie-msi read method
To: P J P <ppandit@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::244;
 envelope-from=liq3ea@gmail.com; helo=mail-oi1-x244.google.com
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
> Add pcie-msi mmio read method to avoid NULL pointer dereference
> issue.
>
> Reported-by: Lei Sun <slei.casper@gmail.com>
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>

Reviewed-by: Li Qiang <liq3ea@gmail.com>

> ---
>  hw/pci-host/designware.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/hw/pci-host/designware.c b/hw/pci-host/designware.c
> index 8492c18991..82262bdfdf 100644
> --- a/hw/pci-host/designware.c
> +++ b/hw/pci-host/designware.c
> @@ -21,6 +21,7 @@
>  #include "qemu/osdep.h"
>  #include "qapi/error.h"
>  #include "qemu/module.h"
> +#include "qemu/log.h"
>  #include "hw/pci/msi.h"
>  #include "hw/pci/pci_bridge.h"
>  #include "hw/pci/pci_host.h"
> @@ -63,6 +64,13 @@ designware_pcie_root_to_host(DesignwarePCIERoot *root)
>      return DESIGNWARE_PCIE_HOST(bus->parent);
>  }
>
> +static uint64_t designware_pcie_root_msi_read(void *opaque, hwaddr addr,
> +                                              unsigned size)
> +{
> +    qemu_log_mask(LOG_UNIMP, "%s not implemented\n", __func__);
> +    return 0;
> +}
> +
>  static void designware_pcie_root_msi_write(void *opaque, hwaddr addr,
>                                             uint64_t val, unsigned len)
>  {
> @@ -77,6 +85,7 @@ static void designware_pcie_root_msi_write(void *opaque=
, hwaddr addr,
>  }
>
>  static const MemoryRegionOps designware_pci_host_msi_ops =3D {
> +    .read =3D designware_pcie_root_msi_read,
>      .write =3D designware_pcie_root_msi_write,
>      .endianness =3D DEVICE_LITTLE_ENDIAN,
>      .valid =3D {
> --
> 2.26.2
>

