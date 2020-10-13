Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B885C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 15:55:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F06F2521E
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 15:55:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F06F2521E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55580 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSMeM-0000wU-L8
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 11:55:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39636)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kSMaR-0005Uq-Cf
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 11:51:40 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:47239)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kSMaL-00066M-0v
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 11:51:39 -0400
Received: from localhost.localdomain ([82.252.141.186]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1Mc1hn-1juOLe0X4J-00dXxn; Tue, 13 Oct 2020 17:51:29 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/4] m68k: import bootinfo headers from linux
Date: Tue, 13 Oct 2020 17:51:21 +0200
Message-Id: <20201013155124.451774-2-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201013155124.451774-1-laurent@vivier.eu>
References: <20201013155124.451774-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Vw79WkF3GCPOVnCdvRVqWnlzmujvVg/i7SjNFfdaKfjnoCSAPmm
 jHILPhgj39LSPnpPjffkPrPXNp5PbzechysFbPSZrxdETP454tVdvQiiAPGsxqhko/2GsCY
 1kQUS2q4f7MJP9ZHp4IogN2DrwkJTXlsj0/Eh1pigvZP4J07RfTg2860H5tgnG+Kg3WDtDr
 o7C5iyVZoIBofLZeu3R7w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:JDkX8dKSiNE=:7GFxFreHK5npjzzVCiG/Hx
 qDjaf98JXbZxfrhlq78SFGuV4EJaBq3nRQ+eCEHNJRSA8Njrp+oTiudd760OUMT8tD6X9FAjS
 9XohCZDBmdmnKkjq6V39z+8k7RGR8DLI4FqaCydo5D3qGX1G4bGPkucBU+uV+cClSzE/KRhR9
 l4aKvoupxfnJpLL6QYn9hJPBBJ7vr7jF/Dk6veIMcZpSI3XuAu8wQRb7R+JTXjenxjfyTzep3
 16L1/E2W/OnyN3mfZ3uLcZy2HI18Zy/gDbcYO0DGCjS+1ho8TQkF2j0s0/8+I0lG6foESpjXY
 U5FQ9MEqKRVX1+kQkhgkHHIGLUOVfwDpqSExWAdo+2x+B9Nu/gmlaA+FUoylzpukmlpRFpw6S
 pcanZ7YCWT8gCKMnTiOXGxaf++7Z+s6tpP22nRtXAf/V9sb+pzgU7Y1397GTnPRCpiG6/jy9i
 vk6aVAAwlDFhxmUI3DCsdGHMn7km05AedvcA2aMbeJ0yvr5Dedx36aOWjdwy25qgZ7BH2clft
 oO3QEh9if7huQcbgpXNShJBjYI/DR9O1qfllHaaDf9IkTjjCd/6U1rwuXAg9bREvJfzMMbXrn
 wvnAWv9C0X9EHgRIfYgQkQj0T/+Xv0WFlXV+IBaNV00HPTGiU6vk05yB1kJsg5H8VrzUMJqkl
 zmzv/JnpTGfZb1UsR0D1LcRbZWNwuciNkrBwsEJqCiYn0vuzUKdpHdoEoTzJmqXY0l2OJrdHE
 /Dw4vJkkEHzcAsfV/hUh8iVzrWNo8+eZkEInTTlSzLABdkq7l3UoC5iulgJITUz8UTZIoWL6S
 yQ1kJTfxb69c6AhHYOedvrLpw88ylu8/QHBuJ/2Sk9LImNGVzjNxHfV0h2eFk19FBInJs9R
Received-SPF: none client-ip=212.227.126.134; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/13 11:51:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Copy bootinfo.h and bootinfo-mac.h from arch/m68k/include/uapi/asm/
to include/standard-headers/asm-m68k/

Imported from linx v5.9 but didn't change since v4.14 (header update)
and since v4.10 (content update).

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/m68k/bootinfo.h                            |  55 ------
 .../standard-headers/asm-m68k/bootinfo-mac.h  | 120 +++++++++++++
 include/standard-headers/asm-m68k/bootinfo.h  | 166 ++++++++++++++++++
 hw/m68k/q800.c                                |  20 +--
 MAINTAINERS                                   |   2 +
 5 files changed, 295 insertions(+), 68 deletions(-)
 create mode 100644 include/standard-headers/asm-m68k/bootinfo-mac.h
 create mode 100644 include/standard-headers/asm-m68k/bootinfo.h

