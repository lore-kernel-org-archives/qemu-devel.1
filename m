Return-Path: <SRS0=5nOY=BY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEAE6C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 15:32:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D06220716
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 15:32:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J6rbG0mp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D06220716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40728 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6bgl-000650-Py
	for qemu-devel@archiver.kernel.org; Fri, 14 Aug 2020 11:32:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54216)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1k6bSq-0007zT-Pk
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 11:17:52 -0400
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41]:40882)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1k6bSo-0000ZI-OP
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 11:17:52 -0400
Received: by mail-io1-xd41.google.com with SMTP id b17so11084941ion.7
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2020 08:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=+MQO3t/+rR8AE3gon5BeAhaHY5XFSnBtxo2HnQ4PG9Q=;
 b=J6rbG0mpJWhEXkpzKnrlfKlxqy/0Idr4lyybB+lCgMmmGZkYp1S+QYx47wOjkhmfKH
 knJB8Ll2kSv4TMYvQ4Enr939LAHcJIAua6xjLlprfbpqxooyJSIxYOKhoKSpT8NHuziA
 ORDKhFCAZlZBFjwGRRdxEMzoZ1/7dPh+Q31ouywMk0a0nn3bUQOoIJffXZRZqOmY9O1K
 OsnfVptFNsxBXnVQcDPhWEYC8UiI0bQz07T6+g1XZjayHmiWGy1NU+2qqBmanpSwfC0q
 A205G6KSBqFToeK0BZiMEkgsjgMvjG3qDxdt84ldQLmqGvmSIjBKJm93zulM6qBvRA0a
 OLBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+MQO3t/+rR8AE3gon5BeAhaHY5XFSnBtxo2HnQ4PG9Q=;
 b=k3NpbiYUxjpjXZA15xtMWnIrKak6FcxoPzeRtHuHODwJY7Lp25tcj+s1tPR2m2SMMh
 4mmTk+HmdLsFVB6GWK7NJv7ra1YoKVU6MRfWBPMXfgd600hCSLTJtgSPuPwnOAx1Reh4
 1CkRlUIBHVLndylzu1vFEc9WHSXJ/HswaiPJ5a+gWxcxI/JuBbUsW5x+EYdtQfFBTrXN
 zUJ2qXJGsl904e4CFsWtJ1hv+UucK06nsZjHul6XYR+bMWsOZVS4Uqp72c/8mYtE0MEQ
 JYzJppri+dbyLd33mE8YegOOIRwzWrunYY7utzG+MWGSuW22knSvtFmD+PmlSInYZJfI
 jN6g==
X-Gm-Message-State: AOAM533frkbLj4gb0QPMBk4O6CWGpeQyeWk20UTNPEPp7hTvPrZebcfT
 IPq7h66Rf2eQxel/wqdYd7uzGH2mYy9nfUOdtT07Q577Va4=
X-Google-Smtp-Source: ABdhPJx8FD3SMx1Iljo4uDpfhxdOO/C0pPujKsnuengfqocM5f4qjQeKjeNruGeNXVFSD8n97XFU1yB9v1R6TSJzAvc=
X-Received: by 2002:a6b:6016:: with SMTP id r22mr2583733iog.42.1597418269446; 
 Fri, 14 Aug 2020 08:17:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200813222625.243136-1-ehabkost@redhat.com>
 <20200813222625.243136-10-ehabkost@redhat.com>
