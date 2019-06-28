Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3059C4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 17:36:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0CC7205F4
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 17:36:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0CC7205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hguni-0002It-0D
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 13:36:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54542)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <palmer@dabbelt.com>) id 1hgukY-0008Gc-Lc
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 13:33:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1hgukV-0000Ex-F5
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 13:33:26 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35229)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1hgukV-0008QV-53
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 13:33:23 -0400
Received: by mail-pl1-f196.google.com with SMTP id w24so3612296plp.2
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2019 10:32:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:cc:from:to;
 bh=D1HIL5SBmBBlqGmn3DV7OFXg5gWo+HXWOwuA3mR3IqE=;
 b=f1LIo67fY4kdhyuFLKPpv/yCk+tYGEBitm7GGoJW82x3vmMly/YAcze9LX+gCBHgam
 mczqeFuDh92PYfKQOTBRwIEfvCZp11TSM8JEK+4C5MPTAisnycYZK+bkmGRcB/xM0MFy
 W4wuP+YiVFq1GE3cLmCwrmqx5IOpcABAJWXEzK8kvZ0o0TBrvNRACz+4W97IzVXFuF9i
 vm5xDgvnBwKIv3Rs/CrIYcEsyZKrOX63nKAXOM2MSxrfr67bWNCP43awUWhIucPsYKZL
 6nHbMb3RQGn2eDm3w/m3NnO6i3yDMzMW2AD5cMqeyQNvmo1NNzPJQBgj9tC9sX5H+zAd
 3zIQ==
X-Gm-Message-State: APjAAAVbnJWwaEQ07ZsPPRhedcpWKfTWoioReb9jnxQ1ep3rucncl2q/
 v/cvyhoe2w94P5yiyH8OEwnaFDvqsB2qA9hk
X-Google-Smtp-Source: APXvYqyIdwN6WPgYTdxwlX2tmPCQj8Sp/A3Ofopw769XUdpWuIt+DyabcFtLOIeqzKGEWCRJjEsWxQ==
X-Received: by 2002:a17:902:722:: with SMTP id
 31mr12767821pli.163.1561743177167; 
 Fri, 28 Jun 2019 10:32:57 -0700 (PDT)
Received: from localhost (220-132-236-182.HINET-IP.hinet.net.
 [220.132.236.182])
 by smtp.gmail.com with ESMTPSA id q1sm4411297pfn.178.2019.06.28.10.32.56
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 28 Jun 2019 10:32:56 -0700 (PDT)
Date: Fri, 28 Jun 2019 10:31:59 -0700
Message-Id: <20190628173227.31925-7-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190628173227.31925-1-palmer@sifive.com>
References: <20190628173227.31925-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@sifive.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.214.196
Subject: [Qemu-devel] [PULL 06/34] RISC-V: Raise access fault exceptions on
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


