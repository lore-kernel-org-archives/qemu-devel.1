Return-Path: <SRS0=NWXH=WU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 984B1C3A59E
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Aug 2019 21:43:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C4562133F
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Aug 2019 21:43:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cJQhfKRk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C4562133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39558 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1doJ-00070f-Kx
	for qemu-devel@archiver.kernel.org; Sat, 24 Aug 2019 17:42:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36364)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i1dgg-0001M1-HR
 for qemu-devel@nongnu.org; Sat, 24 Aug 2019 17:35:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i1dge-00035Q-Fl
 for qemu-devel@nongnu.org; Sat, 24 Aug 2019 17:35:06 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:39755)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i1dga-00030o-La
 for qemu-devel@nongnu.org; Sat, 24 Aug 2019 17:35:02 -0400
Received: by mail-pg1-x541.google.com with SMTP id u17so7972273pgi.6
 for <qemu-devel@nongnu.org>; Sat, 24 Aug 2019 14:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=YR66lN9SJRv3vsHOK1rmmiRwlMbIQXT9UAQyELpnwsw=;
 b=cJQhfKRkZpkGMvu/sZcc2TJJoFF7oZKHl0mjoITm1AUyZxQUa8ZqR8i0FyDXJDGURr
 NiZwVOMAGhLnsE5kf97smE49ygFM1oGbPxaGX7g3TBVFO42iy9UiN5WsOPiKFwlmIR6H
 3C86Y61Vi+2qPS3fcnRbwDa0JmKtBi4FINO5zVgxefaT6yYsj7brzLy8WSmQskHz9XnN
 /+1crYanJK9/VUOW/jlJpRHdTHgcQC3JJuAVzxYxqj7ec9VAC5kT8FazXmC28+5Jp0Bx
 PARj0yHN4FL24a/Ob5E/nal3BMRbE3agXheWBixC1kr0qoerx60n4nKNR9XfUjPf6bI0
 qnXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=YR66lN9SJRv3vsHOK1rmmiRwlMbIQXT9UAQyELpnwsw=;
 b=Qm9B6iJ1TpIjaHPvqsor3QvHkVdfiQjvvE+2X/W00KxTFJ6v43BZaVSxJtj3n8Rebo
 +W0n6sLWbnEyQaRrr3Tbx/AtzRcrS+9z+o6KMGWEjcyyNENiHQSLUXhFf3l9eYtbYPwe
 LoPjbt8rlG7T/XGjNGK1aSqaN/z9s1hPM0voEoLGCTrr1tbi3aQM50BKlIqed6S3GQtu
 njilxarLhhcY1DXFsciM+YiunsE6fUhJaVPTcyw0QoNXOAhmLaBZ7yHGct99gLqBFcyd
 Gb3wLbCic/p6WRFjsJvAaf1WdjB3q0OZYaiTKgqkuo9fveGqgMyyrTQUs3IgBlgrUSPM
 u9nA==
X-Gm-Message-State: APjAAAUZx7XaUw0gjyqXzXZeXzh9X6m2PoLkKNVBMleJshzV/jtigcKt
 FX609GwK2Mlo8Ey6djRGBom1GENQ28w=
X-Google-Smtp-Source: APXvYqyoMzq69F8eVyHt1pF3Cv6dhU4FUqjtr+dZU8Wnvoz7S6xcTKaeIsLzidLDLeibMCIYXxbQmw==
X-Received: by 2002:a62:1901:: with SMTP id 1mr12551701pfz.172.1566682499203; 
 Sat, 24 Aug 2019 14:34:59 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id 81sm6325753pfx.111.2019.08.24.14.34.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Aug 2019 14:34:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sat, 24 Aug 2019 14:34:49 -0700
Message-Id: <20190824213451.31118-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190824213451.31118-1-richard.henderson@linaro.org>
References: <20190824213451.31118-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
Subject: [Qemu-devel] [PATCH 4/6] exec: Factor out
 cpu_watchpoint_address_matches
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
Cc: peter.maydell@linaro.org, david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We want to move the check for watchpoints from
memory_region_section_get_iotlb to tlb_set_page_with_attrs.
Isolate the loop over watchpoints to an exported function.

Rename the existing cpu_watchpoint_address_matches to
watchpoint_address_matches, since it doesn't actually
have a cpu argument.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/hw/core/cpu.h |  7 +++++++
 exec.c                | 45 ++++++++++++++++++++++++++++---------------
 2 files changed, 36 insertions(+), 16 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 7bd8bed5b2..c7cda65c66 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -1096,6 +1096,12 @@ static inline void cpu_check_watchpoint(CPUState *cpu, vaddr addr, vaddr len,
                                         MemTxAttrs atr, int fl, uintptr_t ra)
 {
 }
