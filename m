Return-Path: <SRS0=vfNf=6Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01111C38A2A
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2020 15:30:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B83992080C
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2020 15:30:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MAQdvNsR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B83992080C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jXnu8-00083J-Rt
	for qemu-devel@archiver.kernel.org; Sun, 10 May 2020 11:30:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52548)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jXnsw-0006Ok-6W
 for qemu-devel@nongnu.org; Sun, 10 May 2020 11:28:58 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:40245)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jXnsv-0000zU-GO
 for qemu-devel@nongnu.org; Sun, 10 May 2020 11:28:57 -0400
Received: by mail-wm1-x344.google.com with SMTP id u16so16046582wmc.5
 for <qemu-devel@nongnu.org>; Sun, 10 May 2020 08:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=QRalvaDaYvhVirD34yrdH3n7kI/+oLwzkO7pUTRzFo0=;
 b=MAQdvNsRriClSajCP0qe7AQVAt/3didUQJvymUzotBN4+qrhr8u/jpf1+s9NQlENC8
 pPZeWdjhm78cBMM8B5jWJavJnCnqN9ZXGGAR3f39aCi4Wfi1/PUDPjQbC8hgPOD+Vb7b
 FMJNXCwjPVrIgZ/LWloV1lpJkhXui763JHhG0nqhKvkXzLGU3QK2lVD/Mjof0q9jm0VG
 S6D7g3W1Hyk+8VxpArfo3m3RYWJc8u15+3Ud48GUugeWI0OxKacJ7P8S5excm/PiYMMo
 mkOSuYohdolhFePY5M9I/Xt1O5J/YAkAeja5hOh9RV79NlRTzbLroZCjK5EInobmbj2M
 +DIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=QRalvaDaYvhVirD34yrdH3n7kI/+oLwzkO7pUTRzFo0=;
 b=hvXFFvPnkzvaywXskd99FUhQwi4yJtPYl9P1JS//d0Cfr6MfT7aqnLVQStN++y6tly
 HTYL+7HCW9Vd9KxmQiSoFXs1pInUUyjANLufUUPkI9sSoIIC9xMyHmO8A5yVoj4NC2vY
 DZwwFyooTtkeZJbhwMkXvzupVAeoFrWlimxQx7eIlQp90XwgVzHUTZMGfY3sZZT+aJIX
 1Xgvs5Q6PiuUN31+lPblOshPcL8TA3hWSmDMCWFTI8ggxU/WwLH4AJPmSrNDxjmpeuaM
 qMZ33DJiE8lBNcl+MgE/mlhIP85HHzS2YBcQsHjFyChxZdMDX0VVQe0ifYIWUETXuVXL
 L07w==
X-Gm-Message-State: AGi0PubgJuh4qmfq3kvlr6uxWnJsA2+gllGJ3BGIlQK5z2Ao+1vePosS
 nYs9mCkXjCpPuMEIKwiOC0egOw33sMY=
X-Google-Smtp-Source: APiQypI9oWUOlY5F/2OI2ZaOkNiVZrvbm/i7pqdRAJUjtAna876jqVb/i35c/xjhk9r3HMgQbASGtA==
X-Received: by 2002:a05:600c:22d3:: with SMTP id
 19mr2499082wmg.161.1589124535953; 
 Sun, 10 May 2020 08:28:55 -0700 (PDT)
Received: from localhost.localdomain (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id a67sm24186702wmc.30.2020.05.10.08.28.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 May 2020 08:28:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 7/7] hw/misc/empty_slot: Name the slots when created
Date: Sun, 10 May 2020 17:28:40 +0200
Message-Id: <20200510152840.13558-8-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200510152840.13558-1-f4bug@amsat.org>
References: <20200510152840.13558-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Directly set the slot name when creating the device,
to display the device name in trace events.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/misc/empty_slot.h |  2 +-
 hw/mips/mips_malta.c         |  2 +-
 hw/misc/empty_slot.c         |  2 +-
 hw/sparc/sun4m.c             | 10 +++++++---
 4 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/include/hw/misc/empty_slot.h b/include/hw/misc/empty_slot.h
index b023bc2d91..dec56e56ae 100644
--- a/include/hw/misc/empty_slot.h
+++ b/include/hw/misc/empty_slot.h
@@ -14,6 +14,6 @@
 
 #include "exec/hwaddr.h"
 
-void empty_slot_init(hwaddr addr, uint64_t slot_size);
+void empty_slot_init(const char *name, hwaddr addr, uint64_t slot_size);
 
 #endif
diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
index 30ed3c1538..c6e31a8fb2 100644
--- a/hw/mips/mips_malta.c
+++ b/hw/mips/mips_malta.c
@@ -1246,7 +1246,7 @@ void mips_malta_init(MachineState *machine)
      * exception when accessing invalid memory. Create an empty slot to
      * emulate this feature.
      */
-    empty_slot_init(0, 0x20000000);
+    empty_slot_init("GT64120", 0, 0x20000000);
 
     qdev_init_nofail(dev);
 
diff --git a/hw/misc/empty_slot.c b/hw/misc/empty_slot.c
index 54be085189..b568ae202b 100644
--- a/hw/misc/empty_slot.c
+++ b/hw/misc/empty_slot.c
@@ -50,7 +50,7 @@ static const MemoryRegionOps empty_slot_ops = {
     .endianness = DEVICE_NATIVE_ENDIAN,
 };
 
-void empty_slot_init(hwaddr addr, uint64_t slot_size)
+void empty_slot_init(const char *name, hwaddr addr, uint64_t slot_size)
 {
     if (slot_size > 0) {
         /* Only empty slots larger than 0 byte need handling. */
diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
index 6030900124..3ef615fbbe 100644
--- a/hw/sparc/sun4m.c
+++ b/hw/sparc/sun4m.c
@@ -836,7 +836,8 @@ static void sun4m_hw_init(const struct sun4m_hwdef *hwdef,
 
     /* models without ECC don't trap when missing ram is accessed */
     if (!hwdef->ecc_base) {
-        empty_slot_init(machine->ram_size, hwdef->max_mem - machine->ram_size);
+        empty_slot_init("ecc", machine->ram_size,
+                        hwdef->max_mem - machine->ram_size);
     }
 
     prom_init(hwdef->slavio_base, bios_name);
@@ -867,7 +868,8 @@ static void sun4m_hw_init(const struct sun4m_hwdef *hwdef,
            Software shouldn't use aliased addresses, neither should it crash
            when does. Using empty_slot instead of aliasing can help with
            debugging such accesses */
-        empty_slot_init(hwdef->iommu_pad_base,hwdef->iommu_pad_len);
+        empty_slot_init("iommu.alias",
+                        hwdef->iommu_pad_base, hwdef->iommu_pad_len);
     }
 
     sparc32_dma_init(hwdef->dma_base,
@@ -916,7 +918,9 @@ static void sun4m_hw_init(const struct sun4m_hwdef *hwdef,
     for (i = 0; i < MAX_VSIMMS; i++) {
         /* vsimm registers probed by OBP */
         if (hwdef->vsimm[i].reg_base) {
-            empty_slot_init(hwdef->vsimm[i].reg_base, 0x2000);
+            char *name = g_strdup_printf("vsimm[%d]", i);
+            empty_slot_init(name, hwdef->vsimm[i].reg_base, 0x2000);
+            g_free(name);
         }
     }
 
-- 
2.21.3


