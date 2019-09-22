Return-Path: <SRS0=thrq=XR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47AE6C3A5A6
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Sep 2019 04:09:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10F3520673
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Sep 2019 04:09:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mTCs34vv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10F3520673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45062 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBtC1-00079V-1L
	for qemu-devel@archiver.kernel.org; Sun, 22 Sep 2019 00:09:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40933)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iBsy2-0001n8-8E
 for qemu-devel@nongnu.org; Sat, 21 Sep 2019 23:55:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iBsy0-0008Ia-5E
 for qemu-devel@nongnu.org; Sat, 21 Sep 2019 23:55:21 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:47022)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iBsxz-0008IB-Sb
 for qemu-devel@nongnu.org; Sat, 21 Sep 2019 23:55:20 -0400
Received: by mail-pg1-x543.google.com with SMTP id a3so5972642pgm.13
 for <qemu-devel@nongnu.org>; Sat, 21 Sep 2019 20:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=QxZNUVHClZ6kub1hmpcWcaD4e3TTiMLpQiUcrzE3llI=;
 b=mTCs34vvydaZZxX3xCghwuxVcQ7KkSJo3zxvKdjFDHF052AyPWlD0rMSkYpCwWV8u0
 LJN9sv6EI3m1TTU86PZyY3FmL9HZZo8CyrXbM8Opwad42sE+8W5Qny/ehEglIMhvaRJU
 eaVJv2Exsn/y3sqrulBZhgsqyEumPS8IFW1qrxO3fQ76+5i3ooYYV6GVexA0paIwAe65
 48N+yhh9ZVswEzMjRraVpjuwVWKBcZAGPv5dTiQGuKdoGEAiCPTC1RYp3yN1+nl7i9hl
 u1mlG/Fh6UKtx2hNq7OG/zTFaqL5eiqg27z1Ta6QQYnm7u3+JsNFKgpKUtygsYHEJtYS
 iJqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=QxZNUVHClZ6kub1hmpcWcaD4e3TTiMLpQiUcrzE3llI=;
 b=mOdlkF6TLt3lIalr35b+OPUwjOrSUtC4zmkQolEvxqmANASb0XISjczRtDbx/UWw5F
 5DGWmeoaTbOKixXuZ3lrr3FjBwFZ07DtzDTPQJ6qhY6rhb6mm9pmKTmfAIFUqvOA3s+T
 VgK7H/Bb8VtpAkh+BWPMvroPiwCLSc+sfijBwIJe/myMCaYoEu2oDYBUZbN8Ew69QZiE
 D46lXJ7309qhe9l/vYelxrw1XEtHKEHWSlj9xwaxvDt5yoAQojnogNytqBsACa3cn8NQ
 Eax6Kh3LEop3Iwi8gmqbOImBdM+RkXi9eFu+KVfjbEm4k0evVYL7uiMBjAPQ/HyiMEJj
 01Bg==
X-Gm-Message-State: APjAAAVapafrJmSC40yuRSsOOLZRYuXn6RadCuY4VjP8J/0tNzMbM9Wd
 WTkimvh186l1+OrtBIJaXmtix19mFYo=
X-Google-Smtp-Source: APXvYqzzWQfhP4LHBlFvY9Dw5WRXGOeqA7/qqHtU3OwxRNnfvSCUsUbne9zJC0PriqoDg8sbTGXjMw==
X-Received: by 2002:aa7:85d0:: with SMTP id z16mr26913148pfn.206.1569124518628; 
 Sat, 21 Sep 2019 20:55:18 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id z4sm6452921pjt.17.2019.09.21.20.55.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Sep 2019 20:55:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 14/20] cputlb: Partially inline
 memory_region_section_get_iotlb
Date: Sat, 21 Sep 2019 20:54:52 -0700
Message-Id: <20190922035458.14879-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190922035458.14879-1-richard.henderson@linaro.org>
References: <20190922035458.14879-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
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
Cc: pbonzini@redhat.com, alex.bennee@linaro.org, stefanha@redhat.com,
 david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There is only one caller, tlb_set_page_with_attrs.  We cannot
inline the entire function because the AddressSpaceDispatch
structure is private to exec.c, and cannot easily be moved to
include/exec/memory-internal.h.

Compute is_ram and is_romd once within tlb_set_page_with_attrs.
Fold the number of tests against these predicates.  Compute
cpu_physical_memory_is_clean outside of the tlb lock region.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/exec-all.h |  6 +---
 accel/tcg/cputlb.c      | 68 ++++++++++++++++++++++++++---------------
 exec.c                  | 22 ++-----------
 3 files changed, 47 insertions(+), 49 deletions(-)

diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 81b02eb2fe..49db07ba0b 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -509,11 +509,7 @@ address_space_translate_for_iotlb(CPUState *cpu, int asidx, hwaddr addr,
                                   hwaddr *xlat, hwaddr *plen,
                                   MemTxAttrs attrs, int *prot);
 hwaddr memory_region_section_get_iotlb(CPUState *cpu,
-                                       MemoryRegionSection *section,
-                                       target_ulong vaddr,
-                                       hwaddr paddr, hwaddr xlat,
-                                       int prot,
-                                       target_ulong *address);
+                                       MemoryRegionSection *section);
 #endif
 
 /* vl.c */
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index b7bd738115..1a839c0f82 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -704,13 +704,14 @@ void tlb_set_page_with_attrs(CPUState *cpu, target_ulong vaddr,
     MemoryRegionSection *section;
     unsigned int index;
     target_ulong address;
-    target_ulong code_address;
+    target_ulong write_address;
     uintptr_t addend;
     CPUTLBEntry *te, tn;
     hwaddr iotlb, xlat, sz, paddr_page;
     target_ulong vaddr_page;
     int asidx = cpu_asidx_from_attrs(cpu, attrs);
     int wp_flags;
+    bool is_ram, is_romd;
 
     assert_cpu_is_self(cpu);
 
@@ -739,18 +740,46 @@ void tlb_set_page_with_attrs(CPUState *cpu, target_ulong vaddr,
     if (attrs.byte_swap) {
         address |= TLB_BSWAP;
     }
-    if (!memory_region_is_ram(section->mr) &&
-        !memory_region_is_romd(section->mr)) {
-        /* IO memory case */
-        address |= TLB_MMIO;
-        addend = 0;
-    } else {
+
+    is_ram = memory_region_is_ram(section->mr);
+    is_romd = memory_region_is_romd(section->mr);
+
+    if (is_ram || is_romd) {
+        /* RAM and ROMD both have associated host memory. */
         addend = (uintptr_t)memory_region_get_ram_ptr(section->mr) + xlat;
+    } else {
+        /* I/O does not; force the host address to NULL. */
+        addend = 0;
+    }
+
+    write_address = address;
+    if (is_ram) {
+        iotlb = memory_region_get_ram_addr(section->mr) + xlat;
+        /*
+         * Computing is_clean is expensive; avoid all that unless
+         * the page is actually writable.
+         */
+        if (prot & PAGE_WRITE) {
+            if (section->readonly) {
+                write_address |= TLB_ROM;
+            } else if (cpu_physical_memory_is_clean(iotlb)) {
+                write_address |= TLB_NOTDIRTY;
+            }
+        }
+    } else {
+        /* I/O or ROMD */
+        iotlb = memory_region_section_get_iotlb(cpu, section) + xlat;
+        /*
+         * Writes to romd devices must go through MMIO to enable write.
+         * Reads to romd devices go through the ram_ptr found above,
+         * but of course reads to I/O must go through MMIO.
+         */
+        write_address |= TLB_MMIO;
+        if (!is_romd) {
+            address = write_address;
+        }
     }
 
-    code_address = address;
-    iotlb = memory_region_section_get_iotlb(cpu, section, vaddr_page,
-                                            paddr_page, xlat, prot, &address);
     wp_flags = cpu_watchpoint_address_matches(cpu, vaddr_page,
                                               TARGET_PAGE_SIZE);
 
@@ -790,8 +819,8 @@ void tlb_set_page_with_attrs(CPUState *cpu, target_ulong vaddr,
     /*
      * At this point iotlb contains a physical section number in the lower
      * TARGET_PAGE_BITS, and either
-     *  + the ram_addr_t of the page base of the target RAM (if NOTDIRTY or ROM)
-     *  + the offset within section->mr of the page base (otherwise)
+     *  + the ram_addr_t of the page base of the target RAM (RAM)
+     *  + the offset within section->mr of the page base (I/O, ROMD)
      * We subtract the vaddr_page (which is page aligned and thus won't
      * disturb the low bits) to give an offset which can be added to the
      * (non-page-aligned) vaddr of the eventual memory access to get
@@ -814,25 +843,14 @@ void tlb_set_page_with_attrs(CPUState *cpu, target_ulong vaddr,
     }
 
     if (prot & PAGE_EXEC) {
-        tn.addr_code = code_address;
+        tn.addr_code = address;
     } else {
         tn.addr_code = -1;
     }
 
     tn.addr_write = -1;
     if (prot & PAGE_WRITE) {
-        tn.addr_write = address;
-        if (memory_region_is_romd(section->mr)) {
-            /* Use the MMIO path so that the device can switch states. */
-            tn.addr_write |= TLB_MMIO;
-        } else if (memory_region_is_ram(section->mr)) {
-            if (section->readonly) {
-                tn.addr_write |= TLB_ROM;
-            } else if (cpu_physical_memory_is_clean(
-                        memory_region_get_ram_addr(section->mr) + xlat)) {
-                tn.addr_write |= TLB_NOTDIRTY;
-            }
-        }
+        tn.addr_write = write_address;
         if (prot & PAGE_WRITE_INV) {
             tn.addr_write |= TLB_INVALID_MASK;
         }
diff --git a/exec.c b/exec.c
index abf58b68a0..9c9cc811b3 100644
--- a/exec.c
+++ b/exec.c
@@ -1425,26 +1425,10 @@ bool cpu_physical_memory_snapshot_get_dirty(DirtyBitmapSnapshot *snap,
 
 /* Called from RCU critical section */
 hwaddr memory_region_section_get_iotlb(CPUState *cpu,
-                                       MemoryRegionSection *section,
-                                       target_ulong vaddr,
-                                       hwaddr paddr, hwaddr xlat,
-                                       int prot,
-                                       target_ulong *address)
+                                       MemoryRegionSection *section)
 {
-    hwaddr iotlb;
-
-    if (memory_region_is_ram(section->mr)) {
-        /* Normal RAM.  */
-        iotlb = memory_region_get_ram_addr(section->mr) + xlat;
-    } else {
-        AddressSpaceDispatch *d;
-
-        d = flatview_to_dispatch(section->fv);
-        iotlb = section - d->map.sections;
-        iotlb += xlat;
-    }
-
-    return iotlb;
+    AddressSpaceDispatch *d = flatview_to_dispatch(section->fv);
+    return section - d->map.sections;
 }
 #endif /* defined(CONFIG_USER_ONLY) */
 
-- 
2.17.1


