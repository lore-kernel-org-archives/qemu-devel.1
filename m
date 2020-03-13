Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD681C5ACC0
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 21:28:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A50A720767
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 21:28:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A50A720767
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37814 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCrrB-0007yG-S4
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 17:28:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46652)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1jCrlz-0007mx-6n
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 17:23:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1jCrlx-0000QL-1u
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 17:23:15 -0400
Received: from zero.eik.bme.hu ([152.66.115.2]:57630)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>)
 id 1jCrlr-0008TF-CM; Fri, 13 Mar 2020 17:23:09 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id B314E747E1B;
 Fri, 13 Mar 2020 22:23:05 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 7C6C1747E13; Fri, 13 Mar 2020 22:23:05 +0100 (CET)
Message-Id: <eb14ddee41be26f38ee0fe5ff0ff42c79afe9731.1584134074.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1584134074.git.balaton@eik.bme.hu>
References: <cover.1584134074.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH 4/8] hw/ide: Move MAX_IDE_BUS define to one header
Date: Fri, 13 Mar 2020 22:14:34 +0100
To: qemu-devel@nongnu.org,
    qemu-block@nongnu.org
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 152.66.115.2
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, John Snow <jsnow@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, hpoussin@reactos.org,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, philmd@redhat.com,
 Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There are several definitions of MAX_IDE_BUS in different boards (some
of them unused) with the same value. Move it to include/hw/ide/internal.h
to have it in a central place.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/alpha/dp264.c          | 2 --
 hw/hppa/machine.c         | 2 --
 hw/i386/pc_piix.c         | 2 --
 hw/mips/mips_fulong2e.c   | 1 -
 hw/mips/mips_malta.c      | 4 +---
 hw/mips/mips_r4k.c        | 4 +---
 hw/ppc/mac_newworld.c     | 1 -
 hw/ppc/mac_oldworld.c     | 1 -
 hw/ppc/prep.c             | 2 --
 hw/sparc64/sun4u.c        | 1 -
 include/hw/ide/internal.h | 2 ++
 11 files changed, 4 insertions(+), 18 deletions(-)

diff --git a/hw/alpha/dp264.c b/hw/alpha/dp264.c
index 27595767e5..0f58b1b668 100644
--- a/hw/alpha/dp264.c
+++ b/hw/alpha/dp264.c
@@ -24,8 +24,6 @@
 #include "qemu/cutils.h"
 #include "net/net.h"
 
