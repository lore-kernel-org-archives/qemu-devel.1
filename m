Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 208A4C433E7
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 19:48:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B082206DD
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 19:48:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NaNkP7I/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B082206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48472 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kT9Es-0003iK-BJ
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 15:48:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57208)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kT9DG-0002Jv-Lz; Thu, 15 Oct 2020 15:46:58 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:42419)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kT9DF-0007AM-0f; Thu, 15 Oct 2020 15:46:58 -0400
Received: by mail-wr1-x441.google.com with SMTP id e18so5115440wrw.9;
 Thu, 15 Oct 2020 12:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=aVFMu/wF+Vu6mv+mAFU+nD/l20KT6wub6M7L5ocQ5W8=;
 b=NaNkP7I/TDkCThp5BRIqNCiws+uZHAZrKtFL+eyome1Pav207TMWhofDfPFK60S7DA
 tZ07VoC/a+ODZmnSun5vhfgnNbSH9KyNTxKQpIR94vvTjeOVV1m4qnyYny0BRRbWMwtY
 oOM/F75UiKAanX5ltjROz3E9120ri4lxq+mtjpWuSk94mefgW5l8qagTTvcMQ5FVvuQR
 IodStUoBC5RbrQ6+S2swdSHyWUh2gg5or91DEuNOtE97OwvWYt8ai6flQ/MZPGAxInBK
 KRsOxnnxfyBhJyWng8vobnwPaVv8M602vvz0oUS9/B08fNE5ERP6M3TVbg6hYoEOkD8O
 XWeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=aVFMu/wF+Vu6mv+mAFU+nD/l20KT6wub6M7L5ocQ5W8=;
 b=XLUwFuLQujiZsAZq8EOfKKmrZAUfmsxDTsa9rsdcQkg38CiMCLMta8H1En1vTY0gMU
 dm0ejZtyhGy8MWgynbyafbiTNh7p/30tMFoUDLFURGCwWQRZftRp6lDrMhTVKquoW7Uo
 a9TDx/oq39u3NHRk/G7t1B37/iWMdMmT0yb8aKbFtorlzFY81ldk6u1LTN4OopJ3kkwG
 QX2NGBp3nJZZA0G4Mcrn6OBbrc4Zny6JtedZWdGghpUx6hNqv2iOcNuBxKVUtxAUJnNE
 Q0s3dw6g2KwVqZmW0jmVOtmsuu89FH+zECbEFi/eckGM9oxO8i6PLr/kuhwAjFX2Kdo3
 0CZw==
X-Gm-Message-State: AOAM532IYQU8gWWfyxyteRGDEmbiq1FSKYi3Er0wieE/urWtZqJ49yLQ
 OzTd8ziNIPzgHax9y9sl1jY4O6HggWo=
X-Google-Smtp-Source: ABdhPJx/yZElf7ti0YFAB7DKcv6IBAL8MkGE9D21Nd4QFQFzpSx9wRodbA74CGYgCJTrAz/GEoHsZA==
X-Received: by 2002:adf:9461:: with SMTP id 88mr6044908wrq.307.1602791214660; 
 Thu, 15 Oct 2020 12:46:54 -0700 (PDT)
Received: from localhost.localdomain
 (106.red-83-59-162.dynamicip.rima-tde.net. [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id k5sm87341wmb.19.2020.10.15.12.46.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2020 12:46:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/2] hw/rtc/m48t59: Simplify m48t59_init() removing
 'io_base' argument
Date: Thu, 15 Oct 2020 21:46:46 +0200
Message-Id: <20201015194647.477252-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201015194647.477252-1-f4bug@amsat.org>
References: <20201015194647.477252-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
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

As the 'io_base' argument of m48t59_init() is unused (set to 0),
remove it to simplify.
To create a device on the ISA bus, m48t59_init_isa() is the
preferred function to use.

Acked-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/rtc/m48t59.h | 3 +--
 hw/ppc/ppc405_boards.c  | 2 +-
 hw/rtc/m48t59.c         | 6 +-----
 hw/sparc/sun4m.c        | 2 +-
 hw/sparc64/sun4u.c      | 2 +-
 5 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/include/hw/rtc/m48t59.h b/include/hw/rtc/m48t59.h
index 04abedf3b2b..d99dda2b7de 100644
--- a/include/hw/rtc/m48t59.h
+++ b/include/hw/rtc/m48t59.h
@@ -50,7 +50,6 @@ struct NvramClass {
 Nvram *m48t59_init_isa(ISABus *bus, uint32_t io_base, uint16_t size,
                        int base_year, int type);
 Nvram *m48t59_init(qemu_irq IRQ, hwaddr mem_base,
-                   uint32_t io_base, uint16_t size, int base_year,
-                   int type);
+                   uint16_t size, int base_year, int model);
 
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
index 6525206976b..8b02c2ec558 100644
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
@@ -584,10 +584,6 @@ Nvram *m48t59_init(qemu_irq IRQ, hwaddr mem_base,
         s = SYS_BUS_DEVICE(dev);
         sysbus_realize_and_unref(s, &error_fatal);
         sysbus_connect_irq(s, 0, IRQ);
-        if (io_base != 0) {
-            memory_region_add_subregion(get_system_io(), io_base,
-                                        sysbus_mmio_get_region(s, 1));
-        }
         if (mem_base != 0) {
             sysbus_mmio_map(s, 0, mem_base);
         }
diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
index 54a2b2f9ef3..20c1fa41192 100644
--- a/hw/sparc/sun4m.c
+++ b/hw/sparc/sun4m.c
@@ -966,7 +966,7 @@ static void sun4m_hw_init(const struct sun4m_hwdef *hwdef,
         create_unimplemented_device("SUNW,sx", hwdef->sx_base, 0x2000);
     }
 
-    nvram = m48t59_init(slavio_irq[0], hwdef->nvram_base, 0, 0x2000, 1968, 8);
+    nvram = m48t59_init(slavio_irq[0], hwdef->nvram_base, 0x2000, 1968, 8);
 
     slavio_timer_init_all(hwdef->counter_base, slavio_irq[19], slavio_cpu_irq, smp_cpus);
 
diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
index ad5ca2472a4..6854522bbfa 100644
--- a/hw/sparc64/sun4u.c
+++ b/hw/sparc64/sun4u.c
@@ -671,7 +671,7 @@ static void sun4uv_init(MemoryRegion *address_space_mem,
     pci_ide_create_devs(pci_dev);
 
     /* Map NVRAM into I/O (ebus) space */
-    nvram = m48t59_init(NULL, 0, 0, NVRAM_SIZE, 1968, 59);
+    nvram = m48t59_init(NULL, 0, NVRAM_SIZE, 1968, 59);
     s = SYS_BUS_DEVICE(nvram);
     memory_region_add_subregion(pci_address_space_io(ebus), 0x2000,
                                 sysbus_mmio_get_region(s, 0));
-- 
2.26.2


