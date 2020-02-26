Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63DE2C4BA2D
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 23:06:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FBFD222C2
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 23:06:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sP8VlGvG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FBFD222C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51400 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j75lL-00080d-Bf
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 18:06:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43758)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1j75kX-0007F0-8H
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 18:05:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1j75kV-0005RH-IW
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 18:05:52 -0500
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:33136)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1j75kV-0005PN-8j; Wed, 26 Feb 2020 18:05:51 -0500
Received: by mail-lj1-x241.google.com with SMTP id y6so1090406lji.0;
 Wed, 26 Feb 2020 15:05:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=X1fyWx7cUYHPiMoRyKUX3oonI6sX83xhsfDJLl+1Lg8=;
 b=sP8VlGvGDVv+e8mMJxA9+wF67Jp/csbzjyumwOPIjYvnEamEAEWkbGqLwlMOGQpNI4
 syguRa9/t1xoxwx/wnXd6xAJGY8FT9ztkVzOHGPexUjI/J3h/WDSD5tPWY/GaYGZJu+r
 xT/P32NbSWHCQ1sNkhFK/etu2kD9C+hlHvY04pNdM+ryqempIvUIkfm1/yHbP0zk+iED
 Pt4tHg8w8iDkIzqDCco04MdNSRe9kGJRT+PcnvfUg0lCQHhmiHyt/BgLrk0lZ4NVoqDf
 sxdLfCH0PzlKxb85AdYoEHtFvx+pB9uFa37nST5iuonpYygkeQSJ0Ul4C93fYin212cu
 cOyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=X1fyWx7cUYHPiMoRyKUX3oonI6sX83xhsfDJLl+1Lg8=;
 b=n+Gw9NxDBlK72CftOGhpQvP9OhPXFPDXEfzuJ+bWI4ZAbxYTgwykRN+vSB2xTRbb01
 YvWI8QDUIwrhhCnHRXwD1daC7EAvb1e4o0cHn7pU6y4I8baTJ8swAL7xcfdCJ0mkfIkR
 taTdrrmIvEFiVPxjPr//tQ+Ihb+z0ycp4E50zNMuQVtj6bN7OfjG4L7p2waWGraHr0Pj
 xjGXYd7y7ds1bkfrRa2iVr9IRiomFyxsgCianMBPeR85MkAnNxEWEMfKXu04U+It3eCl
 BuWtqJ+2gdicIhT5F/Ki0h9N9IDPZhksOUHtVnpcCPZarvy4hNUU/KCH8ysRFTok0NX0
 FcNw==
X-Gm-Message-State: ANhLgQ0ioXb+V5s/EhKH+dOk0CAehoSyGNu4otkhYM5ZuPSUbiOw5Qlp
 uQNjNlW/ELY9hsJYgXjPSPZhllZc7KpICfs7khs=
X-Google-Smtp-Source: ADFU+vuDoFsYDE/5qs3walxyjNlVRFiOgCHgYmUXQPco40NOUFiei7NIN6NkbADfdjPi8klUtFXJFjeQS8dy7EbAHhU=
X-Received: by 2002:a2e:a36a:: with SMTP id i10mr781220ljn.107.1582758350047; 
 Wed, 26 Feb 2020 15:05:50 -0800 (PST)
MIME-Version: 1.0
References: <20200225131422.53368-1-damien.hedde@greensocs.com>
 <20200225131422.53368-9-damien.hedde@greensocs.com>
In-Reply-To: <20200225131422.53368-9-damien.hedde@greensocs.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 26 Feb 2020 14:58:13 -0800
Message-ID: <CAKmqyKPmkjjAe-4M_-NXP=dEjLb7WUkhV-bGSmYnCnPUZT0n6w@mail.gmail.com>
Subject: Re: [PATCH v8 8/9] hw/arm/xilinx_zynq: connect uart clocks to slcr
To: Damien Hedde <damien.hedde@greensocs.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::241
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
 "Daniel P. Berrange" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Mark Burton <mark.burton@greensocs.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Edgar Iglesias <edgar.iglesias@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Feb 25, 2020 at 5:40 AM Damien Hedde <damien.hedde@greensocs.com> wrote:
>
> Add the connection between the slcr's output clocks and the uarts inputs.
>
> Also add the main board clock 'ps_clk', which is hard-coded to 33.33MHz
> (the default frequency). This clock is used to feed the slcr's input
> clock.
>
> Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

