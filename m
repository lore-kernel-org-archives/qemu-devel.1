Return-Path: <SRS0=LbB6=TD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A959DC43219
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 06:00:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6062B206DF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 06:00:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m7GuNIGI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6062B206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35027 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMRF1-0002Rj-Ji
	for qemu-devel@archiver.kernel.org; Fri, 03 May 2019 02:00:15 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54832)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1hMR9W-0005lI-H2
	for qemu-devel@nongnu.org; Fri, 03 May 2019 01:54:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1hMR9V-0003P4-84
	for qemu-devel@nongnu.org; Fri, 03 May 2019 01:54:34 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:44364)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sjitindarsingh@gmail.com>)
	id 1hMR9U-0003Nt-Uw; Fri, 03 May 2019 01:54:33 -0400
Received: by mail-pf1-x443.google.com with SMTP id y13so2338099pfm.11;
	Thu, 02 May 2019 22:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=elRKXRVfoRQF6uK9NfqLi1F1+jjT6vwp9JP7+Qj3qL8=;
	b=m7GuNIGIkKmPcpaO9FwVC6S1nQRAN7bQfY8NDbSNfT64HO5rAlBsJ0tYIsFmWU9ThS
	x8gzYQUn5vwPU8xQ5cOLsC3cUsgSx7ptPYZg58zYaQtlcQTGdviN82E+65loV63rNVCq
	JR01GuBG0A2xd/T8WE6nrZjGL8Y3psbosEEVl1xpuLQta0q6jK0yNQWLn6D8L2R/0ABq
	4rEFIDYtUKEN4BxIRf0bNUFGLJWdiaOP7XKWhG/wYsB1G4JGwJvTpi90mXi4mVNMPs6T
	lxBJGlj6/ybsaoDQOPA6BI0xw1crIwHHGO1/ukheQAP+FLN2oOkEofjdkRfCcIS/hHAC
	n/DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=elRKXRVfoRQF6uK9NfqLi1F1+jjT6vwp9JP7+Qj3qL8=;
	b=RbAbeDmk6CMfJunIqTkhS/swuyOZ3NgRR5KvGquKcctPOnI1z2koxktxxIRBMlr3N8
	s1LLlHxk73AIQfHCLZHzSwV/zam8BAWZw4INrilHJPU2qmwcOjSAtCOmiaoCHOANHOTx
	U/mOPV31z2MTxNmy/EBZqWCdY6rELTncTm98RmX34YTpqrbHXVChzVoxuRepB58dp+Sc
	x7t5/bqCDxEfI3xl9nhtZnrcyAFkT9joa+AdN7S16iWJ/g3wi2y7/XrrEK9aIAgLL1iA
	Wtr8EMwoR2AUaTp83xmk7IQ+RYYKokdw0c5Ix1FaTrQJmnLKrb/6nQJVCMxj2BwF2aKw
	ySPg==
X-Gm-Message-State: APjAAAXS7l22NY+QdoMxsZ2njL8FUO7rtVY9Q7FlKH/KQ0JAkUawhbUJ
	5fq4KTiyr1ftAinp2wOql2UVDtNi2GQ=
X-Google-Smtp-Source: APXvYqxRGbomoas+YKP/qHC2eUqK27+bQfXvI5dGW0/u1FjoIgnpvW0o9FSpQyF0lZWGxOELDVZK2w==
X-Received: by 2002:aa7:8c1a:: with SMTP id c26mr8485737pfd.25.1556862871882; 
	Thu, 02 May 2019 22:54:31 -0700 (PDT)
