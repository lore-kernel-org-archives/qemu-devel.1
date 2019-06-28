Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAB61C4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 17:53:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A68DA2083B
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 17:53:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A68DA2083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35008 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgv3y-0005iO-40
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 13:53:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54621)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <palmer@dabbelt.com>) id 1hguka-0008JE-S2
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 13:33:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1hgukW-0000Gc-Gi
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 13:33:28 -0400
Received: from mail-pf1-f178.google.com ([209.85.210.178]:45297)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1hgukW-0008U0-7g
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 13:33:24 -0400
Received: by mail-pf1-f178.google.com with SMTP id r1so3314023pfq.12
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2019 10:33:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:cc:from:to;
 bh=dzPUzTIkHxzJQoxigOG9F6jOZkqkITw8eDaqBssKL50=;
 b=J6AAgeyg+T5IaQ8LXx6CpCd/iUYoChxcx9rAEyIT4t3DoueDtIdqoKrAdIDTtljEsN
 ZAzYffwAMaVxyqokCQLAPpGwaj5LMWTxxEiF+w7043cbOHW2VMvaOAWeexqrqvZhgBF5
 +178SXYKREfCby/bzgYsyMKuivmZ1xY73rCIu1x7i0pAd9M4FPmOppaGxDJDACx/bYfQ
 fRlmYSkljpFKWQRMAg+4nUqrWYmluGGhdQifQ1wYQfTHAK3XcoYso9vSu4kljtVuOufJ
 qqOlsnqnxgHF9/TYZamy1TJqTDX/DcrZC9oIrA1lTybWIeUz4Mu5SKpR48j4kQN+KyKS
 KJvA==
X-Gm-Message-State: APjAAAWeNK4UiKUq46D321/PlxsPvQ7CNT5dpI8H8MCqv7jJdL2erHG4
 OhrOKIDiI68VLA1QlkoyUlvfaoaw2kSfIKYU
X-Google-Smtp-Source: APXvYqz3vzDp/EqRx9HDfzGkrLnZLv+y4KWaqE8j9lwkdTf60XrloxM5jg1l0uiCyALiCaOjzuGTyg==
X-Received: by 2002:a65:6454:: with SMTP id s20mr8726360pgv.15.1561743182870; 
 Fri, 28 Jun 2019 10:33:02 -0700 (PDT)
Received: from localhost (220-132-236-182.HINET-IP.hinet.net.
 [220.132.236.182])
 by smtp.gmail.com with ESMTPSA id w4sm3012655pfw.97.2019.06.28.10.33.01
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 28 Jun 2019 10:33:02 -0700 (PDT)
Date: Fri, 28 Jun 2019 10:32:01 -0700
Message-Id: <20190628173227.31925-9-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190628173227.31925-1-palmer@sifive.com>
References: <20190628173227.31925-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@sifive.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.210.178
Subject: [Qemu-devel] [PULL 08/34] RISC-V: Check PMP during Page Table Walks
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
Cc: Jonathan Behrens <fintelia@gmail.com>, Palmer Dabbelt <palmer@sifive.com>,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 Hesham Almatary <Hesham.Almatary@cl.cam.ac.uk>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Hesham Almatary <Hesham.Almatary@cl.cam.ac.uk>

The PMP should be checked when doing a page table walk, and report access
fault exception if the to-be-read PTE failed the PMP check.

Suggested-by: Jonathan Behrens <fintelia@gmail.com>
Signed-off-by: Hesham Almatary <Hesham.Almatary@cl.cam.ac.uk>
Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 target/riscv/cpu.h        |  1 +
 target/riscv/cpu_helper.c | 10 +++++++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 2e743312536b..934b71c85e13 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -81,6 +81,7 @@ enum {
 #define PRIV_VERSION_1_09_1 0x00010901
 #define PRIV_VERSION_1_10_0 0x00011000
 
+#define TRANSLATE_PMP_FAIL 2
 #define TRANSLATE_FAIL 1
 #define TRANSLATE_SUCCESS 0
 #define MMU_USER_IDX 3
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 71b8123b1019..66be83210f11 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -230,6 +230,12 @@ restart:
 
         /* check that physical address of PTE is legal */
         target_ulong pte_addr = base + idx * ptesize;
+
+        if (riscv_feature(env, RISCV_FEATURE_PMP) &&
+            !pmp_hart_has_privs(env, pte_addr, sizeof(target_ulong),
+            1 << MMU_DATA_LOAD, PRV_S)) {
+            return TRANSLATE_PMP_FAIL;
+        }
 #if defined(TARGET_RISCV32)
         target_ulong pte = ldl_phys(cs->as, pte_addr);
 #elif defined(TARGET_RISCV64)
@@ -448,8 +454,10 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
         (ret == TRANSLATE_SUCCESS) &&
         !pmp_hart_has_privs(env, pa, TARGET_PAGE_SIZE, 1 << access_type,
         mode)) {
+        ret = TRANSLATE_PMP_FAIL;
+    }
+    if (ret == TRANSLATE_PMP_FAIL) {
         pmp_violation = true;
-        ret = TRANSLATE_FAIL;
     }
     if (ret == TRANSLATE_SUCCESS) {
         tlb_set_page(cs, address & TARGET_PAGE_MASK, pa & TARGET_PAGE_MASK,
-- 
2.21.0


