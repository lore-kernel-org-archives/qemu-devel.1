Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D3C4C04A6B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 11:31:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A1D021019
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 11:31:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NRSLhEt2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A1D021019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35228 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOKnX-0000UZ-JS
	for qemu-devel@archiver.kernel.org; Wed, 08 May 2019 07:31:43 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40401)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hongbo.zhang@linaro.org>) id 1hOKmS-0007gz-A3
	for qemu-devel@nongnu.org; Wed, 08 May 2019 07:30:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hongbo.zhang@linaro.org>) id 1hOKmR-0004Od-15
	for qemu-devel@nongnu.org; Wed, 08 May 2019 07:30:36 -0400
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:38442)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <hongbo.zhang@linaro.org>)
	id 1hOKmQ-0004Kk-P7
	for qemu-devel@nongnu.org; Wed, 08 May 2019 07:30:34 -0400
Received: by mail-lj1-x241.google.com with SMTP id u21so8023835lja.5
	for <qemu-devel@nongnu.org>; Wed, 08 May 2019 04:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=euDbYukUunzWf2Zre5ZSrbtkk4J2+ci9a3w4dyAZO/M=;
	b=NRSLhEt2wl4A+ew+zj3Ev1XksjInP1szlciL8baa0fGf/S1e6yIQMpNp6nudnR/xvf
	KB/l8jNQEPZahWzBr07Tw/uXbrBjMhRpz59Yh+3nTQjZUN2akHu0T0ivMRjGvv3vwUhv
	inX/hoZaot/a6GUNnaxlAGrM793kBpWp6iAUlq8gNaWGnzce1qgPFCyBvykGjOsQ9S+6
	w8LgUlcEGXaemrr8UuTKT1q4mHTeR0j4Cf+5a742el5q4h5QRJZhy1woQwV/jxxKfnra
	E/gAayrgDYIjzc+LeGfxF4U5692TxODWdAuoqxFU3b+AuZO0swzsf5S+47YY1ttC1531
	yl8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=euDbYukUunzWf2Zre5ZSrbtkk4J2+ci9a3w4dyAZO/M=;
	b=Sa0btZT5oWjUMHS75iK6Qk7E1libL//zqxQ+I3Y4PcxHm1DOs+efk2tneAf8jtVt9i
	N472ZdlIdYglr7oV4yG1Vds/6NI189yFzpwEvNsjhIYBAA1JRRvm2yaW4Vkci71tAfPN
	4BdpMPemCHs3PiGJw5jXKEZxojlKiD4WnuWL6IZwDWohXsg7OKEJyj48yUICw7unUnbr
	D5mY2vSHeo3y3HOEFvpFxPUe5ovAYNkRF+suXPt/hxSukIsmWX/4vFKgUd3exFrQZn2u
	bqpMzGx5lGIXHOnO+EBaZbqefErp8Zzo5M4tbEazDOoiKgx7lrqtup31kgsl3QbHU4Dq
	Mbqg==
X-Gm-Message-State: APjAAAWi2z3w1QBLDEAhoPbmgr9J55jSGcLijQWARErLU+tazh0zocI4
	LsMVIIMmtPqhe4/EOEbA8hA4trxhJ4/tMntNm0dQAQ==
X-Google-Smtp-Source: APXvYqwPubgcfbLDod8OswjE7/W7r6HB/KvX5Yrl1gxSNwxLXDjD+VsABjk6RS9bZWmxLuFGmw/i2BGuMbU6MsWESPk=
X-Received: by 2002:a2e:894e:: with SMTP id b14mr15563289ljk.158.1557315033407;
	Wed, 08 May 2019 04:30:33 -0700 (PDT)
MIME-Version: 1.0
References: <1555560291-3415-1-git-send-email-hongbo.zhang@linaro.org>
	<1555560291-3415-3-git-send-email-hongbo.zhang@linaro.org>
	<CAFEAcA-poCxPqPtfhx4mUJ5pcOjn1Hz-WNxEt29f=JgpFMi4Kg@mail.gmail.com>
In-Reply-To: <CAFEAcA-poCxPqPtfhx4mUJ5pcOjn1Hz-WNxEt29f=JgpFMi4Kg@mail.gmail.com>
From: Hongbo Zhang <hongbo.zhang@linaro.org>
Date: Wed, 8 May 2019 19:30:26 +0800
Message-ID: <CAHmQWvB4AZGM+MV0LP-vtfoW0kG4RFkf0R6NoRWm8WrFuum+Og@mail.gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::241
Subject: Re: [Qemu-devel] [PATCH v7 2/2] hw/arm: Add arm SBSA reference
 machine, devices part
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Radoslaw Biernacki <radoslaw.biernacki@linaro.org>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>,
	Markus Armbruster <armbru@redhat.com>,
	Leif Lindholm <leif.lindholm@linaro.org>,
	QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 30 Apr 2019 at 22:17, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Thu, 18 Apr 2019 at 05:05, Hongbo Zhang <hongbo.zhang@linaro.org> wrote:
> >
> > Following the previous patch, this patch adds peripheral devices to the
> > newly introduced SBSA-ref machine.
> >
> > Signed-off-by: Hongbo Zhang <hongbo.zhang@linaro.org>
> > ---
> >  hw/arm/sbsa-ref.c | 451 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 451 insertions(+)
>
> Some fairly minor comments on this one.
>
> > +static void create_flash(const SBSAMachineState *vms,
> > +                         MemoryRegion *sysmem,
> > +                         MemoryRegion *secure_sysmem)
> > +{
> > +    /*
> > +     * Create one secure and nonsecure flash devices to fill SBSA_FLASH
> > +     * space in the memmap, file passed via -bios goes in the first one.
> > +     */
> > +    hwaddr flashsize = vms->memmap[SBSA_FLASH].size / 2;
> > +    hwaddr flashbase = vms->memmap[SBSA_FLASH].base;
> > +
> > +    create_one_flash("sbsa-ref.flash0", flashbase, flashsize,
> > +                     bios_name, secure_sysmem);
> > +    create_one_flash("sbsa-ref.flash1", flashbase + flashsize, flashsize,
> > +                     NULL, sysmem);
> > +}
>
> I think Markus might have an opinion on the best way to create
> flash devices on a new board model. Is "just create two flash
> devices the way the virt board does" the right thing?
>
For the firmware part, we are using two flashes, one secure and
another non-secure.

> > +static void create_ahci(const SBSAMachineState *vms, qemu_irq *pic)
> > +{
> > +    hwaddr base = vms->memmap[SBSA_AHCI].base;
> > +    int irq = vms->irqmap[SBSA_AHCI];
> > +    DeviceState *dev;
> > +    DriveInfo *hd[NUM_SATA_PORTS];
> > +    SysbusAHCIState *sysahci;
> > +    AHCIState *ahci;
> > +    int i;
> > +
> > +    dev = qdev_create(NULL, "sysbus-ahci");
> > +    qdev_prop_set_uint32(dev, "num-ports", NUM_SATA_PORTS);
> > +    qdev_init_nofail(dev);
> > +    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
> > +    sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, pic[irq]);
> > +
> > +    sysahci = SYSBUS_AHCI(dev);
> > +    ahci = &sysahci->ahci;
> > +    ide_drive_get(hd, ARRAY_SIZE(hd));
> > +    for (i = 0; i < ahci->ports; i++) {
> > +        if (hd[i] == NULL) {
> > +            continue;
> > +        }
> > +        ide_create_drive(&ahci->dev[i].port, 0, hd[i]);
> > +    }
> > +}
> > +
> > +static void create_ehci(const SBSAMachineState *vms, qemu_irq *pic)
> > +{
> > +    hwaddr base = vms->memmap[SBSA_EHCI].base;
> > +    int irq = vms->irqmap[SBSA_EHCI];
> > +    USBBus *usb_bus;
> > +
> > +    sysbus_create_simple("platform-ehci-usb", base, pic[irq]);
> > +
> > +    usb_bus = usb_bus_find(-1);
> > +    usb_create_simple(usb_bus, "usb-kbd");
> > +    usb_create_simple(usb_bus, "usb-mouse");
>
> I don't think we should automatically create the usb keyboard
> and mouse devices. The user can do it on the command line if they
> want them.
>
OK.

> >  static void sbsa_ref_init(MachineState *machine)
> >  {
> >      SBSAMachineState *vms = SBSA_MACHINE(machine);
> > @@ -125,6 +552,7 @@ static void sbsa_ref_init(MachineState *machine)
> >      bool firmware_loaded = bios_name || drive_get(IF_PFLASH, 0, 0);
> >      const CPUArchIdList *possible_cpus;
> >      int n, sbsa_max_cpus;
> > +    qemu_irq pic[NUM_IRQS];
> >
> >      if (strcmp(machine->cpu_type, ARM_CPU_TYPE_NAME("cortex-a57"))) {
> >          error_report("sbsa-ref: CPU type other than the built-in "
> > @@ -209,11 +637,34 @@ static void sbsa_ref_init(MachineState *machine)
> >                                           machine->ram_size);
> >      memory_region_add_subregion(sysmem, vms->memmap[SBSA_MEM].base, ram);
> >
> > +    create_fdt(vms);
> > +
> > +    create_flash(vms, sysmem, secure_sysmem ? secure_sysmem : sysmem);
> > +
> > +    create_secure_ram(vms, secure_sysmem);
> > +
> > +    create_gic(vms, pic);
> > +
> > +    create_uart(vms, pic, SBSA_UART, sysmem, serial_hd(0));
> > +    create_uart(vms, pic, SBSA_SECURE_UART, secure_sysmem, serial_hd(1));
> > +    create_uart(vms, pic, SBSA_SECURE_UART_MM, secure_sysmem, serial_hd(2));
>
> What's the third UART for (ie what is the name intended to mean)?
> Should we have more than one non-secure UART?
>
Yes, this is called " Standalone Management Mode", I will add comment
for it, this is needed by server RAS feature.

> thanks
> -- PMM

