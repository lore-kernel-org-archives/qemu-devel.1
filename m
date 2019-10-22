Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EE5BCA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 11:23:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 210D520B7C
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 11:23:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 210D520B7C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53500 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMsGE-0002zU-3Z
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 07:23:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44156)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iMsBN-0004ei-9A
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 07:18:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iMsBK-0007oo-9o
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 07:18:32 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:55347)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1iMsBJ-0007o7-Vc; Tue, 22 Oct 2019 07:18:30 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1McY0J-1hkW5K2Yw9-00czjv; Tue, 22 Oct 2019 13:17:59 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PATCH v14 4/9] hw/m68k: implement ADB bus support for via
Date: Tue, 22 Oct 2019 13:17:33 +0200
Message-Id: <20191022111738.20803-5-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191022111738.20803-1-laurent@vivier.eu>
References: <20191022111738.20803-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:F7fu6Z+6FksfunG2Z2SbJ3mRvoBcwz8x5z8lT60EGjqe4speIiU
 wvBRaoEbRZ4Yw5JXrFRlwyrmqYRP/Sey6nVQoQZmQZihcd2EGWRegZO6N90SzS+ANjo79eg
 SJhInO72BoMuhkvrqsctxnQrnNhwkAltLufsmR3mXz/f36VkTEskDxoqEgD50YfXCNu/ICM
 mXIbNsDlW3Q36pVaF5/nA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:43v2KnH9owo=:dPSL4ja+w1V+8CzwKswV/j
 LHfF4Eg4AQ4xwH5mzefsjmRexy93Om+J9RYdiVBqmdPe+pMHyTfNY7VQep3pX+6ai1CRnVyMJ
 vj1Vg+iUY7kdC+v3ICQY0UqyskozW6hLumaSjd4BRsQ5y1PLUfa0RITT6aAl8Hg1lo6ROh4y6
 U28rlWHCJGlxfeqg1Ytp8ulf+aEMABIHzeQ0PBF5EflfyGBk3SGJxr2a0f/uMabdFVXeTtoRT
 /wHMBoEoqsRm1NZ2qCWqVpeup8h2VC8oYuJO6iWz0zaEMDJOiSWK0tt8SNJbu1Q2WCngAt0OX
 QYkI9QkLCgvXD3cfU1ceHAW9DJbnqZ4zZZcoCUQbDjbHYvb9qAYTa/i0hYRNCZ/UhjkFqPxb5
 PNtLE9kvDgKgIxqO6LJUficmV1N5vuDD0v8um/YKia/9NhJ8encEEzQbdMO/nTaWx38LQMPSJ
 56DAi5WKDspN5Euz9TNVB878mYD6N/yFmXafWeyDCIBnEMob1LrgTe87zeVW87P/ckIAN7Gjn
 0xbxCN8LC/RL9vUWQMQ3OwleW45TrIEbAuNxfJgU/hPsx8kZC4RqHho4VpXexqSen4IG9aBVa
 GDF3MTvoOmkiXvxkfgtH/cO9rHRWv+oo4ydRd/IV8xcpaWungal4Ehs42y0aQa4tlDtC8mTe7
 0lS6Yh2Y1SzVBiH1nJ9uLvzxh4HKQTfikOJjivlzRkVhjHlURWWXR4eFzFGlYaOC0wqlotinF
 V5aoazgDJaluQoE9JBNrN2vZfwP/VSyIo0efjt11MDNZ/6QmyNtQGN9JflCCg2FW3/0uqV1Xf
 hxDwXEpapoGa9BC3D3oAr0BglxGl+QvEsnuDTIuK3m4xdrbK52Y8ietQaRiuMtLGDHVOly2gN
 fXkeJgcdhMrqwKjCU70dOKSeEkHIn7QZ7jg42R17g=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 217.72.192.74
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, Thomas Huth <huth@tuxfamily.org>,
 Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

VIA needs to be able to poll the ADB interface and to read/write data
from/to the bus.

This patch adds functions allowing that.

Co-developed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Hervé Poussineau <hpoussin@reactos.org>
Reviewed-by: Thomas Huth <huth@tuxfamily.org>
---
 include/hw/misc/mac_via.h |   7 ++
 hw/misc/mac_via.c         | 197 ++++++++++++++++++++++++++++++++++++++
 hw/misc/Kconfig           |   1 +
 3 files changed, 205 insertions(+)

diff --git a/include/hw/misc/mac_via.h b/include/hw/misc/mac_via.h
index efc8ef3ce3..3f86fcb7e1 100644
--- a/include/hw/misc/mac_via.h
+++ b/include/hw/misc/mac_via.h
@@ -103,6 +103,13 @@ typedef struct MacVIAState {
 
     /* ADB */
     ADBBusState adb_bus;
+    QEMUTimer *adb_poll_timer;
+    qemu_irq adb_data_ready;
+    int adb_data_in_size;
+    int adb_data_in_index;
+    int adb_data_out_index;
+    uint8_t adb_data_in[128];
+    uint8_t adb_data_out[16];
 } MacVIAState;
 
 #endif
