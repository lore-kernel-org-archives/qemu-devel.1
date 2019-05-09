Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C3A7C04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 22:42:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D80E821744
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 22:42:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k4sHyyoI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D80E821744
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33651 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOrjk-00049I-2W
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 18:42:00 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33251)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOrVR-00081V-0f
	for qemu-devel@nongnu.org; Thu, 09 May 2019 18:27:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOrVP-0005eD-Iw
	for qemu-devel@nongnu.org; Thu, 09 May 2019 18:27:12 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:36144)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hOrVP-0005dl-2E
	for qemu-devel@nongnu.org; Thu, 09 May 2019 18:27:11 -0400
Received: by mail-pg1-x542.google.com with SMTP id a3so1926741pgb.3
	for <qemu-devel@nongnu.org>; Thu, 09 May 2019 15:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=g3xnMlX0kQIIsZFf0jn7V0Z3ghhMjOB9lPUnQDGY3Jc=;
	b=k4sHyyoIY8KL33M+u+uAPHFbeyMOYET+ZBPf8krxWJw3y3FfyOcJsO1Pw2aryidZP2
	IF88MWUL32XgK6NEAUXBe/kiQZQ7W8s/rTL96l5bo9bg42hKSA2RFn5z76yEx5qPB5ao
	zt8os/f2HAd9vLlKUxa1JDNEBMoo9Mgl6psZyZI1iiXkS3qWeGFYbIUEVwc0IL1PY/2z
	49O4ZmrVzXYeXD7Vrros5v+n8NV3LKy8NcfPnlI/ORGEwGSWjw1cggrJsOaDUxvhjubj
	D7PsQ4NqbZumsIrXiIJiAh9sCP9zv7JH9FPulcIXwI+rAROfEcPm3NTmKU0EtiXTwsIS
	awRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=g3xnMlX0kQIIsZFf0jn7V0Z3ghhMjOB9lPUnQDGY3Jc=;
	b=Kr/i8A7mZY6w9UVi7uULn2zPtaYdkmEj7sBLXPna4qQ2n3pfbCLfQUR5anpooz6uH9
	5ZdeftMdncbZto3mJeIk5JM2PHmR+dBbOehefAS2U+mGw2NNxpw9cVxywoem60ow0An/
	tEFs6HmqIOO4cxI6JglI/oWcDXoIcUGgdmfGjkPaqFbCrQtuXT/9K8ZjK6w9/DuHBEe1
	N+ZB1mfJtCtWRjdLtaGpuY+0byZt5XgxTodXj6EeF1UprwYt4uEPEPQLZglzbfur2OIt
	LgTV/ORCVCNNLTYa6Gnrd2zmTSaBdz5m+CRAKCkbUpXGrKH9vr5ynsyZk/otQUVfezcY
	8EaQ==
X-Gm-Message-State: APjAAAUIfyA/2FQbgfzxUOSzVTAy2sttU80lgOYB7ItbzZDIkfWu+U1F
	QhckQYoPvuy0EqMhowM/Bf9c9mwqcgs=
X-Google-Smtp-Source: APXvYqz7TgSVUAlewtf5/Nc60IqQGia8I5OgHD1rKqgXKSlJxAAQ0A9mUQ6+Q5C9d+QmXM5BtLAmwg==
X-Received: by 2002:a62:2703:: with SMTP id n3mr8887158pfn.199.1557440829250; 
	Thu, 09 May 2019 15:27:09 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231])
	by smtp.gmail.com with ESMTPSA id m2sm4490521pfi.24.2019.05.09.15.27.08
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 09 May 2019 15:27:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu,  9 May 2019 15:26:31 -0700
Message-Id: <20190509222631.14271-28-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190509222631.14271-1-richard.henderson@linaro.org>
References: <20190509222631.14271-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::542
Subject: [Qemu-devel] [PATCH v3 27/27] tcg: Use tlb_fill probe from
 tlb_vaddr_to_host
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

Most of the existing users would continue around a loop which
would fault the tlb entry in via a normal load/store.

