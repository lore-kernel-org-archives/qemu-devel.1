Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B16CEC433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 16:23:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80DA4207D4
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 16:23:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O/0FinP4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80DA4207D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53858 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkrtH-0002gM-Os
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 12:23:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54214)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jkrsX-00028L-Ai; Mon, 15 Jun 2020 12:22:33 -0400
Received: from mail-il1-x144.google.com ([2607:f8b0:4864:20::144]:42032)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jkrsV-0005Ky-GB; Mon, 15 Jun 2020 12:22:33 -0400
Received: by mail-il1-x144.google.com with SMTP id j19so11701744ilk.9;
 Mon, 15 Jun 2020 09:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=gt4hLmF2dCM3TlrYD7xVTyVmG1CVZP2DvITUqtVWs0M=;
 b=O/0FinP4fsVs9xx/tRwGrvp0EZofA+Q5wSjgz57rPUC6KX597xrm/wCZr3BgxlPG+I
 Gr1cGOSUColIhtOqOnw8jYEyUxJDQBWZ5wRRy2sYCX9DcKxKwinm4cBNWXEKRWpMZx2n
 A7zEQcIiRxI1u2OeFeL4YIv7fn9irk9/rvfery3wpQZMNNHkb6bXPTQIBRKOOZ2XX9Lt
 vv0PQB1BnliiDoVDHDcu5ggfPEg5Xfl+Ysi1I8aIFNtYoFoRx3BlKbzrknrJVimzMjB6
 uE6P8alJKjADJJwvtXuE6CR+hwr3S7ZEXFyb/b6qSo7h9XHSb9eknnwYbxGJVOqMrVdt
 SZCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=gt4hLmF2dCM3TlrYD7xVTyVmG1CVZP2DvITUqtVWs0M=;
 b=FrJS3aCDjcWoPA3N7w6jPKkhAi/kGbXBu6VLpOZyd8X/beUKompDp/vJJ3h2W2XgEg
 FgKwHDu0jRLWIhMly7g7dAxYyh0nJba2aTySJ/EjEIiHt2LNfAs2xqsQixwBjd/zGCO4
 EfCRc6UWG1nCy+IQyIyH+sc0mcigEIL1n8WeLU8u6/R4V8Sryir0OpMgyynX2QOl7hoV
 l/B/moLtBFF5clAoHCv55IJSeJRuvNCPSphY0afyi1D9S4xTWGqELCtFOYkpaEyJfMmn
 zcBTiKbIgkpCh/AKZAOnaKeogD4n7q/A1n+pnmzJ+TjBbYJ4zMzZr/2BBh0HKmXK1IJI
 mEGg==
X-Gm-Message-State: AOAM533XHMw1iiKYbi6GNn+K0o/u4zM0p0s7Cb2pN59G3h91oXGgvd8U
 P/Wjd2+NKyaVQF39nayoRIZfY1bID/bvj37Gb6w=
X-Google-Smtp-Source: ABdhPJxwhB4wstI/mvnaVjlih5WZQH8vZalQlIbBPlxZ4oSaFzstJaP+Zk02SSNEfFnJ6k2nPjUmg9QGyCc2PfU1wJs=
X-Received: by 2002:a05:6e02:4d:: with SMTP id
 i13mr28631665ilr.227.1592238150133; 
 Mon, 15 Jun 2020 09:22:30 -0700 (PDT)
MIME-Version: 1.0
References: <1591625864-31494-1-git-send-email-bmeng.cn@gmail.com>
 <1591625864-31494-6-git-send-email-bmeng.cn@gmail.com>
