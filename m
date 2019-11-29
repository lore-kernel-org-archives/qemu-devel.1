Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EB0EC432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 13:37:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A5F3216F4
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 13:37:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qXE5evr1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A5F3216F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59168 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iagSk-00025y-Fw
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 08:37:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44871)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bilalwasim676@gmail.com>) id 1iac0y-0005np-RK
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 03:52:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bilalwasim676@gmail.com>) id 1iac0u-0000jz-Fb
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 03:52:33 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:34101)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bilalwasim676@gmail.com>)
 id 1iac0u-0000Qs-7R; Fri, 29 Nov 2019 03:52:32 -0500
Received: by mail-wr1-x442.google.com with SMTP id t2so34045329wrr.1;
 Fri, 29 Nov 2019 00:52:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=+H5beYs7R9VzKoKtKDCo0/PtILiDZOqNPj6UEVTqWI8=;
 b=qXE5evr1plLKDoAiwd+QFIqDiPhVreKVkrMKLbRivLYKG4HxvcjfU7lOCzlNzguNT5
 TZ0+lWOHLpJFsFnu/ABwvFBi1WDAvPXOHlIBZjnyCX6sq+ChKlGYJ3iOpmv46rJmL2Ak
 oFm+oZoI6X9zWSfg+zj1KGQ0A1wNbddIeA2PgSPYdGU1xIaEO8IEKc6ClyN0r6Wkqa8B
 EL6OJfng+mvqqDbCTuYTpiq+vEvJMidIjhI0X0yaKPosriD9cxx2JjncWRhg2XKn8VvZ
 Ya3+9/XVBmZaPDvrJwKXFyqzNHH0M6t4d17sizeyj3vdsiUQQTmMuRcJhJdqei9n8BMg
 E1WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=+H5beYs7R9VzKoKtKDCo0/PtILiDZOqNPj6UEVTqWI8=;
 b=G9tn4B75GBiK1Ph6/TzB3hFFckYlSPyQRPxcYfrQXH363AAn+KCEXDyEQMLe37kFKJ
 H7hA9SSnsXqNIwenHbJW8lFk/S7V+gDFYrYCrOXwHbVWRID5dWAAwXy/eWQuxd7BHwUp
 BFsALKSkDNGxd/BXiOoKRkEz4/TifM3/L/kD/etqsiGUoOOqLN2t5Sq2NcTBdtgeVWY1
 RtOsSKmKECg2gMa8LJAYrSj+uvR6QVJajcSVep9N1vhEV2kRfEDaeW6TXvAsPtx6bov3
 41Gt/SbS95ZdFcsiBe/J3/lw1nY36X2qRB8oIMJBcvoOjGrpmHfSgos4xfDF+/XE8Uuo
 ajiw==
X-Gm-Message-State: APjAAAXAf7oOjMBwGeHjVmkUbJpV/83tnlAssst+kfzOTr5tRZlITaV6
 EY9Nz/rD6PMbYCSA+uNRC1L5pwZcIbA=
X-Google-Smtp-Source: APXvYqx5vRQcJKkpsPM4qjZVgJ5vlYFJyZgmTMtbe5XE9ssyEOxZSkay76gBk8a4c9GRjImS+8YV7g==
X-Received: by 2002:adf:f5cf:: with SMTP id k15mr2678894wrp.182.1575017546576; 
 Fri, 29 Nov 2019 00:52:26 -0800 (PST)
Received: from PKL-BWASIM-LT.mgc.mentorg.com ([110.93.212.98])
 by smtp.gmail.com with ESMTPSA id x13sm12490515wmc.19.2019.11.29.00.52.24
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 29 Nov 2019 00:52:26 -0800 (PST)
From: bilalwasim676@gmail.com
To: qemu-devel@nongnu.org
Subject: [PATCH v2] net/cadence_gem: Updating the GEM MAC IP to properly
 filter out multicast addresses.
Date: Fri, 29 Nov 2019 13:52:16 +0500
Message-Id: <20191129085216.5108-1-bilalwasim676@gmail.com>
X-Mailer: git-send-email 2.19.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
X-Mailman-Approved-At: Fri, 29 Nov 2019 08:30:34 -0500
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
Cc: edgar.iglesias@gmail.com, qemu-arm@nongnu.org, bilal_wasim@mentor.com,
 alistair@alistair23.me, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: bwasim <bilal_wasim@mentor.com>

The current code makes a bad assumption that the most-significant byte
of the MAC address is used to determine if the address is multicast or
unicast, but in reality only a single bit is used to determine this.
This caused IPv6 to not work.. Fix is now in place and has been tested
with ZCU102-A53 / IPv6 on a TAP interface. Works well..

Signed-off-by: Bilal Wasim <bilal_wasim@mentor.com>
---
 hw/net/cadence_gem.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
index b8be73dc55..042188c1ba 100644
--- a/hw/net/cadence_gem.c
+++ b/hw/net/cadence_gem.c
@@ -34,6 +34,7 @@
 #include "qemu/module.h"
 #include "sysemu/dma.h"
 #include "net/checksum.h"
+#include "net/eth.h"
 
 #ifdef CADENCE_GEM_ERR_DEBUG
 #define DB_PRINT(...) do { \
@@ -601,7 +602,7 @@ static void gem_receive_updatestats(CadenceGEMState *s, const uint8_t *packet,
     }
 
     /* Error-free Multicast Frames counter */
-    if (packet[0] == 0x01) {
+    if (is_multicast_ether_addr(packet)) {
         s->regs[GEM_RXMULTICNT]++;
     }
 
@@ -690,21 +691,25 @@ static int gem_mac_address_filter(CadenceGEMState *s, const uint8_t *packet)
     }
 
     /* Accept packets -w- hash match? */
-    if ((packet[0] == 0x01 && (s->regs[GEM_NWCFG] & GEM_NWCFG_MCAST_HASH)) ||
-        (packet[0] != 0x01 && (s->regs[GEM_NWCFG] & GEM_NWCFG_UCAST_HASH))) {
+    if ((is_multicast_ether_addr(packet)
+        && (s->regs[GEM_NWCFG] & GEM_NWCFG_MCAST_HASH)) ||
+        (is_unicast_ether_addr(packet)
+        && (s->regs[GEM_NWCFG] & GEM_NWCFG_UCAST_HASH))) {
         unsigned hash_index;
 
         hash_index = calc_mac_hash(packet);
         if (hash_index < 32) {
             if (s->regs[GEM_HASHLO] & (1<<hash_index)) {
-                return packet[0] == 0x01 ? GEM_RX_MULTICAST_HASH_ACCEPT :
-                                           GEM_RX_UNICAST_HASH_ACCEPT;
+                return is_multicast_ether_addr(packet) ?
+                       GEM_RX_MULTICAST_HASH_ACCEPT :
+                       GEM_RX_UNICAST_HASH_ACCEPT;
             }
         } else {
             hash_index -= 32;
             if (s->regs[GEM_HASHHI] & (1<<hash_index)) {
-                return packet[0] == 0x01 ? GEM_RX_MULTICAST_HASH_ACCEPT :
-                                           GEM_RX_UNICAST_HASH_ACCEPT;
+                return is_multicast_ether_addr(packet) ?
+                       GEM_RX_MULTICAST_HASH_ACCEPT :
+                       GEM_RX_UNICAST_HASH_ACCEPT;
             }
         }
     }
-- 
2.19.1.windows.1


