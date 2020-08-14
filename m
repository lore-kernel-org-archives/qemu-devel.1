Return-Path: <SRS0=PlQC=BZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDE51C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2020 15:48:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93F6823B31
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2020 15:48:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LKsECE2L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93F6823B31
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6yPt-000435-Oo
	for qemu-devel@archiver.kernel.org; Sat, 15 Aug 2020 11:48:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48038)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1k6yOw-00032O-1I; Sat, 15 Aug 2020 11:47:22 -0400
Received: from mail-qk1-x742.google.com ([2607:f8b0:4864:20::742]:36003)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1k6yOt-0007YT-Uh; Sat, 15 Aug 2020 11:47:21 -0400
Received: by mail-qk1-x742.google.com with SMTP id g26so11151717qka.3;
 Sat, 15 Aug 2020 08:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=CdUVrTPg31A8j7zUktktHainBsdYNy7QcjoOGz2vqFc=;
 b=LKsECE2LrQURCq2axOcQdpzZEIhZ2GRDnOkee0HIPbs9YqgxzyN3zAaXZZGW5ZRQkD
 rCA0qP0RjlIlQDrjpgj0qYcv9BYbHGaePKBSb9rFkMIEC5VNzO6cTKG12Jz7gOe/GgJZ
 +QDlnu/3GbmaX5Xt9RQnoCYrZ6tTacygAhCA3toj3FDR9A+dP9c3cLY83M2tsuN2MFN1
 P9IxW+/xqlpoonQg1DCCeZB49bHjzdY3s8lDgPNJWkP3xMPFQPnol/r/ukx55khhiDSP
 VeRE0+2O3zNTluO3FA/5jDPPmSM+QH119ea3Dcn2Yl8uGyXU+/+XL3OCfdt3unW59aPK
 Ah4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=CdUVrTPg31A8j7zUktktHainBsdYNy7QcjoOGz2vqFc=;
 b=SRshgQtHyiVMjqbxV4AzbYgWx3+ErG/qjHAqda3LW0MxLpjF/DTALXDyIsX5w0NpMO
 UezZGgPs/vJGYMCxoHvdnExQHrB0lWcElHT4GE1CsusFGmYC3haX2FhWjB4058QYxxAB
 lRP2gMVdENRTa3jSIrsuv57cMYm9m8sb4Ry2fHp5NytjHNoMJaphiM5EhHPlgwbT4p+N
 gI/FGrQbRGBQUduQmNJ6c817smun3Pw2Gyw2g+yEDfGtnWeaW+3K8NOrcAAqTuGh9B6p
 x1awWakTMphDc/txta1qb3vDjgXzNo4LdHHwWeLmm2PQUsg9iBVwMI9H9P4sgxEyJ3uA
 O+oQ==
X-Gm-Message-State: AOAM533CMchOq6CmF6cJOpwNXSNP+DnFg9HA5IgdGic1C3YS6OX7dITO
 KUhvfYNYLQmnL5gc9a1rhL27ZFU15/IlLQ==
X-Google-Smtp-Source: ABdhPJyyQAdgHQrH9HhLNuxbcpgCAMY1hAiGvHXyPExO8+SP2qn8xW0x0LpNYhxM0XTaB4sc5bkePg==
X-Received: by 2002:aed:3c1c:: with SMTP id t28mr3642556qte.74.1597438482669; 
 Fri, 14 Aug 2020 13:54:42 -0700 (PDT)
Received: from rekt.ibmuc.com ([2804:431:c7c6:303f:d1dc:35d8:e9f6:c8b])
 by smtp.gmail.com with ESMTPSA id p33sm12301018qtp.49.2020.08.14.13.54.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2020 13:54:42 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 03/10] spapr: robustify NVLink2 NUMA node logic
Date: Fri, 14 Aug 2020 17:54:17 -0300
Message-Id: <20200814205424.543857-4-danielhb413@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200814205424.543857-1-danielhb413@gmail.com>
References: <20200814205424.543857-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::742;
 envelope-from=danielhb413@gmail.com; helo=mail-qk1-x742.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-ppc@nongnu.org,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

NVLink2 GPUs are allocated in their own NUMA node, at maximum
distance from every other resource in the board. The existing
logic makes some assumptions that don't scale well:

