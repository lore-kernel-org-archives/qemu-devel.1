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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9267C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2020 15:22:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D1842310F
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2020 15:22:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nPhx5OcI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D1842310F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46886 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6y0y-0001Ql-Jx
	for qemu-devel@archiver.kernel.org; Sat, 15 Aug 2020 11:22:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60276)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1k6xyF-0005pw-9g; Sat, 15 Aug 2020 11:19:47 -0400
Received: from mail-qk1-x731.google.com ([2607:f8b0:4864:20::731]:37938)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1k6xyD-00026P-Cn; Sat, 15 Aug 2020 11:19:47 -0400
Received: by mail-qk1-x731.google.com with SMTP id 77so11087988qkm.5;
 Sat, 15 Aug 2020 08:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=d2aeaGkVtyhLHxRTnglxsmaRe1/zdnOa+obmvojxAqs=;
 b=nPhx5OcIeEzG9ytkTifV9w4J/H/jmI+n5tlNQaDNUJ0/uSlOUJ3Dl/pND8+SZf97kS
 tfydWfvhKK1D+OH9LQPZGdMiAuS0dQlPl4uAf4CxgGSjvoeW0vD6AKStn2/5IqmbBjPo
 KdFXVHYHvv/pXH1mcJuaIRMAAmUgC2Cx9WaYgQMjuXRdRFqt66qo0453ap050gmFW9U8
 DmKzeoF/pP3JykYJEsNB2wfcLskwRXF24j1fPTUJ3Kr6vPeokCuss7z+/dGQL8ZVAh9G
 uycdJABfVx7bW0mxCxDC84AmMsqCoTUog0EQRHIqVi9N+HYQy5/swXatNlqlV+7WdMRZ
 4fnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=d2aeaGkVtyhLHxRTnglxsmaRe1/zdnOa+obmvojxAqs=;
 b=Ix1AdKgT5yhK/9RWgMMKnDXifApXLQuNcMLNk+Y7PgqoQpRrqTUKeuIUKXapSpGaT/
 OO961ha9QcO+lGwimYfn1XN8mG3A4TbSk9BE1RhnAEzR36n9fjYMH85sKQkhi9S2uJfP
 WnRMO+n7VeeYssADaHzpQc2lKd7yynSK1Jvuvq3CvrHFsoROfwGBJsB989HXYr3qgi5p
 ehDUT6N79BqUKCBzYNrT4Cm97I2Fv0e+VX5SDo7UPw3UW4Py7w49EIB6PjbLsXJZWMcc
 ONTUVqoO/xAEe4Sbr29jyA1/KGLi39s8OP4i3B1BT1vgOYlhT9M4CwVEAUZiDm7QRSv7
 cSNA==
X-Gm-Message-State: AOAM533gqEchz8OKxhUZ+3Ha+NOuGKm2wng0blsyGvwwcuNZa5wfVfCJ
 JcNOoMMZEnVa2J3rDq0f7tHkdTVnY/lcsg==
X-Google-Smtp-Source: ABdhPJwvT2SohpZxKh+oLUHKrzbPhDyFxksu3Y0/5paNkRPeJcKiMud2eLTIWqZwkwNG4lXsJCmJWQ==
X-Received: by 2002:ac8:490d:: with SMTP id e13mr3666701qtq.198.1597438492855; 
 Fri, 14 Aug 2020 13:54:52 -0700 (PDT)
Received: from rekt.ibmuc.com ([2804:431:c7c6:303f:d1dc:35d8:e9f6:c8b])
 by smtp.gmail.com with ESMTPSA id p33sm12301018qtp.49.2020.08.14.13.54.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2020 13:54:52 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 09/10] spapr: consider user input when defining spapr guest
 NUMA
Date: Fri, 14 Aug 2020 17:54:23 -0300
Message-Id: <20200814205424.543857-10-danielhb413@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200814205424.543857-1-danielhb413@gmail.com>
References: <20200814205424.543857-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::731;
 envelope-from=danielhb413@gmail.com; helo=mail-qk1-x731.google.com
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

This patch puts all the pieces together to finally allow user
input when defining the NUMA topology of the spapr guest.

The logic is centered in the new spapr_init_numa_assoc_domains()
function. This is called once at machine_init(), if we're not
using legacy_numa mode, to initiate the numa_assoc_domain matrix
introduced in the previous patch. We can divide the logic in two
that are mashed together in the body of this function.

First stage is to sanitize the user input from numa_state. Due to
the nature of what ACPI allows the user to do (directly define
the distances the guest will see in the DT) versus what PAPR
allows (we can hint at associativity relations, the OS must decide
what to do), we had to bake in kernel logic in here. The kernel
allows 4 levels of NUMA, where the last one is always the node_id
itself, with distance = 10. The other levels doubles the distances
of previous levels, meaning that the pSeries kernel will only
show distances of 20, 40, 80 and 160 (in case no match is found).
This first stage is then to get the distances defined by the user
and approximate them to those discrete values:

- user distance 11 to 30 will be interpreted as 20
- user distance 31 to 60 will be interpreted as 40
- user distance 61 to 120 will be interpreted as 80
- user distance 121 and beyond will be interpreted as 160
- user distance 10 stays 10

The other stage is defining the associativity domains based
on the NUMA level match. Again, more than one strategy exists
for this same problem, with different results. The approach
taken is to re-use any existing associativity values to the
new matches, instead of overwriting them with a new associativity
match. This decision is necessary because neither we, nor the
pSeries kernel, supports multiple associativity domains for
each resource, meaning that we have to decide what to preserve.
With the current logic, the associativities established by
the earlier nodes take precedence, i.e. associativities defined
by the first node are retained along all other nodes.

