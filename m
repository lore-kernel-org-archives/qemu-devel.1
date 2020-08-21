Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E49F8C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 18:59:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD41B20714
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 18:59:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u4/vk1rS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD41B20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44290 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9CG3-0000en-UO
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 14:59:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52734)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1k9CEi-0007ma-Pi; Fri, 21 Aug 2020 14:58:01 -0400
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41]:41364)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1k9CEg-0004Mc-9O; Fri, 21 Aug 2020 14:58:00 -0400
Received: by mail-io1-xd41.google.com with SMTP id m23so2145570iol.8;
 Fri, 21 Aug 2020 11:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=s9PUk9BfR75TB7lqidjE6k1/7Kv4GQdK8e5XZjVnCKY=;
 b=u4/vk1rSx9JPmhW4r46Swy5BdcwucI0Aa0TWaDLGJfD8IIUSazCbHd1hi7f22b8qZM
 e7TWRexavto2V6bK6XnBZ9tPXCSKuvkOqMJ7Sm6c9ZzstbeaReScK3xMvJke/F9QBtj9
 xawoKJpLDVfA+UkQAMdY6psyjFXwRjXPGMvZljy2JJPbJItVUAk3KusdmFiuvEO833XJ
 slfLq7VrmJ252L0kc4KKd/8XRBeWM7Guj7GMWBtPxHzPwzcZFzoiyqg4ORgwJYrjcov9
 Iu68GfLhJYPN1W24tIfiZyOMWDDq5ipinP6GdG2NrjUTTvaK3NU3Ov20uHl7zQT9Ne8v
 SJkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=s9PUk9BfR75TB7lqidjE6k1/7Kv4GQdK8e5XZjVnCKY=;
 b=dVDmwt5wGhoHzdLRbR+1G5m7TPKQLFtrvooXEUxy12mMSgJ7+rd3mQO/huCTkYzjbO
 idrC+61QjPoCZwR0Av/+dKgYXWKmQK8DSbjzjR0/q1eFEQmWqMTiw/XFlSldkxZ12he4
 4QRx0FZGr5gCGQ321tHpXm3HxwV5/4i677cti9omeeRv5BiVvGh/gRPAF4nsVi8yTcod
 JywrwDXcfzEgR9LC4IygwF14j0rZagrE8iUKojFRULpppzlraRPW4g1ospZXtak09S5I
 5FjThAr5CZfjcDulAaJRiz9xL2iBSENIVr8nJoTQVuO0W9zEEgooDUjBrUOZ1EbW9AB6
 Sykg==
X-Gm-Message-State: AOAM530Hn4IfZq46WrY2wRcWOOrbo4nLN/zbO5j2iMxb5BoaiArqeuNP
 riUxIIOHpVJos8NyDattsszK81xURdy/KK3jwKw=
X-Google-Smtp-Source: ABdhPJwbXZCSKP22zjLkqPyKPD0ro1n+B15j4pUNRGRqa84igZ6okNeMyI5lcB2uWdEixpIViXIEcpTFPQR6lr6N5XE=
X-Received: by 2002:a5d:995a:: with SMTP id v26mr3380193ios.176.1598036276715; 
 Fri, 21 Aug 2020 11:57:56 -0700 (PDT)
MIME-Version: 1.0
References: <1597423256-14847-1-git-send-email-bmeng.cn@gmail.com>
 <1597423256-14847-17-git-send-email-bmeng.cn@gmail.com>
