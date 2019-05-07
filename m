Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E312C004C9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 12:09:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6837205ED
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 12:09:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZIq/ytkp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6837205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45725 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNyuz-0006QH-2v
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 08:09:57 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44899)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hNylr-0007d1-BJ
	for qemu-devel@nongnu.org; Tue, 07 May 2019 08:00:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hNylk-0003W1-Tv
	for qemu-devel@nongnu.org; Tue, 07 May 2019 08:00:31 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:35359)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hNylh-0003Or-88
	for qemu-devel@nongnu.org; Tue, 07 May 2019 08:00:23 -0400
Received: by mail-wr1-x429.google.com with SMTP id w12so8496970wrp.2
	for <qemu-devel@nongnu.org>; Tue, 07 May 2019 05:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=YuOTbWeM20muqoRqb7Q6LAntSlWukOPNKwpiKgXl/7A=;
	b=ZIq/ytkpzgkqqICv1pfRr8fzLvRscfPGGxCzclCu+GRCPKJdmJ2mPw906yvelC2l+A
	ZbLUnyxI5kW7oF4axEfEA9jL4Iyv1NBc48lIy/4VIwvjPFgGlIwgAltSdiLGHZEoAMCT
	zCuK0idRqlMrk7Mf7V4w+PloMxQOg9wJLYh+2dec3hVewXcaxXf56N7txKcibQgncSz2
	In/gqFv7XwxDjawDs9s+aV2NcuZ2E+TfKPcFVf9MCoLaLZ1nJcj3Rawv9PzVjdy0FE8d
	1WiOlw9mJ6mRr4N/+g8YLkIwFLo8Os4t/n3vfMsM6HnJQ0jMDH/g5dQxjea+3Lg5QFUu
	382Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=YuOTbWeM20muqoRqb7Q6LAntSlWukOPNKwpiKgXl/7A=;
	b=fG6GiLdPgZDKBpc6iRqSy0Il04b8d97fkJmtPGfro7aya0ZlNFNdTRmDGI5J8ayPQC
	i1CGbh6ThboKl86AlTsfDyJYQZxfwrsY5wrIlkicRQ22lCVoWRNxg471TNacmJbf44+k
	vN9/Vfay3JikZzirJ+ExvCEcBZupjTYZEuST2zbgQ/IQ/O3OvSNCj2KYo2WYDKJficgw
	EWqX+rpbV3fnvOHMJYBDuZtVErh9k6qweSAU9x6/SWFDFyvTAi+w59gmqWb9jVslUhkq
	p1CfUd17Z3VQNZg27ObtUcRrAcWOZZgCg79gO223lOPqrG5FcLD7o8EnmYGtgi/dwvgs
	K5HQ==
X-Gm-Message-State: APjAAAUA9pDQNaGGl9uj2jk4FLtXdkL+npVqsdMwuGYOihTepnwKm1Nl
	uRT6wyKIPIjpDC2NZwEsRvVmROKFYZc=
X-Google-Smtp-Source: APXvYqx0qCIb9+rF7tTdqOiBvt10mIEVXcCbCAaw3O3dEy4XnJtKpZj/HevxcJH6gWmMoRz/mxoZdg==
X-Received: by 2002:adf:f349:: with SMTP id e9mr4010900wrp.71.1557230418946;
	Tue, 07 May 2019 05:00:18 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id g3sm12348596wmf.9.2019.05.07.05.00.17
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 07 May 2019 05:00:18 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue,  7 May 2019 12:59:59 +0100
Message-Id: <20190507120011.18100-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190507120011.18100-1-peter.maydell@linaro.org>
References: <20190507120011.18100-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::429
Subject: [Qemu-devel] [PULL 03/15] hw/arm/virt: Support firmware
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Markus Armbruster <armbru@redhat.com>

The ARM virt machines put firmware in flash memory.  To configure it,
you use -drive if=pflash,unit=0,... and optionally -drive
if=pflash,unit=1,...

Why two -drive?  This permits setting up one part of the flash memory
read-only, and the other part read/write.  It also makes upgrading
firmware on the host easier.  Below the hood, we get two separate
flash devices, because we were too lazy to improve our flash device
models to support sector protection.

The problem at hand is to do the same with -blockdev somehow, as one
more step towards deprecating -drive.

We recently solved this problem for x86 PC machines, in commit
ebc29e1beab.  See the commit message for design rationale.

This commit solves it for ARM virt basically the same way: new machine
properties pflash0, pflash1 forward to the onboard flash devices'
properties.  Requires creating the onboard devices in the
.instance_init() method virt_instance_init().  The existing code to
pick up drives defined with -drive if=pflash is replaced by code to
desugar into the machine properties.

There are a few behavioral differences, though:

* The flash devices are always present (x86: only present if
  configured)

* Flash base addresses and sizes are fixed (x86: sizes depend on
  images, mapped back to back below a fixed address)

* -bios configures contents of first pflash (x86: -bios configures ROM
   contents)

* -bios is rejected when first pflash is also configured with -machine
   pflash0=... (x86: bios is silently ignored then)

* -machine pflash1=... does not require -machine pflash0=... (x86: it
   does).

The actual code is a bit simpler than for x86 mostly due to the first
two differences.

Before the patch, all the action is in create_flash(), called from the
machine's .init() method machvirt_init():

    main()
        machine_run_board_init()
            machvirt_init()
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

To make the machine properties work, we need to move device creation
to its .instance_init() method virt_instance_init().

Another complication is machvirt_init()'s computation of
@firmware_loaded: it predicts what create_flash() will do.  Instead of
predicting what create_flash()'s replacement virt_firmware_init() will
do, I decided to have virt_firmware_init() return what it did.
Requires calling it a bit earlier.

Resulting call tree:

    main()
        current_machine = object_new()
            ...
                virt_instance_init()
                    virt_flash_create()
                        virt_flash_create1() for flash[0]
                            create
                            configure: set defaults
                            become child of machine [NEW]
                            add machine prop pflash0 as alias for drive [NEW]
                        virt_flash_create1() for flash[1]
                            create
                            configure: set defaults
                            become child of machine [NEW]
                            add machine prop pflash1 as alias for drive [NEW]
        for all machine props from the command line: machine_set_property()
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

You have László to thank for making me explain this in detail.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Acked-by: Laszlo Ersek <lersek@redhat.com>
Message-id: 20190416091348.26075-4-armbru@redhat.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/virt.h |   2 +
 hw/arm/virt.c         | 202 +++++++++++++++++++++++++++---------------
 2 files changed, 132 insertions(+), 72 deletions(-)

diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 507517c603b..424070924ed 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -35,6 +35,7 @@
 #include "qemu/notify.h"
 #include "hw/boards.h"
 #include "hw/arm/arm.h"
+#include "hw/block/flash.h"
 #include "sysemu/kvm.h"
 #include "hw/intc/arm_gicv3_common.h"
 
@@ -113,6 +114,7 @@ typedef struct {
     Notifier machine_done;
     DeviceState *platform_bus_dev;
     FWCfgState *fw_cfg;
+    PFlashCFI01 *flash[2];
     bool secure;
     bool highmem;
     bool highmem_ecam;
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 16ba67f7a76..5331ab71e22 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -30,6 +30,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/units.h"
+#include "qemu/option.h"
 #include "qapi/error.h"
 #include "hw/sysbus.h"
 #include "hw/arm/arm.h"
@@ -871,25 +872,19 @@ static void create_virtio_devices(const VirtMachineState *vms, qemu_irq *pic)
     }
 }
 
-static void create_one_flash(const char *name, hwaddr flashbase,
-                             hwaddr flashsize, const char *file,
-                             MemoryRegion *sysmem)
+#define VIRT_FLASH_SECTOR_SIZE (256 * KiB)
+
+static PFlashCFI01 *virt_flash_create1(VirtMachineState *vms,
+                                        const char *name,
+                                        const char *alias_prop_name)
 {
-    /* Create and map a single flash device. We use the same
-     * parameters as the flash devices on the Versatile Express board.
+    /*
+     * Create a single flash device.  We use the same parameters as
+     * the flash devices on the Versatile Express board.
      */
-    DriveInfo *dinfo = drive_get_next(IF_PFLASH);
     DeviceState *dev = qdev_create(NULL, TYPE_PFLASH_CFI01);
-    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
-    const uint64_t sectorlength = 256 * 1024;
 
-    if (dinfo) {
-        qdev_prop_set_drive(dev, "drive", blk_by_legacy_dinfo(dinfo),
-                            &error_abort);
-    }
-
-    qdev_prop_set_uint32(dev, "num-blocks", flashsize / sectorlength);
-    qdev_prop_set_uint64(dev, "sector-length", sectorlength);
+    qdev_prop_set_uint64(dev, "sector-length", VIRT_FLASH_SECTOR_SIZE);
     qdev_prop_set_uint8(dev, "width", 4);
     qdev_prop_set_uint8(dev, "device-width", 2);
     qdev_prop_set_bit(dev, "big-endian", false);
@@ -898,41 +893,41 @@ static void create_one_flash(const char *name, hwaddr flashbase,
     qdev_prop_set_uint16(dev, "id2", 0x00);
     qdev_prop_set_uint16(dev, "id3", 0x00);
     qdev_prop_set_string(dev, "name", name);
-    qdev_init_nofail(dev);
-
-    memory_region_add_subregion(sysmem, flashbase,
-                                sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0));
-
-    if (file) {
-        char *fn;
-        int image_size;
-
-        if (drive_get(IF_PFLASH, 0, 0)) {
-            error_report("The contents of the first flash device may be "
-                         "specified with -bios or with -drive if=pflash... "
-                         "but you cannot use both options at once");
-            exit(1);
-        }
-        fn = qemu_find_file(QEMU_FILE_TYPE_BIOS, file);
-        if (!fn) {
-            error_report("Could not find ROM image '%s'", file);
-            exit(1);
-        }
-        image_size = load_image_mr(fn, sysbus_mmio_get_region(sbd, 0));
-        g_free(fn);
-        if (image_size < 0) {
-            error_report("Could not load ROM image '%s'", file);
-            exit(1);
-        }
-    }
+    object_property_add_child(OBJECT(vms), name, OBJECT(dev),
+                              &error_abort);
+    object_property_add_alias(OBJECT(vms), alias_prop_name,
+                              OBJECT(dev), "drive", &error_abort);
+    return PFLASH_CFI01(dev);
 }
 
