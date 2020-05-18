Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D543DC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 09:50:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95A852070A
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 09:50:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kscoNuaU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95A852070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55228 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jacPX-0001Pr-QP
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 05:50:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54888)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jacOT-0000lN-NJ
 for qemu-devel@nongnu.org; Mon, 18 May 2020 05:49:10 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:34384)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jacOS-0000Yk-8e
 for qemu-devel@nongnu.org; Mon, 18 May 2020 05:49:09 -0400
Received: by mail-wr1-x442.google.com with SMTP id y3so11075565wrt.1
 for <qemu-devel@nongnu.org>; Mon, 18 May 2020 02:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=K+we9WoGzE+kilpMJ4zUutNfKiratF39l9Zwhq8Nt0Y=;
 b=kscoNuaUEXzulPGUA0sOEoBnffniSiXjrgHl2u0XRtgVTXsoABd8ijMd8DIlTl7OdX
 3NT3WpMFNRVU1R8SzVHR+L8LypdlawHEhJQoBfxd7CgjBLxLgE+iI7ZcgFfo5pIE32c7
 p1wsVlVtcBU3DSoyd0nUUwu5WLKXckyR9D1n8nQlm38DD3AWUz0DUXGTRoUrwB5XN3MT
 C2T1Qrf/RYaUKCZVgerHYzVY/6RZFsjakHx75wa5MzKvV3KTE3D+R5zUwk3NhDmdfqqe
 L1TsN9p0luizk6rp6uHKjnVJAc7RkXauV1UFG7dR1GyU45XOPMl7s2GnXjEZPpxo9Ub9
 nVpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=K+we9WoGzE+kilpMJ4zUutNfKiratF39l9Zwhq8Nt0Y=;
 b=sf8Ap+Rds6ptzBB83q4kGaZTlDrg5yDbcncg0X59Xo7FCCDl8P8OFSLMz4PoQB88Yo
 hg38ZVOZVBmJ+gY/tX7+Qo3QyX2GASk0qYFe867ijhCqUyzVanpDZ3FowY62tcDpJgJ7
 VGsivKepJTyC/vhHPo8gyo4OGoa8MA1pq9biv122ICemzSxQhQFxlJtlxhzNkvLttR5n
 ZnPVqVOgBsYHyoSNQQHTbXct/6Th3ZeE+eWRbrGxcZejCxhrqB18r94FmM6BUC2TEmlW
 KRmJ5//GVcN83zofptIvrVzqoiMXAdXfTolTV60AipqRv/LEgFIhaTQL7rLKkfd0yfUc
 eA6Q==
X-Gm-Message-State: AOAM530v4maoPYCAfHG9RRfl8jgBgn9rWYh3nR38X/99LxhJ1rC1Pi4q
 kG0TwJ4J2xtzn+Yd+2N2mFzxq20+5cA=
X-Google-Smtp-Source: ABdhPJwRSguEQqOAHlGGfynmm1kdZpBzfCRuT+7vEPcgmXpsEd9WDKLf3Y81IbWnxQqtvtzW8tyKDw==
X-Received: by 2002:adf:e905:: with SMTP id f5mr19236259wrm.409.1589795346123; 
 Mon, 18 May 2020 02:49:06 -0700 (PDT)
Received: from x1w.redhat.com (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id 81sm17144898wme.16.2020.05.18.02.49.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2020 02:49:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] hw/m68k/mcf52xx: Replace hw_error() by qemu_log_mask()
Date: Mon, 18 May 2020 11:49:04 +0200
Message-Id: <20200518094904.24226-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
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
Cc: Thomas Huth <huth@tuxfamily.org>, Jason Wang <jasowang@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

hw_error() calls exit(). This a bit overkill when we can log
the accesses as unimplemented or guest error.

When fuzzing the devices, we don't want the whole process to
exit. Replace some hw_error() calls by qemu_log_mask().

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/m68k/mcf5206.c  |  7 +++++--
 hw/m68k/mcf5208.c  | 14 +++++++++-----
 hw/m68k/mcf_intc.c |  4 +++-
 hw/net/mcf_fec.c   |  8 +++++---
 4 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/hw/m68k/mcf5206.c b/hw/m68k/mcf5206.c
index b155dd8170..34a863a588 100644
--- a/hw/m68k/mcf5206.c
+++ b/hw/m68k/mcf5206.c
@@ -8,6 +8,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
+#include "qemu/log.h"
 #include "cpu.h"
 #include "hw/hw.h"
 #include "hw/irq.h"
@@ -306,7 +307,8 @@ static uint64_t m5206_mbar_read(m5206_mbar_state *s,
     case 0x170: return s->uivr[0];
     case 0x1b0: return s->uivr[1];
     }