In-Reply-To: <20200813222625.243136-10-ehabkost@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 14 Aug 2020 08:07:20 -0700
Message-ID: <CAKmqyKNKLUUgQ=5U_KfFwSw98-h+FShL-KzNhAPnv1VaJoVj7g@mail.gmail.com>
Subject: Re: [PATCH 09/41] sifive_e: Rename memmap enum constants
To: Eduardo Habkost <ehabkost@redhat.com>
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Aug 13, 2020 at 3:28 PM Eduardo Habkost <ehabkost@redhat.com> wrote:
>
> Some of the enum constant names conflict with the QOM type check
> macros.  This needs to be addressed to allow us to transform the
> QOM type check macros into functions generated by
> OBJECT_DECLARE_TYPE().
>
> Rename all the constants to SIFIVE_E_DEV_*, to avoid conflicts.
>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  include/hw/riscv/sifive_e.h | 38 ++++++++---------
>  hw/riscv/sifive_e.c         | 82 ++++++++++++++++++-------------------
>  2 files changed, 60 insertions(+), 60 deletions(-)
>
> diff --git a/include/hw/riscv/sifive_e.h b/include/hw/riscv/sifive_e.h
> index 637414130b..7c2eb70189 100644
> --- a/include/hw/riscv/sifive_e.h
> +++ b/include/hw/riscv/sifive_e.h
> @@ -53,25 +53,25 @@ typedef struct SiFiveEState {
>      OBJECT_CHECK(SiFiveEState, (obj), TYPE_RISCV_E_MACHINE)
>
>  enum {
> -    SIFIVE_E_DEBUG,
> -    SIFIVE_E_MROM,
> -    SIFIVE_E_OTP,
> -    SIFIVE_E_CLINT,
> -    SIFIVE_E_PLIC,
> -    SIFIVE_E_AON,
> -    SIFIVE_E_PRCI,
> -    SIFIVE_E_OTP_CTRL,
> -    SIFIVE_E_GPIO0,
> -    SIFIVE_E_UART0,
> -    SIFIVE_E_QSPI0,
> -    SIFIVE_E_PWM0,
> -    SIFIVE_E_UART1,
> -    SIFIVE_E_QSPI1,
> -    SIFIVE_E_PWM1,
> -    SIFIVE_E_QSPI2,
> -    SIFIVE_E_PWM2,
> -    SIFIVE_E_XIP,
> -    SIFIVE_E_DTIM
> +    SIFIVE_E_DEV_DEBUG,
> +    SIFIVE_E_DEV_MROM,
> +    SIFIVE_E_DEV_OTP,
> +    SIFIVE_E_DEV_CLINT,
> +    SIFIVE_E_DEV_PLIC,
> +    SIFIVE_E_DEV_AON,
> +    SIFIVE_E_DEV_PRCI,
> +    SIFIVE_E_DEV_OTP_CTRL,
> +    SIFIVE_E_DEV_GPIO0,
> +    SIFIVE_E_DEV_UART0,
> +    SIFIVE_E_DEV_QSPI0,
> +    SIFIVE_E_DEV_PWM0,
> +    SIFIVE_E_DEV_UART1,
> +    SIFIVE_E_DEV_QSPI1,
> +    SIFIVE_E_DEV_PWM1,
> +    SIFIVE_E_DEV_QSPI2,
> +    SIFIVE_E_DEV_PWM2,
> +    SIFIVE_E_DEV_XIP,
> +    SIFIVE_E_DEV_DTIM
>  };
>
>  enum {
> diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
> index c8b060486a..88b4524117 100644
> --- a/hw/riscv/sifive_e.c
> +++ b/hw/riscv/sifive_e.c
> @@ -54,25 +54,25 @@ static const struct MemmapEntry {
>      hwaddr base;
>      hwaddr size;
>  } sifive_e_memmap[] = {
> -    [SIFIVE_E_DEBUG] =    {        0x0,     0x1000 },
> -    [SIFIVE_E_MROM] =     {     0x1000,     0x2000 },
> -    [SIFIVE_E_OTP] =      {    0x20000,     0x2000 },
> -    [SIFIVE_E_CLINT] =    {  0x2000000,    0x10000 },
> -    [SIFIVE_E_PLIC] =     {  0xc000000,  0x4000000 },
> -    [SIFIVE_E_AON] =      { 0x10000000,     0x8000 },
> -    [SIFIVE_E_PRCI] =     { 0x10008000,     0x8000 },
> -    [SIFIVE_E_OTP_CTRL] = { 0x10010000,     0x1000 },
> -    [SIFIVE_E_GPIO0] =    { 0x10012000,     0x1000 },
> -    [SIFIVE_E_UART0] =    { 0x10013000,     0x1000 },
> -    [SIFIVE_E_QSPI0] =    { 0x10014000,     0x1000 },
> -    [SIFIVE_E_PWM0] =     { 0x10015000,     0x1000 },
> -    [SIFIVE_E_UART1] =    { 0x10023000,     0x1000 },
> -    [SIFIVE_E_QSPI1] =    { 0x10024000,     0x1000 },
> -    [SIFIVE_E_PWM1] =     { 0x10025000,     0x1000 },
> -    [SIFIVE_E_QSPI2] =    { 0x10034000,     0x1000 },
> -    [SIFIVE_E_PWM2] =     { 0x10035000,     0x1000 },
> -    [SIFIVE_E_XIP] =      { 0x20000000, 0x20000000 },
> -    [SIFIVE_E_DTIM] =     { 0x80000000,     0x4000 }
> +    [SIFIVE_E_DEV_DEBUG] =    {        0x0,     0x1000 },
> +    [SIFIVE_E_DEV_MROM] =     {     0x1000,     0x2000 },
> +    [SIFIVE_E_DEV_OTP] =      {    0x20000,     0x2000 },
> +    [SIFIVE_E_DEV_CLINT] =    {  0x2000000,    0x10000 },
> +    [SIFIVE_E_DEV_PLIC] =     {  0xc000000,  0x4000000 },
> +    [SIFIVE_E_DEV_AON] =      { 0x10000000,     0x8000 },
> +    [SIFIVE_E_DEV_PRCI] =     { 0x10008000,     0x8000 },
> +    [SIFIVE_E_DEV_OTP_CTRL] = { 0x10010000,     0x1000 },
> +    [SIFIVE_E_DEV_GPIO0] =    { 0x10012000,     0x1000 },
> +    [SIFIVE_E_DEV_UART0] =    { 0x10013000,     0x1000 },
> +    [SIFIVE_E_DEV_QSPI0] =    { 0x10014000,     0x1000 },
> +    [SIFIVE_E_DEV_PWM0] =     { 0x10015000,     0x1000 },
> +    [SIFIVE_E_DEV_UART1] =    { 0x10023000,     0x1000 },
> +    [SIFIVE_E_DEV_QSPI1] =    { 0x10024000,     0x1000 },
> +    [SIFIVE_E_DEV_PWM1] =     { 0x10025000,     0x1000 },
> +    [SIFIVE_E_DEV_QSPI2] =    { 0x10034000,     0x1000 },
> +    [SIFIVE_E_DEV_PWM2] =     { 0x10035000,     0x1000 },
> +    [SIFIVE_E_DEV_XIP] =      { 0x20000000, 0x20000000 },
> +    [SIFIVE_E_DEV_DTIM] =     { 0x80000000,     0x4000 }
>  };
>
>  static void sifive_e_machine_init(MachineState *machine)
> @@ -90,9 +90,9 @@ static void sifive_e_machine_init(MachineState *machine)
>
>      /* Data Tightly Integrated Memory */
>      memory_region_init_ram(main_mem, NULL, "riscv.sifive.e.ram",
> -        memmap[SIFIVE_E_DTIM].size, &error_fatal);
> +        memmap[SIFIVE_E_DEV_DTIM].size, &error_fatal);
>      memory_region_add_subregion(sys_mem,
> -        memmap[SIFIVE_E_DTIM].base, main_mem);
> +        memmap[SIFIVE_E_DEV_DTIM].base, main_mem);
>
>      /* Mask ROM reset vector */
>      uint32_t reset_vec[4];
> @@ -111,7 +111,7 @@ static void sifive_e_machine_init(MachineState *machine)
>          reset_vec[i] = cpu_to_le32(reset_vec[i]);
>      }
>      rom_add_blob_fixed_as("mrom.reset", reset_vec, sizeof(reset_vec),
> -                          memmap[SIFIVE_E_MROM].base, &address_space_memory);
> +                          memmap[SIFIVE_E_DEV_MROM].base, &address_space_memory);
>
>      if (machine->kernel_filename) {
>          riscv_load_kernel(machine->kernel_filename, NULL);
> @@ -194,12 +194,12 @@ static void sifive_e_soc_realize(DeviceState *dev, Error **errp)
>
>      /* Mask ROM */
>      memory_region_init_rom(&s->mask_rom, OBJECT(dev), "riscv.sifive.e.mrom",
> -                           memmap[SIFIVE_E_MROM].size, &error_fatal);
> +                           memmap[SIFIVE_E_DEV_MROM].size, &error_fatal);
>      memory_region_add_subregion(sys_mem,
> -        memmap[SIFIVE_E_MROM].base, &s->mask_rom);
> +        memmap[SIFIVE_E_DEV_MROM].base, &s->mask_rom);
>
>      /* MMIO */
> -    s->plic = sifive_plic_create(memmap[SIFIVE_E_PLIC].base,
> +    s->plic = sifive_plic_create(memmap[SIFIVE_E_DEV_PLIC].base,
>          (char *)SIFIVE_E_PLIC_HART_CONFIG,
>          SIFIVE_E_PLIC_NUM_SOURCES,
>          SIFIVE_E_PLIC_NUM_PRIORITIES,
> @@ -209,13 +209,13 @@ static void sifive_e_soc_realize(DeviceState *dev, Error **errp)
>          SIFIVE_E_PLIC_ENABLE_STRIDE,
>          SIFIVE_E_PLIC_CONTEXT_BASE,
>          SIFIVE_E_PLIC_CONTEXT_STRIDE,
> -        memmap[SIFIVE_E_PLIC].size);
> -    sifive_clint_create(memmap[SIFIVE_E_CLINT].base,
> -        memmap[SIFIVE_E_CLINT].size, ms->smp.cpus,
> +        memmap[SIFIVE_E_DEV_PLIC].size);
> +    sifive_clint_create(memmap[SIFIVE_E_DEV_CLINT].base,
> +        memmap[SIFIVE_E_DEV_CLINT].size, ms->smp.cpus,
>          SIFIVE_SIP_BASE, SIFIVE_TIMECMP_BASE, SIFIVE_TIME_BASE, false);
>      create_unimplemented_device("riscv.sifive.e.aon",
> -        memmap[SIFIVE_E_AON].base, memmap[SIFIVE_E_AON].size);
> -    sifive_e_prci_create(memmap[SIFIVE_E_PRCI].base);
> +        memmap[SIFIVE_E_DEV_AON].base, memmap[SIFIVE_E_DEV_AON].size);
> +    sifive_e_prci_create(memmap[SIFIVE_E_DEV_PRCI].base);
>
>      /* GPIO */
>
> @@ -224,7 +224,7 @@ static void sifive_e_soc_realize(DeviceState *dev, Error **errp)
>      }
>
>      /* Map GPIO registers */
> -    sysbus_mmio_map(SYS_BUS_DEVICE(&s->gpio), 0, memmap[SIFIVE_E_GPIO0].base);
> +    sysbus_mmio_map(SYS_BUS_DEVICE(&s->gpio), 0, memmap[SIFIVE_E_DEV_GPIO0].base);
>
>      /* Pass all GPIOs to the SOC layer so they are available to the board */
>      qdev_pass_gpios(DEVICE(&s->gpio), dev, NULL);
> @@ -236,27 +236,27 @@ static void sifive_e_soc_realize(DeviceState *dev, Error **errp)
>                                              SIFIVE_E_GPIO0_IRQ0 + i));
>      }
>
> -    sifive_uart_create(sys_mem, memmap[SIFIVE_E_UART0].base,
> +    sifive_uart_create(sys_mem, memmap[SIFIVE_E_DEV_UART0].base,
>          serial_hd(0), qdev_get_gpio_in(DEVICE(s->plic), SIFIVE_E_UART0_IRQ));
>      create_unimplemented_device("riscv.sifive.e.qspi0",
> -        memmap[SIFIVE_E_QSPI0].base, memmap[SIFIVE_E_QSPI0].size);
> +        memmap[SIFIVE_E_DEV_QSPI0].base, memmap[SIFIVE_E_DEV_QSPI0].size);
>      create_unimplemented_device("riscv.sifive.e.pwm0",
> -        memmap[SIFIVE_E_PWM0].base, memmap[SIFIVE_E_PWM0].size);
> -    sifive_uart_create(sys_mem, memmap[SIFIVE_E_UART1].base,
> +        memmap[SIFIVE_E_DEV_PWM0].base, memmap[SIFIVE_E_DEV_PWM0].size);
> +    sifive_uart_create(sys_mem, memmap[SIFIVE_E_DEV_UART1].base,
>          serial_hd(1), qdev_get_gpio_in(DEVICE(s->plic), SIFIVE_E_UART1_IRQ));
>      create_unimplemented_device("riscv.sifive.e.qspi1",
> -        memmap[SIFIVE_E_QSPI1].base, memmap[SIFIVE_E_QSPI1].size);
> +        memmap[SIFIVE_E_DEV_QSPI1].base, memmap[SIFIVE_E_DEV_QSPI1].size);
>      create_unimplemented_device("riscv.sifive.e.pwm1",
> -        memmap[SIFIVE_E_PWM1].base, memmap[SIFIVE_E_PWM1].size);
> +        memmap[SIFIVE_E_DEV_PWM1].base, memmap[SIFIVE_E_DEV_PWM1].size);
>      create_unimplemented_device("riscv.sifive.e.qspi2",
> -        memmap[SIFIVE_E_QSPI2].base, memmap[SIFIVE_E_QSPI2].size);
> +        memmap[SIFIVE_E_DEV_QSPI2].base, memmap[SIFIVE_E_DEV_QSPI2].size);
>      create_unimplemented_device("riscv.sifive.e.pwm2",
> -        memmap[SIFIVE_E_PWM2].base, memmap[SIFIVE_E_PWM2].size);
> +        memmap[SIFIVE_E_DEV_PWM2].base, memmap[SIFIVE_E_DEV_PWM2].size);
>
>      /* Flash memory */
>      memory_region_init_rom(&s->xip_mem, OBJECT(dev), "riscv.sifive.e.xip",
> -                           memmap[SIFIVE_E_XIP].size, &error_fatal);
> -    memory_region_add_subregion(sys_mem, memmap[SIFIVE_E_XIP].base,
> +                           memmap[SIFIVE_E_DEV_XIP].size, &error_fatal);
> +    memory_region_add_subregion(sys_mem, memmap[SIFIVE_E_DEV_XIP].base,
>          &s->xip_mem);
>  }
>
> --
> 2.26.2
>
>

