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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4827DC2D0A8
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 19:40:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C026E235FD
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 19:40:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NhBKRbjj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C026E235FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLAcR-0007dU-OU
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 15:39:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39664)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1kLAY1-0002gV-3Z; Wed, 23 Sep 2020 15:35:25 -0400
Received: from mail-qv1-xf44.google.com ([2607:f8b0:4864:20::f44]:44441)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1kLAXw-0008W3-Nf; Wed, 23 Sep 2020 15:35:24 -0400
Received: by mail-qv1-xf44.google.com with SMTP id j10so581571qvk.11;
 Wed, 23 Sep 2020 12:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2BOBuZbC65SYlx/sk/v7p8L/zpIOl98wNdQzFPXYVBQ=;
 b=NhBKRbjjDLM2gwpjNEqoDd1laEx7YvLhOjgyaBbmQXoY0yOMrAE+pdt9AE8LGcQE/j
 GOlz+05ctJRGYCqoJ4PGnb8YnRmFl5+7k25DEbKr2mxjBihc/umSr5vKz4XiSHZFVuvX
 zOko9m7+sS64POgcCf7zhQWIrqIfuMUspbCeTy1p6ISRReXhQzIFTAgxMu5YG5RxQZzs
 VM3H7b7tEmTRJVCSadalWAWYenTXOjKllznesjrTa65IE6/lYjJeY7MafHm3hnywD60P
 b2ZC0+bSQIRwS46LG/tMPtchPyaipgzEv+cl3B3hcMGCRqyMxcW3vI+775CZwebSXUhB
 vlKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2BOBuZbC65SYlx/sk/v7p8L/zpIOl98wNdQzFPXYVBQ=;
 b=C4BJ63TkSxAcU8Wb9wv/UFj3zkRGQRq6Ns03dBZ3D1yHkOAlDPqB1JNDIZD/cOyXXu
 ntvEBqyKWTOv+VtR+JbNIukJ/0ZJtk6Bmh7PNBI54ypWnNt4bfCxgxVVrVylONnB71HS
 oskyXHyEOhT3IDc7A8eQT29TUTgpiyLnNUFtySk0pqksPUTl5okGaiHE1JK5ASjG7nT1
 +SvZ3JweWO6O6aSZ3tEyIhL/Nknqfot3coiz53G5Upk4mM6Tvu5kDapfOruTlPQyk+jV
 meWDClL/dbcz2A/sHXVirxezFm9sbwnrIJt9duuk4s0/YQYnDXDbar3WB4/2f1/i5zyv
 CBDA==
X-Gm-Message-State: AOAM532xOLLk/daSKsLljFDWHBr4Zqtks+9PuewZ038ZQfOkSdISKnO3
 TfxVqEgf3RM2J+3ddZWgzqkgG25fVBuGGA==
X-Google-Smtp-Source: ABdhPJxxfucnSFaoOQxOVD26OJSmmXpATxG8dnpE8PS5zcP+3WlChbXbWtlSIkaUWLukzcSuYpgY0w==
X-Received: by 2002:a0c:ac02:: with SMTP id l2mr1484637qvb.25.1600889719235;
 Wed, 23 Sep 2020 12:35:19 -0700 (PDT)
Received: from rekt.ibmuc.com ([2804:431:c7c7:9e50:6b84:53b8:5d9d:d408])
 by smtp.gmail.com with ESMTPSA id u4sm612362qkk.68.2020.09.23.12.35.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2020 12:35:18 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/6] spapr_numa: translate regular NUMA distance to PAPR
 distance
Date: Wed, 23 Sep 2020 16:34:55 -0300
Message-Id: <20200923193458.203186-4-danielhb413@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200923193458.203186-1-danielhb413@gmail.com>
References: <20200923193458.203186-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f44;
 envelope-from=danielhb413@gmail.com; helo=mail-qv1-xf44.google.com
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
index 36aaa273ee..180800b2f3 100644
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
+ *  - distances between 11 and 30 -> rounded to 20
+ *  - distances between 31 and 60 -> rounded to 40
+ *  - distances between 61 and 120 -> rounded to 80
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
+            if (distance > 11 && distance < 30) {
+                rounded_distance = 20;
+            } else if (distance > 31 && distance < 60) {
+                rounded_distance = 40;
+            } else if (distance > 61 && distance < 120) {
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
         exit(1);
     }
 
+    spapr_numa_PAPRify_distances(machine);
 }
 
 void spapr_numa_write_associativity_dt(SpaprMachineState *spapr, void *fdt,
-- 
2.26.2


