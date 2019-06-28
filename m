Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2216FC4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 17:58:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F00752083B
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 17:58:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F00752083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35038 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgv8p-0001PC-72
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 13:58:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54686)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <palmer@dabbelt.com>) id 1hgukd-0008JS-6d
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 13:33:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1hgukW-0000HC-LU
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 13:33:30 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39915)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1hgukW-0000F9-E8
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 13:33:24 -0400
Received: by mail-pg1-f196.google.com with SMTP id 196so2889798pgc.6
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2019 10:33:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:cc:from:to;
 bh=dUa00V6qaWWvVsCSIWO0c3PzQTzV7TrVR8O4HvR6bag=;
 b=nD7CPeb/k8+PA3XMZz4LWs4fbtyuWa/WOSOIpR6uOCV2WKH24Vb7PDzjra+ztFobYe
 KpMuWekfn8XzfxxDTf5cfErVDX8kH3hzWjHK7Gb8cRto5wlcwdJSfUYdrW3MqA1tEaLc
 MjdZ+KJPhZrTSmBPAi8PIhuKqh0Ds4FSGJTVAL9MVyRAqYTRDLObCZo7Z5+8heah4/ed
 kT3E2x8scK7JQ2XF2B8+1uWuJ4rNgH0kqu64SmO/3rd9hdVOkDvSyfwxWAoM+TEGpOdj
 TRSrRT+1iIeyboj65C2PE4UZAolSbQcWsn3zfR0SvsycMlhLpmUDbgWfLVRblxjlQFIs
 9DpQ==
X-Gm-Message-State: APjAAAXhYdj5rbSQHdswlkhq6D+z8X+DYFNrcC7ArKZDQFgDWYPPTIJe
 EaIHBcf1zpzaxFERGAeE2IgHBTwwMrSHexMp
X-Google-Smtp-Source: APXvYqyD+8XMXCIjhhGgfHNg6uwWD5He5qCwD3xrpBGZBkUAblFOTixrJodXTQssZTXX6EX4if6vWQ==
X-Received: by 2002:a63:18d:: with SMTP id 135mr10410567pgb.62.1561743202387; 
 Fri, 28 Jun 2019 10:33:22 -0700 (PDT)
Received: from localhost (220-132-236-182.HINET-IP.hinet.net.
 [220.132.236.182])
 by smtp.gmail.com with ESMTPSA id j23sm2496754pgb.63.2019.06.28.10.33.21
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 28 Jun 2019 10:33:21 -0700 (PDT)
Date: Fri, 28 Jun 2019 10:32:08 -0700
Message-Id: <20190628173227.31925-16-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190628173227.31925-1-palmer@sifive.com>
References: <20190628173227.31925-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@sifive.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.215.196
Subject: [Qemu-devel] [PULL 15/34] target/riscv: Add the mcountinhibit CSR
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
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Palmer Dabbelt <palmer@sifive.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alistair Francis <alistair.francis@wdc.com>

1.11 defines mcountinhibit, which has the same numeric CSR value as
mucounteren from 1.09.1 but has different semantics.  This patch enables
the CSR for 1.11-based targets, which is trivial to implement because
the counters in QEMU never tick (legal according to the spec).

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
[Palmer: Fix counter access semantics, change commit message to indicate
the behavior is fully emulated.]
Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 target/riscv/cpu_bits.h |  1 +
 target/riscv/csr.c      | 17 +++++++++++++++--
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index 47450a3cdb75..11f971ad5df0 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -136,6 +136,7 @@
 #define CSR_MCOUNTEREN      0x306
 
 /* Legacy Counter Setup (priv v1.9.1) */
+/* Update to #define CSR_MCOUNTINHIBIT 0x320 for 1.11.0 */
 #define CSR_MUCOUNTEREN     0x320
 #define CSR_MSCOUNTEREN     0x321
 #define CSR_MHCOUNTEREN     0x322
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index c67d29e20618..448162e484a3 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -56,6 +56,15 @@ static int fs(CPURISCVState *env, int csrno)
 static int ctr(CPURISCVState *env, int csrno)
 {
 #if !defined(CONFIG_USER_ONLY)
+    /*
+     * The counters are always enabled on newer priv specs, as the CSR has
+     * changed from controlling that the counters can be read to controlling
+     * that the counters increment.
+     */
+    if (env->priv_ver > PRIV_VERSION_1_09_1) {
+        return 0;
+    }
+
     uint32_t ctr_en = ~0u;
 
     if (env->priv < PRV_M) {
@@ -461,18 +470,22 @@ static int write_mcounteren(CPURISCVState *env, int csrno, target_ulong val)
     return 0;
 }
 
+/* This regiser is replaced with CSR_MCOUNTINHIBIT in 1.11.0 */
 static int read_mscounteren(CPURISCVState *env, int csrno, target_ulong *val)
 {
-    if (env->priv_ver > PRIV_VERSION_1_09_1) {
+    if (env->priv_ver > PRIV_VERSION_1_09_1
+        && env->priv_ver < PRIV_VERSION_1_11_0) {
         return -1;
     }
     *val = env->mcounteren;
     return 0;
 }
 
+/* This regiser is replaced with CSR_MCOUNTINHIBIT in 1.11.0 */
 static int write_mscounteren(CPURISCVState *env, int csrno, target_ulong val)
 {
-    if (env->priv_ver > PRIV_VERSION_1_09_1) {
+    if (env->priv_ver > PRIV_VERSION_1_09_1
+        && env->priv_ver < PRIV_VERSION_1_11_0) {
         return -1;
     }
     env->mcounteren = val;
-- 
2.21.0