- only NVLink2 GPUs will ever require such mechanism, meaning
that the GPU logic is tightly coupled with the NUMA setup of
the machine, via how ibm,max-associativity-domains is set.

- the code is relying on the lack of support for sparse NUMA
nodes in QEMU. Eventually this support can be implemented, and
then the assumption that spapr->gpu_numa_id represents the total
of NUMA nodes plus all generated NUMA ids for the GPUs, which
relies on all QEMU NUMA nodes not being sparsed, has a good
potential for disaster.

This patch aims to fix both assumptions by creating a generic
mechanism to get an available NUMA node, regardless of the
NUMA setup being sparse or not. The idea is to rename the existing
spapr->gpu_numa_id to spapr->current_numa_id and add a new
spapr->extra_numa_nodes attribute. They are used in a new function
called spapr_pci_get_available_numa_id(), that takes into account
that the NUMA conf can be sparsed or not, to retrieve an available
NUMA id for the caller. Each consecutive call of
spapr_pci_get_available_numa_id() will generate a new ID, up
to the limit of numa_state->num_nodes + spapr->extra_numa_nodes
exceeding MAX_NODES. This is a generic code being used only by
NVLink2 ATM, being available to be used in the future by any
other device.

With this new function in place, we can decouple
ibm,max-associativity-domains logic from NVLink2 logic by
using the new spapr->extra_numa_nodes to define the maxdomains
of the forth NUMA level. Instead of defining it as gpu_numa_id,
use num_nodes + extra_numa_nodes. This also makes it resilient
to any future change in the support of sparse NUMA nodes.

Despite all the code juggling, no functional change was made
because sparse NUMA nodes isn't a thing and we do not support
distinct NUMA distances via user input. Next patches will
change that.

Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 hw/ppc/spapr.c              | 15 ++++++++++-----
 hw/ppc/spapr_pci.c          | 33 +++++++++++++++++++++++++++++++++
 hw/ppc/spapr_pci_nvlink2.c  | 10 ++++++----
 include/hw/pci-host/spapr.h |  2 ++
 include/hw/ppc/spapr.h      |  4 +++-
 5 files changed, 54 insertions(+), 10 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 3b16edaf4c..22e78cfc84 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -910,13 +910,13 @@ static void spapr_dt_rtas(SpaprMachineState *spapr, void *fdt)
         cpu_to_be32(SPAPR_MEMORY_BLOCK_SIZE & 0xffffffff),
         cpu_to_be32(ms->smp.max_cpus / ms->smp.threads),
     };
-    uint32_t maxdomain = cpu_to_be32(spapr->gpu_numa_id > 1 ? 1 : 0);
+    uint32_t maxdomain = cpu_to_be32(spapr->extra_numa_nodes > 1 ? 1 : 0);
     uint32_t maxdomains[] = {
         cpu_to_be32(4),
         maxdomain,
         maxdomain,
         maxdomain,
-        cpu_to_be32(spapr->gpu_numa_id),
+        cpu_to_be32(ms->numa_state->num_nodes + spapr->extra_numa_nodes),
     };
 
     _FDT(rtas = fdt_add_subnode(fdt, 0, "rtas"));
@@ -2824,13 +2824,18 @@ static void spapr_machine_init(MachineState *machine)
     /*
      * NVLink2-connected GPU RAM needs to be placed on a separate NUMA node.
      * We assign a new numa ID per GPU in spapr_pci_collect_nvgpu() which is
-     * called from vPHB reset handler so we initialize the counter here.
+     * called from vPHB reset handler. We have code to generate an extra numa
+     * id to place the GPU via 'extra_numa_nodes' and 'current_numa_node', which
+     * are initialized here.
+     *
      * If no NUMA is configured from the QEMU side, we start from 1 as GPU RAM
      * must be equally distant from any other node.
-     * The final value of spapr->gpu_numa_id is going to be written to
+     *
+     * The extra NUMA node ids generated for GPU usage will be written to
      * max-associativity-domains in spapr_build_fdt().
      */
