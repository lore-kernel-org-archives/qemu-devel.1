Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FEC5C4727C
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 13:41:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C164F207C4
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 13:41:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sYbGRo9o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C164F207C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNFse-00011j-RD
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 09:41:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40682)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1kNFqE-0007XT-8L; Tue, 29 Sep 2020 09:38:51 -0400
Received: from mail-qk1-x742.google.com ([2607:f8b0:4864:20::742]:34611)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1kNFqC-0001Ca-Gp; Tue, 29 Sep 2020 09:38:49 -0400
Received: by mail-qk1-x742.google.com with SMTP id c62so4302876qke.1;
 Tue, 29 Sep 2020 06:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=R4x7UXQx3o9BKP7QdPkixkdBnA0FbHUH8NO4L6FHy/8=;
 b=sYbGRo9oOVgPESa02XkvUKC2mYS83l3eDmPVjlJwRu9uVNZZMWDTT9NATjCJK9aDun
 H+5bx8lzNEmaROIUVGAXLPE008vfoFoGqY4PADWVZYiL2WQDzD++vYy4UFsoJBWFBMih
 36mafA8YNGZtRUBGpVAKT3uFnjTNh8bjKvILHaTk0rGcV2NCZ+6Zu+JE7tT+8nYk5ur9
 UF5QMrrQ5OmWC8Urx1U83oiT42Qzo9HJrRI6I0/CB4/+6XiEYjY8n8BZKARdQMbX6DVQ
 2NgvtuvJVe56H7y9T4Y7fbLz9lexKQgWNocyvOMNWfPdad5+nrcBKbTLGKonHTOAiN6V
 D0VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=R4x7UXQx3o9BKP7QdPkixkdBnA0FbHUH8NO4L6FHy/8=;
 b=HCDhh8XAzAzShCUZAlE9W0e/3l0IxxProe3w8D1HXxeZkyCaiGyRqcFtTb0gqIOrpO
 EsT01O+x352EKkOuRRLPKWm24vKsMmrxW2UfS74Re2nrJZYmOkHEe3f7/niJN4YW4EZj
 wBtyxJbS8Q6sXD/ZXKVLnP+VeMgN/vBlBRRvzcJzJ10F0R4vstOFN+PdId9uub6TVPcZ
 Vcg6Gk4tMkzJJrc6EYtHp1YQ69xrsH6y9HNnHLHd89fF2MluCRWSSMxz6co5fRzn8s+d
 VNP4dtOxmeLgO41IGfhkwW4mYLRWWPyNUDE+zdkOh4Qj6h9rsG+kmg3OQsPA3AcaQbLS
 Ot3Q==
X-Gm-Message-State: AOAM5312pQKeGPweUwh7kAmyzDPdosFSGWj3zghqCsqCdmKfaC9qVSO7
 /irLfypN34v2InEBgYoVhalOuRoLFoc=
X-Google-Smtp-Source: ABdhPJxIZhqRcW9tj8LD5NJibbEd7dYqUlfsgUYeeSHFrJmtKQyNdIZgjE6t0KH+7KFoQMNpfoM3dA==
X-Received: by 2002:a05:620a:218b:: with SMTP id
 g11mr4380983qka.494.1601386726924; 
 Tue, 29 Sep 2020 06:38:46 -0700 (PDT)
Received: from rekt.ibmuc.com ([2804:431:c7c7:c625:6c0e:4720:8228:5f68])
 by smtp.gmail.com with ESMTPSA id j88sm5239938qte.96.2020.09.29.06.38.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2020 06:38:42 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 2/5] spapr_numa: forbid asymmetrical NUMA setups
Date: Tue, 29 Sep 2020 10:38:14 -0300
Message-Id: <20200929133817.560278-3-danielhb413@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200929133817.560278-1-danielhb413@gmail.com>
References: <20200929133817.560278-1-danielhb413@gmail.com>
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
 groug@kaod.org, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The pSeries machine does not support asymmetrical NUMA
configurations. This doesn't make much of a different
since we're not using user input for pSeries NUMA setup,
but this will change in the next patches.

To avoid breaking existing setups, gate this change by
checking for legacy NUMA support.

Reviewed-by: Greg Kurz <groug@kaod.org>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 hw/ppc/spapr_numa.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/hw/ppc/spapr_numa.c b/hw/ppc/spapr_numa.c
index 64fe567f5d..fe395e80a3 100644
--- a/hw/ppc/spapr_numa.c
+++ b/hw/ppc/spapr_numa.c
@@ -19,6 +19,24 @@
 /* Moved from hw/ppc/spapr_pci_nvlink2.c */
 #define SPAPR_GPU_NUMA_ID           (cpu_to_be32(1))
 
+static bool spapr_numa_is_symmetrical(MachineState *ms)
+{
+    int src, dst;
+    int nb_numa_nodes = ms->numa_state->num_nodes;
+    NodeInfo *numa_info = ms->numa_state->nodes;
+
+    for (src = 0; src < nb_numa_nodes; src++) {
+        for (dst = src; dst < nb_numa_nodes; dst++) {
+            if (numa_info[src].distance[dst] !=
+                numa_info[dst].distance[src]) {
+                return false;
+            }
+        }
+    }
+
+    return true;
+}
+
 void spapr_numa_associativity_init(SpaprMachineState *spapr,
                                    MachineState *machine)
 {
@@ -61,6 +79,22 @@ void spapr_numa_associativity_init(SpaprMachineState *spapr,
 
         spapr->numa_assoc_array[i][MAX_DISTANCE_REF_POINTS] = cpu_to_be32(i);
     }
+
+    /*
+     * Legacy NUMA guests (pseries-5.1 and older, or guests with only
+     * 1 NUMA node) will not benefit from anything we're going to do
+     * after this point.
+     */
+    if (spapr_machine_using_legacy_numa(spapr)) {
+        return;
+    }
+
+    if (!spapr_numa_is_symmetrical(machine)) {
+        error_report("Asymmetrical NUMA topologies aren't supported "
+                     "in the pSeries machine");
+        exit(EXIT_FAILURE);
+    }
+
 }
 
 void spapr_numa_write_associativity_dt(SpaprMachineState *spapr, void *fdt,
-- 
2.26.2


