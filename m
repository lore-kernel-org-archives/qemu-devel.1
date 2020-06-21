Return-Path: <SRS0=M+f9=AC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8051C433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jun 2020 11:18:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9380524834
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jun 2020 11:18:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9380524834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51176 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmxzl-0002q8-RY
	for qemu-devel@archiver.kernel.org; Sun, 21 Jun 2020 07:18:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34392)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jmxyp-0001UC-3E
 for qemu-devel@nongnu.org; Sun, 21 Jun 2020 07:17:43 -0400
Received: from zero.eik.bme.hu ([152.66.115.2]:36616)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jmxym-0007hO-HR
 for qemu-devel@nongnu.org; Sun, 21 Jun 2020 07:17:42 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id E45E6746307;
 Sun, 21 Jun 2020 13:17:37 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 6EEEB7475FA; Sun, 21 Jun 2020 13:17:37 +0200 (CEST)
Message-Id: <cc1324b9ef06beb8ae233ddc77dedd8bab9b8624.1592737958.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1592737958.git.balaton@eik.bme.hu>
References: <cover.1592737958.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH 3/3] ati-vga: Add dummy MEM_SDRAM_MODE_REG
Date: Sun, 21 Jun 2020 13:12:38 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/21 07:17:37
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Radeon chips have an SDRAM mode reg that is accessed by some drivers.
We don't emulate the memory controller but provide some default value
to prevent drivers getting unexpected 0.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/display/ati.c      | 5 +++++
 hw/display/ati_dbg.c  | 1 +
 hw/display/ati_regs.h | 1 +
 3 files changed, 7 insertions(+)

diff --git a/hw/display/ati.c b/hw/display/ati.c
index 42755cffbb..944f9f420f 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -361,6 +361,11 @@ static uint64_t ati_mm_read(void *opaque, hwaddr addr, unsigned int size)
     case MC_STATUS:
         val = 5;
         break;
+    case MEM_SDRAM_MODE_REG:
+        if (s->dev_id != PCI_DEVICE_ID_ATI_RAGE128_PF) {
+            val = BIT(28) | BIT(20);
+        }
+        break;
     case RBBM_STATUS:
     case GUI_STAT:
         val = 64; /* free CMDFIFO entries */
diff --git a/hw/display/ati_dbg.c b/hw/display/ati_dbg.c
index 0ebbd36f14..bd0ecd48c7 100644
--- a/hw/display/ati_dbg.c
+++ b/hw/display/ati_dbg.c
@@ -42,6 +42,7 @@ static struct ati_regdesc ati_reg_names[] = {
     {"MC_FB_LOCATION", 0x0148},
     {"MC_AGP_LOCATION", 0x014C},
     {"MC_STATUS", 0x0150},
+    {"MEM_SDRAM_MODE_REG", 0x0158},
     {"MEM_POWER_MISC", 0x015c},
     {"AGP_BASE", 0x0170},
     {"AGP_CNTL", 0x0174},
diff --git a/hw/display/ati_regs.h b/hw/display/ati_regs.h
index ebd37ee30d..d6282b2ef2 100644
--- a/hw/display/ati_regs.h
+++ b/hw/display/ati_regs.h
@@ -60,6 +60,7 @@
 #define MC_FB_LOCATION                          0x0148
 #define MC_AGP_LOCATION                         0x014C
 #define MC_STATUS                               0x0150
+#define MEM_SDRAM_MODE_REG                      0x0158
 #define MEM_POWER_MISC                          0x015c
 #define AGP_BASE                                0x0170
 #define AGP_CNTL                                0x0174
-- 
2.21.3


