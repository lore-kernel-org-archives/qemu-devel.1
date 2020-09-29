Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A261CC4741F
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 13:44:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17840207C4
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 13:44:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oHcI2m1U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17840207C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52280 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNFvs-0004G5-1r
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 09:44:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40760)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1kNFqK-0007ZM-4g; Tue, 29 Sep 2020 09:38:57 -0400
Received: from mail-qk1-x744.google.com ([2607:f8b0:4864:20::744]:33592)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1kNFqG-0001DJ-BB; Tue, 29 Sep 2020 09:38:55 -0400
Received: by mail-qk1-x744.google.com with SMTP id s131so4300775qke.0;
 Tue, 29 Sep 2020 06:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=AQnMhIcD5eYV/9ZgfONZjp6v86/KsVMWHA6TpQLzrRY=;
 b=oHcI2m1UOanbEY0l9aI8ELePzBDuNy4oPomABTk6xvZaM/nYynP/QvErAj/cSOa4Io
 LzZTteJMBI0+FoCEJ8/ZcULe3GQjFaUNonqGurnUaMyMxyU76fLcMbCYHW8IV+1Vy0HR
 nPGDqhmVH1NmabEGm13NrLoEGqOeALBq0oRpIz/jZFKNlI3LnrQaMLpIrnElYeef/ytL
 KKMyb2jfMABbxqJiupBHCQxn1XeKZTaxj1u2Le0r7BcUcVXg943F40+XPe9UTtIIpyq/
 vNQbEuG3zKw/2241j4vi2ak9wqMA6LvVNe+EvHvKGafPyx8d0GVLFxxbOTV7pgUs2wy8
 8aSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=AQnMhIcD5eYV/9ZgfONZjp6v86/KsVMWHA6TpQLzrRY=;
 b=t1mQ1cRT8E5p7sKuAxYhRzTkkJkMlKNVad5+4hPNonzGh68S5nGKVbFlwoR1nYU6Bh
 vfTBFL4mbBFWcEtKfr36+wcg12PEKeIk6Rs/0UBFtlyOHwMktbhAAGettJthH2ZhnqZH
 D3svW9KTIhqAOKQfGZ7PJCLKdv7a5LVYgEcdGnNGlJY61qhq+7qnLozNW8NI7qLdXvtk
 sgtG0HShPZqbamjrRCC1zeg06JO7aptWrBN7LSScNYpdzPHu2xFQ0Ec+KXrE0+ZO4jE6
 q4g4vwjHN3bBDzgP3WpsEFx05rs4rWtiArhzz+B1Zv+CmGQWvP8wp4X0GHFmDXh8ubK7
 BqUg==
X-Gm-Message-State: AOAM530fdG6HcXkd7dRWip03rtVC2/QiAxsLHyEaZPwdvu3TDftNBUAL
 AZLOx5wND++8x9/MoPolOj6fjaJ46Uw=
X-Google-Smtp-Source: ABdhPJyuCxV56CQXLdRjkidI84GUVNG/t4Dm7bu7s7zqnt85ZmMWPBjQzcEBbdsJSE1wxn1RujBQ9w==
X-Received: by 2002:a37:4e45:: with SMTP id c66mr4548828qkb.36.1601386730318; 
 Tue, 29 Sep 2020 06:38:50 -0700 (PDT)
Received: from rekt.ibmuc.com ([2804:431:c7c7:c625:6c0e:4720:8228:5f68])
 by smtp.gmail.com with ESMTPSA id j88sm5239938qte.96.2020.09.29.06.38.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2020 06:38:49 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 4/5] spapr_numa: consider user input when defining
 associativity
Date: Tue, 29 Sep 2020 10:38:16 -0300
Message-Id: <20200929133817.560278-5-danielhb413@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200929133817.560278-1-danielhb413@gmail.com>
References: <20200929133817.560278-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::744;
 envelope-from=danielhb413@gmail.com; helo=mail-qk1-x744.google.com
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
 groug@kaod.org, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch puts all the pieces together to finally allow user
