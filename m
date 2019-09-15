Return-Path: <SRS0=GetT=XK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52198C4CEC7
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Sep 2019 15:43:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E86220650
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Sep 2019 15:43:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E86220650
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55678 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9WgE-0007qS-VA
	for qemu-devel@archiver.kernel.org; Sun, 15 Sep 2019 11:43:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48191)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1i9Wbn-0003ZN-M9
 for qemu-devel@nongnu.org; Sun, 15 Sep 2019 11:38:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1i9Wbm-0003Pi-30
 for qemu-devel@nongnu.org; Sun, 15 Sep 2019 11:38:39 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:48403)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1i9Wbl-0003Oz-Qf; Sun, 15 Sep 2019 11:38:38 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1Mw8gc-1iQ60t1KQm-00s6BE; Sun, 15 Sep 2019 17:38:03 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Sun, 15 Sep 2019 17:37:44 +0200
Message-Id: <20190915153751.11333-3-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190915153751.11333-1-laurent@vivier.eu>
References: <20190915153751.11333-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Nbd0LFadjfY7/FhY7L6sJA/tLPwM6qdVv0t9w2RvDZSczzZ/fr4
 YDHoYxsOjwBBZ/jIuAKtoI6MFla4IHVXeHphT0qnGTgHI5aIv54TzjN0/S36nwbQJ47zqtH
 K5BFRPPXjUpZga7A6a25zQHvYzDeIYs+VtSURyVqbMAykkBXsw8xiI0BhQ60cp9f7U+8M2W
 ApzArtBzl/0M8C8C+ROsA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xf/DuPn3+DU=:UB+zCsjWdBRRy/4GEOUJIC
 W5WAhvQccawLDUgyPXawCcVgwrK4JyhvuIDTOWxiu8AKOZEPXToe8Z28nsOOncOHWdbN42Bqb
 EofwMJYHQKOxMJsLXlU9ZHnox/WkYsdh5AmXCYhqAyLGhd/VfAclOj3uYcBmM0cQvKjTa0h3y
 1e4r9qr0+Yl8eX9iputoyLaMe9Nhr1/9qs6cJLSkGEj2uVSHdpeRCDVVieTsIVS5Qn6g1TaJd
 QsAQgGQmII+hzSBxgjdKfJV/b+y58c/i6aQ8izsrdj6ve0xpD1VzKnhKbqgpvhTkn1lOeJaa0
 EMvK410Ab32wvJsvw64oft7TzozGkgbTpE+JR/BSaGNEOIBKY/L7/n0gkRjlwNQviDIZ/F9D6
 JZzrGVz7ALVW9kF5SOclFyDgfZ/cmautgrnBHSTg0slgGEAH9y4HRt/EPpXbLZMbn7i/rfN8o
 qO/5UNRuHKTszEQyJgxkAFZt9WBpZt7Q4Ev1sCx//QTNn4MI594axL+UwzUX7wcmpozOwfvJ1
 wZLIBI/y2cFXJmwodco1NiVCR+tJjqyBuMf3UDcExaAbeTtwdHMT6+RktVGzycdzRNHuUFaCB
 X3WqkyQgRy6iJnVhs71xnAplgdNCmis7jhG6WJwwbNRzKG38qpEI1dCVysp3HGu5uL7ZSz+c3
 l1Z2zFztAcOF6osCrCb+FB7lK0uCQ6xgm0JORA4mZ8kZoswtV1fjPTlDLR349ecgtSnxB5gwT
 Ku+UQ/d7MucubUGrrE++SVpFcrZwNarxiqmnmmUW9iSYROCEv3U4QwLPNW76exWc3GLNix4ny
 F2kTi8b05xn2UWw3gemozC8e+86o2s/hK1HyaUlqRRstxUT+BeAkhAVFbVOW/OwiM+UVqKFl4
 yxofkFoOaLqgwLtldywNrEruT5pXVIeE4QCCIrY+Y=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.24
