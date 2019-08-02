Return-Path: <SRS0=8V6M=V6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 812D2C32750
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 16:07:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B7F42087C
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 16:07:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WGKr7PSD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B7F42087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36190 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hta5q-0002Qb-H3
	for qemu-devel@archiver.kernel.org; Fri, 02 Aug 2019 12:07:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60585)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hta3H-0006qu-G6
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 12:05:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hta3F-00024k-Ic
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 12:05:07 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:39042)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hta3F-00020Q-BS
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 12:05:05 -0400
Received: by mail-wr1-x444.google.com with SMTP id x4so24556629wrt.6
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2019 09:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=/Si04CZi+jPrI1hrdsqdiLuVY6itlYimxkl7cUi4ico=;
 b=WGKr7PSD52mgAK/eb/wMJYPIoWSJJECDPjLr634XMTcCFkbqZ8MJFRTHAQRYmIkyyz
 IE/+v/Hb87d0uIjEJo/3FbIBp8wYfFxVeqDUkc1zda8ExJrX0D27EvBQcjCesko/SlnY
 ENIqDQ0bkHpKK/3CiaM6eBSRFoWFjhOzT47STksAPlu08XKf4SW/wt5vqRhy4tKKF1nX
 jAdXriw+Qzz5sg499Z+rfe4L5NyqeM47kCW1El0zCJ15C8GOuAK/UGWbou3Tb+yQYdhJ
 GgVU9GE1eHryoapvorYGkWOxfDKYUn1f5p/o7ktg2fIo/NOsZt1kDaz1/Usj93r8adlc
 ysBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/Si04CZi+jPrI1hrdsqdiLuVY6itlYimxkl7cUi4ico=;
 b=cjActQfue150wzfQL//8nWjAqqKDmOqM2Y8xKmlGy31bo1GELo5wQUYhOisEui8wJ7
 BNJAhtnWL/pASNOAzjlMEGhUX040pPzTMiLVgl7SadFHPdxEevfrfefF7syM4hJjiyGY
 aeQbl90gvQRT6r6tzCx0CjoEPdFWjko5YGPkS0lWJuaUB6tKh7p54TW7JixAgrpl1NbG
 UjltHgtVMzq5QqPfw+V6R5QZDSi/askxOG1aRn65J67p+yDyv6D3Xdz+lfgghCD1YSkz
 HvOfaBcXEldXJzZGymIupg5RWidlqGtDtotX5Dmsiv6h4b+O98JnMq2bBO2bs1banmU5
 Yk8g==
X-Gm-Message-State: APjAAAVclV1ekmK7ZwG/0U+qk8c6e1naksBDCQCIDFbkllPkgp78vHQ1
 N+a4piXYtBBlT4l5KxDNt5YLZUpR8RsGnw==
X-Google-Smtp-Source: APXvYqyTnue+ZR3YWHXE91hVIOGkHLsoXf5oYfCT8TtzIUJiDqZyGvEBUNoe3u2Eg8KDNRzlPyXReg==
X-Received: by 2002:a5d:6583:: with SMTP id q3mr10467702wru.184.1564761904164; 
 Fri, 02 Aug 2019 09:05:04 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id o7sm66200171wmf.43.2019.08.02.09.05.02
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 02 Aug 2019 09:05:03 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri,  2 Aug 2019 17:04:57 +0100
Message-Id: <20190802160458.25681-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190802160458.25681-1-peter.maydell@linaro.org>
References: <20190802160458.25681-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: [Qemu-devel] [PATCH 2/3] target/mips: Switch to
 do_transaction_failed() hook
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
Cc: Aleksandar Rikalo <arikalo@wavecomp.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Switch the MIPS target from the old unassigned_access hook to the new
do_transaction_failed hook.

Unlike the old hook, do_transaction_failed is only ever called from
the TCG memory access paths, so there is no need for the "ignore this
if we're using KVM" hack that we were previously using to work around
the way unassigned_access was called for all kinds of memory accesses
to unassigned physical addresses.

