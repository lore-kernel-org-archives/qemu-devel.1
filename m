Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D3C7C47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 13:35:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35173206F9
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 13:35:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XQPHx/ga"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35173206F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43494 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jY8aq-0003gk-9E
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 09:35:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48898)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jY8ZS-0001ia-Rz
 for qemu-devel@nongnu.org; Mon, 11 May 2020 09:34:14 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d]:52120)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jY8ZR-000707-VZ
 for qemu-devel@nongnu.org; Mon, 11 May 2020 09:34:14 -0400
Received: by mail-wm1-x32d.google.com with SMTP id f134so5898898wmf.1
 for <qemu-devel@nongnu.org>; Mon, 11 May 2020 06:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=LZBTHfpEZAJcb/Rg+g/QLUSKbytIhAoqXs85oGOuYl8=;
 b=XQPHx/ga/2RQnX5Volz9GWLWZgteq9NE8OhV/A5rbyimnj1JlkibTWG2o37aiUeOMk
 5NrS4qE88CYTJ6b7NIqtwbiKeKpWyvO+w8rW9kntNH9O2/v2N0X9G9Pu4lDNhfXw3rno
 LlpvrFSqKJo2kg2bNgKD9RHNMgrthJAc159gvkJborNIumz+hBXEqSOR6WLqlcFZsyzx
 7s+JjiKmEQ6Mj75j40o51FBsnmzc8dl34/qKtUWfJifogkDCzrMQz543HegI09x+Nnlo
 KwTnsubrMSC65/cnaxtfR+LxVrdK+t16cv/MBX/t306hnpDXGBNNHntyvYIOSHdKh63z
 FKDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=LZBTHfpEZAJcb/Rg+g/QLUSKbytIhAoqXs85oGOuYl8=;
 b=lhF/hy9RSEwwnCAsYocwum/5U8jN9OTJui7Yp7C57w18x3vTVQx3ahqXoWD8CjHTLx
 R/bOs9o5YCgSfpt1EB912RgD/mOHtp8HhUPhu1L34gWOJuvLWqHh7tcvibLf+4wqJUal
 zGM5/u6HBfNeNo2LU/1E148rnTysDXsU3A3ZNo3ZGTon+Elt+i7RoF5qWSLmSrz11h5s
 hus+VIiJylTFYc8W4th5xOsci99KVWfzhFTkAHKyKqyYNqiMWyI29tol/X5XLGfUvJXM
 eCoy5TaGCaRuTjKCqUP4vVFIu6Q3rWsolSWqDD5qy+UI3aVY5pLCgQro1Pj+EhJFb0Vh
 epmQ==
X-Gm-Message-State: AGi0PuaS+BeJPshXlChy9TkCyg/TCJOuLq0PEhYqjMOJ5hvmuBDbGQRb
 yLOkPQSyY5lsJ0ZUCws6/X1CGFMxWU31ig==
X-Google-Smtp-Source: APiQypKNVqnr5JePnzhP5QJDrSCPuuUAUA82qhtXDqi/YZdLEN7bGIefw31iYLPrUvhwC2yLbyjQVg==
X-Received: by 2002:a1c:f416:: with SMTP id z22mr31779778wma.32.1589204052249; 
 Mon, 11 May 2020 06:34:12 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id m3sm2154818wrn.96.2020.05.11.06.34.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2020 06:34:11 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/34] aspeed: sdmc: Implement AST2600 locking behaviour
Date: Mon, 11 May 2020 14:33:35 +0100
Message-Id: <20200511133405.5275-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200511133405.5275-1-peter.maydell@linaro.org>
References: <20200511133405.5275-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Joel Stanley <joel@jms.id.au>

The AST2600 handles this differently with the extra 'hardlock' state, so
move the testing to the soc specific class' write callback.

Signed-off-by: Joel Stanley <joel@jms.id.au>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Message-id: 20200505090136.341426-1-joel@jms.id.au
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/misc/aspeed_sdmc.c | 55 +++++++++++++++++++++++++++++++++++--------
 1 file changed, 45 insertions(+), 10 deletions(-)

diff --git a/hw/misc/aspeed_sdmc.c b/hw/misc/aspeed_sdmc.c
index 7b466bf19a6..14db9cfc1f8 100644
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
 
@@ -320,6 +315,16 @@ static uint32_t aspeed_2400_sdmc_compute_conf(AspeedSDMCState *s, uint32_t data)
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
@@ -368,6 +373,16 @@ static uint32_t aspeed_2500_sdmc_compute_conf(AspeedSDMCState *s, uint32_t data)
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
@@ -424,7 +439,27 @@ static uint32_t aspeed_2600_sdmc_compute_conf(AspeedSDMCState *s, uint32_t data)
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
2.20.1


