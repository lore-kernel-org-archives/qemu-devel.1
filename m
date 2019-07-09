Return-Path: <SRS0=huOX=VG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF0C3C606B0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 09:27:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83C49214AF
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 09:27:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PXqwmcqI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83C49214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48108 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkmP5-00058B-Qn
	for qemu-devel@archiver.kernel.org; Tue, 09 Jul 2019 05:27:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43506)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hkmJW-00072R-Oi
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 05:21:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hkmJV-00024Z-3t
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 05:21:30 -0400
Received: from mail-io1-xd44.google.com ([2607:f8b0:4864:20::d44]:34861)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hkmJS-000210-V3
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 05:21:28 -0400
Received: by mail-io1-xd44.google.com with SMTP id m24so32166341ioo.2
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2019 02:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=kUYtEVCtbbNfYNqyJu/DwHfi1v5PGfant7R2M4Nf9u8=;
 b=PXqwmcqId/ArQolYsEqS2pncOb0V2THv1ejejqPpn4Jcf0f5St0oe9uIjiBfWgC+wC
 1uc6dGyI2fnLp6ywHdLzbeTXpowSV+v9RZZCeFMOsBGjNz5rkinlxeP2FHCOhVrA9jVl
 aPfDs3zUZhBEOHY+eOohvIsoPvaQqBTd7LE3AHCF0BVd65PCUoQYA7opghOkc6DmUuS3
 zMcpjuAVr+MKUxMtHbK4opUnoE48vK1DL8vCZmd7X6YNfJBDtBLcy/s01eMWIxMwJgWl
 +rqZ3G8SqP6kgGxidc5nQ3v/slS5Zzd5KVM9098ehdEw8zdfDEG0B+o88vCd2BfSEFqI
 Y/PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=kUYtEVCtbbNfYNqyJu/DwHfi1v5PGfant7R2M4Nf9u8=;
 b=PYV56qTyGNoMX11vRMFaANKPALeVrcs3pTWpiA8R/LXN2C8N3WTOc4PTSb6qE1Z8Af
 zarcCp3OmxeUlHCRAMwRh5HVQqE274ZxPnNNfcEQJh2L0vDIgwGLyl+ACD31KlYUVK8Z
 eLtYcBfvjFSxs0Z7kWWkPakZ4njR1pxitGTcXAz3fWj2Ocyua290TNu07fvWEYhhPhou
 SIipNs/gL33f/DpjVI6Zb7NZ0xWJLvKiCsj788VpcFOgKsHm19Dkj8at4KmLcbmqddqZ
 NxxFuhs0mwxeVAaIlYCiy3tq9JGIG9Qf+Kl9Yxwa3dXE/AqjJZ/ziJJ1kx83FiRz50H1
 i2oQ==
X-Gm-Message-State: APjAAAUaphUpire/afQkrcaYt2ScO/UZ/oiriztNeHASF96Johl12BM9
 j97j1FAuNKmsiBOWrSWiG0Vh4eL6hdk=
X-Google-Smtp-Source: APXvYqwcOv4bWXLxEQ8rjMuPi/S/dIgM895kzPQcyDQIB9/e/Khg4V2UJCwE80glcXDd6PctGMa2Yg==
X-Received: by 2002:a02:6616:: with SMTP id k22mr27315822jac.100.1562664085043; 
 Tue, 09 Jul 2019 02:21:25 -0700 (PDT)
Received: from localhost.localdomain ([172.56.12.212])
 by smtp.gmail.com with ESMTPSA id c17sm17613817ioo.82.2019.07.09.02.21.20
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 09 Jul 2019 02:21:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue,  9 Jul 2019 11:20:49 +0200
Message-Id: <20190709092049.13771-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190709092049.13771-1-richard.henderson@linaro.org>
References: <20190709092049.13771-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d44
Subject: [Qemu-devel] [PATCH 5/5] tcg: Release mmap_lock on translation fault
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
Cc: lvivier@redhat.com, peter.maydell@linaro.org, alex.bennee@linaro.org,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Turn helper_retaddr into a multi-state flag that may now also
indicate when we're performing a read on behalf of the translator.
In this case, release the mmap_lock before the longjmp back to
the main cpu loop, and thereby avoid a failing assert therein.

Fixes: https://bugs.launchpad.net/qemu/+bug/1832353
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu_ldst_useronly_template.h | 20 +++++--
 accel/tcg/user-exec.c                     | 65 ++++++++++++++++-------
 2 files changed, 62 insertions(+), 23 deletions(-)

