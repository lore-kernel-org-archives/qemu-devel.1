Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7CDAC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 09:33:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF718212CC
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 09:33:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF718212CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51612 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jokje-0004b0-VT
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 05:33:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55390)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1jokbM-0005r0-Un; Fri, 26 Jun 2020 05:24:52 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167]:34330
 helo=mail.default.ilande.uk0.bigv.io)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1jokbI-0005El-84; Fri, 26 Jun 2020 05:24:52 -0400
Received: from host86-158-109-79.range86-158.btcentralplus.com
 ([86.158.109.79] helo=kentang.home)
 by mail.default.ilande.uk0.bigv.io with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1jokbH-0007bz-4B; Fri, 26 Jun 2020 10:24:50 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: peter.maydell@linaro.org, laurent@vivier.eu, david@gibson.dropbear.id.au,
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Date: Fri, 26 Jun 2020 10:23:10 +0100
Message-Id: <20200626092317.3875-16-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200626092317.3875-1-mark.cave-ayland@ilande.co.uk>
References: <20200626092317.3875-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.158.109.79
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PULL 15/22] adb: add autopoll_blocked variable to block autopoll
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

Whilst autopoll is enabled it is necessary to prevent the ADB buffer contents
from being overwritten until the host has read back the response in its
entirety.

Add adb_autopoll_block() and adb_autopoll_unblock() functions in preparation
for ensuring that the ADB buffer contents are protected for explicit ADB
requests.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Tested-by: Finn Thain <fthain@telegraphics.com.au>
Acked-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20200623204936.24064-16-mark.cave-ayland@ilande.co.uk>
---
 hw/input/adb.c         | 21 +++++++++++++++++++++
 include/hw/input/adb.h |  4 ++++
 2 files changed, 25 insertions(+)

diff --git a/hw/input/adb.c b/hw/input/adb.c
index b3ad7c5fca..70aa1f4570 100644
--- a/hw/input/adb.c
+++ b/hw/input/adb.c
@@ -157,6 +157,26 @@ void adb_set_autopoll_mask(ADBBusState *s, uint16_t mask)
     }
 }
 
+void adb_autopoll_block(ADBBusState *s)
+{
+    s->autopoll_blocked = true;
+
+    if (s->autopoll_enabled) {
+        timer_del(s->autopoll_timer);
+    }
+}
+
+void adb_autopoll_unblock(ADBBusState *s)
+{
+    s->autopoll_blocked = false;
+
+    if (s->autopoll_enabled) {
+        timer_mod(s->autopoll_timer,
+                  qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) +
+                  s->autopoll_rate_ms);
+    }
+}
+
 static void adb_autopoll(void *opaque)
 {
     ADBBusState *s = opaque;
@@ -184,6 +204,7 @@ static const VMStateDescription vmstate_adb_bus = {
         VMSTATE_BOOL(autopoll_enabled, ADBBusState),
         VMSTATE_UINT8(autopoll_rate_ms, ADBBusState),
         VMSTATE_UINT16(autopoll_mask, ADBBusState),
+        VMSTATE_BOOL(autopoll_blocked, ADBBusState),
         VMSTATE_END_OF_LIST()
     }
 };
diff --git a/include/hw/input/adb.h b/include/hw/input/adb.h
index cff264739c..bb75a7b1e3 100644
--- a/include/hw/input/adb.h
+++ b/include/hw/input/adb.h
@@ -86,6 +86,7 @@ struct ADBBusState {
 
     QEMUTimer *autopoll_timer;
     bool autopoll_enabled;
+    bool autopoll_blocked;
     uint8_t autopoll_rate_ms;
     uint16_t autopoll_mask;
     void (*autopoll_cb)(void *opaque);
@@ -96,6 +97,9 @@ int adb_request(ADBBusState *s, uint8_t *buf_out,
                 const uint8_t *buf, int len);
 int adb_poll(ADBBusState *s, uint8_t *buf_out, uint16_t poll_mask);
 
+void adb_autopoll_block(ADBBusState *s);
+void adb_autopoll_unblock(ADBBusState *s);
+
 void adb_set_autopoll_enabled(ADBBusState *s, bool enabled);
 void adb_set_autopoll_rate_ms(ADBBusState *s, int rate_ms);
 void adb_set_autopoll_mask(ADBBusState *s, uint16_t mask);
-- 
2.20.1


