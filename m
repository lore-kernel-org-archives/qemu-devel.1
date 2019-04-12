Return-Path: <SRS0=wsBa=SO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14346C10F0E
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 17:50:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75C362086D
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 17:50:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75C362086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40712 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hF0Jt-0002iB-Ev
	for qemu-devel@archiver.kernel.org; Fri, 12 Apr 2019 13:50:33 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37280)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hF0Ir-0002Hy-D6
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 13:49:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hF0Io-0005BX-L8
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 13:49:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38564)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>)
	id 1hF0IZ-00050P-TE; Fri, 12 Apr 2019 13:49:12 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1F93531028D9;
	Fri, 12 Apr 2019 17:49:07 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-116.ams2.redhat.com
	[10.36.116.116])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 70BA65D9C5;
	Fri, 12 Apr 2019 17:49:06 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 031F81138648; Fri, 12 Apr 2019 19:49:04 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Laszlo Ersek <lersek@redhat.com>
References: <20190411135602.21725-1-armbru@redhat.com>
	<20190411135602.21725-3-armbru@redhat.com>
	<710ff1e9-14f9-8510-93ad-1930f21cc768@redhat.com>
Date: Fri, 12 Apr 2019 19:49:04 +0200
In-Reply-To: <710ff1e9-14f9-8510-93ad-1930f21cc768@redhat.com> (Laszlo Ersek's
	message of "Fri, 12 Apr 2019 13:00:45 +0200")
Message-ID: <871s27ktbj.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.42]);
	Fri, 12 Apr 2019 17:49:07 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
	qemu-devel@nongnu.org, mreitz@redhat.com, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190412174904.LLPGWnUw6u5lFYZ6FBiXjyW8CWdv0Va1M28lUuStX8A@z>

Laszlo Ersek <lersek@redhat.com> writes:

> On 04/11/19 15:56, Markus Armbruster wrote:
>> The ARM virt machines put firmware in flash memory.  To configure it,
>> you use -drive if=pflash,unit=0,... and optionally -drive
>> if=pflash,unit=1,...
>> 
>> Why two -drive?  This permits setting up one part of the flash memory
>> read-only, and the other part read/write.  It also makes upgrading
>> firmware on the host easier.  Below the hood, we get two separate
>> flash devices, because we were too lazy to improve our flash device
>> models to support sector protection.
>> 
>> The problem at hand is to do the same with -blockdev somehow, as one
>> more step towards deprecating -drive.
>> 
>> We recently solved this problem for x86 PC machines, in commit
>> ebc29e1beab.  See the commit message for design rationale.
>> 
>> This commit solves it for ARM virt basically the same way: new machine
>> properties pflash0, pflash1 forward to the onboard flash devices'
>> properties.  Requires creating the onboard devices in the
>> .instance_init() method virt_instance_init().  The existing code to
>> pick up drives defined with -drive if=pflash is replaced by code to
>> desugar into the machine properties.
>> 
>> There are a few behavioral differences, though:
>> 
>> * The flash devices are always present (x86: only present if
>>   configured)
>> 
>> * Flash base addresses and sizes are fixed (x86: sizes depend on
>>   images, mapped back to back below a fixed address)
>> 
>> * -bios configures contents of first pflash (x86: -bios configures ROM
>>    contents)
>> 
>> * -bios is rejected when first pflash is also configured with -machine
>>    pflash0=... (x86: bios is silently ignored then)
>> 
>> * -machine pflash1=... does not require -machine pflash0=... (x86: it
>>    does).
>> 
>> The actual code is a bit simpler than for x86 mostly due to the first
>> two differences.
>> 
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  hw/arm/virt.c         | 192 +++++++++++++++++++++++++++---------------
>>  include/hw/arm/virt.h |   2 +
>>  2 files changed, 124 insertions(+), 70 deletions(-)
>
> I tried to review this patch, but I can't follow it.
>
> I'm not saying it's wrong; in fact it *looks* right to me, but I can't
> follow it. It does so many things at once that I can't keep them all in
> mind.

Happens.  I'll try to explain, and then we can talk about improving the
patch.

Did you follow "See the commit message [of ebc29e1beab] for design
rationale" reference?

