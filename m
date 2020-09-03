Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7457DC43461
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 22:23:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31A7E20716
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 22:23:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EKLe54Ac"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31A7E20716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36618 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDxdI-0007wI-Dw
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 18:23:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45088)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1kDxNl-0006MY-GN; Thu, 03 Sep 2020 18:07:03 -0400
Received: from mail-qt1-x841.google.com ([2607:f8b0:4864:20::841]:39747)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1kDxNh-0007Sk-T5; Thu, 03 Sep 2020 18:07:01 -0400
Received: by mail-qt1-x841.google.com with SMTP id 92so3195145qtb.6;
 Thu, 03 Sep 2020 15:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=GkJH56YyrTfgDLU7Hl4gNM2JIPN54D3aOTKmprseOmg=;
 b=EKLe54Ac4dVxyljo/zf+UD+rArPFZEbTEVDzsDmgH6DerAb7pgCGkHTt3ArbeO0Fxu
 NeMOej5/IiJwgETJC3+rF/3T1N9q5M1ulcOfRWRBaaiKeEezVGL97Q2DgBkKg7ImH2+c
 d9hzKWPM8uyPugsa1vJKS3yT9aUmOG+RSuRTUvaBAW5r4HI0W/l49SC3WiSiRgepD/I6
 LRUrRTHdRX7fUMXvRPag6NRBMEkHOMVl9r8O2JQSYMBqji5tQ3xqWcas68+qAbilLJgu
 47krljJTf1bq797S3QpOKRh+qnVatPLlQhNeeS3Om6OlvARQZ0NVeOsYAbfBI3F9Zuya
 0rYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=GkJH56YyrTfgDLU7Hl4gNM2JIPN54D3aOTKmprseOmg=;
 b=Uh8w/tKhyI3+vna5gU+UVQGN/gLT6iGmiVLZnqcjC1EYFTpu2n1/G1ib2QvL/vtb5v
 POjC9hQTv6ooYqiiwYWc+IZO8ySyefgQXxEBwpgojNLNvjsCPtuRgPQ9vhspqhHNtjY/
 /5h6aje+793+UB8VZKDCwnoY18+IhMuXkZBVC/zQ9ztnslCTety5D1SGLIbJUPGO5fRe
 D6eW2xgDgrEmCE6R4bh5YqM6RjXyBhXG/Sp37r3u4/XpHupTjSMwbnKtCEbEGDKyokqn
 94byr3gUjQzyl0+N9JCLkm2cpr3R5y263Kcgu4jLpn7G5RyO5kE5q/elbG4ljaIve5ZG
 2UZw==
X-Gm-Message-State: AOAM533i4eUduW6cPjEvcBGu0lWAwJ3GarZB6VfMDe6YJukSVBZ+0jFn
 HkF/4yTnltNzLExKtkmV4DCB3GN+AlUGtQ==
X-Google-Smtp-Source: ABdhPJzcs9YJyXi20OA5LV4KCyVQtowoHX/KLm4aKeqbjrGgRqpbt5hTGrcbl2mAg05znMja+uAJEg==
X-Received: by 2002:ac8:4245:: with SMTP id r5mr5762577qtm.52.1599170816101;
 Thu, 03 Sep 2020 15:06:56 -0700 (PDT)
Received: from rekt.ibmuc.com ([2804:431:c7c6:1dc:ffbd:d3fb:97ff:aaca])
 by smtp.gmail.com with ESMTPSA id j1sm1798757qtk.91.2020.09.03.15.06.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2020 15:06:55 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 4/7] spapr_numa: move NVLink2 associativity handling to
 spapr_numa.c
Date: Thu,  3 Sep 2020 19:06:36 -0300
Message-Id: <20200903220639.563090-5-danielhb413@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200903220639.563090-1-danielhb413@gmail.com>
References: <20200903220639.563090-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::841;
 envelope-from=danielhb413@gmail.com; helo=mail-qt1-x841.google.com
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

The NVLink2 GPUs works like a regular NUMA node with its
own associativity values, regardless of user input.

This can be handled inside spapr_numa_associativity_init(),
initializing NVGPU_MAX_NUM associativity arrays that can
be used by the GPUs.

Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 hw/ppc/spapr_numa.c        | 28 +++++++++++++++++++++++++++-
 hw/ppc/spapr_pci_nvlink2.c | 20 +++-----------------
 2 files changed, 30 insertions(+), 18 deletions(-)

diff --git a/hw/ppc/spapr_numa.c b/hw/ppc/spapr_numa.c
index 5a82a84438..93a000b729 100644
--- a/hw/ppc/spapr_numa.c
+++ b/hw/ppc/spapr_numa.c
@@ -13,14 +13,18 @@
 #include "qemu/osdep.h"
 #include "qemu-common.h"
 #include "hw/ppc/spapr_numa.h"
+#include "hw/pci-host/spapr.h"
 #include "hw/ppc/fdt.h"
 