>
> ---
> v7
>  + update ClockIn/ClockOut types
>  + simplify the ps_clk frequency init
> ---
>  hw/arm/xilinx_zynq.c | 57 +++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 49 insertions(+), 8 deletions(-)
>
> diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
> index 3a0fa5b23f..261a1690a8 100644
> --- a/hw/arm/xilinx_zynq.c
> +++ b/hw/arm/xilinx_zynq.c
> @@ -34,6 +34,15 @@
>  #include "hw/char/cadence_uart.h"
>  #include "hw/net/cadence_gem.h"
>  #include "hw/cpu/a9mpcore.h"
> +#include "hw/qdev-clock.h"
> +#include "sysemu/reset.h"
> +
> +#define TYPE_ZYNQ_MACHINE MACHINE_TYPE_NAME("xilinx-zynq-a9")
> +#define ZYNQ_MACHINE(obj) \
> +    OBJECT_CHECK(ZynqMachineState, (obj), TYPE_ZYNQ_MACHINE)
> +
> +/* board base frequency: 33.333333 MHz */
> +#define PS_CLK_FREQUENCY (100 * 1000 * 1000 / 3)
>
>  #define NUM_SPI_FLASHES 4
>  #define NUM_QSPI_FLASHES 2
> @@ -74,6 +83,11 @@ static const int dma_irqs[8] = {
>      0xe3401000 + ARMV7_IMM16(extract32((val), 16, 16)), /* movt r1 ... */ \
>      0xe5801000 + (addr)
>
> +typedef struct ZynqMachineState {
> +    MachineState parent;
> +    Clock *ps_clk;
> +} ZynqMachineState;
> +
>  static void zynq_write_board_setup(ARMCPU *cpu,
>                                     const struct arm_boot_info *info)
>  {
> @@ -158,12 +172,13 @@ static inline void zynq_init_spi_flashes(uint32_t base_addr, qemu_irq irq,
>
>  static void zynq_init(MachineState *machine)
>  {
> +    ZynqMachineState *zynq_machine = ZYNQ_MACHINE(machine);
>      ram_addr_t ram_size = machine->ram_size;
>      ARMCPU *cpu;
>      MemoryRegion *address_space_mem = get_system_memory();
>      MemoryRegion *ext_ram = g_new(MemoryRegion, 1);
>      MemoryRegion *ocm_ram = g_new(MemoryRegion, 1);
> -    DeviceState *dev;
> +    DeviceState *dev, *slcr;
>      SysBusDevice *busdev;
>      qemu_irq pic[64];
>      int n;
> @@ -208,9 +223,18 @@ static void zynq_init(MachineState *machine)
>                            1, 0x0066, 0x0022, 0x0000, 0x0000, 0x0555, 0x2aa,
>                            0);
>
> -    dev = qdev_create(NULL, "xilinx,zynq_slcr");
> -    qdev_init_nofail(dev);
> -    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, 0xF8000000);
> +    /* Create slcr, keep a pointer to connect clocks */
> +    slcr = qdev_create(NULL, "xilinx,zynq_slcr");
> +    qdev_init_nofail(slcr);
> +    sysbus_mmio_map(SYS_BUS_DEVICE(slcr), 0, 0xF8000000);
> +
> +    /* Create the main clock source, and feed slcr with it */
> +    zynq_machine->ps_clk = CLOCK(object_new(TYPE_CLOCK));
> +    object_property_add_child(OBJECT(zynq_machine), "ps_clk",
> +                              OBJECT(zynq_machine->ps_clk), &error_abort);
> +    object_unref(OBJECT(zynq_machine->ps_clk));
> +    clock_set_hz(zynq_machine->ps_clk, PS_CLK_FREQUENCY);
> +    qdev_connect_clock_in(slcr, "ps_clk", zynq_machine->ps_clk);
>
>      dev = qdev_create(NULL, TYPE_A9MPCORE_PRIV);
>      qdev_prop_set_uint32(dev, "num-cpu", 1);
> @@ -231,8 +255,12 @@ static void zynq_init(MachineState *machine)
>      sysbus_create_simple("xlnx,ps7-usb", 0xE0002000, pic[53-IRQ_OFFSET]);
>      sysbus_create_simple("xlnx,ps7-usb", 0xE0003000, pic[76-IRQ_OFFSET]);
>
> -    cadence_uart_create(0xE0000000, pic[59 - IRQ_OFFSET], serial_hd(0));
> -    cadence_uart_create(0xE0001000, pic[82 - IRQ_OFFSET], serial_hd(1));
> +    dev = cadence_uart_create(0xE0000000, pic[59 - IRQ_OFFSET], serial_hd(0));
> +    qdev_connect_clock_in(dev, "refclk",
> +                          qdev_get_clock_out(slcr, "uart0_ref_clk"));
> +    dev = cadence_uart_create(0xE0001000, pic[82 - IRQ_OFFSET], serial_hd(1));
> +    qdev_connect_clock_in(dev, "refclk",
> +                          qdev_get_clock_out(slcr, "uart1_ref_clk"));
>
>      sysbus_create_varargs("cadence_ttc", 0xF8001000,
>              pic[42-IRQ_OFFSET], pic[43-IRQ_OFFSET], pic[44-IRQ_OFFSET], NULL);
> @@ -310,8 +338,9 @@ static void zynq_init(MachineState *machine)
>      arm_load_kernel(ARM_CPU(first_cpu), machine, &zynq_binfo);
>  }
>
> -static void zynq_machine_init(MachineClass *mc)
> +static void zynq_machine_class_init(ObjectClass *oc, void *data)
>  {
> +    MachineClass *mc = MACHINE_CLASS(oc);
>      mc->desc = "Xilinx Zynq Platform Baseboard for Cortex-A9";
>      mc->init = zynq_init;
>      mc->max_cpus = 1;
> @@ -320,4 +349,16 @@ static void zynq_machine_init(MachineClass *mc)
>      mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-a9");
>  }
>
> -DEFINE_MACHINE("xilinx-zynq-a9", zynq_machine_init)
> +static const TypeInfo zynq_machine_type = {
> +    .name = TYPE_ZYNQ_MACHINE,
> +    .parent = TYPE_MACHINE,
> +    .class_init = zynq_machine_class_init,
> +    .instance_size = sizeof(ZynqMachineState),
> +};
> +
> +static void zynq_machine_register_types(void)
> +{
> +    type_register_static(&zynq_machine_type);
> +}
> +
> +type_init(zynq_machine_register_types)
> --
> 2.25.1
>
>

