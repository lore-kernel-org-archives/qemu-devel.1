Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1707C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 14:17:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B7AC2074B
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 14:17:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O/UzJXiE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B7AC2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49442 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtXMa-0005kc-Nr
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 10:17:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50858)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jtXIv-0000E0-7f
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 10:13:37 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:42831)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jtXIt-0001KR-Bw
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 10:13:36 -0400
Received: by mail-wr1-x443.google.com with SMTP id o11so2546071wrv.9
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2020 07:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ZNov9lr+FZ+BjQf8kZgYjYTcVUA09W56mHbfjcwgZik=;
 b=O/UzJXiEig3CtucaVVXV5U68ZCURQLwvdnnExUD+ttIk/gOz5xPsmp1Zo+5vasz6Ru
 BywmeDT7RGDM+tGOh+YyZEE0coO/rpfEo7TmuCkqi8Z/lOiSUWos+owG9Mqhq2VQqn6V
 dySPv5dZ9uGzBtU4rYt40DAmRUOIU7bmFO02RR2HsHEb3fK/s4hdRW7swEQzMrAs1CFy
 n0rrhEfP560Y7regfQk3Nnzid4szaV0C3dGlsAxbSSh+1B+cHQ1Oa4wXkxNVGV0+ZIXy
 k8Xm89UDQo9pw7oVelVnIUe+20XaPHvMq8g+WbgRS9iO+ialVqzaI/A/deECzMTdPlPH
 EfAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ZNov9lr+FZ+BjQf8kZgYjYTcVUA09W56mHbfjcwgZik=;
 b=oxDU7HhYdIp5/CQjYVD2GBcwCc37HFkjvInhCfZmvfhLFXqGLII8TKsIpesEhF9muW
 0kmYXFZdaF7jadx+HPxqAyhThn8BxOYwiJw0J7KCs/XCR202p399b4zdb3lnE7exXJoA
 Vsv2TTTVYEQVwxi0wxZZ9bJnyLGaq4lT/AtoOHW+hLA1BIoXNMbLrENn8gxd2RkxUzDZ
 qlCJrNyXx5nOvcxq/2bXCwVJOzzx4uSj/VbP7o+gty0cM41As/xCx51qbFNtZW9IfFr+
 eV6adjZAUUiMChfpdE6GE6Zk8s2S/uOVHQ8gqcewwjxfoK1+q0fwMPXhJNG2X6c7OiDx
 fFMA==
X-Gm-Message-State: AOAM533C2xYTrN8JMsWWfkuJTRYfzr1D56G97EpVBCFJL9xG3nwWXiEo
 usLv5SmM8Iskp9w5cAx3KIRFOw==
X-Google-Smtp-Source: ABdhPJwR4z6mnEv6qG6I3HQ7EqX6m4GRuUIbx8mabyea+1/qPTCAk4lg5ITW+PIp3hlLpWvnQpusMg==
X-Received: by 2002:a5d:6748:: with SMTP id l8mr70667319wrw.347.1594304013905; 
 Thu, 09 Jul 2020 07:13:33 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id m16sm6378753wro.0.2020.07.09.07.13.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2020 07:13:29 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id BCC421FF90;
 Thu,  9 Jul 2020 15:13:27 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 04/13] cputlb: ensure we save the IOTLB data in case of
 reset
Date: Thu,  9 Jul 2020 15:13:18 +0100
Message-Id: <20200709141327.14631-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200709141327.14631-1-alex.bennee@linaro.org>
References: <20200709141327.14631-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x443.google.com
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
---
 include/hw/core/cpu.h   |  4 +++
 include/qemu/typedefs.h |  1 +
 accel/tcg/cputlb.c      | 57 +++++++++++++++++++++++++++++++++++++++--
 3 files changed, 60 insertions(+), 2 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index b3f4b7931823..bedbf098dc57 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -417,7 +417,11 @@ struct CPUState {
 
     DECLARE_BITMAP(plugin_mask, QEMU_PLUGIN_EV_MAX);
 
+#ifdef CONFIG_PLUGIN
     GArray *plugin_mem_cbs;
+    /* saved iotlb data from io_writex */
+    SavedIOTLB *saved_iotlb;
+#endif
 
     /* TODO Move common fields from CPUArchState here. */
     int cpu_index;
diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
index 15f5047bf1dc..427027a9707a 100644
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
index 1e815357c709..8636b66e036a 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1073,6 +1073,42 @@ static uint64_t io_readx(CPUArchState *env, CPUIOTLBEntry *iotlbentry,
     return val;
 }
 
+#ifdef CONFIG_PLUGIN
+
+typedef struct SavedIOTLB {
+    struct rcu_head rcu;
+    hwaddr addr;
+    MemoryRegionSection *section;
+    hwaddr mr_offset;
+} SavedIOTLB;
+
+/*
+ * Save a potentially trashed IOTLB entry for later lookup by plugin.
+ *
+ * We also need to track the thread storage address because the RCU
+ * cleanup that runs when we leave the critical region (the current
+ * execution) is actually in a different thread.
+ */
+static void save_iotlb_data(CPUState *cs, hwaddr addr, MemoryRegionSection *section, hwaddr mr_offset)
+{
+    SavedIOTLB *old, *new = g_new(SavedIOTLB, 1);
+    new->addr = addr;
+    new->section = section;
+    new->mr_offset = mr_offset;
+    old = atomic_rcu_read(&cs->saved_iotlb);
+    atomic_rcu_set(&cs->saved_iotlb, new);
+    if (old) {
+        g_free_rcu(old, rcu);
+    }
+}
+
+#else
+static void save_iotlb_data(CPUState *cs, hwaddr addr, MemoryRegionSection *section, hwaddr mr_offset)
+{
+    /* do nothing */
+}
+#endif
+
 static void io_writex(CPUArchState *env, CPUIOTLBEntry *iotlbentry,
                       int mmu_idx, uint64_t val, target_ulong addr,
                       uintptr_t retaddr, MemOp op)
@@ -1092,6 +1128,12 @@ static void io_writex(CPUArchState *env, CPUIOTLBEntry *iotlbentry,
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
@@ -1381,8 +1423,11 @@ void *tlb_vaddr_to_host(CPUArchState *env, abi_ptr addr,
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
@@ -1406,6 +1451,14 @@ bool tlb_plugin_lookup(CPUState *cpu, target_ulong addr, int mmu_idx,
             data->v.ram.hostaddr = addr + tlbe->addend;
         }
         return true;
+    } else {
+        SavedIOTLB *saved = atomic_rcu_read(&cpu->saved_iotlb);
+        if (saved && saved->addr == tlb_addr) {
+            data->is_io = true;
+            data->v.io.section = saved->section;
+            data->v.io.offset = saved->mr_offset;
+            return true;
+        }
     }
     return false;
 }
-- 
2.20.1


