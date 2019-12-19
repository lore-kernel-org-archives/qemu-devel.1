Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FA5BC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 20:16:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55AD82465E
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 20:16:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55AD82465E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47450 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ii2DS-0002Sh-EW
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 15:16:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39451)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1ii2C9-0001Gy-Nw
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 15:14:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1ii2C6-0004MZ-TM
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 15:14:49 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:35885)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1ii2C6-0004If-C0
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 15:14:46 -0500
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MmU9R-1hzf161mSX-00iVeZ; Thu, 19 Dec 2019 21:14:41 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/2] q800: fix mac_via RTC PRAM commands
Date: Thu, 19 Dec 2019 21:14:38 +0100
Message-Id: <20191219201439.84804-2-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191219201439.84804-1-laurent@vivier.eu>
References: <20191219201439.84804-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:CzwElIE6Vqc63meeZjmdjRHTcaNrrMXefHPYOL/W/owrJASuqAK
 Tti3Ea4nQELCfUtQlg/vlIRaAiPIzk4MCcWmGJamrIurdZXKZ7Z8cLJ3AFkxbQ1xzfwCZEI
 bbJOy4e5/pbmHxgs0njFiG/1/mCEBFV0utJTVfg+62GMGwLgvLWk4mqhTN9sQKJIUOhRYCu
 EHInmd5aYqz9JCGmJsQeQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:aEQZnneeaW0=:d/CP33KkZEieyTFQFIo9Xy
 Z97M43ChjG8nWRAGN1wrJbOhB/0UdspQrTACFtnNKaBr7zh0dlPe2xh7icGS/vpYN9spyq9nb
 IafSPr3AtVQvJ8Wzf5x2jnlWR2nMNNoHymVf0+poT7LwUgDTr3TlOgNAkRY7DisedUU/J8cHb
 Cib7yVMNKqd6O19hPgdrlYWSTuh+XkAla1RwoDHTy5SBoq6fERWoi1BrlGDq47j/cdHGiQgUq
 L7PgddTOzR0HcJJG0DnOjRicSmRheQZQTQyrhzJlcaTYkvrBqPar6ysPOun1ZfLndXtX3z7sH
 Bhq0atT5bRQZL9syHLnT5YVCYh1vVpTy5RVQK9I32jvMwC2KkrppO4/UJbwyQfPtCPmK5089h
 EQbdIhjAnyYz9hrLJq/+gMN2Y0fXMKuGZb8XD7lHIR0keJeZMUKQN2xk0b5+IFPwOC5X2W4Jt
 X1Zx2j4yBgDSdMoY1TmSPsSRUJcB/jzbW7MckfDJpHEeR4bldpm4QHoASi5ZrgmL/QY7ZMQci
 YPdiILvOTgLgO6RNG9Fo2G3uUL5Jt96cmXgOruc39WRSAe6KzVUizWf1Ao0w0bjC1ln6bffus
 4SvSc1OaMWITKMqleW5dTYAU78A/YlclhY3l6b/j5BA87dr0im2xqYx6SqreDg4tYf1EDFp4/
 PZ0VG7e69Bjeuhhp2xlXFATq4zxt8YagNuv3bTvwoIYUJtcDC1WH4X1gIHGofoZUGuG3xKAOx
 O+FaUzkXP9mvouIE2YRYcKJy3Olx7qaJiLSnn5086PpPS+us436kEB/glapR8O1Oq3QSt+TsJ
 SJelJsUyEZodkVPQYgpyObX7cuKI/uLmcGy47b64jhsIxBHWm9oc0AjNYhSFoYGfEOUdluTPF
 jn8OvsQ2wxVHu7nE8Ycg==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.126.134
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The command byte is not decoded correctly.

This patch reworks the RTC/PRAM interface and fixes the problem.
It adds a comment before the function to explain how are encoded commands
and some trace-events to ease debugging.

Bug: https://bugs.launchpad.net/qemu/+bug/1856549
Fixes: 6dca62a000 ("hw/m68k: add VIA support")
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/misc/mac_via.c    | 274 ++++++++++++++++++++++++++++++-------------
 hw/misc/trace-events |  19 +++
 2 files changed, 210 insertions(+), 83 deletions(-)