diff --git a/include/exec/cpu_ldst_useronly_template.h b/include/exec/cpu_ldst_useronly_template.h
index d663826ac2..35caae8ca6 100644
--- a/include/exec/cpu_ldst_useronly_template.h
+++ b/include/exec/cpu_ldst_useronly_template.h
@@ -64,12 +64,18 @@
 static inline RES_TYPE
 glue(glue(cpu_ld, USUFFIX), MEMSUFFIX)(CPUArchState *env, abi_ptr ptr)
 {
-#if !defined(CODE_ACCESS)
+#ifdef CODE_ACCESS
+    RES_TYPE ret;
+    set_helper_retaddr(1);
+    ret = glue(glue(ld, USUFFIX), _p)(g2h(ptr));
+    clear_helper_retaddr();
+    return ret;
+#else
     trace_guest_mem_before_exec(
         env_cpu(env), ptr,
         trace_mem_build_info(SHIFT, false, MO_TE, false));
-#endif
     return glue(glue(ld, USUFFIX), _p)(g2h(ptr));
+#endif
 }
 
 #ifndef CODE_ACCESS
@@ -90,12 +96,18 @@ glue(glue(glue(cpu_ld, USUFFIX), MEMSUFFIX), _ra)(CPUArchState *env,
 static inline int
 glue(glue(cpu_lds, SUFFIX), MEMSUFFIX)(CPUArchState *env, abi_ptr ptr)
 {
-#if !defined(CODE_ACCESS)
+#ifdef CODE_ACCESS
+    int ret;
+    set_helper_retaddr(1);
+    ret = glue(glue(ld, USUFFIX), _p)(g2h(ptr));
+    clear_helper_retaddr();
+    return ret;
+#else
     trace_guest_mem_before_exec(
         env_cpu(env), ptr,
         trace_mem_build_info(SHIFT, true, MO_TE, false));
-#endif
     return glue(glue(lds, SUFFIX), _p)(g2h(ptr));
+#endif
 }
 
 #ifndef CODE_ACCESS
diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index 4384b59a4d..5adea629de 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -64,27 +64,55 @@ static inline int handle_cpu_signal(uintptr_t pc, siginfo_t *info,
     CPUState *cpu = current_cpu;
     CPUClass *cc;
     unsigned long address = (unsigned long)info->si_addr;
-    MMUAccessType access_type;
+    MMUAccessType access_type = is_write ? MMU_DATA_STORE : MMU_DATA_LOAD;
 
-    /* We must handle PC addresses from two different sources:
-     * a call return address and a signal frame address.
-     *
-     * Within cpu_restore_state_from_tb we assume the former and adjust
-     * the address by -GETPC_ADJ so that the address is within the call
-     * insn so that addr does not accidentally match the beginning of the
-     * next guest insn.
-     *
-     * However, when the PC comes from the signal frame, it points to
-     * the actual faulting host insn and not a call insn.  Subtracting
-     * GETPC_ADJ in that case may accidentally match the previous guest insn.
-     *
-     * So for the later case, adjust forward to compensate for what
-     * will be done later by cpu_restore_state_from_tb.
-     */
-    if (helper_retaddr) {
+    switch (helper_retaddr) {
+    default:
+        /*
+         * Fault during host memory operation within a helper function.
+         * The helper's host return address, saved here, gives us a
+         * pointer into the generated code that will unwind to the
+         * correct guest pc.
+         */
         pc = helper_retaddr;
-    } else {
+        break;
+
+    case 0:
+        /*
+         * Fault during host memory operation within generated code.
+         * (Or, a unrelated bug within qemu, but we can't tell from here).
+         *
+         * We take the host pc from the signal frame.  However, we cannot
+         * use that value directly.  Within cpu_restore_state_from_tb, we
+         * assume PC comes from GETPC(), as used by the helper functions,
+         * so we adjust the address by -GETPC_ADJ to form an address that
+         * is within the call insn, so that the address does not accidentially
+         * match the beginning of the next guest insn.  However, when the
+         * pc comes fromt he signal frame it points to the actual faulting
+         * host memory insn and not a call insn.
+         *
+         * Therefore, adjust to compensate for what will be done later
+         * by cpu_restore_state_from_tb.
+         */
         pc += GETPC_ADJ;
+        break;
+
+    case 1:
+        /*
+         * Fault during host read for translation, or loosely, "execution".
+         * 
+         * The guest pc is already pointing to the start of the TB for which
+         * code is being generated.  If the guest translator manages the
+         * page crossings correctly, this is exactly the correct address
+         * (and if it doesn't there's little we can do about that here).
+         * Therefore, do not trigger the unwinder.
+         *
+         * Like tb_gen_code, release the memory lock before cpu_loop_exit.
+         */
+        pc = 0;
+        access_type = MMU_INST_FETCH;
+        mmap_unlock();
+        break;
     }
 
     /* For synchronous signals we expect to be coming from the vCPU
@@ -155,7 +183,6 @@ static inline int handle_cpu_signal(uintptr_t pc, siginfo_t *info,
     clear_helper_retaddr();
 
     cc = CPU_GET_CLASS(cpu);
-    access_type = is_write ? MMU_DATA_STORE : MMU_DATA_LOAD;
     cc->tlb_fill(cpu, address, 0, access_type, MMU_USER_IDX, false, pc);
     g_assert_not_reached();
 }
-- 
2.17.1


