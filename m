Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F5FAC432C2
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 18:57:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07CD921D7B
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 18:57:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yj84Hus4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07CD921D7B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDCTW-0003Zo-92
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 14:57:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47016)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iDCIc-0001ku-IO
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 14:46:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iDCIb-0004FO-13
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 14:46:02 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636]:33419)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iDCIa-0004F1-P7
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 14:46:00 -0400
Received: by mail-pl1-x636.google.com with SMTP id d22so2945375pls.0
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 11:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=VU8gXJ0ha+BxU/auLcZl3iqhGwLSOAQ2I5JEO3/h8Yw=;
 b=yj84Hus4B03MBtSSLlSTLIPbiF7Wmw/YsBAFyO/HFgEdtQYr1YrIeSuJ45AXvu4oZq
 aEv7huRujb/U3ogGaliSZiU4X3Vh998j7z8VubAfWL+JU7I4SKUgzaqvnyLwNdbwhDWk
 GqGvnOgWQs20v9VgndldTWVJ4O58kQDrzOsV+z9u8qHpU7C/wn/C+WB3yEWxxYX/Howe
 bU3IAklyjegUqf7uFylZgAH0fheWQeHaBOTo7+5D30jT0jiAyOYaUqVe+/L2KD8plEdD
 gRTDdZ2/m1p4eGaB6l+FFwfPEMmpsiMnqJmdBO6YBk0yKQijgo5FNKdKBMr8eCexn8Pf
 kB5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=VU8gXJ0ha+BxU/auLcZl3iqhGwLSOAQ2I5JEO3/h8Yw=;
 b=JFJqbMpp/hRYXE0yyJPt9jWwHEXoS9J7LXCHbP0WRXkj/dyItmsZpGcTsuBMQtTqP8
 lvRB+wK8Fe6pKtgp3u7wXOvafgqSA/QkFFICXAJgJQqY/1CiJGyMEJQXQyMEsPjq1Ole
 aYYGF1bhSUsZCUzfUuzgDoFF2Rr8Zxijr+MiW3M3k7/rTaz+06QMVd6kNYDcFUFSdmmA
 el0qt0c5H8v6JcV0CBvPyDUZIOhXywXaaXCrnFbX02B3WaN3+kL0RXdlv+sb4NQudt85
 R234boosdgLqUFEEJe/svCTc5yG9DwSTgBA4j0Xe3g3aNp+CK+AnvYqCWx6sgF5csRah
 dcXQ==
X-Gm-Message-State: APjAAAUYVpTGhPCeGM8A7dMcR9FCk+W7yjsd9CEdLV0RHB3mZryKA4DM
 0a8sAFzy5K9Xfk1tcnkseuUTZgzqSrA=
X-Google-Smtp-Source: APXvYqxLAK8/dQM5rZtKi/XzBtf9o3NHYrfASu31YsXs4HtRQuSQuTdXGRV84wm2DqvDg9dAgxV8+w==
X-Received: by 2002:a17:902:9a05:: with SMTP id
 v5mr10778603plp.237.1569437159291; 
 Wed, 25 Sep 2019 11:45:59 -0700 (PDT)
Received: from localhost.localdomain ([12.206.46.61])
 by smtp.gmail.com with ESMTPSA id l24sm6133229pff.151.2019.09.25.11.45.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Sep 2019 11:45:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/16] cputlb: Introduce TLB_BSWAP
Date: Wed, 25 Sep 2019 11:45:38 -0700
Message-Id: <20190925184548.30673-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190925184548.30673-1-richard.henderson@linaro.org>
References: <20190925184548.30673-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::636
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Handle bswap on ram directly in load/store_helper.  This fixes a
bug with the previous implementation in that one cannot use the
I/O path for RAM.

Fixes: a26fc6f5152b47f1
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu-all.h |  4 ++-
 accel/tcg/cputlb.c     | 72 +++++++++++++++++++++++++-----------------
 2 files changed, 46 insertions(+), 30 deletions(-)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index e0c8dc540c..d148bded35 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -335,12 +335,14 @@ CPUArchState *cpu_copy(CPUArchState *env);
 #define TLB_MMIO            (1 << (TARGET_PAGE_BITS_MIN - 3))
 /* Set if TLB entry contains a watchpoint.  */
 #define TLB_WATCHPOINT      (1 << (TARGET_PAGE_BITS_MIN - 4))
+/* Set if TLB entry requires byte swap.  */
+#define TLB_BSWAP           (1 << (TARGET_PAGE_BITS_MIN - 5))
 
 /* Use this mask to check interception with an alignment mask
  * in a TCG backend.
  */
 #define TLB_FLAGS_MASK \