Subject: [Qemu-devel] [PATCH v12 2/9] dp8393x: manage big endian bus
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-block@nongnu.org, Thomas Huth <huth@tuxfamily.org>,
 Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <laurent@vivier.eu>, Max Reitz <mreitz@redhat.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is needed by Quadra 800, this card can run on little-endian
or big-endian bus.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Tested-by: Hervé Poussineau <hpoussin@reactos.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Hervé Poussineau <hpoussin@reactos.org>
---
 hw/net/dp8393x.c | 88 +++++++++++++++++++++++++++++++-----------------
 1 file changed, 57 insertions(+), 31 deletions(-)

diff --git a/hw/net/dp8393x.c b/hw/net/dp8393x.c
index a5678e11fa..693e244ce6 100644
--- a/hw/net/dp8393x.c
+++ b/hw/net/dp8393x.c
@@ -153,6 +153,7 @@ typedef struct dp8393xState {
 
     /* Hardware */
     uint8_t it_shift;
+    bool big_endian;
     qemu_irq irq;
 #ifdef DEBUG_SONIC
     int irq_level;
@@ -223,6 +224,29 @@ static uint32_t dp8393x_wt(dp8393xState *s)
     return s->regs[SONIC_WT1] << 16 | s->regs[SONIC_WT0];
 }
 
+static uint16_t dp8393x_get(dp8393xState *s, int width, uint16_t *base,
+                            int offset)
+{
+    uint16_t val;
+
+    if (s->big_endian) {
+        val = be16_to_cpu(base[offset * width + width - 1]);
+    } else {
+        val = le16_to_cpu(base[offset * width]);
+    }
+    return val;
+}
+
+static void dp8393x_put(dp8393xState *s, int width, uint16_t *base, int offset,
+                        uint16_t val)
+{
+    if (s->big_endian) {
+        base[offset * width + width - 1] = cpu_to_be16(val);
+    } else {
+        base[offset * width] = cpu_to_le16(val);
+    }
+}
+
 static void dp8393x_update_irq(dp8393xState *s)
 {
     int level = (s->regs[SONIC_IMR] & s->regs[SONIC_ISR]) ? 1 : 0;
@@ -254,12 +278,12 @@ static void dp8393x_do_load_cam(dp8393xState *s)
         /* Fill current entry */
         address_space_rw(&s->as, dp8393x_cdp(s),
             MEMTXATTRS_UNSPECIFIED, (uint8_t *)data, size, 0);
-        s->cam[index][0] = data[1 * width] & 0xff;
-        s->cam[index][1] = data[1 * width] >> 8;
-        s->cam[index][2] = data[2 * width] & 0xff;
-        s->cam[index][3] = data[2 * width] >> 8;
-        s->cam[index][4] = data[3 * width] & 0xff;
-        s->cam[index][5] = data[3 * width] >> 8;
+        s->cam[index][0] = dp8393x_get(s, width, data, 1) & 0xff;
+        s->cam[index][1] = dp8393x_get(s, width, data, 1) >> 8;
+        s->cam[index][2] = dp8393x_get(s, width, data, 2) & 0xff;
+        s->cam[index][3] = dp8393x_get(s, width, data, 2) >> 8;
+        s->cam[index][4] = dp8393x_get(s, width, data, 3) & 0xff;
+        s->cam[index][5] = dp8393x_get(s, width, data, 3) >> 8;
         DPRINTF("load cam[%d] with %02x%02x%02x%02x%02x%02x\n", index,
             s->cam[index][0], s->cam[index][1], s->cam[index][2],
             s->cam[index][3], s->cam[index][4], s->cam[index][5]);
@@ -272,7 +296,7 @@ static void dp8393x_do_load_cam(dp8393xState *s)
     /* Read CAM enable */
     address_space_rw(&s->as, dp8393x_cdp(s),
         MEMTXATTRS_UNSPECIFIED, (uint8_t *)data, size, 0);
-    s->regs[SONIC_CE] = data[0 * width];
+    s->regs[SONIC_CE] = dp8393x_get(s, width, data, 0);
     DPRINTF("load cam done. cam enable mask 0x%04x\n", s->regs[SONIC_CE]);
 
     /* Done */
@@ -293,10 +317,10 @@ static void dp8393x_do_read_rra(dp8393xState *s)
         MEMTXATTRS_UNSPECIFIED, (uint8_t *)data, size, 0);
 
     /* Update SONIC registers */
