Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04FC9C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 06:32:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C43BB206B7
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 06:32:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZASTzxI+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C43BB206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43132 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jncUA-0007mp-2t
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 02:32:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44028)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jncSx-00060e-JO; Tue, 23 Jun 2020 02:31:31 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:34979)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jncSv-0008I6-F4; Tue, 23 Jun 2020 02:31:31 -0400
Received: by mail-wm1-x343.google.com with SMTP id g21so1944257wmg.0;
 Mon, 22 Jun 2020 23:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=h+GNyklVeOXj/PefQvxfVmTVfMeIbcFaCXnj/MJvRkk=;
 b=ZASTzxI+ZpK4RqXRzdEjXg/e6PZUxfT/Mdkd6Didvpud9qfCFn7WTvLRrQWw3Cxq15
 Y6A4MfNLW3c9jNCtSYr3mQ6SYlYWPVA5a19w4+w2zFWJAwczVo7532ZQvnKvMUyTAOeX
 keWL9gnvmu6sApKli0c9u1ViGlb4NCorfMcAXx76yDBhvREsThPNbawJl22gLduiYobo
 nDi0rvOG7x+ZXL3Cj6Fd7k4GQALvPpTnGjDZSW4H3A6rOT/pkSP7U46j5Y9S3/okeAdy
 L1XVAJJXjQxQerfeQ5m0rfaaUv2gJGCaE1aF/viha35FKPD54X2cTNkqCq58gLAYzwHM
 g3dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=h+GNyklVeOXj/PefQvxfVmTVfMeIbcFaCXnj/MJvRkk=;
 b=HlVZ972KlNrf0y9EnyE+HhiXEP9t10662r26C6Xzcj82RzuPRbuJdiLSprZ+SSe57p
 0jhUDmsorcFhsYLXxAzPyD/iqyfnI7TCt9FLFf3my18zmW+han1C51uPExAC2ejD4AGt
 n3pfvZDMxJoQPlQQeIFDmcuuE9ppfGPIImHdAYBhmWVwz7+Bp+VGsO6Uv8AziF6nXUc7
 MRDQbsIIIcgnhW2o8/zf1s/jwQ+pyv174DndunJJ6LqLsP8EMT4nbDv0tKeQhwRg8X+T
 Y4H3doKT+0PULLQGBDMI1dXwGkDyNHAHcu0YoE89C/h3CeLi/QHFDvKC76JbEYstIklT
 lC3w==
X-Gm-Message-State: AOAM533lSt5QomtXBMD36ZfuzUsl2f+oEuJyP7g+ZIVEx402a8bjklTw
 o0St/x52K266n7UpHGnEFq3ZIwBI
X-Google-Smtp-Source: ABdhPJxydoSCGvJwNGyOOotDoKetRAJtXtqzQltYU4jpI+Imk7BFhB5hfEaVOxKutksiRQIKQDg6pQ==
X-Received: by 2002:a1c:32c4:: with SMTP id y187mr22673570wmy.79.1592893887234; 
 Mon, 22 Jun 2020 23:31:27 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id x205sm2407188wmx.21.2020.06.22.23.31.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2020 23:31:26 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org,
	BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v2 1/3] i2c: Match parameters of i2c_start_transfer and
 i2c_send_recv
Date: Tue, 23 Jun 2020 08:31:21 +0200
Message-Id: <20200623063123.20776-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200623063123.20776-1-f4bug@amsat.org>
References: <20200623063123.20776-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Corey Minyard <cminyard@mvista.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: BALATON Zoltan <balaton@eik.bme.hu>

These functions have a parameter that decides the direction of
transfer but totally confusingly they don't match but inverted sense.
To avoid frequent mistakes when using these functions change
i2c_send_recv to match i2c_start_transfer.

Rename i2c_send_recv() as i2c_recv_send() and rename the 'send'
argument as 'is_recv' (its boolean opposite). Invert the logic
in i2c_recv_send() to not use inverted boolean value check.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Message-Id: <20200621145235.9E241745712@zero.eik.bme.hu>
[PMD: Split patch, added docstring]
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/i2c/i2c.h | 11 ++++++++++-
 hw/display/sm501.c   |  4 ++--
 hw/i2c/core.c        | 32 ++++++++++++++++----------------
 hw/i2c/ppc4xx_i2c.c  |  2 +-
 hw/misc/auxbus.c     |  4 ++--
 5 files changed, 31 insertions(+), 22 deletions(-)

diff --git a/include/hw/i2c/i2c.h b/include/hw/i2c/i2c.h
index 4117211565..bc70c5b43d 100644
--- a/include/hw/i2c/i2c.h
+++ b/include/hw/i2c/i2c.h
@@ -75,7 +75,16 @@ int i2c_bus_busy(I2CBus *bus);
 int i2c_start_transfer(I2CBus *bus, uint8_t address, int recv);
 void i2c_end_transfer(I2CBus *bus);
 void i2c_nack(I2CBus *bus);
-int i2c_send_recv(I2CBus *bus, uint8_t *data, bool send);
+/**
+ * i2c_recv_send: receive from or send to an I2C bus.
+ *
+ * @bus: #I2CBus to be used
+ * @data: buffer with the data transferred
+ * @is_recv: indicates the transfer direction
+ *
+ * Returns: 0 on success, -1 on error
+ */
+int i2c_recv_send(I2CBus *bus, uint8_t *data, bool is_recv);
 int i2c_send(I2CBus *bus, uint8_t data);
 uint8_t i2c_recv(I2CBus *bus);
 