-#define MAX_IDE_BUS 2
-
 static uint64_t cpu_alpha_superpage_to_phys(void *opaque, uint64_t addr)
 {
     if (((addr >> 41) & 3) == 2) {
diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index 9175f4b790..1f9a390f99 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -24,8 +24,6 @@
 #include "qemu/log.h"
 #include "net/net.h"
 
-#define MAX_IDE_BUS 2
-
 static ISABus *hppa_isa_bus(void)
 {
     ISABus *isa_bus;
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index c399398739..b363a69e2e 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -63,8 +63,6 @@
 #include "sysemu/numa.h"
 #include "hw/mem/nvdimm.h"
 
-#define MAX_IDE_BUS 2
-
 #ifdef CONFIG_IDE_ISA
 static const int ide_iobase[MAX_IDE_BUS] = { 0x1f0, 0x170 };
 static const int ide_iobase2[MAX_IDE_BUS] = { 0x3f6, 0x376 };
diff --git a/hw/mips/mips_fulong2e.c b/hw/mips/mips_fulong2e.c
index 639ba2a091..3690b76061 100644
--- a/hw/mips/mips_fulong2e.c
+++ b/hw/mips/mips_fulong2e.c
@@ -55,7 +55,6 @@
 
 /* fulong 2e has a 512k flash: Winbond W39L040AP70Z */
 #define BIOS_SIZE               (512 * KiB)
-#define MAX_IDE_BUS             2
 
 /*
  * PMON is not part of qemu and released with BSD license, anyone
diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
index d380f73d7b..6f51e33e7b 100644
--- a/hw/mips/mips_malta.c
+++ b/hw/mips/mips_malta.c
@@ -40,7 +40,7 @@
 #include "sysemu/arch_init.h"
 #include "qemu/log.h"
 #include "hw/mips/bios.h"
-#include "hw/ide.h"
+#include "hw/ide/internal.h"
 #include "hw/irq.h"
 #include "hw/loader.h"
 #include "elf.h"
@@ -68,8 +68,6 @@
 
 #define FLASH_SIZE          0x400000
 
-#define MAX_IDE_BUS         2
-
 typedef struct {
     MemoryRegion iomem;
     MemoryRegion iomem_lo; /* 0 - 0x900 */
diff --git a/hw/mips/mips_r4k.c b/hw/mips/mips_r4k.c
index ad8b75e286..2e5372bda0 100644
--- a/hw/mips/mips_r4k.c
+++ b/hw/mips/mips_r4k.c
@@ -25,7 +25,7 @@
 #include "hw/block/flash.h"
 #include "qemu/log.h"
 #include "hw/mips/bios.h"
-#include "hw/ide.h"
+#include "hw/ide/internal.h"
 #include "hw/loader.h"
 #include "elf.h"
 #include "hw/rtc/mc146818rtc.h"
@@ -37,8 +37,6 @@
 #include "sysemu/runstate.h"
 #include "qemu/error-report.h"
 
-#define MAX_IDE_BUS 2
-
 static const int ide_iobase[2] = { 0x1f0, 0x170 };
 static const int ide_iobase2[2] = { 0x3f6, 0x376 };
 static const int ide_irq[2] = { 14, 15 };
diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
index b8189bf7a4..daa1523feb 100644
--- a/hw/ppc/mac_newworld.c
+++ b/hw/ppc/mac_newworld.c
@@ -75,7 +75,6 @@
 #include "hw/sysbus.h"
 #include "trace.h"
 
-#define MAX_IDE_BUS 2
 #define CFG_ADDR 0xf0000510
 #define TBFREQ (100UL * 1000UL * 1000UL)
 #define CLOCKFREQ (900UL * 1000UL * 1000UL)
diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
index 440c406eb4..2478748c78 100644
--- a/hw/ppc/mac_oldworld.c
+++ b/hw/ppc/mac_oldworld.c
@@ -51,7 +51,6 @@
 #include "kvm_ppc.h"
 #include "exec/address-spaces.h"
 
-#define MAX_IDE_BUS 2
 #define CFG_ADDR 0xf0000510
 #define TBFREQ 16600000UL
 #define CLOCKFREQ 266000000UL
diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
index 111cc80867..e1b1549e58 100644
--- a/hw/ppc/prep.c
+++ b/hw/ppc/prep.c
@@ -56,8 +56,6 @@
 /* SMP is not enabled, for now */
 #define MAX_CPUS 1
 
-#define MAX_IDE_BUS 2
-
 #define CFG_ADDR 0xf0000510
 
 #define KERNEL_LOAD_ADDR 0x01000000
diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
index d33e84f831..74acfd39b3 100644
--- a/hw/sparc64/sun4u.c
+++ b/hw/sparc64/sun4u.c
@@ -66,7 +66,6 @@
 #define PBM_PCI_IO_BASE      (PBM_SPECIAL_BASE + 0x02000000ULL)
 #define PROM_FILENAME        "openbios-sparc64"
 #define NVRAM_SIZE           0x2000
-#define MAX_IDE_BUS          2
 #define BIOS_CFG_IOPORT      0x510
 #define FW_CFG_SPARC64_WIDTH (FW_CFG_ARCH_LOCAL + 0x00)
 #define FW_CFG_SPARC64_HEIGHT (FW_CFG_ARCH_LOCAL + 0x01)
diff --git a/include/hw/ide/internal.h b/include/hw/ide/internal.h
index 1bc1fc73e5..1a49d35959 100644
--- a/include/hw/ide/internal.h
+++ b/include/hw/ide/internal.h
@@ -27,6 +27,8 @@ typedef struct IDEDMAOps IDEDMAOps;
 #define TYPE_IDE_BUS "IDE"
 #define IDE_BUS(obj) OBJECT_CHECK(IDEBus, (obj), TYPE_IDE_BUS)
 
+#define MAX_IDE_BUS 2
+
 /* Bits of HD_STATUS */
 #define ERR_STAT		0x01
 #define INDEX_STAT		0x02
-- 
2.21.1