-    s->regs[SONIC_CRBA0] = data[0 * width];
-    s->regs[SONIC_CRBA1] = data[1 * width];
-    s->regs[SONIC_RBWC0] = data[2 * width];
-    s->regs[SONIC_RBWC1] = data[3 * width];
+    s->regs[SONIC_CRBA0] = dp8393x_get(s, width, data, 0);
+    s->regs[SONIC_CRBA1] = dp8393x_get(s, width, data, 1);
+    s->regs[SONIC_RBWC0] = dp8393x_get(s, width, data, 2);
+    s->regs[SONIC_RBWC1] = dp8393x_get(s, width, data, 3);
     DPRINTF("CRBA0/1: 0x%04x/0x%04x, RBWC0/1: 0x%04x/0x%04x\n",
         s->regs[SONIC_CRBA0], s->regs[SONIC_CRBA1],
         s->regs[SONIC_RBWC0], s->regs[SONIC_RBWC1]);
@@ -411,12 +435,12 @@ static void dp8393x_do_transmit_packets(dp8393xState *s)
         tx_len = 0;
 
         /* Update registers */
-        s->regs[SONIC_TCR] = data[0 * width] & 0xf000;
-        s->regs[SONIC_TPS] = data[1 * width];
-        s->regs[SONIC_TFC] = data[2 * width];
-        s->regs[SONIC_TSA0] = data[3 * width];
-        s->regs[SONIC_TSA1] = data[4 * width];
-        s->regs[SONIC_TFS] = data[5 * width];
+        s->regs[SONIC_TCR] = dp8393x_get(s, width, data, 0) & 0xf000;
+        s->regs[SONIC_TPS] = dp8393x_get(s, width, data, 1);
+        s->regs[SONIC_TFC] = dp8393x_get(s, width, data, 2);
+        s->regs[SONIC_TSA0] = dp8393x_get(s, width, data, 3);
+        s->regs[SONIC_TSA1] = dp8393x_get(s, width, data, 4);
+        s->regs[SONIC_TFS] = dp8393x_get(s, width, data, 5);
 
         /* Handle programmable interrupt */
         if (s->regs[SONIC_TCR] & SONIC_TCR_PINT) {
@@ -442,9 +466,9 @@ static void dp8393x_do_transmit_packets(dp8393xState *s)
                 address_space_rw(&s->as,
                     dp8393x_ttda(s) + sizeof(uint16_t) * (4 + 3 * i) * width,
                     MEMTXATTRS_UNSPECIFIED, (uint8_t *)data, size, 0);
-                s->regs[SONIC_TSA0] = data[0 * width];
-                s->regs[SONIC_TSA1] = data[1 * width];
-                s->regs[SONIC_TFS] = data[2 * width];
+                s->regs[SONIC_TSA0] = dp8393x_get(s, width, data, 0);
+                s->regs[SONIC_TSA1] = dp8393x_get(s, width, data, 1);
+                s->regs[SONIC_TFS] = dp8393x_get(s, width, data, 2);
             }
         }
 
@@ -471,7 +495,8 @@ static void dp8393x_do_transmit_packets(dp8393xState *s)
         s->regs[SONIC_TCR] |= SONIC_TCR_PTX;
 
         /* Write status */
-        data[0 * width] = s->regs[SONIC_TCR] & 0x0fff; /* status */
+        dp8393x_put(s, width, data, 0,
+                    s->regs[SONIC_TCR] & 0x0fff); /* status */
         size = sizeof(uint16_t) * width;
         address_space_rw(&s->as,
             dp8393x_ttda(s),
@@ -485,8 +510,8 @@ static void dp8393x_do_transmit_packets(dp8393xState *s)
                              sizeof(uint16_t) *
                              (4 + 3 * s->regs[SONIC_TFC]) * width,
                 MEMTXATTRS_UNSPECIFIED, (uint8_t *)data, size, 0);
