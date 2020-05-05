Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2B05C47254
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 09:04:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78B6E206A4
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 09:04:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h+15IpkF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78B6E206A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVtVZ-0002JG-HB
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 05:04:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42478)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1jVtSh-0001Uj-FE; Tue, 05 May 2020 05:01:59 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:34771)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1jVtSg-00031H-6G; Tue, 05 May 2020 05:01:59 -0400
Received: by mail-pj1-x1042.google.com with SMTP id h12so940300pjz.1;
 Tue, 05 May 2020 02:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ZZcaownYOVGMUS4sax5IIN6n1Gg5Mtz3RfOCiSHv/xE=;
 b=h+15IpkFSmzGR/AuM7P4npo7008FXGgrozpw+FYbyC5CF0aSLACkG/CSBuYhTsh1Jz
 CJ0GE2rh9zTm4EXI6rt9c3n0CvZNfwAQGB8haW1o6g0+9AGXTyuSPjb3puMmrabyqgHi
 9cb0/573rA8NQRKPK1rvarlzCw/Bhd1gISk9DgEKq5aAPWi+bRqdqpOtcdOQ/LxCIbyJ
 cWq5yIvyz5zxGlQPMK3MjOKYAdyoOkf6rUguzHzR2xkA1712MUj6YjjWkuu/CkimC07A
 pk+mwuj1kby71l3iHUDLyE0LzwQlOj9shkVwlMUzhEQjuaLoCKEq6tDJoKTWB2y33Vcr
 ZxeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=ZZcaownYOVGMUS4sax5IIN6n1Gg5Mtz3RfOCiSHv/xE=;
 b=D1zvrlUf+dqBV5IFX0CIvGMviNhbcEWgBE1UXCg2B/e1E0B736tGeVSg+qKlr8BVlQ
 T+rYcXmF5Fu6Ofepv3CwUWkBiTNUhMnxuNbruodsnhRT6mAj1Mb5c3fVa5/zKo1uEDiG
 SysGYtKvwCc6GRQiiywSf1DYuzngJHCrktaXqnC+AjHErYsiiCEHF5dxaNP6uwKYT1v4
 M+B/kDAqhPuNzU9R9XlMrP4fZeV8+lHemOr3IKNKMgeTlOEBVf8xpCPrj+p2hn5tUCPe
 r46//m6GOUsnIKNXadhNPLMRkAz7qszIZxM4fsvHaqBslhr8pKXxjGi4sdORGD17Zx4Z
 Dtcg==
X-Gm-Message-State: AGi0PuaokbX8t3me1syPWMyFQMVIaa6JNhSL9DCEodHAqZdTskDvPmhk
 npGQFtU7nPmLMkhPqH7dzq0=
X-Google-Smtp-Source: APiQypJj4b3ZQqnqoRYNXVQ2mglm6AXoju1khTzfLt2WsNGpOQEoWz/KrKVB34eCTh0NJg1zKFUL6w==
X-Received: by 2002:a17:902:7203:: with SMTP id
 ba3mr1084480plb.202.1588669315473; 
 Tue, 05 May 2020 02:01:55 -0700 (PDT)
Received: from localhost.localdomain ([45.124.203.15])
 by smtp.gmail.com with ESMTPSA id w125sm1142401pgw.22.2020.05.05.02.01.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2020 02:01:54 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH] aspeed: sdmc: Implement AST2600 locking behaviour
Date: Tue,  5 May 2020 18:31:36 +0930
Message-Id: <20200505090136.341426-1-joel@jms.id.au>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1042;
 envelope-from=joel.stan@gmail.com; helo=mail-pj1-x1042.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Andrew Jeffery <andrew@aj.id.au>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The AST2600 handles this differently with the extra 'hardlock' state, so
move the testing to the soc specific class' write callback.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 hw/misc/aspeed_sdmc.c | 55 +++++++++++++++++++++++++++++++++++--------
 1 file changed, 45 insertions(+), 10 deletions(-)

