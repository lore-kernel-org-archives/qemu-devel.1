Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC894C31E4B
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 17:59:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B720321841
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 17:59:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xylxhynK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B720321841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53926 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbqUJ-0002d5-0K
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 13:59:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58596)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hbpqh-0005aq-3s
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 13:18:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hbpqe-00076Y-50
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 13:18:46 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:36067)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hbpqd-0006iJ-NR
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 13:18:43 -0400
Received: by mail-wr1-x444.google.com with SMTP id n4so3355415wrs.3
 for <qemu-devel@nongnu.org>; Fri, 14 Jun 2019 10:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=wTzsgKyezzklLe62p3Xhjbs91VZGkyagGHfvJN+obus=;
 b=xylxhynKuTsGMmspgASfMRRvc1v7UD0zd4h0c+eo3PIbebB7xn9FAaJXh8JnwvYJmD
 6HGmlmqRAJHss5vahRw/8MOJuhVBDwsfPTl04eytddPGkRQWqNJIhUzjW12rQSPMx5BF
 nkkzkvv7R7PHXhMOvf+tDaluFvtL5YXX4OETt9/x/+PObGv8Lq1mNDQ51VRQUMjciiWE
 No2huPuf57BqHupDU/mi56IjMO999bkKvMEPxGAbTjJEswWoJKGnBRtjQTQodr4+BrX1
 423VUIT2YIqAmK95Tcd5NlB2NWrwnGdAiB/TLX3JjuKet0XUUAJNaeTJgcrOOJ0D5JRC
 OyPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=wTzsgKyezzklLe62p3Xhjbs91VZGkyagGHfvJN+obus=;
 b=pAgk5Ein5hYdfg7kzFBjc3Y9zhKqILtgyS1ZdrNJCepKdCSoR3aUCCafncswfYzsVJ
 1Q6uEc5uNeBI5CNKcC1b/tdBQsyU/w5ambTW1ZDmkc0DSnwAx7OSFxz/NoSgkd6brwP8
 DobKJT16TD37ji3LOEj86wlBN8adOxZOUi+fLV7h9O0cMnVGXoIkiZ+sJrecqXGv7IWw
 ToN52kY+I/QhgMPE9GtxX4gG+lCmPDHHZ0hXu3TggI7WpFnb1QBnXy5/lFQskBU7vnTc
 p8OKIlU/8iNMVu34Bg+H80BjXbxcrX4eke6DMjOhXWjRLdrlMNjhWm749otUIjOcFLrg
 oLdg==
X-Gm-Message-State: APjAAAXTx+nIZdMka0K/175noDIzvWNPlsDSgRxYvQKKqNQ80PrrUX8y
 ADb1BhtF4hjaFyd8gujhQjX/ow==
X-Google-Smtp-Source: APXvYqziac+lJyzXGtAUFBDJvBVk2vyaKTBG46VV6NxopwMWSo6Fxbzg+X6VFt6+f7KLYHHhAiPWeQ==
X-Received: by 2002:a5d:4ec1:: with SMTP id s1mr13199824wrv.19.1560532712075; 
 Fri, 14 Jun 2019 10:18:32 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id g19sm4416496wmg.10.2019.06.14.10.18.28
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 14 Jun 2019 10:18:29 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 6F3FE1FF9B;
 Fri, 14 Jun 2019 18:12:01 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 14 Jun 2019 18:11:21 +0100
Message-Id: <20190614171200.21078-12-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190614171200.21078-1-alex.bennee@linaro.org>
References: <20190614171200.21078-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: [Qemu-devel] [PATCH v3 11/50] cputlb: document get_page_addr_code
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Emilio G. Cota" <cota@braap.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Suggested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 accel/tcg/cputlb.c      |  5 -----
 include/exec/exec-all.h | 24 +++++++++++++++++++++---
 2 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index bb9897b25a..3237ff4def 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1015,11 +1015,6 @@ static bool victim_tlb_hit(CPUArchState *env, size_t mmu_idx, size_t index,
   victim_tlb_hit(env, mmu_idx, index, offsetof(CPUTLBEntry, TY), \
                  (ADDR) & TARGET_PAGE_MASK)
 
-/* NOTE: this function can trigger an exception */
-/* NOTE2: the returned address is not exactly the physical address: it
- * is actually a ram_addr_t (in system mode; the user mode emulation
- * version of this function returns a guest virtual address).
- */
 tb_page_addr_t get_page_addr_code(CPUArchState *env, target_ulong addr)
 {
     uintptr_t mmu_idx = cpu_mmu_index(env, true);
diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 16034ee651..8b1c3d5b9d 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -480,7 +480,15 @@ void mmap_lock(void);
 void mmap_unlock(void);
 bool have_mmap_lock(void);
 
-static inline tb_page_addr_t get_page_addr_code(CPUArchState *env1, target_ulong addr)
+/**
+ * get_page_addr_code() - user-mode version
+ * @env: CPUArchState
+ * @addr: guest virtual address of guest code
+ *
+ * Returns @addr.
+ */
+static inline tb_page_addr_t get_page_addr_code(CPUArchState *env,
+                                                target_ulong addr)
 {
     return addr;
 }
@@ -488,8 +496,18 @@ static inline tb_page_addr_t get_page_addr_code(CPUArchState *env1, target_ulong
 static inline void mmap_lock(void) {}
 static inline void mmap_unlock(void) {}
 
-/* cputlb.c */
-tb_page_addr_t get_page_addr_code(CPUArchState *env1, target_ulong addr);
+/**
+ * get_page_addr_code() - full-system version
+ * @env: CPUArchState
+ * @addr: guest virtual address of guest code
+ *
+ * If we cannot translate and execute from the entire RAM page, or if
+ * the region is not backed by RAM, returns -1. Otherwise, returns the
+ * ram_addr_t corresponding to the guest code at @addr.
+ *
+ * Note: this function can trigger an exception.
+ */
+tb_page_addr_t get_page_addr_code(CPUArchState *env, target_ulong addr);
 
 void tlb_reset_dirty(CPUState *cpu, ram_addr_t start1, ram_addr_t length);
 void tlb_set_dirty(CPUState *cpu, target_ulong vaddr);
-- 
2.20.1