Received: from localhost.ibm.com ([1.129.142.217])
	by smtp.gmail.com with ESMTPSA id
	h187sm1292983pfc.52.2019.05.02.22.54.27
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 02 May 2019 22:54:31 -0700 (PDT)
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
To: qemu-devel@nongnu.org
Date: Fri,  3 May 2019 15:53:14 +1000
Message-Id: <20190503055316.6441-12-sjitindarsingh@gmail.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20190503055316.6441-1-sjitindarsingh@gmail.com>
References: <20190503055316.6441-1-sjitindarsingh@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::443
Subject: [Qemu-devel] [QEMU-PPC] [PATCH 11/13] target/ppc: Implement hcall
 H_COPY_TOFROM_GUEST
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
Cc: groug@kaod.org, qemu-ppc@nongnu.org, clg@kaod.org,
	Suraj Jitindar Singh <sjitindarsingh@gmail.com>,
	david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190503055314.UWvhl3xmX72muF6sZ57o8o3a-7wUbyUQxDOLzHIJchs@z>

The hcall H_COPY_TOFROM_GUEST of used by a guest acting as a nested
hypervisor to access quadrants since quadrant access is hypervisor
privileged.

Translate the guest address to be accessed, map the memory and perform
the access on behalf of the guest. If the parameters are invalid, the
address can't be translated or the memory cannot be mapped then fail
the access.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
---
 hw/ppc/spapr_hcall.c     | 74 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/hw/ppc/spapr.h   |  3 +-
 target/ppc/mmu-radix64.c |  7 ++---
 target/ppc/mmu-radix64.h |  4 +++
 4 files changed, 83 insertions(+), 5 deletions(-)

diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index a84d5e2163..a370d70500 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -17,6 +17,7 @@
 #include "mmu-book3s-v3.h"
 #include "hw/mem/memory-device.h"
 #include "hw/ppc/ppc.h"