-            s->regs[SONIC_CTDA] = data[0 * width] & ~0x1;
-            if (data[0 * width] & 0x1) {
+            s->regs[SONIC_CTDA] = dp8393x_get(s, width, data, 0) & ~0x1;
+            if (dp8393x_get(s, width, data, 0) & 0x1) {
                 /* EOL detected */
                 break;
             }
@@ -749,7 +774,7 @@ static ssize_t dp8393x_receive(NetClientState *nc, const uint8_t * buf,
         address = dp8393x_crda(s) + sizeof(uint16_t) * 5 * width;
         address_space_rw(&s->as, address, MEMTXATTRS_UNSPECIFIED,
                          (uint8_t *)data, size, 0);
-        if (data[0 * width] & 0x1) {
+        if (dp8393x_get(s, width, data, 0) & 0x1) {
             /* Still EOL ; stop reception */
             return -1;
         } else {
@@ -793,11 +818,11 @@ static ssize_t dp8393x_receive(NetClientState *nc, const uint8_t * buf,
 
     /* Write status to memory */
     DPRINTF("Write status at %08x\n", dp8393x_crda(s));
-    data[0 * width] = s->regs[SONIC_RCR]; /* status */
-    data[1 * width] = rx_len; /* byte count */
-    data[2 * width] = s->regs[SONIC_TRBA0]; /* pkt_ptr0 */
-    data[3 * width] = s->regs[SONIC_TRBA1]; /* pkt_ptr1 */
-    data[4 * width] = s->regs[SONIC_RSC]; /* seq_no */
+    dp8393x_put(s, width, data, 0, s->regs[SONIC_RCR]); /* status */
+    dp8393x_put(s, width, data, 1, rx_len); /* byte count */
+    dp8393x_put(s, width, data, 2, s->regs[SONIC_TRBA0]); /* pkt_ptr0 */
+    dp8393x_put(s, width, data, 3, s->regs[SONIC_TRBA1]); /* pkt_ptr1 */
+    dp8393x_put(s, width, data, 4, s->regs[SONIC_RSC]); /* seq_no */
     size = sizeof(uint16_t) * 5 * width;
     address_space_rw(&s->as, dp8393x_crda(s),
         MEMTXATTRS_UNSPECIFIED, (uint8_t *)data, size, 1);
@@ -806,12 +831,12 @@ static ssize_t dp8393x_receive(NetClientState *nc, const uint8_t * buf,
     size = sizeof(uint16_t) * width;
     address_space_rw(&s->as, dp8393x_crda(s) + sizeof(uint16_t) * 5 * width,
         MEMTXATTRS_UNSPECIFIED, (uint8_t *)data, size, 0);
-    s->regs[SONIC_LLFA] = data[0 * width];
+    s->regs[SONIC_LLFA] = dp8393x_get(s, width, data, 0);
     if (s->regs[SONIC_LLFA] & 0x1) {
         /* EOL detected */
         s->regs[SONIC_ISR] |= SONIC_ISR_RDE;
     } else {
-        data[0 * width] = 0; /* in_use */
+        dp8393x_put(s, width, data, 0, 0); /* in_use */
         address_space_rw(&s->as, dp8393x_crda(s) + sizeof(uint16_t) * 6 * width,
             MEMTXATTRS_UNSPECIFIED, (uint8_t *)data, sizeof(uint16_t), 1);
         s->regs[SONIC_CRDA] = s->regs[SONIC_LLFA];
@@ -924,6 +949,7 @@ static Property dp8393x_properties[] = {
     DEFINE_NIC_PROPERTIES(dp8393xState, conf),
     DEFINE_PROP_PTR("dma_mr", dp8393xState, dma_mr),
     DEFINE_PROP_UINT8("it_shift", dp8393xState, it_shift, 0),
+    DEFINE_PROP_BOOL("big_endian", dp8393xState, big_endian, false),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
2.21.0


