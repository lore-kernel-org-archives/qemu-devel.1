Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8340CC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 20:06:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54BAF20674
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 20:06:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R7KFLfXv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54BAF20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48854 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jv4iv-0004Fq-Ls
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 16:06:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59486)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jv4ge-000856-2L
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 16:04:28 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:44885)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jv4gc-0006IH-3A
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 16:04:27 -0400
Received: by mail-wr1-x444.google.com with SMTP id b6so18142398wrs.11
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2020 13:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=kb87PAc0ILcvwPMRDtx1z2EyoH/JKtctRlrd2cWmYmY=;
 b=R7KFLfXvss6QA1s0lF4F3JbssBLto2qMYIIrmbreQJg1sgVQjo8itdImO5QxDT8A4k
 nnARnsGWE5+oopWZMkD0YIUkdckB9oFrA2G3o9DDVQe1Q5+kcRN82vYTaFLkQz9UCmDz
 vXA2eukaqhUEsffy5XUmju1jdRKnSVM1U5r+Db56u75Ws+IFIGdxWDJzf9XYxWGsbN7t
 PiHWwUpGmI/39h01NM7SaGZwjcLPyRhwOIabQmgfzW3AaqegWEqaWWqVUTGSCChw0qxV
 k68wV2Qluqy1OhnlEPfUvAKTTlBpquyLcNoriRz5HsbWrPCAiaDmDLua/vqh9KMRUPH+
 6g5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=kb87PAc0ILcvwPMRDtx1z2EyoH/JKtctRlrd2cWmYmY=;
 b=A+b9V702TiLZUZUh7HEm7FVA9/MccOA58uY1TBPno88ByfmpwvFuYFLzqA1XQ1RHoz
 ZnIVqPJI3NRg+8qdnE9GsbR9Kmgf4Lp9VThEqpOYNL5cxQ0dI6I8KR6fQgxjb3tTmBx/
 NSU4BvRaPu/TlZ6AceT3uFSylZ2UDBJcpaO/BLVSUMxitObDPv+EbbW7PI4kOepbDYW5
 8ftT+GzjAStoGH5puubIsMNOtLed1XKKMjviFeut+yGRR05pCusa7gjClH53IZQF914y
 CbH0w2uul8imac+ey+T2wqEbiqYhrpaUJ3zlKipA5Pm0qCzdoCSHf0CBtQ9K3qQYk5KP
 VT9w==
X-Gm-Message-State: AOAM5319JFOfoP6Vgs3m917mseimHaScoQrWpzmlRy6lw+VYMWeGFzF/
 TQODAzB9u747yTlwrjQotAkcSA==
X-Google-Smtp-Source: ABdhPJwUyLxRrB1B22Q9XU6df9A42VKwqlpGTi3eVSOW0naoJZTIgfVAJDLs8boUFGlZ6P6ycW+ATg==
X-Received: by 2002:adf:ff90:: with SMTP id j16mr1183783wrr.364.1594670664723; 
 Mon, 13 Jul 2020 13:04:24 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id k131sm874059wmb.36.2020.07.13.13.04.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2020 13:04:22 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 2C8A01FF92;
 Mon, 13 Jul 2020 21:04:16 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 06/11] cputlb: ensure we save the IOTLB data in case of
 reset
Date: Mon, 13 Jul 2020 21:04:10 +0100
Message-Id: <20200713200415.26214-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200713200415.26214-1-alex.bennee@linaro.org>
References: <20200713200415.26214-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: fam@euphon.net, berrange@redhat.com, robert.foley@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org, robhenry@microsoft.com,
 aaron@os.amperecomputing.com, cota@braap.org, kuhn.chenqun@huawei.com,
 peter.puhov@linaro.org, Eduardo Habkost <ehabkost@redhat.com>,
 aurelien@aurel32.net, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Any write to a device might cause a re-arrangement of memory
triggering a TLB flush and potential re-size of the TLB invalidating
previous entries. This would cause users of qemu_plugin_get_hwaddr()
to see the warning:

  invalid use of qemu_plugin_get_hwaddr

because of the failed tlb_lookup which should always succeed. To
prevent this we save the IOTLB data in case it is later needed by a
plugin doing a lookup.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - save the entry instead of re-running the tlb_fill.
v3
  - don't abuse TLS, use CPUState to store data
  - just use g_free_rcu() to avoid ugliness
  - verify addr matches before returning data
  - ws fix
v4
  - don't both with RCU, just store it in CPUState
  - clean-up #ifdef'ery
  - checkpatch
