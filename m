Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95FCCFA372A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 14:50:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F68220854
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 14:50:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DnAvsztg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F68220854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49728 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL771-0004XI-PZ
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 10:50:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37665)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iL5wH-00064Y-62
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:35:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iL5wF-0004ZU-3t
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:35:37 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:55594)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iL5wD-0004WI-5C
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:35:35 -0400
Received: by mail-wm1-x344.google.com with SMTP id a6so2585675wma.5
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 06:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ciNF6SAJRuOiY+C5HOxCQCLrm7QppdZGV2meoQ3PBRA=;
 b=DnAvsztgNa1vT56WhOo9VNDKcAc/61/H8LUvYRGeiuJ3Yo1lQHhrVOytHJxH0Dgq5Y
 zC2d/Pz0p7a1naUu9vtoFP0HCmxJK7pULWMKA8I5ZNTtHKxV9/e+NlvaauyuRGyVQwTX
 z0epBWsRkGpLA6FE8H++4qSx1Gh1Ae7vlKM4FEwassjZARu0BXj9iLbQIYQXSCK3z4U9
 CrOAK95H/gcyCT1qY596LtrcFPl2NEFkZ4X3RwIVeA3KlVdwTozd5gd8nQIqo9uiTx7e
 auBfAA9vT5BU+xGs9dE3ZbfPxnduVb/7GPSWIAmm7CWZ8Q3zwQf0VyIEUdpeEYMWTxc8
 wxxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ciNF6SAJRuOiY+C5HOxCQCLrm7QppdZGV2meoQ3PBRA=;
 b=bpSK7A/m6zNzclnCkavXLLEUxh9L52vRhU32oosRx9lqVRtOXSjvE9J7C6kljGXyzx
 FT7x6H1HG9f1QLGSOCi4rMTwjFuRwOeNPzY+wh3TyHhZh0dNK3/a/orQCqNrnNqGmMQ+
 cD+8BMY4XTYjJj4rq0QOZwHUBIgGbjv2Jl/TEEL0HXcstFW/dit7217rLdMsSPqAxFly
 uPaPdEUORYmHQ6lKVZ9l/XBCDOYIliKl4Tj24a6LFT9d0PsGNfUWYohqv9CYoPofPHFK
 2tlujyzj0uN6wLsqBonUPzY82HNvSn+fP9F2w01a8egil6FWknaZO61b7lkQcpAh/kyd
 XXXg==
X-Gm-Message-State: APjAAAWTmMj0SaU2bqiEJj266O5x++B7qezB/h1IEkuD8h+TpQ/bPfHJ
 kTitw33WXi8S7oBFtDD9HlOvuQ==
X-Google-Smtp-Source: APXvYqxJL4IDoxCqqdM+GWWyMINxKi9lylp6CKdgb3ThSLvQrvL1zl95qgjYGIsTI5I+qNIzviWXjg==
X-Received: by 2002:a05:600c:2196:: with SMTP id
 e22mr201555wme.79.1571319331868; 
 Thu, 17 Oct 2019 06:35:31 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id q19sm2908150wra.89.2019.10.17.06.35.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2019 06:35:30 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 74C831FF9F;
 Thu, 17 Oct 2019 14:16:17 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v6 16/54] plugins: implement helpers for resolving hwaddr
Date: Thu, 17 Oct 2019 14:15:37 +0100
Message-Id: <20191017131615.19660-17-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191017131615.19660-1-alex.bennee@linaro.org>
References: <20191017131615.19660-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
Cc: robert.foley@futurewei.com,
 Richard Henderson <richard.henderson@linaro.org>, peter.puhov@futurewei.com,
 aaron@os.amperecomputing.com, cota@braap.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We need to keep a local per-cpu copy of the data as other threads may
be running. Currently we can provide insight as to if the access was
IO or not and give the offset into a given device (usually the main
RAMBlock). We store enough information to get details such as the
MemoryRegion which might be useful in later expansions to the API.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
v5
  - use TLS instead of racy GArray
  - add more commentary regarding success
  - error_report if we fail
