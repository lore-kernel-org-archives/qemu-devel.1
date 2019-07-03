Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4A55C06511
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 08:51:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91B7D218A4
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 08:51:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91B7D218A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33754 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiazL-0006vw-Lf
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 04:51:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51244)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <palmer@dabbelt.com>) id 1hiapS-0005gX-ER
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 04:41:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1hiapR-0006bu-Bk
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 04:41:26 -0400
Received: from mail-lf1-f43.google.com ([209.85.167.43]:46899)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1hiapR-0006Yq-4j
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 04:41:25 -0400
Received: by mail-lf1-f43.google.com with SMTP id z15so1131569lfh.13
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2019 01:41:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:cc:from:to;
 bh=dzPUzTIkHxzJQoxigOG9F6jOZkqkITw8eDaqBssKL50=;
 b=Blh7DQ2cYKyUnb8vzO/t3/mqwh/tAJY6NyYvgL+1dBCsyxY0OsyWr/26v7CfxthBTz
 0f0Znt0uiE/u7Aa+Ru3EzKVjjBMo0ovEEO1n77ftYvY4p+6cmukbSrbVC2t65kZyTHz4
 EqgSf2V8G7MKKnuTI2wdXozOanwjUT9KGM/tXa0HLrdIuIUA/wOe1+K0fU1JGMKcLQ+e
 y4TiB5ROv3MqVzbueeeYxmj2FdMVtKDcaBtgnyfwVn0SwmrL9wH47pNeGleg6IaD7mya
 JvkJtbK6zy61DznHc14asGmwCYiokkSakvQc7ugt3DN7jvbBkjIM+Or5pZxHXwyT9xPw
 Bh/A==
X-Gm-Message-State: APjAAAXXsLBFCgwZConLyHQhztcqFiWI9xB0sckniMLxDl0I1889dDCE
 T1u5viqLgtKOXuA5DFbzi9ndNDMYtgg0Cg==
X-Google-Smtp-Source: APXvYqwLmq9ga6+zRwZtr10y42bkJHzDWQxXSTvT9gd7QaclDaEz+7p88BjxmSnFpQuIoHHEgJOxGg==
X-Received: by 2002:a05:6512:1d2:: with SMTP id
 f18mr16873535lfp.173.1562143283232; 
 Wed, 03 Jul 2019 01:41:23 -0700 (PDT)
Received: from localhost ([134.17.27.127])
 by smtp.gmail.com with ESMTPSA id t28sm291190lfp.69.2019.07.03.01.41.22
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 03 Jul 2019 01:41:22 -0700 (PDT)
Date: Wed,  3 Jul 2019 01:40:24 -0700
Message-Id: <20190703084048.6980-9-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190703084048.6980-1-palmer@sifive.com>
References: <20190703084048.6980-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@sifive.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.167.43
Subject: [Qemu-devel] [PULL 08/32] RISC-V: Check PMP during Page Table Walks
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


