Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1033C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 10:08:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6FDA20707
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 10:08:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jYHgX7pT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6FDA20707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jl8WO-00005K-Us
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 06:08:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51018)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jl8LU-0007f0-1B
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 05:57:32 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:42488)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jl8LR-00043f-8d
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 05:57:31 -0400
Received: by mail-wr1-x441.google.com with SMTP id p5so20053200wrw.9
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2020 02:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=yduhvPOTRr0xD1KiT4dgO2ixrWMeq+0pzSllB8kMbEw=;
 b=jYHgX7pTOZl4iCEkbnYYnqA9HgUP+QDTC2ptOZVy+F6EXu9UBK+EY5nAg9poEPdbc4
 cZiEgDNw47LDlXCutzIjPhoM2zdEBGyy8EGnMIXCRoEl4ekUXr44tHFdBvidZnehhW55
 eOIfPb4PgZ/jctnF6zf2VneiMwfC8T+fwiLGgf0UaOCUvJ8+eyazgasT0s4hT/ajtJ4c
 MmefqThn4MM4geHSIXETSybhWJ6lr0tHSVeo4M/wXkPz1O/mN63mDHyYBsZtyv4wuBQO
 9yDb0X92pg1KxciNp1rdbFb7akwbmHQqDRwECLTbNqWFBdlWZOy6M5YxytXao4tn8/I1
 AHaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=yduhvPOTRr0xD1KiT4dgO2ixrWMeq+0pzSllB8kMbEw=;
 b=K0CwDN+3YOPapmMqteZzfDgNv7Hz41JgHtEfibSHajUpjmOOHLpNsoDkcxL5Qrlvrn
 nsbvpSXBYRKjetN7Pt8UuwpqhuSCzs51q2+3rEMPqmceE45YaJCqYP9D+Tkblp5fdtzH
 dU+03qUGwQxEIBBq/U5G2YDPNTajk1auWWQZzsNSQdfKr5kPyI8XXh6DxmpVF5XqoJWj
 ftuaqnla+JIjCfeHtckepXg4PM2cKLS0yvQ78Tvj80H4ZS2FKC1yQ+RySLI1ansrutql
 or94JNBaD4KHKbYNxfY/Jfx+0H4ALkHXswF+WWRLqv83prwVGkIGxoGf9b1taPmiUtVu
 1aAA==
X-Gm-Message-State: AOAM530GKfXOPau7IDmlfLxYnhcdo4+TTerXLMMUHndGla/fBYl+XWE1
 stv107sWmcusV7wuAE7dNM2GMAXcY6Htkw==
X-Google-Smtp-Source: ABdhPJxOleU28xiGnGk+uPGai4j20JVuL74C7F32TqkCBDilMjMqknZHeXQ7y0wWJGnv57U/HETg1Q==
X-Received: by 2002:adf:f251:: with SMTP id b17mr2071029wrp.289.1592301447640; 
 Tue, 16 Jun 2020 02:57:27 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id z12sm31090851wrg.9.2020.06.16.02.57.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2020 02:57:27 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 19/23] Implement configurable descriptor size in ftgmac100
Date: Tue, 16 Jun 2020 10:56:58 +0100
Message-Id: <20200616095702.25848-20-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200616095702.25848-1-peter.maydell@linaro.org>
References: <20200616095702.25848-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Erik Smit <erik.lucas.smit@gmail.com>

The hardware supports configurable descriptor sizes, configured in the DBLAC
register.

Most drivers use the default 4 word descriptor, which is currently hardcoded,
but Aspeed SDK configures 8 words to store extra data.

Signed-off-by: Erik Smit <erik.lucas.smit@gmail.com>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
[PMM: removed unnecessary parens]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/net/ftgmac100.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/hw/net/ftgmac100.c b/hw/net/ftgmac100.c
index 25ebee7ec2b..043ba61b864 100644
--- a/hw/net/ftgmac100.c
+++ b/hw/net/ftgmac100.c
@@ -79,6 +79,16 @@
 #define FTGMAC100_APTC_TXPOLL_CNT(x)        (((x) >> 8) & 0xf)
 #define FTGMAC100_APTC_TXPOLL_TIME_SEL      (1 << 12)
 
+/*
+ * DMA burst length and arbitration control register
+ */
+#define FTGMAC100_DBLAC_RXBURST_SIZE(x)     (((x) >> 8) & 0x3)
+#define FTGMAC100_DBLAC_TXBURST_SIZE(x)     (((x) >> 10) & 0x3)
+#define FTGMAC100_DBLAC_RXDES_SIZE(x)       ((((x) >> 12) & 0xf) * 8)
+#define FTGMAC100_DBLAC_TXDES_SIZE(x)       ((((x) >> 16) & 0xf) * 8)
+#define FTGMAC100_DBLAC_IFG_CNT(x)          (((x) >> 20) & 0x7)
+#define FTGMAC100_DBLAC_IFG_INC             (1 << 23)
+
 /*
  * PHY control register
  */
@@ -553,7 +563,7 @@ static void ftgmac100_do_tx(FTGMAC100State *s, uint32_t tx_ring,
         if (bd.des0 & s->txdes0_edotr) {
             addr = tx_ring;
         } else {
-            addr += sizeof(FTGMAC100Desc);
+            addr += FTGMAC100_DBLAC_TXDES_SIZE(s->dblac);
         }
     }
 
@@ -800,6 +810,18 @@ static void ftgmac100_write(void *opaque, hwaddr addr,
         s->phydata = value & 0xffff;
         break;
     case FTGMAC100_DBLAC: /* DMA Burst Length and Arbitration Control */
+        if (FTGMAC100_DBLAC_TXDES_SIZE(s->dblac) < sizeof(FTGMAC100Desc)) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s: transmit descriptor too small : %d bytes\n",
+                          __func__, FTGMAC100_DBLAC_TXDES_SIZE(s->dblac));
+            break;
+        }
+        if (FTGMAC100_DBLAC_RXDES_SIZE(s->dblac) < sizeof(FTGMAC100Desc)) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s: receive descriptor too small : %d bytes\n",
+                          __func__, FTGMAC100_DBLAC_RXDES_SIZE(s->dblac));
+            break;
+        }
         s->dblac = value;
         break;
     case FTGMAC100_REVR:  /* Feature Register */
@@ -982,7 +1004,7 @@ static ssize_t ftgmac100_receive(NetClientState *nc, const uint8_t *buf,
         if (bd.des0 & s->rxdes0_edorr) {
             addr = s->rx_ring;
         } else {
-            addr += sizeof(FTGMAC100Desc);
+            addr += FTGMAC100_DBLAC_RXDES_SIZE(s->dblac);
         }
     }
     s->rx_descriptor = addr;
-- 
2.20.1