These decisions have direct impact on how the user will interact
with the NUMA topology, and none of them are perfect. To keep
this commit message no longer than it already is, let's update the
existing documentation in ppc-spapr-numa.rst with more in depth
details and design considerations/drawbacks in the next patch.

Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 hw/ppc/spapr.c | 109 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 109 insertions(+)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 4f50ab21ee..0d60d06cf4 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -222,6 +222,109 @@ void spapr_set_associativity(uint32_t *assoc, int node_id, int cpu_index,
     assoc[4] = cpu_to_be32(node_id);
 }
 
+static void spapr_numa_assoc_assign_domain(SpaprMachineClass *smc,
+                                           uint8_t nodeA, uint8_t nodeB,
+                                           uint8_t numaLevel,
+                                           uint8_t curr_domain)
+{
+    uint8_t assoc_A, assoc_B;
+
+    assoc_A = smc->numa_assoc_domains[nodeA][numaLevel];
+    assoc_B = smc->numa_assoc_domains[nodeB][numaLevel];
+
+    /* No associativity domains on both. Assign and move on */
+    if ((assoc_A | assoc_B) == 0) {
+        smc->numa_assoc_domains[nodeA][numaLevel] = curr_domain;
+        smc->numa_assoc_domains[nodeB][numaLevel] = curr_domain;
+        return;
+    }
+
+    /* Use the existing assoc domain of any of the nodes to not
+     * disrupt previous associations already defined */
+    if (assoc_A != 0) {
+        smc->numa_assoc_domains[nodeB][numaLevel] = assoc_A;
+    } else {
+        smc->numa_assoc_domains[nodeA][numaLevel] = assoc_B;
+    }
+}
+
+static void spapr_init_numa_assoc_domains(MachineState *machine)
+{
+    SpaprMachineClass *smc = SPAPR_MACHINE_GET_CLASS(machine);
+    int nb_numa_nodes = machine->numa_state->num_nodes;
+    NodeInfo *numa_info = machine->numa_state->nodes;
+    uint8_t existing_nodes[nb_numa_nodes];
+    int i, j, src_node, dst_node, index = 0;
+
+    /* We don't have information about any extra NUMA nodes that
+     * the machine might create at this point (e.g. NVLink2 GPUs).
+     * Assigning associativity domains with low numbers might have
+     * unintended consequences in the presence of GPUs, which are
+     * supposed to always be at maximum distance of everything else,
+     * because we might end up using a GPU numa_id identifier by
+     * accident.
+     *
+     * Starting this counter at MAX_NODES avoids any possible
+     * collision since no NUMA id can reach this value. */
+    uint8_t assoc_domain = MAX_NODES;
+
+    /* We will assume that the NUMA nodes might be sparsed. This
+     * preliminary fetch step is required to avoid having to search
+     * for an existing NUMA node more than once. */
+    for (i = 0; i < MAX_NODES; i++) {
+        if (numa_info[i].present) {
+            existing_nodes[index++] = i;
+            if (index == nb_numa_nodes) {
+                break;
+            }
+        }
+    }
+
+    /* Start iterating through the existing numa nodes to
+     * define associativity groups */
+    for (i = 0; i < nb_numa_nodes; i++) {
+        uint8_t distance = 20;
+        uint8_t lower_end = 10;
+        uint8_t upper_end = 0;
+
+        src_node = existing_nodes[i];
+
+        /* Calculate all associativity domains src_node belongs to. */
+        for(index = 0; index < 3; index++) {
+            upper_end = distance/2 + distance;
+
+            for(j = i + 1; j < nb_numa_nodes; j++) {
+                uint8_t node_dist;
+
+                dst_node = existing_nodes[j];
+                node_dist = numa_info[src_node].distance[dst_node];
+
+                if (node_dist > lower_end && node_dist <= upper_end) {
+                    spapr_numa_assoc_assign_domain(smc, src_node, dst_node,
+                                                   2 - index, assoc_domain);
+                                                   assoc_domain++;
+                }
+            }
+
+            lower_end = upper_end;
+            distance *= 2;
+        }
+    }
+
+    /* Zero (0) is considered a valid associativity domain identifier.
+     * To avoid NUMA nodes having matches where it wasn't intended, fill
+     * the zeros with unique identifiers. */
+    for (i = 0; i < nb_numa_nodes; i++) {
+        src_node = existing_nodes[i];
+        for (j = 0; j < 3; j++) {
+            if (smc->numa_assoc_domains[src_node][j] == 0) {
+                smc->numa_assoc_domains[src_node][j] = assoc_domain;
+                assoc_domain++;
+            }
+        }
+    }
+ }
+
 static int spapr_fixup_cpu_numa_dt(void *fdt, int offset, PowerPCCPU *cpu,
                                    MachineState *machine)
 {
@@ -2887,6 +2990,12 @@ static void spapr_machine_init(MachineState *machine)
     spapr->current_numa_id = 0;
     spapr->extra_numa_nodes = 0;
 
+    /* We don't need to init the NUMA matrix if we're running in
+     * legacy NUMA mode. */
+    if (!spapr_machine_using_legacy_numa(spapr)) {
+        spapr_init_numa_assoc_domains(machine);
+    }
+
     if ((!kvm_enabled() || kvmppc_has_cap_mmu_radix()) &&
         ppc_type_check_compat(machine->cpu_type, CPU_POWERPC_LOGICAL_3_00, 0,
                               spapr->max_compat_pvr)) {
-- 
2.26.2


