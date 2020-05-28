Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92DC7C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 22:34:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48D87208B8
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 22:34:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="FFJk/WWQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48D87208B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44464 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeR6b-0002t7-Ed
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 18:34:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47006)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4104b2603=alistair.francis@wdc.com>)
 id 1jeQxN-0005P8-0O; Thu, 28 May 2020 18:24:58 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:17153)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4104b2603=alistair.francis@wdc.com>)
 id 1jeQxD-0008AD-NU; Thu, 28 May 2020 18:24:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1590704687; x=1622240687;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=XRfgytYTyR08nkfffQ++DnxIYSd95DyOzyU+qaA7vEI=;
 b=FFJk/WWQDC98+blzOgS7EpwY14d7fDQdEmAwLXGc+RYc1exT8jbkjAdv
 WuO4pJYjnxoh/dc+ttD+7p4ouX8mfjOj3y843I/OfA9U2jo286SuWQzLC
 jpPHJxYh2vo7xSM2ymn/SUW+hDmxOYDt3rXCNIxlFw8A8zAY1KborhR+a
 EdiTL8zz7PORtZcIewbdPvDrcoYbSeYf7c7AXUXsAIhsCWJSVCLByHU1W
 DSK5YmD2n9kJ7Y3TU7/qScVXu3kp3/FJgBKMi6SfSGzkj29X4UjbHfgC6
 atm35biZnJBwx0b0E9K/ia4U0932zxv+yUg6b1IckIVWTHBELi5iizSib w==;
IronPort-SDR: sAGEPwC9iKvBJFQUez0Q2AjgXMgEqmLwwsdGFGMxm4ns9hTIpQjWOGt1NGmqZunPLNuuq3lio7
 YYvwQU4RatT9TeIrFi6/zjtjIN8IkXuft7LQa3x1WFiJ5jj8FCzfQiuu5zCvnZ9D+RCDN+Y3NB
 GMtZAlPr8tcii7H1GGTzMT8CAe01TbzI5URMySH/cOzvxiI2aRXq8jQIiYT4+v0NrCobb86qqr
 2GawJzaQXNnjkj+wFlPDeH6BIDnK5HXP65IssiCmpqa0K8ghqwbRuhHE4jmsNWyHHveBm+dXz2
 sVc=
X-IronPort-AV: E=Sophos;i="5.73,446,1583164800"; d="scan'208";a="247810977"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 29 May 2020 06:24:44 +0800
IronPort-SDR: Ok52Fi4TUMkIyN1LcEyW4l1mhcOHNpOG+Dh9qQsAWVzcN+eihKTU5eAPMLpZ99ydcuxOw6GCDH
 46pCVlIG2Hwv7zlDALdqDeOsnQUPaWZP0=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 May 2020 15:13:59 -0700
IronPort-SDR: A3pyHwMkr9vruLjJ8kK5mgXAnEkCIVArmLvX2RCFjna6vPXQsVg2AzaEVcLAtbpcllzW5odYy6
 ec1FlGOXWaEg==
WDCIronportException: Internal
Received: from 6xf7cg2.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.57.123])
 by uls-op-cesaip02.wdc.com with ESMTP; 28 May 2020 15:24:44 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v4 1/4] hw/riscv: spike: Remove deprecated ISA specific
 machines
Date: Thu, 28 May 2020 15:16:08 -0700
Message-Id: <bf556e99b3e7cc1b5388641117858e11b147f9b3.1590704110.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1590704110.git.alistair.francis@wdc.com>
References: <cover.1590704110.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=68.232.141.245;
 envelope-from=prvs=4104b2603=alistair.francis@wdc.com;
 helo=esa1.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 18:24:44
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: alistair.francis@wdc.com, bmeng.cn@gmail.com, palmer@dabbelt.com,
 alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The ISA specific Spike machines have been deprecated in QEMU since 4.1,
let's finally remove them.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Bin Meng <bin.meng@windriver.com>
---
 docs/system/deprecated.rst |  17 +--
 include/hw/riscv/spike.h   |   6 +-
 hw/riscv/spike.c           | 217 -------------------------------------
 3 files changed, 12 insertions(+), 228 deletions(-)

diff --git a/docs/system/deprecated.rst b/docs/system/deprecated.rst
index f0061f94aa..50927bad74 100644
--- a/docs/system/deprecated.rst
+++ b/docs/system/deprecated.rst
@@ -379,13 +379,6 @@ This machine has been renamed ``fuloong2e``.
 These machine types are very old and likely can not be used for live migration
 from old QEMU versions anymore. A newer machine type should be used instead.
 
