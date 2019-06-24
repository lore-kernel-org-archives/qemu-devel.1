Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0B6AC4646B
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 22:09:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BECD920663
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 22:09:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="STvIRsYS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BECD920663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54910 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfX98-00059P-VB
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 18:09:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54845)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1hfX29-0007tk-J9
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 18:01:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1hfX27-00044m-GC
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 18:01:53 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:37203)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1hfX25-0003Cx-Ht
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 18:01:51 -0400
Received: by mail-wr1-x443.google.com with SMTP id v14so15514939wrr.4
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2019 15:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=IIHLqb+Tji18CeWo1iHa+k4D0J8xhz1pLarQhDAY1ak=;
 b=STvIRsYS7c4ixW9EM2qXv466H5GuFA4qgeyPVE2hktxzDJCyLso7WfRHGLs0WDrAnN
 3AjygYnO6wxX2Kf8PToIpM1Va/x4z2+YfmZgWcMuvaH1HohCb3lolpTsOa+AFXRCy/ul
 zVGjFfWtvV5o6HMGW9HODZxPzTKNNO96aHOqp+Osy4+hrE8bSyFBxCvtrld9pHxLeADE
 KcKp0hYzwAlsBedmZfgAUGnaQIrVgpxX56SrdfUNFOtcIPk1KQ5bhF544fPdmYflVChi
 ft3w9urYvsm6bgiiZKgRS3zBcIKofp2Md2cB5sTqrE+zhe2a19qhdsb4AKQAHPIWDNWD
 b/5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=IIHLqb+Tji18CeWo1iHa+k4D0J8xhz1pLarQhDAY1ak=;
 b=E5HdQy4CA282XDPW5xJpb+eNOIZwDIN5eGKUgFtxFs+Y4Qj+9MZJekb8hHpf3OG/9Z
 QJ4CDi7Ib3d+7LLpZjaaV6Dvqab4Ri/qYQ7MMUrfFYACHmhpFa4bxySFFwL8+2ncYvc7
 PT16RkoRXNhyLHuXO3+2CxBTHuA/Y4HCiW5WLiSWiGzo3ucpvaWB9bbFkpPzDRTppj5x
 CEq8Eyo/QYEf6PQcUTMuwr1K0/Hr/GzONAkXdURooYnIuSS2YaSG41+Av1lCNYnWr7Ar
 YwhzLG9f3Pb84uGS03CbZrIUxI1skLVdjX3PARAIBMigl/ptPRtF2EpDscAJ3Gu+Nqoj
 WeJg==
X-Gm-Message-State: APjAAAUDciPUjg/x/GmQkIUD68wX1wlgPy2uDTlQz18RkWUWJUlrbjDH
 ZwI9tQvkCjMlvTquVQfMk9BUyHNW
X-Google-Smtp-Source: APXvYqwOiq7JbOmk3mmwzAEUSz+GNrlGtkk0+NELdqvIv5ttHSyBIo0/MB7n1bl2JpFb0QGpbBxOVA==
X-Received: by 2002:a5d:56cb:: with SMTP id m11mr14964052wrw.255.1561413670596; 
 Mon, 24 Jun 2019 15:01:10 -0700 (PDT)
Received: from x1.local (183.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.183])
 by smtp.gmail.com with ESMTPSA id z126sm1118612wmb.32.2019.06.24.15.01.09
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 24 Jun 2019 15:01:09 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Date: Tue, 25 Jun 2019 00:00:56 +0200
Message-Id: <20190624220056.25861-10-f4bug@amsat.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190624220056.25861-1-f4bug@amsat.org>
References: <20190624220056.25861-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: [Qemu-devel] [PATCH 9/9] hw/misc/empty_slot: Pass the slot name as
 argument
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
 Aleksandar Rikalo <arikalo@wavecomp.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Use the slot name to have more meaningful tracing logs.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/misc/empty_slot.h | 3 ++-
 hw/mips/mips_malta.c         | 2 +-
 hw/misc/empty_slot.c         | 6 ++++--
 hw/sparc/sun4m.c             | 9 ++++++---
 4 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/include/hw/misc/empty_slot.h b/include/hw/misc/empty_slot.h