But for AArch64 SVE we have an existing emulation bug wherein we
would mark the first element of a no-fault vector load as faulted
(within the FFR, not via exception) just because we did not have
its address in the TLB.  Now we can properly only mark it as faulted
if there really is no valid, readable translation, while still not
raising an exception.  (Note that beyond the first element of the
vector, the hardware may report a fault for any reason whatsoever;
with at least one element loaded, forward progress is guaranteed.)

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v2: Update function docs comment.
---
 include/exec/cpu_ldst.h | 50 ++++++-----------------------
 accel/tcg/cputlb.c      | 69 ++++++++++++++++++++++++++++++++++++-----
 target/arm/sve_helper.c |  6 +---
 3 files changed, 72 insertions(+), 53 deletions(-)

diff --git a/include/exec/cpu_ldst.h b/include/exec/cpu_ldst.h
index d78041d7a0..7b28a839d2 100644
--- a/include/exec/cpu_ldst.h
+++ b/include/exec/cpu_ldst.h
@@ -433,50 +433,20 @@ static inline CPUTLBEntry *tlb_entry(CPUArchState *env, uintptr_t mmu_idx,
  * @mmu_idx: MMU index to use for lookup
  *
  * Look up the specified guest virtual index in the TCG softmmu TLB.
- * If the TLB contains a host virtual address suitable for direct RAM
- * access, then return it. Otherwise (TLB miss, TLB entry is for an
- * I/O access, etc) return NULL.
- *
- * This is the equivalent of the initial fast-path code used by
- * TCG backends for guest load and store accesses.
+ * If we can translate a host virtual address suitable for direct RAM
+ * access, without causing a guest exception, then return it.
+ * Otherwise (TLB entry is for an I/O access, guest software
+ * TLB fill required, etc) return NULL.
  */
+#ifdef CONFIG_USER_ONLY
 static inline void *tlb_vaddr_to_host(CPUArchState *env, abi_ptr addr,
-                                      int access_type, int mmu_idx)
+                                      MMUAccessType access_type, int mmu_idx)
 {
-#if defined(CONFIG_USER_ONLY)
     return g2h(addr);
-#else
-    CPUTLBEntry *tlbentry = tlb_entry(env, mmu_idx, addr);
-    abi_ptr tlb_addr;
-    uintptr_t haddr;
-
-    switch (access_type) {
-    case 0:
-        tlb_addr = tlbentry->addr_read;
-        break;
-    case 1:
-        tlb_addr = tlb_addr_write(tlbentry);
-        break;
-    case 2:
-        tlb_addr = tlbentry->addr_code;
-        break;
-    default:
-        g_assert_not_reached();
-    }
-
-    if (!tlb_hit(tlb_addr, addr)) {
-        /* TLB entry is for a different page */
-        return NULL;
-    }
-
-    if (tlb_addr & ~TARGET_PAGE_MASK) {
-        /* IO access */
-        return NULL;
-    }
-
-    haddr = addr + tlbentry->addend;
-    return (void *)haddr;
-#endif /* defined(CONFIG_USER_ONLY) */
 }
+#else
+void *tlb_vaddr_to_host(CPUArchState *env, abi_ptr addr,
+                        MMUAccessType access_type, int mmu_idx);
+#endif
 
 #endif /* CPU_LDST_H */
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index dfcd9ae168..45a5c4e123 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1007,6 +1007,16 @@ static void io_writex(CPUArchState *env, CPUIOTLBEntry *iotlbentry,
     }
 }
 
