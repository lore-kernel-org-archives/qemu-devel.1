Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 243A0C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 02:41:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4BAE2068D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 02:41:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eL01DCZn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4BAE2068D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57508 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfwrt-0008Lc-5z
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 22:41:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37430)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zltjiangshi@gmail.com>)
 id 1jfwr9-0007ke-PS
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 22:40:47 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031]:35060)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zltjiangshi@gmail.com>)
 id 1jfwr7-0005vr-Ca
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 22:40:47 -0400
Received: by mail-pj1-x1031.google.com with SMTP id 5so732123pjd.0
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2020 19:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=jUIKvjJiGTtscMbvb9QpFo3gA1FF6z6c7v/5gxBnmJI=;
 b=eL01DCZnq5bT8f3+b4u0aViM9Zr1fn06+eUi5JgRzagfN6eKLrXPWttHsK1qffvWff
 Fcakg3nWoZN0q4zeBvVdrIjsxM9wWeeGjz6aC0qIS2Iu5hQ4EuD4+K3Ky2nTy7FjZG8R
 QUKjHNOWuWcaddmZZSDCg6RQg4HCVUh8BBNwXKIO7dOYuN0tpzK61jYayc4s839UmMy9
 RGtxKTjct0hWWHEvVjGsn7tPL6yxCqfvZsxhwtKfmXKo9pn/pcSUh4I8Gd0Jt1kn8ixs
 rVGJOX7az4qR3LKBrRETtPxzwF/V19as8HznzMGUsuXqo9UUxQsSTJWV1JouWYupun8Y
 IkfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=jUIKvjJiGTtscMbvb9QpFo3gA1FF6z6c7v/5gxBnmJI=;
 b=cxRbppJAKSfSXYzqQeC0kSkIHSQFuQeB6XXzhgGOxGBFqAmyJfhSEywNytuenlDl+X
 6epuuIJsm04GDkgmM2Jrd8/AwQbstMp4tZVMCBQ010uFCpUZ+xYThUgcbfJnxtwlfykn
 Tkq19daIEOig9b7OEBOimAdxt4srp00nBOHpuGSt0vVrGLhSUSqTp2k8vDdk1NywdoXR
 pPwdJ6s+g9HImQmKerwJ+KH8nvF1ijONsh72M8BNQGCBKN93e6GnBQEbmBEeLsxasfDF
 Aw25mtO7Yte73/icK9t6j2AdIE3TPcjz3FHRgtvNtiosJMdXsyyIz2YrrOx4jZ/D669J
 UAPQ==
X-Gm-Message-State: AOAM531WvphwARID2y/B1kFqycHRykpI0wL4/PN2T11tquHsotAe09Fi
 EYV2jLFiCxAWbwjdMTTOTb57BCgYLraszw==
X-Google-Smtp-Source: ABdhPJyd9Wdg9z7d9LqcS92dlLpqLfxX/Br5pH1cJpSyam/3ZIUqoDaSgWQWJ9B38CGQHyOX7DL+jQ==
X-Received: by 2002:a17:90b:430f:: with SMTP id
 ih15mr2714516pjb.61.1591065643588; 
 Mon, 01 Jun 2020 19:40:43 -0700 (PDT)
Received: from software.domain.org (28.144.92.34.bc.googleusercontent.com.
 [34.92.144.28])
 by smtp.gmail.com with ESMTPSA id j186sm630761pfb.220.2020.06.01.19.40.40
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 01 Jun 2020 19:40:42 -0700 (PDT)
From: Huacai Chen <zltjiangshi@gmail.com>
X-Google-Original-From: Huacai Chen <chenhc@lemote.com>
To: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Subject: [PATCH for-5.1 V4 3/4] hw/mips: Add Loongson-3 machine support (with
 KVM)
Date: Tue,  2 Jun 2020 10:39:16 +0800
Message-Id: <1591065557-9174-4-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1591065557-9174-1-git-send-email-chenhc@lemote.com>
References: <1591065557-9174-1-git-send-email-chenhc@lemote.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=zltjiangshi@gmail.com; helo=mail-pj1-x1031.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
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
Cc: Huacai Chen <chenhuacai@gmail.com>, Huacai Chen <chenhc@lemote.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>, qemu-devel@nongnu.org,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add Loongson-3 based machine support, it use i8259 as the interrupt
controler and use GPEX as the pci controller. Currently it can only
work with KVM, but we will add TCG support in future.

We already have a full functional Linux kernel (based on Linux-5.4.x LTS
but not upstream yet) here:

https://github.com/chenhuacai/linux

How to use QEMU/Loongson-3?
1, Download kernel source from the above URL;
2, Build a kernel with arch/mips/configs/loongson3_{def,hpc}config;
3, Boot the a Loongson-3A4000 host with this kernel;
4, Build QEMU-5.0.0 with this patchset;
5, modprobe kvm;
6, Use QEMU with TCG (available in future):
       qemu-system-mips64el -M loongson3,accel=tcg -cpu Loongson-3A1000 -kernel <path_to_kernel> -append ...
   Use QEMU with KVM (available at present):
       qemu-system-mips64el -M loongson3,accel=kvm -cpu Loongson-3A4000 -kernel <path_to_kernel> -append ...

   The "-cpu" parameter can be omitted here and QEMU will use the correct type for TCG/KVM automatically.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
Co-developed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 default-configs/mips64el-softmmu.mak |   1 +
 hw/mips/Kconfig                      |  10 +
 hw/mips/Makefile.objs                |   1 +
 hw/mips/loongson3.c                  | 901 +++++++++++++++++++++++++++++++++++
 4 files changed, 913 insertions(+)
 create mode 100644 hw/mips/loongson3.c