> I started with:
>
>   virt_instance_init()
>     virt_flash_create()
>       virt_pflash_create1()
>
> and then I got confused by the object_property_add_*() calls, which
> don't exist in the original code:
>
>> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
>> index ce2664a30b..8ce7ecca80 100644
>> --- a/hw/arm/virt.c
>> +++ b/hw/arm/virt.c
>> @@ -30,6 +30,7 @@
>>  
>>  #include "qemu/osdep.h"
>>  #include "qemu/units.h"
>> +#include "qemu/option.h"
>>  #include "qapi/error.h"
>>  #include "hw/sysbus.h"
>>  #include "hw/arm/arm.h"
>> @@ -871,25 +872,19 @@ static void create_virtio_devices(const VirtMachineState *vms, qemu_irq *pic)
>>      }
>>  }
>>  
>> -static void create_one_flash(const char *name, hwaddr flashbase,
>> -                             hwaddr flashsize, const char *file,
>> -                             MemoryRegion *sysmem)
>> +#define VIRT_FLASH_SECTOR_SIZE (256 * KiB)
>> +
>> +static PFlashCFI01 *virt_pflash_create1(VirtMachineState *vms,
>> +                                        const char *name,
>> +                                        const char *alias_prop_name)
>>  {
>> -    /* Create and map a single flash device. We use the same
>> -     * parameters as the flash devices on the Versatile Express board.
>> +    /*
>> +     * Create a single flash device.  We use the same parameters as
>> +     * the flash devices on the Versatile Express board.
>>       */
>> -    DriveInfo *dinfo = drive_get_next(IF_PFLASH);
>>      DeviceState *dev = qdev_create(NULL, TYPE_PFLASH_CFI01);
>> -    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
>> -    const uint64_t sectorlength = 256 * 1024;
>>  
>> -    if (dinfo) {
>> -        qdev_prop_set_drive(dev, "drive", blk_by_legacy_dinfo(dinfo),
>> -                            &error_abort);
>> -    }
>> -
>> -    qdev_prop_set_uint32(dev, "num-blocks", flashsize / sectorlength);
>> -    qdev_prop_set_uint64(dev, "sector-length", sectorlength);
>> +    qdev_prop_set_uint64(dev, "sector-length", VIRT_FLASH_SECTOR_SIZE);
>>      qdev_prop_set_uint8(dev, "width", 4);
>>      qdev_prop_set_uint8(dev, "device-width", 2);
>>      qdev_prop_set_bit(dev, "big-endian", false);
>> @@ -898,41 +893,41 @@ static void create_one_flash(const char *name, hwaddr flashbase,
>>      qdev_prop_set_uint16(dev, "id2", 0x00);
>>      qdev_prop_set_uint16(dev, "id3", 0x00);
>>      qdev_prop_set_string(dev, "name", name);
>> +    object_property_add_child(OBJECT(vms), name, OBJECT(dev),
>> +                              &error_abort);
>
> I guess this links the pflash device as a child under the
> VirtMachineState object

Yes.

>                         -- but why wasn't that necessary before?

For better or worse, a qdev device without a parent gets adopted on
realize by container object "/machine/unattached".  See
device_set_realized() under if (!obj->parent).

Example to illustrate, feel free to skip ahead to "End of example".

Here's the contents of "/machine/unattached" for a pretty minimal ARM
virt machine (I use scripts/qmp/qom-fuse to mount the QOM tree to
qom-fuse/ for easy examination):

    $ ls qom-fuse/machine/unattached/
    'device[0]'   'device[19]'  'device[28]'  'device[37]'  'device[7]'
    'device[10]'  'device[1]'   'device[29]'  'device[38]'  'device[8]'
    'device[11]'  'device[20]'  'device[2]'   'device[39]'  'device[9]'
    'device[12]'  'device[21]'  'device[30]'  'device[3]'   'io[0]'
    'device[13]'  'device[22]'  'device[31]'  'device[40]'  'mach-virt.ram[0]'
    'device[14]'  'device[23]'  'device[32]'  'device[41]'  'platform bus[0]'
    'device[15]'  'device[24]'  'device[33]'  'device[42]'   sysbus
    'device[16]'  'device[25]'  'device[34]'  'device[4]'   'system[0]'
    'device[17]'  'device[26]'  'device[35]'  'device[5]'    type
    'device[18]'  'device[27]'  'device[36]'  'device[6]'

The device* are the adopted qdevs.  Let's look for pflash:

    $ grep -a cfi qom-fuse/machine/unattached/device*/type
    qom-fuse/machine/unattached/device[1]/type:cfi.pflash01
    qom-fuse/machine/unattached/device[2]/type:cfi.pflash01

Here are the children of /machine:

    $ ls qom-fuse/machine/
    accel                   fw_cfg        kernel             secure
    append                  gic-version   kernel-irqchip     suppress-vmdesc
    dt-compatible           graphics      kvm-shadow-mem     type
    dtb                     highmem       mem-merge          unattached
    dump-guest-core         igd-passthru  memory-encryption  usb
    dumpdtb                 initrd        peripheral         virtualization
    enforce-config-section  iommu         peripheral-anon
    firmware                its           phandle-start

This was before this patch.  Afterwards:

    $ ls qom-fuse/machine/unattached/
    'device[0]'   'device[19]'  'device[28]'  'device[37]'  'device[9]'
    'device[10]'  'device[1]'   'device[29]'  'device[38]'  'io[0]'
    'device[11]'  'device[20]'  'device[2]'   'device[39]'  'mach-virt.ram[0]'
    'device[12]'  'device[21]'  'device[30]'  'device[3]'   'platform bus[0]'
    'device[13]'  'device[22]'  'device[31]'  'device[40]'   sysbus
    'device[14]'  'device[23]'  'device[32]'  'device[4]'   'system[0]'
    'device[15]'  'device[24]'  'device[33]'  'device[5]'    type
    'device[16]'  'device[25]'  'device[34]'  'device[6]'
    'device[17]'  'device[26]'  'device[35]'  'device[7]'
    'device[18]'  'device[27]'  'device[36]'  'device[8]'

Two fewer device*.

    $ ls qom-fuse/machine/
    accel                   gic-version     kvm-shadow-mem     suppress-vmdesc
    append                  graphics        mem-merge          type
    dt-compatible           highmem         memory-encryption  unattached
    dtb                     igd-passthru    peripheral         usb
    dump-guest-core         initrd          peripheral-anon    virt.flash0
    dumpdtb                 iommu           pflash0            virt.flash1
    enforce-config-section  its             pflash1            virtualization
    firmware                kernel          phandle-start
    fw_cfg                  kernel-irqchip  secure

Note new virt.flash0 and virt.flash1.

    $ cat qom-fuse/machine/virt.flash*/type
    cfi.pflash01
    cfi.pflash01

That's where the two went.

End of example.

Now I'm actually read to answer your question "why wasn't that necessary
before?", or rather "why is it necessary now?"

It wasn't necessary before because orphans get adopted.

It might not even be necessary now, but I feel (strongly!) that an alias
property should redirect to a child's property, not some random
unrelated object's property (see right below).

Regardless, I feel onboard devices should be proper children of the
machine anyway, not stuffed into its unattached/ grabbag.

>> +    object_property_add_alias(OBJECT(vms), alias_prop_name,
>> +                              OBJECT(dev), "drive", &error_abort);
>
> What is this good for? Does this make the pflash0 / pflash1 properties
> of the machine refer to the "drive" property of the pflash device?

Correct!

With object.h and a crystal ball, you should be able to work that out
for yourself:

/**
 * object_property_add_alias:
 * @obj: the object to add a property to
 * @name: the name of the property
 * @target_obj: the object to forward property access to
 * @target_name: the name of the property on the forwarded object
 * @errp: if an error occurs, a pointer to an area to store the error
 *
 * Add an alias for a property on an object.  This function will add a property
 * of the same type as the forwarded property.
 *
 * The caller must ensure that <code>@target_obj</code> stays alive as long as
 * this property exists.  In the case of a child object or an alias on the same
 * object this will be the case.  For aliases to other objects the caller is
 * responsible for taking a reference.
 */

Oh, no crystal ball?  Then it's spelunking through object.c, I guess.

> Can we have a comment about that, or is that obvious for people that are
> used to QOM code?

If there are any, please speak up, so we can appoint you QOM maintainer.

In my (weak) defense, I mentioned the property forwarding in my commit
message ("new machine properties pflash0, pflash1 forward to the onboard
flash devices' properties"), and I did point to commit ebc29e1beab for
design rationale.  It has this paragraph:

    More seriously, the properties do not belong to the machine, they
    belong to the onboard flash devices.  Adding them to the machine would
    then require bad magic to somehow transfer them to the flash devices.
    Fortunately, QOM provides the means to handle exactly this case: add
    alias properties to the machine that forward to the onboard devices'
    properties.

> ... So anyway, this is where I come to an almost complete halt. I
> understand one more bit (in isolation only):
>
>> +    return PFLASH_CFI01(dev);
>> +}
>> +
>> +static void virt_flash_create(VirtMachineState *vms)
>> +{
>> +    vms->flash[0] = virt_pflash_create1(vms, "virt.flash0", "pflash0");
>> +    vms->flash[1] = virt_pflash_create1(vms, "virt.flash1", "pflash1");
>> +}
>> +
>> +static void virt_flash_map1(PFlashCFI01 *flash,
>> +                            hwaddr base, hwaddr size,
>> +                            MemoryRegion *sysmem)
>> +{
>> +    DeviceState *dev = DEVICE(flash);
>> +
>> +    assert(size % VIRT_FLASH_SECTOR_SIZE == 0);
>> +    assert(size / VIRT_FLASH_SECTOR_SIZE <= UINT32_MAX);
>> +    qdev_prop_set_uint32(dev, "num-blocks", size / VIRT_FLASH_SECTOR_SIZE);
>>      qdev_init_nofail(dev);
>>  
>> -    memory_region_add_subregion(sysmem, flashbase,
>> -                                sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0));
>> -
>> -    if (file) {
>> -        char *fn;
>> -        int image_size;
>> -
>> -        if (drive_get(IF_PFLASH, 0, 0)) {
>> -            error_report("The contents of the first flash device may be "
>> -                         "specified with -bios or with -drive if=pflash... "
>> -                         "but you cannot use both options at once");
>> -            exit(1);
>> -        }
>> -        fn = qemu_find_file(QEMU_FILE_TYPE_BIOS, file);
>> -        if (!fn) {
>> -            error_report("Could not find ROM image '%s'", file);
>> -            exit(1);
>> -        }
>> -        image_size = load_image_mr(fn, sysbus_mmio_get_region(sbd, 0));
>> -        g_free(fn);
>> -        if (image_size < 0) {
>> -            error_report("Could not load ROM image '%s'", file);
>> -            exit(1);
>> -        }
>> -    }
>> +    memory_region_add_subregion(sysmem, base,
>> +                                sysbus_mmio_get_region(SYS_BUS_DEVICE(dev),
>> +                                                       0));
>>  }
>>  
>> -static void create_flash(const VirtMachineState *vms,
>> -                         MemoryRegion *sysmem,
>> -                         MemoryRegion *secure_sysmem)
>> +static void virt_flash_map(VirtMachineState *vms,
>> +                           MemoryRegion *sysmem,
>> +                           MemoryRegion *secure_sysmem)
>>  {
>> -    /* Create two flash devices to fill the VIRT_FLASH space in the memmap.
>> -     * Any file passed via -bios goes in the first of these.
>> +    /*
>> +     * Map two flash devices to fill the VIRT_FLASH space in the memmap.
>>       * sysmem is the system memory space. secure_sysmem is the secure view
>>       * of the system, and the first flash device should be made visible only
>>       * there. The second flash device is visible to both secure and nonsecure.
>> @@ -941,13 +936,21 @@ static void create_flash(const VirtMachineState *vms,
>>       */
>>      hwaddr flashsize = vms->memmap[VIRT_FLASH].size / 2;
>>      hwaddr flashbase = vms->memmap[VIRT_FLASH].base;
>> +
>> +    virt_flash_map1(vms->flash[0], flashbase, flashsize,
>> +                    secure_sysmem);
>> +    virt_flash_map1(vms->flash[1], flashbase + flashsize, flashsize,
>> +                    sysmem);
>> +}
>> +
>> +static void virt_flash_fdt(VirtMachineState *vms,
>> +                           MemoryRegion *sysmem,
>> +                           MemoryRegion *secure_sysmem)
>> +{
>> +    hwaddr flashsize = vms->memmap[VIRT_FLASH].size / 2;
>> +    hwaddr flashbase = vms->memmap[VIRT_FLASH].base;
>>      char *nodename;
>>  
>> -    create_one_flash("virt.flash0", flashbase, flashsize,
>> -                     bios_name, secure_sysmem);
>> -    create_one_flash("virt.flash1", flashbase + flashsize, flashsize,
>> -                     NULL, sysmem);
>> -
>>      if (sysmem == secure_sysmem) {
>>          /* Report both flash devices as a single node in the DT */
>>          nodename = g_strdup_printf("/flash@%" PRIx64, flashbase);
>> @@ -959,7 +962,8 @@ static void create_flash(const VirtMachineState *vms,
>>          qemu_fdt_setprop_cell(vms->fdt, nodename, "bank-width", 4);
>>          g_free(nodename);
>>      } else {
>> -        /* Report the devices as separate nodes so we can mark one as
>> +        /*
>> +         * Report the devices as separate nodes so we can mark one as
>>           * only visible to the secure world.
>>           */
>>          nodename = g_strdup_printf("/secflash@%" PRIx64, flashbase);
>> @@ -982,6 +986,48 @@ static void create_flash(const VirtMachineState *vms,
>>      }
>>  }
>>  
>> +static bool virt_firmware_init(VirtMachineState *vms,
>> +                               MemoryRegion *sysmem,
>> +                               MemoryRegion *secure_sysmem)
>> +{
>> +    BlockBackend *pflash_blk0;
>> +
>> +    pflash_cfi01_legacy_drive(vms->flash, ARRAY_SIZE(vms->flash));
>> +    virt_flash_map(vms, sysmem, secure_sysmem);
>> +
>> +    pflash_blk0 = pflash_cfi01_get_blk(vms->flash[0]);
>> +
>> +    if (bios_name) {
>> +        char *fname;
>> +        MemoryRegion *mr;
>> +        int image_size;
>> +
>> +        if (pflash_blk0) {
>> +            error_report("The contents of the first flash device may be "
>> +                         "specified with -bios or with -drive if=pflash... "
>> +                         "but you cannot use both options at once");
>> +            exit(1);
>> +        }
>> +
>> +        /* Fall back to -bios */
>> +
>> +        fname = qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
>> +        if (!fname) {
>> +            error_report("Could not find ROM image '%s'", bios_name);
>> +            exit(1);
>> +        }
>> +        mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(vms->flash[0]), 0);
>> +        image_size = load_image_mr(fname, mr);
>> +        g_free(fname);
>> +        if (image_size < 0) {
>> +            error_report("Could not load ROM image '%s'", bios_name);
>> +            exit(1);
>> +        }
>> +    }
>> +
>> +    return pflash_blk0 || bios_name;
>> +}
>> +
>>  static FWCfgState *create_fw_cfg(const VirtMachineState *vms, AddressSpace *as)
>>  {
>>      hwaddr base = vms->memmap[VIRT_FW_CFG].base;
>> @@ -1421,7 +1467,7 @@ static void machvirt_init(MachineState *machine)
>>      MemoryRegion *secure_sysmem = NULL;
>>      int n, virt_max_cpus;
>>      MemoryRegion *ram = g_new(MemoryRegion, 1);
>> -    bool firmware_loaded = bios_name || drive_get(IF_PFLASH, 0, 0);
>> +    bool firmware_loaded;
>>      bool aarch64 = true;
>>  
>>      /*
>> @@ -1460,6 +1506,27 @@ static void machvirt_init(MachineState *machine)
>>          exit(1);
>>      }
>>  
>> +    if (vms->secure) {
>> +        if (kvm_enabled()) {
>> +            error_report("mach-virt: KVM does not support Security extensions");
>> +            exit(1);
>> +        }
>> +
>> +        /*
>> +         * The Secure view of the world is the same as the NonSecure,
>> +         * but with a few extra devices. Create it as a container region
>> +         * containing the system memory at low priority; any secure-only
>> +         * devices go in at higher priority and take precedence.
>> +         */
>> +        secure_sysmem = g_new(MemoryRegion, 1);
>> +        memory_region_init(secure_sysmem, OBJECT(machine), "secure-memory",
>> +                           UINT64_MAX);
>> +        memory_region_add_subregion_overlap(secure_sysmem, 0, sysmem, -1);
>> +    }
>> +
>> +    firmware_loaded = virt_firmware_init(vms, sysmem,
>> +                                         secure_sysmem ?: sysmem);
>> +
>>      /* If we have an EL3 boot ROM then the assumption is that it will
>>       * implement PSCI itself, so disable QEMU's internal implementation
>>       * so it doesn't get in the way. Instead of starting secondary
>
> Namely, at this point, I seem to understand that we have to hoist this
> "vms->secure" block here, because:
>
> - below (not seen in the context), we have a condition on "firmware_loaded",

Correct.

> - "firmware_loaded" *now* depends on "secure_sysmem" (it used not to,
> before)

Correct again.

Before the patch, we have

    bool firmware_loaded = bios_name || drive_get(IF_PFLASH, 0, 0);

which really means "-bios or -drive if=pflash,unit=0 given".  If true,
create_flash() below will surely put firmware into the first flash chip.

Afterwards, predicting "will put firmware" is more complex.  Instead of
coding up a prediction of what create_flash()'s replacement
virt_firmware_init() is going to do, I have virt_firmware_init() return
what it did:

        firmware_loaded = virt_firmware_init(vms, sysmem,
                                             secure_sysmem ?: sysmem);

Naturally, I have to do this before firmware_loaded is used.  So
create_flash()'s replacement virt_firmware_init() moves up right before
the first use of firmware_loaded.  On its way, ...

> - and "secure_sysmem" depends on the "vms->secure" block that we're
> moving up here.

... it bumps into the computation of secure_sysmem, and pushes it up,
too.

> And that's where I grind to a halt, because I don't understand what the
> old functions are responsible for exactly, and how the responsibilities
> are now re-distributed, between the new functions.
>
> I tried to look at this patch with full function context, and I also
> tried to look at the full file (pre vs. post) through a colorized
> side-by-side diff. To no use.
>
> Now, I'm not saying this is a fault with the patch. It's entirely
> possible that the goal can only be achieved with such a "rewrite". I
> think it plausible that the patch cannot be done in multiple smaller
> patches, especially if we consider bisectability a requirement. (Maybe
> splitting the patch to smaller logical steps would be possible if we
> accepted halfway constructed and/or orphan objects, mid-series, that
> build and cause no issues at runtime. I don't know.)

Maybe it's possible, period.

> So it's *my* fault -- it's like the code is sliced into small bits and
> then reshuffled to a new story, and I can't follow the bits' dance.
>
> Can you add two high-level call trees, side-by-side, to the commit
> message, not just with function names but also with responsibilities?
>
> I guess I won't ask for arrows from the left to the right :) I'll try to
> draw them myself.

Before the patch:

    main()
        machine_run_board_init()
            machvirt_init() [method .init()]
                create_flash()
                    create_one_flash() for flash[0]
                        create
                        configure
                            includes obeying -drive if=pflash,unit=0
                        realize
                        map
                        fall back to -bios
                    create_one_flash() for flash[1]
                        create
                        configure
                            includes obeying -drive if=pflash,unit=1
                        realize
                        map
                    update FDT

All the action is in create_flash().

Creating onboard devices in the machine's .init() method is common, but
that doesn't make it right.  By the time .init() runs, we're long done
with setting properties.  So anything we create that late cannot expose
properties.  The proper place to create onboard devices is
.instance_init().  This is why I need to split up create_flash().

After the patch:

    main()
        current_machine = object_new()
            ...
                virt_instance_init() [method .instance_init()]
                    virt_flash_create()
                        virt_flash_create1() for flash[0]
                            create
                            configure: set defaults
                            become child of machine
                            add machine prop pflash0 as alias for drive
                        virt_flash_create1() for flash[1]
                            create
                            configure: set defaults
                            become child of machine [NEW]
                            add machine prop pflash1 as alias for drive [NEW]
        for all machine props: machine_set_property()
            ...
                property_set_alias() for machine props pflash0, pflash1
                    ...
                        set_drive() for cfi.pflash01 prop drive
                            this is how -machine pflash0=... etc set
        machine_run_board_init(current_machine);
            virt_firmware_init()
                pflash_cfi01_legacy_drive()
                    legacy -drive if=pflash,unit=0 and =1 [NEW]
                virt_flash_map()
                    virt_flash_map1() for flash[0]
                        configure: num-blocks
                        realize
                        map
                    virt_flash_map1() for flash[1]
                        configure: num-blocks
                        realize
                        map
                fall back to -bios
            virt_flash_fdt()
                update FDT

Hope this helps!

> To re-state: I'm not complaining about the patch, just saying that I've
> failed to understand it. I don't insist on understanding it (I'm fine if
> others understand it and approve it), but if I'm expected to ACK, I'll
> need more explanation. A lot more. :) Preferably captured within the series.
>
> Thanks (and I apologize)

No problem.

