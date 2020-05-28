Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06C78C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 19:39:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C69F72078C
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 19:39:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="sPN0nEcd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C69F72078C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yadro.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59504 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeOMw-0001h5-Uj
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 15:39:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49264)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.bolshakov@yadro.com>)
 id 1jeOLv-000065-Gk
 for qemu-devel@nongnu.org; Thu, 28 May 2020 15:38:07 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:35486 helo=mta-01.yadro.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.bolshakov@yadro.com>)
 id 1jeOLt-00072e-Od
 for qemu-devel@nongnu.org; Thu, 28 May 2020 15:38:07 -0400
Received: from localhost (unknown [127.0.0.1])
 by mta-01.yadro.com (Postfix) with ESMTP id 17D114C868;
 Thu, 28 May 2020 19:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
 content-type:content-type:content-transfer-encoding:mime-version
 :references:in-reply-to:x-mailer:message-id:date:date:subject
 :subject:from:from:received:received:received; s=mta-01; t=
 1590694680; x=1592509081; bh=yRdfGU9O+jIl5jsoVFny8UUmigYXZvuMb+P
 sqxYq3VY=; b=sPN0nEcdPLV8Tf1RAtTKR7owFwpuYCOCetSxlBaVx2SOPisoMOp
 CNt8ewUsh5GGlD9GYW7wgNXWiHPUCJ+3k7N3I6iTgcnGKGwMMw5KuI9BZK/GEDGP
 rhTJ56mkKeurOeUgr4U7M42EL3W4+pLv8BUheqTDyouJCjTxcqbvngek=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
 by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FCN5hINCjKg8; Thu, 28 May 2020 22:38:00 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com
 [172.17.10.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by mta-01.yadro.com (Postfix) with ESMTPS id 865E741227;
 Thu, 28 May 2020 22:38:00 +0300 (MSK)
Received: from localhost (172.17.204.212) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Thu, 28
 May 2020 22:38:01 +0300
From: Roman Bolshakov <r.bolshakov@yadro.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH 02/13] i386: hvf: Drop useless declarations in sysemu
Date: Thu, 28 May 2020 22:37:47 +0300
Message-ID: <20200528193758.51454-3-r.bolshakov@yadro.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200528193758.51454-1-r.bolshakov@yadro.com>
References: <20200528193758.51454-1-r.bolshakov@yadro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.17.204.212]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
Received-SPF: pass client-ip=89.207.88.252; envelope-from=r.bolshakov@yadro.com;
 helo=mta-01.yadro.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 15:38:02
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Roman Bolshakov <r.bolshakov@yadro.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Cameron Esfahani <dirty@apple.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

They're either declared elsewhere or have no use.

While at it, rename _hvf_cpu_synchronize_post_init() to
do_hvf_cpu_synchronize_post_init().

Signed-off-by: Roman Bolshakov <r.bolshakov@yadro.com>
---
 include/sysemu/hvf.h  | 22 ----------------------
 target/i386/hvf/hvf.c |  7 ++++---
 2 files changed, 4 insertions(+), 25 deletions(-)

diff --git a/include/sysemu/hvf.h b/include/sysemu/hvf.h
index 30a565ab73..03f3cd7db3 100644
--- a/include/sysemu/hvf.h
+++ b/include/sysemu/hvf.h
@@ -30,35 +30,13 @@ uint32_t hvf_get_supported_cpuid(uint32_t func, uint32_t idx,
 #define hvf_get_supported_cpuid(func, idx, reg) 0
 #endif
 
-/* Disable HVF if |disable| is 1, otherwise, enable it iff it is supported by
- * the host CPU. Use hvf_enabled() after this to get the result. */
-void hvf_disable(int disable);
-
-/* Returns non-0 if the host CPU supports the VMX "unrestricted guest" feature
- * which allows the virtual CPU to directly run in "real mode". If true, this
- * allows QEMU to run several vCPU threads in parallel (see cpus.c). Otherwise,
- * only a a single TCG thread can run, and it will call HVF to run the current
- * instructions, except in case of "real mode" (paging disabled, typically at
- * boot time), or MMIO operations. */
-
-int hvf_sync_vcpus(void);
-
 int hvf_init_vcpu(CPUState *);
 int hvf_vcpu_exec(CPUState *);
-int hvf_smp_cpu_exec(CPUState *);
 void hvf_cpu_synchronize_state(CPUState *);
 void hvf_cpu_synchronize_post_reset(CPUState *);
 void hvf_cpu_synchronize_post_init(CPUState *);
-void _hvf_cpu_synchronize_post_init(CPUState *, run_on_cpu_data);
-
 void hvf_vcpu_destroy(CPUState *);
-void hvf_raise_event(CPUState *);
-/* void hvf_reset_vcpu_state(void *opaque); */
 void hvf_reset_vcpu(CPUState *);
-void vmx_update_tpr(CPUState *);
-void update_apic_tpr(CPUState *);
-int hvf_put_registers(CPUState *);
-void vmx_clear_int_window_exiting(CPUState *cpu);
 
 #define TYPE_HVF_ACCEL ACCEL_CLASS_NAME("hvf")
 
diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index d72543dc31..9ccdb7e7c7 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -251,7 +251,7 @@ void vmx_update_tpr(CPUState *cpu)
     }
 }
 
-void update_apic_tpr(CPUState *cpu)
+static void update_apic_tpr(CPUState *cpu)
 {
     X86CPU *x86_cpu = X86_CPU(cpu);
     int tpr = rreg(cpu->hvf_fd, HV_X86_TPR) >> 4;
@@ -312,7 +312,8 @@ void hvf_cpu_synchronize_post_reset(CPUState *cpu_state)
     run_on_cpu(cpu_state, do_hvf_cpu_synchronize_post_reset, RUN_ON_CPU_NULL);
 }
 
-void _hvf_cpu_synchronize_post_init(CPUState *cpu, run_on_cpu_data arg)
+static void do_hvf_cpu_synchronize_post_init(CPUState *cpu,
+                                             run_on_cpu_data arg)
 {
     CPUState *cpu_state = cpu;
     hvf_put_registers(cpu_state);
@@ -321,7 +322,7 @@ void _hvf_cpu_synchronize_post_init(CPUState *cpu, run_on_cpu_data arg)
 
 void hvf_cpu_synchronize_post_init(CPUState *cpu_state)
 {
-    run_on_cpu(cpu_state, _hvf_cpu_synchronize_post_init, RUN_ON_CPU_NULL);
+    run_on_cpu(cpu_state, do_hvf_cpu_synchronize_post_init, RUN_ON_CPU_NULL);
 }
 
 static bool ept_emulation_fault(hvf_slot *slot, uint64_t gpa, uint64_t ept_qual)
-- 
2.26.1