diff --git a/hw/m68k/bootinfo.h b/hw/m68k/bootinfo.h
index c954270aad6c..adbf0c5521e5 100644
--- a/hw/m68k/bootinfo.h
+++ b/hw/m68k/bootinfo.h
@@ -11,61 +11,6 @@
 
 #ifndef HW_M68K_BOOTINFO_H
 #define HW_M68K_BOOTINFO_H
-struct bi_record {
-    uint16_t tag;        /* tag ID */
-    uint16_t size;       /* size of record */
-    uint32_t data[];     /* data */
-};
-
-/* machine independent tags */
-
-#define BI_LAST         0x0000 /* last record */
-#define BI_MACHTYPE     0x0001 /* machine type (u_long) */
-#define BI_CPUTYPE      0x0002 /* cpu type (u_long) */
-#define BI_FPUTYPE      0x0003 /* fpu type (u_long) */
-#define BI_MMUTYPE      0x0004 /* mmu type (u_long) */
-#define BI_MEMCHUNK     0x0005 /* memory chunk address and size */
-                               /* (struct mem_info) */
-#define BI_RAMDISK      0x0006 /* ramdisk address and size */
-                               /* (struct mem_info) */
-#define BI_COMMAND_LINE 0x0007 /* kernel command line parameters */
-                               /* (string) */
-
-/*  Macintosh-specific tags (all u_long) */
-
-#define BI_MAC_MODEL    0x8000  /* Mac Gestalt ID (model type) */
-#define BI_MAC_VADDR    0x8001  /* Mac video base address */
-#define BI_MAC_VDEPTH   0x8002  /* Mac video depth */
-#define BI_MAC_VROW     0x8003  /* Mac video rowbytes */
-#define BI_MAC_VDIM     0x8004  /* Mac video dimensions */
-#define BI_MAC_VLOGICAL 0x8005  /* Mac video logical base */
-#define BI_MAC_SCCBASE  0x8006  /* Mac SCC base address */
-#define BI_MAC_BTIME    0x8007  /* Mac boot time */
-#define BI_MAC_GMTBIAS  0x8008  /* Mac GMT timezone offset */
-#define BI_MAC_MEMSIZE  0x8009  /* Mac RAM size (sanity check) */
-#define BI_MAC_CPUID    0x800a  /* Mac CPU type (sanity check) */
-#define BI_MAC_ROMBASE  0x800b  /* Mac system ROM base address */
-
-/*  Macintosh hardware profile data */
-
-#define BI_MAC_VIA1BASE 0x8010  /* Mac VIA1 base address (always present) */
-#define BI_MAC_VIA2BASE 0x8011  /* Mac VIA2 base address (type varies) */
-#define BI_MAC_VIA2TYPE 0x8012  /* Mac VIA2 type (VIA, RBV, OSS) */
-#define BI_MAC_ADBTYPE  0x8013  /* Mac ADB interface type */
-#define BI_MAC_ASCBASE  0x8014  /* Mac Apple Sound Chip base address */
-#define BI_MAC_SCSI5380 0x8015  /* Mac NCR 5380 SCSI (base address, multi) */
-#define BI_MAC_SCSIDMA  0x8016  /* Mac SCSI DMA (base address) */
-#define BI_MAC_SCSI5396 0x8017  /* Mac NCR 53C96 SCSI (base address, multi) */
-#define BI_MAC_IDETYPE  0x8018  /* Mac IDE interface type */
-#define BI_MAC_IDEBASE  0x8019  /* Mac IDE interface base address */
-#define BI_MAC_NUBUS    0x801a  /* Mac Nubus type (none, regular, pseudo) */
-#define BI_MAC_SLOTMASK 0x801b  /* Mac Nubus slots present */
-#define BI_MAC_SCCTYPE  0x801c  /* Mac SCC serial type (normal, IOP) */
-#define BI_MAC_ETHTYPE  0x801d  /* Mac builtin ethernet type (Sonic, MACE */
-#define BI_MAC_ETHBASE  0x801e  /* Mac builtin ethernet base address */
-#define BI_MAC_PMU      0x801f  /* Mac power management / poweroff hardware */
-#define BI_MAC_IOP_SWIM 0x8020  /* Mac SWIM floppy IOP */
-#define BI_MAC_IOP_ADB  0x8021  /* Mac ADB IOP */
 
 #define BOOTINFO0(as, base, id) \
     do { \
diff --git a/include/standard-headers/asm-m68k/bootinfo-mac.h b/include/standard-headers/asm-m68k/bootinfo-mac.h
new file mode 100644
index 000000000000..449928cfcbf2
--- /dev/null
+++ b/include/standard-headers/asm-m68k/bootinfo-mac.h
@@ -0,0 +1,120 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+** asm/bootinfo-mac.h -- Macintosh-specific boot information definitions
+*/
+
+#ifndef _UAPI_ASM_M68K_BOOTINFO_MAC_H
+#define _UAPI_ASM_M68K_BOOTINFO_MAC_H
+
+
+    /*
+     *  Macintosh-specific tags (all __be32)
+     */
+
+#define BI_MAC_MODEL		0x8000	/* Mac Gestalt ID (model type) */
+#define BI_MAC_VADDR		0x8001	/* Mac video base address */
+#define BI_MAC_VDEPTH		0x8002	/* Mac video depth */
+#define BI_MAC_VROW		0x8003	/* Mac video rowbytes */
+#define BI_MAC_VDIM		0x8004	/* Mac video dimensions */
+#define BI_MAC_VLOGICAL		0x8005	/* Mac video logical base */
+#define BI_MAC_SCCBASE		0x8006	/* Mac SCC base address */
+#define BI_MAC_BTIME		0x8007	/* Mac boot time */
+#define BI_MAC_GMTBIAS		0x8008	/* Mac GMT timezone offset */
+#define BI_MAC_MEMSIZE		0x8009	/* Mac RAM size (sanity check) */
+#define BI_MAC_CPUID		0x800a	/* Mac CPU type (sanity check) */
+#define BI_MAC_ROMBASE		0x800b	/* Mac system ROM base address */
+
+
+    /*
+     *  Macintosh hardware profile data - unused, see macintosh.h for
+     *  reasonable type values
+     */
+
+#define BI_MAC_VIA1BASE		0x8010	/* Mac VIA1 base address (always present) */
+#define BI_MAC_VIA2BASE		0x8011	/* Mac VIA2 base address (type varies) */
+#define BI_MAC_VIA2TYPE		0x8012	/* Mac VIA2 type (VIA, RBV, OSS) */
+#define BI_MAC_ADBTYPE		0x8013	/* Mac ADB interface type */
+#define BI_MAC_ASCBASE		0x8014	/* Mac Apple Sound Chip base address */
+#define BI_MAC_SCSI5380		0x8015	/* Mac NCR 5380 SCSI (base address, multi) */
+#define BI_MAC_SCSIDMA		0x8016	/* Mac SCSI DMA (base address) */
+#define BI_MAC_SCSI5396		0x8017	/* Mac NCR 53C96 SCSI (base address, multi) */
+#define BI_MAC_IDETYPE		0x8018	/* Mac IDE interface type */
+#define BI_MAC_IDEBASE		0x8019	/* Mac IDE interface base address */
+#define BI_MAC_NUBUS		0x801a	/* Mac Nubus type (none, regular, pseudo) */
+#define BI_MAC_SLOTMASK		0x801b	/* Mac Nubus slots present */
+#define BI_MAC_SCCTYPE		0x801c	/* Mac SCC serial type (normal, IOP) */
+#define BI_MAC_ETHTYPE		0x801d	/* Mac builtin ethernet type (Sonic, MACE */
+#define BI_MAC_ETHBASE		0x801e	/* Mac builtin ethernet base address */
+#define BI_MAC_PMU		0x801f	/* Mac power management / poweroff hardware */
+#define BI_MAC_IOP_SWIM		0x8020	/* Mac SWIM floppy IOP */
+#define BI_MAC_IOP_ADB		0x8021	/* Mac ADB IOP */
+
+
+    /*
+     * Macintosh Gestalt numbers (BI_MAC_MODEL)
+     */
+
+#define MAC_MODEL_II		6
+#define MAC_MODEL_IIX		7
+#define MAC_MODEL_IICX		8
+#define MAC_MODEL_SE30		9
+#define MAC_MODEL_IICI		11
+#define MAC_MODEL_IIFX		13	/* And well numbered it is too */
+#define MAC_MODEL_IISI		18
+#define MAC_MODEL_LC		19
+#define MAC_MODEL_Q900		20
+#define MAC_MODEL_PB170		21
+#define MAC_MODEL_Q700		22
+#define MAC_MODEL_CLII		23	/* aka: P200 */
+#define MAC_MODEL_PB140		25
+#define MAC_MODEL_Q950		26	/* aka: WGS95 */
+#define MAC_MODEL_LCIII		27	/* aka: P450 */
+#define MAC_MODEL_PB210		29
+#define MAC_MODEL_C650		30
+#define MAC_MODEL_PB230		32
+#define MAC_MODEL_PB180		33
+#define MAC_MODEL_PB160		34
+#define MAC_MODEL_Q800		35	/* aka: WGS80 */
+#define MAC_MODEL_Q650		36
+#define MAC_MODEL_LCII		37	/* aka: P400/405/410/430 */
+#define MAC_MODEL_PB250		38
+#define MAC_MODEL_IIVI		44
+#define MAC_MODEL_P600		45	/* aka: P600CD */
+#define MAC_MODEL_IIVX		48
+#define MAC_MODEL_CCL		49	/* aka: P250 */
+#define MAC_MODEL_PB165C	50
+#define MAC_MODEL_C610		52	/* aka: WGS60 */
+#define MAC_MODEL_Q610		53
+#define MAC_MODEL_PB145		54	/* aka: PB145B */
+#define MAC_MODEL_P520		56	/* aka: LC520 */
+#define MAC_MODEL_C660		60
+#define MAC_MODEL_P460		62	/* aka: LCIII+, P466/P467 */
+#define MAC_MODEL_PB180C	71
+#define MAC_MODEL_PB520		72	/* aka: PB520C, PB540, PB540C, PB550C */
+#define MAC_MODEL_PB270C	77
+#define MAC_MODEL_Q840		78
+#define MAC_MODEL_P550		80	/* aka: LC550, P560 */
+#define MAC_MODEL_CCLII		83	/* aka: P275 */
+#define MAC_MODEL_PB165		84
+#define MAC_MODEL_PB190		85	/* aka: PB190CS */
+#define MAC_MODEL_TV		88
+#define MAC_MODEL_P475		89	/* aka: LC475, P476 */
+#define MAC_MODEL_P475F		90	/* aka: P475 w/ FPU (no LC040) */
+#define MAC_MODEL_P575		92	/* aka: LC575, P577/P578 */
+#define MAC_MODEL_Q605		94
+#define MAC_MODEL_Q605_ACC	95	/* Q605 accelerated to 33 MHz */
+#define MAC_MODEL_Q630		98	/* aka: LC630, P630/631/635/636/637/638/640 */
+#define MAC_MODEL_P588		99	/* aka: LC580, P580 */
+#define MAC_MODEL_PB280		102
+#define MAC_MODEL_PB280C	103
+#define MAC_MODEL_PB150		115
+
+
+    /*
+     *  Latest Macintosh bootinfo version
+     */
+
+#define MAC_BOOTI_VERSION	MK_BI_VERSION(2, 0)
+
+
+#endif /* _UAPI_ASM_M68K_BOOTINFO_MAC_H */
diff --git a/include/standard-headers/asm-m68k/bootinfo.h b/include/standard-headers/asm-m68k/bootinfo.h
new file mode 100644
index 000000000000..7b790e8ec8d6
--- /dev/null
+++ b/include/standard-headers/asm-m68k/bootinfo.h
@@ -0,0 +1,166 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * asm/bootinfo.h -- Definition of the Linux/m68k boot information structure
+ *
+ * Copyright 1992 by Greg Harp
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file COPYING in the main directory of this archive
+ * for more details.
+ */
+
+#ifndef _UAPI_ASM_M68K_BOOTINFO_H
+#define _UAPI_ASM_M68K_BOOTINFO_H
+
+
+    /*
+     *  Bootinfo definitions
+     *
+     *  This is an easily parsable and extendable structure containing all
+     *  information to be passed from the bootstrap to the kernel.
+     *
+     *  This way I hope to keep all future changes back/forewards compatible.
+     *  Thus, keep your fingers crossed...
+     *
+     *  This structure is copied right after the kernel by the bootstrap
+     *  routine.
+     */
+
+struct bi_record {
+	uint16_t tag;			/* tag ID */
+	uint16_t size;			/* size of record (in bytes) */
+	uint32_t data[0];			/* data */
+};
+
+
+struct mem_info {
+	uint32_t addr;			/* physical address of memory chunk */
+	uint32_t size;			/* length of memory chunk (in bytes) */
+};
+
+
+    /*
+     *  Tag Definitions
+     *
+     *  Machine independent tags start counting from 0x0000
+     *  Machine dependent tags start counting from 0x8000
+     */
+
+#define BI_LAST			0x0000	/* last record (sentinel) */
+#define BI_MACHTYPE		0x0001	/* machine type (uint32_t) */
+#define BI_CPUTYPE		0x0002	/* cpu type (uint32_t) */
+#define BI_FPUTYPE		0x0003	/* fpu type (uint32_t) */
+#define BI_MMUTYPE		0x0004	/* mmu type (uint32_t) */
+#define BI_MEMCHUNK		0x0005	/* memory chunk address and size */
+					/* (struct mem_info) */
+#define BI_RAMDISK		0x0006	/* ramdisk address and size */
+					/* (struct mem_info) */
+#define BI_COMMAND_LINE		0x0007	/* kernel command line parameters */
+					/* (string) */
+
+
+    /*
+     *  Linux/m68k Architectures (BI_MACHTYPE)
+     */
+
+#define MACH_AMIGA		1
+#define MACH_ATARI		2
+#define MACH_MAC		3
+#define MACH_APOLLO		4
+#define MACH_SUN3		5
+#define MACH_MVME147		6
+#define MACH_MVME16x		7
+#define MACH_BVME6000		8
+#define MACH_HP300		9
+#define MACH_Q40		10
+#define MACH_SUN3X		11
+#define MACH_M54XX		12
+#define MACH_M5441X		13
+#define MACH_VIRT		14
+
+
+    /*
+     *  CPU, FPU and MMU types (BI_CPUTYPE, BI_FPUTYPE, BI_MMUTYPE)
+     *
+     *  Note: we may rely on the following equalities:
+     *
+     *      CPU_68020 == MMU_68851
+     *      CPU_68030 == MMU_68030
+     *      CPU_68040 == FPU_68040 == MMU_68040
+     *      CPU_68060 == FPU_68060 == MMU_68060
+     */
+
+#define CPUB_68020		0
+#define CPUB_68030		1
+#define CPUB_68040		2
+#define CPUB_68060		3
+#define CPUB_COLDFIRE		4
+
+#define CPU_68020		(1 << CPUB_68020)
+#define CPU_68030		(1 << CPUB_68030)
+#define CPU_68040		(1 << CPUB_68040)
+#define CPU_68060		(1 << CPUB_68060)
+#define CPU_COLDFIRE		(1 << CPUB_COLDFIRE)
+
+#define FPUB_68881		0
+#define FPUB_68882		1
+#define FPUB_68040		2	/* Internal FPU */
+#define FPUB_68060		3	/* Internal FPU */
+#define FPUB_SUNFPA		4	/* Sun-3 FPA */
+#define FPUB_COLDFIRE		5	/* ColdFire FPU */
+
+#define FPU_68881		(1 << FPUB_68881)
+#define FPU_68882		(1 << FPUB_68882)
+#define FPU_68040		(1 << FPUB_68040)
+#define FPU_68060		(1 << FPUB_68060)
+#define FPU_SUNFPA		(1 << FPUB_SUNFPA)
+#define FPU_COLDFIRE		(1 << FPUB_COLDFIRE)
+
+#define MMUB_68851		0
+#define MMUB_68030		1	/* Internal MMU */
+#define MMUB_68040		2	/* Internal MMU */
+#define MMUB_68060		3	/* Internal MMU */
+#define MMUB_APOLLO		4	/* Custom Apollo */
+#define MMUB_SUN3		5	/* Custom Sun-3 */
+#define MMUB_COLDFIRE		6	/* Internal MMU */
+
+#define MMU_68851		(1 << MMUB_68851)
+#define MMU_68030		(1 << MMUB_68030)
+#define MMU_68040		(1 << MMUB_68040)
+#define MMU_68060		(1 << MMUB_68060)
+#define MMU_SUN3		(1 << MMUB_SUN3)
+#define MMU_APOLLO		(1 << MMUB_APOLLO)
+#define MMU_COLDFIRE		(1 << MMUB_COLDFIRE)
+
+
+    /*
+     * Stuff for bootinfo interface versioning
+     *
+     * At the start of kernel code, a 'struct bootversion' is located.
+     * bootstrap checks for a matching version of the interface before booting
+     * a kernel, to avoid user confusion if kernel and bootstrap don't work
+     * together :-)
+     *
+     * If incompatible changes are made to the bootinfo interface, the major
+     * number below should be stepped (and the minor reset to 0) for the
+     * appropriate machine. If a change is backward-compatible, the minor
+     * should be stepped. "Backwards-compatible" means that booting will work,
+     * but certain features may not.
+     */
+
+#define BOOTINFOV_MAGIC			0x4249561A	/* 'BIV^Z' */
+#define MK_BI_VERSION(major, minor)	(((major) << 16) + (minor))
+#define BI_VERSION_MAJOR(v)		(((v) >> 16) & 0xffff)
+#define BI_VERSION_MINOR(v)		((v) & 0xffff)
+
+struct bootversion {
+	uint16_t branch;
+	uint32_t magic;
+	struct {
+		uint32_t machtype;
+		uint32_t version;
+	} machversions[0];
+} QEMU_PACKED;
+
+
+#endif /* _UAPI_ASM_M68K_BOOTINFO_H */
diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
index ce4b47c3e34d..961044b3aca1 100644
--- a/hw/m68k/q800.c
+++ b/hw/m68k/q800.c
@@ -35,6 +35,8 @@
 #include "hw/char/escc.h"
 #include "hw/sysbus.h"
 #include "hw/scsi/esp.h"
+#include "standard-headers/asm-m68k/bootinfo.h"
+#include "standard-headers/asm-m68k/bootinfo-mac.h"
 #include "bootinfo.h"
 #include "hw/misc/mac_via.h"
 #include "hw/input/adb.h"
@@ -52,14 +54,6 @@
 
 #define MACROM_FILENAME "MacROM.bin"
 
-#define Q800_MACHINE_ID 35
-#define Q800_CPU_ID (1 << 2)
-#define Q800_FPU_ID (1 << 2)
-#define Q800_MMU_ID (1 << 2)
-
-#define MACH_MAC        3
-#define Q800_MAC_CPU_ID 2
-
 #define IO_BASE               0x50000000
 #define IO_SLICE              0x00040000
 #define IO_SIZE               0x04000000
@@ -348,11 +342,11 @@ static void q800_init(MachineState *machine)
         parameters_base = (high + 1) & ~1;
 
         BOOTINFO1(cs->as, parameters_base, BI_MACHTYPE, MACH_MAC);
-        BOOTINFO1(cs->as, parameters_base, BI_FPUTYPE, Q800_FPU_ID);
-        BOOTINFO1(cs->as, parameters_base, BI_MMUTYPE, Q800_MMU_ID);
-        BOOTINFO1(cs->as, parameters_base, BI_CPUTYPE, Q800_CPU_ID);
-        BOOTINFO1(cs->as, parameters_base, BI_MAC_CPUID, Q800_MAC_CPU_ID);
-        BOOTINFO1(cs->as, parameters_base, BI_MAC_MODEL, Q800_MACHINE_ID);
+        BOOTINFO1(cs->as, parameters_base, BI_FPUTYPE, FPU_68040);
+        BOOTINFO1(cs->as, parameters_base, BI_MMUTYPE, MMU_68040);
+        BOOTINFO1(cs->as, parameters_base, BI_CPUTYPE, CPU_68040);
+        BOOTINFO1(cs->as, parameters_base, BI_MAC_CPUID, CPUB_68040);
+        BOOTINFO1(cs->as, parameters_base, BI_MAC_MODEL, MAC_MODEL_Q800);
         BOOTINFO1(cs->as, parameters_base,
                   BI_MAC_MEMSIZE, ram_size >> 20); /* in MB */
         BOOTINFO2(cs->as, parameters_base, BI_MEMCHUNK, 0, ram_size);
diff --git a/MAINTAINERS b/MAINTAINERS
index 47dd38a8cc5d..d0962a22e1b4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1094,6 +1094,8 @@ F: hw/nubus/*
 F: hw/display/macfb.c
 F: hw/block/swim.c
 F: hw/m68k/bootinfo.h
+F: include/standard-headers/asm-m68k/bootinfo.h
+F: include/standard-headers/asm-m68k/bootinfo-mac.h
 F: include/hw/misc/mac_via.h
 F: include/hw/nubus/*
 F: include/hw/display/macfb.h
-- 
2.26.2


