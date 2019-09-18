Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59E45C4CEC4
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 15:46:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F49F206C2
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 15:46:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F49F206C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60216 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAc9Y-0005mw-BZ
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 11:46:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49090)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmer@dabbelt.com>) id 1iAbrx-0006Mv-7p
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 11:27:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1iAbrw-0006TJ-1n
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 11:27:49 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39788)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1iAbrv-0006Se-SB
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 11:27:47 -0400
Received: by mail-pf1-f195.google.com with SMTP id i1so201368pfa.6
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2019 08:27:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:cc:from:to;
 bh=ObpRu4yWGJ56Lce0E8Qj/S0MZ1B/JMtbNndq30ymwo0=;
 b=p7XPQSH5Os1bX+o6AqGLinhM0Zlm1qdmm4ZKAl38xk8DzAd1PGBjlYNQD64qzS7bxS
 Jz+tpZMxfoWF3iXHx+S1glErefKpQywR4ByRMghPxC0levi5paSdOVTT0A+v1jRA0i/3
 Vuu5of1FTSWmPEkJdULWn1OLqw5u1Hj4L7asg4R2bgkc1lOqs7K5Dv03HqnltdHnYi2n
 0SpwnfLArwn1xACho05aOGiteLx+wQsmTrg7G4LHIaIHhWZJHlp3jTI0DCnaAXN58whu
 /YIw0R0IvDDD/GiB39uRK4mOWrH4eyL6r7DX6JR2GgHilv6Sc1Cv2LTACq6ESltzN3hu
 G0ZQ==
X-Gm-Message-State: APjAAAUmR4LVY85KnaTmF5mK2cNN1J2vF/1sujyPGa+5o+1ROx8hauCG
 07SMKVP0Q0q1JbcjfNTTJqSZVg==
X-Google-Smtp-Source: APXvYqzalaVF/UtW5QClUcNY5hqPSb6pUDyth2/zz1ByScXYulkSUxKELM8zmC6Pw7G/ixHGpbS7Fg==
X-Received: by 2002:a63:eb52:: with SMTP id b18mr2090909pgk.71.1568820466587; 
 Wed, 18 Sep 2019 08:27:46 -0700 (PDT)
Received: from localhost ([12.206.222.5])
 by smtp.gmail.com with ESMTPSA id l124sm6998219pgl.54.2019.09.18.08.27.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Sep 2019 08:27:45 -0700 (PDT)
Date: Wed, 18 Sep 2019 07:56:01 -0700
Message-Id: <20190918145640.17349-10-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190918145640.17349-1-palmer@sifive.com>
References: <20190918145640.17349-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@sifive.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.210.195
Subject: [Qemu-devel] [PULL 09/48] riscv: rv32: Root page table address can
 be larger than 32-bit
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
Cc: Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 Palmer Dabbelt <palmer@sifive.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Bin Meng <bmeng.cn@gmail.com>

For RV32, the root page table's PPN has 22 bits hence its address
bits could be larger than the maximum bits that target_ulong is
able to represent. Use hwaddr instead.

Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 target/riscv/cpu_helper.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 96373b67d8..87dd6a6ece 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -186,12 +186,12 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
 
     *prot = 0;
 
-    target_ulong base;
+    hwaddr base;
     int levels, ptidxbits, ptesize, vm, sum;
     int mxr = get_field(env->mstatus, MSTATUS_MXR);
 
     if (env->priv_ver >= PRIV_VERSION_1_10_0) {
-        base = get_field(env->satp, SATP_PPN) << PGSHIFT;
+        base = (hwaddr)get_field(env->satp, SATP_PPN) << PGSHIFT;
         sum = get_field(env->mstatus, MSTATUS_SUM);
         vm = get_field(env->satp, SATP_MODE);
         switch (vm) {
@@ -211,7 +211,7 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
           g_assert_not_reached();
         }
     } else {
-        base = env->sptbr << PGSHIFT;
+        base = (hwaddr)(env->sptbr) << PGSHIFT;
         sum = !get_field(env->mstatus, MSTATUS_PUM);
         vm = get_field(env->mstatus, MSTATUS_VM);
         switch (vm) {
@@ -249,7 +249,7 @@ restart:
                            ((1 << ptidxbits) - 1);
 
         /* check that physical address of PTE is legal */
-        target_ulong pte_addr = base + idx * ptesize;
+        hwaddr pte_addr = base + idx * ptesize;
 
         if (riscv_feature(env, RISCV_FEATURE_PMP) &&
             !pmp_hart_has_privs(env, pte_addr, sizeof(target_ulong),
@@ -261,7 +261,7 @@ restart:
 #elif defined(TARGET_RISCV64)
         target_ulong pte = ldq_phys(cs->as, pte_addr);
 #endif
-        target_ulong ppn = pte >> PTE_PPN_SHIFT;
+        hwaddr ppn = pte >> PTE_PPN_SHIFT;
 
         if (!(pte & PTE_V)) {
             /* Invalid PTE */
-- 
2.21.0


