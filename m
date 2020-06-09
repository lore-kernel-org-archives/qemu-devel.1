Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1856EC433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 07:40:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D67D92074B
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 07:40:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OkkIasPx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D67D92074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48380 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiYsJ-0008E6-3S
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 03:40:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40326)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jiYkE-00047a-P1
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 03:32:27 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:44761)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jiYkE-0007X4-0T
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 03:32:26 -0400
Received: by mail-wr1-x444.google.com with SMTP id y17so20042419wrn.11
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 00:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=7SiSsVqqUtOR4NW9TEB36YXYjOxJiCE5fvC4CDj0Z7M=;
 b=OkkIasPxUwE1Fr++rG+KrYibi+e+Su1wqh88cWuquIusPPTMw112BDDjOS47EdUBAB
 Cd/xnjAJflUyYAl5IKP7OT/D+t/0uyhwtiQ3hEa8rQkSruavCioS91kB1xeLd2wP2vS5
 VSKSrJX+ilNhtSTN1R1XS88gzJgavyl4xthp842L70QyPw84IbvONgAjdS21ESnElo5M
 LYcONH0SvwBz18x9xSNlFAftTvi+2rH0KN/ZGQJCWDC7pyAZev1u3fQgFlEJR/KoZLZv
 pdN4KLbye0yR0optY2hxJlGw2fz/FzocbqzQtKCch6WEMwmcrsjSYGLjJGVH8Axj+NdN
 UgRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=7SiSsVqqUtOR4NW9TEB36YXYjOxJiCE5fvC4CDj0Z7M=;
 b=IGAZsMul7IRVhTlgwYun8V0CFHPZn3EgyE8YaNbsQtG373Mg56mNMDtdfb+9/w/bYy
 Hi8kMy++tEPMR0VQ8S8ycB9b8m/67lJFzzkQFvi4k/tS+mI22oUi8JWNMZLFmlxn/CMv
 ZnWqebe+38yuPVq3gZJX60fwVwRUhRUmPiLT6nRQjTM07oSPaQxYqsNVPl/tnPP1DrCh
 nZRXHZ98GiVhK+H9rgsLwbXdqVSk5H/GfM3HkBw23tp8OeMtrZydyiXj1i5pbDL+E+Fx
 L3V0EmriyRHvNF0YI/gJ9utz7Y819xKu+t1K3Jl1s9LV7QkzyGK+S0URuavwm8XvntSS
 N4Qg==
X-Gm-Message-State: AOAM530m2uLHo6t1wckDgB2Gvq4CHlnw6OTjLZgoAuzHRDryK5IU/TNZ
 F92np5OnEhW9ma5/hJzkPO/Tg1q3
X-Google-Smtp-Source: ABdhPJyMzIv1YTU/vR52wY5ROwsN/rjadEnOpJTbZUo//y4GSjsC1RFZfnhL2bFNtk0MIwk7bpzUoQ==
X-Received: by 2002:a5d:4042:: with SMTP id w2mr2989322wrp.423.1591687944359; 
 Tue, 09 Jun 2020 00:32:24 -0700 (PDT)
Received: from localhost.localdomain
 (181.red-88-10-103.dynamicip.rima-tde.net. [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id m3sm2036192wmc.0.2020.06.09.00.32.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2020 00:32:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/16] hw/misc/empty_slot: Name the slots when created
Date: Tue,  9 Jun 2020 09:32:05 +0200
Message-Id: <20200609073214.14079-8-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200609073214.14079-1-f4bug@amsat.org>
References: <20200609073214.14079-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 Fabien Chouteau <chouteau@adacore.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Directly set the slot name when creating the device,
to display the device name in trace events.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Acked-by: Artyom Tarasenko <atar4qemu@gmail.com>
Message-Id: <20200510152840.13558-8-f4bug@amsat.org>
---
 include/hw/misc/empty_slot.h |  2 +-
 hw/mips/malta.c              |  2 +-
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
diff --git a/hw/mips/malta.c b/hw/mips/malta.c
index c973c76b2a..62063b2305 100644
--- a/hw/mips/malta.c
+++ b/hw/mips/malta.c
@@ -1241,7 +1241,7 @@ void mips_malta_init(MachineState *machine)
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
index a16e667bee..249f7ba7ea 100644
--- a/hw/sparc/sun4m.c
+++ b/hw/sparc/sun4m.c
@@ -884,7 +884,8 @@ static void sun4m_hw_init(const struct sun4m_hwdef *hwdef,
 
     /* models without ECC don't trap when missing ram is accessed */
     if (!hwdef->ecc_base) {
-        empty_slot_init(machine->ram_size, hwdef->max_mem - machine->ram_size);
+        empty_slot_init("ecc", machine->ram_size,
+                        hwdef->max_mem - machine->ram_size);
     }
 
     prom_init(hwdef->slavio_base, bios_name);
@@ -915,7 +916,8 @@ static void sun4m_hw_init(const struct sun4m_hwdef *hwdef,
            Software shouldn't use aliased addresses, neither should it crash
            when does. Using empty_slot instead of aliasing can help with
            debugging such accesses */
-        empty_slot_init(hwdef->iommu_pad_base,hwdef->iommu_pad_len);
+        empty_slot_init("iommu.alias",
+                        hwdef->iommu_pad_base, hwdef->iommu_pad_len);
     }
 
     sparc32_dma_init(hwdef->dma_base,
@@ -964,7 +966,9 @@ static void sun4m_hw_init(const struct sun4m_hwdef *hwdef,
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