+static inline target_ulong tlb_read_ofs(CPUTLBEntry *entry, size_t ofs)
+{
+#if TCG_OVERSIZED_GUEST
+    return *(target_ulong *)((uintptr_t)entry + ofs);
+#else
+    /* ofs might correspond to .addr_write, so use atomic_read */
+    return atomic_read((target_ulong *)((uintptr_t)entry + ofs));
+#endif
+}
+
 /* Return true if ADDR is present in the victim tlb, and has been copied
    back to the main tlb.  */
 static bool victim_tlb_hit(CPUArchState *env, size_t mmu_idx, size_t index,
@@ -1017,14 +1027,7 @@ static bool victim_tlb_hit(CPUArchState *env, size_t mmu_idx, size_t index,
     assert_cpu_is_self(ENV_GET_CPU(env));
     for (vidx = 0; vidx < CPU_VTLB_SIZE; ++vidx) {
         CPUTLBEntry *vtlb = &env->tlb_v_table[mmu_idx][vidx];
-        target_ulong cmp;
-
-        /* elt_ofs might correspond to .addr_write, so use atomic_read */
-#if TCG_OVERSIZED_GUEST
-        cmp = *(target_ulong *)((uintptr_t)vtlb + elt_ofs);
-#else
-        cmp = atomic_read((target_ulong *)((uintptr_t)vtlb + elt_ofs));
-#endif
+        target_ulong cmp = tlb_read_ofs(vtlb, elt_ofs);
 
         if (cmp == page) {
             /* Found entry in victim tlb, swap tlb and iotlb.  */
@@ -1108,6 +1111,56 @@ void probe_write(CPUArchState *env, target_ulong addr, int size, int mmu_idx,
     }
 }
 
+void *tlb_vaddr_to_host(CPUArchState *env, abi_ptr addr,
+                        MMUAccessType access_type, int mmu_idx)
+{
+    CPUTLBEntry *entry = tlb_entry(env, mmu_idx, addr);
+    uintptr_t tlb_addr, page;
+    size_t elt_ofs;
+
+    switch (access_type) {
+    case MMU_DATA_LOAD:
+        elt_ofs = offsetof(CPUTLBEntry, addr_read);
+        break;
+    case MMU_DATA_STORE:
+        elt_ofs = offsetof(CPUTLBEntry, addr_write);
+        break;
+    case MMU_INST_FETCH:
+        elt_ofs = offsetof(CPUTLBEntry, addr_code);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+    page = addr & TARGET_PAGE_MASK;
+    tlb_addr = tlb_read_ofs(entry, elt_ofs);
+
+    if (!tlb_hit_page(tlb_addr, page)) {
+        uintptr_t index = tlb_index(env, mmu_idx, addr);
+
+        if (!victim_tlb_hit(env, mmu_idx, index, elt_ofs, page)) {
+            CPUState *cs = ENV_GET_CPU(env);
+            CPUClass *cc = CPU_GET_CLASS(cs);
+
+            if (!cc->tlb_fill(cs, addr, 0, access_type, mmu_idx, true, 0)) {
+                /* Non-faulting page table read failed.  */
+                return NULL;
+            }
+
+            /* TLB resize via tlb_fill may have moved the entry.  */
+            entry = tlb_entry(env, mmu_idx, addr);
+        }
+        tlb_addr = tlb_read_ofs(entry, elt_ofs);
+    }
+
+    if (tlb_addr & ~TARGET_PAGE_MASK) {
+        /* IO access */
+        return NULL;
+    }
+
+    return (void *)(addr + entry->addend);
+}
+
 /* Probe for a read-modify-write atomic operation.  Do not allow unaligned
  * operations, or io operations to proceed.  Return the host address.  */
 static void *atomic_mmu_lookup(CPUArchState *env, target_ulong addr,
diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index bc847250dd..fd434c66ea 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -4598,11 +4598,7 @@ static void sve_ldnf1_r(CPUARMState *env, void *vg, const target_ulong addr,
      * in the real world, obviously.)
      *
      * Then there are the annoying special cases with watchpoints...
-     *
-     * TODO: Add a form of tlb_fill that does not raise an exception,
-     * with a form of tlb_vaddr_to_host and a set of loads to match.
-     * The non_fault_vaddr_to_host would handle everything, usually,
-     * and the loads would handle the iomem path for watchpoints.
+     * TODO: Add a form of non-faulting loads using cc->tlb_fill(probe=true).
      */
     host = tlb_vaddr_to_host(env, addr + mem_off, MMU_DATA_LOAD, mmu_idx);
     split = max_for_page(addr, mem_off, mem_max);
-- 
2.17.1


