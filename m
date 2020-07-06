Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7636AC433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 17:18:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43004206DF
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 17:18:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VlAqpNrK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43004206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44476 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsUkl-00032I-HT
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 13:18:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59030)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jsUIz-0000wH-El; Mon, 06 Jul 2020 12:49:21 -0400
Received: from mail-il1-x141.google.com ([2607:f8b0:4864:20::141]:40080)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jsUIx-0004Pa-5U; Mon, 06 Jul 2020 12:49:21 -0400
Received: by mail-il1-x141.google.com with SMTP id e18so22772008ilr.7;
 Mon, 06 Jul 2020 09:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Nbx9IfByicVhiGofOcBwvynyHEZt9D8sbVE/rksuBKQ=;
 b=VlAqpNrKxCPkyItSx5oheqbtPIm7Un993nTRk23s0wL2NGLawIMQzVHROozLKBVDd5
 LHl0zYjP+OtF6o5KCM2TWF3D0trQbqJllGxBp/wF+wAPypXHEobmGRqxoL3/0xh7rWkx
 j8jaHHPy4a3YnQNaORJvKpS9ppo1SeXplNNrhFolASokM8S9gInT9SKRXoF2QgD1Bqwf
 G86D9t4nLxd8UmlSyxQKfE3ljgAnll5zJQsGFXoPMQCHU4wy1XSfk8jrIjyh0LqkA3be
 yuS9Ls/ayZyVBKoKQ/zfRkyO0KCCrzz2lnyozUyBx9gJU0kF+xCHjyT8aIU9ckdbqsrY
 /WrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Nbx9IfByicVhiGofOcBwvynyHEZt9D8sbVE/rksuBKQ=;
 b=NDdfFxXHNxI4w2ZJkSE2AvbHuJmSicrfxbPndy1TT0nDUzDl7KtTG4bMoPYOUDXq1y
 3K/bZEMQaPpH6I/jNlNAgmMMnKdSDtWZhpYYGRxdcskfd3C7SoSXq8HNnCl6mKE0EUTq
 pR4YXpVYF0bR7koZyvrU+UqDtRhm1vW90HhAzcmmV3FVX32laqtiwf/hl2hqjxnZUGbz
 Koue6oMwUZUQyTyT/ZIOcFdEJQ1AxLhcyCKIatdYFag6YYJmQnYqXJRZaZs/COYq5ltT
 Cx1FIy41KQSIkoqucMutCdzRnFIMbdeXX+SX2UIh/N9WWKFSEjM9CLJFWQ7sek/D+er9
 lvBA==
X-Gm-Message-State: AOAM530tQQsuCBPPU5sFSCCwKllEtvVu4SOncZVaIf1DbOiYt5RuN6fR
 Wqcp75h63k5aDxdGeGoUxk+cP3NkwuIw1ZGAmm4=
X-Google-Smtp-Source: ABdhPJypGlcxLt+/3A86jvbCmBdwPrEotQsvQy+ykkvFqxTLUIHFUaSlyTkUU3qqKxSjMlyvMcc7jR24Tfa5V1UmX+s=
X-Received: by 2002:a92:5f12:: with SMTP id t18mr31642216ilb.267.1594054157141; 
 Mon, 06 Jul 2020 09:49:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200705213350.24725-1-f4bug@amsat.org>
 <20200705213350.24725-3-f4bug@amsat.org>
In-Reply-To: <20200705213350.24725-3-f4bug@amsat.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 6 Jul 2020 09:39:25 -0700
Message-ID: <CAKmqyKO_1HhM4WVejpEBcqNW9W6Ept9Vks0E75uF2CJAxHH0HQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] hw/sd/pxa2xx_mmci: Trivial simplification
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::141;
 envelope-from=alistair23@gmail.com; helo=mail-il1-x141.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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
 "open list:Trivial patches" <qemu-trivial@nongnu.org>,
 Alistair Francis <alistair@alistair23.me>, Michael Tokarev <mjt@tls.msk.ru>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Laurent Vivier <laurent@vivier.eu>, qemu-arm <qemu-arm@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Jul 5, 2020 at 2:35 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org=
> wrote:
>
> Avoid declaring PXA2xxMMCIState local variable, return it directly.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/sd/pxa2xx_mmci.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/hw/sd/pxa2xx_mmci.c b/hw/sd/pxa2xx_mmci.c
> index 9482b9212d..2996a2ef17 100644
> --- a/hw/sd/pxa2xx_mmci.c
> +++ b/hw/sd/pxa2xx_mmci.c
> @@ -480,10 +480,8 @@ PXA2xxMMCIState *pxa2xx_mmci_init(MemoryRegion *sysm=
em,
>  {
>      DeviceState *dev;
>      SysBusDevice *sbd;
> -    PXA2xxMMCIState *s;
>
>      dev =3D qdev_new(TYPE_PXA2XX_MMCI);
> -    s =3D PXA2XX_MMCI(dev);
>      sbd =3D SYS_BUS_DEVICE(dev);
>      sysbus_mmio_map(sbd, 0, base);
>      sysbus_connect_irq(sbd, 0, irq);
> @@ -491,7 +489,7 @@ PXA2xxMMCIState *pxa2xx_mmci_init(MemoryRegion *sysme=
m,
>      qdev_connect_gpio_out_named(dev, "tx-dma", 0, tx_dma);
>      sysbus_realize_and_unref(sbd, &error_fatal);
>
> -    return s;
> +    return PXA2XX_MMCI(dev);
>  }
>
>  static void pxa2xx_mmci_set_inserted(DeviceState *dev, bool inserted)
> --
> 2.21.3
>
>