diff --git a/default-configs/mips64el-softmmu.mak b/default-configs/mips64el-softmmu.mak
index 9f8a3ef..2a2a3fb 100644
--- a/default-configs/mips64el-softmmu.mak
+++ b/default-configs/mips64el-softmmu.mak
@@ -3,6 +3,7 @@
 include mips-softmmu-common.mak
 CONFIG_IDE_VIA=y
 CONFIG_FULOONG=y
+CONFIG_LOONGSON3=y
 CONFIG_ATI_VGA=y
 CONFIG_RTL8139_PCI=y
 CONFIG_JAZZ=y
diff --git a/hw/mips/Kconfig b/hw/mips/Kconfig
index 67d39c5..42931fd 100644
--- a/hw/mips/Kconfig
+++ b/hw/mips/Kconfig
@@ -45,6 +45,16 @@ config FULOONG
     bool
     select PCI_BONITO
 
+config LOONGSON3
+    bool
+    select PCKBD
+    select SERIAL
+    select ISA_BUS
+    select PCI_EXPRESS_GENERIC_BRIDGE
+    select VIRTIO_VGA
+    select QXL if SPICE
+    select MSI_NONBROKEN
+
 config MIPS_CPS
     bool
     select PTIMER
diff --git a/hw/mips/Makefile.objs b/hw/mips/Makefile.objs
index 3b3e6ea..31dedcb 100644
--- a/hw/mips/Makefile.objs
+++ b/hw/mips/Makefile.objs
@@ -4,5 +4,6 @@ obj-$(CONFIG_MALTA) += gt64xxx_pci.o malta.o
 obj-$(CONFIG_MIPSSIM) += mipssim.o
 obj-$(CONFIG_JAZZ) += jazz.o
 obj-$(CONFIG_FULOONG) += fuloong2e.o
+obj-$(CONFIG_LOONGSON3) += loongson3.o
 obj-$(CONFIG_MIPS_CPS) += cps.o
 obj-$(CONFIG_MIPS_BOSTON) += boston.o
