Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDFEDC433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 13:01:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B04A2206CD
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 13:01:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LdLRs+7u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B04A2206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD5us-0008Mn-PY
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 09:01:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36418)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1kD5qW-0001WR-6e; Tue, 01 Sep 2020 08:57:08 -0400
Received: from mail-qt1-x842.google.com ([2607:f8b0:4864:20::842]:43933)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1kD5qU-0002nK-8H; Tue, 01 Sep 2020 08:57:07 -0400
Received: by mail-qt1-x842.google.com with SMTP id g3so669576qtq.10;
 Tue, 01 Sep 2020 05:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=44LN6WKw2NuzFJmsrJlYdSX6iSr07Frryi3h99Vzf9c=;
 b=LdLRs+7uYDbI+TLDEdAnDa69/GWygdQo5mCMybauUFJ09vEUS4iCfMXD4eBkhpuotc
 onpcHxA9dp4QXetVyklDNT4IrdK83rwJ01QlMblyDPjrIqzanWtNBfy5EkujgjzMLAb4
 8tmVMkv2tm8aYPBbyNgn6ZNTvmKrZN8fIFUmYHPDNP07juBuXS3WMyySlfLxNfDQ1xpC
 C+FX53a7V7ohIgEUaYxlcfBx4Xp0RUtCUOuwZgWxxUELtkG7rsrsZX/8V1re9Ce4pvIb
 ESQNoEWqqDjOC7fBDsdu8+oM/lrOJTZQ65SHtYmHooZi0Ra0GicmXWGN/OUWWZr5dPjY
 TE6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=44LN6WKw2NuzFJmsrJlYdSX6iSr07Frryi3h99Vzf9c=;
 b=ZFB2eDjRuacGpb71kXm/+h57RUsEBlSekg3yDVi6OKSV73p9BZwA8uK1CFvrDTFeAc
 qpVAs4XSNMxaxmnj5qBrsLUlw8U1e+k52Aw6Vvpoo5NXKm+GfOo4tO0ffOzGv8iwLOG8
 C9eUFgpISJ1N/womCyzfHJBokE65rnaHRYsy5w7r9fQ59UjD1Wprq3PuJQ4l2hD19fPx
 v5hkDPmndFOa5EJnoMmfdX7VS4DkSXhJgE/3+/kY7QBRE/8XcnqA8BvoJ9+H8CC2K4U6
 l6p4CUUfnfe7dEBB8rk/0UqVF8FlsNsB+oYU7MFKidNk2cwoghQsbg116tkARhBm+BcZ
 ZLIQ==
X-Gm-Message-State: AOAM5338NacpTIgOG/Gf8ztXd8o+Dx0pLEKt8B7CI7a6A3KW+UhuWu/r
 HJWpdkZWcV3wDmPcSx+AgiFUIggHI0XfdQ==
X-Google-Smtp-Source: ABdhPJxzDfXgbYc/jJjEtH93nC6SK3mRSyU+AiN3e2sm4XB9KvH4cE64YC9A/9ZEKGiFnJi9nYHEIQ==
X-Received: by 2002:ac8:43cf:: with SMTP id w15mr1625104qtn.55.1598965024649; 
 Tue, 01 Sep 2020 05:57:04 -0700 (PDT)
Received: from rekt.ibmuc.com ([2804:431:c7c7:6be:f6e3:c671:cefe:b943])
 by smtp.gmail.com with ESMTPSA id q7sm1430164qkf.35.2020.09.01.05.57.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2020 05:57:04 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 6/7] spapr_numa: move NVLink2 associativity handling to
 spapr_numa.c
Date: Tue,  1 Sep 2020 09:56:44 -0300
Message-Id: <20200901125645.118026-7-danielhb413@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200901125645.118026-1-danielhb413@gmail.com>
References: <20200901125645.118026-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::842;
 envelope-from=danielhb413@gmail.com; helo=mail-qt1-x842.google.com
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

This patch adds a new spapr_numa_write_assoc_nvlink2() helper
to handle the ibm,associativity for NVLink2 GPUs.

Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 hw/ppc/spapr_numa.c         | 23 +++++++++++++++++++++++
 hw/ppc/spapr_pci_nvlink2.c  | 19 ++-----------------
 include/hw/ppc/spapr_numa.h |  3 +++
 3 files changed, 28 insertions(+), 17 deletions(-)

