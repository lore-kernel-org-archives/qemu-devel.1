Return-Path: <SRS0=hY9S=T7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A895C04AB6
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 14:01:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 159B5269F3
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 14:01:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ClBMu1OW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 159B5269F3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44053 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWi5w-0004Yt-Bn
	for qemu-devel@archiver.kernel.org; Fri, 31 May 2019 10:01:20 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34508)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hWhoo-0007To-92
	for qemu-devel@nongnu.org; Fri, 31 May 2019 09:43:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hWhon-0000MH-6d
	for qemu-devel@nongnu.org; Fri, 31 May 2019 09:43:38 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:36236)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hWhon-0000Ld-1k
	for qemu-devel@nongnu.org; Fri, 31 May 2019 09:43:37 -0400
Received: by mail-oi1-x244.google.com with SMTP id y124so7752308oiy.3
	for <qemu-devel@nongnu.org>; Fri, 31 May 2019 06:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=YB1fZJoA1Y1wxrdEJayHVTCzPLNtdm/r4TsjTEPf7eE=;
	b=ClBMu1OWQAARMpVvZL7Q/VGJg+5q+D9y3XnpQ4py2CUIPPLS/RsNpHLuzJY3z4d34r
	NjuKP7scorreohOVQ6P+mboO7UKOvNHq/1XhFiQaA22Sba2Oyo6Cx2W0HOAGlp/KJxo/
	3TCeH4ydSzBVYgEmLTjqjcuUK9HgrMqn8R2xYoOdMCErSugO9J2dxwddwVtJeVBSSl6N
	mqKsLBb1DAVl6b54BOk4TPNw6KG61B5k7IxJlCj+ruAupyGGcMZdCgyksIsfVN6HdIad
	NNY0X95N+KLzdtYpPCIldKyFXzmlfFH5s7OMqBI0t02YxhSJlcxALS4M77cWf1Uyb4gB
	l+cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=YB1fZJoA1Y1wxrdEJayHVTCzPLNtdm/r4TsjTEPf7eE=;
	b=RnjKwI37gjeDPAVZzZbCDdi39cj/hAKYP0O0uQ3Mpi3rjJPajQ2B4FUmQaPzsMGp0+
	voTS0evbg1dCeQ2wjVaRNC/j9+xOx9XRIxvT9X2yFY/bPjVd2WUXMNGBcgvk8Tl6PRc4
	/NxWzeMBORG48uFd4T2zu1xVRw39jfRZlfDvcB391g598rVUDznMyMsph82es/84vHhA
	1jiWRqBpmp0mkTd0OBb3AzyasQd//Rfi4ahQeAaXnrRRuTsId7nDL2Tk/ApDf9lpAgUw
	O3QvEJDYJd4S5guv57Fo/PjR31SHFI+uhk9eEb64h9ShFEGil63EWGDz0YmgjVTi0pjX
	rbvQ==
X-Gm-Message-State: APjAAAUf1WUnMacKv2EQ9LvznSmx+52RrZWTexKx8+PHqX7FwrHqRze2
	smVN1zQ9J62X+WHYeIXVYEfBKb0laVIWQQ==
X-Google-Smtp-Source: APXvYqzsxQPFvQF8Wc6c8OICS2Sdxq9j2iTGBCkTTw9L3NJs5WIG91t2dN1yIClJ+aC50u7pweV3ng==
X-Received: by 2002:aca:b444:: with SMTP id d65mr670402oif.102.1559310216164; 
	Fri, 31 May 2019 06:43:36 -0700 (PDT)
Received: from localhost.localdomain (168.189-204-159.bestelclientes.com.mx.
	[189.204.159.168]) by smtp.gmail.com with ESMTPSA id
	r23sm2391176otg.49.2019.05.31.06.43.35
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 31 May 2019 06:43:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 31 May 2019 08:43:03 -0500
Message-Id: <20190531134315.4109-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190531134315.4109-1-richard.henderson@linaro.org>
References: <20190531134315.4109-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::244
Subject: [Qemu-devel] [PATCH v16 11/23] target/rx: Convert to
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