v6
  - rename api to qemu_plugin_hwaddr_device_offset
  - also save iotlb details for IO accesses.
  - keep memory api header details in separate header
---
 accel/tcg/cputlb.c           | 42 +++++++++++++++++++++++++++++++
 include/qemu/plugin-memory.h | 40 +++++++++++++++++++++++++++++
 include/qemu/qemu-plugin.h   |  8 ++++++
 plugins/api.c                | 49 ++++++++++++++++++++++++++++++++++++
 4 files changed, 139 insertions(+)
 create mode 100644 include/qemu/plugin-memory.h

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 82282d30d9..2c06b57272 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -34,6 +34,9 @@
 #include "qemu/atomic.h"
 #include "qemu/atomic128.h"
 #include "translate-all.h"
+#ifdef CONFIG_PLUGIN
+#include "qemu/plugin-memory.h"
+#endif
 
 /* DEBUG defines, enable DEBUG_TLB_LOG to log to the CPU_LOG_MMU target */
 /* #define DEBUG_TLB */
@@ -1247,6 +1250,45 @@ void *tlb_vaddr_to_host(CPUArchState *env, abi_ptr addr,
     return (void *)((uintptr_t)addr + entry->addend);
 }
 
+
+#ifdef CONFIG_PLUGIN
+/*
+ * Perform a TLB lookup and populate the qemu_plugin_hwaddr structure.
+ * This should be a hot path as we will have just looked this path up
+ * in the softmmu lookup code (or helper). We don't handle re-fills or
+ * checking the victim table. This is purely informational.
+ *
+ * This should never fail as the memory access being instrumented
+ * should have just filled the TLB.
+ */
+
+bool tlb_plugin_lookup(CPUState *cpu, target_ulong addr, int mmu_idx,
+                       bool is_store, struct qemu_plugin_hwaddr *data)
+{
+    CPUArchState *env = cpu->env_ptr;
+    CPUTLBEntry *tlbe = tlb_entry(env, mmu_idx, addr);
+    uintptr_t index = tlb_index(env, mmu_idx, addr);
+    target_ulong tlb_addr = is_store ? tlb_addr_write(tlbe) : tlbe->addr_read;
+
+    if (likely(tlb_hit(tlb_addr, addr))) {
+        /* We must have an iotlb entry for MMIO */
+        if (tlb_addr & TLB_MMIO) {
+            CPUIOTLBEntry *iotlbentry;
+            iotlbentry = &env_tlb(env)->d[mmu_idx].iotlb[index];
+            data->is_io = true;
+            data->v.io.section = iotlb_to_section(cpu, iotlbentry->addr, iotlbentry->attrs);
+            data->v.io.offset = (iotlbentry->addr & TARGET_PAGE_MASK) + addr;
+        } else {
+            data->is_io = false;
+            data->v.ram.hostaddr = addr + tlbe->addend;
+        }
+        return true;
+    }
+    return false;
+}
+
+#endif
+
 /* Probe for a read-modify-write atomic operation.  Do not allow unaligned
  * operations, or io operations to proceed.  Return the host address.  */
 static void *atomic_mmu_lookup(CPUArchState *env, target_ulong addr,
diff --git a/include/qemu/plugin-memory.h b/include/qemu/plugin-memory.h
new file mode 100644
index 0000000000..fbbe99474b
--- /dev/null
+++ b/include/qemu/plugin-memory.h
@@ -0,0 +1,40 @@
+/*
+ * Plugin Memory API
+ *
+ * Copyright (c) 2019 Linaro Ltd
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef _PLUGIN_MEMORY_H_
+#define _PLUGIN_MEMORY_H_
+
+struct qemu_plugin_hwaddr {
+    bool is_io;
+    bool is_store;
+    union {
+        struct {
+            MemoryRegionSection *section;
+            hwaddr    offset;
+        } io;
+        struct {
+            uint64_t hostaddr;
+        } ram;
+    } v;
+};
+
+/**
+ * tlb_plugin_lookup: query last TLB lookup
+ * @cpu: cpu environment
+ *
+ * This function can be used directly after a memory operation to
+ * query information about the access. It is used by the plugin
+ * infrastructure to expose more information about the address.
+ *
+ * It would only fail if not called from an instrumented memory access
+ * which would be an abuse of the API.
+ */
+bool tlb_plugin_lookup(CPUState *cpu, target_ulong addr, int mmu_idx,
+                       bool is_store, struct qemu_plugin_hwaddr *data);
+
+#endif /* _PLUGIN_MEMORY_H_ */
diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
index b9a4a4b684..c213d1dd19 100644
--- a/include/qemu/qemu-plugin.h
+++ b/include/qemu/qemu-plugin.h
@@ -285,6 +285,14 @@ bool qemu_plugin_mem_is_store(qemu_plugin_meminfo_t info);
 struct qemu_plugin_hwaddr *qemu_plugin_get_hwaddr(qemu_plugin_meminfo_t info,
                                                   uint64_t vaddr);
 
+/*
+ * The following additional queries can be run on the hwaddr structure
+ * to return information about it. For non-IO accesses the device
+ * offset will be into the appropriate block of RAM.
+ */
+bool qemu_plugin_hwaddr_is_io(struct qemu_plugin_hwaddr *hwaddr);
+uint64_t qemu_plugin_hwaddr_device_offset(const struct qemu_plugin_hwaddr *haddr);
+
 typedef void
 (*qemu_plugin_vcpu_mem_cb_t)(unsigned int vcpu_index,
                              qemu_plugin_meminfo_t info, uint64_t vaddr,
diff --git a/plugins/api.c b/plugins/api.c
index facf2a132d..33dac8e790 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -42,6 +42,7 @@
 #include "trace/mem-internal.h" /* mem_info macros */
 #include "plugin.h"
 #ifndef CONFIG_USER_ONLY
+#include "qemu/plugin-memory.h"
 #include "hw/boards.h"
 #endif
 
@@ -240,11 +241,59 @@ bool qemu_plugin_mem_is_store(qemu_plugin_meminfo_t info)
  * Virtual Memory queries
  */
 
+#ifdef CONFIG_SOFTMMU
+static __thread struct qemu_plugin_hwaddr hwaddr_info;
+
+struct qemu_plugin_hwaddr *qemu_plugin_get_hwaddr(qemu_plugin_meminfo_t info,
+                                                  uint64_t vaddr)
+{
+    CPUState *cpu = current_cpu;
+    unsigned int mmu_idx = info >> TRACE_MEM_MMU_SHIFT;
+    hwaddr_info.is_store = info & TRACE_MEM_ST;
+
+    if (!tlb_plugin_lookup(cpu, vaddr, mmu_idx,
+                           info & TRACE_MEM_ST, &hwaddr_info)) {
+        error_report("invalid use of qemu_plugin_get_hwaddr");
+        return NULL;
+    }
+
+    return &hwaddr_info;
+}
+#else
 struct qemu_plugin_hwaddr *qemu_plugin_get_hwaddr(qemu_plugin_meminfo_t info,
                                                   uint64_t vaddr)
 {
     return NULL;
 }
+#endif
+
+bool qemu_plugin_hwaddr_is_io(struct qemu_plugin_hwaddr *hwaddr)
+{
+#ifdef CONFIG_SOFTMMU
+    return hwaddr->is_io;
+#else
+    return false;
+#endif
+}
+
+uint64_t qemu_plugin_hwaddr_device_offset(const struct qemu_plugin_hwaddr *haddr)
+{
+#ifdef CONFIG_SOFTMMU
+    if (haddr) {
+        if (!haddr->is_io) {
+            ram_addr_t ram_addr = qemu_ram_addr_from_host((void *) haddr->v.ram.hostaddr);
+            if (ram_addr == RAM_ADDR_INVALID) {
+                error_report("Bad ram pointer %"PRIx64"", haddr->v.ram.hostaddr);
+                abort();
+            }
+            return ram_addr;
+        } else {
+            return haddr->v.io.offset;
+        }
+    }
+#endif
+    return 0;
+}
 
 /*
  * Queries to the number and potential maximum number of vCPUs there
-- 
2.20.1


