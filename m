Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A7D3C352AA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 17:21:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4557920842
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 17:21:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y++m4a4L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4557920842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45660 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFLpu-0005vG-9b
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 13:21:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32860)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iFLlH-0001bX-2m
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 13:16:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iFLlF-0005Xa-GJ
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 13:16:30 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f]:39022)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iFLlF-0005Ww-8l
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 13:16:29 -0400
Received: by mail-pl1-x62f.google.com with SMTP id s17so5790433plp.6
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2019 10:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=X3LTmFzczfRxgo2AFbnOMhu+tfZBTFunSRj9qIKUaA8=;
 b=y++m4a4LsN9HqKBbgoDaKR6bVsjnSYyEWUPNSHHDAZw/oIDeBtkTZM7gCDtIh9JOZP
 h32CQpDZg/ptsWgVBysFUyd+kp4yUshCXOY2YfKtze904sDficR/HwphFTXNQ142YLif
 ThkU7AvNzbJPxL+zEt1h9xbXk2IqV2cLT9muI84R8ZIncT1Og4BPeK9HYPgJ6ZgZWxPB
 CDsxsO3FQ0FmvyfTRrfrpzld2AjK7pOoyH3fWw6AnH/bS/HyEeh/BT1vGgNGxqSE/RLh
 zQr5VLdzOY6a27sxqD4IaG7T6olET4+JBkiazL7iCFHLlT2rUg0TGIh+yb49eX8OppCG
 sqtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=X3LTmFzczfRxgo2AFbnOMhu+tfZBTFunSRj9qIKUaA8=;
 b=J3v2stqs8XAODl2TPxg33BX+v4ISaLEVPyVwyVsBSC6lRLkYLjzaf2xoPIdwVWeW+W
 DuJ6VqhknoGbgd1e96ddcTgW93A1ipH4VQZCp2ZoqW7CvGMOPZT7gfRmUmNxZPIN8EHl
 nBhPLzaC6wVT2vb4pnwxcy2GN49mUxxHAKUxyuqI2+SeFVGFtOz6e8fgxqKMkWTOB7kQ
 njQP3LquqHDRHCHlLusrf4HjsbkOQk8AaqeJ6AsZk8xQK9JjZU6vg2wgV4HnHBoROEmN
 loEY/sr1UMd8dbcbHk9MZ+NpeEkbqygGCM/KzljY0pORP4dIY69EEB5DihlUsDbMbbYU
 iq4Q==
X-Gm-Message-State: APjAAAVjQ5tAoph6qqv3Y8te67NNB2gYfl5r6Hp1lt3Fjcd4kHX7eEBn
 HBUMrhlQUanhBFImobMp+CPDZk9oLIY=
X-Google-Smtp-Source: APXvYqzunpFWl7xFUlwSWUOB5pIfvrja/vmM8/escDfsvfJXALojpQ3DZ0uYq+dkZuO2Nlil7hX9Rw==
X-Received: by 2002:a17:902:b48f:: with SMTP id
 y15mr19885433plr.168.1569950187598; 
 Tue, 01 Oct 2019 10:16:27 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id w7sm2863568pjn.1.2019.10.01.10.16.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Oct 2019 10:16:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 09/18] target/s390x: Return exception from mmu_translate
Date: Tue,  1 Oct 2019 10:16:05 -0700
Message-Id: <20191001171614.8405-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191001171614.8405-1-richard.henderson@linaro.org>
References: <20191001171614.8405-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::62f
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
Cc: david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Do not raise the exception directly within mmu_translate,
but pass it back so that caller may do so.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/s390x/internal.h    |  2 +-
 target/s390x/excp_helper.c |  4 +--
 target/s390x/helper.c      |  3 ++-
 target/s390x/mem_helper.c  | 13 +++++++---
 target/s390x/mmu_helper.c  | 51 +++++++++++++++-----------------------
 5 files changed, 35 insertions(+), 38 deletions(-)