The MIPS target does not ever do direct memory reads by physical
address (via either ldl_phys etc or address_space_ldl etc), so the
only memory accesses this affects are the 'normal' guest loads and
stores, which will be handled by the new hook; their behaviour is
unchanged.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/mips/internal.h  |  8 +++++---
 target/mips/cpu.c       |  2 +-
 target/mips/op_helper.c | 24 ++++++++----------------
 3 files changed, 14 insertions(+), 20 deletions(-)

diff --git a/target/mips/internal.h b/target/mips/internal.h
index b2b41a51ab4..26533bb937d 100644
--- a/target/mips/internal.h
+++ b/target/mips/internal.h
@@ -138,9 +138,11 @@ void r4k_helper_tlbinv(CPUMIPSState *env);
 void r4k_helper_tlbinvf(CPUMIPSState *env);
 void r4k_invalidate_tlb(CPUMIPSState *env, int idx, int use_extra);
 
-void mips_cpu_unassigned_access(CPUState *cpu, hwaddr addr,
-                                bool is_write, bool is_exec, int unused,
-                                unsigned size);
+void mips_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
+                                    vaddr addr, unsigned size,
+                                    MMUAccessType access_type,
+                                    int mmu_idx, MemTxAttrs attrs,
+                                    MemTxResult response, uintptr_t retaddr);
 hwaddr cpu_mips_translate_address(CPUMIPSState *env, target_ulong address,
                                   int rw);
 #endif
diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index 39eafafc5cd..a79badcb1a6 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -197,7 +197,7 @@ static void mips_cpu_class_init(ObjectClass *c, void *data)
     cc->gdb_read_register = mips_cpu_gdb_read_register;
     cc->gdb_write_register = mips_cpu_gdb_write_register;
 #ifndef CONFIG_USER_ONLY
-    cc->do_unassigned_access = mips_cpu_unassigned_access;
+    cc->do_transaction_failed = mips_cpu_do_transaction_failed;
     cc->do_unaligned_access = mips_cpu_do_unaligned_access;
     cc->get_phys_page_debug = mips_cpu_get_phys_page_debug;
     cc->vmsd = &vmstate_mips_cpu;
diff --git a/target/mips/op_helper.c b/target/mips/op_helper.c
index 9e2e02f8586..65ff9f5b935 100644
--- a/target/mips/op_helper.c
+++ b/target/mips/op_helper.c
@@ -2666,27 +2666,19 @@ void mips_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
     do_raise_exception_err(env, excp, error_code, retaddr);
 }
 
-void mips_cpu_unassigned_access(CPUState *cs, hwaddr addr,
-                                bool is_write, bool is_exec, int unused,
-                                unsigned size)
+void mips_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
+                                    vaddr addr, unsigned size,
+                                    MMUAccessType access_type,
+                                    int mmu_idx, MemTxAttrs attrs,
+                                    MemTxResult response, uintptr_t retaddr)
 {
     MIPSCPU *cpu = MIPS_CPU(cs);
     CPUMIPSState *env = &cpu->env;
 
-    /*
-     * Raising an exception with KVM enabled will crash because it won't be from
-     * the main execution loop so the longjmp won't have a matching setjmp.
-     * Until we can trigger a bus error exception through KVM lets just ignore
-     * the access.
-     */
-    if (kvm_enabled()) {
-        return;
-    }
-
-    if (is_exec) {
-        raise_exception(env, EXCP_IBE);
+    if (access_type == MMU_INST_FETCH) {
+        do_raise_exception(env, EXCP_IBE, retaddr);
     } else {
-        raise_exception(env, EXCP_DBE);
+        do_raise_exception(env, EXCP_DBE, retaddr);
     }
 }
 #endif /* !CONFIG_USER_ONLY */
-- 
2.20.1