index 46483f24c3..d0cd989d2d 100644
--- a/include/hw/misc/empty_slot.h
+++ b/include/hw/misc/empty_slot.h
@@ -14,6 +14,7 @@
 
 /**
  * empty_slot_init: create and map a RAZ/WI device
+ * @name: name of the device for debug logging
  * @base: base address of the device's MMIO region
  * @size: size of the device's MMIO region
  *
@@ -27,6 +28,6 @@
  * use it to cover a large region and then map other devices on top of it
  * if necessary.
  */
-void empty_slot_init(hwaddr addr, uint64_t slot_size);
+void empty_slot_init(const char *name, hwaddr addr, uint64_t slot_size);
 
 #endif
diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
index 7008be2e5b..51db5212be 100644
--- a/hw/mips/mips_malta.c
+++ b/hw/mips/mips_malta.c
@@ -1212,7 +1212,7 @@ void mips_malta_init(MachineState *machine)
     /* The whole address space decoded by the GT-64120A doesn't generate
        exception when accessing invalid memory. Create an empty slot to
        emulate this feature. */
-    empty_slot_init(0, 0x20000000);
+    empty_slot_init("gt64120-ad", 0x00000000, 0x20000000);
 
     qdev_init_nofail(dev);
 
diff --git a/hw/misc/empty_slot.c b/hw/misc/empty_slot.c
index b810655554..396f9dd06a 100644
--- a/hw/misc/empty_slot.c
+++ b/hw/misc/empty_slot.c
@@ -52,12 +52,13 @@ static const MemoryRegionOps empty_slot_ops = {
     .endianness = DEVICE_NATIVE_ENDIAN,
 };
 
-void empty_slot_init(hwaddr addr, uint64_t slot_size)
+void empty_slot_init(const char *name, hwaddr addr, uint64_t slot_size)
 {
     DeviceState *dev;
 
     dev = qdev_create(NULL, TYPE_EMPTY_SLOT);
 
+    qdev_prop_set_string(dev, "name", name);
     qdev_prop_set_uint64(dev, "size", slot_size);
     qdev_init_nofail(dev);
 
@@ -77,7 +78,8 @@ static void empty_slot_realize(DeviceState *dev, Error **errp)
         return;
     }
     if (s->name == NULL) {
-        s->name = g_strdup("empty-slot");
+        error_setg(errp, "property 'name' not specified");
+        return;
     }
 
     memory_region_init_io(&s->iomem, OBJECT(s), &empty_slot_ops, s,
diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
index d55753d5cb..b17be3ddb8 100644
--- a/hw/sparc/sun4m.c
+++ b/hw/sparc/sun4m.c
@@ -819,7 +819,7 @@ static void sun4m_hw_init(const struct sun4m_hwdef *hwdef,
                                          machine->ram_size);
     memory_region_add_subregion(get_system_memory(), 0x00000000, &ram);
     /* models without ECC don't trap when missing ram is accessed */
-    empty_slot_init(0x00000000, hwdef->max_mem);
+    empty_slot_init("dram", 0x00000000, hwdef->max_mem);
 
     /* init CPUs */
     for(i = 0; i < smp_cpus; i++) {
@@ -859,7 +859,8 @@ static void sun4m_hw_init(const struct sun4m_hwdef *hwdef,
            Software shouldn't use aliased addresses, neither should it crash
            when does. Using empty_slot instead of aliasing can help with
            debugging such accesses */
-        empty_slot_init(hwdef->iommu_pad_base,hwdef->iommu_pad_len);
+        empty_slot_init("iommu.alias",
+                        hwdef->iommu_pad_base, hwdef->iommu_pad_len);
     }
 
     sparc32_dma_init(hwdef->dma_base,
@@ -908,7 +909,9 @@ static void sun4m_hw_init(const struct sun4m_hwdef *hwdef,
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
2.19.1