diff --git a/hw/misc/mac_via.c b/hw/misc/mac_via.c
index f3f130ad96..e5658af922 100644
--- a/hw/misc/mac_via.c
+++ b/hw/misc/mac_via.c
@@ -27,7 +27,7 @@
 #include "sysemu/runstate.h"
 #include "qapi/error.h"
 #include "qemu/cutils.h"
-
+#include "trace.h"
 
 /*
  * VIAs: There are two in every machine,
@@ -278,6 +278,21 @@
 /* VIA returns time offset from Jan 1, 1904, not 1970 */
 #define RTC_OFFSET 2082844800
 
+enum {
+    REG_0,
+    REG_1,
+    REG_2,
+    REG_3,
+    REG_TEST,
+    REG_WPROTECT,
+    REG_PRAM_ADDR,
+    REG_PRAM_ADDR_LAST = REG_PRAM_ADDR + 19,
+    REG_PRAM_SECT,
+    REG_PRAM_SECT_LAST = REG_PRAM_SECT + 7,
+    REG_INVALID,
+    REG_EMPTY = 0xff,
+};
+
 static void via1_VBL_update(MOS6522Q800VIA1State *v1s)
 {
     MOS6522State *s = MOS6522(v1s);
@@ -360,10 +375,62 @@ static void via2_irq_request(void *opaque, int irq, int level)
     mdc->update_irq(s);
 }
 
+/*
+ * RTC Commands
+ *
+ * Command byte    Register addressed by the command
+ *
+ * z0000001        Seconds register 0 (lowest-order byte)
+ * z0000101        Seconds register 1
+ * z0001001        Seconds register 2
+ * z0001101        Seconds register 3 (highest-order byte)
+ * 00110001        Test register (write-only)
+ * 00110101        Write-Protect Register (write-only)
+ * z010aa01        RAM address 100aa ($10-$13) (first 20 bytes only)
+ * z1aaaa01        RAM address 0aaaa ($00-$0F) (first 20 bytes only)
+ * z0111aaa        Extended memory designator and sector number
+ *
+ * For a read request, z=1, for a write z=0
+ * The letter a indicates bits whose value depend on what parameter
+ * RAM byte you want to address
+ */
+static int via1_rtc_compact_cmd(uint8_t value)
+{
+    uint8_t read = value & 0x80;
+
+    value &= 0x7f;
+
+    /* the last 2 bits of a command byte must always be 0b01 ... */
+    if ((value & 0x78) == 0x38) {
+        /* except for the extended memory designator */
+        return read | (REG_PRAM_SECT + (value & 0x07));
+    }
+    if ((value & 0x03) == 0x01) {
+        value >>= 2;
+        if ((value & 0x1c) == 0) {
+            /* seconds registers */
+            return read | (REG_0 + (value & 0x03));
+        } else if ((value == 0x0c) && !read) {
+            return REG_TEST;
+        } else if ((value == 0x0d) && !read) {
+            return REG_WPROTECT;
+        } else if ((value & 0x1c) == 0x08) {
+            /* RAM address 0x10 to 0x13 */
+            return read | (REG_PRAM_ADDR + 0x10 + (value & 0x03));
+        } else if ((value & 0x43) == 0x41) {
+            /* RAM address 0x00 to 0x0f */
+            return read | (REG_PRAM_ADDR + (value & 0x0f));
+        }
+    }
+    return REG_INVALID;
+}
+
 static void via1_rtc_update(MacVIAState *m)
 {
     MOS6522Q800VIA1State *v1s = &m->mos6522_via1;
     MOS6522State *s = MOS6522(v1s);
+    int cmd, sector, addr;
+    uint32_t time;
 
     if (s->b & VIA1B_vRTCEnb) {
         return;
@@ -376,7 +443,9 @@ static void via1_rtc_update(MacVIAState *m)
             m->data_out |= s->b & VIA1B_vRTCData;
             m->data_out_cnt++;
         }
+        trace_via1_rtc_update_data_out(m->data_out_cnt, m->data_out);
     } else {
+        trace_via1_rtc_update_data_in(m->data_in_cnt, m->data_in);
         /* receive bits from the RTC */
         if ((v1s->last_b & VIA1B_vRTCClk) &&
             !(s->b & VIA1B_vRTCClk) &&
@@ -386,96 +455,132 @@ static void via1_rtc_update(MacVIAState *m)
             m->data_in <<= 1;
             m->data_in_cnt--;
         }
+        return;
     }
 