-    (TLB_INVALID_MASK | TLB_NOTDIRTY | TLB_MMIO | TLB_WATCHPOINT)
+    (TLB_INVALID_MASK | TLB_NOTDIRTY | TLB_MMIO | TLB_WATCHPOINT | TLB_BSWAP)
 
 /**
  * tlb_hit_page: return true if page aligned @addr is a hit against the
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index eeba8c9847..028eebcb44 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -737,8 +737,7 @@ void tlb_set_page_with_attrs(CPUState *cpu, target_ulong vaddr,
         address |= TLB_INVALID_MASK;
     }
     if (attrs.byte_swap) {
-        /* Force the access through the I/O slow path.  */
-        address |= TLB_MMIO;
+        address |= TLB_BSWAP;
     }
     if (!memory_region_is_ram(section->mr) &&
         !memory_region_is_romd(section->mr)) {
@@ -901,10 +900,6 @@ static uint64_t io_readx(CPUArchState *env, CPUIOTLBEntry *iotlbentry,
     bool locked = false;
     MemTxResult r;
 
-    if (iotlbentry->attrs.byte_swap) {
-        op ^= MO_BSWAP;
-    }
-
     section = iotlb_to_section(cpu, iotlbentry->addr, iotlbentry->attrs);
     mr = section->mr;
     mr_offset = (iotlbentry->addr & TARGET_PAGE_MASK) + addr;
@@ -947,10 +942,6 @@ static void io_writex(CPUArchState *env, CPUIOTLBEntry *iotlbentry,
     bool locked = false;
     MemTxResult r;
 
-    if (iotlbentry->attrs.byte_swap) {
-        op ^= MO_BSWAP;
-    }
-
     section = iotlb_to_section(cpu, iotlbentry->addr, iotlbentry->attrs);
     mr = section->mr;
     mr_offset = (iotlbentry->addr & TARGET_PAGE_MASK) + addr;
@@ -1133,8 +1124,8 @@ void *probe_access(CPUArchState *env, target_ulong addr, int size,
                              wp_access, retaddr);
     }
 
-    if (tlb_addr & (TLB_NOTDIRTY | TLB_MMIO)) {
-        /* I/O access */
+    /* Reject I/O access, or other required slow-path.  */
+    if (tlb_addr & (TLB_NOTDIRTY | TLB_MMIO | TLB_BSWAP)) {
         return NULL;
     }
 
@@ -1344,6 +1335,7 @@ load_helper(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
     /* Handle anything that isn't just a straight memory access.  */
     if (unlikely(tlb_addr & ~TARGET_PAGE_MASK)) {
         CPUIOTLBEntry *iotlbentry;
+        bool need_swap;
 
         /* For anything that is unaligned, recurse through full_load.  */
         if ((addr & (size - 1)) != 0) {
@@ -1357,17 +1349,27 @@ load_helper(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
             /* On watchpoint hit, this will longjmp out.  */
             cpu_check_watchpoint(env_cpu(env), addr, size,
                                  iotlbentry->attrs, BP_MEM_READ, retaddr);
-
-            /* The backing page may or may not require I/O.  */
-            tlb_addr &= ~TLB_WATCHPOINT;
-            if ((tlb_addr & ~TARGET_PAGE_MASK) == 0) {
-                goto do_aligned_access;
-            }
         }
 
+        need_swap = size > 1 && (tlb_addr & TLB_BSWAP);
+
         /* Handle I/O access.  */
-        return io_readx(env, iotlbentry, mmu_idx, addr,
-                        retaddr, access_type, op);
+        if (likely(tlb_addr & TLB_MMIO)) {
+            return io_readx(env, iotlbentry, mmu_idx, addr, retaddr,
+                            access_type, op ^ (need_swap * MO_BSWAP));
+        }
+
+        haddr = (void *)((uintptr_t)addr + entry->addend);
+
+        /*
+         * Keep these two load_memop separate to ensure that the compiler
+         * is able to fold the entire function to a single instruction.
+         * There is a build-time assert inside to remind you of this.  ;-)
+         */
+        if (unlikely(need_swap)) {
+            return load_memop(haddr, op ^ MO_BSWAP);
+        }
+        return load_memop(haddr, op);
     }
 
     /* Handle slow unaligned access (it spans two pages or IO).  */
@@ -1394,7 +1396,6 @@ load_helper(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
         return res & MAKE_64BIT_MASK(0, size * 8);
     }
 
- do_aligned_access:
     haddr = (void *)((uintptr_t)addr + entry->addend);
     return load_memop(haddr, op);
 }
@@ -1591,6 +1592,7 @@ store_helper(CPUArchState *env, target_ulong addr, uint64_t val,
     /* Handle anything that isn't just a straight memory access.  */
     if (unlikely(tlb_addr & ~TARGET_PAGE_MASK)) {
         CPUIOTLBEntry *iotlbentry;
+        bool need_swap;
 
         /* For anything that is unaligned, recurse through byte stores.  */
         if ((addr & (size - 1)) != 0) {
@@ -1604,16 +1606,29 @@ store_helper(CPUArchState *env, target_ulong addr, uint64_t val,
             /* On watchpoint hit, this will longjmp out.  */
             cpu_check_watchpoint(env_cpu(env), addr, size,
                                  iotlbentry->attrs, BP_MEM_WRITE, retaddr);
-
-            /* The backing page may or may not require I/O.  */
-            tlb_addr &= ~TLB_WATCHPOINT;
-            if ((tlb_addr & ~TARGET_PAGE_MASK) == 0) {
-                goto do_aligned_access;
-            }
         }
 
+        need_swap = size > 1 && (tlb_addr & TLB_BSWAP);
+
         /* Handle I/O access.  */
-        io_writex(env, iotlbentry, mmu_idx, val, addr, retaddr, op);
+        if (likely(tlb_addr & (TLB_MMIO | TLB_NOTDIRTY))) {
+            io_writex(env, iotlbentry, mmu_idx, val, addr, retaddr,
+                      op ^ (need_swap * MO_BSWAP));
+            return;
+        }
+
+        haddr = (void *)((uintptr_t)addr + entry->addend);
+
+        /*
+         * Keep these two store_memop separate to ensure that the compiler
+         * is able to fold the entire function to a single instruction.
+         * There is a build-time assert inside to remind you of this.  ;-)
+         */
+        if (unlikely(need_swap)) {
+            store_memop(haddr, val, op ^ MO_BSWAP);
+        } else {
+            store_memop(haddr, val, op);
+        }
         return;
     }
 
@@ -1682,7 +1697,6 @@ store_helper(CPUArchState *env, target_ulong addr, uint64_t val,
         return;
     }
 
- do_aligned_access:
     haddr = (void *)((uintptr_t)addr + entry->addend);
     store_memop(haddr, val, op);
 }
-- 
2.17.1


