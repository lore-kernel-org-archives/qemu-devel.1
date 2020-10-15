Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D46D4C433E7
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 19:50:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38138206DD
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 19:50:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rjRUqZRF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38138206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52662 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kT9Go-0005SK-8Q
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 15:50:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57224)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kT9DL-0002Rh-Ms; Thu, 15 Oct 2020 15:47:04 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:36275)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kT9DK-0007Af-09; Thu, 15 Oct 2020 15:47:03 -0400
Received: by mail-wm1-x342.google.com with SMTP id e2so266218wme.1;
 Thu, 15 Oct 2020 12:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=BpLyEF4lsBlmsqCz036I9WHuVtmpK50cd9Lhjaym5ic=;
 b=rjRUqZRFdwHkaiqMXKbFjikxw2uKT/z/skHRNn66y5Ij4KSuzqClMvgsM8SV5E6Klr
 lMrmK6UL3N938pfaja+cI1iwxpVIu9Zo65bHn/LL2jqMXA6E6KgULduQt00D9bVnIwLk
 T5GLqYTxIIr1856PD1D5+5m2uT9+i8hBXkR5I6ZIGX8vPvrwsvKem3kj2OqrasAXV4EW
 Vg9/G6WPY9m+X7OY94K2lJ8VysFNlzblwIboZKbq2kNqCcTJESPntMUhBi1piLIecvHo
 G2qUqbXPJw2XZvC6gMZS3r8lWJFYM6weJ2Bd/8FEaztdaRAqhMW1R8lvOa5BHhsCYO9C
 KWdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=BpLyEF4lsBlmsqCz036I9WHuVtmpK50cd9Lhjaym5ic=;
 b=eqTwLBaLZJD3QGQhFYXjSVfxcePWDqdHmgZy7Leb7sZUE2JKIkXBItu6AVEeHPRfIC
 ps7WGKOH0G9C3JNO4DXoQOAhZe87EQM6iQvHjhtFPbAx2efBwxuIz1q1CVSWcwx0n9OH
 0lwdgdi64Ai/5FWLRkpMnvfM5erOKwE78q/eN9Z/OWgKoPyM9BeaE7uPEzbRB735MmQw
 tGxZL0YeD9xCov5gDb60iCx6HcjAaA8D65OLNIKxIT1Su38P/a9cT7ZY00kzCeD5b/OQ
 T411GItpWRTjwUm5YqzEGVgqxnIqodRp6jUsVARC8NAfk6yDFEXOSTGsQQ49C0+/A/7I
 hPaw==
X-Gm-Message-State: AOAM533xk8y2NmEqZASTRD0RP/aYMm4WsGBNBpQYwbW31oYeunQhDhHe
 4NPxHCMNSce5WXT9dA+0UPHli8UXXpM=
X-Google-Smtp-Source: ABdhPJwyYdDf4ugiKS5iqxNyAqLPXgnC4yHrPOAMGOOyc1Dd7OOAsP3eyaKJcuiGBqFcyHb44lJS9Q==
X-Received: by 2002:a1c:3:: with SMTP id 3mr279581wma.14.1602791219298;
 Thu, 15 Oct 2020 12:46:59 -0700 (PDT)