diff --git a/hw/mips/loongson3.c b/hw/mips/loongson3.c
new file mode 100644
index 0000000..e4b9538
--- /dev/null
+++ b/hw/mips/loongson3.c
@@ -0,0 +1,901 @@
+/*
+ * Generic Loongson-3 Platform support
+ *
+ * Copyright (c) 2016-2020 Huacai Chen (chenhc@lemote.com)
+ * This code is licensed under the GNU GPL v2.
+ *
+ * Contributions are licensed under the terms of the GNU GPL,
+ * version 2 or (at your option) any later version.
+ */
+
+/*
+ * Generic PC Platform based on Loongson-3 CPU (MIPS64R2 with extensions,
+ * 800~2000MHz)
+ */
+
+#include "qemu/osdep.h"
+#include "qemu-common.h"
+#include "qemu/units.h"
+#include "qapi/error.h"
+#include "cpu.h"
+#include "elf.h"
+#include "hw/boards.h"
+#include "hw/char/serial.h"
+#include "hw/mips/mips.h"
+#include "hw/mips/cpudevs.h"
+#include "hw/intc/i8259.h"
+#include "hw/loader.h"
+#include "hw/ide.h"
+#include "hw/isa/superio.h"
+#include "hw/pci/msi.h"
+#include "hw/pci/pci.h"
+#include "hw/pci/pci_host.h"
+#include "hw/pci-host/gpex.h"
+#include "hw/rtc/mc146818rtc.h"
+#include "net/net.h"
+#include "exec/address-spaces.h"
+#include "sysemu/kvm.h"
+#include "sysemu/qtest.h"
+#include "sysemu/reset.h"
+#include "sysemu/runstate.h"
+#include "qemu/log.h"
+#include "qemu/error-report.h"
+
+#define INITRD_OFFSET         0x04000000
+#define BOOTPARAM_ADDR        0x8ff00000
+#define BOOTPARAM_PHYADDR     0x0ff00000
+#define CFG_ADDR              0x0f100000
+#define FW_CONF_ADDR          0x0fff0000
+#define PM_MMIO_ADDR          0x10080000
+#define PM_MMIO_SIZE          0x100
+#define PM_CNTL_MODE          0x10
+
+#define PHYS_TO_VIRT(x) ((x) | ~(target_ulong)0x7fffffff)
+
+/* Loongson-3 has a 2MB flash rom */
+#define BIOS_SIZE               (2 * MiB)
+#define LOONGSON_MAX_VCPUS      16
+
+#define LOONGSON3_BIOSNAME "bios_loongson3.bin"
+
+#define PCIE_IRQ_BASE       3
+
+#define VIRT_PCI_IO_BASE    0x18000000ul
+#define VIRT_PCI_IO_SIZE    0x000c0000ul
+#define VIRT_PCI_MEM_BASE   0x40000000ul
+#define VIRT_PCI_MEM_SIZE   0x40000000ul
+#define VIRT_PCI_ECAM_BASE  0x1a000000ul
+#define VIRT_PCI_ECAM_SIZE  0x02000000ul
+
+#define align(x) (((x) + 63) & ~63)
+
+/* LEFI (a UEFI-like interface for BIOS-Kernel boot parameters) data structrues
+ * defined at arch/mips/include/asm/mach-loongson64/boot_param.h in Linux kernel
+ */
+struct efi_memory_map_loongson {
+    uint16_t vers;               /* version of efi_memory_map */
+    uint32_t nr_map;             /* number of memory_maps */
+    uint32_t mem_freq;           /* memory frequence */
+    struct mem_map {
+        uint32_t node_id;        /* node_id which memory attached to */
+        uint32_t mem_type;       /* system memory, pci memory, pci io, etc. */
+        uint64_t mem_start;      /* memory map start address */
+        uint32_t mem_size;       /* each memory_map size, not the total size */
+    } map[128];
+} __attribute__((packed));
+
+enum loongson_cpu_type {
+    Legacy_2E = 0x0,
+    Legacy_2F = 0x1,
+    Legacy_3A = 0x2,
+    Legacy_3B = 0x3,
+    Legacy_1A = 0x4,
+    Legacy_1B = 0x5,
+    Legacy_2G = 0x6,
+    Legacy_2H = 0x7,
+    Loongson_1A = 0x100,
+    Loongson_1B = 0x101,
+    Loongson_2E = 0x200,
+    Loongson_2F = 0x201,
+    Loongson_2G = 0x202,
+    Loongson_2H = 0x203,
+    Loongson_3A = 0x300,
+    Loongson_3B = 0x301
+};
+
+/*
+ * Capability and feature descriptor structure for MIPS CPU
+ */
+struct efi_cpuinfo_loongson {
+    uint16_t vers;               /* version of efi_cpuinfo_loongson */
+    uint32_t processor_id;       /* PRID, e.g. 6305, 6306 */
+    uint32_t cputype;            /* Loongson_3A/3B, etc. */
+    uint32_t total_node;         /* num of total numa nodes */
+    uint16_t cpu_startup_core_id;   /* Boot core id */
+    uint16_t reserved_cores_mask;
+    uint32_t cpu_clock_freq;     /* cpu_clock */
+    uint32_t nr_cpus;
+    char cpuname[64];
+} __attribute__((packed));
+
+#define MAX_UARTS 64
+struct uart_device {
+    uint32_t iotype;
+    uint32_t uartclk;
+    uint32_t int_offset;
+    uint64_t uart_base;
+} __attribute__((packed));
+
+#define MAX_SENSORS 64
+#define SENSOR_TEMPER  0x00000001
+#define SENSOR_VOLTAGE 0x00000002
+#define SENSOR_FAN     0x00000004
+struct sensor_device {
+    char name[32];  /* a formal name */
+    char label[64]; /* a flexible description */
+    uint32_t type;       /* SENSOR_* */
+    uint32_t id;         /* instance id of a sensor-class */
+    uint32_t fan_policy; /* step speed or constant speed */
+    uint32_t fan_percent;/* only for constant speed policy */
+    uint64_t base_addr;  /* base address of device registers */
+} __attribute__((packed));
+
+struct system_loongson {
+    uint16_t vers;               /* version of system_loongson */
+    uint32_t ccnuma_smp;         /* 0: no numa; 1: has numa */
+    uint32_t sing_double_channel;/* 1: single; 2: double */
+    uint32_t nr_uarts;
+    struct uart_device uarts[MAX_UARTS];
+    uint32_t nr_sensors;
+    struct sensor_device sensors[MAX_SENSORS];
+    char has_ec;
+    char ec_name[32];
+    uint64_t ec_base_addr;
+    char has_tcm;
+    char tcm_name[32];
+    uint64_t tcm_base_addr;
+    uint64_t workarounds;
+    uint64_t of_dtb_addr; /* NULL if not support */
+} __attribute__((packed));
+
+struct irq_source_routing_table {
+    uint16_t vers;
+    uint16_t size;
+    uint16_t rtr_bus;
+    uint16_t rtr_devfn;
+    uint32_t vendor;
+    uint32_t device;
+    uint32_t PIC_type;           /* conform use HT or PCI to route to CPU-PIC */
+    uint64_t ht_int_bit;         /* 3A: 1<<24; 3B: 1<<16 */
+    uint64_t ht_enable;          /* irqs used in this PIC */
+    uint32_t node_id;            /* node id: 0x0-0; 0x1-1; 0x10-2; 0x11-3 */
+    uint64_t pci_mem_start_addr;
+    uint64_t pci_mem_end_addr;
+    uint64_t pci_io_start_addr;
+    uint64_t pci_io_end_addr;
+    uint64_t pci_config_addr;
+    uint16_t dma_mask_bits;
+    uint16_t dma_noncoherent;
+} __attribute__((packed));
+
+struct interface_info {
+    uint16_t vers;               /* version of the specificition */
+    uint16_t size;
+    uint8_t  flag;
+    char description[64];
+} __attribute__((packed));
+
+#define MAX_RESOURCE_NUMBER 128
+struct resource_loongson {
+    uint64_t start;              /* resource start address */
+    uint64_t end;                /* resource end address */
+    char name[64];
+    uint32_t flags;
+};
+
+struct archdev_data {};          /* arch specific additions */
+
+struct board_devices {
+    char name[64];               /* hold the device name */
+    uint32_t num_resources;      /* number of device_resource */
+    /* for each device's resource */
+    struct resource_loongson resource[MAX_RESOURCE_NUMBER];
+    /* arch specific additions */
+    struct archdev_data archdata;
+};
+
+struct loongson_special_attribute {
+    uint16_t vers;               /* version of this special */
+    char special_name[64];       /* special_atribute_name */
+    uint32_t loongson_special_type; /* type of special device */
+    /* for each device's resource */
+    struct resource_loongson resource[MAX_RESOURCE_NUMBER];
+};
+
+struct loongson_params {
+    uint64_t memory_offset;      /* efi_memory_map_loongson struct offset */
+    uint64_t cpu_offset;         /* efi_cpuinfo_loongson struct offset */
+    uint64_t system_offset;      /* system_loongson struct offset */
+    uint64_t irq_offset;         /* irq_source_routing_table struct offset */
+    uint64_t interface_offset;   /* interface_info struct offset */
+    uint64_t special_offset;     /* loongson_special_attribute struct offset */
+    uint64_t boarddev_table_offset;  /* board_devices offset */
+};
+
+struct smbios_tables {
+    uint16_t vers;               /* version of smbios */
+    uint64_t vga_bios;           /* vga_bios address */
+    struct loongson_params lp;
+};
+
+struct efi_reset_system_t {
+    uint64_t ResetCold;
+    uint64_t ResetWarm;
+    uint64_t ResetType;
+    uint64_t Shutdown;
+    uint64_t DoSuspend; /* NULL if not support */
+};
+
+struct efi_loongson {
+    uint64_t mps;                /* MPS table */
+    uint64_t acpi;               /* ACPI table (IA64 ext 0.71) */
+    uint64_t acpi20;             /* ACPI table (ACPI 2.0) */
+    struct smbios_tables smbios; /* SM BIOS table */
+    uint64_t sal_systab;         /* SAL system table */
+    uint64_t boot_info;          /* boot info table */
+};
+
+struct boot_params {
+    struct efi_loongson efi;
+    struct efi_reset_system_t reset_system;
+};
+
+static struct _fw_config {
+    unsigned long ram_size;
+    unsigned int mem_freq;
+    unsigned int nr_cpus;
+    unsigned int cpu_clock_freq;
+} fw_config;
+
+static struct _loaderparams {
+    unsigned long ram_size;
+    const char *kernel_cmdline;
+    const char *kernel_filename;
+    const char *initrd_filename;
+    int64_t kernel_entry;
+    unsigned long a0, a1, a2;
+} loaderparams;
+
+static void *boot_params_p;
+static void *boot_params_buf;
+
+static unsigned int bios_boot_code[] = {
+    0x40086000,   /* mfc0    t0, CP0_STATUS                                   */
+    0x240900E4,   /* li      t1, 0xe4         #set kx, sx, ux, erl            */
+    0x01094025,   /* or      t0, t0, t1                                       */
+    0x3C090040,   /* lui     t1, 0x40         #set bev                        */
+    0x01094025,   /* or      t0, t0, t1                                       */
+    0x40886000,   /* mtc0    t0, CP0_STATUS                                   */
+    0x00000000,
+    0x40806800,   /* mtc0    zero, CP0_CAUSE                                  */
+    0x00000000,
+    0x400A7801,   /* mfc0    t2, $15, 1                                       */
+    0x314A00FF,   /* andi    t2, 0x0ff                                        */
+    0x3C089000,   /* dli     t0, 0x900000003ff01000                           */
+    0x00084438,
+    0x35083FF0,
+    0x00084438,
+    0x35081000,
+    0x314B0003,   /* andi    t3, t2, 0x3      #local cpuid                    */
+    0x000B5A00,   /* sll     t3, 8                                            */
+    0x010B4025,   /* or      t0, t0, t3                                       */
+    0x314C000C,   /* andi    t4, t2, 0xc      #node id                        */
+    0x000C62BC,   /* dsll    t4, 42                                           */
+    0x010C4025,   /* or      t0, t0, t4                                       */
+                  /* waitforinit:                                             */
+    0xDD020020,   /* ld      v0, FN_OFF(t0)   #FN_OFF 0x020                   */
+    0x1040FFFE,   /* beqz    v0, waitforinit                                  */
+    0x00000000,   /* nop                                                      */
+    0xDD1D0028,   /* ld      sp, SP_OFF(t0)   #FN_OFF 0x028                   */
+    0xDD1C0030,   /* ld      gp, GP_OFF(t0)   #FN_OFF 0x030                   */
+    0xDD050038,   /* ld      a1, A1_OFF(t0)   #FN_OFF 0x038                   */
+    0x00400008,   /* jr      v0               #byebye                         */
+    0x00000000,   /* nop                                                      */
+    0x1000FFFF,   /* 1:  b   1b                                               */
+    0x00000000,   /* nop                                                      */
+
+                  /* Reset                                                    */
+    0x3C0C9000,   /* dli     t0, 0x9000000010080010                           */
+    0x358C0000,
+    0x000C6438,
+    0x358C1008,
+    0x000C6438,
+    0x358C0010,
+    0x240D0000,   /* li      t1, 0x00                                         */
+    0xA18D0000,   /* sb      t1, (t0)                                         */
+    0x1000FFFF,   /* 1:  b   1b                                               */
+    0x00000000,   /* nop                                                      */
+
+                  /* Shutdown                                                 */
+    0x3C0C9000,   /* dli     t0, 0x9000000010080010                           */
+    0x358C0000,
+    0x000C6438,
+    0x358C1008,
+    0x000C6438,
+    0x358C0010,
+    0x240D00FF,   /* li      t1, 0xff                                         */
+    0xA18D0000,   /* sb      t1, (t0)                                         */
+    0x1000FFFF,   /* 1:  b   1b                                               */
+    0x00000000    /* nop                                                      */
+};
+
+static uint64_t loongson3_pm_read(void *opaque, hwaddr addr, unsigned size)
+{
+    return 0;
+}
+
+static void loongson3_pm_write(void *opaque, hwaddr addr, uint64_t val, unsigned size)
+{
+    if (addr != PM_CNTL_MODE) {
+        return;
+    }
+
+    switch (val) {
+    case 0x00:
+        qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
+        return;
+    case 0xff:
+        qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
+        return;
+    default:
+        return;
+    }
+}
+
+static const MemoryRegionOps loongson3_pm_ops = {
+    .read  = loongson3_pm_read,
+    .write = loongson3_pm_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+};
+
+static struct efi_memory_map_loongson *init_memory_map(void *g_map)
+{
+    struct efi_memory_map_loongson *emap = g_map;
+
+    emap->nr_map = 2;
+    emap->mem_freq = 300000000;
+
+    emap->map[0].node_id = 0;
+    emap->map[0].mem_type = 1;
+    emap->map[0].mem_start = 0x0;
+    emap->map[0].mem_size = (loaderparams.ram_size > 0x10000000
+                            ? 256 : (loaderparams.ram_size >> 20)) - 16;
+
+    emap->map[1].node_id = 0;
+    emap->map[1].mem_type = 2;
+    emap->map[1].mem_start = 0x90000000;
+    emap->map[1].mem_size = (loaderparams.ram_size > 0x10000000
+                            ? (loaderparams.ram_size >> 20) - 256 : 0);
+
+    return emap;
+}
+
+static int get_host_cpu_freq(void)
+{
+    int fd = 0, freq = 0;
+    char buf[1024], *buf_p;
+
+    fd = open("/proc/cpuinfo", O_RDONLY);
+    if (fd == -1) {
+        fprintf(stderr, "Failed to open /proc/cpuinfo!\n");
+        return 0;
+    }
+
+    if (read(fd, buf, 1024) < 0) {
+        close(fd);
+        fprintf(stderr, "Failed to read /proc/cpuinfo!\n");
+        return 0;
+    }
+    close(fd);
+
+    buf_p = strstr(buf, "model name");
+    while (*buf_p != '@') {
+        buf_p++;
+    }
+
+    buf_p += 2;
+    memcpy(buf, buf_p, 12);
+    buf_p = buf;
+    while ((*buf_p >= '0') && (*buf_p <= '9')) {
+        buf_p++;
+    }
+    *buf_p = '\0';
+
+    freq = atoi(buf);
+
+    return freq * 1000 * 1000;
+}
+
+static struct efi_cpuinfo_loongson *init_cpu_info(void *g_cpuinfo_loongson)
+{
+    struct efi_cpuinfo_loongson *c = g_cpuinfo_loongson;
+
+    c->cputype  = Loongson_3A;
+    c->processor_id = 0x14C000;
+    c->cpu_clock_freq = get_host_cpu_freq();
+    if (!c->cpu_clock_freq) {
+        c->cpu_clock_freq = 500000000;
+    }
+
+    c->cpu_startup_core_id = 0;
+    c->nr_cpus = current_machine->smp.cpus;
+    c->total_node = (current_machine->smp.cpus + 3) / 4;
+
+    return c;
+}
+
+static struct system_loongson *init_system_loongson(void *g_system)
+{
+    struct system_loongson *s = g_system;
+
+    s->ccnuma_smp = 0;
+    s->sing_double_channel = 1;
+    s->nr_uarts = 1;
+    s->uarts[0].iotype = 2;
+    s->uarts[0].int_offset = 2;
+    s->uarts[0].uartclk = 25000000;
+    s->uarts[0].uart_base = 0x1fe001e0;
+
+    return s;
+}
+
+static struct irq_source_routing_table *init_irq_source(void *g_irq_source)
+{
+    struct irq_source_routing_table *irq_info = g_irq_source;
+
+    irq_info->node_id = 0;
+    irq_info->PIC_type = 0;
+    irq_info->dma_mask_bits = 64;
+    irq_info->pci_mem_start_addr = VIRT_PCI_MEM_BASE;
+    irq_info->pci_mem_end_addr   = VIRT_PCI_MEM_BASE + VIRT_PCI_MEM_SIZE - 1;
+    irq_info->pci_io_start_addr  = VIRT_PCI_IO_BASE;
+
+    return irq_info;
+}
+
+static struct interface_info *init_interface_info(void *g_interface)
+{
+    struct interface_info *interface = g_interface;
+
+    interface->vers = 0x01;
+    strcpy(interface->description, "UEFI_Version_v1.0");
+
+    return interface;
+}
+
+static struct board_devices *board_devices_info(void *g_board)
+{
+    struct board_devices *bd = g_board;
+
+    strcpy(bd->name, "Loongson-3A-VIRT-1w-V1.00-demo");
+
+    return bd;
+}
+
+static struct loongson_special_attribute *init_special_info(void *g_special)
+{
+    struct loongson_special_attribute *special = g_special;
+
+    strcpy(special->special_name, "2016-05-16");
+
+    return special;
+}
+
+static void init_loongson_params(struct loongson_params *lp)
+{
+    void *p = boot_params_p;
+
+    lp->memory_offset = (unsigned long long)init_memory_map(p)
+                        - (unsigned long long)lp;
+    p += align(sizeof(struct efi_memory_map_loongson));
+
+    lp->cpu_offset = (unsigned long long)init_cpu_info(p)
+                     - (unsigned long long)lp;
+    p += align(sizeof(struct efi_cpuinfo_loongson));
+
+    lp->system_offset = (unsigned long long)init_system_loongson(p)
+                        - (unsigned long long)lp;
+    p += align(sizeof(struct system_loongson));
+
+    lp->irq_offset = (unsigned long long)init_irq_source(p)
+                     - (unsigned long long)lp;
+    p += align(sizeof(struct irq_source_routing_table));
+
+    lp->interface_offset = (unsigned long long)init_interface_info(p)
+                           - (unsigned long long)lp;
+    p += align(sizeof(struct interface_info));
+
+    lp->boarddev_table_offset = (unsigned long long)board_devices_info(p)
+                                - (unsigned long long)lp;
+    p += align(sizeof(struct board_devices));
+
+    lp->special_offset = (unsigned long long)init_special_info(p)
+                         - (unsigned long long)lp;
+    p += align(sizeof(struct loongson_special_attribute));
+
+    boot_params_p = p;
+}
+
+static void init_smbios(struct smbios_tables *smbios)
+{
+    smbios->vers = 1;
+    init_loongson_params(&(smbios->lp));
+}
+
+static void init_efi(struct efi_loongson *efi)
+{
+    init_smbios(&(efi->smbios));
+}
+
+static void init_reset_system(struct efi_reset_system_t *reset)
+{
+    reset->Shutdown = 0xffffffffbfc000a8;
+    reset->ResetCold = 0xffffffffbfc00080;
+    reset->ResetWarm = 0xffffffffbfc00080;
+}
+
+static int init_boot_param(struct boot_params *bp)
+{
+    init_efi(&(bp->efi));
+    init_reset_system(&(bp->reset_system));
+
+    return 0;
+}
+
+static void fw_cfg_boot_set(void *opaque, const char *boot_device,
+                            Error **errp)
+{
+    fw_cfg_modify_i16(opaque, FW_CFG_BOOT_DEVICE, boot_device[0]);
+}
+
+static void fw_conf_init(unsigned long ram_size)
+{
+    FWCfgState *fw_cfg;
+
+    fw_cfg = fw_cfg_init_mem_wide(CFG_ADDR, CFG_ADDR + 8, 8, 0, NULL);
+    fw_cfg_add_i16(fw_cfg, FW_CFG_NB_CPUS, (uint16_t)current_machine->smp.cpus);
+    fw_cfg_add_i16(fw_cfg, FW_CFG_MAX_CPUS, (uint16_t)current_machine->smp.max_cpus);
+    fw_cfg_add_i64(fw_cfg, FW_CFG_RAM_SIZE, (uint64_t)ram_size);
+    qemu_register_boot_set(fw_cfg_boot_set, fw_cfg);
+
+    fw_config.ram_size = ram_size;
+    fw_config.mem_freq = 300000000;
+    fw_config.nr_cpus = current_machine->smp.cpus;
+    fw_config.cpu_clock_freq = get_host_cpu_freq();
+}
+
+static int set_prom_bootparam(ram_addr_t initrd_offset, long initrd_size)
+{
+    long params_size;
+    char memenv[32];
+    char highmemenv[32];
+    void *params_buf;
+    unsigned int *parg_env;
+    int ret = 0;
+
+    /* Allocate params_buf for command line. */
+    params_size = 0x100000;
+    params_buf = g_malloc0(params_size);
+
+    /*
+     * Layout of params_buf looks like this:
+     * argv[0], argv[1], 0, env[0], env[1], ... env[i], 0,
+     * argv[0]'s data, argv[1]'s data, env[0]'data, ..., env[i]'s data, 0
+     */
+    parg_env = (void *)params_buf;
+
+    ret = (3 + 1) * 4;
+    *parg_env++ = (BOOTPARAM_ADDR + ret);
+    ret += (1 + snprintf(params_buf + ret, 256 - ret, "g"));
+
+    /* argv1 */
+    *parg_env++ = BOOTPARAM_ADDR + ret;
+    if (initrd_size > 0)
+        ret += (1 + snprintf(params_buf + ret, 256 - ret,
+                "rd_start=0x" TARGET_FMT_lx " rd_size=%li %s",
+                PHYS_TO_VIRT((uint32_t)initrd_offset),
+                initrd_size, loaderparams.kernel_cmdline));
+    else
+        ret += (1 + snprintf(params_buf + ret, 256 - ret, "%s",
+                loaderparams.kernel_cmdline));
+
+    /* argv2 */
+    *parg_env++ = BOOTPARAM_ADDR + 4 * ret;
+
+    /* env */
+    sprintf(memenv, "%ld", loaderparams.ram_size > 0x10000000
+            ? 256 : (loaderparams.ram_size >> 20));
+    sprintf(highmemenv, "%ld", loaderparams.ram_size > 0x10000000
+            ? (loaderparams.ram_size >> 20) - 256 : 0);
+
+    setenv("memsize", memenv, 1);
+    setenv("highmemsize", highmemenv, 1);
+
+    ret = ((ret + 32) & ~31);
+
+    boot_params_buf = (void *)(params_buf + ret);
+    boot_params_p = boot_params_buf + align(sizeof(struct boot_params));
+
+    init_boot_param(boot_params_buf);
+
+    rom_add_blob_fixed("params", params_buf, params_size,
+                       BOOTPARAM_PHYADDR);
+    loaderparams.a0 = 2;
+    loaderparams.a1 = 0xffffffff80000000ULL + BOOTPARAM_PHYADDR;
+    loaderparams.a2 = 0xffffffff80000000ULL + BOOTPARAM_PHYADDR + ret;
+
+    return 0;
+}
+
+static int64_t load_kernel(CPUMIPSState *env)
+{
+    long kernel_size;
+    ram_addr_t initrd_offset;
+    int64_t kernel_entry, kernel_low, kernel_high, initrd_size;
+
+    kernel_size = load_elf(loaderparams.kernel_filename, NULL,
+                           cpu_mips_kseg0_to_phys, NULL,
+                           (uint64_t *)&kernel_entry,
+                           (uint64_t *)&kernel_low, (uint64_t *)&kernel_high,
+                           NULL, 0, EM_MIPS, 1, 0);
+    if (kernel_size < 0) {
+        error_report("could not load kernel '%s': %s",
+                     loaderparams.kernel_filename,
+                     load_elf_strerror(kernel_size));
+        exit(1);
+    }
+
+    /* load initrd */
+    initrd_size = 0;
+    initrd_offset = 0;
+    if (loaderparams.initrd_filename) {
+        initrd_size = get_image_size(loaderparams.initrd_filename);
+        if (initrd_size > 0) {
+            initrd_offset = (kernel_high + ~INITRD_PAGE_MASK) &
+                            INITRD_PAGE_MASK;
+            initrd_offset = MAX(initrd_offset, INITRD_OFFSET);
+
+            if (initrd_offset + initrd_size > ram_size) {
+                error_report("memory too small for initial ram disk '%s'",
+                             loaderparams.initrd_filename);
+                exit(1);
+            }
+
+            initrd_size = load_image_targphys(loaderparams.initrd_filename,
+                                              initrd_offset,
+                                              ram_size - initrd_offset);
+        }
+
+        if (initrd_size == (target_ulong) -1) {
+            error_report("could not load initial ram disk '%s'",
+                         loaderparams.initrd_filename);
+            exit(1);
+        }
+    }
+
+    /* Setup prom parameters. */
+    set_prom_bootparam(initrd_offset, initrd_size);
+
+    return kernel_entry;
+}
+
+static void main_cpu_reset(void *opaque)
+{
+    MIPSCPU *cpu = opaque;
+    CPUMIPSState *env = &cpu->env;
+
+    cpu_reset(CPU(cpu));
+
+    /* Loongson-3 reset stuff */
+    if (loaderparams.kernel_filename) {
+        if (cpu == MIPS_CPU(first_cpu)) {
+            env->active_tc.gpr[4] = loaderparams.a0;
+            env->active_tc.gpr[5] = loaderparams.a1;
+            env->active_tc.gpr[6] = loaderparams.a2;
+            env->active_tc.PC = loaderparams.kernel_entry;
+        }
+        env->CP0_Status &= ~((1 << CP0St_BEV) | (1 << CP0St_ERL));
+    }
+}
+
+static void loongson3_isa_init(qemu_irq intc)
+{
+    qemu_irq *i8259;
+    ISABus *isa_bus;
+
+    isa_bus = isa_bus_new(NULL, get_system_memory(), get_system_io(), &error_abort);
+
+    /* Interrupt controller */
+    /* The 8259 -> IP3  */
+    i8259 = i8259_init(isa_bus, intc);
+    isa_bus_irqs(isa_bus, i8259);
+    /* init other devices */
+    isa_create_simple(isa_bus, "i8042");
+    mc146818_rtc_init(isa_bus, 2000, NULL);
+}
+
+static inline void loongson3_pcie_init(MachineState *machine, DeviceState *pic)
+{
+    int i;
+    qemu_irq irq;
+    PCIBus *pci_bus;
+    DeviceState *dev;
+    MemoryRegion *pio_alias;
+    MemoryRegion *mmio_alias, *mmio_reg;
+    MemoryRegion *ecam_alias, *ecam_reg;
+
+    dev = qdev_create(NULL, TYPE_GPEX_HOST);
+
+    qdev_init_nofail(dev);
+    pci_bus = PCI_HOST_BRIDGE(dev)->bus;
+
+    ecam_alias = g_new0(MemoryRegion, 1);
+    ecam_reg = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0);
+    memory_region_init_alias(ecam_alias, OBJECT(dev), "pcie-ecam",
+                             ecam_reg, 0, VIRT_PCI_ECAM_SIZE);
+    memory_region_add_subregion(get_system_memory(), VIRT_PCI_ECAM_BASE, ecam_alias);
+
+    mmio_alias = g_new0(MemoryRegion, 1);
+    mmio_reg = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 1);
+    memory_region_init_alias(mmio_alias, OBJECT(dev), "pcie-mmio",
+                             mmio_reg, VIRT_PCI_MEM_BASE, VIRT_PCI_MEM_SIZE);
+    memory_region_add_subregion(get_system_memory(), VIRT_PCI_MEM_BASE, mmio_alias);
+
+    pio_alias = g_new0(MemoryRegion, 1);
+    memory_region_init_alias(pio_alias, OBJECT(dev), "pcie-pio",
+                             get_system_io(), 0, VIRT_PCI_IO_SIZE);
+    memory_region_add_subregion(get_system_memory(), VIRT_PCI_IO_BASE, pio_alias);
+    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 2, VIRT_PCI_IO_BASE);
+
+    for (i = 0; i < GPEX_NUM_IRQS; i++) {
+        irq = qdev_get_gpio_in(pic, PCIE_IRQ_BASE + i);
+        sysbus_connect_irq(SYS_BUS_DEVICE(dev), i, irq);
+        gpex_set_irq_num(GPEX_HOST(dev), i, PCIE_IRQ_BASE + i);
+    }
+
+    pci_vga_init(pci_bus);
+
+    for (i = 0; i < nb_nics; i++) {
+        NICInfo *nd = &nd_table[i];
+
+        if (!nd->model) {
+            nd->model = g_strdup("virtio");
+        }
+
+        pci_nic_init_nofail(nd, pci_bus, nd->model, NULL);
+    }
+}
+
+static void mips_loongson3_init(MachineState *machine)
+{
+    int i;
+    long bios_size;
+    MIPSCPU *cpu;
+    CPUMIPSState *env;
+    char *filename;
+    const char *kernel_cmdline = machine->kernel_cmdline;
+    const char *kernel_filename = machine->kernel_filename;
+    const char *initrd_filename = machine->initrd_filename;
+    ram_addr_t ram_size = machine->ram_size;
+    MemoryRegion *address_space_mem = get_system_memory();
+    MemoryRegion *ram = g_new(MemoryRegion, 1);
+    MemoryRegion *bios = g_new(MemoryRegion, 1);
+    MemoryRegion *iomem = g_new(MemoryRegion, 1);
+
+    if (!kvm_enabled()) {
+        if (!machine->cpu_type) {
+            machine->cpu_type = MIPS_CPU_TYPE_NAME("Loongson-3A1000");
+        }
+        if (!strstr(machine->cpu_type, "Loongson-3A1000")) {
+            error_report("Loongson-3/TCG need cpu type Loongson-3A1000");
+            exit(1);
+        }
+    } else {
+        if (!machine->cpu_type) {
+            machine->cpu_type = MIPS_CPU_TYPE_NAME("Loongson-3A4000");
+        }
+        if (!strstr(machine->cpu_type, "Loongson-3A4000")) {
+            error_report("Loongson-3/KVM need cpu type Loongson-3A4000");
+            exit(1);
+        }
+    }
+
+    if (ram_size < 256 * 0x100000) {
+        error_report("Loongson-3 need at least 256MB memory");
+        exit(1);
+    }
+
+    for (i = 0; i < machine->smp.cpus; i++) {
+        /* init CPUs */
+        cpu = MIPS_CPU(cpu_create(machine->cpu_type));
+
+        /* Init internal devices */
+        cpu_mips_irq_init_cpu(cpu);
+        cpu_mips_clock_init(cpu);
+        qemu_register_reset(main_cpu_reset, cpu);
+    }
+    env = &MIPS_CPU(first_cpu)->env;
+
+    /* Allocate RAM/BIOS, 0x00000000~0x10000000 is alias of 0x80000000~0x90000000 */
+    memory_region_init_rom(bios, NULL, "loongson3.bios",
+                           BIOS_SIZE, &error_fatal);
+    memory_region_init_alias(ram, NULL, "loongson3.lowram",
+                           machine->ram, 0, 256 * 0x100000);
+    memory_region_init_io(iomem, NULL, &loongson3_pm_ops,
+                           NULL, "loongson3_pm", PM_MMIO_SIZE);
+
+    memory_region_add_subregion(address_space_mem, 0x00000000LL, ram);
+    memory_region_add_subregion(address_space_mem, 0x1fc00000LL, bios);
+    memory_region_add_subregion(address_space_mem, 0x80000000LL, machine->ram);
+    memory_region_add_subregion(address_space_mem, PM_MMIO_ADDR, iomem);
+
+    /*
+     * We do not support flash operation, just loading pmon.bin as raw BIOS.
+     * Please use -L to set the BIOS path and -bios to set bios name.
+     */
+
+    if (kernel_filename) {
+        loaderparams.ram_size = ram_size;
+        loaderparams.kernel_filename = kernel_filename;
+        loaderparams.kernel_cmdline = kernel_cmdline;
+        loaderparams.initrd_filename = initrd_filename;
+        loaderparams.kernel_entry = load_kernel(env);
+        rom_add_blob_fixed("bios",
+                         bios_boot_code, sizeof(bios_boot_code), 0x1fc00000LL);
+    } else {
+        if (bios_name == NULL) {
+                bios_name = LOONGSON3_BIOSNAME;
+        }
+        filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
+        if (filename) {
+            bios_size = load_image_targphys(filename, 0x1fc00000LL,
+                                            BIOS_SIZE);
+            g_free(filename);
+        } else {
+            bios_size = -1;
+        }
+
+        if ((bios_size < 0 || bios_size > BIOS_SIZE) &&
+            !kernel_filename && !qtest_enabled()) {
+            error_report("Could not load MIPS bios '%s'", bios_name);
+            exit(1);
+        }
+
+        fw_conf_init(ram_size);
+        rom_add_blob_fixed("fw_conf",
+                         &fw_config, sizeof(fw_config), FW_CONF_ADDR);
+    }
+
+    msi_nonbroken = true;
+    loongson3_isa_init(env->irq[3]);
+    loongson3_pcie_init(machine, isa_pic);
+
+    if (serial_hd(0)) {
+        serial_mm_init(address_space_mem, 0x1fe001e0, 0, env->irq[2],
+                           115200, serial_hd(0), DEVICE_NATIVE_ENDIAN);
+    }
+}
+
+static void mips_loongson3_machine_init(MachineClass *mc)
+{
+    mc->desc = "Generic Loongson-3 Platform";
+    mc->init = mips_loongson3_init;
+    mc->block_default_type = IF_IDE;
+    mc->max_cpus = LOONGSON_MAX_VCPUS;
+    mc->default_ram_id = "loongson3.highram";
+    mc->default_ram_size = 1200 * MiB;
+    mc->kvm_type = mips_kvm_type;
+    mc->minimum_page_bits = 14;
+}
+
+DEFINE_MACHINE("loongson3", mips_loongson3_machine_init)
-- 
2.7.0