diff --git a/hw/ppc/spapr_numa.c b/hw/ppc/spapr_numa.c
index 9eb4bdbe80..785cc24624 100644
--- a/hw/ppc/spapr_numa.c
+++ b/hw/ppc/spapr_numa.c
@@ -15,6 +15,8 @@
 #include "hw/ppc/spapr_numa.h"
 #include "hw/ppc/fdt.h"
 
+/* Moved from hw/ppc/spapr_pci_nvlink2.c */
+#define SPAPR_GPU_NUMA_ID           (cpu_to_be32(1))
 
 void spapr_numa_associativity_init(MachineState *machine)
 {
@@ -114,6 +116,27 @@ int spapr_numa_write_assoc_lookup_arrays(SpaprMachineState *spapr, void *fdt,
     return ret;
 }
 
+void spapr_numa_write_assoc_nvlink2(void *fdt, int offset, int numa_id,
+                                    SpaprPhbState *sphb)
+{
+    uint32_t associativity[NUMA_ASSOC_SIZE];
+    int i;
+
+    associativity[0] = cpu_to_be32(MAX_DISTANCE_REF_POINTS);
+    for (i = 1; i < NUMA_ASSOC_SIZE; i++) {
+        associativity[i] = cpu_to_be32(numa_id);
+    };
+
+    if (sphb->pre_5_1_assoc) {
+        associativity[1] = SPAPR_GPU_NUMA_ID;
+        associativity[2] = SPAPR_GPU_NUMA_ID;
+        associativity[3] = SPAPR_GPU_NUMA_ID;
+    }
+
+    _FDT((fdt_setprop(fdt, offset, "ibm,associativity", associativity,
+                      sizeof(associativity))));
+}
+
 /*
  * Helper that writes ibm,associativity-reference-points and
  * max-associativity-domains in the RTAS pointed by @rtas
diff --git a/hw/ppc/spapr_pci_nvlink2.c b/hw/ppc/spapr_pci_nvlink2.c
index 76ae77ebc8..662a0af990 100644
--- a/hw/ppc/spapr_pci_nvlink2.c
+++ b/hw/ppc/spapr_pci_nvlink2.c
@@ -29,6 +29,7 @@
 #include "qemu/error-report.h"
 #include "hw/ppc/fdt.h"
 #include "hw/pci/pci_bridge.h"
+#include "hw/ppc/spapr_numa.h"
 
 #define PHANDLE_PCIDEV(phb, pdev)    (0x12000000 | \
                                      (((phb)->index) << 16) | ((pdev)->devfn))
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
@@ -376,14 +368,7 @@ void spapr_phb_nvgpu_ram_populate_dt(SpaprPhbState *sphb, void *fdt)
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
+        spapr_numa_write_assoc_nvlink2(fdt, off, nvslot->numa_id, sphb);
 
         _FDT((fdt_setprop_string(fdt, off, "compatible",
                                  "ibm,coherent-device-memory")));
diff --git a/include/hw/ppc/spapr_numa.h b/include/hw/ppc/spapr_numa.h
index f6127501a6..b6e0721b07 100644
--- a/include/hw/ppc/spapr_numa.h
+++ b/include/hw/ppc/spapr_numa.h
@@ -15,6 +15,7 @@
 
 #include "hw/boards.h"
 #include "hw/ppc/spapr.h"
+#include "hw/pci-host/spapr.h"
 
 void spapr_numa_associativity_init(MachineState *machine);
 void spapr_numa_write_rtas_dt(SpaprMachineState *spapr, void *fdt, int rtas);
@@ -24,6 +25,8 @@ int spapr_numa_fixup_cpu_dt(SpaprMachineState *spapr, void *fdt,
                             int offset, PowerPCCPU *cpu);
 int spapr_numa_write_assoc_lookup_arrays(SpaprMachineState *spapr, void *fdt,
                                          int offset);
+void spapr_numa_write_assoc_nvlink2(void *fdt, int offset, int numa_id,
+                                    SpaprPhbState *sphb);
 
 
 #endif /* HW_SPAPR_NUMA_H */
-- 
2.26.2


