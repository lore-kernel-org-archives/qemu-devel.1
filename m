Return-Path: <SRS0=HPkn=YN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 869D0CA9EA0
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Oct 2019 20:49:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5116E20869
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Oct 2019 20:49:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=duncanthrax.net header.i=@duncanthrax.net header.b="qRFT3ReI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5116E20869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=stackframe.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMI8O-0004m0-As
	for qemu-devel@archiver.kernel.org; Sun, 20 Oct 2019 16:49:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52475)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <svens@stackframe.org>) id 1iMI6t-0003Wz-5n
 for qemu-devel@nongnu.org; Sun, 20 Oct 2019 16:47:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <svens@stackframe.org>) id 1iMI6s-0001AB-2B
 for qemu-devel@nongnu.org; Sun, 20 Oct 2019 16:47:31 -0400
Received: from smtp.duncanthrax.net ([2001:470:70c5:1111::170]:40821)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <svens@stackframe.org>)
 id 1iMI6r-00019l-Gy
 for qemu-devel@nongnu.org; Sun, 20 Oct 2019 16:47:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=duncanthrax.net; s=dkim; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From;
 bh=dwkWskxsx7FPaiyaMKPPvOg3v6bui3kx1ke0toivyko=; b=qRFT3ReIrM0/3mNke9eJ0O6X/F
 Vujlq/3Ksp0rc3RLYq2/2MTki4EkLzIaqKzS9tn+3iHv3DB5Us/Vc3n6TMhbklU1mk9KHV10w7nde
 h5WdZMIz3apHi6ZvTxWxdN+lf6ouB7in41zqBSr+5sdH3tfRSvndcu+jztB5cFn1un7M=;
Received: from hsi-kbw-046-005-233-221.hsi8.kabel-badenwuerttemberg.de
 ([46.5.233.221] helo=x280.stackframe.org)
 by smtp.eurescom.eu with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.86_2) (envelope-from <svens@stackframe.org>)
 id 1iMI6p-0002cH-Tv; Sun, 20 Oct 2019 22:47:27 +0200
From: Sven Schnelle <svens@stackframe.org>
To: Richard Henderson <rth@twiddle.net>
Subject: [PATCH 3/7] hppa: remove ISA region
Date: Sun, 20 Oct 2019 22:47:20 +0200
Message-Id: <20191020204724.31537-4-svens@stackframe.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191020204724.31537-1-svens@stackframe.org>
References: <20191020204724.31537-1-svens@stackframe.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2001:470:70c5:1111::170
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
Cc: Helge Deller <deller@gmx.de>, Sven Schnelle <svens@stackframe.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

B160L doesn't have an ISA bus, and we no longer need it to
workaround missing hardware, so remove it.

Signed-off-by: Sven Schnelle <svens@stackframe.org>
---
 hw/hppa/hppa_hardware.h |  1 -
 hw/hppa/machine.c       | 32 --------------------------------
 2 files changed, 33 deletions(-)

diff --git a/hw/hppa/hppa_hardware.h b/hw/hppa/hppa_hardware.h
index 507f91e05d..ce59cbbf94 100644
--- a/hw/hppa/hppa_hardware.h
+++ b/hw/hppa/hppa_hardware.h
@@ -26,7 +26,6 @@
 #define MEMORY_HPA      0xfffbf000
 
 #define PCI_HPA         DINO_HPA        /* PCI bus */
-#define IDE_HPA         0xf9000000      /* Boot disc controller */
 
 /* offsets to DINO HPA: */
 #define DINO_PCI_ADDR           0x064
diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index 65fc20ebed..542faae9be 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -22,30 +22,6 @@
 #include "qapi/error.h"
 #include "qemu/log.h"
 
-#define MAX_IDE_BUS 2
-
-static ISABus *hppa_isa_bus(void)
-{
-    ISABus *isa_bus;
-    qemu_irq *isa_irqs;
-    MemoryRegion *isa_region;
-
-    isa_region = g_new(MemoryRegion, 1);
-    memory_region_init_io(isa_region, NULL, &hppa_pci_ignore_ops,
-                          NULL, "isa-io", 0x800);
-    memory_region_add_subregion(get_system_memory(), IDE_HPA,
-                                isa_region);
-
-    isa_bus = isa_bus_new(NULL, get_system_memory(), isa_region,
-                          &error_abort);
-    isa_irqs = i8259_init(isa_bus,
-                          /* qemu_allocate_irq(dino_set_isa_irq, s, 0)); */
-                          NULL);
-    isa_bus_irqs(isa_bus, isa_irqs);
-
-    return isa_bus;
-}
-
 static uint64_t cpu_hppa_to_phys(void *opaque, uint64_t addr)
 {
     addr &= (0x10000000 - 1);
@@ -62,7 +38,6 @@ static void machine_hppa_init(MachineState *machine)
     const char *initrd_filename = machine->initrd_filename;
     DeviceState *dev;
     PCIBus *pci_bus;
-    ISABus *isa_bus;
     qemu_irq rtc_irq, serial_irq;
     char *firmware_filename;
     uint64_t firmware_low, firmware_high;
@@ -108,13 +83,6 @@ static void machine_hppa_init(MachineState *machine)
     pci_bus = dino_init(addr_space, &rtc_irq, &serial_irq);
     assert(pci_bus);
 
-    /* Create ISA bus. */
-    isa_bus = hppa_isa_bus();
-    assert(isa_bus);
-
-    /* Realtime clock, used by firmware for PDC_TOD call. */
-    mc146818_rtc_init(isa_bus, 2000, rtc_irq);
-
     /* Serial code setup.  */
     if (serial_hd(0)) {
         uint32_t addr = DINO_UART_HPA + 0x800;
-- 
2.23.0


