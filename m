Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA7D4C41604
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 17:34:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC2B22168B
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 17:34:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JCFsUdRZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC2B22168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60256 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQDKu-0003FK-Te
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 13:34:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59258)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1kQDFZ-0006AO-05; Wed, 07 Oct 2020 13:29:13 -0400
Received: from mail-qk1-x72e.google.com ([2607:f8b0:4864:20::72e]:35355)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1kQDFS-00008E-Sw; Wed, 07 Oct 2020 13:29:12 -0400
Received: by mail-qk1-x72e.google.com with SMTP id 140so2020316qko.2;
 Wed, 07 Oct 2020 10:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=iUBW/FZN4OUPJQhsvziAh5iqbYebZLNMaGJLcZL+gkY=;
 b=JCFsUdRZMyui0itPAOV6qRQtrtMvSRd+PfoX/QVsn98mKrro3fBZrTD3dp3PjVR+OA
 qiWQbvVoisX1x2kn9bFdznITkWFsFMz17xH/rmsfe7E8ezkOUan6hL399ev5a9PYuVyF
 BxJqHEYTY8074SYLV1tEcqCYaJB6xyM7IHNmTnpDuXjh2/92FbpJPuSHhPRF9PmqUB5c
 eKkw0jkcCko6spknI42d7yBm5zUFXjWhlXr0rGUEbp7N5uJlO7YCX/IIUXSHxpWOQ8s6
 2iBH58Z0ika6ET/gAoKp4hFSqK29No0Z49rVzFH8DzvR7PlyP0X6U04/SSquNsaXzaWE
 v1ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=iUBW/FZN4OUPJQhsvziAh5iqbYebZLNMaGJLcZL+gkY=;
 b=jeVa/6n2iEjmaDHNWUCq9jySgyOrZ2vI44V/Mpt+KuRqMaoRPhXCsyV88wvDMaUIOp
 Hj9XOSh3YVn7f0O6j/mYBRxCO+zfMvV8iVe9W/5tkDhWvZ0ytEK8JaE73Z+q4KryI92J
 MBjkCAabvVWb50/uxvepXilhs2kV4rhGr95afHClTuQvu9xe8wRQVgroHshv4hauVsIq
 qwkDuOhtZGlcnAhHPSKsPqucCPYjdZvuMMiYq4uSbIfwoXCShOxr02WekPoKqiEzTGC8
 PF1X+vmIMg5ErU9OO2BW4hGhUs1wv8nc5FPQ+B9CIx1E2dSJJrnthdPdrmEG3C7fcDaH
 8rVw==
X-Gm-Message-State: AOAM533LAjxG+WhotigyEMPmk+ZJCr4t+WoLcn8MWi3IxEtIUR9cDO7r
 8c3sLuqo+1z4VT+aLqAGL1xlM0EJyw2dzA==
X-Google-Smtp-Source: ABdhPJz5d/x3KXsYv2PC14Hws3Jg+jDfhqJXhpXpapl2wqcQMrtpDLs5tTPT7t+x1TConPNutZUzQw==
X-Received: by 2002:a37:a495:: with SMTP id n143mr3946511qke.394.1602091745040; 
 Wed, 07 Oct 2020 10:29:05 -0700 (PDT)
Received: from rekt.ibmuc.com ([2804:431:c7c6:5a9b:54fc:df2a:8a5e:989b])
 by smtp.gmail.com with ESMTPSA id e39sm2080117qtk.32.2020.10.07.10.29.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2020 10:29:04 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 4/5] spapr_numa: consider user input when defining
 associativity
Date: Wed,  7 Oct 2020 14:28:48 -0300
Message-Id: <20201007172849.302240-5-danielhb413@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201007172849.302240-1-danielhb413@gmail.com>
References: <20201007172849.302240-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::72e;
 envelope-from=danielhb413@gmail.com; helo=mail-qk1-x72e.google.com
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

A new function called spapr_numa_define_associativity_domains()
is created to calculate the associativity domains and change
the associativity arrays considering user input. This is how
the associativity domain between two NUMA nodes A and B is
calculated:

- get the distance D between them

- get the correspondent NUMA level 'n_level' for D. This is done
via a helper called spapr_numa_get_numa_level()