-static void create_flash(const VirtMachineState *vms,
-                         MemoryRegion *sysmem,
-                         MemoryRegion *secure_sysmem)
+static void virt_flash_create(VirtMachineState *vms)
 {
-    /* Create two flash devices to fill the VIRT_FLASH space in the memmap.
-     * Any file passed via -bios goes in the first of these.
+    vms->flash[0] = virt_flash_create1(vms, "virt.flash0", "pflash0");
+    vms->flash[1] = virt_flash_create1(vms, "virt.flash1", "pflash1");
+}
+
+static void virt_flash_map1(PFlashCFI01 *flash,
+                            hwaddr base, hwaddr size,
+                            MemoryRegion *sysmem)
+{
+    DeviceState *dev = DEVICE(flash);
+
+    assert(size % VIRT_FLASH_SECTOR_SIZE == 0);
+    assert(size / VIRT_FLASH_SECTOR_SIZE <= UINT32_MAX);
+    qdev_prop_set_uint32(dev, "num-blocks", size / VIRT_FLASH_SECTOR_SIZE);
+    qdev_init_nofail(dev);
+
+    memory_region_add_subregion(sysmem, base,
+                                sysbus_mmio_get_region(SYS_BUS_DEVICE(dev),
+                                                       0));
+}
+
+static void virt_flash_map(VirtMachineState *vms,
+                           MemoryRegion *sysmem,
+                           MemoryRegion *secure_sysmem)
+{
+    /*
+     * Map two flash devices to fill the VIRT_FLASH space in the memmap.
      * sysmem is the system memory space. secure_sysmem is the secure view
      * of the system, and the first flash device should be made visible only
      * there. The second flash device is visible to both secure and nonsecure.
@@ -941,12 +936,20 @@ static void create_flash(const VirtMachineState *vms,
      */
     hwaddr flashsize = vms->memmap[VIRT_FLASH].size / 2;
     hwaddr flashbase = vms->memmap[VIRT_FLASH].base;
-    char *nodename;
 
-    create_one_flash("virt.flash0", flashbase, flashsize,
-                     bios_name, secure_sysmem);
-    create_one_flash("virt.flash1", flashbase + flashsize, flashsize,
-                     NULL, sysmem);
+    virt_flash_map1(vms->flash[0], flashbase, flashsize,
+                    secure_sysmem);
+    virt_flash_map1(vms->flash[1], flashbase + flashsize, flashsize,
+                    sysmem);
+}
+
+static void virt_flash_fdt(VirtMachineState *vms,
+                           MemoryRegion *sysmem,
+                           MemoryRegion *secure_sysmem)
+{
+    hwaddr flashsize = vms->memmap[VIRT_FLASH].size / 2;
+    hwaddr flashbase = vms->memmap[VIRT_FLASH].base;
+    char *nodename;
 
     if (sysmem == secure_sysmem) {
         /* Report both flash devices as a single node in the DT */
@@ -959,7 +962,8 @@ static void create_flash(const VirtMachineState *vms,
         qemu_fdt_setprop_cell(vms->fdt, nodename, "bank-width", 4);
         g_free(nodename);
     } else {
-        /* Report the devices as separate nodes so we can mark one as
+        /*
+         * Report the devices as separate nodes so we can mark one as
          * only visible to the secure world.
          */
         nodename = g_strdup_printf("/secflash@%" PRIx64, flashbase);
@@ -982,6 +986,54 @@ static void create_flash(const VirtMachineState *vms,
     }
 }
 
+static bool virt_firmware_init(VirtMachineState *vms,
+                               MemoryRegion *sysmem,
+                               MemoryRegion *secure_sysmem)
+{
+    int i;
+    BlockBackend *pflash_blk0;
+
+    /* Map legacy -drive if=pflash to machine properties */
+    for (i = 0; i < ARRAY_SIZE(vms->flash); i++) {
+        pflash_cfi01_legacy_drive(vms->flash[i],
+                                  drive_get(IF_PFLASH, 0, i));
+    }
+
+    virt_flash_map(vms, sysmem, secure_sysmem);
+
+    pflash_blk0 = pflash_cfi01_get_blk(vms->flash[0]);
+
+    if (bios_name) {
+        char *fname;
+        MemoryRegion *mr;
+        int image_size;
+
+        if (pflash_blk0) {
+            error_report("The contents of the first flash device may be "
+                         "specified with -bios or with -drive if=pflash... "
+                         "but you cannot use both options at once");
+            exit(1);
+        }
+
+        /* Fall back to -bios */
+
+        fname = qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
+        if (!fname) {
+            error_report("Could not find ROM image '%s'", bios_name);
+            exit(1);
+        }
+        mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(vms->flash[0]), 0);
+        image_size = load_image_mr(fname, mr);
+        g_free(fname);
+        if (image_size < 0) {
+            error_report("Could not load ROM image '%s'", bios_name);
+            exit(1);
+        }
+    }
+
+    return pflash_blk0 || bios_name;
+}
+
 static FWCfgState *create_fw_cfg(const VirtMachineState *vms, AddressSpace *as)
 {
     hwaddr base = vms->memmap[VIRT_FW_CFG].base;
@@ -1421,7 +1473,7 @@ static void machvirt_init(MachineState *machine)
     MemoryRegion *secure_sysmem = NULL;
     int n, virt_max_cpus;
     MemoryRegion *ram = g_new(MemoryRegion, 1);
-    bool firmware_loaded = bios_name || drive_get(IF_PFLASH, 0, 0);
+    bool firmware_loaded;
     bool aarch64 = true;
 
     /*
@@ -1460,6 +1512,27 @@ static void machvirt_init(MachineState *machine)
         exit(1);
     }
 
+    if (vms->secure) {
+        if (kvm_enabled()) {
+            error_report("mach-virt: KVM does not support Security extensions");
+            exit(1);
+        }
+
+        /*
+         * The Secure view of the world is the same as the NonSecure,
+         * but with a few extra devices. Create it as a container region
+         * containing the system memory at low priority; any secure-only
+         * devices go in at higher priority and take precedence.
+         */
+        secure_sysmem = g_new(MemoryRegion, 1);
+        memory_region_init(secure_sysmem, OBJECT(machine), "secure-memory",
+                           UINT64_MAX);
+        memory_region_add_subregion_overlap(secure_sysmem, 0, sysmem, -1);
+    }
+
+    firmware_loaded = virt_firmware_init(vms, sysmem,
+                                         secure_sysmem ?: sysmem);
+
     /* If we have an EL3 boot ROM then the assumption is that it will
      * implement PSCI itself, so disable QEMU's internal implementation
      * so it doesn't get in the way. Instead of starting secondary
@@ -1505,23 +1578,6 @@ static void machvirt_init(MachineState *machine)
         exit(1);
     }
 
-    if (vms->secure) {
-        if (kvm_enabled()) {
-            error_report("mach-virt: KVM does not support Security extensions");
-            exit(1);
-        }
-
-        /* The Secure view of the world is the same as the NonSecure,
-         * but with a few extra devices. Create it as a container region
-         * containing the system memory at low priority; any secure-only
-         * devices go in at higher priority and take precedence.
-         */
-        secure_sysmem = g_new(MemoryRegion, 1);
-        memory_region_init(secure_sysmem, OBJECT(machine), "secure-memory",
-                           UINT64_MAX);
-        memory_region_add_subregion_overlap(secure_sysmem, 0, sysmem, -1);
-    }
-
     create_fdt(vms);
 
     possible_cpus = mc->possible_cpu_arch_ids(machine);
@@ -1610,7 +1666,7 @@ static void machvirt_init(MachineState *machine)
                                     &machine->device_memory->mr);
     }
 
-    create_flash(vms, sysmem, secure_sysmem ? secure_sysmem : sysmem);
+    virt_flash_fdt(vms, sysmem, secure_sysmem);
 
     create_gic(vms, pic);
 
@@ -1956,6 +2012,8 @@ static void virt_instance_init(Object *obj)
                                     NULL);
 
     vms->irqmap = a15irqmap;
+
+    virt_flash_create(vms);
 }
 
 static const TypeInfo virt_machine_info = {
-- 
2.20.1


