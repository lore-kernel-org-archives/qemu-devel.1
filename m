Return-Path: <SRS0=McoT=XE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11EA5C4740A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 16:02:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBEFE2084D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 16:01:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBEFE2084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58396 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7M74-0001nB-Cc
	for qemu-devel@archiver.kernel.org; Mon, 09 Sep 2019 12:01:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59549)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1i7M48-0008Oh-7Y
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 11:58:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1i7M46-0001ai-Nq
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 11:58:56 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:45445)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1i7M46-0001aA-2i; Mon, 09 Sep 2019 11:58:54 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1N332D-1iHZJB3d1h-013J9E; Mon, 09 Sep 2019 17:58:29 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Mon,  9 Sep 2019 17:58:08 +0200
Message-Id: <20190909155813.27760-5-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190909155813.27760-1-laurent@vivier.eu>
References: <20190909155813.27760-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:8hJHv8g+pzlaXTuaiWQ3/L3ENgIU5WSGr5thhdcx65QDk1riDKt
 fZeDH0+88By1rRwI9bduWXdUHVnpU6O9svgs1cmepDGWZjH21iMnxJxO1l2mTG3qFgjYItB
 NrqXBrfIqo26VJyPW0DY2GC7mncBQFrv6o5DAFjpaxZG84ZCwBOEJduiNf53OvNoActEbhc
 zPYf4F0diD8OkipaXGmlg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:XYmLKxYZI80=:mzrurWVHlVzLZm5QICSCt1
 AEj9SWl+RQ82revjiqRDNGicV23FyWKVlGlBIeEiAjyB9pmnt+LtwsmMxfKAK8fA1t3m1FIn9
 QT5zGhal23VFij1FyakPuGbedb6NBzAHJuIYRAEBhqcwymfjRzdQd0QuweyJ+oQzYDr2GmmBU
 vZoYPmg0AlRyvP+UhwzhbCMoz6FR/k6qK5o/ivlZmyVeJOkNsMPAgHSAMjuuP3W4shleZJ2Nn
 i7/OILqK0w9PHruOB2s80rIqJv9g+fpiiYFZ3xjxBl7qQHswzG6TD+dqDhlr6Y8QTnLajCCxw
 RlO1LiqNqy0iYQvc6g2kpTpTx2SaChulggAvNfOrRYq1mcSIR3KFi9zfZ8LtVEoUfmGYehSHS
 ZfFF5DgLpMVE6VmOfnIWOxxYhks2QJYYYUsk3HeEASxXWoheQEHhztP06LpPYDSsueMsysgDA
 HtlPmyt+Yn5N83U3UJ/SOhEL+aI1nIK/0vl6WGWxsJFDQb9kKhK8BS/zFiC1mzQoCO7jWCnFR
 O8h9MQV+WZnR8Dm977v1WuCZXFsGfpeDZ8WUOlc4YbVL3fI9I+P7Wijdnh/RsnoSp8g8BNz0D
 ltQGparADQvrtS5EPKx9t+F6z/PJy9T67veXZpVN6DvHNmtNWP5WMlVV3ABY6+0Ytt7i27a1y
 7nXzFDJZcDa6/fopHbiG5HQQIa1T9ro6mBwQi2RBWssLO/dy1yehNwg7SI1lRHrVs2izdH8zh
 QUNSiYksUATU6yZ9HMO2Y7N6nYTb/jehCDgcb2P3/8fOyxp8I7Nj9y38j+pe9q6BzX9E0JWOw
 dBVy333jDOD8Hn77d1k/MACk2bxKzx3XQ8s+MN6KNS2iHSrd3s=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.130
Subject: [Qemu-devel] [PATCH v9 4/9] hw/m68k: implement ADB bus support for
 via
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Thomas Huth <huth@tuxfamily.org>,
 Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Co-developed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Hervé Poussineau <hpoussin@reactos.org>
Reviewed-by: Thomas Huth <huth@tuxfamily.org>
---
 hw/misc/mac_via.c         | 190 ++++++++++++++++++++++++++++++++++++++
 include/hw/misc/mac_via.h |   7 ++
 2 files changed, 197 insertions(+)

diff --git a/hw/misc/mac_via.c b/hw/misc/mac_via.c
index 64914b806e..76cb5f8883 100644
--- a/hw/misc/mac_via.c
+++ b/hw/misc/mac_via.c
@@ -263,10 +263,16 @@
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
@@ -448,6 +454,181 @@ static void via1_rtc_update(MacVIAState *m)
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
@@ -510,6 +691,10 @@ static void mac_via_reset(DeviceState *dev)
 {
     MacVIAState *m = MAC_VIA(dev);
 
+    timer_mod(m->adb_poll_timer,
+              qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
+              (NANOSECONDS_PER_SECOND / VIA_ADB_POLL_FREQ));
+
     timer_mod(m->VBL_timer, (qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + 16630)
               / 16630 * 16630);
 
@@ -548,6 +733,10 @@ static void mac_via_realize(DeviceState *dev, Error **errp)
 
     qemu_get_timedate(&tm, 0);
     m->tick_offset = (uint32_t)mktimegm(&tm) + RTC_OFFSET;
+
+    m->adb_poll_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, via_adb_poll, m);
+    m->adb_data_ready = qdev_get_gpio_in_named(dev, "via1-irq",
+                                               VIA1_IRQ_ADB_READY_BIT);
 }
 
 static void mac_via_init(Object *obj)
@@ -596,6 +785,7 @@ static void mos6522_q800_via1_portB_write(MOS6522State *s)
     MacVIAState *m = container_of(v1s, MacVIAState, mos6522_via1);
 
     via1_rtc_update(m);
+    via1_adb_update(m);
 
     v1s->last_b = s->b;
 }
diff --git a/include/hw/misc/mac_via.h b/include/hw/misc/mac_via.h
index 69bdecabb0..2181140293 100644
--- a/include/hw/misc/mac_via.h
+++ b/include/hw/misc/mac_via.h
@@ -97,6 +97,13 @@ typedef struct MacVIAState {
 
     /* ADB */
     ADBBusState adb_bus;
+    QEMUTimer *adb_poll_timer;
+    qemu_irq adb_data_ready;
+    int adb_data_in_size;
+    int adb_data_in_index;
+    int adb_data_out_index;
+    uint8_t adb_data_in[128];
+    uint8_t adb_data_out[16];
 
     /* external timers */
     QEMUTimer *one_second_timer;
-- 
2.21.0


