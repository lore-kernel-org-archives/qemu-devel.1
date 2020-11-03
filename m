Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2417FC2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 17:35:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CE6821D91
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 17:35:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RDS9bHK7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CE6821D91
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34578 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ka0DC-0005ui-LT
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 12:35:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60454)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ka09m-0001UG-R2; Tue, 03 Nov 2020 12:31:42 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f]:34063)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ka09h-0007bB-CO; Tue, 03 Nov 2020 12:31:41 -0500
Received: by mail-wm1-x32f.google.com with SMTP id 23so354937wmg.1;
 Tue, 03 Nov 2020 09:31:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+hIf3eZWVLUuPvUK+JvEYw3IeK+GL5CZY+UJFkfdKak=;
 b=RDS9bHK755AAjOa913VZXj+0Y0ZgCSO0CZBQhSbRAozhcUDX2V87G4pADClN4xNOTv
 I+EV/1aDXWmwEvU1GGzO58N8H8m0EIHQMkkgK5U8K6WlY7Ner7UXv5URJDsbK6NZCrCL
 M++0mUUjdJObsQ2KPuJC7mbtn394ehNg6n3rcKjEioOkMoBeJ7SQ5b6oyzdY/nEa7+VJ
 SImYrk45NzebYCsLTUuilwP0ztAMz0qQeq48psLMj6RcLkwdvJf7N2wNLYZFDvYJYeyk
 AvEcIRscN5LYaI0ChJWGcv0Olge3UNOsI1uDAHg9VbzWkAEiZ21+QNUsGah0gYl8k+AZ
 yQyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=+hIf3eZWVLUuPvUK+JvEYw3IeK+GL5CZY+UJFkfdKak=;
 b=eP9jolI1sD7aaz0Tf+sZYXJUutl4Il5zJyAWtsFVRFX4VGbZybEc1yfTTSfMuXeTa1
 +o5VZD8WwQbMsNSAtRsk3NvhCJTVg6KOTLVmY55zOoVqERpRncs1Aej6zeLbHLnnjCvy
 fmpa9tZqyJD48Owm5gJGPH1mxkdbtfkP5/6iF3CPHRUCJX7kggsYYZlyP+Ah3u8RWJ/f
 MXM0NMYb2NfX/n4LhZS3PX7ghQ+3CJitUfm7KFIThSx6OVYMX4+ZHGYl/sDy1H4T0HD6
 s1im/Oo0s93alYAuNacIsbsSoXhXYkt5eE4zWhfh4LyG6WVrzmxKQJERwfmHnL+ZTnKT
 YgHQ==
X-Gm-Message-State: AOAM531jM/e/yibHjfYy6I0DMjQOwsVVgFkrXRCOdAquVNiQL4uoJ7e9
 aLfIkTpWrkFeS7q4ekG7bC2EettzAbg=
X-Google-Smtp-Source: ABdhPJz0QIO2VboMehLgOmAvzOCgyqtgSqmU2Bt/s7hWh2LjZ9oyDY4GKpkZK5yzKk2/m8p/M0KGug==
X-Received: by 2002:a1c:81c9:: with SMTP id c192mr221409wmd.1.1604424695048;
 Tue, 03 Nov 2020 09:31:35 -0800 (PST)
Received: from x1w.redhat.com (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id b7sm25997762wrp.16.2020.11.03.09.31.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2020 09:31:34 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 1/6] hw/mips: Remove the 'r4k' machine
Date: Tue,  3 Nov 2020 18:31:22 +0100
Message-Id: <20201103173127.2704256-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201103173127.2704256-1-f4bug@amsat.org>
References: <20201103173127.2704256-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x32f.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Peter Krempa <pkrempa@redhat.com>, qemu-block@nongnu.org,
 Paul Burton <paulburton@kernel.org>, libvir-list@redhat.com,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Huacai Chen <chenhc@lemote.com>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We deprecated the support for the 'r4k' machine for the 5.0 release
(commit d32dc61421), which means that our deprecation policy allows
us to drop it in release 5.2. Remove the code.

To repeat the rationale from the deprecation note:
- this virtual machine has no specification
- the Linux kernel dropped support for it 10 years ago

Users are recommended to use the Malta board instead.

Acked-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
ACKed-by: Peter Krempa <pkrempa@redhat.com>
Message-Id: <20201102201311.2220005-1-f4bug@amsat.org>
---
 docs/system/deprecated.rst                    |  12 +-
 .../devices/mips-softmmu-common.mak           |   1 -
 hw/mips/r4k.c                                 | 318 ------------------
 tests/qtest/cdrom-test.c                      |   2 +-
 tests/qtest/endianness-test.c                 |   2 -
 MAINTAINERS                                   |   6 -
 hw/mips/Kconfig                               |  13 -
 hw/mips/meson.build                           |   1 -
 8 files changed, 7 insertions(+), 348 deletions(-)
 delete mode 100644 hw/mips/r4k.c

