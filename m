Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA61FC41604
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 17:31:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12EBC2168B
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 17:31:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XWqqo/8d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12EBC2168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53308 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQDHe-000082-U8
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 13:31:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59198)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1kQDFQ-00060M-WC; Wed, 07 Oct 2020 13:29:05 -0400
Received: from mail-qk1-x742.google.com ([2607:f8b0:4864:20::742]:41515)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1kQDFP-00007Z-6P; Wed, 07 Oct 2020 13:29:04 -0400
Received: by mail-qk1-x742.google.com with SMTP id b69so3735591qkg.8;
 Wed, 07 Oct 2020 10:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=R4x7UXQx3o9BKP7QdPkixkdBnA0FbHUH8NO4L6FHy/8=;
 b=XWqqo/8da/pbFHfzh1iZKrT3bLl8cxBgfu4zDkq/Ja0FQKNd9WH6yNJ1pTApcAJG9b
 N7ngGEEgs1IqQnSAMbeQA6GTuU8+ZIuCzQg7AZ5nRmpwpoaDZJMXlqQJx2nHmBOfFdK3
 AnmfJ9/vi66F6PSi5tOx/cPEZBTysq6C+8jep1QBvY969BZkKzuaaCC7RlSjq8TomEHs
 7Sys0eAsy/iIU0pPOO7TX0L5zOm4l/gKYEM0Uq5+OpoQtiVGsMknzKh7ZiGAfbPbnzNs
 0u/CvD8uf+2YBE360qIT+ICAI1ONxoE0L+hZ12j83rrbl2fPhwZ1+FQNJipMKAl9sL0C
 4sWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=R4x7UXQx3o9BKP7QdPkixkdBnA0FbHUH8NO4L6FHy/8=;
 b=d70ybMCzwe9+7Xx7ByjyaJdNi4k21tMLrvRA543otN/CcfJgolpbgleNSbzYrpncSA
 TnhKW6mi9+cZ4Kg0hvjxTyIVhqUyoi2N94COdeezgPbtIpdcX/Hjt1aq73643MWWxi6y
 OdrGND+Mx5DKVoPlVYleUxMNMA7ZSM6dnr8/4m664wuOUa0yN0HD8wxZqatFC5pcptvU
 v71omqfvxV9sG13JI1fcUf/OrZk0Yrwql+UTZlFscvwQUcaNfqaH5Yu4oRaLcbbialmj
 viwjh0nI0RG67d6nB1jdafFBS22G8kiBz3k6BE4BqcxWAytfd+ltBOv/ufK0XCc3FaIm
 ZatA==
X-Gm-Message-State: AOAM5323yZjCpBxSESkVT6rtUvVS72dJdv+GxRF9YMf4CTDES/HrfSEl
 uESLz4rY7X3GtvR4Ll83qUxB6iew/AMPDQ==
X-Google-Smtp-Source: ABdhPJw315qM/00DWZJ6RZ8orJxW5RZckmIUM4lA0UWxw3NLD/JhQ3f6ffK2KR3q1qXVAb6pUqBycQ==
X-Received: by 2002:a37:b285:: with SMTP id b127mr3811451qkf.323.1602091741626; 
 Wed, 07 Oct 2020 10:29:01 -0700 (PDT)
Received: from rekt.ibmuc.com ([2804:431:c7c6:5a9b:54fc:df2a:8a5e:989b])
 by smtp.gmail.com with ESMTPSA id e39sm2080117qtk.32.2020.10.07.10.29.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2020 10:29:01 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 2/5] spapr_numa: forbid asymmetrical NUMA setups
Date: Wed,  7 Oct 2020 14:28:46 -0300
Message-Id: <20201007172849.302240-3-danielhb413@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201007172849.302240-1-danielhb413@gmail.com>
References: <20201007172849.302240-1-danielhb413@gmail.com>
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
 Greg Kurz <groug@kaod.org>, david@gibson.dropbear.id.au
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