diff --git a/hw/misc/mac_via.c b/hw/misc/mac_via.c
index d2da8b8e60..f3f130ad96 100644
--- a/hw/misc/mac_via.c
+++ b/hw/misc/mac_via.c
@@ -264,10 +264,16 @@
  * Table 19-10 ADB transaction states
  */
 
+#define ADB_STATE_NEW       0
+#define ADB_STATE_EVEN      1
+#define ADB_STATE_ODD       2
+#define ADB_STATE_IDLE      3
+
 #define VIA1B_vADB_StateMask    (VIA1B_vADBS1 | VIA1B_vADBS2)
 #define VIA1B_vADB_StateShift   4
 
 #define VIA_TIMER_FREQ (783360)
+#define VIA_ADB_POLL_FREQ 50 /* XXX: not real */
 
 /* VIA returns time offset from Jan 1, 1904, not 1970 */
 #define RTC_OFFSET 2082844800
@@ -472,6 +478,181 @@ static void via1_rtc_update(MacVIAState *m)
     }
 }
 
+static int adb_via_poll(MacVIAState *s, int state, uint8_t *data)
+{
+    if (state != ADB_STATE_IDLE) {
+        return 0;
+    }
+
+    if (s->adb_data_in_size < s->adb_data_in_index) {
+        return 0;
+    }
+
+    if (s->adb_data_out_index != 0) {
+        return 0;
+    }
+
+    s->adb_data_in_index = 0;
+    s->adb_data_out_index = 0;
+    s->adb_data_in_size = adb_poll(&s->adb_bus, s->adb_data_in, 0xffff);
+
+    if (s->adb_data_in_size) {
+        *data = s->adb_data_in[s->adb_data_in_index++];
+        qemu_irq_raise(s->adb_data_ready);
+    }
+
+    return s->adb_data_in_size;
+}
+
+static int adb_via_send(MacVIAState *s, int state, uint8_t data)
+{
+    switch (state) {
+    case ADB_STATE_NEW:
+        s->adb_data_out_index = 0;
+        break;
+    case ADB_STATE_EVEN:
+        if ((s->adb_data_out_index & 1) == 0) {
+            return 0;
+        }
+        break;
+    case ADB_STATE_ODD:
+        if (s->adb_data_out_index & 1) {
+            return 0;
+        }
+        break;
+    case ADB_STATE_IDLE:
+        return 0;
+    }
+
+    assert(s->adb_data_out_index < sizeof(s->adb_data_out) - 1);
+
+    s->adb_data_out[s->adb_data_out_index++] = data;
+    qemu_irq_raise(s->adb_data_ready);
+    return 1;
+}
+
+static int adb_via_receive(MacVIAState *s, int state, uint8_t *data)
+{
+    switch (state) {
+    case ADB_STATE_NEW:
+        return 0;
+
+    case ADB_STATE_EVEN:
+        if (s->adb_data_in_size <= 0) {
+            qemu_irq_raise(s->adb_data_ready);
+            return 0;
+        }
+
+        if (s->adb_data_in_index >= s->adb_data_in_size) {
+            *data = 0;
+            qemu_irq_raise(s->adb_data_ready);
+            return 1;
+        }
+
+        if ((s->adb_data_in_index & 1) == 0) {
+            return 0;
+        }
+
+        break;
+
+    case ADB_STATE_ODD:
+        if (s->adb_data_in_size <= 0) {
+            qemu_irq_raise(s->adb_data_ready);
+            return 0;
+        }
+
+        if (s->adb_data_in_index >= s->adb_data_in_size) {
+            *data = 0;
+            qemu_irq_raise(s->adb_data_ready);
+            return 1;
+        }
+
+        if (s->adb_data_in_index & 1) {
+            return 0;
+        }
+
+        break;
+
+    case ADB_STATE_IDLE:
+        if (s->adb_data_out_index == 0) {
+            return 0;
+        }
+
+        s->adb_data_in_size = adb_request(&s->adb_bus, s->adb_data_in,
+                                          s->adb_data_out,
+                                          s->adb_data_out_index);
+        s->adb_data_out_index = 0;
+        s->adb_data_in_index = 0;
+        if (s->adb_data_in_size < 0) {
+            *data = 0xff;
+            qemu_irq_raise(s->adb_data_ready);
+            return -1;
+        }
+
+        if (s->adb_data_in_size == 0) {
+            return 0;
+        }
+
+        break;
+    }
+
+    assert(s->adb_data_in_index < sizeof(s->adb_data_in) - 1);
+
+    *data = s->adb_data_in[s->adb_data_in_index++];
+    qemu_irq_raise(s->adb_data_ready);
+    if (*data == 0xff || *data == 0) {
+        return 0;
+    }
+    return 1;
+}
+
+static void via1_adb_update(MacVIAState *m)
+{
+    MOS6522Q800VIA1State *v1s = MOS6522_Q800_VIA1(&m->mos6522_via1);
+    MOS6522State *s = MOS6522(v1s);
+    int state;
+    int ret;
+
+    state = (s->b & VIA1B_vADB_StateMask) >> VIA1B_vADB_StateShift;
+
+    if (s->acr & VIA1ACR_vShiftOut) {
+        /* output mode */
+        ret = adb_via_send(m, state, s->sr);
+        if (ret > 0) {
+            s->b &= ~VIA1B_vADBInt;
+        } else {
+            s->b |= VIA1B_vADBInt;
+        }
+    } else {
+        /* input mode */
+        ret = adb_via_receive(m, state, &s->sr);
+        if (ret > 0 && s->sr != 0xff) {
+            s->b &= ~VIA1B_vADBInt;
+        } else {
+            s->b |= VIA1B_vADBInt;
+        }
+    }
+}
+
+static void via_adb_poll(void *opaque)
+{
+    MacVIAState *m = opaque;
+    MOS6522Q800VIA1State *v1s = MOS6522_Q800_VIA1(&m->mos6522_via1);
+    MOS6522State *s = MOS6522(v1s);
+    int state;
+
+    if (s->b & VIA1B_vADBInt) {
+        state = (s->b & VIA1B_vADB_StateMask) >> VIA1B_vADB_StateShift;
+        if (adb_via_poll(m, state, &s->sr)) {
+            s->b &= ~VIA1B_vADBInt;
+        }
+    }
+
+    timer_mod(m->adb_poll_timer,
+              qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
+              (NANOSECONDS_PER_SECOND / VIA_ADB_POLL_FREQ));
+}
+
 static uint64_t mos6522_q800_via1_read(void *opaque, hwaddr addr, unsigned size)
 {
     MOS6522Q800VIA1State *s = MOS6522_Q800_VIA1(opaque);
@@ -553,6 +734,10 @@ static void mac_via_reset(DeviceState *dev)
     MacVIAState *m = MAC_VIA(dev);
     MOS6522Q800VIA1State *v1s = &m->mos6522_via1;
 
+    timer_mod(m->adb_poll_timer,
+              qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
+              (NANOSECONDS_PER_SECOND / VIA_ADB_POLL_FREQ));
+
     timer_del(v1s->VBL_timer);
     v1s->next_VBL = 0;
     timer_del(v1s->one_second_timer);
@@ -593,6 +778,10 @@ static void mac_via_realize(DeviceState *dev, Error **errp)
 
     qemu_get_timedate(&tm, 0);
     m->tick_offset = (uint32_t)mktimegm(&tm) + RTC_OFFSET;
+
+    m->adb_poll_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, via_adb_poll, m);
+    m->adb_data_ready = qdev_get_gpio_in_named(dev, "via1-irq",
+                                               VIA1_IRQ_ADB_READY_BIT);
 }
 
 static void mac_via_init(Object *obj)