input when defining the NUMA topology of the spapr guest.

For each NUMA node A, starting at node id 0, the new
spapr_numa_define_associativity_domains() will:

- get the distance between node A and B = A + 1
- get the correspondent NUMA level for this distance
- assign the associativity domain for A and B for the given
NUMA level, using the lowest associativity domain value between
them
- if there is more NUMA nodes, increment B and repeat

Since we always start at the first node (id = 0) and go in
ascending order, we are prioritizing any previous associativity
already calculated. This is necessary because neither QEMU, nor
the pSeries kernel, supports multiple associativity domains for
each resource, meaning that we have to decide which associativity
relation is relevant. Another side effect is that the first
NUMA node, node 0, will always have an associativity array
full of zeroes. This is intended - in fact, the Linux kernel
expects it (see [1] for more info).

Ultimately, all of this results in a best effort approximation for
the actual NUMA distances the user input in the command line. Given
the nature of how PAPR itself interprets NUMA distances versus the
expectations risen by how ACPI SLIT works, there might be better
algorithms but, in the end, it'll also result in another way to
approximate what the user really wanted.

To keep this commit message no longer than it already is, the next
patch will update the existing documentation in ppc-spapr-numa.rst
with more in depth details and design considerations/drawbacks.

[1] https://lore.kernel.org/linuxppc-dev/5e8fbea3-8faf-0951-172a-b41a2138fbcf@gmail.com/

Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 hw/ppc/spapr_numa.c | 120 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 119 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/spapr_numa.c b/hw/ppc/spapr_numa.c
index 16badb1f4b..f3d43ceb1e 100644
--- a/hw/ppc/spapr_numa.c
+++ b/hw/ppc/spapr_numa.c
@@ -37,12 +37,118 @@ static bool spapr_numa_is_symmetrical(MachineState *ms)
     return true;
 }
 
