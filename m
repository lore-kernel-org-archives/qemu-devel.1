Return-Path: <SRS0=5YAC=T2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA793C07542
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2019 01:35:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE2BD20644
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2019 01:35:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE2BD20644
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49213 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUi4n-0001Up-Ss
	for qemu-devel@archiver.kernel.org; Sat, 25 May 2019 21:35:53 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53756)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@dabbelt.com>) id 1hUhxF-0003GC-IE
	for qemu-devel@nongnu.org; Sat, 25 May 2019 21:28:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@dabbelt.com>) id 1hUhgI-0006RD-W2
	for qemu-devel@nongnu.org; Sat, 25 May 2019 21:10:35 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43785)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1hUhgI-0006Qh-Qx
	for qemu-devel@nongnu.org; Sat, 25 May 2019 21:10:34 -0400
Received: by mail-pl1-f194.google.com with SMTP id gn7so5618838plb.10
	for <qemu-devel@nongnu.org>; Sat, 25 May 2019 18:10:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:cc:from:to;
	bh=XBhUGLLDCqlPrL4Y4ENmCJmXPWom5sz/dBlkDrNXnDE=;
	b=LWR4ngEA07LfeB6Hgg/s8dYnjbZxk4ve7WDCMaA1ZwUz1tZRqDACFD62eC+PIoYsdx
	hcEl1Fda+K79WuKp6mBkhpTXfDBsX9CeK7onuMLG9WytjxqolcvV6efxJO8cyOluUusq
	FeOD1I3LVUr4g0t1eiATZxvU/sFVaa9pLz5VAH1zq271+mn/XXD5P9hamxY2uADZ46qU
	6Bew2RJgtUC6o39tBvzEo8MP6j6+ahJViPtrcih5oRE+M1E1mxZNVtQiS3wS901aXeWj
	MJvUoVZCQHB3IgXbCNi89s56Qim5flwyofqpk/UVdsR0oUVxyKXB3DX1iQiekmL5q1tF
	aYFA==
X-Gm-Message-State: APjAAAUiwQqGRERxHnzw/eNwqXcY+GLgFMHSpVVELIm8ZCqY/nSZZgLw
	r9UQCPqgp9CnM+NnhHHIMLtGfQ==
X-Google-Smtp-Source: APXvYqy5S9tSZkUyRQwqUKgWOFqFq2ytw2Ni6rzsi6AFQrXL1cRdX7k52Urgb1+JJDTJuGEwcxOQ3w==
X-Received: by 2002:a17:902:8a91:: with SMTP id
	p17mr52728975plo.60.1558833033700; 
	Sat, 25 May 2019 18:10:33 -0700 (PDT)
Received: from localhost ([12.206.222.5])
	by smtp.gmail.com with ESMTPSA id k3sm6902397pfa.36.2019.05.25.18.10.33
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Sat, 25 May 2019 18:10:33 -0700 (PDT)
Date: Sat, 25 May 2019 18:09:42 -0700
Message-Id: <20190526010948.3923-24-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190526010948.3923-1-palmer@sifive.com>
References: <20190526010948.3923-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@sifive.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.214.194
Subject: [Qemu-devel] [PULL 23/29] target/riscv: Allow setting mstatus
 virtulisation bits
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
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

From: Alistair Francis <Alistair.Francis@wdc.com>

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Revieweb-by: Palmer Dabbelt <palmer@sifive.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 target/riscv/csr.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index f9d8d150e012..e6d68a99560d 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -290,7 +290,6 @@ static int write_mstatus(CPURISCVState *env, int csrno, target_ulong val)
 {
     target_ulong mstatus = env->mstatus;
     target_ulong mask = 0;
-    target_ulong mpp = get_field(val, MSTATUS_MPP);
 
     /* flush tlb on mstatus fields that affect VM */
     if (env->priv_ver <= PRIV_VERSION_1_09_1) {
@@ -305,7 +304,7 @@ static int write_mstatus(CPURISCVState *env, int csrno, target_ulong val)
                 MSTATUS_VM : 0);
     }
     if (env->priv_ver >= PRIV_VERSION_1_10_0) {
-        if ((val ^ mstatus) & (MSTATUS_MXR | MSTATUS_MPP |
+        if ((val ^ mstatus) & (MSTATUS_MXR | MSTATUS_MPP | MSTATUS_MPV |
                 MSTATUS_MPRV | MSTATUS_SUM)) {
             tlb_flush(CPU(riscv_env_get_cpu(env)));
         }
@@ -313,13 +312,13 @@ static int write_mstatus(CPURISCVState *env, int csrno, target_ulong val)
             MSTATUS_SPP | MSTATUS_FS | MSTATUS_MPRV | MSTATUS_SUM |
             MSTATUS_MPP | MSTATUS_MXR | MSTATUS_TVM | MSTATUS_TSR |
             MSTATUS_TW;
-    }
-
-    /* silenty discard mstatus.mpp writes for unsupported modes */
-    if (mpp == PRV_H ||
-        (!riscv_has_ext(env, RVS) && mpp == PRV_S) ||
-        (!riscv_has_ext(env, RVU) && mpp == PRV_U)) {
-        mask &= ~MSTATUS_MPP;
+#if defined(TARGET_RISCV64)
+            /*
+             * RV32: MPV and MTL are not in mstatus. The current plan is to
+             * add them to mstatush. For now, we just don't support it.
+             */
+            mask |= MSTATUS_MPP | MSTATUS_MPV;
+#endif
     }
 
     mstatus = (mstatus & ~mask) | (val & mask);
-- 
2.21.0