+
+static inline int cpu_watchpoint_address_matches(CPUState *cpu,
+                                                 vaddr addr, vaddr len)
+{
+    return 0;
+}
 #else
 int cpu_watchpoint_insert(CPUState *cpu, vaddr addr, vaddr len,
                           int flags, CPUWatchpoint **watchpoint);
@@ -1105,6 +1111,7 @@ void cpu_watchpoint_remove_by_ref(CPUState *cpu, CPUWatchpoint *watchpoint);
 void cpu_watchpoint_remove_all(CPUState *cpu, int mask);
 void cpu_check_watchpoint(CPUState *cpu, vaddr addr, vaddr len,
                           MemTxAttrs attrs, int flags, uintptr_t ra);
+int cpu_watchpoint_address_matches(CPUState *cpu, vaddr addr, vaddr len);
 #endif
 
 /**
diff --git a/exec.c b/exec.c
index cb6f5763dc..8575ce51ad 100644
--- a/exec.c
+++ b/exec.c
@@ -1138,9 +1138,8 @@ void cpu_watchpoint_remove_all(CPUState *cpu, int mask)
  * partially or completely with the address range covered by the
  * access).
  */
-static inline bool cpu_watchpoint_address_matches(CPUWatchpoint *wp,
-                                                  vaddr addr,
-                                                  vaddr len)
+static inline bool watchpoint_address_matches(CPUWatchpoint *wp,
+                                              vaddr addr, vaddr len)
 {
     /* We know the lengths are non-zero, but a little caution is
      * required to avoid errors in the case where the range ends
@@ -1152,6 +1151,20 @@ static inline bool cpu_watchpoint_address_matches(CPUWatchpoint *wp,
 
     return !(addr > wpend || wp->vaddr > addrend);
 }
+
+/* Return flags for watchpoints that match addr + prot.  */
+int cpu_watchpoint_address_matches(CPUState *cpu, vaddr addr, vaddr len)
+{
+    CPUWatchpoint *wp;
+    int ret = 0;
+
+    QTAILQ_FOREACH(wp, &cpu->watchpoints, entry) {
+        if (watchpoint_address_matches(wp, addr, TARGET_PAGE_SIZE)) {
+            ret |= wp->flags;
+        }
+    }
+    return ret;
+}
 #endif /* !CONFIG_USER_ONLY */
 
 /* Add a breakpoint.  */
@@ -1459,7 +1472,7 @@ hwaddr memory_region_section_get_iotlb(CPUState *cpu,
                                        target_ulong *address)
 {
     hwaddr iotlb;
-    CPUWatchpoint *wp;
+    int flags, match;
 
     if (memory_region_is_ram(section->mr)) {
         /* Normal RAM.  */
@@ -1477,17 +1490,17 @@ hwaddr memory_region_section_get_iotlb(CPUState *cpu,
         iotlb += xlat;
     }
 
-    /* Make accesses to pages with watchpoints go via the
-       watchpoint trap routines.  */
-    QTAILQ_FOREACH(wp, &cpu->watchpoints, entry) {
-        if (cpu_watchpoint_address_matches(wp, vaddr, TARGET_PAGE_SIZE)) {
-            /* Avoid trapping reads of pages with a write breakpoint. */
-            if ((prot & PAGE_WRITE) || (wp->flags & BP_MEM_READ)) {
-                iotlb = PHYS_SECTION_WATCH + paddr;
-                *address |= TLB_MMIO;
-                break;
-            }
-        }
+    /* Avoid trapping reads of pages with a write breakpoint. */
+    match = (prot & PAGE_READ ? BP_MEM_READ : 0)
+          | (prot & PAGE_WRITE ? BP_MEM_WRITE : 0);
+    flags = cpu_watchpoint_address_matches(cpu, vaddr, TARGET_PAGE_SIZE);
+    if (flags & match) {
+        /*
+         * Make accesses to pages with watchpoints go via the
+         * watchpoint trap routines.
+         */
+        iotlb = PHYS_SECTION_WATCH + paddr;
+        *address |= TLB_MMIO;
     }
 
     return iotlb;
@@ -2806,7 +2819,7 @@ void cpu_check_watchpoint(CPUState *cpu, vaddr addr, vaddr len,
 
     addr = cc->adjust_watchpoint_address(cpu, addr, len);
     QTAILQ_FOREACH(wp, &cpu->watchpoints, entry) {
-        if (cpu_watchpoint_address_matches(wp, addr, len)
+        if (watchpoint_address_matches(wp, addr, len)
             && (wp->flags & flags)) {
             if (flags == BP_MEM_READ) {
                 wp->flags |= BP_WATCHPOINT_HIT_READ;
-- 
2.17.1


