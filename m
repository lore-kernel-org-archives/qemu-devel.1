Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F00EC282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 14:14:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE25D20863
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 14:14:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B/UmNJcU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE25D20863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37149 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hToUM-0001a2-4o
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 10:14:34 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46532)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hToHa-0006G8-9y
	for qemu-devel@nongnu.org; Thu, 23 May 2019 10:01:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hToHZ-0004W9-3X
	for qemu-devel@nongnu.org; Thu, 23 May 2019 10:01:22 -0400
Received: from mail-vs1-xe42.google.com ([2607:f8b0:4864:20::e42]:45553)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hToHY-0004V3-VW
	for qemu-devel@nongnu.org; Thu, 23 May 2019 10:01:21 -0400
Received: by mail-vs1-xe42.google.com with SMTP id k187so3619909vsk.12
	for <qemu-devel@nongnu.org>; Thu, 23 May 2019 07:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=YB1fZJoA1Y1wxrdEJayHVTCzPLNtdm/r4TsjTEPf7eE=;
	b=B/UmNJcUfwurBTD6GtX5T1UFo3oDrI9OrwB33nF75S8mgqcvqfX3UiVKP44FXt5k26
	HM0h9BNes+T/SMLulrdNgGcj0Bi/KkMfqLXoEoM6YH1oQPQDw5r22DjMP+MxpvKbGVZV
	wcr7bfoNvGxihu4BD0af04Gy0SZMOuRZEAsoyo71jKy02ikihniIfWrd1oAWpyUfUXtF
	J6yJfZfwWHnbaN129rNak1qpNIFrtxCswSEC5J+qgmgrrzomIK18lDsWb0HpmUX3cJl0
	dWA5nzeremXvnhcWkFmiOYV9uDmLomV4iFM/01ihwKdt/xCDP2vDjoe2XLb0D60PGFk5
	yRjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=YB1fZJoA1Y1wxrdEJayHVTCzPLNtdm/r4TsjTEPf7eE=;
	b=q3cgk/lYWYUDvm7+i5E4nzf9gBqoXcfkZfM1Uby3H9bVG9RsMIo8FMmSWfh5AAo9i2
	Dr0lj7MmlBzc0dS6D5JynFdY7zfMWPMzgtTyrpMhtDrt2kAW2SR0Zi82iXGcPeIQH/eG
	h/y3xp8prpZR3KUJQMrqbpvsn896hzpiACQwjgD14fwrn1sRtdXZCcW+oUYFXySAoVvy
	u4F67i31kEvtGiy0rO45LptbCp8mXcWPcm62fvS10cIldDOlLZrGLHZR9lAQvoEwf6KQ
	zBeOEAlFAu7eXJJfTfp8LkwEQ63Qe84U5hYJC4SA2cBctjHTkYhWQzlQ1wh4vBkz/l9x
	IiXg==
X-Gm-Message-State: APjAAAUX38+6+i29URhkt24URvD6gj26K1kjBVWQzaqyzvE7G+Nch4nK
	WWTPaw7e8FjjCEStNMrIop59PX+oOB1W/Q==
X-Google-Smtp-Source: APXvYqxhULkviZp694FyBkD2NCrAQL/q/tTKWrcvcGgDtX3+iS59p6ZrLWszLRLF7B30vbv+caIy6A==
X-Received: by 2002:a67:eb82:: with SMTP id e2mr45758309vso.13.1558620079920; 
	Thu, 23 May 2019 07:01:19 -0700 (PDT)
Received: from localhost.localdomain (ip-173-130-215-183.orldfl.spcsdns.net.
	[173.130.215.183]) by smtp.gmail.com with ESMTPSA id
	v133sm1984166vkv.5.2019.05.23.07.01.18
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 23 May 2019 07:01:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu, 23 May 2019 10:00:57 -0400
Message-Id: <20190523140059.18548-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190523140059.18548-1-richard.henderson@linaro.org>
References: <20190523140059.18548-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::e42
Subject: [Qemu-devel] [PULL 11/13] target/rx: Convert to CPUClass::tlb_fill
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

The interface for tlb_fill has changed very recently.
Move the function into cpu.c so that it may be static
while assigning to the CPUClass methods.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/rx/cpu.c       | 14 ++++++++++++++
 target/rx/op_helper.c | 11 -----------
 2 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/target/rx/cpu.c b/target/rx/cpu.c
index 4b96f2e463..3268077d08 100644
--- a/target/rx/cpu.c
+++ b/target/rx/cpu.c
@@ -143,6 +143,19 @@ static void rx_cpu_disas_set_info(CPUState *cpu, disassemble_info *info)
     info->print_insn = print_insn_rx;
 }
 
+static bool rx_cpu_tlb_fill(CPUState *cs, vaddr addr, int size,
+                            MMUAccessType access_type, int mmu_idx,
+                            bool probe, uintptr_t retaddr)
+{
+    uint32_t address, physical, prot;
+
+    /* Linear mapping */
+    address = physical = addr & TARGET_PAGE_MASK;
+    prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
+    tlb_set_page(cs, address, physical, prot, mmu_idx, TARGET_PAGE_SIZE);
+    return true;
+}
+
 static void rx_cpu_init(Object *obj)
 {
     CPUState *cs = CPU(obj);
@@ -177,6 +190,7 @@ static void rxcpu_class_init(ObjectClass *klass, void *data)
     cc->get_phys_page_debug = rx_cpu_get_phys_page_debug;
     cc->disas_set_info = rx_cpu_disas_set_info;
     cc->tcg_initialize = rx_translate_init;
+    cc->tlb_fill = rx_cpu_tlb_fill;
 
     cc->gdb_num_core_regs = 26;
 }
diff --git a/target/rx/op_helper.c b/target/rx/op_helper.c
index 9a460070e9..fb7ae3c3ec 100644
--- a/target/rx/op_helper.c
+++ b/target/rx/op_helper.c
@@ -468,14 +468,3 @@ void QEMU_NORETURN helper_rxbrk(CPURXState *env)
 {
     raise_exception(env, 0x100, 0);
 }
-
-void tlb_fill(CPUState *cs, target_ulong addr, int size,
-              MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
-{
-    uint32_t address, physical, prot;
-
-    /* Linear mapping */
-    address = physical = addr & TARGET_PAGE_MASK;
-    prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
-    tlb_set_page(cs, address, physical, prot, mmu_idx, TARGET_PAGE_SIZE);
-}
-- 
2.17.1