In-Reply-To: <1597423256-14847-17-git-send-email-bmeng.cn@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 21 Aug 2020 11:47:19 -0700
Message-ID: <CAKmqyKPQVybDkwFqM0TjWSBruBPiPBy4fx3Hvfpy6bOkv9q6MA@mail.gmail.com>
Subject: Re: [PATCH 16/18] hw/riscv: microchip_pfsoc: Hook GPIO controllers
To: Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d41;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd41.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Aug 14, 2020 at 9:53 AM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> From: Bin Meng <bin.meng@windriver.com>
>
> Microchip PolarFire SoC integrates 3 GPIOs controllers. It seems
> enough to create unimplemented devices to cover their register
> spaces at this point.
>
> With this commit, QEMU can boot to U-Boot (2nd stage bootloader)
> all the way to the Linux shell login prompt, with a modified HSS
> (1st stage bootloader).
>
> Signed-off-by: Bin Meng <bin.meng@windriver.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>
>  hw/riscv/microchip_pfsoc.c         | 14 ++++++++++++++
>  include/hw/riscv/microchip_pfsoc.h |  3 +++
>  2 files changed, 17 insertions(+)
>
> diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
> index 625b511..139284a 100644
> --- a/hw/riscv/microchip_pfsoc.c
> +++ b/hw/riscv/microchip_pfsoc.c
> @@ -89,6 +89,9 @@ static const struct MemmapEntry {
>      [MICROCHIP_PFSOC_MMUART4] =         { 0x20106000,     0x1000 },
>      [MICROCHIP_PFSOC_GEM0] =            { 0x20110000,     0x2000 },
>      [MICROCHIP_PFSOC_GEM1] =            { 0x20112000,     0x2000 },
> +    [MICROCHIP_PFSOC_GPIO0] =           { 0x20120000,     0x1000 },
> +    [MICROCHIP_PFSOC_GPIO1] =           { 0x20121000,     0x1000 },
> +    [MICROCHIP_PFSOC_GPIO2] =           { 0x20122000,     0x1000 },
>      [MICROCHIP_PFSOC_ENVM_CFG] =        { 0x20200000,     0x1000 },
>      [MICROCHIP_PFSOC_ENVM_DATA] =       { 0x20220000,    0x20000 },
>      [MICROCHIP_PFSOC_IOSCB_CFG] =       { 0x37080000,     0x1000 },
> @@ -308,6 +311,17 @@ static void microchip_pfsoc_soc_realize(DeviceState *dev, Error **errp)
>      sysbus_connect_irq(SYS_BUS_DEVICE(&s->gem1), 0,
>          qdev_get_gpio_in(DEVICE(s->plic), MICROCHIP_PFSOC_GEM1_IRQ));
>
> +    /* GPIOs */
> +    create_unimplemented_device("microchip.pfsoc.gpio0",
> +        memmap[MICROCHIP_PFSOC_GPIO0].base,
> +        memmap[MICROCHIP_PFSOC_GPIO0].size);
> +    create_unimplemented_device("microchip.pfsoc.gpio1",
> +        memmap[MICROCHIP_PFSOC_GPIO1].base,
> +        memmap[MICROCHIP_PFSOC_GPIO1].size);
> +    create_unimplemented_device("microchip.pfsoc.gpio2",
> +        memmap[MICROCHIP_PFSOC_GPIO2].base,
> +        memmap[MICROCHIP_PFSOC_GPIO2].size);
> +
>      /* eNVM */
>      memory_region_init_rom(envm_data, OBJECT(dev), "microchip.pfsoc.envm.data",
>                             memmap[MICROCHIP_PFSOC_ENVM_DATA].size,
> diff --git a/include/hw/riscv/microchip_pfsoc.h b/include/hw/riscv/microchip_pfsoc.h
> index 60f994c..993b17c 100644
> --- a/include/hw/riscv/microchip_pfsoc.h
> +++ b/include/hw/riscv/microchip_pfsoc.h
> @@ -89,6 +89,9 @@ enum {
>      MICROCHIP_PFSOC_MMUART4,
>      MICROCHIP_PFSOC_GEM0,
>      MICROCHIP_PFSOC_GEM1,
> +    MICROCHIP_PFSOC_GPIO0,
> +    MICROCHIP_PFSOC_GPIO1,
> +    MICROCHIP_PFSOC_GPIO2,
>      MICROCHIP_PFSOC_ENVM_CFG,
>      MICROCHIP_PFSOC_ENVM_DATA,
>      MICROCHIP_PFSOC_IOSCB_CFG,
> --
> 2.7.4
>
>

