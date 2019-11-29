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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCAFAC432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 13:44:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 873E321736
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 13:44:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KLMMCDDv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 873E321736
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iagYx-0006sh-Id
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 08:43:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51489)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bilalwasim676@gmail.com>) id 1iadRs-0003um-Cd
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 05:24:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bilalwasim676@gmail.com>) id 1iadRp-0001yq-0w
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 05:24:26 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:42603)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bilalwasim676@gmail.com>)
 id 1iadRo-0001jB-O6; Fri, 29 Nov 2019 05:24:24 -0500
Received: by mail-wr1-x441.google.com with SMTP id a15so34481351wrf.9;
 Fri, 29 Nov 2019 02:24:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=3vLHdln1DbX8BhwYGzhWQv2zwN23+8GT4g7zmpr3u9E=;
 b=KLMMCDDvzQbjNZiuFf8HPcoa8P565LXBj5IVn/3rtTW94oK74YD6K7GsO5GN5ygyd/
 TOvOtM7reXvFVTL1prqrX4dtuFZgX6QJkCnGBfGqNGxoS7nUt/VALUyNfobtiYOUtaWu
 d1WcOUhOTnl+s7mcrIwfqSmAzzTmuA6XOt6mZ3R123raDcMmL9nHqL6xH0zNdhd+eKq9
 AC8vIN4LCr1xGnr/daGCzjqj4HCn8hN9+C/5/wLPGALwYUCYrkRghKcJ9vpSv2sEcDLL
 1FTsguk01vWrEKRiiwDNkc7Ug4OcLx6pYQmVPc8X2V9jC/GT2QnlU3KXmchJY0O+m68e
 97Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=3vLHdln1DbX8BhwYGzhWQv2zwN23+8GT4g7zmpr3u9E=;
 b=IJGNvn+hqLNgMrv/0BMn66PPdw8KJbP7XfLZOOrUwrJVRZIkdikQhzopx13nHPScrc
 qalTAQBVG/yW+gx79uiRlz8hSy47L+nfrDpkH/ni6OBfBD3uf28V7O+HcYD/X2MENQnB
 tPTNA3hr/ouZOTGlHFlIELErvZ9YBUgi1AR4V7wm7BBrdAmwwr0B5qCBJhWYotLZ8256
 wttn7hThPMP1M53dcZZqh8BkvB47D7fONSWPVfVlM598lvGBIEq9t/L9Gq8twquITuF4
 UWthpBmwdp+OSqVLTksyDPYAvll8o0p8L8Q8NJlow67E6SAegb2STnJfRMEQcMeOaGtN
 wcVA==
X-Gm-Message-State: APjAAAUmF3UXrhpupjtAiK7jYB2rzSlAbs0CzMt9o2HYlmx1zQfIV9Ik
 KrU4I0+ePGa+h3p5Xm7XPiM9hUnxpd8=
X-Google-Smtp-Source: APXvYqxYuik7Uk3HEIinicPHFfngD9h79KY5ssbi9euvevLnoEg9vKEzqgb4wMcnGRG1ltJ2584pQg==
X-Received: by 2002:a5d:68cf:: with SMTP id p15mr2093577wrw.31.1575023060081; 
 Fri, 29 Nov 2019 02:24:20 -0800 (PST)
Received: from PKL-BWASIM-LT.mgc.mentorg.com ([110.93.212.98])
 by smtp.gmail.com with ESMTPSA id a26sm12698479wmm.14.2019.11.29.02.24.18
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 29 Nov 2019 02:24:19 -0800 (PST)
From: bilalwasim676@gmail.com
To: qemu-devel@nongnu.org
Subject: [PATCH v3] net/cadence_gem: Updating the GEM MAC IP to properly
 filter out multicast addresses.
Date: Fri, 29 Nov 2019 15:24:14 +0500
Message-Id: <20191129102414.14060-1-bilalwasim676@gmail.com>
X-Mailer: git-send-email 2.19.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
X-Mailman-Approved-At: Fri, 29 Nov 2019 08:30:37 -0500
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
 hw/net/cadence_gem.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
index b8be73dc55..6400b3653b 100644
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
@@ -1083,7 +1088,7 @@ static void gem_transmit_updatestats(CadenceGEMState *s, const uint8_t *packet,
     }
 
     /* Error-free Multicast Frames counter */
-    if (packet[0] == 0x01) {
+    if (is_multicast_ether_addr(packet)) {
         s->regs[GEM_TXMCNT]++;
     }
 
-- 
2.19.1.windows.1


