Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70306C4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 19:54:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A81CA2220C
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 19:54:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CiNC0aDH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A81CA2220C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45982 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLXJw-0004Ox-KN
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 15:54:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55666)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1kLXH3-0001ui-H5; Thu, 24 Sep 2020 15:51:27 -0400
Received: from mail-qv1-xf42.google.com ([2607:f8b0:4864:20::f42]:37840)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1kLXGx-00019G-Ln; Thu, 24 Sep 2020 15:51:25 -0400
Received: by mail-qv1-xf42.google.com with SMTP id db4so151776qvb.4;
 Thu, 24 Sep 2020 12:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=wzrMd4eBXeLBiNY+rrKL5I5ntV6Gub53UCMYZ5Jggdc=;
 b=CiNC0aDHBAfDP/YEiV38XII4W1vAc7jr4gneJQydm2I1EMEc9dopJMopyzehNXoWkP
 g6WSmnWWNVQgWMTKjHdLkpZJbWUVQTmRfbgkhre3yZ1ZuoQLjKQqzrIjvtRjpZOuB8Fw
 5urJLZbNLZxVUYq6Qb5hJd6iKhGpYaxoPRkxtBfui6XjOtkOGGE3027Dskx+d7xXIXfa
 Cis6FJo8Xcv6VTF7X/7lsTymwqizDYuMYNUhltae5Q7AwbpL+c0mxTKgG782eddoZdcX
 WWk8w8IH9aS2pX7c+BPSlUpW3qD0eR9imX4OqtNf+uN8tZOMWeFRUSkAw7s9BXTCBohv
 IOPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=wzrMd4eBXeLBiNY+rrKL5I5ntV6Gub53UCMYZ5Jggdc=;
 b=tVIZDEIEmZZu9+I5QKpSMyG8k2fe9AVlgA+zRb8k/h4DZ3RCqj+CWzLxJ4KjVfbMdZ
 eVCvE5Po50CVt4MYawrlYeo/4ecFe9M48i1toencBSOtOp5AulL1L98PDzW52daMUL6P
 m8U3aFRqKdqZVipKOfxhkp3S8/ztlM3P+2WdNhD7ot16TKX4RDl/GaZmtFHH+BeZGXpN
 y55/W+q+OpHh0qlvZdXH9Zpalwst/mSQgnUw3knz0IKJZ33y62CRuaSoL4Z2dHRISGfb
 zYTYSQ6KEu8yCyV2+qPqOSkRdYOVxjHlmGC0314S2AepXjJwmhY7sGo4r8KywUSXf4Yu
 QJjw==
X-Gm-Message-State: AOAM530dou1VIo6onhnEB7whAGtmyYf7CFQVm2euTOMAbDjAMLIstSo6
 8KXS9eK6PoJAqjgzejz2rhFhBZjg9AcRdQ==
X-Google-Smtp-Source: ABdhPJwXXMc6DyEtgTTINaU9JgJdnPbTWnXNS4gl5eEwL5y+7hMzM/8z9Q0I7Iey/gsYx8UAtLvTUA==
X-Received: by 2002:ad4:47cc:: with SMTP id p12mr879620qvw.26.1600977077662;
 Thu, 24 Sep 2020 12:51:17 -0700 (PDT)
Received: from rekt.ibmuc.com ([2804:431:c7c7:c625:6c0e:4720:8228:5f68])
 by smtp.gmail.com with ESMTPSA id f3sm381613qtg.71.2020.09.24.12.51.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2020 12:51:17 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 5/6] spapr_numa: consider user input when defining
 associativity
Date: Thu, 24 Sep 2020 16:50:57 -0300
Message-Id: <20200924195058.362984-6-danielhb413@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200924195058.362984-1-danielhb413@gmail.com>
References: <20200924195058.362984-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f42;
 envelope-from=danielhb413@gmail.com; helo=mail-qv1-xf42.google.com
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

We have one more kernel restriction to handle in this patch:
the associativity array of node 0 must be filled with zeroes
[1]. The strategy below ensures that this will happen.

spapr_numa_define_associativity_domains() will read the distance
(already PAPRified) between the nodes from numa_state and determine
the appropriate NUMA level. The NUMA domains, processed in ascending
order, are going to be matched via NUMA levels, and the lowest
associativity domain value is assigned to that specific level for
both.

This will create an heuristic where the associativities of the first
nodes have higher priority and are re-used in new matches, instead of
overwriting them with a new associativity match. This is necessary
because neither QEMU, nor the pSeries kernel, supports multiple
associativity domains for each resource, meaning that we have to
decide which associativity relation is relevant.

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
 hw/ppc/spapr_numa.c | 101 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 100 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/spapr_numa.c b/hw/ppc/spapr_numa.c
index ea33439a15..21cae3f799 100644
--- a/hw/ppc/spapr_numa.c
+++ b/hw/ppc/spapr_numa.c
@@ -80,12 +80,99 @@ static void spapr_numa_PAPRify_distances(MachineState *ms)
     }
 }
 
+static uint8_t spapr_numa_get_numa_level(uint8_t distance)
+{
+    uint8_t numa_level;
+
+    switch (distance) {
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
+             * we'll assign the lowest value of assoc_src and assoc_dst to be
+             * the associativity domain of both, for the given NUMA level.
+             *
+             * The PPC kernel expects the associativity domains of node 0 to
+             * be always 0, and this algorithm will grant that by default.
+             */
+            uint8_t distance = numa_info[src].distance[dst];
+            uint8_t n_level = spapr_numa_get_numa_level(distance);
+            uint32_t assoc_src, assoc_dst;
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
+            assoc_src = be32_to_cpu(spapr->numa_assoc_array[src][n_level]);
+            assoc_dst = be32_to_cpu(spapr->numa_assoc_array[dst][n_level]);
+
+            if (assoc_src < assoc_dst) {
+                spapr->numa_assoc_array[dst][n_level] = cpu_to_be32(assoc_src);
+            } else {
+                spapr->numa_assoc_array[src][n_level] = cpu_to_be32(assoc_dst);
+            }
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
@@ -99,6 +186,17 @@ void spapr_numa_associativity_init(SpaprMachineState *spapr,
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
@@ -128,7 +226,7 @@ void spapr_numa_associativity_init(SpaprMachineState *spapr,
      * 1 NUMA node) will not benefit from anything we're going to do
      * after this point.
      */
-    if (spapr_machine_using_legacy_numa(spapr)) {
+    if (using_legacy_numa) {
         return;
     }
 
@@ -139,6 +237,7 @@ void spapr_numa_associativity_init(SpaprMachineState *spapr,
     }
 
     spapr_numa_PAPRify_distances(machine);
+    spapr_numa_define_associativity_domains(spapr);
 }
 
 void spapr_numa_write_associativity_dt(SpaprMachineState *spapr, void *fdt,
-- 
2.26.2


