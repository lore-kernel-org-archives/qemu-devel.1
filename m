Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6942FC5B578
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 08:52:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 428C9218A3
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 08:52:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 428C9218A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33760 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hib01-0008Eo-H8
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 04:52:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51194)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <palmer@dabbelt.com>) id 1hiapO-0005VG-EV
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 04:41:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1hiapN-0006RR-7G
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 04:41:22 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41336)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1hiapN-0006OY-0I
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 04:41:21 -0400
Received: by mail-lj1-f195.google.com with SMTP id 205so1463273ljj.8
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2019 01:41:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:cc:from:to;
 bh=D1HIL5SBmBBlqGmn3DV7OFXg5gWo+HXWOwuA3mR3IqE=;
 b=cN6JMn51bPmd/Sce5ZvLBqCoZJ99hCb9NTSrikMtbhf4vM98uQUIt+38NY2TTvMWOw
 sC4qHh/nMrFsY93gJOPG+Aa5BKF1Py/ErVGCJGx9IluNQiIvn4CRnevKNe9YtjcFuvlK
 U68c1ng/JcPXZEATzutJHAgWwM/d9cG8l/vWUIe3pAHsKYnociZMdvYqHNfqjpFQoCi+
 C+e1ymr2AZGnIYMuIU3d5mhrdVeJIBVBPfW01mCpuGg1zaxqq0OzUbIepl17gjgnrv5G
 KmyiRZNcqRWtp+ZXbqsj2LkYKpovA5dT1ykP03hgm7kikVfjiTFB1x19v+f8EXYnJJgE
 +tXg==
X-Gm-Message-State: APjAAAVjZoShpiMvxvAZ1CMEUK369bejTsHaf9P7uLvrsnc/son/hOLG
 059IEYUFE/GvyZjSCInSF9NSu02wmGdNcQ==
X-Google-Smtp-Source: APXvYqz0YCnSubA2q7ypKkeNwCDmJ+Mkruj38luMs43GLY2i3z0f/gK5u7QH7lWAxLU7KEPaK5dyYw==
X-Received: by 2002:a2e:9158:: with SMTP id q24mr2478639ljg.119.1562143279251; 
 Wed, 03 Jul 2019 01:41:19 -0700 (PDT)
Received: from localhost ([134.17.27.127])
 by smtp.gmail.com with ESMTPSA id p12sm343296lja.23.2019.07.03.01.41.18
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 03 Jul 2019 01:41:18 -0700 (PDT)
Date: Wed,  3 Jul 2019 01:40:22 -0700
Message-Id: <20190703084048.6980-7-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190703084048.6980-1-palmer@sifive.com>
References: <20190703084048.6980-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@sifive.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.208.195
Subject: [Qemu-devel] [PULL 06/32] RISC-V: Raise access fault exceptions on
 PMP violations
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
 qemu-devel@nongnu.org, Hesham Almatary <Hesham.Almatary@cl.cam.ac.uk>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Hesham Almatary <Hesham.Almatary@cl.cam.ac.uk>

Section 3.6 in RISC-V v1.10 privilege specification states that PMP violations
report "access exceptions." The current PMP implementation has
a bug which wrongly reports "page exceptions" on PMP violations.

This patch fixes this bug by reporting the correct PMP access exceptions
trap values.

Signed-off-by: Hesham Almatary <Hesham.Almatary@cl.cam.ac.uk>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 target/riscv/cpu_helper.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index a45b05ef8395..ffbfaf433268 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -337,12 +337,13 @@ restart:
 }
 
 static void raise_mmu_exception(CPURISCVState *env, target_ulong address,
-                                MMUAccessType access_type)
+                                MMUAccessType access_type, bool pmp_violation)
 {
     CPUState *cs = env_cpu(env);
     int page_fault_exceptions =
         (env->priv_ver >= PRIV_VERSION_1_10_0) &&
-        get_field(env->satp, SATP_MODE) != VM_1_10_MBARE;
+        get_field(env->satp, SATP_MODE) != VM_1_10_MBARE &&
+        !pmp_violation;
     switch (access_type) {
     case MMU_INST_FETCH:
         cs->exception_index = page_fault_exceptions ?
@@ -424,6 +425,7 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     CPURISCVState *env = &cpu->env;
     hwaddr pa = 0;
     int prot;
+    bool pmp_violation = false;
     int ret = TRANSLATE_FAIL;
 
     qemu_log_mask(CPU_LOG_MMU, "%s ad %" VADDR_PRIx " rw %d mmu_idx %d\n",
@@ -438,6 +440,7 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     if (riscv_feature(env, RISCV_FEATURE_PMP) &&
         (ret == TRANSLATE_SUCCESS) &&
         !pmp_hart_has_privs(env, pa, TARGET_PAGE_SIZE, 1 << access_type)) {
+        pmp_violation = true;
         ret = TRANSLATE_FAIL;
     }
     if (ret == TRANSLATE_SUCCESS) {
@@ -447,7 +450,7 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     } else if (probe) {
         return false;
     } else {
-        raise_mmu_exception(env, address, access_type);
+        raise_mmu_exception(env, address, access_type, pmp_violation);
         riscv_raise_exception(env, cs->exception_index, retaddr);
     }
 #else
-- 
2.21.0


