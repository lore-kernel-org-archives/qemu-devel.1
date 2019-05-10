Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CF73C04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 15:32:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35D3320578
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 15:32:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="goUfrrA5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35D3320578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45154 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hP7Vb-0002et-G4
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 11:32:30 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56417)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hP7Ju-0007wK-QP
	for qemu-devel@nongnu.org; Fri, 10 May 2019 11:20:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hP7Jt-0000Op-Iq
	for qemu-devel@nongnu.org; Fri, 10 May 2019 11:20:22 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f]:38936)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hP7Jt-0000Nf-5l
	for qemu-devel@nongnu.org; Fri, 10 May 2019 11:20:21 -0400
Received: by mail-pf1-x42f.google.com with SMTP id z26so3404852pfg.6
	for <qemu-devel@nongnu.org>; Fri, 10 May 2019 08:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=7X2wC9JBm7qMTyCvU+ISYeQpejo5eFPlqgIZBbqHM2A=;
	b=goUfrrA5ptbRhNJDtaBMtPoxIclyf6WBGBDfsj/cJY20s9UONh7GTzGz29b5Lk5Yxu
	DcIr5Cy8gI1ihqMk1DtCdoCbX4BTClo5WUAcq5SuWHReLLMGwwSTVO8oifERrc3FHUy4
	wScpPbviW1oIq/YJxwlcb57o+9i463knNndCabbGQn3a926SfwtNFLhJLZroiYNEBP87
	bobuQm3dELibYIIsu37NJd5hlvOs+vO+XVhxDPtSLvsPwbe8UEOCZNGNDq5dHvU4ShCG
	5D7M4EJudBq173YlLWd1yrGif7tUNh1MNJbEYnj+ZQ54BRhgXLZqZN7+HarxUK79iVMG
	3nCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=7X2wC9JBm7qMTyCvU+ISYeQpejo5eFPlqgIZBbqHM2A=;
	b=uBgiWnv4ygpwRZ2246f+6qjxjCkQjfYJlmfHHRZu9GSs1AOe71KwFHu/yq7LpjPlea
	O8AYgI9nm7UZdluZo5kkf8E9lY6Xp3OdLAadrpbLjkjBt02MLDH/vv4J4Qn+EOvY+7V3
	YuHbXYuurQ+0a9Y7yAASdjcMkZSDb+SYiqiL9HZlQ9s5qT6qD4rttjNfjP5qw/N2TAHN
	JA8XrWcgPQoCA58bZQmdMeQ1yvHcqYBdLCu0o5foXTK8fkjAMAfvmsFmGo03q/yf1Cq1
	hI+p2DF24ud3yK6OadLGnM1zULva6iSk12qhJXU7zG5AD8BL0astwPNt3K0thdbR/EGx
	VfNg==
X-Gm-Message-State: APjAAAWhVYrOKpfvWkDdcnllCsORucZjdBj/tPh61IHgES3wjn78YPtP
	qc6CChPGspW8LWOJI1PBBRK0ylYuk7k=
X-Google-Smtp-Source: APXvYqwnAwwuV/FQjVmSz9u0CmPf6aFLlv72RgmaIiAJrkaTbW4qS0HKTvyPNBEvvwSnyK/Aho0WPw==
X-Received: by 2002:a63:7909:: with SMTP id u9mr9501616pgc.223.1557501619730; 
	Fri, 10 May 2019 08:20:19 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231])
	by smtp.gmail.com with ESMTPSA id 19sm5920517pgz.24.2019.05.10.08.20.18
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 10 May 2019 08:20:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 10 May 2019 08:19:43 -0700
Message-Id: <20190510151944.22981-27-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190510151944.22981-1-richard.henderson@linaro.org>
References: <20190510151944.22981-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::42f
Subject: [Qemu-devel] [PULL 26/27] tcg: Remove CPUClass::handle_mmu_fault
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This hook is now completely replaced by tlb_fill.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/qom/cpu.h     |  3 ---
 accel/tcg/user-exec.c | 13 +++----------
 2 files changed, 3 insertions(+), 13 deletions(-)

diff --git a/include/qom/cpu.h b/include/qom/cpu.h
index c1f267b4e0..32983f27c3 100644
--- a/include/qom/cpu.h
+++ b/include/qom/cpu.h
@@ -117,7 +117,6 @@ struct TranslationBlock;
  *       This always includes at least the program counter; some targets
  *       will need to do more. If this hook is not implemented then the
  *       default is to call @set_pc(tb->pc).
- * @handle_mmu_fault: Callback for handling an MMU fault.
  * @tlb_fill: Callback for handling a softmmu tlb miss or user-only
  *       address fault.  For system mode, if the access is valid, call
  *       tlb_set_page and return true; if the access is invalid, and
@@ -195,8 +194,6 @@ typedef struct CPUClass {
                                Error **errp);
     void (*set_pc)(CPUState *cpu, vaddr value);
     void (*synchronize_from_tb)(CPUState *cpu, struct TranslationBlock *tb);
-    int (*handle_mmu_fault)(CPUState *cpu, vaddr address, int size, int rw,
-                            int mmu_index);
     bool (*tlb_fill)(CPUState *cpu, vaddr address, int size,
                      MMUAccessType access_type, int mmu_idx,
                      bool probe, uintptr_t retaddr);
diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index 199f88c826..8cfbeb1b56 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -63,7 +63,6 @@ static inline int handle_cpu_signal(uintptr_t pc, siginfo_t *info,
 {
     CPUState *cpu = current_cpu;
     CPUClass *cc;
-    int ret;
     unsigned long address = (unsigned long)info->si_addr;
     MMUAccessType access_type;
 
@@ -156,15 +155,9 @@ static inline int handle_cpu_signal(uintptr_t pc, siginfo_t *info,
     helper_retaddr = 0;
 
     cc = CPU_GET_CLASS(cpu);
-    if (cc->tlb_fill) {
-        access_type = is_write ? MMU_DATA_STORE : MMU_DATA_LOAD;
-        cc->tlb_fill(cpu, address, 0, access_type, MMU_USER_IDX, false, pc);
-        g_assert_not_reached();
-    } else {
-        ret = cc->handle_mmu_fault(cpu, address, 0, is_write, MMU_USER_IDX);
-        g_assert(ret > 0);
-        cpu_loop_exit_restore(cpu, pc);
-    }
+    access_type = is_write ? MMU_DATA_STORE : MMU_DATA_LOAD;
+    cc->tlb_fill(cpu, address, 0, access_type, MMU_USER_IDX, false, pc);
+    g_assert_not_reached();
 }
 
 #if defined(__i386__)
-- 
2.17.1