diff --git a/hw/display/sm501.c b/hw/display/sm501.c
index a7fc08c52b..56e35cf4ae 100644
--- a/hw/display/sm501.c
+++ b/hw/display/sm501.c
@@ -1040,8 +1040,8 @@ static void sm501_i2c_write(void *opaque, hwaddr addr, uint64_t value,
                     SM501_DPRINTF("sm501 i2c : transferring %d bytes to 0x%x\n",
                                   s->i2c_byte_count + 1, s->i2c_addr >> 1);
                     for (i = 0; i <= s->i2c_byte_count; i++) {
-                        res = i2c_send_recv(s->i2c_bus, &s->i2c_data[i],
-                                            !(s->i2c_addr & 1));
+                        res = i2c_recv_send(s->i2c_bus, &s->i2c_data[i],
+                                            s->i2c_addr & 1);
                         if (res) {
                             SM501_DPRINTF("sm501 i2c : transfer failed"
                                           " i=%d, res=%d\n", i, res);
diff --git a/hw/i2c/core.c b/hw/i2c/core.c
index 1aac457a2a..b83c2b5b89 100644
--- a/hw/i2c/core.c
+++ b/hw/i2c/core.c
@@ -175,26 +175,14 @@ void i2c_end_transfer(I2CBus *bus)
     bus->broadcast = false;
 }
 
-int i2c_send_recv(I2CBus *bus, uint8_t *data, bool send)
+int i2c_recv_send(I2CBus *bus, uint8_t *data, bool is_recv)
 {
     I2CSlaveClass *sc;
     I2CSlave *s;
     I2CNode *node;
     int ret = 0;
 
-    if (send) {
-        QLIST_FOREACH(node, &bus->current_devs, next) {
-            s = node->elt;
-            sc = I2C_SLAVE_GET_CLASS(s);
-            if (sc->send) {
-                trace_i2c_send(s->address, *data);
-                ret = ret || sc->send(s, *data);
-            } else {
-                ret = -1;
-            }
-        }
-        return ret ? -1 : 0;
-    } else {
+    if (is_recv) {
         ret = 0xff;
         if (!QLIST_EMPTY(&bus->current_devs) && !bus->broadcast) {
             sc = I2C_SLAVE_GET_CLASS(QLIST_FIRST(&bus->current_devs)->elt);
@@ -206,19 +194,31 @@ int i2c_send_recv(I2CBus *bus, uint8_t *data, bool send)
         }
         *data = ret;
         return 0;
+    } else {
+        QLIST_FOREACH(node, &bus->current_devs, next) {
+            s = node->elt;
+            sc = I2C_SLAVE_GET_CLASS(s);
+            if (sc->send) {
+                trace_i2c_send(s->address, *data);
+                ret = ret || sc->send(s, *data);
+            } else {
+                ret = -1;
+            }
+        }
+        return ret ? -1 : 0;
     }
 }
 
 int i2c_send(I2CBus *bus, uint8_t data)
 {
-    return i2c_send_recv(bus, &data, true);
+    return i2c_recv_send(bus, &data, false);
 }
 
 uint8_t i2c_recv(I2CBus *bus)
 {
     uint8_t data = 0xff;
 
-    i2c_send_recv(bus, &data, false);
+    i2c_recv_send(bus, &data, true);
     return data;
 }
 
diff --git a/hw/i2c/ppc4xx_i2c.c b/hw/i2c/ppc4xx_i2c.c
index c0a8e04567..f0b0de19b0 100644
--- a/hw/i2c/ppc4xx_i2c.c
+++ b/hw/i2c/ppc4xx_i2c.c
@@ -239,7 +239,7 @@ static void ppc4xx_i2c_writeb(void *opaque, hwaddr addr, uint64_t value,
                     }
                 }
                 if (!(i2c->sts & IIC_STS_ERR) &&
-                    i2c_send_recv(i2c->bus, &i2c->mdata[i], !recv)) {
+                    i2c_recv_send(i2c->bus, &i2c->mdata[i], recv)) {
                     i2c->sts |= IIC_STS_ERR;
                     i2c->extsts |= IIC_EXTSTS_XFRA;
                     break;
diff --git a/hw/misc/auxbus.c b/hw/misc/auxbus.c
index da361baa32..cef0d0d6d0 100644
--- a/hw/misc/auxbus.c
+++ b/hw/misc/auxbus.c
@@ -148,7 +148,7 @@ AUXReply aux_request(AUXBus *bus, AUXCommand cmd, uint32_t address,
 
         ret = AUX_I2C_ACK;
         while (len > 0) {
-            if (i2c_send_recv(i2c_bus, data++, is_write) < 0) {
+            if (i2c_recv_send(i2c_bus, data++, is_write) < 0) {
                 ret = AUX_I2C_NACK;
                 break;
             }
@@ -189,7 +189,7 @@ AUXReply aux_request(AUXBus *bus, AUXCommand cmd, uint32_t address,
         bus->last_transaction = cmd;
         bus->last_i2c_address = address;
         while (len > 0) {
-            if (i2c_send_recv(i2c_bus, data++, is_write) < 0) {
+            if (i2c_recv_send(i2c_bus, data++, is_write) < 0) {
                 i2c_end_transfer(i2c_bus);
                 break;
             }
-- 
2.21.3