diff --git a/hw/misc/aspeed_sdmc.c b/hw/misc/aspeed_sdmc.c
index 02940e7c2a76..7c688becf8c7 100644
--- a/hw/misc/aspeed_sdmc.c
+++ b/hw/misc/aspeed_sdmc.c
@@ -23,7 +23,12 @@
 
 /* Protection Key Register */
 #define R_PROT            (0x00 / 4)
+#define   PROT_UNLOCKED      0x01
+#define   PROT_HARDLOCKED    0x10  /* AST2600 */
+#define   PROT_SOFTLOCKED    0x00
+
 #define   PROT_KEY_UNLOCK     0xFC600309
+#define   PROT_KEY_HARDLOCK   0xDEADDEAD /* AST2600 */
 
 /* Configuration Register */
 #define R_CONF            (0x04 / 4)
@@ -130,16 +135,6 @@ static void aspeed_sdmc_write(void *opaque, hwaddr addr, uint64_t data,
         return;
     }
 
-    if (addr == R_PROT) {
-        s->regs[addr] = (data == PROT_KEY_UNLOCK) ? 1 : 0;
-        return;
-    }
-
-    if (!s->regs[R_PROT]) {
-        qemu_log_mask(LOG_GUEST_ERROR, "%s: SDMC is locked!\n", __func__);
-        return;
-    }
-
     asc->write(s, addr, data);
 }
 
@@ -291,6 +286,16 @@ static uint32_t aspeed_2400_sdmc_compute_conf(AspeedSDMCState *s, uint32_t data)
 static void aspeed_2400_sdmc_write(AspeedSDMCState *s, uint32_t reg,
                                    uint32_t data)
 {
+    if (reg == R_PROT) {
+        s->regs[reg] = (data == PROT_KEY_UNLOCK) ? PROT_UNLOCKED : PROT_SOFTLOCKED;
+        return;
+    }
+
+    if (!s->regs[R_PROT]) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: SDMC is locked!\n", __func__);
+        return;
+    }
+
     switch (reg) {
     case R_CONF:
         data = aspeed_2400_sdmc_compute_conf(s, data);
@@ -339,6 +344,16 @@ static uint32_t aspeed_2500_sdmc_compute_conf(AspeedSDMCState *s, uint32_t data)
 static void aspeed_2500_sdmc_write(AspeedSDMCState *s, uint32_t reg,
                                    uint32_t data)
 {
+    if (reg == R_PROT) {
+        s->regs[reg] = (data == PROT_KEY_UNLOCK) ? PROT_UNLOCKED : PROT_SOFTLOCKED;
+        return;
+    }
+
+    if (!s->regs[R_PROT]) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: SDMC is locked!\n", __func__);
+        return;
+    }
+
     switch (reg) {
     case R_CONF:
         data = aspeed_2500_sdmc_compute_conf(s, data);
@@ -395,7 +410,27 @@ static uint32_t aspeed_2600_sdmc_compute_conf(AspeedSDMCState *s, uint32_t data)
 static void aspeed_2600_sdmc_write(AspeedSDMCState *s, uint32_t reg,
                                    uint32_t data)
 {
+    if (s->regs[R_PROT] == PROT_HARDLOCKED) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: SDMC is locked until system reset!\n",
+                __func__);
+        return;
+    }
+
+    if (reg != R_PROT && s->regs[R_PROT] == PROT_SOFTLOCKED) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: SDMC is locked!\n", __func__);
+        return;
+    }
+
     switch (reg) {
+    case R_PROT:
+        if (data == PROT_KEY_UNLOCK)  {
+            data = PROT_UNLOCKED;
+        } else if (data == PROT_KEY_HARDLOCK) {
+            data = PROT_HARDLOCKED;
+        } else {
+            data = PROT_SOFTLOCKED;
+        }
+        break;
     case R_CONF:
         data = aspeed_2600_sdmc_compute_conf(s, data);
         break;
-- 
2.26.2


