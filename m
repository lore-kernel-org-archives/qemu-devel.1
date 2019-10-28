Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAC93CA9EC0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 18:51:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6AC7208C0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 18:51:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6AC7208C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48582 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPA7I-0001xM-Nh
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 14:51:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56611)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iP9Zp-0002hT-Pz
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 14:17:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iP9Zn-00043B-Rd
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 14:17:13 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:51391)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1iP9Zj-0003yY-Fa; Mon, 28 Oct 2019 14:17:07 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1McHQA-1hrCnW2N5A-00cf2x; Mon, 28 Oct 2019 19:16:59 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 06/11] hw/m68k: implement ADB bus support for via
Date: Mon, 28 Oct 2019 19:16:38 +0100
Message-Id: <20191028181643.5143-7-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191028181643.5143-1-laurent@vivier.eu>
References: <20191028181643.5143-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:ML494i2SGiUImlmvTOOclLBZ3Ydc1KcCBKhfLOr8gsyq0LmBZW/
 /KKnIVdtjsGHJkYcUNHGpgbvw3Tf26lFg1dkSxDtlxx4TV+ndKJ/d6IxBNZF/Vt5nb8xzVY
 PFM5NjKDdtH/0BIoSHfOtxXNjDFHGYbwq1TlwyF+ngJ4ZdHSAWftEU3u6brWctMWSVWzsWk
 A7tRtSKAVKwnm0DkCQRPw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3JKCi0FPCFo=:hUD9ByI7XqpuySEFY8XECp
 kqsdWTraQqV5HsbzS2tWyclsXbHauWvF48O59wt8AYHKlHlWO79/Y6SlUSPcUyBtByEmxFO0t
 FqqkFyBlA5BN3mZqKIX4uUM5H8po6oyDRE739Hg6Z0p+Z2rJ7sXMoIOYIYPqFE1GbQbyBxF4u
 w3rQJ9YY/XC+IvjoIdc2EMTHxTbV+hXTWID0GCZS6Et3DkPQaZqg223agLqGMXYkO3EkYpa6F
 9s+1OH18pZBzvBbuxu5wZZlJgjO0o1cdLaFNziocto5Wa1g3UHmouWIWWCELoDHEFNihk4TFz
 0xYfTcpPUEpIM0QZAJarcmEODRa10fUmUvSBD9evAuAKoDOwJAQ/PvYwGkfFfVtKSw1TsjiAq
 gf7JSdImiXB2ayWpAfkaYi8NrJ7uYPlVVB+RQRU0bSs1cM3TsUI59xNSCjlt3Dl461K+0j/gd
 WtV0eQspDQAD3dqGhwIg2A8POsPPtQ5IYWXUJTxIqh/8CbeqyLFemi0JCiGQAk6cW23AzN0SS
 2KZ1HbWB+b+7BBsNKqDX0I4lEubROesjYBPF7/VR1tUBuaN8vPtsrTNxXqkyW2mobTJ8Hp28M
 hJdb2Mkq1ZtZOnxXDno2kmdgBrD0Bzyq0oCby91Zk4xO/35vzYIxVXoOHFcCVQ+bf5GRmRvSn
 IMttXvzg3EefmLxCStLsVqUsS8bUIpJyenkd8+u5Y2+bWY9jeqSi2dQaQhUBMu7mBqDx36HbC
 7vjt46pfqOl6DsN6509a9SdUIOHjrRK+6039qZkW9SUGU7jMZP+0jQHD8X0PTLu0mc4feHaDS
 1Ln4hg/9hqtoZypuB4oqEkdTLiw2gl0bisFGfKUuY57+vkVHMzCHwuntj7WAUolFH/ra5WI57
 eRDJeyKYwYLtFSoI64CgEWKIA686PcoolB6qZDFJA=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.17.13
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
 Laurent Vivier <laurent@vivier.eu>, Max Reitz <mreitz@redhat.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Paolo Bonzini <pbonzini@redhat.com>
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
Message-Id: <20191026164546.30020-7-laurent@vivier.eu>
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


