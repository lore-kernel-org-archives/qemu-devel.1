Return-Path: <SRS0=clLO=73=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB69FC433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2020 14:36:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94535206D7
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2020 14:36:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94535206D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51582 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkTkc-0001fY-Rm
	for qemu-devel@archiver.kernel.org; Sun, 14 Jun 2020 10:36:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52354)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1jkTf8-0000Yp-RD; Sun, 14 Jun 2020 10:31:06 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167]:38502
 helo=mail.default.ilande.uk0.bigv.io)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1jkTf6-0005Zi-Us; Sun, 14 Jun 2020 10:31:06 -0400
Received: from host217-39-64-113.range217-39.btcentralplus.com
 ([217.39.64.113] helo=kentang.home)
 by mail.default.ilande.uk0.bigv.io with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1jkTew-0006Hv-3U; Sun, 14 Jun 2020 15:31:03 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, laurent@vivier.eu,
 fthain@telegraphics.com.au
Date: Sun, 14 Jun 2020 15:28:39 +0100
Message-Id: <20200614142840.10245-22-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200614142840.10245-1-mark.cave-ayland@ilande.co.uk>
References: <20200614142840.10245-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 217.39.64.113
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 21/22] adb: use adb_device prefix for ADB device trace events
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

This is to allow us to distinguish between ADB device events and ADB
bus events separately.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/input/adb-kbd.c    | 12 ++++++------
 hw/input/adb-mouse.c  | 12 ++++++------
 hw/input/trace-events | 20 ++++++++++----------
 3 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/hw/input/adb-kbd.c b/hw/input/adb-kbd.c