diff --git a/docs/system/deprecated.rst b/docs/system/deprecated.rst
index 32a0e620dbb..8c1dc7645d7 100644
--- a/docs/system/deprecated.rst
+++ b/docs/system/deprecated.rst
@@ -328,12 +328,6 @@ The 'scsi-disk' device is deprecated. Users should use 'scsi-hd' or
 System emulator machines
 ------------------------
 
-mips ``r4k`` platform (since 5.0)
-'''''''''''''''''''''''''''''''''
-
-This machine type is very old and unmaintained. Users should use the ``malta``
-machine type instead.
-
 mips ``fulong2e`` machine (since 5.1)
 '''''''''''''''''''''''''''''''''''''
 
@@ -576,6 +570,12 @@ The version specific Spike machines have been removed in favour of the
 generic ``spike`` machine. If you need to specify an older version of the RISC-V
 spec you can use the ``-cpu rv64gcsu,priv_spec=v1.10.0`` command line argument.
 
+mips ``r4k`` platform (removed in 5.2)
+''''''''''''''''''''''''''''''''''''''
+
+This machine type was very old and unmaintained. Users should use the ``malta``
+machine type instead.
+
 Related binaries
 ----------------
 
diff --git a/default-configs/devices/mips-softmmu-common.mak b/default-configs/devices/mips-softmmu-common.mak
index da29c6c0b24..ea78fe72759 100644
--- a/default-configs/devices/mips-softmmu-common.mak
+++ b/default-configs/devices/mips-softmmu-common.mak
@@ -33,7 +33,6 @@ CONFIG_MC146818RTC=y
 CONFIG_EMPTY_SLOT=y
 CONFIG_MIPS_CPS=y
 CONFIG_MIPS_ITU=y
-CONFIG_R4K=y
 CONFIG_MALTA=y
 CONFIG_PCNET_PCI=y
 CONFIG_MIPSSIM=y
diff --git a/hw/mips/r4k.c b/hw/mips/r4k.c
deleted file mode 100644
index 38308543421..00000000000
--- a/hw/mips/r4k.c
+++ /dev/null
@@ -1,318 +0,0 @@
-/*
- * QEMU/MIPS pseudo-board
- *
- * emulates a simple machine with ISA-like bus.
- * ISA IO space mapped to the 0x14000000 (PHYS) and
- * ISA memory at the 0x10000000 (PHYS, 16Mb in size).
- * All peripherial devices are attached to this "bus" with
- * the standard PC ISA addresses.
- */
-
-#include "qemu/osdep.h"
-#include "qemu/units.h"
-#include "qapi/error.h"
-#include "qemu-common.h"
-#include "cpu.h"
-#include "hw/clock.h"
-#include "hw/mips/mips.h"
-#include "hw/mips/cpudevs.h"
-#include "hw/intc/i8259.h"
-#include "hw/char/serial.h"
-#include "hw/isa/isa.h"
-#include "net/net.h"
-#include "hw/net/ne2000-isa.h"
-#include "sysemu/sysemu.h"
-#include "hw/boards.h"
-#include "hw/block/flash.h"
-#include "qemu/log.h"
-#include "hw/mips/bios.h"
-#include "hw/ide.h"
-#include "hw/ide/internal.h"
-#include "hw/loader.h"
-#include "elf.h"
-#include "hw/rtc/mc146818rtc.h"
-#include "hw/input/i8042.h"
-#include "hw/timer/i8254.h"
-#include "exec/address-spaces.h"
-#include "sysemu/qtest.h"
-#include "sysemu/reset.h"
-#include "sysemu/runstate.h"
-#include "qemu/error-report.h"
-
-#define MAX_IDE_BUS 2
-
-static const int ide_iobase[2] = { 0x1f0, 0x170 };
-static const int ide_iobase2[2] = { 0x3f6, 0x376 };
-static const int ide_irq[2] = { 14, 15 };
-
-static ISADevice *pit; /* PIT i8254 */
-
-/* i8254 PIT is attached to the IRQ0 at PIC i8259 */
-
-static struct _loaderparams {
-    int ram_size;
-    const char *kernel_filename;
-    const char *kernel_cmdline;
-    const char *initrd_filename;
-} loaderparams;
-
-static void mips_qemu_write(void *opaque, hwaddr addr,
-                            uint64_t val, unsigned size)
-{
-    if ((addr & 0xffff) == 0 && val == 42) {
-        qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
-    } else if ((addr & 0xffff) == 4 && val == 42) {
-        qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
-    }
-}
-
-static uint64_t mips_qemu_read(void *opaque, hwaddr addr,
-                               unsigned size)
-{
-    return 0;
-}
-
-static const MemoryRegionOps mips_qemu_ops = {
-    .read = mips_qemu_read,
-    .write = mips_qemu_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
-};
-
-typedef struct ResetData {
-    MIPSCPU *cpu;
-    uint64_t vector;
-} ResetData;
-
-static int64_t load_kernel(void)
-{
-    const size_t params_size = 264;
-    int64_t entry, kernel_high, initrd_size;
-    long kernel_size;
-    ram_addr_t initrd_offset;
-    uint32_t *params_buf;
-    int big_endian;
-
-#ifdef TARGET_WORDS_BIGENDIAN
-    big_endian = 1;
-#else
-    big_endian = 0;
-#endif
-    kernel_size = load_elf(loaderparams.kernel_filename, NULL,
-                           cpu_mips_kseg0_to_phys, NULL,
-                           (uint64_t *)&entry, NULL,
-                           (uint64_t *)&kernel_high, NULL, big_endian,
-                           EM_MIPS, 1, 0);
-    if (kernel_size < 0) {
-        error_report("could not load kernel '%s': %s",
-                     loaderparams.kernel_filename,
-                     load_elf_strerror(kernel_size));
-        exit(1);
-    }
-
-    /* load initrd */
-    initrd_size = 0;
-    initrd_offset = 0;
-    if (loaderparams.initrd_filename) {
-        initrd_size = get_image_size(loaderparams.initrd_filename);
-        if (initrd_size > 0) {
-            initrd_offset = ROUND_UP(kernel_high, INITRD_PAGE_SIZE);
-            if (initrd_offset + initrd_size > ram_size) {
-                error_report("memory too small for initial ram disk '%s'",
-                             loaderparams.initrd_filename);
-                exit(1);
-            }
-            initrd_size = load_image_targphys(loaderparams.initrd_filename,
-                                              initrd_offset,
-                                              ram_size - initrd_offset);
-        }
-        if (initrd_size == (target_ulong) -1) {
-            error_report("could not load initial ram disk '%s'",
-                         loaderparams.initrd_filename);
-            exit(1);
-        }
-    }
-
-    /* Store command line.  */
-    params_buf = g_malloc(params_size);
-
-    params_buf[0] = tswap32(ram_size);
-    params_buf[1] = tswap32(0x12345678);
-
-    if (initrd_size > 0) {
-        snprintf((char *)params_buf + 8, 256,
-                 "rd_start=0x%" PRIx64 " rd_size=%" PRId64 " %s",
-                 cpu_mips_phys_to_kseg0(NULL, initrd_offset),
-                 initrd_size, loaderparams.kernel_cmdline);
-    } else {
-        snprintf((char *)params_buf + 8, 256,
-        "%s", loaderparams.kernel_cmdline);
-    }
-
-    rom_add_blob_fixed("params", params_buf, params_size,
-                       16 * MiB - params_size);
-
-    g_free(params_buf);
-    return entry;
-}
-
-static void main_cpu_reset(void *opaque)
-{
-    ResetData *s = (ResetData *)opaque;
-    CPUMIPSState *env = &s->cpu->env;
-
-    cpu_reset(CPU(s->cpu));
-    env->active_tc.PC = s->vector;
-}
-
-static const int sector_len = 32 * KiB;
-static
-void mips_r4k_init(MachineState *machine)
-{
-    const char *kernel_filename = machine->kernel_filename;
-    const char *kernel_cmdline = machine->kernel_cmdline;
-    const char *initrd_filename = machine->initrd_filename;
-    char *filename;
-    MemoryRegion *address_space_mem = get_system_memory();
-    MemoryRegion *bios;
-    MemoryRegion *iomem = g_new(MemoryRegion, 1);
-    MemoryRegion *isa_io = g_new(MemoryRegion, 1);
-    MemoryRegion *isa_mem = g_new(MemoryRegion, 1);
-    int bios_size;
-    Clock *cpuclk;
-    MIPSCPU *cpu;
-    CPUMIPSState *env;
-    ResetData *reset_info;
-    int i;
-    qemu_irq *i8259;
-    ISABus *isa_bus;
-    DriveInfo *hd[MAX_IDE_BUS * MAX_IDE_DEVS];
-    DriveInfo *dinfo;
-    int be;
-
-    cpuclk = clock_new(OBJECT(machine), "cpu-refclk");
-    clock_set_hz(cpuclk, 200000000); /* 200 MHz */
-
-    /* init CPUs */
-    cpu = mips_cpu_create_with_clock(machine->cpu_type, cpuclk);
-    env = &cpu->env;
-
-    reset_info = g_malloc0(sizeof(ResetData));
-    reset_info->cpu = cpu;
-    reset_info->vector = env->active_tc.PC;
-    qemu_register_reset(main_cpu_reset, reset_info);
-
-    /* allocate RAM */
-    if (machine->ram_size > 256 * MiB) {
-        error_report("Too much memory for this machine: %" PRId64 "MB,"
-                     " maximum 256MB", ram_size / MiB);
-        exit(1);
-    }
-    memory_region_add_subregion(address_space_mem, 0, machine->ram);
-
-    memory_region_init_io(iomem, NULL, &mips_qemu_ops,
-                          NULL, "mips-qemu", 0x10000);
-
-    memory_region_add_subregion(address_space_mem, 0x1fbf0000, iomem);
-
-    /*
-     * Try to load a BIOS image. If this fails, we continue regardless,
-     * but initialize the hardware ourselves. When a kernel gets
-     * preloaded we also initialize the hardware, since the BIOS wasn't
-     * run.
-     */
-
-    if (bios_name == NULL) {
-        bios_name = BIOS_FILENAME;
-    }
-    filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
-    if (filename) {
-        bios_size = get_image_size(filename);
-    } else {
-        bios_size = -1;
-    }
-#ifdef TARGET_WORDS_BIGENDIAN
-    be = 1;
-#else
-    be = 0;
-#endif
-    dinfo = drive_get(IF_PFLASH, 0, 0);
-    if ((bios_size > 0) && (bios_size <= BIOS_SIZE)) {
-        bios = g_new(MemoryRegion, 1);
-        memory_region_init_rom(bios, NULL, "mips_r4k.bios", BIOS_SIZE,
-                               &error_fatal);
-        memory_region_add_subregion(get_system_memory(), 0x1fc00000, bios);
-
-        load_image_targphys(filename, 0x1fc00000, BIOS_SIZE);
-    } else if (dinfo != NULL) {
-        uint32_t mips_rom = 0x00400000;
-        if (!pflash_cfi01_register(0x1fc00000, "mips_r4k.bios", mips_rom,
-                                   blk_by_legacy_dinfo(dinfo),
-                                   sector_len, 4, 0, 0, 0, 0, be)) {
-            fprintf(stderr, "qemu: Error registering flash memory.\n");
-        }
-    } else if (!qtest_enabled()) {
-        /* not fatal */
-        warn_report("could not load MIPS bios '%s'", bios_name);
-    }
-    g_free(filename);
-
-    if (kernel_filename) {
-        loaderparams.ram_size = machine->ram_size;
-        loaderparams.kernel_filename = kernel_filename;
-        loaderparams.kernel_cmdline = kernel_cmdline;
-        loaderparams.initrd_filename = initrd_filename;
-        reset_info->vector = load_kernel();
-    }
-
-    /* Init CPU internal devices */
-    cpu_mips_irq_init_cpu(cpu);
-    cpu_mips_clock_init(cpu);
-
-    /* ISA bus: IO space at 0x14000000, mem space at 0x10000000 */
-    memory_region_init_alias(isa_io, NULL, "isa-io",
-                             get_system_io(), 0, 0x00010000);
-    memory_region_init(isa_mem, NULL, "isa-mem", 0x01000000);
-    memory_region_add_subregion(get_system_memory(), 0x14000000, isa_io);
-    memory_region_add_subregion(get_system_memory(), 0x10000000, isa_mem);
-    isa_bus = isa_bus_new(NULL, isa_mem, get_system_io(), &error_abort);
-
-    /* The PIC is attached to the MIPS CPU INT0 pin */
-    i8259 = i8259_init(isa_bus, env->irq[2]);
-    isa_bus_irqs(isa_bus, i8259);
-
-    mc146818_rtc_init(isa_bus, 2000, NULL);
-
-    pit = i8254_pit_init(isa_bus, 0x40, 0, NULL);
-
-    serial_hds_isa_init(isa_bus, 0, MAX_ISA_SERIAL_PORTS);
-
-    isa_vga_init(isa_bus);
-
-    if (nd_table[0].used) {
-        isa_ne2000_init(isa_bus, 0x300, 9, &nd_table[0]);
-    }
-
-    ide_drive_get(hd, ARRAY_SIZE(hd));
-    for (i = 0; i < MAX_IDE_BUS; i++)
-        isa_ide_init(isa_bus, ide_iobase[i], ide_iobase2[i], ide_irq[i],
-                     hd[MAX_IDE_DEVS * i],
-                     hd[MAX_IDE_DEVS * i + 1]);
-
-    isa_create_simple(isa_bus, TYPE_I8042);
-}
-
-static void mips_machine_init(MachineClass *mc)
-{
-    mc->deprecation_reason = "use malta machine type instead";
-    mc->desc = "mips r4k platform";
-    mc->init = mips_r4k_init;
-    mc->block_default_type = IF_IDE;
-#ifdef TARGET_MIPS64
-    mc->default_cpu_type = MIPS_CPU_TYPE_NAME("R4000");
-#else
-    mc->default_cpu_type = MIPS_CPU_TYPE_NAME("24Kf");
-#endif
-    mc->default_ram_id = "mips_r4k.ram";
-}
-
-DEFINE_MACHINE("mips", mips_machine_init)
diff --git a/tests/qtest/cdrom-test.c b/tests/qtest/cdrom-test.c
index eef242dc80c..5af944a5fb7 100644
--- a/tests/qtest/cdrom-test.c
+++ b/tests/qtest/cdrom-test.c
@@ -217,7 +217,7 @@ int main(int argc, char **argv)
         add_cdrom_param_tests(sparc64machines);
     } else if (!strncmp(arch, "mips64", 6)) {
         const char *mips64machines[] = {
-            "magnum", "malta", "mips", "pica61", NULL
+            "magnum", "malta", "pica61", NULL
         };
         add_cdrom_param_tests(mips64machines);
     } else if (g_str_equal(arch, "arm") || g_str_equal(arch, "aarch64")) {
diff --git a/tests/qtest/endianness-test.c b/tests/qtest/endianness-test.c
index 4e79e22c28c..09ecb531f11 100644
--- a/tests/qtest/endianness-test.c
+++ b/tests/qtest/endianness-test.c
@@ -27,11 +27,9 @@ struct TestCase {
 
 static const TestCase test_cases[] = {
     { "i386", "pc", -1 },
-    { "mips", "mips", 0x14000000, .bswap = true },
     { "mips", "malta", 0x10000000, .bswap = true },
     { "mips64", "magnum", 0x90000000, .bswap = true },
     { "mips64", "pica61", 0x90000000, .bswap = true },
-    { "mips64", "mips", 0x14000000, .bswap = true },
     { "mips64", "malta", 0x10000000, .bswap = true },
     { "mips64el", "fuloong2e", 0x1fd00000 },
     { "ppc", "g3beige", 0xfe000000, .bswap = true, .superio = "i82378" },
diff --git a/MAINTAINERS b/MAINTAINERS
index c1d16026baf..8a2c2041521 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1138,12 +1138,6 @@ S: Orphaned
 F: hw/mips/mipssim.c
 F: hw/net/mipsnet.c
 
-R4000
-R: Aurelien Jarno <aurelien@aurel32.net>
-R: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
-S: Obsolete
-F: hw/mips/r4k.c
-
 Fuloong 2E
 M: Huacai Chen <chenhc@lemote.com>
 M: Philippe Mathieu-Daudé <f4bug@amsat.org>
diff --git a/hw/mips/Kconfig b/hw/mips/Kconfig
index 67d39c56a4e..8be70122f4c 100644
--- a/hw/mips/Kconfig
+++ b/hw/mips/Kconfig
@@ -1,16 +1,3 @@
-config R4K
-    bool
-    select ISA_BUS
-    select SERIAL_ISA
-    select I8259
-    select I8254
-    select MC146818RTC
-    imply VGA_ISA
-    imply NE2000_ISA
-    select IDE_ISA
-    select PCKBD
-    select PFLASH_CFI01
-
 config MALTA
     bool
     select ISA_SUPERIO
diff --git a/hw/mips/meson.build b/hw/mips/meson.build
index 46294b7382f..bcdf96be69f 100644
--- a/hw/mips/meson.build
+++ b/hw/mips/meson.build
@@ -6,6 +6,5 @@
 mips_ss.add(when: 'CONFIG_MIPSSIM', if_true: files('mipssim.c'))
 mips_ss.add(when: 'CONFIG_MIPS_BOSTON', if_true: [files('boston.c'), fdt])
 mips_ss.add(when: 'CONFIG_MIPS_CPS', if_true: files('cps.c'))
-mips_ss.add(when: 'CONFIG_R4K', if_true: files('r4k.c'))
 
 hw_arch += {'mips': mips_ss}
-- 
2.26.2