@@ -642,6 +831,13 @@ static const VMStateDescription vmstate_mac_via = {
         VMSTATE_UINT8(cmd, MacVIAState),
         VMSTATE_INT32(wprotect, MacVIAState),
         VMSTATE_INT32(alt, MacVIAState),
+        /* ADB */
+        VMSTATE_TIMER_PTR(adb_poll_timer, MacVIAState),
+        VMSTATE_INT32(adb_data_in_size, MacVIAState),
+        VMSTATE_INT32(adb_data_in_index, MacVIAState),
+        VMSTATE_INT32(adb_data_out_index, MacVIAState),
+        VMSTATE_BUFFER(adb_data_in, MacVIAState),
+        VMSTATE_BUFFER(adb_data_out, MacVIAState),
         VMSTATE_END_OF_LIST()
     }
 };
@@ -671,6 +867,7 @@ static void mos6522_q800_via1_portB_write(MOS6522State *s)
     MacVIAState *m = container_of(v1s, MacVIAState, mos6522_via1);
 
     via1_rtc_update(m);
+    via1_adb_update(m);
 
     v1s->last_b = s->b;
 }
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index 18a5dc9c09..2164646553 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -123,5 +123,6 @@ config UNIMP
 config MAC_VIA
     bool
     select MOS6522
+    select ADB
 
 source macio/Kconfig
-- 
2.21.0


