Return-Path: <SRS0=clLO=73=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA5EDC433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2020 18:27:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86442206D7
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2020 18:27:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86442206D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkXMK-0005eh-Oj
	for qemu-devel@archiver.kernel.org; Sun, 14 Jun 2020 14:27:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48792)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jkXLQ-0004Bb-DW; Sun, 14 Jun 2020 14:27:00 -0400
Received: from zero.eik.bme.hu ([152.66.115.2]:52078)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jkXLO-0007gM-Mf; Sun, 14 Jun 2020 14:27:00 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 4EEC274633F;
 Sun, 14 Jun 2020 20:26:44 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id BD322748DD1; Sun, 14 Jun 2020 20:26:43 +0200 (CEST)
Message-Id: <c0aef32ab7953f5d9ee35b6e505f5ac56e4fd11f.1592158400.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1592158400.git.balaton@eik.bme.hu>
References: <cover.1592158400.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v4 7/9] macio: Add dummy screamer register area
Date: Sun, 14 Jun 2020 20:13:19 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/14 14:26:44
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
Cc: Howard Spoelstra <hsp.cat7@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The only thing this returns is an idle status so the firmware
continues, otherwise just ignores and logs access for debugging. This
is a stop gap until proper implementation of this device lands.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
This could be reverted as the first patch of a series adding real
implementation so it should not cause much trouble. Or in case it's
found that firmware continues once SPD data is available this patch
may not be needed.

 hw/misc/macio/macio.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/hw/misc/macio/macio.c b/hw/misc/macio/macio.c
index 3779865ab2..dbc3df9ab1 100644
--- a/hw/misc/macio/macio.c
+++ b/hw/misc/macio/macio.c
@@ -26,6 +26,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qemu/module.h"
+#include "qemu/log.h"
 #include "hw/ppc/mac.h"
 #include "hw/misc/macio/cuda.h"
 #include "hw/pci/pci.h"
@@ -103,6 +104,33 @@ static void macio_init_child_obj(MacIOState *s, const char *childname,
     qdev_set_parent_bus(DEVICE(child), BUS(&s->macio_bus));
 }
 
+#define AWAC_CODEC_STATUS_REG 0x20
+
+#define AWAC_MAKER_CRYSTAL 1
+#define AWAC_REV_SCREAMER 3
+#define AWAC_VALID_DATA 0x40
+
+static uint64_t screamer_read(void *opaque, hwaddr addr, unsigned size)
+{
+    qemu_log_mask(LOG_UNIMP,
+                  "macio: screamer read %" HWADDR_PRIx "  %d\n", addr, size);
+    return (addr == AWAC_CODEC_STATUS_REG ? AWAC_VALID_DATA << 8 |
+            AWAC_MAKER_CRYSTAL << 16 | AWAC_REV_SCREAMER << 20 : 0);
+}
+
+static void screamer_write(void *opaque, hwaddr addr,
+                           uint64_t val, unsigned size)
+{
+    qemu_log_mask(LOG_UNIMP,
+                  "macio: screamer write %" HWADDR_PRIx "  %d = %"PRIx64"\n",
+                  addr, size, val);
+}
+
+const MemoryRegionOps screamer_ops = {
+    .read = screamer_read,
+    .write = screamer_write,
+};
+
 static void macio_common_realize(PCIDevice *d, Error **errp)
 {
     MacIOState *s = MACIO(d);
@@ -158,6 +186,7 @@ static void macio_oldworld_realize(PCIDevice *d, Error **errp)
     DeviceState *pic_dev = DEVICE(os->pic);
     Error *err = NULL;
     SysBusDevice *sysbus_dev;
+    MemoryRegion *screamer = g_new(MemoryRegion, 1);
 
     macio_common_realize(d, &err);
     if (err) {
@@ -217,6 +246,11 @@ static void macio_oldworld_realize(PCIDevice *d, Error **errp)
         error_propagate(errp, err);
         return;
     }
+
+    /* Dummy screamer sound device */
+    memory_region_init_io(screamer, OBJECT(d), &screamer_ops, NULL,
+                          "screamer", 0x2000);
+    memory_region_add_subregion(&s->bar, 0x14000, screamer);
 }
 
 static void macio_init_ide(MacIOState *s, MACIOIDEState *ide, size_t ide_size,
-- 
2.21.3


