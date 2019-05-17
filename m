Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71C10C04AB4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 04:57:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3ABE920833
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 04:57:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A3LOidZH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3ABE920833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42318 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRUwE-0002qv-F1
	for qemu-devel@archiver.kernel.org; Fri, 17 May 2019 00:57:46 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59652)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hRUqX-0006Dx-QJ
	for qemu-devel@nongnu.org; Fri, 17 May 2019 00:51:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hRUqW-0007nr-SC
	for qemu-devel@nongnu.org; Fri, 17 May 2019 00:51:53 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:46646)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hRUqW-0007n1-DA
	for qemu-devel@nongnu.org; Fri, 17 May 2019 00:51:52 -0400
Received: by mail-pg1-x543.google.com with SMTP id t187so2654838pgb.13
	for <qemu-devel@nongnu.org>; Thu, 16 May 2019 21:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=p+U5vIBnOjLXY8VPVNTFWspmy+sk8WL3JV5On5zCYGA=;
	b=A3LOidZH4y9vx21PQgSSS0/bjErJS/Ie/xxo9a1i478Q+cAvj6sy6uSoICR563JyBy
	07ex1MN89S9pLB6xc/27w32Gyd+ZFAB+8wm4FidQ300GmQNJVzbHvBdR0NQBfU/zqNNp
	PrLxN9YKvEP2fZQP2a5ayLtd7yPnT7oq6EHsDh9EOqTp6tqXW8CtnngmhtUTtz2fWEsL
	Ne4+3qKK8ZJKoTTvxkjtbrayiBTzjgHHj+xw+iwGOzqdj+K+tZlLu2LkX4HCQTCAbsty
	XCFH3S2bevvh11pHWAIG46V4TAFnPSo4+yRxYQui9nff97bKan+cCxH+/RTTZEOcfYEP
	I/aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=p+U5vIBnOjLXY8VPVNTFWspmy+sk8WL3JV5On5zCYGA=;
	b=oJTbpzkmqLPAkZZGvMFuQorWbvFcxG/bhOZf3g+98qCEcbkUzc3nXMqNmEcVQoO6j4
	h81k+mBDFb5D6RK9vm7tvHtnq5fNYCLGpR3zhQkM36S78vRJvL2FRqXgw825y24RtVYX
	mWfGVpg6o2fqM1nasTO/Z68mEpEwixfu8+ABWGLkpLjFjFzkF4HcMFyseOcAaffJOH4A
	O+sxglP5M5DfVqJvGOREtObG+c0leY2HC9dmec/SG+cXnDr17LKdthP1x3Y4y0StRxqB
	1iM60QSm7PAIWxebkHfmmNJVuH2AdRz+ZUXVfpySB1uszAqRx0KwbY3KJ5pHBhEmdIMz
	bujA==
X-Gm-Message-State: APjAAAU+ae6PRqVI/iJYNw326B6RwpjaKYGkwUPg1rEUZ4B+v6cvHHyo
	oloYqBA8nof7imI4tYXht6Tvx7lUXFI=
X-Google-Smtp-Source: APXvYqw+EVZ50tBTArIi8HDUQfpsGizrxQXuOB++jpsWrxY0fBCJ/hKMgQSUDfvBvFbGAG+vYyl+Ng==
X-Received: by 2002:a62:116:: with SMTP id 22mr20121785pfb.119.1558068711037; 
	Thu, 16 May 2019 21:51:51 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	132sm7709625pga.79.2019.05.16.21.51.49
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 16 May 2019 21:51:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu, 16 May 2019 21:51:34 -0700
Message-Id: <20190517045136.3509-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190517045136.3509-1-richard.henderson@linaro.org>
References: <20190517045136.3509-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::543
Subject: [Qemu-devel] [PATCH v14 11/13] target/rx: Convert to
 CPUClass::tlb_fill
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
Cc: philmd@redhat.com, ysato@users.sourceforge.jp
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The interface for tlb_fill has changed very recently.
Move the function into cpu.c so that it may be static
while assigning to the CPUClass methods.

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


