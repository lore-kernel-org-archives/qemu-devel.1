Return-Path: <SRS0=7PPA=SN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2E69C10F13
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 14:37:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D72B206BA
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 14:37:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D72B206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49971 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEapd-000563-QD
	for qemu-devel@archiver.kernel.org; Thu, 11 Apr 2019 10:37:37 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33914)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hEanO-0003np-3X
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 10:35:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hEanM-0004ta-7h
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 10:35:18 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45077)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hEanL-0004t5-R2
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 10:35:16 -0400
Received: by mail-wr1-f68.google.com with SMTP id s15so7643688wra.12
	for <qemu-devel@nongnu.org>; Thu, 11 Apr 2019 07:35:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=cvV3ikNI1mGO0gxgxlOPR4wPd5ri2sJcCEBFBkzNLfo=;
	b=DzMOrjSnp7e99IZzaRDZvXyheCwL2MGYNgUousRna5U/ecumA7Ib1SzLquOh62ahaA
	QZbSuHefgRi+TUc7rWkv4rOyXyW2qo+T/laqxM6zqHocCLqX5CISMBn8M+GjleVuJOgQ
	s1C5QkP6Emm6ooA55kIN5bTaURXJDLDKBaWh/xWdJl1GFj87SAyfpYYSJyV2ipd6MOYK
	CliPo3zcw6emUykjTu6E1fDyoEU8kAmutrm/t9d50WcDJeBlqxT2pVB8oTqFvoR82zPW
	A0g37epv1tiAkNYcIe/LY3Hi6bLLSAVB6eswnXPlr/a4TOdE/XzWVgecVbYJ6UJ70b5n
	sZOQ==
X-Gm-Message-State: APjAAAWyCMaRxfX8lpPHYqFMq7NliELOll60Ir18X+O4cjUSnwfgNjbO
	Z2LARkyCdv/wQUtQA7RecA4L4Q==
X-Google-Smtp-Source: APXvYqyZtavDsd2nkf/e5+buCKVAkmrQzPsba8SR9jucl0ZL22Uty/f+BMeeJBAL3njUu6lRG1kVpw==
X-Received: by 2002:a5d:6988:: with SMTP id g8mr31965525wru.117.1554993314591; 
	Thu, 11 Apr 2019 07:35:14 -0700 (PDT)
Received: from [192.168.1.33] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193]) by smtp.gmail.com with ESMTPSA id
	a187sm7145485wma.32.2019.04.11.07.35.13
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Thu, 11 Apr 2019 07:35:13 -0700 (PDT)
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20190411135602.21725-1-armbru@redhat.com>
	<20190411135602.21725-3-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <95f2e6d2-5bd0-a9dc-ab4b-dc172e7f1ad1@redhat.com>
Date: Thu, 11 Apr 2019 16:35:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190411135602.21725-3-armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.68
Subject: Re: [Qemu-devel] [PATCH 2/2] hw/arm/virt: Support firmware
 configuration with -blockdev
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-block@nongnu.org,
	mreitz@redhat.com, qemu-arm@nongnu.org, lersek@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190411143513.MbkMU1vAIyPL-NNAQkufb60C3a6PlkdyUpCAo5NmJhc@z>

On 4/11/19 3:56 PM, Markus Armbruster wrote:
> The ARM virt machines put firmware in flash memory.  To configure it,
> you use -drive if=pflash,unit=0,... and optionally -drive
> if=pflash,unit=1,...
> 
> Why two -drive?  This permits setting up one part of the flash memory
> read-only, and the other part read/write.  It also makes upgrading
> firmware on the host easier.  Below the hood, we get two separate
> flash devices, because we were too lazy to improve our flash device
> models to support sector protection.
> 
> The problem at hand is to do the same with -blockdev somehow, as one
> more step towards deprecating -drive.
> 
> We recently solved this problem for x86 PC machines, in commit
> ebc29e1beab.  See the commit message for design rationale.
> 
> This commit solves it for ARM virt basically the same way: new machine
> properties pflash0, pflash1 forward to the onboard flash devices'
> properties.  Requires creating the onboard devices in the
> .instance_init() method virt_instance_init().  The existing code to
> pick up drives defined with -drive if=pflash is replaced by code to
> desugar into the machine properties.
> 
> There are a few behavioral differences, though:
> 
> * The flash devices are always present (x86: only present if
>   configured)
> 
> * Flash base addresses and sizes are fixed (x86: sizes depend on
>   images, mapped back to back below a fixed address)
> 
> * -bios configures contents of first pflash (x86: -bios configures ROM
>    contents)
> 
> * -bios is rejected when first pflash is also configured with -machine
>    pflash0=... (x86: bios is silently ignored then)