-    hw_error("Bad MBAR read offset 0x%x", (int)offset);
+    qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad MBAR offset 0x%" HWADDR_PRIX "\n",
+                  __func__, offset);
     return 0;
 }
 
@@ -360,7 +362,8 @@ static void m5206_mbar_write(m5206_mbar_state *s, uint32_t offset,
         s->uivr[1] = value;
         break;
     default:
-        hw_error("Bad MBAR write offset 0x%x", (int)offset);
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad MBAR offset 0x%x\n",
+                      __func__, offset);
         break;
     }
 }
diff --git a/hw/m68k/mcf5208.c b/hw/m68k/mcf5208.c
index b84c152ce3..cd8a32e0c6 100644
--- a/hw/m68k/mcf5208.c
+++ b/hw/m68k/mcf5208.c
@@ -9,10 +9,10 @@
 #include "qemu/osdep.h"
 #include "qemu/units.h"
 #include "qemu/error-report.h"
+#include "qemu/log.h"
 #include "qapi/error.h"
 #include "qemu-common.h"
 #include "cpu.h"
-#include "hw/hw.h"
 #include "hw/irq.h"
 #include "hw/m68k/mcf.h"
 #include "hw/m68k/mcf_fec.h"
@@ -111,7 +111,8 @@ static void m5208_timer_write(void *opaque, hwaddr offset,
     case 4:
         break;
     default:
-        hw_error("m5208_timer_write: Bad offset 0x%x\n", (int)offset);
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset 0x%" HWADDR_PRIX "\n",
+                      __func__, offset);
         break;
     }
     m5208_timer_update(s);
@@ -136,7 +137,8 @@ static uint64_t m5208_timer_read(void *opaque, hwaddr addr,
     case 4:
         return ptimer_get_count(s->timer);
     default:
-        hw_error("m5208_timer_read: Bad offset 0x%x\n", (int)addr);
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset 0x%" HWADDR_PRIX "\n",
+                      __func__, addr);
         return 0;
     }
 }
@@ -164,7 +166,8 @@ static uint64_t m5208_sys_read(void *opaque, hwaddr addr,
         return 0;
 
     default:
-        hw_error("m5208_sys_read: Bad offset 0x%x\n", (int)addr);
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset 0x%" HWADDR_PRIX "\n",
+                      __func__, addr);
         return 0;
     }
 }
@@ -172,7 +175,8 @@ static uint64_t m5208_sys_read(void *opaque, hwaddr addr,
 static void m5208_sys_write(void *opaque, hwaddr addr,
                             uint64_t value, unsigned size)
 {
-    hw_error("m5208_sys_write: Bad offset 0x%x\n", (int)addr);
+    qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset 0x%" HWADDR_PRIX "\n",
+                  __func__, addr);
 }
 
 static const MemoryRegionOps m5208_sys_ops = {
diff --git a/hw/m68k/mcf_intc.c b/hw/m68k/mcf_intc.c
index d9e03a06ab..7dddf17d33 100644
--- a/hw/m68k/mcf_intc.c
+++ b/hw/m68k/mcf_intc.c
@@ -8,6 +8,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/module.h"
+#include "qemu/log.h"
 #include "cpu.h"
 #include "hw/hw.h"
 #include "hw/irq.h"
@@ -127,7 +128,8 @@ static void mcf_intc_write(void *opaque, hwaddr addr,
         }
         break;
     default:
-        hw_error("mcf_intc_write: Bad write offset %d\n", offset);
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset 0x%02x\n",
+                      __func__, offset);
         break;
     }
     mcf_intc_update(s);
diff --git a/hw/net/mcf_fec.c b/hw/net/mcf_fec.c
index 9327ac8a30..b3a92c0114 100644
--- a/hw/net/mcf_fec.c
+++ b/hw/net/mcf_fec.c
@@ -7,7 +7,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/hw.h"
+#include "qemu/log.h"
 #include "hw/irq.h"
 #include "net/net.h"
 #include "qemu/module.h"
@@ -392,7 +392,8 @@ static uint64_t mcf_fec_read(void *opaque, hwaddr addr,
     case 0x188: return s->emrbr;
     case 0x200 ... 0x2e0: return s->mib[(addr & 0x1ff) / 4];
     default:
-        hw_error("mcf_fec_read: Bad address 0x%x\n", (int)addr);
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad address 0x%" HWADDR_PRIX "\n",
+                      __func__, addr);
         return 0;
     }
 }
@@ -492,7 +493,8 @@ static void mcf_fec_write(void *opaque, hwaddr addr,
         s->mib[(addr & 0x1ff) / 4] = value;
         break;
     default:
-        hw_error("mcf_fec_write Bad address 0x%x\n", (int)addr);
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad address 0x%" HWADDR_PRIX "\n",
+                      __func__, addr);
     }
     mcf_fec_update(s);
 }
-- 
2.21.3


