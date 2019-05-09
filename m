Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B890C04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 06:23:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB85620656
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 06:23:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PMDZDgJS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB85620656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48858 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOcSW-0007rM-31
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 02:23:12 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45167)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOc9O-0006NP-UC
	for qemu-devel@nongnu.org; Thu, 09 May 2019 02:03:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOc9N-0007KO-R0
	for qemu-devel@nongnu.org; Thu, 09 May 2019 02:03:26 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:38106)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hOc9L-0007Is-Sl
	for qemu-devel@nongnu.org; Thu, 09 May 2019 02:03:24 -0400
Received: by mail-pf1-x444.google.com with SMTP id 10so723744pfo.5
	for <qemu-devel@nongnu.org>; Wed, 08 May 2019 23:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=7X2wC9JBm7qMTyCvU+ISYeQpejo5eFPlqgIZBbqHM2A=;
	b=PMDZDgJS+ftwQFG5gEFlapiKiC2l0aUNd+S2Lo12qd8qOfryT/Ina8h9RpXT9ndLfE
	uZs8fRo2Cp1lOpBx30MHHPEg2ZyFl8Nsh8WQ+WKkem3u6ZHyVrsGq/N12LhyHTAekki2
	Ad0Rww6H+YssAgxiUAHlMAZ1PA+wInv27e+cC7e1SiuStGhokKcnM0AT6Zt2xCev4gKh
	hn5/mbJf3tVmfGqdGTe00aspAdpxFzjN4ePPE8gSgavVDM50MO3zTAmp23RhzIKZQ1Do
	QKxX2wn1bwrln1bI/qQcQtp7Mf/S2X0esRBiyVAfssjU6Z8s2wH7wn/NVhiYwfrpyHLu
	vDfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=7X2wC9JBm7qMTyCvU+ISYeQpejo5eFPlqgIZBbqHM2A=;
	b=pu7XsDrQoFTltiRx+6BBxvTQHnN1inR8euuBcBHfOoAq+vSNhjF4B+COvCUDBKHmXU
	tfUxa8YiB3MaFH9CmGEXBWA9YF9W9+QYTz5Mp19MK82s0RN22c22m4CzA9jc1I9XryZn
	exnjfAXfOjA9VlLKYxAB8qhTiwwRt+jLQBEcoVPeas7F+q9oNQnPlQjYZKniMJrCIOkY
	Lh/QfJ4j+hV2/5NTivXeHnEKVdqnq5Ox+Whutr2M931vZTWE79aXXorKSDp2TQuTaczz
	hc6pcJoIHeqTRQTZ5gozV0pn/iBco6Yrc6XPpLUNrkRBvksUWR0gkm99u4OqqbYegIVE
	fYOQ==
X-Gm-Message-State: APjAAAXiXGebZr/XuIFY63v/zFrTN7InHUsAGNm9iWvf3MM/YJyd/TMc
	wltOAb7Oo8coNaVFD4BuLVNyvgu/dDI=
X-Google-Smtp-Source: APXvYqyeQuIka00tjV2MtM8c4C1lJ234AVr/YP+ePPvVgsczDBrjHX5JW0zhtlFiXnpZ6/BZwHMlXw==
X-Received: by 2002:aa7:810e:: with SMTP id b14mr2654937pfi.112.1557381802283; 
	Wed, 08 May 2019 23:03:22 -0700 (PDT)
Received: from localhost.localdomain (97-113-27-95.tukw.qwest.net.
	[97.113.27.95])
	by smtp.gmail.com with ESMTPSA id n7sm1496109pff.45.2019.05.08.23.03.21
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 08 May 2019 23:03:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed,  8 May 2019 23:02:45 -0700
Message-Id: <20190509060246.4031-27-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190509060246.4031-1-richard.henderson@linaro.org>
References: <20190509060246.4031-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::444
Subject: [Qemu-devel] [PATCH v2 26/27] tcg: Remove CPUClass::handle_mmu_fault
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