Can we start deprecating the -bios command line option?

Maybe on a per-architecture basis first.

> * -machine pflash1=... does not require -machine pflash0=... (x86: it
>    does).
> 
> The actual code is a bit simpler than for x86 mostly due to the first
> two differences.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  hw/arm/virt.c         | 192 +++++++++++++++++++++++++++---------------
>  include/hw/arm/virt.h |   2 +
>  2 files changed, 124 insertions(+), 70 deletions(-)
> 
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index ce2664a30b..8ce7ecca80 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -30,6 +30,7 @@
>  
>  #include "qemu/osdep.h"
>  #include "qemu/units.h"
> +#include "qemu/option.h"
>  #include "qapi/error.h"
>  #include "hw/sysbus.h"
>  #include "hw/arm/arm.h"
> @@ -871,25 +872,19 @@ static void create_virtio_devices(const VirtMachineState *vms, qemu_irq *pic)
>      }
>  }
>  
> -static void create_one_flash(const char *name, hwaddr flashbase,
> -                             hwaddr flashsize, const char *file,
> -                             MemoryRegion *sysmem)
> +#define VIRT_FLASH_SECTOR_SIZE (256 * KiB)
> +
> +static PFlashCFI01 *virt_pflash_create1(VirtMachineState *vms,
> +                                        const char *name,
> +                                        const char *alias_prop_name)
>  {
> -    /* Create and map a single flash device. We use the same
> -     * parameters as the flash devices on the Versatile Express board.
> +    /*
> +     * Create a single flash device.  We use the same parameters as
> +     * the flash devices on the Versatile Express board.
>       */
> -    DriveInfo *dinfo = drive_get_next(IF_PFLASH);
>      DeviceState *dev = qdev_create(NULL, TYPE_PFLASH_CFI01);
> -    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
> -    const uint64_t sectorlength = 256 * 1024;
>  
> -    if (dinfo) {
> -        qdev_prop_set_drive(dev, "drive", blk_by_legacy_dinfo(dinfo),
> -                            &error_abort);
> -    }
> -
> -    qdev_prop_set_uint32(dev, "num-blocks", flashsize / sectorlength);
> -    qdev_prop_set_uint64(dev, "sector-length", sectorlength);
> +    qdev_prop_set_uint64(dev, "sector-length", VIRT_FLASH_SECTOR_SIZE);
>      qdev_prop_set_uint8(dev, "width", 4);
>      qdev_prop_set_uint8(dev, "device-width", 2);
>      qdev_prop_set_bit(dev, "big-endian", false);
> @@ -898,41 +893,41 @@ static void create_one_flash(const char *name, hwaddr flashbase,
>      qdev_prop_set_uint16(dev, "id2", 0x00);
>      qdev_prop_set_uint16(dev, "id3", 0x00);
>      qdev_prop_set_string(dev, "name", name);
> +    object_property_add_child(OBJECT(vms), name, OBJECT(dev),
> +                              &error_abort);
> +    object_property_add_alias(OBJECT(vms), alias_prop_name,
> +                              OBJECT(dev), "drive", &error_abort);
> +    return PFLASH_CFI01(dev);
> +}
> +
> +static void virt_flash_create(VirtMachineState *vms)
> +{
> +    vms->flash[0] = virt_pflash_create1(vms, "virt.flash0", "pflash0");
> +    vms->flash[1] = virt_pflash_create1(vms, "virt.flash1", "pflash1");
> +}
> +
> +static void virt_flash_map1(PFlashCFI01 *flash,
> +                            hwaddr base, hwaddr size,
> +                            MemoryRegion *sysmem)
> +{
> +    DeviceState *dev = DEVICE(flash);
> +
> +    assert(size % VIRT_FLASH_SECTOR_SIZE == 0);
> +    assert(size / VIRT_FLASH_SECTOR_SIZE <= UINT32_MAX);
> +    qdev_prop_set_uint32(dev, "num-blocks", size / VIRT_FLASH_SECTOR_SIZE);
>      qdev_init_nofail(dev);
>  
> -    memory_region_add_subregion(sysmem, flashbase,
> -                                sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0));
> -
> -    if (file) {
> -        char *fn;
> -        int image_size;
> -
> -        if (drive_get(IF_PFLASH, 0, 0)) {
> -            error_report("The contents of the first flash device may be "
> -                         "specified with -bios or with -drive if=pflash... "
> -                         "but you cannot use both options at once");
> -            exit(1);
> -        }
> -        fn = qemu_find_file(QEMU_FILE_TYPE_BIOS, file);
> -        if (!fn) {
> -            error_report("Could not find ROM image '%s'", file);
> -            exit(1);
> -        }
> -        image_size = load_image_mr(fn, sysbus_mmio_get_region(sbd, 0));
> -        g_free(fn);
> -        if (image_size < 0) {
> -            error_report("Could not load ROM image '%s'", file);
> -            exit(1);
> -        }
> -    }
> +    memory_region_add_subregion(sysmem, base,
> +                                sysbus_mmio_get_region(SYS_BUS_DEVICE(dev),
> +                                                       0));
>  }
>  
> -static void create_flash(const VirtMachineState *vms,
> -                         MemoryRegion *sysmem,
> -                         MemoryRegion *secure_sysmem)
> +static void virt_flash_map(VirtMachineState *vms,
> +                           MemoryRegion *sysmem,
> +                           MemoryRegion *secure_sysmem)
>  {
> -    /* Create two flash devices to fill the VIRT_FLASH space in the memmap.
> -     * Any file passed via -bios goes in the first of these.
> +    /*
> +     * Map two flash devices to fill the VIRT_FLASH space in the memmap.
>       * sysmem is the system memory space. secure_sysmem is the secure view
>       * of the system, and the first flash device should be made visible only
>       * there. The second flash device is visible to both secure and nonsecure.
> @@ -941,13 +936,21 @@ static void create_flash(const VirtMachineState *vms,
>       */
>      hwaddr flashsize = vms->memmap[VIRT_FLASH].size / 2;
>      hwaddr flashbase = vms->memmap[VIRT_FLASH].base;
> +
> +    virt_flash_map1(vms->flash[0], flashbase, flashsize,
> +                    secure_sysmem);
> +    virt_flash_map1(vms->flash[1], flashbase + flashsize, flashsize,
> +                    sysmem);
> +}
> +
> +static void virt_flash_fdt(VirtMachineState *vms,
> +                           MemoryRegion *sysmem,
> +                           MemoryRegion *secure_sysmem)
> +{
> +    hwaddr flashsize = vms->memmap[VIRT_FLASH].size / 2;
> +    hwaddr flashbase = vms->memmap[VIRT_FLASH].base;
>      char *nodename;
>  
> -    create_one_flash("virt.flash0", flashbase, flashsize,
> -                     bios_name, secure_sysmem);
> -    create_one_flash("virt.flash1", flashbase + flashsize, flashsize,
> -                     NULL, sysmem);
> -
>      if (sysmem == secure_sysmem) {
>          /* Report both flash devices as a single node in the DT */
>          nodename = g_strdup_printf("/flash@%" PRIx64, flashbase);
> @@ -959,7 +962,8 @@ static void create_flash(const VirtMachineState *vms,
>          qemu_fdt_setprop_cell(vms->fdt, nodename, "bank-width", 4);
>          g_free(nodename);
>      } else {
> -        /* Report the devices as separate nodes so we can mark one as
> +        /*
> +         * Report the devices as separate nodes so we can mark one as
>           * only visible to the secure world.
>           */
>          nodename = g_strdup_printf("/secflash@%" PRIx64, flashbase);
> @@ -982,6 +986,48 @@ static void create_flash(const VirtMachineState *vms,
>      }
>  }
>  
> +static bool virt_firmware_init(VirtMachineState *vms,
> +                               MemoryRegion *sysmem,
> +                               MemoryRegion *secure_sysmem)
> +{
> +    BlockBackend *pflash_blk0;
> +
> +    pflash_cfi01_legacy_drive(vms->flash, ARRAY_SIZE(vms->flash));
> +    virt_flash_map(vms, sysmem, secure_sysmem);
> +
> +    pflash_blk0 = pflash_cfi01_get_blk(vms->flash[0]);
> +
> +    if (bios_name) {
> +        char *fname;
> +        MemoryRegion *mr;
> +        int image_size;
> +
> +        if (pflash_blk0) {
> +            error_report("The contents of the first flash device may be "
> +                         "specified with -bios or with -drive if=pflash... "
> +                         "but you cannot use both options at once");
> +            exit(1);
> +        }
> +
> +        /* Fall back to -bios */
> +
> +        fname = qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
> +        if (!fname) {
> +            error_report("Could not find ROM image '%s'", bios_name);
> +            exit(1);
> +        }
> +        mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(vms->flash[0]), 0);
> +        image_size = load_image_mr(fname, mr);
> +        g_free(fname);
> +        if (image_size < 0) {
> +            error_report("Could not load ROM image '%s'", bios_name);
> +            exit(1);
> +        }
> +    }
> +
> +    return pflash_blk0 || bios_name;
> +}
> +
>  static FWCfgState *create_fw_cfg(const VirtMachineState *vms, AddressSpace *as)
>  {
>      hwaddr base = vms->memmap[VIRT_FW_CFG].base;
> @@ -1421,7 +1467,7 @@ static void machvirt_init(MachineState *machine)
>      MemoryRegion *secure_sysmem = NULL;
>      int n, virt_max_cpus;
>      MemoryRegion *ram = g_new(MemoryRegion, 1);
> -    bool firmware_loaded = bios_name || drive_get(IF_PFLASH, 0, 0);
> +    bool firmware_loaded;
>      bool aarch64 = true;
>  
>      /*
> @@ -1460,6 +1506,27 @@ static void machvirt_init(MachineState *machine)
>          exit(1);
>      }
>  
> +    if (vms->secure) {
> +        if (kvm_enabled()) {
> +            error_report("mach-virt: KVM does not support Security extensions");
> +            exit(1);
> +        }
> +
> +        /*
> +         * The Secure view of the world is the same as the NonSecure,
> +         * but with a few extra devices. Create it as a container region
> +         * containing the system memory at low priority; any secure-only
> +         * devices go in at higher priority and take precedence.
> +         */
> +        secure_sysmem = g_new(MemoryRegion, 1);
> +        memory_region_init(secure_sysmem, OBJECT(machine), "secure-memory",
> +                           UINT64_MAX);
> +        memory_region_add_subregion_overlap(secure_sysmem, 0, sysmem, -1);
> +    }
> +
> +    firmware_loaded = virt_firmware_init(vms, sysmem,
> +                                         secure_sysmem ?: sysmem);
> +
>      /* If we have an EL3 boot ROM then the assumption is that it will
>       * implement PSCI itself, so disable QEMU's internal implementation
>       * so it doesn't get in the way. Instead of starting secondary
> @@ -1505,23 +1572,6 @@ static void machvirt_init(MachineState *machine)
>          exit(1);
>      }
>  
> -    if (vms->secure) {
> -        if (kvm_enabled()) {
> -            error_report("mach-virt: KVM does not support Security extensions");
> -            exit(1);
> -        }
> -
> -        /* The Secure view of the world is the same as the NonSecure,
> -         * but with a few extra devices. Create it as a container region
> -         * containing the system memory at low priority; any secure-only
> -         * devices go in at higher priority and take precedence.
> -         */
> -        secure_sysmem = g_new(MemoryRegion, 1);
> -        memory_region_init(secure_sysmem, OBJECT(machine), "secure-memory",
> -                           UINT64_MAX);
> -        memory_region_add_subregion_overlap(secure_sysmem, 0, sysmem, -1);
> -    }
> -
>      create_fdt(vms);
>  
>      possible_cpus = mc->possible_cpu_arch_ids(machine);
> @@ -1610,7 +1660,7 @@ static void machvirt_init(MachineState *machine)
>                                      &machine->device_memory->mr);
>      }
>  
> -    create_flash(vms, sysmem, secure_sysmem ? secure_sysmem : sysmem);
> +    virt_flash_fdt(vms, sysmem, secure_sysmem);
>  
>      create_gic(vms, pic);
>  
> @@ -1956,6 +2006,8 @@ static void virt_instance_init(Object *obj)
>                                      NULL);
>  
>      vms->irqmap = a15irqmap;
> +
> +    virt_flash_create(vms);
>  }
>  
>  static const TypeInfo virt_machine_info = {
> diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
> index 507517c603..424070924e 100644
> --- a/include/hw/arm/virt.h
> +++ b/include/hw/arm/virt.h
> @@ -35,6 +35,7 @@
>  #include "qemu/notify.h"
>  #include "hw/boards.h"
>  #include "hw/arm/arm.h"
> +#include "hw/block/flash.h"
>  #include "sysemu/kvm.h"
>  #include "hw/intc/arm_gicv3_common.h"
>  
> @@ -113,6 +114,7 @@ typedef struct {
>      Notifier machine_done;
>      DeviceState *platform_bus_dev;
>      FWCfgState *fw_cfg;
> +    PFlashCFI01 *flash[2];
>      bool secure;
>      bool highmem;
>      bool highmem_ecam;
> 