-    if (m->data_out_cnt == 8) {
-        m->data_out_cnt = 0;
-
-        if (m->cmd == 0) {
-            if (m->data_out & 0x80) {
-                /* this is a read command */
-                uint32_t time = m->tick_offset +
-                               (qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) /
-                               NANOSECONDS_PER_SECOND);
-                if (m->data_out == 0x81) {        /* seconds register 0 */
-                    m->data_in = time & 0xff;
-                    m->data_in_cnt = 8;
-                } else if (m->data_out == 0x85) { /* seconds register 1 */
-                    m->data_in = (time >> 8) & 0xff;
-                    m->data_in_cnt = 8;
-                } else if (m->data_out == 0x89) { /* seconds register 2 */
-                    m->data_in = (time >> 16) & 0xff;
-                    m->data_in_cnt = 8;
-                } else if (m->data_out == 0x8d) { /* seconds register 3 */
-                    m->data_in = (time >> 24) & 0xff;
-                    m->data_in_cnt = 8;
-                } else if ((m->data_out & 0xf3) == 0xa1) {
-                    /* PRAM address 0x10 -> 0x13 */
-                    int addr = (m->data_out >> 2) & 0x03;
-                    m->data_in = v1s->PRAM[addr];
-                    m->data_in_cnt = 8;
-                } else if ((m->data_out & 0xf3) == 0xa1) {
-                    /* PRAM address 0x00 -> 0x0f */
-                    int addr = (m->data_out >> 2) & 0x0f;
-                    m->data_in = v1s->PRAM[addr];
-                    m->data_in_cnt = 8;
-                } else if ((m->data_out & 0xf8) == 0xb8) {
-                    /* extended memory designator and sector number */
-                    m->cmd = m->data_out;
-                }
-            } else {
-                /* this is a write command */
-                m->cmd = m->data_out;
+    if (m->data_out_cnt != 8) {
+        return;
+    }
+
+    m->data_out_cnt = 0;
+
+    trace_via1_rtc_internal_status(m->cmd, m->alt, m->data_out);
+    /* first byte: it's a command */
+    if (m->cmd == REG_EMPTY) {
+
+        cmd = via1_rtc_compact_cmd(m->data_out);
+        trace_via1_rtc_internal_cmd(cmd);
+
+        if (cmd == REG_INVALID) {
+            trace_via1_rtc_cmd_invalid(m->data_out);
+            return;
+        }
+
+        if (cmd & 0x80) { /* this is a read command */
+            switch (cmd & 0x7f) {
+            case REG_0...REG_3: /* seconds registers */
+                /*
+                 * register 0 is lowest-order byte
+                 * register 3 is highest-order byte
+                 */
+
+                time = m->tick_offset + (qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL)
+                       / NANOSECONDS_PER_SECOND);
+                trace_via1_rtc_internal_time(time);
+                m->data_in = (time >> ((cmd & 0x03) << 3)) & 0xff;
+                m->data_in_cnt = 8;
+                trace_via1_rtc_cmd_seconds_read((cmd & 0x7f) - REG_0,
+                                                m->data_in);
+                break;
+            case REG_PRAM_ADDR...REG_PRAM_ADDR_LAST:
+                /* PRAM address 0x00 -> 0x13 */
+                m->data_in = v1s->PRAM[(cmd & 0x7f) - REG_PRAM_ADDR];
+                m->data_in_cnt = 8;
+                trace_via1_rtc_cmd_pram_read((cmd & 0x7f) - REG_PRAM_ADDR,
+                                             m->data_in);
+                break;
+            case REG_PRAM_SECT...REG_PRAM_SECT_LAST:
+                /*
+                 * extended memory designator and sector number
+                 * the only two-byte read command
+                 */
+                trace_via1_rtc_internal_set_cmd(cmd);
+                m->cmd = cmd;
+                break;
+            default:
+                g_assert_not_reached();
+                break;
             }
+            return;
+        }
+
+        /* this is a write command, needs a parameter */
+        if (cmd == REG_WPROTECT || !m->wprotect) {
+            trace_via1_rtc_internal_set_cmd(cmd);
+            m->cmd = cmd;
         } else {
+            trace_via1_rtc_internal_ignore_cmd(cmd);
+        }
+        return;
+    }
+
+    /* second byte: it's a parameter */
+    if (m->alt == REG_EMPTY) {
+        switch (m->cmd & 0x7f) {
+        case REG_0...REG_3: /* seconds register */
+            /* FIXME */
+            trace_via1_rtc_cmd_seconds_write(m->cmd - REG_0, m->data_out);
+            m->cmd = REG_EMPTY;
+            break;
+        case REG_TEST:
+            /* device control: nothing to do */
+            trace_via1_rtc_cmd_test_write(m->data_out);
+            m->cmd = REG_EMPTY;
+            break;
+        case REG_WPROTECT:
+            /* Write Protect register */
+            trace_via1_rtc_cmd_wprotect_write(m->data_out);
+            m->wprotect = !!(m->data_out & 0x80);
+            m->cmd = REG_EMPTY;
+            break;
+        case REG_PRAM_ADDR...REG_PRAM_ADDR_LAST:
+            /* PRAM address 0x00 -> 0x13 */
+            trace_via1_rtc_cmd_pram_write(m->cmd - REG_PRAM_ADDR, m->data_out);
+            v1s->PRAM[m->cmd - REG_PRAM_ADDR] = m->data_out;
+            m->cmd = REG_EMPTY;
+            break;
+        case REG_PRAM_SECT...REG_PRAM_SECT_LAST:
+            addr = (m->data_out >> 2) & 0x1f;
+            sector = (m->cmd & 0x7f) - REG_PRAM_SECT;
             if (m->cmd & 0x80) {
-                if ((m->cmd & 0xf8) == 0xb8) {
-                    /* extended memory designator and sector number */
-                    int sector = m->cmd & 0x07;
-                    int addr = (m->data_out >> 2) & 0x1f;
-
-                    m->data_in = v1s->PRAM[sector * 8 + addr];
-                    m->data_in_cnt = 8;
-                }
-            } else if (!m->wprotect) {
-                /* this is a write command */
-                if (m->alt != 0) {
-                    /* extended memory designator and sector number */
-                    int sector = m->cmd & 0x07;
-                    int addr = (m->alt >> 2) & 0x1f;
-
-                    v1s->PRAM[sector * 8 + addr] = m->data_out;
-
-                    m->alt = 0;
-                } else if (m->cmd == 0x01) { /* seconds register 0 */
-                    /* FIXME */
-                } else if (m->cmd == 0x05) { /* seconds register 1 */
-                    /* FIXME */
-                } else if (m->cmd == 0x09) { /* seconds register 2 */
-                    /* FIXME */
-                } else if (m->cmd == 0x0d) { /* seconds register 3 */
-                    /* FIXME */
-                } else if (m->cmd == 0x31) {
-                    /* Test Register */
-                } else if (m->cmd == 0x35) {
-                    /* Write Protect register */
-                    m->wprotect = m->data_out & 1;
-                } else if ((m->cmd & 0xf3) == 0xa1) {
-                    /* PRAM address 0x10 -> 0x13 */
-                    int addr = (m->cmd >> 2) & 0x03;
-                    v1s->PRAM[addr] = m->data_out;
-                } else if ((m->cmd & 0xf3) == 0xa1) {
-                    /* PRAM address 0x00 -> 0x0f */
-                    int addr = (m->cmd >> 2) & 0x0f;
-                    v1s->PRAM[addr] = m->data_out;
-                } else if ((m->cmd & 0xf8) == 0xb8) {
-                    /* extended memory designator and sector number */
-                    m->alt = m->cmd;
-                }
+                /* it's a read */
+                m->data_in = v1s->PRAM[sector * 32 + addr];
+                m->data_in_cnt = 8;
+                trace_via1_rtc_cmd_pram_sect_read(sector, addr,
+                                                  sector * 32 + addr,
+                                                  m->data_in);
+                m->cmd = REG_EMPTY;
+            } else {
+                /* it's a write, we need one more parameter */
+                trace_via1_rtc_internal_set_alt(addr, sector, addr);
+                m->alt = addr;
             }
+            break;
+        default:
+            g_assert_not_reached();
+            break;
         }
-        m->data_out = 0;
+        return;
     }
+
+    /* third byte: it's the data of a REG_PRAM_SECT write */
+    g_assert(REG_PRAM_SECT <= m->cmd && m->cmd <= REG_PRAM_SECT_LAST);
+    sector = m->cmd - REG_PRAM_SECT;
+    v1s->PRAM[sector * 32 + m->alt] = m->data_out;
+    trace_via1_rtc_cmd_pram_sect_write(sector, m->alt, sector * 32 + m->alt,
+                                       m->data_out);
+    m->alt = REG_EMPTY;
+    m->cmd = REG_EMPTY;
 }
 
 static int adb_via_poll(MacVIAState *s, int state, uint8_t *data)
