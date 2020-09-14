Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AB51C2BC11
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 10:25:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B28642078D
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 10:25:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LLQzDrtb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B28642078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34004 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHlfq-0004PU-PO
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 06:25:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34430)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kHley-0003ij-2h; Mon, 14 Sep 2020 06:24:32 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:33090)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kHlew-0000IG-HH; Mon, 14 Sep 2020 06:24:31 -0400
Received: by mail-wr1-x443.google.com with SMTP id m6so18125431wrn.0;
 Mon, 14 Sep 2020 03:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=xdg3/apUjZJVOlOfnD/BCFpWvd7I8+hMge8okefApw8=;
 b=LLQzDrtbolAP58qXEfMDXnXdeehVqPXF927w/ej9VNt5PlBoX6iFuO8QwRpew5qtH9
 UNhE/y2FJNjK+WbXPgpgjqtPcPiNhrcaMVBnJcQJezcaBGlVDZEzJzPtR9HfMm8JaHJH
 tk2H932yaNHff7v0EGJLxNsDcSPx1UietwZm96foNV3h5LP8vCJE2f69huJpKc36Z/2U
 BaHDbohFZ0HlE29FNHfDapoIlL0d1+gwWNdug429NWxSn/7oVmY7H/FllQpI9nMoLnbb
 yZAgj6DUwH6xQzba+TUPKpyXg6zUHzC5iuiVehYo9qBeMK/+ulhbpdwZfPCQY7HG/NbW
 q5Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=xdg3/apUjZJVOlOfnD/BCFpWvd7I8+hMge8okefApw8=;
 b=UA28mDmpo0/rVzLiZbqkHeilnZF1qi2eMNftftYDkT6veAJ8tDv7VGc0x1Z+Id3bCQ
 RIUiBHVIMNpw1cC2ygcTF7t/9Tdvtc+ucfeBSjhsIEVkQmDpZjVpvgWhNuYhSKEQ2mCZ
 kw/FZiwgm/DCH8iP3snpjrmA0R24fI0Buv3uEvxMHr/HjdCZ41ACCopfUQJ+TgSbXRR0
 oNMdJ8bm+qMRKPJ3osI3OSKgElCkEeQa1pBdG+qGTJst5iZ+19/yddJkf/Mbc1DViAp8
 ZQ5VuPf4XZuO5qT+J7x6WO/WtE9o8Xq3GvF3xSYEXLe4+YluQ3B3QumCMAV/7LSBc2Ph
 0W3g==
X-Gm-Message-State: AOAM532J05fOfCaUX2ThtIddS9x6VLrcuxR9uHIvW0CRtXsVKXeRWe+B
 9/pTGiZsq4Z6+Sr1Izwp2sCJ60mf2vs=
X-Google-Smtp-Source: ABdhPJw4tpOwP678ZA/c2uO1eEhmKtOGTtnK96uKN5O/i2S5TqO/v3mKhjNzUP6WrVCTwohdxiCMAw==
X-Received: by 2002:adf:f852:: with SMTP id d18mr15134677wrq.245.1600079067975; 
 Mon, 14 Sep 2020 03:24:27 -0700 (PDT)
Received: from x1w.redhat.com (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id y6sm19949427wrn.41.2020.09.14.03.24.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2020 03:24:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] hw/rtc/m48t59: Simplify m48t59_init()
Date: Mon, 14 Sep 2020 12:24:25 +0200
Message-Id: <20200914102425.1152962-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.248,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
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

As the 'io_base' argument of m48t59_init() is unused (set to 0),
remove it to simplify.
To create a device on the ISA bus, m48t59_init_isa() is the
preferred function to use.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/rtc/m48t59.h |  2 +-
 hw/ppc/ppc405_boards.c  |  2 +-
 hw/rtc/m48t59.c         | 10 ++--------
 hw/sparc/sun4m.c        |  2 +-
 hw/sparc64/sun4u.c      |  2 +-
 5 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/include/hw/rtc/m48t59.h b/include/hw/rtc/m48t59.h