index 23760ecf7b..3cfb6a7a20 100644
--- a/hw/input/adb-kbd.c
+++ b/hw/input/adb-kbd.c
@@ -243,7 +243,7 @@ static int adb_kbd_request(ADBDevice *d, uint8_t *obuf,
     olen = 0;
     switch (cmd) {
     case ADB_WRITEREG:
-        trace_adb_kbd_writereg(reg, buf[1]);
+        trace_adb_device_kbd_writereg(reg, buf[1]);
         switch (reg) {
         case 2:
             /* LED status */
@@ -256,7 +256,7 @@ static int adb_kbd_request(ADBDevice *d, uint8_t *obuf,
             case ADB_CMD_CHANGE_ID_AND_ACT:
             case ADB_CMD_CHANGE_ID_AND_ENABLE:
                 d->devaddr = buf[1] & 0xf;
-                trace_adb_kbd_request_change_addr(d->devaddr);
+                trace_adb_device_kbd_request_change_addr(d->devaddr);
                 break;
             default:
                 d->devaddr = buf[1] & 0xf;
@@ -270,8 +270,8 @@ static int adb_kbd_request(ADBDevice *d, uint8_t *obuf,
                     d->handler = buf[2];
                 }
 
-                trace_adb_kbd_request_change_addr_and_handler(d->devaddr,
-                                                              d->handler);
+                trace_adb_device_kbd_request_change_addr_and_handler(
+                    d->devaddr, d->handler);
                 break;
             }
         }
@@ -294,7 +294,7 @@ static int adb_kbd_request(ADBDevice *d, uint8_t *obuf,
             olen = 2;
             break;
         }
-        trace_adb_kbd_readreg(reg, obuf[0], obuf[1]);
+        trace_adb_device_kbd_readreg(reg, obuf[0], obuf[1]);
         break;
     }
     return olen;
@@ -321,7 +321,7 @@ static void adb_keyboard_event(DeviceState *dev, QemuConsole *src,
     /* FIXME: take handler into account when translating qcode */
     keycode = qcode_to_adb_keycode[qcode];
     if (keycode == NO_KEY) {  /* We don't want to send this to the guest */
-        trace_adb_kbd_no_key();
+        trace_adb_device_kbd_no_key();
         return;
     }
     if (evt->u.key.data->down == false) { /* if key release event */
diff --git a/hw/input/adb-mouse.c b/hw/input/adb-mouse.c
index e2359fd74d..577a38ff2e 100644
--- a/hw/input/adb-mouse.c
+++ b/hw/input/adb-mouse.c
@@ -121,7 +121,7 @@ static int adb_mouse_request(ADBDevice *d, uint8_t *obuf,
         s->dx = 0;
         s->dy = 0;
         s->dz = 0;
-        trace_adb_mouse_flush();
+        trace_adb_device_mouse_flush();
         return 0;
     }
 
@@ -130,7 +130,7 @@ static int adb_mouse_request(ADBDevice *d, uint8_t *obuf,
     olen = 0;
     switch (cmd) {
     case ADB_WRITEREG:
-        trace_adb_mouse_writereg(reg, buf[1]);
+        trace_adb_device_mouse_writereg(reg, buf[1]);
         switch (reg) {
         case 2:
             break;
@@ -152,7 +152,7 @@ static int adb_mouse_request(ADBDevice *d, uint8_t *obuf,
             case ADB_CMD_CHANGE_ID_AND_ACT:
             case ADB_CMD_CHANGE_ID_AND_ENABLE:
                 d->devaddr = buf[1] & 0xf;
-                trace_adb_mouse_request_change_addr(d->devaddr);
+                trace_adb_device_mouse_request_change_addr(d->devaddr);
                 break;
             default:
                 d->devaddr = buf[1] & 0xf;
@@ -172,8 +172,8 @@ static int adb_mouse_request(ADBDevice *d, uint8_t *obuf,
                     d->handler = buf[2];
                 }
 
-                trace_adb_mouse_request_change_addr_and_handler(d->devaddr,
-                                                                d->handler);
+                trace_adb_device_mouse_request_change_addr_and_handler(
+                    d->devaddr, d->handler);
                 break;
             }
         }
@@ -191,7 +191,7 @@ static int adb_mouse_request(ADBDevice *d, uint8_t *obuf,
             olen = 2;
             break;
         }
-        trace_adb_mouse_readreg(reg, obuf[0], obuf[1]);
+        trace_adb_device_mouse_readreg(reg, obuf[0], obuf[1]);
         break;
     }
     return olen;
diff --git a/hw/input/trace-events b/hw/input/trace-events
index a2888fd10c..6f0d78241c 100644
--- a/hw/input/trace-events
+++ b/hw/input/trace-events
@@ -1,18 +1,18 @@
 # See docs/devel/tracing.txt for syntax documentation.
 
 # adb-kbd.c
-adb_kbd_no_key(void) "Ignoring NO_KEY"
-adb_kbd_writereg(int reg, uint8_t val) "reg %d val 0x%2.2x"
-adb_kbd_readreg(int reg, uint8_t val0, uint8_t val1) "reg %d obuf[0] 0x%2.2x obuf[1] 0x%2.2x"
-adb_kbd_request_change_addr(int devaddr) "change addr to 0x%x"
-adb_kbd_request_change_addr_and_handler(int devaddr, int handler) "change addr and handler to 0x%x, 0x%x"
+adb_device_kbd_no_key(void) "Ignoring NO_KEY"
+adb_device_kbd_writereg(int reg, uint8_t val) "reg %d val 0x%2.2x"
+adb_device_kbd_readreg(int reg, uint8_t val0, uint8_t val1) "reg %d obuf[0] 0x%2.2x obuf[1] 0x%2.2x"
+adb_device_kbd_request_change_addr(int devaddr) "change addr to 0x%x"
+adb_device_kbd_request_change_addr_and_handler(int devaddr, int handler) "change addr and handler to 0x%x, 0x%x"
 
 # adb-mouse.c
-adb_mouse_flush(void) "flush"
-adb_mouse_writereg(int reg, uint8_t val) "reg %d val 0x%2.2x"
-adb_mouse_readreg(int reg, uint8_t val0, uint8_t val1) "reg %d obuf[0] 0x%2.2x obuf[1] 0x%2.2x"
-adb_mouse_request_change_addr(int devaddr) "change addr to 0x%x"
-adb_mouse_request_change_addr_and_handler(int devaddr, int handler) "change addr and handler to 0x%x, 0x%x"
+adb_device_mouse_flush(void) "flush"
+adb_device_mouse_writereg(int reg, uint8_t val) "reg %d val 0x%2.2x"
+adb_device_mouse_readreg(int reg, uint8_t val0, uint8_t val1) "reg %d obuf[0] 0x%2.2x obuf[1] 0x%2.2x"
+adb_device_mouse_request_change_addr(int devaddr) "change addr to 0x%x"
+adb_device_mouse_request_change_addr_and_handler(int devaddr, int handler) "change addr and handler to 0x%x, 0x%x"
 
 # pckbd.c
 pckbd_kbd_read_data(uint32_t val) "0x%02x"
-- 
2.20.1


