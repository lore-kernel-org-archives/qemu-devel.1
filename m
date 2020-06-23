Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01D00C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 21:05:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C78F720702
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 21:04:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C78F720702
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33470 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnq6E-0004Is-T7
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 17:04:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45900)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1jnptT-00069I-FI; Tue, 23 Jun 2020 16:51:47 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167]:56512
 helo=mail.default.ilande.uk0.bigv.io)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1jnptR-0002Og-Ie; Tue, 23 Jun 2020 16:51:47 -0400
Received: from host86-158-109-79.range86-158.btcentralplus.com
 ([86.158.109.79] helo=kentang.home)
 by mail.default.ilande.uk0.bigv.io with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1jnptN-0007T1-BS; Tue, 23 Jun 2020 21:51:47 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, laurent@vivier.eu,
 fthain@telegraphics.com.au
Date: Tue, 23 Jun 2020 21:49:36 +0100
Message-Id: <20200623204936.24064-23-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200623204936.24064-1-mark.cave-ayland@ilande.co.uk>
References: <20200623204936.24064-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.158.109.79
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 22/22] adb: add ADB bus trace events
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.default.ilande.uk0.bigv.io)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk;
 helo=mail.default.ilande.uk0.bigv.io
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Finn Thain <fthain@telegraphics.com.au>
---
 hw/input/adb.c        | 21 ++++++++++++++++++++-
 hw/input/trace-events |  7 +++++++
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/hw/input/adb.c b/hw/input/adb.c
index fe0f6c7ef3..013fcc9c54 100644
--- a/hw/input/adb.c
+++ b/hw/input/adb.c
@@ -29,10 +29,18 @@
 #include "qemu/module.h"
 #include "qemu/timer.h"
 #include "adb-internal.h"
+#include "trace.h"
 
 /* error codes */
 #define ADB_RET_NOTPRESENT (-2)
 
+static const char *adb_commands[] = {
+    "RESET", "FLUSH", "(Reserved 0x2)", "(Reserved 0x3)",
+    "Reserved (0x4)", "(Reserved 0x5)", "(Reserved 0x6)", "(Reserved 0x7)",
+    "LISTEN r0", "LISTEN r1", "LISTEN r2", "LISTEN r3",
+    "TALK r0", "TALK r1", "TALK r2", "TALK r3",
+};
+
 static void adb_device_reset(ADBDevice *d)
 {
     qdev_reset_all(DEVICE(d));
@@ -86,9 +94,16 @@ static int do_adb_request(ADBBusState *s, uint8_t *obuf, const uint8_t *buf,
 
 int adb_request(ADBBusState *s, uint8_t *obuf, const uint8_t *buf, int len)
 {
+    int ret;
+
+    trace_adb_bus_request(buf[0] >> 4, adb_commands[buf[0] & 0xf], len);
+
     assert(s->autopoll_blocked);
 
-    return do_adb_request(s, obuf, buf, len);
+    ret = do_adb_request(s, obuf, buf, len);
+
+    trace_adb_bus_request_done(buf[0] >> 4, adb_commands[buf[0] & 0xf], ret);
+    return ret;
 }
 
 int adb_poll(ADBBusState *s, uint8_t *obuf, uint16_t poll_mask)
@@ -161,6 +176,7 @@ void adb_set_autopoll_mask(ADBBusState *s, uint16_t mask)
 void adb_autopoll_block(ADBBusState *s)
 {
     s->autopoll_blocked = true;
+    trace_adb_bus_autopoll_block(s->autopoll_blocked);
 
     if (s->autopoll_enabled) {
         timer_del(s->autopoll_timer);
@@ -170,6 +186,7 @@ void adb_autopoll_block(ADBBusState *s)
 void adb_autopoll_unblock(ADBBusState *s)
 {
     s->autopoll_blocked = false;
+    trace_adb_bus_autopoll_block(s->autopoll_blocked);
 
     if (s->autopoll_enabled) {
         timer_mod(s->autopoll_timer,
@@ -183,7 +200,9 @@ static void adb_autopoll(void *opaque)
     ADBBusState *s = opaque;
 
     if (!s->autopoll_blocked) {
+        trace_adb_bus_autopoll_cb(s->autopoll_mask);
         s->autopoll_cb(s->autopoll_cb_opaque);
+        trace_adb_bus_autopoll_cb_done(s->autopoll_mask);
     }
 
     timer_mod(s->autopoll_timer,
diff --git a/hw/input/trace-events b/hw/input/trace-events
index 6f0d78241c..1dd8ad6018 100644
--- a/hw/input/trace-events
+++ b/hw/input/trace-events
@@ -14,6 +14,13 @@ adb_device_mouse_readreg(int reg, uint8_t val0, uint8_t val1) "reg %d obuf[0] 0x
 adb_device_mouse_request_change_addr(int devaddr) "change addr to 0x%x"
 adb_device_mouse_request_change_addr_and_handler(int devaddr, int handler) "change addr and handler to 0x%x, 0x%x"
 
+# adb.c
+adb_bus_request(uint8_t addr, const char *cmd, int size) "device 0x%x %s cmdsize=%d"
+adb_bus_request_done(uint8_t addr, const char *cmd, int size) "device 0x%x %s replysize=%d"
+adb_bus_autopoll_block(bool blocked) "blocked: %d"
+adb_bus_autopoll_cb(uint16_t mask) "executing autopoll_cb with autopoll mask 0x%x"
+adb_bus_autopoll_cb_done(uint16_t mask) "done executing autopoll_cb with autopoll mask 0x%x"
+
 # pckbd.c
 pckbd_kbd_read_data(uint32_t val) "0x%02x"
 pckbd_kbd_read_status(int status) "0x%02x"
-- 
2.20.1