---
 include/hw/core/cpu.h   | 16 ++++++++++++++++
 include/qemu/typedefs.h |  1 +
 accel/tcg/cputlb.c      | 38 +++++++++++++++++++++++++++++++++++---
 3 files changed, 52 insertions(+), 3 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 5542577d2b..8f145733ce 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -259,6 +259,18 @@ struct CPUWatchpoint {
     QTAILQ_ENTRY(CPUWatchpoint) entry;
 };
 
+#ifdef CONFIG_PLUGIN
+/*
+ * For plugins we sometime need to save the resolved iotlb data before
+ * the memory regions get moved around  by io_writex.
+ */
+typedef struct SavedIOTLB {
+    hwaddr addr;
+    MemoryRegionSection *section;
+    hwaddr mr_offset;
+} SavedIOTLB;
+#endif
+
 struct KVMState;
 struct kvm_run;
 
@@ -417,7 +429,11 @@ struct CPUState {
 
     DECLARE_BITMAP(plugin_mask, QEMU_PLUGIN_EV_MAX);
 
+#ifdef CONFIG_PLUGIN
     GArray *plugin_mem_cbs;
+    /* saved iotlb data from io_writex */
+    SavedIOTLB saved_iotlb;
+#endif
 
     /* TODO Move common fields from CPUArchState here. */
     int cpu_index;
diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
index 15f5047bf1..427027a970 100644
--- a/include/qemu/typedefs.h
+++ b/include/qemu/typedefs.h
@@ -116,6 +116,7 @@ typedef struct QObject QObject;
 typedef struct QString QString;
 typedef struct RAMBlock RAMBlock;
 typedef struct Range Range;
+typedef struct SavedIOTLB SavedIOTLB;
 typedef struct SHPCDevice SHPCDevice;
 typedef struct SSIBus SSIBus;
 typedef struct VirtIODevice VirtIODevice;
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 1e815357c7..d370aedb47 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1073,6 +1073,24 @@ static uint64_t io_readx(CPUArchState *env, CPUIOTLBEntry *iotlbentry,
     return val;
 }
 
+/*
+ * Save a potentially trashed IOTLB entry for later lookup by plugin.
+ *
+ * We also need to track the thread storage address because the RCU
+ * cleanup that runs when we leave the critical region (the current
+ * execution) is actually in a different thread.
+ */
+static void save_iotlb_data(CPUState *cs, hwaddr addr,
+                            MemoryRegionSection *section, hwaddr mr_offset)
+{
+#ifdef CONFIG_PLUGIN
+    SavedIOTLB *saved = &cs->saved_iotlb;
+    saved->addr = addr;
+    saved->section = section;
+    saved->mr_offset = mr_offset;
+#endif
+}
+
 static void io_writex(CPUArchState *env, CPUIOTLBEntry *iotlbentry,
                       int mmu_idx, uint64_t val, target_ulong addr,
                       uintptr_t retaddr, MemOp op)
@@ -1092,6 +1110,12 @@ static void io_writex(CPUArchState *env, CPUIOTLBEntry *iotlbentry,
     }
     cpu->mem_io_pc = retaddr;
 
+    /*
+     * The memory_region_dispatch may trigger a flush/resize
+     * so for plugins we save the iotlb_data just in case.
+     */
+    save_iotlb_data(cpu, iotlbentry->addr, section, mr_offset);
+
     if (mr->global_locking && !qemu_mutex_iothread_locked()) {
         qemu_mutex_lock_iothread();
         locked = true;
@@ -1381,8 +1405,11 @@ void *tlb_vaddr_to_host(CPUArchState *env, abi_ptr addr,
  * in the softmmu lookup code (or helper). We don't handle re-fills or
  * checking the victim table. This is purely informational.
  *
- * This should never fail as the memory access being instrumented
- * should have just filled the TLB.
+ * This almost never fails as the memory access being instrumented
+ * should have just filled the TLB. The one corner case is io_writex
+ * which can cause TLB flushes and potential resizing of the TLBs
+ * loosing the information we need. In those cases we need to recover
+ * data from a copy of the io_tlb entry.
  */
 
 bool tlb_plugin_lookup(CPUState *cpu, target_ulong addr, int mmu_idx,
@@ -1406,8 +1433,13 @@ bool tlb_plugin_lookup(CPUState *cpu, target_ulong addr, int mmu_idx,
             data->v.ram.hostaddr = addr + tlbe->addend;
         }
         return true;
+    } else {
+        SavedIOTLB *saved = &cpu->saved_iotlb;
+        data->is_io = true;
+        data->v.io.section = saved->section;
+        data->v.io.offset = saved->mr_offset;
+        return true;
     }
-    return false;
 }
 
 #endif
-- 
2.20.1


