Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3D96C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 08:52:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8B6F206C3
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 08:52:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8B6F206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34370 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jaxzZ-0007Ep-Tx
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 04:52:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54040)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <geert@linux-m68k.org>)
 id 1jaxyW-0006D5-MI
 for qemu-devel@nongnu.org; Tue, 19 May 2020 04:51:48 -0400
Received: from laurent.telenet-ops.be ([2a02:1800:110:4::f00:19]:49374)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <geert@linux-m68k.org>)
 id 1jaxyV-0004KV-In
 for qemu-devel@nongnu.org; Tue, 19 May 2020 04:51:48 -0400
Received: from ramsan ([IPv6:2a02:1810:ac12:ed60:918e:b928:22c1:d715])
 by laurent.telenet-ops.be with bizsmtp
 id gYrk2200S4CPMDc01Yrkql; Tue, 19 May 2020 10:51:44 +0200
Received: from rox.of.borg ([192.168.97.57]) by ramsan with esmtp (Exim 4.90_1)
 (envelope-from <geert@linux-m68k.org>)
 id 1jaxyS-0002Mh-GL; Tue, 19 May 2020 10:51:44 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
 (envelope-from <geert@linux-m68k.org>)
 id 1jaxyS-0000Mw-E7; Tue, 19 May 2020 10:51:44 +0200
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH] ARM: PL061: Introduce N_GPIOS
Date: Tue, 19 May 2020 10:51:43 +0200
Message-Id: <20200519085143.1376-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2a02:1800:110:4::f00:19;
 envelope-from=geert@linux-m68k.org; helo=laurent.telenet-ops.be
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_LOW=-0.7,
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
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add a definition for the number of GPIO lines controlled by a PL061
instance, and use it instead of the hardcoded magic value 8.

Suggested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 hw/gpio/pl061.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/hw/gpio/pl061.c b/hw/gpio/pl061.c
index 2a828260bdb0b946..6d3c36bc16cf9e0d 100644
--- a/hw/gpio/pl061.c
+++ b/hw/gpio/pl061.c
@@ -36,6 +36,8 @@ static const uint8_t pl061_id_luminary[12] =
 #define TYPE_PL061 "pl061"
 #define PL061(obj) OBJECT_CHECK(PL061State, (obj), TYPE_PL061)
 
+#define N_GPIOS 8
+
 typedef struct PL061State {
     SysBusDevice parent_obj;
 
@@ -62,7 +64,7 @@ typedef struct PL061State {
     uint32_t cr;
     uint32_t amsel;
     qemu_irq irq;
-    qemu_irq out[8];
+    qemu_irq out[N_GPIOS];
     const unsigned char *id;
     uint32_t rsvd_start; /* reserved area: [rsvd_start, 0xfcc] */
 } PL061State;
@@ -112,7 +114,7 @@ static void pl061_update(PL061State *s)
     changed = s->old_out_data ^ out;
     if (changed) {
         s->old_out_data = out;
-        for (i = 0; i < 8; i++) {
+        for (i = 0; i < N_GPIOS; i++) {
             mask = 1 << i;
             if (changed & mask) {
                 DPRINTF("Set output %d = %d\n", i, (out & mask) != 0);
@@ -125,7 +127,7 @@ static void pl061_update(PL061State *s)
     changed = (s->old_in_data ^ s->data) & ~s->dir;
     if (changed) {
         s->old_in_data = s->data;
-        for (i = 0; i < 8; i++) {
+        for (i = 0; i < N_GPIOS; i++) {
             mask = 1 << i;
             if (changed & mask) {
                 DPRINTF("Changed input %d = %d\n", i, (s->data & mask) != 0);
@@ -364,8 +366,8 @@ static void pl061_init(Object *obj)
     memory_region_init_io(&s->iomem, obj, &pl061_ops, s, "pl061", 0x1000);
     sysbus_init_mmio(sbd, &s->iomem);
     sysbus_init_irq(sbd, &s->irq);
-    qdev_init_gpio_in(dev, pl061_set_irq, 8);
-    qdev_init_gpio_out(dev, s->out, 8);
+    qdev_init_gpio_in(dev, pl061_set_irq, N_GPIOS);
+    qdev_init_gpio_out(dev, s->out, N_GPIOS);
 }
 
 static void pl061_class_init(ObjectClass *klass, void *data)
-- 
2.17.1


