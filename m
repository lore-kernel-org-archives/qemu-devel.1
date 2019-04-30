Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67FB3C43219
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 14:18:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24B5920652
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 14:18:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x3K5sN6p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24B5920652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47794 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLTaN-0001lE-6v
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 10:18:19 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56213)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hLTZJ-0001Oh-Nc
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 10:17:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hLTZI-0007LM-JA
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 10:17:13 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:33601)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hLTZI-0007KB-DT
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 10:17:12 -0400
Received: by mail-ot1-x343.google.com with SMTP id s11so7720595otp.0
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 07:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=oMh7iWcXAytvlvEHTXWoOdsLJGJYV9qHq2JPyOdE2Kk=;
	b=x3K5sN6ppSjSKwO5cnkJBD+ptH/250muve3hAD6QAl9J4POyEk+bDjdvKK3v5zIwNt
	wECLI1JTtUXLdV4CnOLcLB/RnBpNKMuygTyAdrUJWMXsZamfdD/wGVFmmRhvuBZka1NT
	5JlupDKS8Y/UHKya4LZVO5UsMfCgCCpUPOP5RXpG8RBrPwX0v+R1dGyjQGbn9ziYB94F
	SAhDzjisGImAUY/24YwhOqIecqfhFn3TfWs4SR/2Bfbnve/OIEwjUQqHdQQPtJTbUCqi
	j/0Vb/F/VDtDCLO31TEGo0FtGPMGh+wqtWs5UpygeVIEkddQm6iAHBjqCJrQgAK9kOjC
	v71g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=oMh7iWcXAytvlvEHTXWoOdsLJGJYV9qHq2JPyOdE2Kk=;
	b=H6YNbpgTkpd+1VdjbgXZuFoW/lagVwNyStpYMe3Aj/+UDuEE8TU6h36uXVPyH3PWnZ
	h9sy60Uax6IyslX+8wdRYbQ4NJ04ziXDJkmyvnv5FoVBKCv8K1YuXsjvw/kJt0HoPB00
	/NGDCiTqDoLBvD6iqG6o+VPXl6NnKQFO8gF1nvQuqSxHRdhV/ERjtaNvhsmiksLQOpvO
	8QzxH38vh1s2a0IdnfRaK0GUGk3k/c9lFWxqGObVmSRwlUzEC12uyixqdsAkAD9AS/7n
	oz9Aq2M8svMfq/WRteZBHk2RSCL4qMOvtJX4ozk+Bw26Ve1675+HPeNGmy2VqgnR/rqu
	ekEA==
X-Gm-Message-State: APjAAAV2ADbrc19PhGhIIfmDqtvjlNJ+cRYXk3bXaU4NQ0BlNghSCUV4
	rjvvOWZeGsFJdFblzjl7vnxnwLAhGTkCHFh73AD9Fw==
X-Google-Smtp-Source: APXvYqwhfCBVQVbQQs/3Op2UprrFtWs/PnyDFUENwXlk02gj/MovMXdhAI+Ppqapy/fAAnIha1UEmDCSGPaDglpxzGg=
X-Received: by 2002:a9d:57c4:: with SMTP id q4mr7851219oti.151.1556633830118; 
	Tue, 30 Apr 2019 07:17:10 -0700 (PDT)
MIME-Version: 1.0
References: <1555560291-3415-1-git-send-email-hongbo.zhang@linaro.org>
	<1555560291-3415-3-git-send-email-hongbo.zhang@linaro.org>
In-Reply-To: <1555560291-3415-3-git-send-email-hongbo.zhang@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 Apr 2019 15:16:59 +0100
Message-ID:
 <CAFEAcA-poCxPqPtfhx4mUJ5pcOjn1Hz-WNxEt29f=JgpFMi4Kg@mail.gmail.com>
To: Hongbo Zhang <hongbo.zhang@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::343
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
Message-ID: <20190430141659.DLcRDOlhGFm5T6HEQFiDea-Rv9ItglglPx2JEaXyt-8@z>

On Thu, 18 Apr 2019 at 05:05, Hongbo Zhang <hongbo.zhang@linaro.org> wrote:
>
> Following the previous patch, this patch adds peripheral devices to the
> newly introduced SBSA-ref machine.
>
> Signed-off-by: Hongbo Zhang <hongbo.zhang@linaro.org>
> ---
>  hw/arm/sbsa-ref.c | 451 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 451 insertions(+)

