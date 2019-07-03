Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F5FAC0650E
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 09:05:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77EA4218A3
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 09:05:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77EA4218A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hibCe-0002qS-Pi
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 05:05:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51446)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <palmer@dabbelt.com>) id 1hiapi-0006AI-Jy
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 04:41:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1hiapg-0007DV-Qh
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 04:41:41 -0400
Received: from mail-lf1-f54.google.com ([209.85.167.54]:38065)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1hiapg-00075K-Hc
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 04:41:40 -0400
Received: by mail-lf1-f54.google.com with SMTP id b11so1160247lfa.5
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2019 01:41:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:cc:from:to;
 bh=dUa00V6qaWWvVsCSIWO0c3PzQTzV7TrVR8O4HvR6bag=;
 b=Z45H62Yb1RPy+NPcdF+OJ0WRaXgj4tIptXYjJN70t8XJuW18Tqek2a7ucPgcADyZh5
 7xSfNaBw6cN8Q7+MLukiW3btTy30e6cuNJxO3CRs9CWKOXZPKXc1MfiJhs3ObqflwkXq
 9NDQaMMglaeYVQW7TMWs1434qSowYm2C92c96iWusu/0Oprg01Ud6ojO/GZqiG6HnfIt
 Rc3lERGg2cXdaRSsRFQ9oLMrpZ6WAAGOl0mqtwUfLlB37+AIj/lgMoSxWvFg6ZOADAfs
 OuKi8W5ZyZS0GR7G2fNhkwQJ3iZgr+IWsjs1EaQu/5O2xUOqFKdeIZ3coXnJSagU+JZZ
 x01w==
X-Gm-Message-State: APjAAAXY8StRpTJA9TrjswWd7nL1BmcKWusL5sMFzNCRIwfHS6L5SpO+
 fi+14c+4STLmyT2avltszOzSUTCJv5HbHQ==
X-Google-Smtp-Source: APXvYqxQscEjCH6gBZmYF2Axq6GbeSFGszP49M8AhAxDdT92Q7Ijg8lIrjKT5r3hKIdRQdFom79myA==
X-Received: by 2002:a05:6512:24a:: with SMTP id
 b10mr17740340lfo.37.1562143296176; 
 Wed, 03 Jul 2019 01:41:36 -0700 (PDT)
Received: from localhost ([134.17.27.127])
 by smtp.gmail.com with ESMTPSA id s19sm340157lji.38.2019.07.03.01.41.35
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 03 Jul 2019 01:41:35 -0700 (PDT)
Date: Wed,  3 Jul 2019 01:40:31 -0700
Message-Id: <20190703084048.6980-16-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190703084048.6980-1-palmer@sifive.com>
References: <20190703084048.6980-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@sifive.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.167.54
Subject: [Qemu-devel] [PULL 15/32] target/riscv: Add the mcountinhibit CSR
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