In-Reply-To: <1591625864-31494-6-git-send-email-bmeng.cn@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 15 Jun 2020 09:13:06 -0700
Message-ID: <CAKmqyKMuwWSSQGmQiLnGRCCN5r1y2MfEZUf_LBD2J1QesqHvcQ@mail.gmail.com>
Subject: Re: [PATCH 05/15] hw/riscv: sifive_gpio: Clean up the codes
To: Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::144;
 envelope-from=alistair23@gmail.com; helo=mail-il1-x144.google.com
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
Cc: Bin Meng <bin.meng@windriver.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmerdabbelt@google.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jun 8, 2020 at 7:22 AM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> From: Bin Meng <bin.meng@windriver.com>
>
> Do various minor clean-ups to the exisiting codes for:
>
> - coding convention conformance
> - remove unnecessary blank lines
> - spell SiFive correctly
>
> Signed-off-by: Bin Meng <bin.meng@windriver.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>
>  hw/riscv/sifive_gpio.c         | 13 +++++--------
>  include/hw/riscv/sifive_gpio.h |  7 ++++---
>  2 files changed, 9 insertions(+), 11 deletions(-)
>
> diff --git a/hw/riscv/sifive_gpio.c b/hw/riscv/sifive_gpio.c
> index 5c7c596..c9cffa2 100644
> --- a/hw/riscv/sifive_gpio.c
> +++ b/hw/riscv/sifive_gpio.c
> @@ -1,5 +1,5 @@
>  /*
> - * sifive System-on-Chip general purpose input/output register definition
> + * SiFive System-on-Chip general purpose input/output register definition
>   *
>   * Copyright 2019 AdaCore
>   *
> @@ -20,7 +20,6 @@
>
>  static void update_output_irq(SIFIVEGPIOState *s)
>  {
> -
>      uint32_t pending;
>      uint32_t pin;
>
> @@ -186,7 +185,7 @@ static uint64_t sifive_gpio_read(void *opaque, hwaddr offset, unsigned int size)
>  }
>
>  static void sifive_gpio_write(void *opaque, hwaddr offset,
> -                       uint64_t value, unsigned int size)
> +                              uint64_t value, unsigned int size)
>  {
>      SIFIVEGPIOState *s = SIFIVE_GPIO(opaque);
>
> @@ -318,7 +317,6 @@ static void sifive_gpio_reset(DeviceState *dev)
>      s->out_xor = 0;
>      s->in = 0;
>      s->in_mask = 0;
> -
>  }
>
>  static const VMStateDescription vmstate_sifive_gpio = {
> @@ -342,8 +340,8 @@ static const VMStateDescription vmstate_sifive_gpio = {
>          VMSTATE_UINT32(iof_en,    SIFIVEGPIOState),
>          VMSTATE_UINT32(iof_sel,   SIFIVEGPIOState),
>          VMSTATE_UINT32(out_xor,   SIFIVEGPIOState),
> -        VMSTATE_UINT32(in, SIFIVEGPIOState),
> -        VMSTATE_UINT32(in_mask, SIFIVEGPIOState),
> +        VMSTATE_UINT32(in,        SIFIVEGPIOState),
> +        VMSTATE_UINT32(in_mask,   SIFIVEGPIOState),
>          VMSTATE_END_OF_LIST()
>      }
>  };
> @@ -356,7 +354,6 @@ static void sifive_gpio_init(Object *obj)
>              TYPE_SIFIVE_GPIO, SIFIVE_GPIO_SIZE);
>      sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
>
> -
>      for (int i = 0; i < SIFIVE_GPIO_PINS; i++) {
>          sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->irq[i]);
>      }
> @@ -371,7 +368,7 @@ static void sifive_gpio_class_init(ObjectClass *klass, void *data)
>
>      dc->vmsd = &vmstate_sifive_gpio;
>      dc->reset = sifive_gpio_reset;
> -    dc->desc = "sifive GPIO";
> +    dc->desc = "SiFive GPIO";
>  }
>
>  static const TypeInfo sifive_gpio_info = {
> diff --git a/include/hw/riscv/sifive_gpio.h b/include/hw/riscv/sifive_gpio.h
> index fce03d6..ad915b2 100644
> --- a/include/hw/riscv/sifive_gpio.h
> +++ b/include/hw/riscv/sifive_gpio.h
> @@ -1,5 +1,5 @@
>  /*
> - * sifive System-on-Chip general purpose input/output register definition
> + * SiFive System-on-Chip general purpose input/output register definition
>   *
>   * Copyright 2019 AdaCore
>   *
> @@ -10,10 +10,12 @@
>   * This code is licensed under the GPL version 2 or later.  See
>   * the COPYING file in the top-level directory.
>   */
> +
>  #ifndef SIFIVE_GPIO_H
>  #define SIFIVE_GPIO_H
>
>  #include "hw/sysbus.h"
> +
>  #define TYPE_SIFIVE_GPIO "sifive_soc.gpio"
>  #define SIFIVE_GPIO(obj) OBJECT_CHECK(SIFIVEGPIOState, (obj), TYPE_SIFIVE_GPIO)
>
> @@ -66,7 +68,6 @@ typedef struct SIFIVEGPIOState {
>      uint32_t out_xor;
>      uint32_t in;
>      uint32_t in_mask;
> -
>  } SIFIVEGPIOState;
>
> -#endif
> +#endif /* SIFIVE_GPIO_H */
> --
> 2.7.4
>
>