-``spike_v1.9.1`` and ``spike_v1.10`` (since 4.1)
-''''''''''''''''''''''''''''''''''''''''''''''''
-
-The version specific Spike machines have been deprecated in favour of the
-generic ``spike`` machine. If you need to specify an older version of the RISC-V
-spec you can use the ``-cpu rv64gcsu,priv_spec=v1.9.1`` command line argument.
-
 Device options
 --------------
 
@@ -493,6 +486,16 @@ The ``hub_id`` parameter of ``hostfwd_add`` / ``hostfwd_remove`` (removed in 5.0
 The ``[hub_id name]`` parameter tuple of the 'hostfwd_add' and
 'hostfwd_remove' HMP commands has been replaced by ``netdev_id``.
 
+System emulator machines
+------------------------
+
+``spike_v1.9.1`` and ``spike_v1.10`` (removed in 5.1)
+'''''''''''''''''''''''''''''''''''''''''''''''''''''
+
+The version specific Spike machines have been removed in favour of the
+generic ``spike`` machine. If you need to specify an older version of the RISC-V
+spec you can use the ``-cpu rv64gcsu,priv_spec=v1.10.0`` command line argument.
+
 Related binaries
 ----------------
 
diff --git a/include/hw/riscv/spike.h b/include/hw/riscv/spike.h
index dc770421bc..1cd72b85d6 100644
--- a/include/hw/riscv/spike.h
+++ b/include/hw/riscv/spike.h
@@ -39,11 +39,9 @@ enum {
 };
 
 #if defined(TARGET_RISCV32)
-#define SPIKE_V1_09_1_CPU TYPE_RISCV_CPU_RV32GCSU_V1_09_1
-#define SPIKE_V1_10_0_CPU TYPE_RISCV_CPU_RV32GCSU_V1_10_0
+#define SPIKE_V1_10_0_CPU TYPE_RISCV_CPU_BASE32
 #elif defined(TARGET_RISCV64)
-#define SPIKE_V1_09_1_CPU TYPE_RISCV_CPU_RV64GCSU_V1_09_1
-#define SPIKE_V1_10_0_CPU TYPE_RISCV_CPU_RV64GCSU_V1_10_0
+#define SPIKE_V1_10_0_CPU TYPE_RISCV_CPU_BASE64
 #endif
 
 #endif
diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
index d0c4843712..7bbbdb5036 100644
--- a/hw/riscv/spike.c
+++ b/hw/riscv/spike.c
@@ -257,221 +257,6 @@ static void spike_board_init(MachineState *machine)
         false);
 }
 
-static void spike_v1_10_0_board_init(MachineState *machine)
-{
-    const struct MemmapEntry *memmap = spike_memmap;
-
-    SpikeState *s = g_new0(SpikeState, 1);
-    MemoryRegion *system_memory = get_system_memory();
-    MemoryRegion *main_mem = g_new(MemoryRegion, 1);
-    MemoryRegion *mask_rom = g_new(MemoryRegion, 1);
-    int i;
-    unsigned int smp_cpus = machine->smp.cpus;
-
-    if (!qtest_enabled()) {
-        info_report("The Spike v1.10.0 machine has been deprecated. "
-                    "Please use the generic spike machine and specify the ISA "
-                    "versions using -cpu.");
-    }
-
-    /* Initialize SOC */
-    object_initialize_child(OBJECT(machine), "soc", &s->soc, sizeof(s->soc),
-                            TYPE_RISCV_HART_ARRAY, &error_abort, NULL);
-    object_property_set_str(OBJECT(&s->soc), SPIKE_V1_10_0_CPU, "cpu-type",
-                            &error_abort);
-    object_property_set_int(OBJECT(&s->soc), smp_cpus, "num-harts",
-                            &error_abort);
-    object_property_set_bool(OBJECT(&s->soc), true, "realized",
-                            &error_abort);
-
-    /* register system main memory (actual RAM) */
-    memory_region_init_ram(main_mem, NULL, "riscv.spike.ram",
-                           machine->ram_size, &error_fatal);
-    memory_region_add_subregion(system_memory, memmap[SPIKE_DRAM].base,
-        main_mem);
-
-    /* create device tree */
-    create_fdt(s, memmap, machine->ram_size, machine->kernel_cmdline);
-
-    /* boot rom */
-    memory_region_init_rom(mask_rom, NULL, "riscv.spike.mrom",
-                           memmap[SPIKE_MROM].size, &error_fatal);
-    memory_region_add_subregion(system_memory, memmap[SPIKE_MROM].base,
-                                mask_rom);
-
-    if (machine->kernel_filename) {
-        riscv_load_kernel(machine->kernel_filename, htif_symbol_callback);
-    }
-
-    /* reset vector */
-    uint32_t reset_vec[8] = {
-        0x00000297,                  /* 1:  auipc  t0, %pcrel_hi(dtb) */
-        0x02028593,                  /*     addi   a1, t0, %pcrel_lo(1b) */
-        0xf1402573,                  /*     csrr   a0, mhartid  */
-#if defined(TARGET_RISCV32)
-        0x0182a283,                  /*     lw     t0, 24(t0) */
-#elif defined(TARGET_RISCV64)
-        0x0182b283,                  /*     ld     t0, 24(t0) */
-#endif
-        0x00028067,                  /*     jr     t0 */
-        0x00000000,
-        memmap[SPIKE_DRAM].base,     /* start: .dword DRAM_BASE */
-        0x00000000,
-                                     /* dtb: */
-    };
-
-    /* copy in the reset vector in little_endian byte order */
-    for (i = 0; i < sizeof(reset_vec) >> 2; i++) {
-        reset_vec[i] = cpu_to_le32(reset_vec[i]);
-    }
-    rom_add_blob_fixed_as("mrom.reset", reset_vec, sizeof(reset_vec),
-                          memmap[SPIKE_MROM].base, &address_space_memory);
-
-    /* copy in the device tree */
-    if (fdt_pack(s->fdt) || fdt_totalsize(s->fdt) >
-            memmap[SPIKE_MROM].size - sizeof(reset_vec)) {
-        error_report("not enough space to store device-tree");
-        exit(1);
-    }
-    qemu_fdt_dumpdtb(s->fdt, fdt_totalsize(s->fdt));
-    rom_add_blob_fixed_as("mrom.fdt", s->fdt, fdt_totalsize(s->fdt),
-                          memmap[SPIKE_MROM].base + sizeof(reset_vec),
-                          &address_space_memory);
-
-    /* initialize HTIF using symbols found in load_kernel */
-    htif_mm_init(system_memory, mask_rom, &s->soc.harts[0].env, serial_hd(0));
-
-    /* Core Local Interruptor (timer and IPI) */
-    sifive_clint_create(memmap[SPIKE_CLINT].base, memmap[SPIKE_CLINT].size,
-        smp_cpus, SIFIVE_SIP_BASE, SIFIVE_TIMECMP_BASE, SIFIVE_TIME_BASE,
-        false);
-}
-
-static void spike_v1_09_1_board_init(MachineState *machine)
-{
-    const struct MemmapEntry *memmap = spike_memmap;
-
-    SpikeState *s = g_new0(SpikeState, 1);
-    MemoryRegion *system_memory = get_system_memory();
-    MemoryRegion *main_mem = g_new(MemoryRegion, 1);
-    MemoryRegion *mask_rom = g_new(MemoryRegion, 1);
-    int i;
-    unsigned int smp_cpus = machine->smp.cpus;
-
-    if (!qtest_enabled()) {
-        info_report("The Spike v1.09.1 machine has been deprecated. "
-                    "Please use the generic spike machine and specify the ISA "
-                    "versions using -cpu.");
-    }
-
-    /* Initialize SOC */
-    object_initialize_child(OBJECT(machine), "soc", &s->soc, sizeof(s->soc),
-                            TYPE_RISCV_HART_ARRAY, &error_abort, NULL);
-    object_property_set_str(OBJECT(&s->soc), SPIKE_V1_09_1_CPU, "cpu-type",
-                            &error_abort);
-    object_property_set_int(OBJECT(&s->soc), smp_cpus, "num-harts",
-                            &error_abort);
-    object_property_set_bool(OBJECT(&s->soc), true, "realized",
-                            &error_abort);
-
-    /* register system main memory (actual RAM) */
-    memory_region_init_ram(main_mem, NULL, "riscv.spike.ram",
-                           machine->ram_size, &error_fatal);
-    memory_region_add_subregion(system_memory, memmap[SPIKE_DRAM].base,
-        main_mem);
-
-    /* boot rom */
-    memory_region_init_rom(mask_rom, NULL, "riscv.spike.mrom",
-                           memmap[SPIKE_MROM].size, &error_fatal);
-    memory_region_add_subregion(system_memory, memmap[SPIKE_MROM].base,
-                                mask_rom);
-
-    if (machine->kernel_filename) {
-        riscv_load_kernel(machine->kernel_filename, htif_symbol_callback);
-    }
-
-    /* reset vector */
-    uint32_t reset_vec[8] = {
-        0x297 + memmap[SPIKE_DRAM].base - memmap[SPIKE_MROM].base, /* lui */
-        0x00028067,                   /* jump to DRAM_BASE */
-        0x00000000,                   /* reserved */
-        memmap[SPIKE_MROM].base + sizeof(reset_vec), /* config string pointer */
-        0, 0, 0, 0                    /* trap vector */
-    };
-
-    /* part one of config string - before memory size specified */
-    const char *config_string_tmpl =
-        "platform {\n"
-        "  vendor ucb;\n"
-        "  arch spike;\n"
-        "};\n"
-        "rtc {\n"
-        "  addr 0x%" PRIx64 "x;\n"
-        "};\n"
-        "ram {\n"
-        "  0 {\n"
-        "    addr 0x%" PRIx64 "x;\n"
-        "    size 0x%" PRIx64 "x;\n"
-        "  };\n"
-        "};\n"
-        "core {\n"
-        "  0" " {\n"
-        "    " "0 {\n"
-        "      isa %s;\n"
-        "      timecmp 0x%" PRIx64 "x;\n"
-        "      ipi 0x%" PRIx64 "x;\n"
-        "    };\n"
-        "  };\n"
-        "};\n";
-
-    /* build config string with supplied memory size */
-    char *isa = riscv_isa_string(&s->soc.harts[0]);
-    char *config_string = g_strdup_printf(config_string_tmpl,
-        (uint64_t)memmap[SPIKE_CLINT].base + SIFIVE_TIME_BASE,
-        (uint64_t)memmap[SPIKE_DRAM].base,
-        (uint64_t)ram_size, isa,
-        (uint64_t)memmap[SPIKE_CLINT].base + SIFIVE_TIMECMP_BASE,
-        (uint64_t)memmap[SPIKE_CLINT].base + SIFIVE_SIP_BASE);
-    g_free(isa);
-    size_t config_string_len = strlen(config_string);
-
-    /* copy in the reset vector in little_endian byte order */
-    for (i = 0; i < sizeof(reset_vec) >> 2; i++) {
-        reset_vec[i] = cpu_to_le32(reset_vec[i]);
-    }
-    rom_add_blob_fixed_as("mrom.reset", reset_vec, sizeof(reset_vec),
-                          memmap[SPIKE_MROM].base, &address_space_memory);
-
-    /* copy in the config string */
-    rom_add_blob_fixed_as("mrom.reset", config_string, config_string_len,
-                          memmap[SPIKE_MROM].base + sizeof(reset_vec),
-                          &address_space_memory);
-
-    /* initialize HTIF using symbols found in load_kernel */
-    htif_mm_init(system_memory, mask_rom, &s->soc.harts[0].env, serial_hd(0));
-
-    /* Core Local Interruptor (timer and IPI) */
-    sifive_clint_create(memmap[SPIKE_CLINT].base, memmap[SPIKE_CLINT].size,
-        smp_cpus, SIFIVE_SIP_BASE, SIFIVE_TIMECMP_BASE, SIFIVE_TIME_BASE,
-        false);
-
-    g_free(config_string);
-}
-
-static void spike_v1_09_1_machine_init(MachineClass *mc)
-{
-    mc->desc = "RISC-V Spike Board (Privileged ISA v1.9.1)";
-    mc->init = spike_v1_09_1_board_init;
-    mc->max_cpus = 1;
-}
-
-static void spike_v1_10_0_machine_init(MachineClass *mc)
-{
-    mc->desc = "RISC-V Spike Board (Privileged ISA v1.10)";
-    mc->init = spike_v1_10_0_board_init;
-    mc->max_cpus = 1;
-}
-
 static void spike_machine_init(MachineClass *mc)
 {
     mc->desc = "RISC-V Spike Board";
@@ -481,6 +266,4 @@ static void spike_machine_init(MachineClass *mc)
     mc->default_cpu_type = SPIKE_V1_10_0_CPU;
 }
 
-DEFINE_MACHINE("spike_v1.9.1", spike_v1_09_1_machine_init)
-DEFINE_MACHINE("spike_v1.10", spike_v1_10_0_machine_init)
 DEFINE_MACHINE("spike", spike_machine_init)
-- 
2.26.2