+#include "mmu-radix64.h"
 
 static bool has_spr(PowerPCCPU *cpu, int spr)
 {
@@ -2158,6 +2159,78 @@ static target_ulong h_nested_tlb_invalidate(PowerPCCPU *cpu,
     return H_SUCCESS;
 }
 
+static target_ulong h_copy_tofrom_guest(PowerPCCPU *cpu,
+                                        SpaprMachineState *spapr,
+                                        target_ulong opcode, target_ulong *args)
+{
+    target_ulong lpid = args[0];
+    target_ulong pid = args[1];
+    vaddr eaddr = args[2];
+    target_ulong gp_to = args[3];
+    target_ulong gp_from = args[4];
+    target_ulong n = args[5];
+    int is_load = !!gp_to;
+    void *from, *to;
+    int prot, psize;
+    hwaddr raddr, to_len, from_len;
+
+    if (spapr_get_cap(spapr, SPAPR_CAP_NESTED_KVM_HV) == 0) {
+        return H_FUNCTION;
+    }
+
+    if ((gp_to && gp_from) || (!gp_to && !gp_from)) {
+        return H_PARAMETER;
+    }
+
+    if (eaddr & (0xFFFUL << 52)) {
+        return H_PARAMETER;
+    }
+
+    if (!lpid) {
+        return H_PARAMETER;
+    }
+
+    /* Translate eaddr to raddr */
+    if (ppc_radix64_xlate(cpu, eaddr, is_load, lpid, pid, 1, &raddr, &psize,
+                          &prot, 0)) {
+        return H_NOT_FOUND;
+    }
+    if (((raddr & ((1UL << psize) - 1)) + n) >= (1UL << psize)) {
+        return H_PARAMETER;
+    }
+
+    if (is_load) {
+        gp_from = raddr;
+    } else {
+        gp_to = raddr;
+    }
+
+    /* Map the memory regions and perform a memory copy */
+    from = cpu_physical_memory_map(gp_from, &from_len, 0);
+    if (!from) {
+        return H_NOT_FOUND;
+    }
+    if (from_len < n) {
+        cpu_physical_memory_unmap(from, from_len, 0, 0);
+        return H_PARAMETER;
+    }
+    to = cpu_physical_memory_map(gp_to, &to_len, 1);
+    if (!to) {
+        cpu_physical_memory_unmap(from, from_len, 0, 0);
+        return H_PARAMETER;
+    }
+    if (to_len < n) {
+        cpu_physical_memory_unmap(from, from_len, 0, 0);
+        cpu_physical_memory_unmap(to, to_len, 1, 0);
+        return H_PARAMETER;
+    }
+    memcpy(to, from, n);
+    cpu_physical_memory_unmap(from, from_len, 0, n);
+    cpu_physical_memory_unmap(to, to_len, 1, n);
+
+    return H_SUCCESS;
+}
+
 static spapr_hcall_fn papr_hypercall_table[(MAX_HCALL_OPCODE / 4) + 1];
 static spapr_hcall_fn kvmppc_hypercall_table[KVMPPC_HCALL_MAX - KVMPPC_HCALL_BASE + 1];
 
@@ -2268,6 +2341,7 @@ static void hypercall_register_types(void)
     spapr_register_hypercall(H_SET_PARTITION_TABLE, h_set_partition_table);
     spapr_register_hypercall(H_ENTER_NESTED, h_enter_nested);
     spapr_register_hypercall(H_TLB_INVALIDATE, h_nested_tlb_invalidate);
+    spapr_register_hypercall(H_COPY_TOFROM_GUEST, h_copy_tofrom_guest);
 
     /* Virtual Processor Home Node */
     spapr_register_hypercall(H_HOME_NODE_ASSOCIATIVITY,
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 6a614c445f..d62f4108d4 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -505,7 +505,8 @@ struct SpaprMachineState {
 #define H_SET_PARTITION_TABLE   0xF800
 #define H_ENTER_NESTED          0xF804
 #define H_TLB_INVALIDATE        0xF808
-#define KVMPPC_HCALL_MAX        H_TLB_INVALIDATE
+#define H_COPY_TOFROM_GUEST     0xF80C
+#define KVMPPC_HCALL_MAX        H_COPY_TOFROM_GUEST
 
 typedef struct SpaprDeviceTreeUpdateHeader {
     uint32_t version_id;
diff --git a/target/ppc/mmu-radix64.c b/target/ppc/mmu-radix64.c
index 6118ad1b00..2a8147fc38 100644
--- a/target/ppc/mmu-radix64.c
+++ b/target/ppc/mmu-radix64.c
@@ -429,10 +429,9 @@ static bool validate_pate(PowerPCCPU *cpu, uint64_t lpid, ppc_v3_pate_t *pate)
     return true;
 }
 
-static int ppc_radix64_xlate(PowerPCCPU *cpu, vaddr eaddr, int rwx,
-                             uint64_t lpid, uint64_t pid, bool relocation,
-                             hwaddr *raddr, int *psizep, int *protp,
-                             bool cause_excp)
+int ppc_radix64_xlate(PowerPCCPU *cpu, vaddr eaddr, int rwx, uint64_t lpid,
+                      uint64_t pid, bool relocation, hwaddr *raddr, int *psizep,
+                      int *protp, bool cause_excp)
 {
     CPUPPCState *env = &cpu->env;
     ppc_v3_pate_t pate;
diff --git a/target/ppc/mmu-radix64.h b/target/ppc/mmu-radix64.h
index 96228546aa..c0bbd5c332 100644
--- a/target/ppc/mmu-radix64.h
+++ b/target/ppc/mmu-radix64.h
@@ -66,6 +66,10 @@ static inline int ppc_radix64_get_prot_amr(PowerPCCPU *cpu)
            (iamr & 0x1 ? 0 : PAGE_EXEC);
 }
 
+int ppc_radix64_xlate(PowerPCCPU *cpu, vaddr eaddr, int rwx, uint64_t lpid,
+                      uint64_t pid, bool relocation, hwaddr *raddr, int *psizep,
+                      int *protp, bool cause_excp);
+
 #endif /* TARGET_PPC64 */
 
 #endif /* CONFIG_USER_ONLY */
-- 
2.13.6