Received: from localhost.localdomain
 (106.red-83-59-162.dynamicip.rima-tde.net. [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id 205sm63372wme.38.2020.10.15.12.46.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2020 12:46:58 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 2/2] hw/rtc/m48t59: Simplify m48t59_init() passing
 MemoryRegion argument
Date: Thu, 15 Oct 2020 21:46:47 +0200
Message-Id: <20201015194647.477252-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201015194647.477252-1-f4bug@amsat.org>
References: <20201015194647.477252-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.248,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.248,
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
Cc: qemu-trivial@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 qemu-ppc@nongnu.org, Artyom Tarasenko <atar4qemu@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Pass a MemoryRegion* to m48t59_init(), directly call
memory_region_add_subregion() instead of sysbus_mmio_map().

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/rtc/m48t59.h |  2 +-
 hw/ppc/ppc405_boards.c  |  2 +-
 hw/rtc/m48t59.c         | 10 +++-------
 hw/sparc/sun4m.c        |  3 ++-
 hw/sparc64/sun4u.c      |  7 ++-----
 5 files changed, 9 insertions(+), 15 deletions(-)

diff --git a/include/hw/rtc/m48t59.h b/include/hw/rtc/m48t59.h
index d99dda2b7de..3c337e8171c 100644
--- a/include/hw/rtc/m48t59.h
+++ b/include/hw/rtc/m48t59.h
@@ -49,7 +49,7 @@ struct NvramClass {
 
 Nvram *m48t59_init_isa(ISABus *bus, uint32_t io_base, uint16_t size,
                        int base_year, int type);
-Nvram *m48t59_init(qemu_irq IRQ, hwaddr mem_base,
+Nvram *m48t59_init(MemoryRegion *mr, hwaddr mem_base, qemu_irq IRQ,
                    uint16_t size, int base_year, int model);
 
 #endif /* HW_M48T59_H */
diff --git a/hw/ppc/ppc405_boards.c b/hw/ppc/ppc405_boards.c
index 93ffee801a3..6ab1b860545 100644
--- a/hw/ppc/ppc405_boards.c
+++ b/hw/ppc/ppc405_boards.c
@@ -227,7 +227,7 @@ static void ref405ep_init(MachineState *machine)
     /* Register FPGA */
     ref405ep_fpga_init(sysmem, 0xF0300000);
     /* Register NVRAM */
-    m48t59_init(NULL, 0xF0000000, 8192, 1968, 8);
+    m48t59_init(get_system_memory(), 0xF0000000, NULL, 8192, 1968, 8);
     /* Load kernel */
     linux_boot = (kernel_filename != NULL);
     if (linux_boot) {
diff --git a/hw/rtc/m48t59.c b/hw/rtc/m48t59.c
index 8b02c2ec558..7ec4b241218 100644
--- a/hw/rtc/m48t59.c
+++ b/hw/rtc/m48t59.c
@@ -565,9 +565,8 @@ const MemoryRegionOps m48t59_io_ops = {
 };
 
 /* Initialisation routine */
-Nvram *m48t59_init(qemu_irq IRQ, hwaddr mem_base,
-                   uint16_t size, int base_year,
-                   int model)
+Nvram *m48t59_init(MemoryRegion *mr, hwaddr mem_base, qemu_irq IRQ,
+                   uint16_t size, int base_year, int model)
 {
     DeviceState *dev;
     SysBusDevice *s;
@@ -584,10 +583,7 @@ Nvram *m48t59_init(qemu_irq IRQ, hwaddr mem_base,
         s = SYS_BUS_DEVICE(dev);
         sysbus_realize_and_unref(s, &error_fatal);
         sysbus_connect_irq(s, 0, IRQ);
-        if (mem_base != 0) {
-            sysbus_mmio_map(s, 0, mem_base);
-        }
-
+        memory_region_add_subregion(mr, mem_base, sysbus_mmio_get_region(s, 0));
         return NVRAM(s);
     }
 
diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
index 20c1fa41192..aebe9e0df3d 100644
--- a/hw/sparc/sun4m.c
+++ b/hw/sparc/sun4m.c
@@ -966,7 +966,8 @@ static void sun4m_hw_init(const struct sun4m_hwdef *hwdef,
         create_unimplemented_device("SUNW,sx", hwdef->sx_base, 0x2000);
     }
 
-    nvram = m48t59_init(slavio_irq[0], hwdef->nvram_base, 0x2000, 1968, 8);
+    nvram = m48t59_init(get_system_memory(), hwdef->nvram_base, slavio_irq[0],
+                        0x2000, 1968, 8);
 
     slavio_timer_init_all(hwdef->counter_base, slavio_irq[19], slavio_cpu_irq, smp_cpus);
 
diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
index 6854522bbfa..4c975c25274 100644
--- a/hw/sparc64/sun4u.c
+++ b/hw/sparc64/sun4u.c
@@ -561,7 +561,6 @@ static void sun4uv_init(MemoryRegion *address_space_mem,
     SabreState *sabre;
     PCIBus *pci_bus, *pci_busA, *pci_busB;
     PCIDevice *ebus, *pci_dev;
-    SysBusDevice *s;
     DeviceState *iommu, *dev;
     FWCfgState *fw_cfg;
     NICInfo *nd;
@@ -671,10 +670,8 @@ static void sun4uv_init(MemoryRegion *address_space_mem,
     pci_ide_create_devs(pci_dev);
 
     /* Map NVRAM into I/O (ebus) space */
-    nvram = m48t59_init(NULL, 0, NVRAM_SIZE, 1968, 59);
-    s = SYS_BUS_DEVICE(nvram);
-    memory_region_add_subregion(pci_address_space_io(ebus), 0x2000,
-                                sysbus_mmio_get_region(s, 0));
+    nvram = m48t59_init(pci_address_space_io(ebus), 0x2000, NULL,
+                        NVRAM_SIZE, 1968, 59);
  
     initrd_size = 0;
     initrd_addr = 0;
-- 
2.26.2


