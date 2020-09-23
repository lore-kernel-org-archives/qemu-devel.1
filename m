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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3401BC2D0A8
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 19:37:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82792235FD
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 19:37:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mmAPIDtk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82792235FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLAZk-0004Vq-Ck
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 15:37:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39654)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1kLAXz-0002fA-Ua; Wed, 23 Sep 2020 15:35:24 -0400
Received: from mail-qv1-xf44.google.com ([2607:f8b0:4864:20::f44]:33335)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1kLAXw-0008Vt-ET; Wed, 23 Sep 2020 15:35:23 -0400
Received: by mail-qv1-xf44.google.com with SMTP id cy2so629021qvb.0;
 Wed, 23 Sep 2020 12:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=SwOEQO9kfmA7oDtZYIo2rP0M5TYu31XtL4UeyeKcFpc=;
 b=mmAPIDtkKngGrxtBlFhT2+YqOx45oxRGI1Osh0+Lp5aqJ8e3l3QlI7SE9ozZZuSBIf
 cCk5uca/ZFpEElObLnyeG5gU3zjRn1UoF5fjfWB01/ESia3/JLzGpDVoSS8ESwL/6fcb
 C2QvmAofIIoE5Us/bbleEG3iZTlmOkrnzJcjSqfNmnowXTv8IAgOrcl0DREfGREkwh3W
 2Uc1YhRUVf2ctYvpGx0IRESgbB9QxJtUJVYTZKod9iXGmrl7mgWDNS3a5pBPAcDtzWrd
 LcH6qY3K6q6yg6E/DhXSHtxEG4AtLpdn8jfZNO/R0bG+EwJ/3mgESNOW8MkddnDyIyJB
 LjYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=SwOEQO9kfmA7oDtZYIo2rP0M5TYu31XtL4UeyeKcFpc=;
 b=JumQjohF8HRDfNtV6C/kat0LWZDjHbeESzzaFfp3SuKv2KOSNPUA/E0G/+9tA6waNs
 il6q2LmVU3QAbyEGppoT5CJDzgOBQ9jJhO/40+Uq2VwOEcKgWD4TJmXAbxnOh9GIV0HZ
 V0pSb6cEJ80lCGipXj3GWpj/l/ZejZ418gS5UjcJwMb4a79fVyBmuKqym61kB3wm8pqi
 a8pPuRqAoEFn2KZ4/zK8o7Tq8X8L4SWI46Uutj2OXn3jxX6dcoEFVLEv6jV1xhFIuaU7
 xebg//GZ9LUW4LGb3k7Kjz3Y+uNLjaD96hudOj09EGubxCUD59q0A29lYbPlez8oyWBT
 bw5w==
X-Gm-Message-State: AOAM532vuPGTb3J5JPIqxhktFyUkhaANovYMxXyfo3YHPTX7RX/rO8J+
 TPYewbhZV0Rzv63LXVYL0MKCfbVjvm+5Jw==
X-Google-Smtp-Source: ABdhPJzTEhh56p2Boz2N56BdY0D+nuWeHd4fC5j/JNAAltllKilcPgYZsaqsJ4/UaHrYs59XnOEJcg==
X-Received: by 2002:ad4:5387:: with SMTP id i7mr1611045qvv.43.1600889716798;
 Wed, 23 Sep 2020 12:35:16 -0700 (PDT)
Received: from rekt.ibmuc.com ([2804:431:c7c7:9e50:6b84:53b8:5d9d:d408])
 by smtp.gmail.com with ESMTPSA id u4sm612362qkk.68.2020.09.23.12.35.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2020 12:35:13 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/6] spapr_numa: forbid asymmetrical NUMA setups
Date: Wed, 23 Sep 2020 16:34:54 -0300
Message-Id: <20200923193458.203186-3-danielhb413@gmail.com>
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

The pSeries machine does not support asymmetrical NUMA
configurations. This doesn't make much of a different
since we're not using user input for pSeries NUMA setup,
but this will change in the next patches.

To avoid breaking existing setups, gate this change by
checking for legacy NUMA support.

Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 hw/ppc/spapr_numa.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/hw/ppc/spapr_numa.c b/hw/ppc/spapr_numa.c
index 64fe567f5d..36aaa273ee 100644
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
+     * Legacy NUMA guests (pseries-5.1 and order, or guests with only
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
+        exit(1);
+    }
+
 }
 
 void spapr_numa_write_associativity_dt(SpaprMachineState *spapr, void *fdt,
-- 
2.26.2