index 04abedf3b2b..62297ee0db1 100644
--- a/include/hw/rtc/m48t59.h
+++ b/include/hw/rtc/m48t59.h
@@ -50,7 +50,7 @@ struct NvramClass {
 Nvram *m48t59_init_isa(ISABus *bus, uint32_t io_base, uint16_t size,
                        int base_year, int type);
 Nvram *m48t59_init(qemu_irq IRQ, hwaddr mem_base,
-                   uint32_t io_base, uint16_t size, int base_year,
+                   uint16_t size, int base_year,
                    int type);
 
 #endif /* HW_M48T59_H */
diff --git a/hw/ppc/ppc405_boards.c b/hw/ppc/ppc405_boards.c
index 6198ec1035b..93ffee801a3 100644
--- a/hw/ppc/ppc405_boards.c
+++ b/hw/ppc/ppc405_boards.c
@@ -227,7 +227,7 @@ static void ref405ep_init(MachineState *machine)
     /* Register FPGA */
     ref405ep_fpga_init(sysmem, 0xF0300000);
     /* Register NVRAM */
-    m48t59_init(NULL, 0xF0000000, 0, 8192, 1968, 8);
+    m48t59_init(NULL, 0xF0000000, 8192, 1968, 8);
     /* Load kernel */
     linux_boot = (kernel_filename != NULL);
     if (linux_boot) {
diff --git a/hw/rtc/m48t59.c b/hw/rtc/m48t59.c
index 6525206976b..2d6a095c4e4 100644
--- a/hw/rtc/m48t59.c
+++ b/hw/rtc/m48t59.c
@@ -566,7 +566,7 @@ const MemoryRegionOps m48t59_io_ops = {
 
 /* Initialisation routine */
 Nvram *m48t59_init(qemu_irq IRQ, hwaddr mem_base,
-                   uint32_t io_base, uint16_t size, int base_year,
+                   uint16_t size, int base_year,
                    int model)
 {
     DeviceState *dev;
@@ -584,13 +584,7 @@ Nvram *m48t59_init(qemu_irq IRQ, hwaddr mem_base,
         s = SYS_BUS_DEVICE(dev);
         sysbus_realize_and_unref(s, &error_fatal);
         sysbus_connect_irq(s, 0, IRQ);
-        if (io_base != 0) {
-            memory_region_add_subregion(get_system_io(), io_base,
-                                        sysbus_mmio_get_region(s, 1));
-        }
-        if (mem_base != 0) {
-            sysbus_mmio_map(s, 0, mem_base);
-        }
+        sysbus_mmio_map(s, 0, mem_base);
 
         return NVRAM(s);
     }
diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
index 947b69d1597..56a0d38f274 100644
--- a/hw/sparc/sun4m.c
+++ b/hw/sparc/sun4m.c
@@ -970,7 +970,7 @@ static void sun4m_hw_init(const struct sun4m_hwdef *hwdef,
         create_unimplemented_device("SUNW,sx", hwdef->sx_base, 0x2000);
     }
 
-    nvram = m48t59_init(slavio_irq[0], hwdef->nvram_base, 0, 0x2000, 1968, 8);
+    nvram = m48t59_init(slavio_irq[0], hwdef->nvram_base, 0x2000, 1968, 8);
 
     slavio_timer_init_all(hwdef->counter_base, slavio_irq[19], slavio_cpu_irq, smp_cpus);
 
diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
index b4aabfc076f..1cc57b030a7 100644
--- a/hw/sparc64/sun4u.c
+++ b/hw/sparc64/sun4u.c
@@ -675,7 +675,7 @@ static void sun4uv_init(MemoryRegion *address_space_mem,
     pci_ide_create_devs(pci_dev);
 
     /* Map NVRAM into I/O (ebus) space */
-    nvram = m48t59_init(NULL, 0, 0, NVRAM_SIZE, 1968, 59);
+    nvram = m48t59_init(NULL, 0, NVRAM_SIZE, 1968, 59);
     s = SYS_BUS_DEVICE(nvram);
     memory_region_add_subregion(pci_address_space_io(ebus), 0x2000,
                                 sysbus_mmio_get_region(s, 0));
-- 
2.26.2