@@ -742,6 +847,9 @@ static void mac_via_reset(DeviceState *dev)
     v1s->next_VBL = 0;
     timer_del(v1s->one_second_timer);
     v1s->next_second = 0;
+
+    m->cmd = REG_EMPTY;
+    m->alt = REG_EMPTY;
 }
 
 static void mac_via_realize(DeviceState *dev, Error **errp)
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index 1deb1d08c1..2e0c820834 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -149,3 +149,22 @@ bcm2835_mbox_write(unsigned int size, uint64_t addr, uint64_t value) "mbox write
 bcm2835_mbox_read(unsigned int size, uint64_t addr, uint64_t value) "mbox read sz:%u addr:0x%"PRIx64" data:0x%"PRIx64
 bcm2835_mbox_irq(unsigned level) "mbox irq:ARM level:%u"
 bcm2835_mbox_property(uint32_t tag, uint32_t bufsize, size_t resplen) "mbox property tag:0x%08x in_sz:%u out_sz:%zu"
+
+# mac_via.c
+via1_rtc_update_data_out(int count, int value) "count=%d value=0x%02x"
+via1_rtc_update_data_in(int count, int value) "count=%d value=0x%02x"
+via1_rtc_internal_status(int cmd, int alt, int value) "cmd=0x%02x alt=0x%02x value=0x%02x"
+via1_rtc_internal_cmd(int cmd) "cmd=0x%02x"
+via1_rtc_cmd_invalid(int value) "value=0x%02x"
+via1_rtc_internal_time(uint32_t time) "time=0x%08x"
+via1_rtc_internal_set_cmd(int cmd) "cmd=0x%02x"
+via1_rtc_internal_ignore_cmd(int cmd) "cmd=0x%02x"
+via1_rtc_internal_set_alt(int alt, int sector, int offset) "alt=0x%02x sector=%u offset=%u"
+via1_rtc_cmd_seconds_read(int reg, int value) "reg=%d value=0x%02x"
+via1_rtc_cmd_seconds_write(int reg, int value) "reg=%d value=0x%02x"
+via1_rtc_cmd_test_write(int value) "value=0x%02x"
+via1_rtc_cmd_wprotect_write(int value) "value=0x%02x"
+via1_rtc_cmd_pram_read(int addr, int value) "addr=%u value=0x%02x"
+via1_rtc_cmd_pram_write(int addr, int value) "addr=%u value=0x%02x"
+via1_rtc_cmd_pram_sect_read(int sector, int offset, int addr, int value) "sector=%u offset=%u addr=%d value=0x%02x"
+via1_rtc_cmd_pram_sect_write(int sector, int offset, int addr, int value) "sector=%u offset=%u addr=%d value=0x%02x"
-- 
2.24.1