- all associativity arrays were initialized with their own
numa_ids, and we're calculating the distance in node_id ascending
order, starting from node id 0 (the first node retrieved by
numa_state). This will have a cascade effect in the algorithm because
the associativity domains that node 0 defines will be carried over to
other nodes, and node 1 associativities will be carried over after
taking node 0 associativities into account, and so on. This
happens because we'll assign assoc_src as the associativity domain
of dst as well, for all NUMA levels beyond and including n_level.

The PPC kernel expects the associativity domains of the first node
(node id 0) to be always 0 [1], and this algorithm will grant that
by default.

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
 capstone            |   2 +-
 hw/ppc/spapr_numa.c | 110 +++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 110 insertions(+), 2 deletions(-)

diff --git a/capstone b/capstone
index f8b1b83301..22ead3e0bf 160000
--- a/capstone
+++ b/capstone
@@ -1 +1 @@
-Subproject commit f8b1b833015a4ae47110ed068e0deb7106ced66d
+Subproject commit 22ead3e0bfdb87516656453336160e0a37b066bf
diff --git a/hw/ppc/spapr_numa.c b/hw/ppc/spapr_numa.c
index 16badb1f4b..b50796bbe3 100644
--- a/hw/ppc/spapr_numa.c
+++ b/hw/ppc/spapr_numa.c
@@ -37,12 +37,108 @@ static bool spapr_numa_is_symmetrical(MachineState *ms)
     return true;
 }
 
+/*
+ * This function will translate the user distances into
+ * what the kernel understand as possible values: 10
+ * (local distance), 20, 40, 80 and 160, and return the equivalent
+ * NUMA level for each. Current heuristic is:
+ *  - local distance (10) returns numa_level = 0x4, meaning there is
+ *    no rounding for local distance
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
+    if (distance == 10) {
+        return 0x4;
+    } else if (distance > 11 && distance <= 30) {
+        return 0x3;
+    } else if (distance > 31 && distance <= 60) {
+        return 0x2;
+    } else if (distance > 61 && distance <= 120) {
+        return 0x1;
+    }
+
+    return 0;
+}
+
+static void spapr_numa_define_associativity_domains(SpaprMachineState *spapr)
+{
+    MachineState *ms = MACHINE(spapr);
+    NodeInfo *numa_info = ms->numa_state->nodes;
+    int nb_numa_nodes = ms->numa_state->num_nodes;
+    int src, dst, i;
+
+    for (src = 0; src < nb_numa_nodes; src++) {
+        for (dst = src; dst < nb_numa_nodes; dst++) {
+            /*
+             * This is how the associativity domain between A and B
+             * is calculated:
+             *
+             * - get the distance D between them
+             * - get the correspondent NUMA level 'n_level' for D
+             * - all associativity arrays were initialized with their own
+             * numa_ids, and we're calculating the distance in node_id
+             * ascending order, starting from node id 0 (the first node
+             * retrieved by numa_state). This will have a cascade effect in
+             * the algorithm because the associativity domains that node 0
+             * defines will be carried over to other nodes, and node 1
+             * associativities will be carried over after taking node 0
+             * associativities into account, and so on. This happens because
+             * we'll assign assoc_src as the associativity domain of dst
+             * as well, for all NUMA levels beyond and including n_level.
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
+            /*
+             * We must assign all assoc_src to dst, starting from n_level
+             * and going up to 0x1.
+             */
+            for (i = n_level; i > 0; i--) {
+                assoc_src = spapr->numa_assoc_array[src][i];
+                spapr->numa_assoc_array[dst][i] = assoc_src;
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
@@ -56,6 +152,17 @@ void spapr_numa_associativity_init(SpaprMachineState *spapr,
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
@@ -85,7 +192,7 @@ void spapr_numa_associativity_init(SpaprMachineState *spapr,
      * 1 NUMA node) will not benefit from anything we're going to do
      * after this point.
      */
-    if (spapr_machine_using_legacy_numa(spapr)) {
+    if (using_legacy_numa) {
         return;
     }
 
@@ -95,6 +202,7 @@ void spapr_numa_associativity_init(SpaprMachineState *spapr,
         exit(EXIT_FAILURE);
     }
 
+    spapr_numa_define_associativity_domains(spapr);
 }
 
 void spapr_numa_write_associativity_dt(SpaprMachineState *spapr, void *fdt,
-- 
2.26.2