+/*
+ * This function will translate the user distances into
+ * what the kernel understand as possible values: 10
+ * (local distance), 20, 40, 80 and 160, and return the equivalent
+ * NUMA level for each. Current heuristic is:
+ *  - local distance (10) returns numa_level = 0x4
+ *  - distances between 11 and 30 inclusive -> rounded to 20,
+ *    numa_level = 0x3
+ *  - distances between 31 and 60 inclusive -> rounded to 40,
+ *    numa_level = 0x2
+ *  - distances between 61 and 120 inclusive -> rounded to 80,
+ *    numa_level = 0x1
+ *  - everything above 120 returns numa_level = 0 to indicate that
+ *    there is no match. This will be calculated as disntace = 160
+ *    by the kernel (as of v5.9)
+ */
+static uint8_t spapr_numa_get_numa_level(uint8_t distance)
+{
+    uint8_t rounded_distance = 160;
+    uint8_t numa_level;
+
+    if (distance > 11 && distance <= 30) {
+        rounded_distance = 20;
+    } else if (distance > 31 && distance <= 60) {
+        rounded_distance = 40;
+    } else if (distance > 61 && distance <= 120) {
+        rounded_distance = 80;
+    }
+
+    switch (rounded_distance) {
+    case 10:
+        numa_level = 0x4;
+        break;
+    case 20:
+        numa_level = 0x3;
+        break;
+    case 40:
+        numa_level = 0x2;
+        break;
+    case 80:
+        numa_level = 0x1;
+        break;
+    default:
+        numa_level = 0;
+    }
+
+    return numa_level;
+}
+
+static void spapr_numa_define_associativity_domains(SpaprMachineState *spapr)
+{
+    MachineState *ms = MACHINE(spapr);
+    NodeInfo *numa_info = ms->numa_state->nodes;
+    int nb_numa_nodes = ms->numa_state->num_nodes;
+    int src, dst;
+
+    for (src = 0; src < nb_numa_nodes; src++) {
+        for (dst = src; dst < nb_numa_nodes; dst++) {
+            /*
+             * This is how the associativity domain between A and B
+             * is calculated:
+             *
+             * - get the distance between them
+             * - get the correspondent NUMA level for this distance
+             * - the arrays were initialized with their own numa_ids,
+             * and we're calculating the distance in node_id ascending order,
+             * starting from node 0. This will have a cascade effect in the
+             * algorithm because the associativity domains that node 0 defines
+             * will be carried over to the other nodes, and node 1
+             * associativities will be carried over unless there's already a
+             * node 0 associativity assigned, and so on. This happens because
+             * we'll assign assoc_src as the associativity domain of dst
+             * as well, for the given NUMA level.
+             *
+             * The PPC kernel expects the associativity domains of node 0 to
+             * be always 0, and this algorithm will grant that by default.
+             */
+            uint8_t distance = numa_info[src].distance[dst];
+            uint8_t n_level = spapr_numa_get_numa_level(distance);
+            uint32_t assoc_src;
+
+            /*
+             * n_level = 0 means that the distance is greater than our last
+             * rounded value (120). In this case there is no NUMA level match
+             * between src and dst and we can skip the remaining of the loop.
+             *
+             * The Linux kernel will assume that the distance between src and
+             * dst, in this case of no match, is 10 (local distance) doubled
+             * for each NUMA it didn't match. We have MAX_DISTANCE_REF_POINTS
+             * levels (4), so this gives us 10*2*2*2*2 = 160.
+             *
+             * This logic can be seen in the Linux kernel source code, as of
+             * v5.9, in arch/powerpc/mm/numa.c, function __node_distance().
+             */
+            if (n_level == 0) {
+                continue;
+            }
+
+            assoc_src = spapr->numa_assoc_array[src][n_level];
+            spapr->numa_assoc_array[dst][n_level] = assoc_src;
+        }
+    }
+
+}
+
 void spapr_numa_associativity_init(SpaprMachineState *spapr,
                                    MachineState *machine)
 {
     SpaprMachineClass *smc = SPAPR_MACHINE_GET_CLASS(spapr);
     int nb_numa_nodes = machine->numa_state->num_nodes;
     int i, j, max_nodes_with_gpus;
+    bool using_legacy_numa = spapr_machine_using_legacy_numa(spapr);
 
     /*
      * For all associativity arrays: first position is the size,
@@ -56,6 +162,17 @@ void spapr_numa_associativity_init(SpaprMachineState *spapr,
     for (i = 0; i < nb_numa_nodes; i++) {
         spapr->numa_assoc_array[i][0] = cpu_to_be32(MAX_DISTANCE_REF_POINTS);
         spapr->numa_assoc_array[i][MAX_DISTANCE_REF_POINTS] = cpu_to_be32(i);
+
+        /*
+         * Fill all associativity domains of non-zero NUMA nodes with
+         * node_id. This is required because the default value (0) is
+         * considered a match with associativity domains of node 0.
+         */
+        if (!using_legacy_numa && i != 0) {
+            for (j = 1; j < MAX_DISTANCE_REF_POINTS; j++) {
+                spapr->numa_assoc_array[i][j] = cpu_to_be32(i);
+            }
+        }
     }
 
     /*
@@ -85,7 +202,7 @@ void spapr_numa_associativity_init(SpaprMachineState *spapr,
      * 1 NUMA node) will not benefit from anything we're going to do
      * after this point.
      */
-    if (spapr_machine_using_legacy_numa(spapr)) {
+    if (using_legacy_numa) {
         return;
     }
 
@@ -95,6 +212,7 @@ void spapr_numa_associativity_init(SpaprMachineState *spapr,
         exit(EXIT_FAILURE);
     }
 
+    spapr_numa_define_associativity_domains(spapr);
 }
 
 void spapr_numa_write_associativity_dt(SpaprMachineState *spapr, void *fdt,
-- 
2.26.2