diff --git a/target/s390x/internal.h b/target/s390x/internal.h
index c4388aaf23..c993c3ef40 100644
--- a/target/s390x/internal.h
+++ b/target/s390x/internal.h
@@ -360,7 +360,7 @@ void probe_write_access(CPUS390XState *env, uint64_t addr, uint64_t len,
 
 /* mmu_helper.c */
 int mmu_translate(CPUS390XState *env, target_ulong vaddr, int rw, uint64_t asc,
-                  target_ulong *raddr, int *flags, bool exc);
+                  target_ulong *raddr, int *flags, uint64_t *tec);
 int mmu_translate_real(CPUS390XState *env, target_ulong raddr, int rw,
                        target_ulong *addr, int *flags, uint64_t *tec);
 
diff --git a/target/s390x/excp_helper.c b/target/s390x/excp_helper.c
index 906b87c071..6a0728b65f 100644
--- a/target/s390x/excp_helper.c
+++ b/target/s390x/excp_helper.c
@@ -140,8 +140,8 @@ bool s390_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
         if (!(env->psw.mask & PSW_MASK_64)) {
             vaddr &= 0x7fffffff;
         }
-        fail = mmu_translate(env, vaddr, access_type, asc, &raddr, &prot, true);
-        excp = 0; /* exception already raised */
+        excp = mmu_translate(env, vaddr, access_type, asc, &raddr, &prot, &tec);
+        fail = excp;
     } else if (mmu_idx == MMU_REAL_IDX) {
         /* 31-Bit mode */
         if (!(env->psw.mask & PSW_MASK_64)) {
diff --git a/target/s390x/helper.c b/target/s390x/helper.c
index bf503b56ee..a3a49164e4 100644
--- a/target/s390x/helper.c
+++ b/target/s390x/helper.c
@@ -52,6 +52,7 @@ hwaddr s390_cpu_get_phys_page_debug(CPUState *cs, vaddr vaddr)
     target_ulong raddr;
     int prot;
     uint64_t asc = env->psw.mask & PSW_MASK_ASC;
+    uint64_t tec;
 
     /* 31-Bit mode */
     if (!(env->psw.mask & PSW_MASK_64)) {
@@ -67,7 +68,7 @@ hwaddr s390_cpu_get_phys_page_debug(CPUState *cs, vaddr vaddr)
      * We want to read code even if IEP is active. Use MMU_DATA_LOAD instead
      * of MMU_INST_FETCH.
      */
-    if (mmu_translate(env, vaddr, MMU_DATA_LOAD, asc, &raddr, &prot, false)) {
+    if (mmu_translate(env, vaddr, MMU_DATA_LOAD, asc, &raddr, &prot, &tec)) {
         return -1;
     }
     return raddr;
diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index 7d2a652823..e15aa296dd 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -2364,8 +2364,8 @@ uint64_t HELPER(lra)(CPUS390XState *env, uint64_t addr)
     CPUState *cs = env_cpu(env);
     uint32_t cc = 0;
     uint64_t asc = env->psw.mask & PSW_MASK_ASC;
-    uint64_t ret;
-    int old_exc, flags;
+    uint64_t ret, tec;
+    int old_exc, flags, exc;
 
     /* XXX incomplete - has more corner cases */
     if (!(env->psw.mask & PSW_MASK_64) && (addr >> 32)) {
@@ -2373,7 +2373,14 @@ uint64_t HELPER(lra)(CPUS390XState *env, uint64_t addr)
     }
 
     old_exc = cs->exception_index;
-    if (mmu_translate(env, addr, 0, asc, &ret, &flags, true)) {
+    exc = mmu_translate(env, addr, 0, asc, &ret, &flags, &tec);
+    if (exc) {
+        /*
+         * We don't care about ILEN or TEC, as we're not going to
+         * deliver the exception -- thus resetting exception_index below.
+         * TODO: clean this up.
+         */
+        trigger_pgm_exception(env, exc, ILEN_UNWIND);
         cc = 3;
     }
     if (cs->exception_index == EXCP_PGM) {
diff --git a/target/s390x/mmu_helper.c b/target/s390x/mmu_helper.c
index e57d762f45..001d0a9c8a 100644
--- a/target/s390x/mmu_helper.c
+++ b/target/s390x/mmu_helper.c
@@ -365,20 +365,18 @@ static void mmu_handle_skey(target_ulong addr, int rw, int *flags)
  * @param raddr  the translated address is stored to this pointer
  * @param flags  the PAGE_READ/WRITE/EXEC flags are stored to this pointer
  * @param exc    true = inject a program check if a fault occurred
- * @return       0 if the translation was successful, -1 if a fault occurred
+ * @return       0 = success, != 0, the exception to raise
  */
 int mmu_translate(CPUS390XState *env, target_ulong vaddr, int rw, uint64_t asc,
-                  target_ulong *raddr, int *flags, bool exc)
+                  target_ulong *raddr, int *flags, uint64_t *tec)
 {
-    /* Code accesses have an undefined ilc, let's use 2 bytes. */
-    const int ilen = (rw == MMU_INST_FETCH) ? 2 : ILEN_AUTO;
-    uint64_t tec = (vaddr & TARGET_PAGE_MASK) | (asc >> 46) |
-                   (rw == MMU_DATA_STORE ? FS_WRITE : FS_READ);
     uint64_t asce;
     int r;
 
-
+    *tec = (vaddr & TARGET_PAGE_MASK) | (asc >> 46) |
+            (rw == MMU_DATA_STORE ? FS_WRITE : FS_READ);
     *flags = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
+
     if (is_low_address(vaddr & TARGET_PAGE_MASK) && lowprot_enabled(env, asc)) {
         /*
          * If any part of this page is currently protected, make sure the
@@ -390,12 +388,9 @@ int mmu_translate(CPUS390XState *env, target_ulong vaddr, int rw, uint64_t asc,
          */
         *flags |= PAGE_WRITE_INV;
         if (is_low_address(vaddr) && rw == MMU_DATA_STORE) {
-            if (exc) {
-                /* LAP sets bit 56 */
-                tec |= 0x80;
-                trigger_access_exception(env, PGM_PROTECTION, ilen, tec);
-            }
-            return -EACCES;
+            /* LAP sets bit 56 */
+            *tec |= 0x80;
+            return PGM_PROTECTION;
         }
     }
 
@@ -425,30 +420,21 @@ int mmu_translate(CPUS390XState *env, target_ulong vaddr, int rw, uint64_t asc,
     /* perform the DAT translation */
     r = mmu_translate_asce(env, vaddr, asc, asce, raddr, flags, rw);
     if (unlikely(r)) {
-        if (exc) {
-            trigger_access_exception(env, r, ilen, tec);
-        }
-        return -1;
+        return r;
     }
 
     /* check for DAT protection */
     if (unlikely(rw == MMU_DATA_STORE && !(*flags & PAGE_WRITE))) {
-        if (exc) {
-            /* DAT sets bit 61 only */
-            tec |= 0x4;
-            trigger_access_exception(env, PGM_PROTECTION, ilen, tec);
-        }
-        return -1;
+        /* DAT sets bit 61 only */
+        *tec |= 0x4;
+        return PGM_PROTECTION;
     }
 
     /* check for Instruction-Execution-Protection */
     if (unlikely(rw == MMU_INST_FETCH && !(*flags & PAGE_EXEC))) {
-        if (exc) {
-            /* IEP sets bit 56 and 61 */
-            tec |= 0x84;
-            trigger_access_exception(env, PGM_PROTECTION, ilen, tec);
-        }
-        return -1;
+        /* IEP sets bit 56 and 61 */
+        *tec |= 0x84;
+        return PGM_PROTECTION;
     }
 
 nodat:
@@ -472,9 +458,12 @@ static int translate_pages(S390CPU *cpu, vaddr addr, int nr_pages,
     int ret, i, pflags;
 
     for (i = 0; i < nr_pages; i++) {
-        ret = mmu_translate(env, addr, is_write, asc, &pages[i], &pflags, true);
+        uint64_t tec;
+
+        ret = mmu_translate(env, addr, is_write, asc, &pages[i], &pflags, &tec);
         if (ret) {
-            return ret;
+            trigger_access_exception(env, ret, ILEN_AUTO, tec);
+            return -EFAULT;
         }
         if (!address_space_access_valid(&address_space_memory, pages[i],
                                         TARGET_PAGE_SIZE, is_write,
-- 
2.17.1


