Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51726C2D0A8
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 19:44:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FEE520888
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 19:44:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ED7BBIc3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FEE520888
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43126 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLAh1-0002oC-5A
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 15:44:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39690)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1kLAY3-0002lB-SD; Wed, 23 Sep 2020 15:35:27 -0400
Received: from mail-qt1-x844.google.com ([2607:f8b0:4864:20::844]:44071)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1kLAY0-000058-Of; Wed, 23 Sep 2020 15:35:27 -0400
Received: by mail-qt1-x844.google.com with SMTP id e7so894263qtj.11;
 Wed, 23 Sep 2020 12:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=U8iLQ4CK3SSipSwps1buB7OCIE9Aj5GfsslZoNsZ8xc=;
 b=ED7BBIc3H5GwQLVW5PJVLWBCT6GeKF2IDV6qL2twyFHLYj/o1nKaDoC0FnVbczWTRu
 JARr5gucDb6f8OGSgRmDHfn3Tfy18ziyXE9AnHRnoyJ/zKU9ofjonuSE4d5pKkrdeP1x
 NqYGS0ww9Za3LdQsuzSa9vh6Hn6zCbROsjSPd2hyspB2Y4iJeEst2BeAcff0w8hbicDu
 xIqU5jRf2Bf7vWU/omSP1Rmd2WgwQ4qbO8hdwQb47O/n3xcX/hVlQ3XH7aE0XXc7xBWw
 v68h0FpqvnWYS1iJBxQDJ/gldsEVvn+EFmVQd3uLO+wO6KW2Wlkliib9UZUtwbDAdHsc
 8O1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=U8iLQ4CK3SSipSwps1buB7OCIE9Aj5GfsslZoNsZ8xc=;
 b=KDxTKk1JSoW8xNB2BQyU5Ze/RcMq+ZobJgWqomX52OH2AWEorbya1gNyOxAlmqooxn
 Pyc6w2T87bWXa5pSFJ+FcGuAxn0AChOFb+PlyoyEedFyl52NlIRdNbY4OnkyfV0wh2yb
 JzwQ41ipR8U63JptoVHSkQ6AQSuL4qAjSMZ7yS7NyvkkPF3drAJlGex8gNqqIiVYFcIP
 JlcKORYoWf9sTSDuaZaa1ENAyo+cpToed6sA7HZMhthBT37EwrAvJOFpkWIAPKXPU2V9
 /obbF5Ydp12z5zQ8miY2X0vKpSaElL8sLTStWjS/GCmM2OVi3KHHDSOcw2qV70+BUU2H
 IgXg==
X-Gm-Message-State: AOAM5306Kg2b1RCycY8ZFZTe22jisaECcpSddqV5g96jOFJ/EYZrsWoI
 UgrQX8CiWHEEhtZTXzwT0IVmChNl63r8WQ==
X-Google-Smtp-Source: ABdhPJwbWOTMbsCG9zW4bUMj+HuV4NZyBs7REvAeDe1XuZ2O3P8o0ksNnqULIztAOErLKUVNlrrlsw==
X-Received: by 2002:ac8:5650:: with SMTP id 16mr1847379qtt.120.1600889722731; 
 Wed, 23 Sep 2020 12:35:22 -0700 (PDT)
Received: from rekt.ibmuc.com ([2804:431:c7c7:9e50:6b84:53b8:5d9d:d408])
 by smtp.gmail.com with ESMTPSA id u4sm612362qkk.68.2020.09.23.12.35.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2020 12:35:22 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 5/6] spapr_numa: consider user input when defining
 associativity
Date: Wed, 23 Sep 2020 16:34:57 -0300
Message-Id: <20200923193458.203186-6-danielhb413@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200923193458.203186-1-danielhb413@gmail.com>
References: <20200923193458.203186-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::844;
 envelope-from=danielhb413@gmail.com; helo=mail-qt1-x844.google.com
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
 hw/ppc/spapr_numa.c | 81 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 80 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/spapr_numa.c b/hw/ppc/spapr_numa.c
index 688391278e..c84f77cda7 100644
--- a/hw/ppc/spapr_numa.c
+++ b/hw/ppc/spapr_numa.c
@@ -80,12 +80,79 @@ static void spapr_numa_PAPRify_distances(MachineState *ms)
     }
 }
 
+static uint8_t spapr_numa_get_NUMA_level(uint8_t distance)
+{
+    uint8_t numa_level;
+
+    switch (distance) {
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
+static void spapr_numa_define_associativity_domains(SpaprMachineState *spapr,
+                                                    MachineState *ms)
+{
+    int src, dst;
+    int nb_numa_nodes = ms->numa_state->num_nodes;
+    NodeInfo *numa_info = ms->numa_state->nodes;
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
+            uint8_t n_level = spapr_numa_get_NUMA_level(distance);
+            uint32_t assoc_src, assoc_dst;
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
@@ -99,6 +166,17 @@ void spapr_numa_associativity_init(SpaprMachineState *spapr,
     for (i = 0; i < nb_numa_nodes; i++) {
         spapr->numa_assoc_array[i][0] = cpu_to_be32(MAX_DISTANCE_REF_POINTS);
         spapr->numa_assoc_array[i][MAX_DISTANCE_REF_POINTS] = cpu_to_be32(i);
+
+        /*
+         * Fill all associativity domains of the node with node_id.
+         * This is required because the kernel makes valid associativity
+         * matches with the zeroes if we leave the matrix unitialized.
+         */
+        if (!using_legacy_numa) {
+            for (j = 1; j < MAX_DISTANCE_REF_POINTS; j++) {
+                spapr->numa_assoc_array[i][j] = cpu_to_be32(i);
+            }
+        }
     }
 
     /*
@@ -128,7 +206,7 @@ void spapr_numa_associativity_init(SpaprMachineState *spapr,
      * 1 NUMA node) will not benefit from anything we're going to do
      * after this point.
      */
-    if (spapr_machine_using_legacy_numa(spapr)) {
+    if (using_legacy_numa) {
         return;
     }
 
@@ -139,6 +217,7 @@ void spapr_numa_associativity_init(SpaprMachineState *spapr,
     }
 
     spapr_numa_PAPRify_distances(machine);
+    spapr_numa_define_associativity_domains(spapr, machine);
 }
 
 void spapr_numa_write_associativity_dt(SpaprMachineState *spapr, void *fdt,
-- 
2.26.2


