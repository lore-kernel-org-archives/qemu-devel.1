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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A62D4C4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 19:57:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E3862220C
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 19:57:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DwS3ZqEU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E3862220C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51816 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLXMR-00072H-Ox
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 15:56:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55578)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1kLXGv-0001o3-P9; Thu, 24 Sep 2020 15:51:19 -0400
Received: from mail-qv1-xf41.google.com ([2607:f8b0:4864:20::f41]:37839)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1kLXGt-00018s-M4; Thu, 24 Sep 2020 15:51:17 -0400
Received: by mail-qv1-xf41.google.com with SMTP id db4so151687qvb.4;
 Thu, 24 Sep 2020 12:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=21vV+hmckvLTxsw8vcWpzHxsduGLiKrg1o2Z9DjqQW8=;
 b=DwS3ZqEU/2yqIMBt1ql3BWhUM3Evt5cD2m02BudW5rsWjrAHqw0njW6DwX89lHp9oW
 Ho5Uw0k2nieFJzzjKVybj2B3siymYOKSV+ojo6FjFCVWR+tBlSlVoMyD8oty1iqUwaQt
 erYVFdHAescMeUpMFOhCUEfVtfLa3oVJnMm0x565xuYtsFO1zv3higOVTjO1b3LoqpY/
 c6DHBNFRimldqEptute0siQZXTA2pbN1reyr9GXu27MfQm/abkYn0DnuKAWkWuTq0E6Q
 4U5Lddi5y8y90Zfl4qNkIgDcNLWBBgtsAkzVUZUhmt6PJe11cDaDkr8InqYNgk5K+J0Z
 UyTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=21vV+hmckvLTxsw8vcWpzHxsduGLiKrg1o2Z9DjqQW8=;
 b=KURgY+Ym9gyT4oYDlulZym95KSmwh6bt5UwSRmZgeOtAp+eCZEczbBqNCDhtXynhXt
 CGOcuwPp1LklzxAeO89Ce8z0rOgG9otvNbn14eYOJ+D8M3gQdBcZ9yRZg8yNBUl/CJQR
 PWXkwt9KOWJ9saNoNCzSYS7u9SJCX/6aqo9n9oeOsrU/v6PA0IE/LsufN0OhPtMYXNn+
 nxTGaovZ/k58Rqz1si9+aTt785dUfoW4bdABMkD+LakGBKo8yufHmMu5h+w7DoA9fd+w
 MJvm/QrzviTOUlDSgxFvFjQzbYGweyyLXiMDFG5uHUA3mclpOjxxG4pYRiKAjQP6kGzI
 XReg==
X-Gm-Message-State: AOAM530QxYzHH/dA7D7xFRgCxCmfG3GxKCdpXS7hfzHn6uAMI6PWHCAl
 +rgbkCIVnmyDPcmsQvlM+hetQ9IhU7f0vg==
X-Google-Smtp-Source: ABdhPJyR5O0Rx1/4+oH/NCOzxv97vhfLBY9HqYBfC8TwSUtCBON/wOQVz7NnutjC47QXsDzCpoUQqQ==
X-Received: by 2002:a0c:c543:: with SMTP id y3mr852905qvi.47.1600977073676;
 Thu, 24 Sep 2020 12:51:13 -0700 (PDT)
Received: from rekt.ibmuc.com ([2804:431:c7c7:c625:6c0e:4720:8228:5f68])
 by smtp.gmail.com with ESMTPSA id f3sm381613qtg.71.2020.09.24.12.51.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2020 12:51:13 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 3/6] spapr_numa: translate regular NUMA distance to PAPR
 distance
Date: Thu, 24 Sep 2020 16:50:55 -0300
Message-Id: <20200924195058.362984-4-danielhb413@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200924195058.362984-1-danielhb413@gmail.com>
References: <20200924195058.362984-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f41;
 envelope-from=danielhb413@gmail.com; helo=mail-qv1-xf41.google.com
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

QEMU allows the user to set NUMA distances in the command line.
For ACPI architectures like x86, this means that user input is
used to populate the SLIT table, and the guest perceives the
distances as the user chooses to.

PPC64 does not work that way. In the PAPR concept of NUMA,
associativity relations between the NUMA nodes are provided by
the device tree, and the guest kernel is free to calculate the
distances as it sees fit. Given how ACPI architectures works,
this puts the pSeries machine in a strange spot - users expect
to define NUMA distances like in the ACPI case, but QEMU does
not have control over it. To give pSeries users a similar
experience, we'll need to bring kernel specifics to QEMU
to approximate the NUMA distances.

The pSeries kernel works with the NUMA distance range 10,
20, 40, 80 and 160. The code starts at 10 (local distance) and
searches for a match in the first NUMA level between the
resources. If there is no match, the distance is doubled and
then it proceeds to try to match in the next NUMA level. Rinse
and repeat for MAX_DISTANCE_REF_POINTS levels.

This patch introduces a spapr_numa_PAPRify_distances() helper
that translates the user distances to kernel distance, which
we're going to use to determine the associativity domains for
the NUMA nodes.

Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 hw/ppc/spapr_numa.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/hw/ppc/spapr_numa.c b/hw/ppc/spapr_numa.c
index fe395e80a3..990a5fce08 100644
--- a/hw/ppc/spapr_numa.c
+++ b/hw/ppc/spapr_numa.c
@@ -37,6 +37,49 @@ static bool spapr_numa_is_symmetrical(MachineState *ms)
     return true;
 }
 
+/*
+ * This function will translate the user distances into
+ * what the kernel understand as possible values: 10
+ * (local distance), 20, 40, 80 and 160. Current heuristic
+ * is:
+ *
+ *  - distances between 11 and 30 inclusive -> rounded to 20
+ *  - distances between 31 and 60 inclusive -> rounded to 40
+ *  - distances between 61 and 120 inclusive -> rounded to 80
+ *  - everything above 120 -> 160
+ *
+ * This step can also be done in the same time as the NUMA
+ * associativity domains calculation, at the cost of extra
+ * complexity. We chose to keep it simpler.
+ *
+ * Note: this will overwrite the distance values in
+ * ms->numa_state->nodes.
+ */
+static void spapr_numa_PAPRify_distances(MachineState *ms)
+{
+    int src, dst;
+    int nb_numa_nodes = ms->numa_state->num_nodes;
+    NodeInfo *numa_info = ms->numa_state->nodes;
+
+    for (src = 0; src < nb_numa_nodes; src++) {
+        for (dst = src; dst < nb_numa_nodes; dst++) {
+            uint8_t distance = numa_info[src].distance[dst];
+            uint8_t rounded_distance = 160;
+
+            if (distance > 11 && distance <= 30) {
+                rounded_distance = 20;
+            } else if (distance > 31 && distance <= 60) {
+                rounded_distance = 40;
+            } else if (distance > 61 && distance <= 120) {
+                rounded_distance = 80;
+            }
+
+            numa_info[src].distance[dst] = rounded_distance;
+            numa_info[dst].distance[src] = rounded_distance;
+        }
+    }
+}
+
 void spapr_numa_associativity_init(SpaprMachineState *spapr,
                                    MachineState *machine)
 {
@@ -95,6 +138,7 @@ void spapr_numa_associativity_init(SpaprMachineState *spapr,
         exit(EXIT_FAILURE);
     }
 
+    spapr_numa_PAPRify_distances(machine);
 }
 
 void spapr_numa_write_associativity_dt(SpaprMachineState *spapr, void *fdt,
-- 
2.26.2


