Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 997DEC432C2
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 19:09:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DB1F21D79
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 19:09:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S0QUhfur"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DB1F21D79
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDCfU-0000K6-Av
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 15:09:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47322)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iDCIu-00021d-WC
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 14:46:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iDCIs-0004X3-4l
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 14:46:20 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630]:34827)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iDCIq-0004VA-3D
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 14:46:16 -0400
Received: by mail-pl1-x630.google.com with SMTP id y10so2936307plp.2
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 11:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Eck7z4xU6rWZDIf+jUdftaZDf15l360hvN4eD+K3cX0=;
 b=S0QUhfurjE0ohyg7NT/RKXb3JlbA3RVowbnV81ytUzRzUMh+Jxu4ilASjWByY9HigY
 HPySyI2KtyBf9V8sCG0xP3OXjt5qWsNYO69pZ5pM9yUbbd5VSsaBxHHRDZUprFk7Kgfj
 cqA/GoYK0RAzynx5LlV38k74W4hJ8g5u5Q1M+dsKx8Bri2LtWhkPvb7jg/OaNr0+AHFz
 0z1JBZHQ+TzRCJ9oxqxBXQ8kmkdU18lmv1612iqwnejBlMGV4ZmbuA8tMWweJEvVlrZl
 pBqHtojT2n5dAcSwfBJbFQn8BsSBo+sUk1jxyRv92pKSV2Hb0IwwXqulP+T9HPAHNzuq
 9v7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Eck7z4xU6rWZDIf+jUdftaZDf15l360hvN4eD+K3cX0=;
 b=FY+gjpLmRL5yRMQY0yKicXU6HGMjIeF4U2KNOryOE+OahOR428Orv2t241oc/fiDOo
 t5kAAgnBVVzeA2ND/TMyFGO73sOtovkV4OMQkDlM+UfmkNoH+0hixMiAFNu0AYcikZaF
 VSdDjWCNeCVaIcAnfbVR7j9JMQjyc7GcYXstYW9Pj+zVDNlqrbtnBc18+NS860THr+JH
 ItRa84qA5e7thyU0YxzqdAxEyprov/XLkOZRnHdJVmpms+5Ny0ixor+XacInQLUJneJo
 c5RkOfX5Xn7gk7eXGzniTasqxzjh2UHueow7mI+VxNvmGbROV/QvVXRjPRPae/BMesCU
 p/cA==
X-Gm-Message-State: APjAAAUjwKuq9MCs5znhXxI815gPrlPBroFYIfqhUMqDv13FxXsBh8Ww
 nQv5K7dXhYJizfbRDuy/mxUFY0OXRAs=
X-Google-Smtp-Source: APXvYqzXa1RyyUxY3xwA6SKOhSea/TiWF0IPWqBS5YVtCF+0uIG3puPp5LAEsUVnY0hX4rMqXdwg2A==
X-Received: by 2002:a17:902:654a:: with SMTP id
 d10mr10653303pln.199.1569437173816; 
 Wed, 25 Sep 2019 11:46:13 -0700 (PDT)
Received: from localhost.localdomain ([12.206.46.61])
 by smtp.gmail.com with ESMTPSA id l24sm6133229pff.151.2019.09.25.11.46.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Sep 2019 11:46:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 16/16] cputlb: Pass retaddr to tb_check_watchpoint
Date: Wed, 25 Sep 2019 11:45:48 -0700
Message-Id: <20190925184548.30673-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190925184548.30673-1-richard.henderson@linaro.org>
References: <20190925184548.30673-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::630
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fixes the previous TLB_WATCHPOINT patches because we are currently
failing to set cpu->mem_io_pc with the call to cpu_check_watchpoint.
Pass down the retaddr directly because it's readily available.

Fixes: 50b107c5d61
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/translate-all.h | 2 +-
 accel/tcg/translate-all.c | 6 +++---
 exec.c                    | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/accel/tcg/translate-all.h b/accel/tcg/translate-all.h
index 135c1ea96a..a557b4e2bb 100644
--- a/accel/tcg/translate-all.h
+++ b/accel/tcg/translate-all.h
@@ -30,7 +30,7 @@ void tb_invalidate_phys_page_fast(struct page_collection *pages,
                                   tb_page_addr_t start, int len,
                                   uintptr_t retaddr);
 void tb_invalidate_phys_page_range(tb_page_addr_t start, tb_page_addr_t end);
-void tb_check_watchpoint(CPUState *cpu);
+void tb_check_watchpoint(CPUState *cpu, uintptr_t retaddr);
 
 #ifdef CONFIG_USER_ONLY
 int page_unprotect(target_ulong address, uintptr_t pc);
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index db77fb221b..66d4bc4341 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -2142,16 +2142,16 @@ static bool tb_invalidate_phys_page(tb_page_addr_t addr, uintptr_t pc)
 #endif
 
 /* user-mode: call with mmap_lock held */
-void tb_check_watchpoint(CPUState *cpu)
+void tb_check_watchpoint(CPUState *cpu, uintptr_t retaddr)
 {
     TranslationBlock *tb;
 
     assert_memory_lock();
 
-    tb = tcg_tb_lookup(cpu->mem_io_pc);
+    tb = tcg_tb_lookup(retaddr);
     if (tb) {
         /* We can use retranslation to find the PC.  */
-        cpu_restore_state_from_tb(cpu, tb, cpu->mem_io_pc, true);
+        cpu_restore_state_from_tb(cpu, tb, retaddr, true);
         tb_phys_invalidate(tb, -1);
     } else {
         /* The exception probably happened in a helper.  The CPU state should
diff --git a/exec.c b/exec.c
index b3df826039..8a0a6613b1 100644
--- a/exec.c
+++ b/exec.c
@@ -2758,7 +2758,7 @@ void cpu_check_watchpoint(CPUState *cpu, vaddr addr, vaddr len,
                 cpu->watchpoint_hit = wp;
 
                 mmap_lock();
-                tb_check_watchpoint(cpu);
+                tb_check_watchpoint(cpu, ra);
                 if (wp->flags & BP_STOP_BEFORE_ACCESS) {
                     cpu->exception_index = EXCP_DEBUG;
                     mmap_unlock();
-- 
2.17.1


