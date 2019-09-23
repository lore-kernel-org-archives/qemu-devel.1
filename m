Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2F74C432C1
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 23:15:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D7D621BE5
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 23:15:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QRJ4rwtj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D7D621BE5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37230 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCXXy-0001zs-M4
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 19:15:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35878)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iCXJl-0005hA-8s
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 19:00:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iCXJi-00087Y-Ln
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 19:00:28 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:43646)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iCXJg-00086E-Lr
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 19:00:26 -0400
Received: by mail-pg1-x543.google.com with SMTP id v27so2796169pgk.10
 for <qemu-devel@nongnu.org>; Mon, 23 Sep 2019 16:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=pUAaCktLquOjXW5Xa8iLJXKY1VYXEwAziRNCOh2IfXs=;
 b=QRJ4rwtjP3OD1rX2mFQoDWI/jeuHf5KVxIZvCSDenv2CxqKfaWi1JpY/T4c8cEPwTM
 cvz2LTXo+lCDaatWrY71i7THtMJP+AVsndSwIeJaiwo8iao+8kPgTaT34W6p09URsWjo
 EULbfNF5z6uRSywcS0RM8Pr212s6sKOXJ14E0NJXaSPaF/CoBgjRosMV+zm2Kuu7WO0X
 P+36tW50siaTgKPJf+ayaWMTN9GodYYhpcNBVEs4Eoy072wQpZxYsVcX1qBLBaoVdRnQ
 kFuh7ZWrL54B0eRGixGbzc/KniCyd9NwwG7lgz9xzD8c/LYEQcvLZVPi/IXCFtqPyguf
 rxOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=pUAaCktLquOjXW5Xa8iLJXKY1VYXEwAziRNCOh2IfXs=;
 b=qU+8gz9BebsF4ZMwr7JNb2QPRp/oSR6+0SewkDeue7if6lvdm8apFzdXRMBTxnHVvW
 7ENhWnx26I0WR6lWRgmPN66nf3fzufZ4TvCTkDWzMhPXtUlUCqhX/fq65FQ6ZIVX32Gl
 +SGYSPQrOAtp69Fkl+BWmz+vJNSEdF7y2GPGYDpV7AUIK+65aRe4Sf+xg5n5poIPloQV
 PqI2z3zIUrS1gkpzJ5LGZOzYPdP+voAKRvO/ILVZ0hDcae60w4pYdhD5ssq7Kmzvj7Wg
 LM0tkuzFUvpCrRq7MW3Fev6R5q1Us6RE2I3kwsz1l4nI8ups8KikacIfpIlUUK3+1fcH
 6kEA==
X-Gm-Message-State: APjAAAUaDGKY0ghz8tXTWP6ylmglfhiRxPDNLvfnYC9WDmb0uWL5zo1X
 HSZQfXY5itS0Fpmp4HjP+q2HWMPkYgw=
X-Google-Smtp-Source: APXvYqzODWRNdyZxD/oUXi9z5g+9od7hpY5xEOO35bLD+AJCtWZgkFzYogbA59EB/9smQi1j2JWjfw==
X-Received: by 2002:a17:90a:e998:: with SMTP id
 v24mr1909617pjy.112.1569279622468; 
 Mon, 23 Sep 2019 16:00:22 -0700 (PDT)
Received: from localhost.localdomain ([12.206.46.59])
 by smtp.gmail.com with ESMTPSA id 74sm11674810pfy.78.2019.09.23.16.00.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Sep 2019 16:00:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 10/16] cputlb: Partially inline
 memory_region_section_get_iotlb
Date: Mon, 23 Sep 2019 15:59:58 -0700
Message-Id: <20190923230004.9231-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190923230004.9231-1-richard.henderson@linaro.org>
References: <20190923230004.9231-1-richard.henderson@linaro.org>
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
index 05212ff244..05530a8b0c 100644
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
index dc7001f115..961d7d6497 100644
--- a/exec.c
+++ b/exec.c
@@ -1459,26 +1459,10 @@ bool cpu_physical_memory_snapshot_get_dirty(DirtyBitmapSnapshot *snap,
 
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