+/* Moved from hw/ppc/spapr_pci_nvlink2.c */
+#define SPAPR_GPU_NUMA_ID           (cpu_to_be32(1))
 
 void spapr_numa_associativity_init(SpaprMachineState *spapr,
                                    MachineState *machine)
 {
+    SpaprMachineClass *smc = SPAPR_MACHINE_GET_CLASS(spapr);
     int nb_numa_nodes = machine->numa_state->num_nodes;
-    int i;
+    int i, j, max_nodes_with_gpus;
 
     /*
      * For all associativity arrays: first position is the size,
@@ -35,6 +39,28 @@ void spapr_numa_associativity_init(SpaprMachineState *spapr,
         spapr->numa_assoc_array[i][0] = cpu_to_be32(MAX_DISTANCE_REF_POINTS);
         spapr->numa_assoc_array[i][MAX_DISTANCE_REF_POINTS] = cpu_to_be32(i);
     }
+
+    /*
+     * Initialize NVLink GPU associativity arrays. We know that
+     * the first GPU will take the first available NUMA id, and
+     * we'll have a maximum of NVGPU_MAX_NUM GPUs in the machine.
+     * At this point we're not sure if there are GPUs or not, but
+     * let's initialize the associativity arrays and allow NVLink
+     * GPUs to be handled like regular NUMA nodes later on.
+     */
+    max_nodes_with_gpus = nb_numa_nodes + NVGPU_MAX_NUM;
+
+    for (i = nb_numa_nodes; i < max_nodes_with_gpus; i++) {
+        spapr->numa_assoc_array[i][0] = cpu_to_be32(MAX_DISTANCE_REF_POINTS);
+
+        for (j = 1; j < MAX_DISTANCE_REF_POINTS; j++) {
+            uint32_t gpu_assoc = smc->pre_5_1_assoc_refpoints ?
+                                 SPAPR_GPU_NUMA_ID : cpu_to_be32(i);
+            spapr->numa_assoc_array[i][j] = gpu_assoc;
+        }
+
+        spapr->numa_assoc_array[i][MAX_DISTANCE_REF_POINTS] = cpu_to_be32(i);
+    }
 }
 
 void spapr_numa_write_associativity_dt(SpaprMachineState *spapr, void *fdt,
diff --git a/hw/ppc/spapr_pci_nvlink2.c b/hw/ppc/spapr_pci_nvlink2.c
index 76ae77ebc8..8ef9b40a18 100644
--- a/hw/ppc/spapr_pci_nvlink2.c
+++ b/hw/ppc/spapr_pci_nvlink2.c
@@ -26,6 +26,7 @@
 #include "qemu-common.h"
 #include "hw/pci/pci.h"
 #include "hw/pci-host/spapr.h"
+#include "hw/ppc/spapr_numa.h"
 #include "qemu/error-report.h"
 #include "hw/ppc/fdt.h"
 #include "hw/pci/pci_bridge.h"
@@ -37,8 +38,6 @@
 #define PHANDLE_NVLINK(phb, gn, nn)  (0x00130000 | (((phb)->index) << 8) | \
                                      ((gn) << 4) | (nn))
 
-#define SPAPR_GPU_NUMA_ID           (cpu_to_be32(1))
-
 typedef struct SpaprPhbPciNvGpuSlot {
         uint64_t tgt;
         uint64_t gpa;
@@ -360,13 +359,6 @@ void spapr_phb_nvgpu_ram_populate_dt(SpaprPhbState *sphb, void *fdt)
         Object *nv_mrobj = object_property_get_link(OBJECT(nvslot->gpdev),
                                                     "nvlink2-mr[0]",
                                                     &error_abort);
-        uint32_t associativity[] = {
-            cpu_to_be32(0x4),
-            cpu_to_be32(nvslot->numa_id),
-            cpu_to_be32(nvslot->numa_id),
-            cpu_to_be32(nvslot->numa_id),
-            cpu_to_be32(nvslot->numa_id)
-        };
         uint64_t size = object_property_get_uint(nv_mrobj, "size", NULL);
         uint64_t mem_reg[2] = { cpu_to_be64(nvslot->gpa), cpu_to_be64(size) };
         char *mem_name = g_strdup_printf("memory@%"PRIx64, nvslot->gpa);
@@ -376,14 +368,8 @@ void spapr_phb_nvgpu_ram_populate_dt(SpaprPhbState *sphb, void *fdt)
         _FDT((fdt_setprop_string(fdt, off, "device_type", "memory")));
         _FDT((fdt_setprop(fdt, off, "reg", mem_reg, sizeof(mem_reg))));
 
-        if (sphb->pre_5_1_assoc) {
-            associativity[1] = SPAPR_GPU_NUMA_ID;
-            associativity[2] = SPAPR_GPU_NUMA_ID;
-            associativity[3] = SPAPR_GPU_NUMA_ID;
-        }
-
-        _FDT((fdt_setprop(fdt, off, "ibm,associativity", associativity,
-                          sizeof(associativity))));
+        spapr_numa_write_associativity_dt(SPAPR_MACHINE(qdev_get_machine()),
+                                          fdt, off, nvslot->numa_id);
 
         _FDT((fdt_setprop_string(fdt, off, "compatible",
                                  "ibm,coherent-device-memory")));
-- 
2.26.2