-    spapr->gpu_numa_id = MAX(1, machine->numa_state->num_nodes);
+    spapr->current_numa_id = 0;
+    spapr->extra_numa_nodes = 0;
 
     if ((!kvm_enabled() || kvmppc_has_cap_mmu_radix()) &&
         ppc_type_check_compat(machine->cpu_type, CPU_POWERPC_LOGICAL_3_00, 0,
diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 0a418f1e67..09ac58fd7f 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -2492,3 +2492,36 @@ void spapr_pci_switch_vga(bool big_endian)
                            &big_endian);
     }
 }
+
+unsigned spapr_pci_get_available_numa_id(Error **errp)
+{
+    MachineState *machine = MACHINE(qdev_get_machine());
+    SpaprMachineState *spapr = SPAPR_MACHINE(machine);
+    NodeInfo *numa_info = machine->numa_state->nodes;
+    unsigned i, start;
+
+    if (machine->numa_state->num_nodes + spapr->extra_numa_nodes >= MAX_NODES) {
+        error_setg(errp,
+                   "Unable to get an extra NUMA node beyond MAX_NODES = %d",
+                   MAX_NODES);
+        return spapr->current_numa_id;
+    }
+
+    if (spapr->extra_numa_nodes == 0) {
+        start = 0;
+    } else {
+        start = spapr->current_numa_id + 1;
+    }
+
+    for (i = start; i < MAX_NODES; i++) {
+        if (!numa_info[i].present) {
+            spapr->extra_numa_nodes++;
+            spapr->current_numa_id = i;
+            return i;
+        }
+    }
+
+    error_setg(errp, "Unable to find a valid NUMA id");
+
+    return spapr->current_numa_id;
+}
diff --git a/hw/ppc/spapr_pci_nvlink2.c b/hw/ppc/spapr_pci_nvlink2.c
index 76ae77ebc8..611c8a2957 100644
--- a/hw/ppc/spapr_pci_nvlink2.c
+++ b/hw/ppc/spapr_pci_nvlink2.c
@@ -87,9 +87,8 @@ static void spapr_pci_collect_nvgpu(SpaprPhbPciNvGpuConfig *nvgpus,
                                     PCIDevice *pdev, uint64_t tgt,
                                     MemoryRegion *mr, Error **errp)
 {
-    MachineState *machine = MACHINE(qdev_get_machine());
-    SpaprMachineState *spapr = SPAPR_MACHINE(machine);
     SpaprPhbPciNvGpuSlot *nvslot = spapr_nvgpu_get_slot(nvgpus, tgt);
+    Error *local_err = NULL;
 
     if (!nvslot) {
         error_setg(errp, "Found too many GPUs per vPHB");
@@ -100,8 +99,11 @@ static void spapr_pci_collect_nvgpu(SpaprPhbPciNvGpuConfig *nvgpus,
 
     nvslot->gpa = nvgpus->nv2_ram_current;
     nvgpus->nv2_ram_current += memory_region_size(mr);
-    nvslot->numa_id = spapr->gpu_numa_id;
-    ++spapr->gpu_numa_id;
+
+    nvslot->numa_id = spapr_pci_get_available_numa_id(&local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+    }
 }
 
 static void spapr_pci_collect_nvnpu(SpaprPhbPciNvGpuConfig *nvgpus,
diff --git a/include/hw/pci-host/spapr.h b/include/hw/pci-host/spapr.h
index 600eb55c34..8d93223a76 100644
--- a/include/hw/pci-host/spapr.h
+++ b/include/hw/pci-host/spapr.h
@@ -129,6 +129,8 @@ struct SpaprPhbState {
 #define SPAPR_PCI_NV2ATSD_WIN_SIZE   (NVGPU_MAX_NUM * NVGPU_MAX_LINKS * \
                                       64 * KiB)
 
+unsigned spapr_pci_get_available_numa_id(Error **errp);
+
 int spapr_dt_phb(SpaprMachineState *spapr, SpaprPhbState *phb,
                  uint32_t intc_phandle, void *fdt, int *node_offset);
 
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 3134d339e8..739a6a4942 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -227,7 +227,9 @@ struct SpaprMachineState {
     bool cmd_line_caps[SPAPR_CAP_NUM];
     SpaprCapabilities def, eff, mig;
 
-    unsigned gpu_numa_id;
+    unsigned current_numa_id;
+    unsigned extra_numa_nodes;
+
     SpaprTpmProxy *tpm_proxy;
 
     Error *fwnmi_migration_blocker;
-- 
2.26.2