Some fairly minor comments on this one.

> +static void create_flash(const SBSAMachineState *vms,
> +                         MemoryRegion *sysmem,
> +                         MemoryRegion *secure_sysmem)
> +{
> +    /*
> +     * Create one secure and nonsecure flash devices to fill SBSA_FLASH
> +     * space in the memmap, file passed via -bios goes in the first one.
> +     */
> +    hwaddr flashsize = vms->memmap[SBSA_FLASH].size / 2;
> +    hwaddr flashbase = vms->memmap[SBSA_FLASH].base;
> +
> +    create_one_flash("sbsa-ref.flash0", flashbase, flashsize,
> +                     bios_name, secure_sysmem);
> +    create_one_flash("sbsa-ref.flash1", flashbase + flashsize, flashsize,
> +                     NULL, sysmem);
> +}

I think Markus might have an opinion on the best way to create
flash devices on a new board model. Is "just create two flash
devices the way the virt board does" the right thing?

> +static void create_ahci(const SBSAMachineState *vms, qemu_irq *pic)
> +{
> +    hwaddr base = vms->memmap[SBSA_AHCI].base;
> +    int irq = vms->irqmap[SBSA_AHCI];
> +    DeviceState *dev;
> +    DriveInfo *hd[NUM_SATA_PORTS];
> +    SysbusAHCIState *sysahci;
> +    AHCIState *ahci;
> +    int i;
> +
> +    dev = qdev_create(NULL, "sysbus-ahci");
> +    qdev_prop_set_uint32(dev, "num-ports", NUM_SATA_PORTS);
> +    qdev_init_nofail(dev);
> +    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
> +    sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, pic[irq]);
> +
> +    sysahci = SYSBUS_AHCI(dev);
> +    ahci = &sysahci->ahci;
> +    ide_drive_get(hd, ARRAY_SIZE(hd));
> +    for (i = 0; i < ahci->ports; i++) {
> +        if (hd[i] == NULL) {
> +            continue;
> +        }
> +        ide_create_drive(&ahci->dev[i].port, 0, hd[i]);
> +    }
> +}
> +
> +static void create_ehci(const SBSAMachineState *vms, qemu_irq *pic)
> +{
> +    hwaddr base = vms->memmap[SBSA_EHCI].base;
> +    int irq = vms->irqmap[SBSA_EHCI];
> +    USBBus *usb_bus;
> +
> +    sysbus_create_simple("platform-ehci-usb", base, pic[irq]);
> +
> +    usb_bus = usb_bus_find(-1);
> +    usb_create_simple(usb_bus, "usb-kbd");
> +    usb_create_simple(usb_bus, "usb-mouse");

I don't think we should automatically create the usb keyboard
and mouse devices. The user can do it on the command line if they
want them.

>  static void sbsa_ref_init(MachineState *machine)
>  {
>      SBSAMachineState *vms = SBSA_MACHINE(machine);
> @@ -125,6 +552,7 @@ static void sbsa_ref_init(MachineState *machine)
>      bool firmware_loaded = bios_name || drive_get(IF_PFLASH, 0, 0);
>      const CPUArchIdList *possible_cpus;
>      int n, sbsa_max_cpus;
> +    qemu_irq pic[NUM_IRQS];
>
>      if (strcmp(machine->cpu_type, ARM_CPU_TYPE_NAME("cortex-a57"))) {
>          error_report("sbsa-ref: CPU type other than the built-in "
> @@ -209,11 +637,34 @@ static void sbsa_ref_init(MachineState *machine)
>                                           machine->ram_size);
>      memory_region_add_subregion(sysmem, vms->memmap[SBSA_MEM].base, ram);
>
> +    create_fdt(vms);
> +
> +    create_flash(vms, sysmem, secure_sysmem ? secure_sysmem : sysmem);
> +
> +    create_secure_ram(vms, secure_sysmem);
> +
> +    create_gic(vms, pic);
> +
> +    create_uart(vms, pic, SBSA_UART, sysmem, serial_hd(0));
> +    create_uart(vms, pic, SBSA_SECURE_UART, secure_sysmem, serial_hd(1));
> +    create_uart(vms, pic, SBSA_SECURE_UART_MM, secure_sysmem, serial_hd(2));

What's the third UART for (ie what is the name intended to mean)?
Should we have more than one non-secure UART?

thanks
-- PMM

