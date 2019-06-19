Return-Path: <SRS0=PARU=US=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0A06C43613
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 22:28:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C2D3215EA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 22:28:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C2D3215EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42352 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdj4S-0000BW-QV
	for qemu-devel@archiver.kernel.org; Wed, 19 Jun 2019 18:28:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36069)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <laurent@vivier.eu>) id 1hdiwu-0001lS-Ul
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 18:21:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1hdiwt-0007qL-A8
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 18:21:00 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:48353)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1hdiwp-0007jo-Rh; Wed, 19 Jun 2019 18:20:56 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1N6sSV-1igEMN0WAJ-018Nv1; Thu, 20 Jun 2019 00:19:56 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Thu, 20 Jun 2019 00:19:28 +0200
Message-Id: <20190619221933.1981-6-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190619221933.1981-1-laurent@vivier.eu>
References: <20190619221933.1981-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:BBoTL/ECTKIHx5+KQHuigAZ+malLinV2NbOCLmG7YQVSLP8Onln
 IFmWfIaF4TX4SGe2M534z8+pCaOswCVXkLNRPyQdoAoXY9nnX1Gr0FxcRI3fY53R9jBPkvC
 iAF07KjZqkMbWuTSnMKkuCftRrAnv9rM7GYzin3sMz1AyaFtv4gNw65GD4gHNqVP2HKfHrV
 VK4aMVXWXx1/InnLq1KhA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:C+CSz9wy2tw=:zk6lLzlfSZj3H2P4TBo6a3
 rzEcXsZqqTNYgop9L7gqgCcUnSjPWkUUyTrcMk8vJkG1A25oNJRp28MJYenXvMYvyYAmnrQpQ
 WUmOH3jh69FkSaG6kYvMIrA90k/SX7or3/lR2b7qUEVrvU+DLJohIt3HYOzSyprIupsBQqIRr
 WiCcpBemrss0oLzsMH6hRKzJF8bs2Q+DKyFLlwq0v3XesGFnaIXto8nQw0ih3BuVGZhkLAt14
 fLW94eY3R+spOzUmo553I+3ejeKihvn2DdRFP209h4qQTif08//jaWmZ9p4ubGfrmk5zuQFfg
 fFWYR0MtcGKGHAGg331kXhkbQEX5qq+i2K+UDhOhtw0Um3Sf6WbE1ioobw+38bAqslAmwKFU5
 ov5nQfMVRB6xgb8Rb04Im5yhtTgJKAzrPpjHHL9ho40l79/uysfH1/aIPjWUrETFb/QrJvs40
 BCG4YNr6oed3qS+IFyiUAzr2k+HI0S1KLSCabB+qQ2PAXPBOOpOKd+8M4ku3NAJ518YSr61Aq
 FdcrIk6MeTRfeS2wHfTe7W/0yo5JDKebowS3zI+ttmzwIzHxzH4neHN/S836o2WOpleXQEi/b
 7YYTbDOeEpxM7Jp0ItVV57ZKXTTU62DXWcyenkYatpQcxRPa1D2iL8MgMDrPVSROK+YLCNqK0
 x6v9/OwUp8Mhgij9O/4uKu8PDKTix2gJYjQ1rhQzdhYNP8TaSgJRiK2I5fHhRG4NIa/xiwOVI
 cmFbK4XKciBRifni8RiwtOdY0DVMnm4czkzJ2hSlo39C8WDqfuewlnvi9pQ=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.187
Subject: [Qemu-devel] [PATCH v8 05/10] hw/m68k: implement ADB bus support
 for via
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
 Laurent Vivier <laurent@vivier.eu>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
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
index baa87c2879..4249632a57 100644
--- a/hw/misc/mac_via.c
+++ b/hw/misc/mac_via.c
@@ -238,10 +238,16 @@
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
@@ -423,6 +429,181 @@ static void via1_rtc_update(MacVIAState *m)
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
@@ -485,6 +666,10 @@ static void mac_via_reset(DeviceState *dev)
 {
     MacVIAState *m = MAC_VIA(dev);
 
+    timer_mod(m->adb_poll_timer,
+              qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
+              (NANOSECONDS_PER_SECOND / VIA_ADB_POLL_FREQ));
+
     timer_mod(m->VBL_timer, (qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + 16630)
               / 16630 * 16630);
 
@@ -523,6 +708,10 @@ static void mac_via_realize(DeviceState *dev, Error **errp)
 
     qemu_get_timedate(&tm, 0);
     m->tick_offset = (uint32_t)mktimegm(&tm) + RTC_OFFSET;
+
+    m->adb_poll_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, via_adb_poll, m);
+    m->adb_data_ready = qdev_get_gpio_in_named(dev, "via1-irq",
+                                               VIA1_IRQ_ADB_READY_BIT);
 }
 
 static void mac_via_init(Object *obj)
@@ -571,6 +760,7 @@ static void mos6522_q800_via1_portB_write(MOS6522State *s)
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


