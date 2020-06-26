Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E318C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 09:28:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74024212CC
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 09:28:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74024212CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jokea-0003bG-MH
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 05:28:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55060)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1jokb0-00055I-Bk; Fri, 26 Jun 2020 05:24:31 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167]:34290
 helo=mail.default.ilande.uk0.bigv.io)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1jokay-0004sa-Ju; Fri, 26 Jun 2020 05:24:30 -0400
Received: from host86-158-109-79.range86-158.btcentralplus.com
 ([86.158.109.79] helo=kentang.home)
 by mail.default.ilande.uk0.bigv.io with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1jokav-0007bz-Ev; Fri, 26 Jun 2020 10:24:31 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: peter.maydell@linaro.org, laurent@vivier.eu, david@gibson.dropbear.id.au,
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Date: Fri, 26 Jun 2020 10:23:06 +0100
Message-Id: <20200626092317.3875-12-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200626092317.3875-1-mark.cave-ayland@ilande.co.uk>
References: <20200626092317.3875-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.158.109.79
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PULL 11/22] adb: introduce new ADBDeviceHasData method to
 ADBDeviceClass
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

This is required later to allow devices to assert a service request (SRQ)
signal to indicate that it has data to send, without having to consume it.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Tested-by: Finn Thain <fthain@telegraphics.com.au>
Acked-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20200623204936.24064-12-mark.cave-ayland@ilande.co.uk>
---
 hw/input/adb-kbd.c     | 8 ++++++++
 hw/input/adb-mouse.c   | 9 +++++++++
 include/hw/input/adb.h | 3 +++
 3 files changed, 20 insertions(+)

diff --git a/hw/input/adb-kbd.c b/hw/input/adb-kbd.c
index 027dd3e531..23760ecf7b 100644
--- a/hw/input/adb-kbd.c
+++ b/hw/input/adb-kbd.c
@@ -300,6 +300,13 @@ static int adb_kbd_request(ADBDevice *d, uint8_t *obuf,
     return olen;
 }
 
+static bool adb_kbd_has_data(ADBDevice *d)
+{
+    KBDState *s = ADB_KEYBOARD(d);
+
+    return s->count > 0;
+}
+
 /* This is where keyboard events enter this file */
 static void adb_keyboard_event(DeviceState *dev, QemuConsole *src,
                                InputEvent *evt)
@@ -382,6 +389,7 @@ static void adb_kbd_class_init(ObjectClass *oc, void *data)
     set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
 
     adc->devreq = adb_kbd_request;
+    adc->devhasdata = adb_kbd_has_data;
     dc->reset = adb_kbd_reset;
     dc->vmsd = &vmstate_adb_kbd;
 }
diff --git a/hw/input/adb-mouse.c b/hw/input/adb-mouse.c
index 78b6f5030c..e2359fd74d 100644
--- a/hw/input/adb-mouse.c
+++ b/hw/input/adb-mouse.c
@@ -197,6 +197,14 @@ static int adb_mouse_request(ADBDevice *d, uint8_t *obuf,
     return olen;
 }
 
+static bool adb_mouse_has_data(ADBDevice *d)
+{
+    MouseState *s = ADB_MOUSE(d);
+
+    return !(s->last_buttons_state == s->buttons_state &&
+             s->dx == 0 && s->dy == 0);
+}
+
 static void adb_mouse_reset(DeviceState *dev)
 {
     ADBDevice *d = ADB_DEVICE(dev);
@@ -252,6 +260,7 @@ static void adb_mouse_class_init(ObjectClass *oc, void *data)
     set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
 
     adc->devreq = adb_mouse_request;
+    adc->devhasdata = adb_mouse_has_data;
     dc->reset = adb_mouse_reset;
     dc->vmsd = &vmstate_adb_mouse;
 }
diff --git a/include/hw/input/adb.h b/include/hw/input/adb.h
index 15b1874a3d..9b80204e43 100644
--- a/include/hw/input/adb.h
+++ b/include/hw/input/adb.h
@@ -39,6 +39,8 @@ typedef struct ADBDevice ADBDevice;
 typedef int ADBDeviceRequest(ADBDevice *d, uint8_t *buf_out,
                               const uint8_t *buf, int len);
 
+typedef bool ADBDeviceHasData(ADBDevice *d);
+
 #define TYPE_ADB_DEVICE "adb-device"
 #define ADB_DEVICE(obj) OBJECT_CHECK(ADBDevice, (obj), TYPE_ADB_DEVICE)
 
@@ -62,6 +64,7 @@ typedef struct ADBDeviceClass {
     /*< public >*/
 
     ADBDeviceRequest *devreq;
+    ADBDeviceHasData *devhasdata;
 } ADBDeviceClass;
 
 #define TYPE_ADB_BUS "apple-desktop-bus"
-- 
2.20.1


