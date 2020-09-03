Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2324C433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 22:11:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A22F20716
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 22:11:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oq3BcToO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A22F20716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36838 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDxRq-0004fZ-BC
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 18:11:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45112)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1kDxNn-0006Ow-UB; Thu, 03 Sep 2020 18:07:03 -0400
Received: from mail-qt1-x842.google.com ([2607:f8b0:4864:20::842]:39748)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1kDxNl-0007TP-Hv; Thu, 03 Sep 2020 18:07:03 -0400
Received: by mail-qt1-x842.google.com with SMTP id 92so3195262qtb.6;
 Thu, 03 Sep 2020 15:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=8AcS+2MgC3Xn7XSXkC9a9dEuvG+oK6tDqMnM4qvC+dU=;
 b=oq3BcToOSYmqJDEIQMixJsfzZQhp/uVchSleg8Q9DLnh+icgpIPtsk2bLc3bbJqLv0
 hx3oxrnQuAIMjKVbZaNufnELf7uoCHxj2dDybHFSmTlF9uA4VqHehq4v5AVWcDuvrMfg
 F3v4MTbmWXNBxPHd0dc/wEmC1tIHFfGKKLK6vPqYb/2uYaBKYBpM36NhLFJtzVJRmDLT
 7JlZOE8K2KmfRIMbgsRBf4JaDnSXUN2Mb+MdUB7UTeorbC6J9ec/MTmoiYrPzLjiZNaI
 Za2hS2zpakwNzOxGFn3dC7fm3XndgVuAw8RlUM6iugyiTG2d0YCF+bcJ+2rjbhZCzEor
 cqGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8AcS+2MgC3Xn7XSXkC9a9dEuvG+oK6tDqMnM4qvC+dU=;
 b=dMYldKm7BQv5a8UTr7WZl8oTrWMZj36f8K6VW6n5/SvDteinw9OAcaPAp+zgpdi3Mn
 RNBpN5EsEKO2ZTZh5MBr4JEGRzP6d7akHx1akzGbVAVCf9/6xSxeAsOSI1S58A2jU4ZP
 QQDR3kXfu1u8QN257JioBxQb88T88VaFTIg1MQYjS744w7pa+E+315wWV3KgoMNE5mEO
 FsFrFRJVcpXZM/2G09D66tKBrrtN1UjXg3NcZwvQH6WHTjGZ1aXKkYzuDe5v1VflBL6r
 chzh+CbZN4pexI7+fRslO+Ox7O1GKa+ssSoV76+Aohjlkq3SdZRf96rZzpbyuu76Pu3J
 2YVA==
X-Gm-Message-State: AOAM532j89EgmegP+ErPzzJbSKMyLIwYcTWljulcjVKD/5jwREplM/Kx
 wOilyJBzPcpPJSt9k+O9rssbSoKwSMKD6A==
X-Google-Smtp-Source: ABdhPJxUo882Mu856Qcn/cxeo4RwfJ70o+Ud42Z8WPgg8dX9vLZxwhFCicyZDGCF/CYrTLbOKfIJBw==
X-Received: by 2002:ac8:48ca:: with SMTP id l10mr5692348qtr.385.1599170819866; 
 Thu, 03 Sep 2020 15:06:59 -0700 (PDT)
Received: from rekt.ibmuc.com ([2804:431:c7c6:1dc:ffbd:d3fb:97ff:aaca])
 by smtp.gmail.com with ESMTPSA id j1sm1798757qtk.91.2020.09.03.15.06.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2020 15:06:59 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 6/7] spapr_numa: create a vcpu associativity helper
Date: Thu,  3 Sep 2020 19:06:38 -0300
Message-Id: <20200903220639.563090-7-danielhb413@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200903220639.563090-1-danielhb413@gmail.com>
References: <20200903220639.563090-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::842;
 envelope-from=danielhb413@gmail.com; helo=mail-qt1-x842.google.com
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

The work to be done in h_home_node_associativity() intersects
with what is already done in spapr_numa_fixup_cpu_dt(). This
patch creates a new helper, spapr_numa_get_vcpu_assoc(), to
be used for both spapr_numa_fixup_cpu_dt() and
h_home_node_associativity().

Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 hw/ppc/spapr_numa.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/hw/ppc/spapr_numa.c b/hw/ppc/spapr_numa.c
index d4dca57321..abc7361921 100644
--- a/hw/ppc/spapr_numa.c
+++ b/hw/ppc/spapr_numa.c
@@ -71,14 +71,17 @@ void spapr_numa_write_associativity_dt(SpaprMachineState *spapr, void *fdt,
                       sizeof(spapr->numa_assoc_array[nodeid]))));
 }
 
-int spapr_numa_fixup_cpu_dt(SpaprMachineState *spapr, void *fdt,
-                            int offset, PowerPCCPU *cpu)
+static uint32_t *spapr_numa_get_vcpu_assoc(SpaprMachineState *spapr,
+                                          PowerPCCPU *cpu,
+                                          uint *vcpu_assoc_size)
 {
-    uint vcpu_assoc_size = NUMA_ASSOC_SIZE + 1;
-    uint32_t vcpu_assoc[vcpu_assoc_size];
+    uint32_t *vcpu_assoc = NULL;
     int index = spapr_get_vcpu_id(cpu);
     int i;
 
+    *vcpu_assoc_size = (NUMA_ASSOC_SIZE + 1) * sizeof(uint32_t);
+    vcpu_assoc = g_malloc(*vcpu_assoc_size);
+
     /*
      * VCPUs have an extra 'cpu_id' value in ibm,associativity
      * compared to other resources. Increment the size at index
@@ -91,11 +94,22 @@ int spapr_numa_fixup_cpu_dt(SpaprMachineState *spapr, void *fdt,
         vcpu_assoc[i] = spapr->numa_assoc_array[cpu->node_id][i];
     }
 
-    vcpu_assoc[vcpu_assoc_size - 1] = cpu_to_be32(index);
+    vcpu_assoc[MAX_DISTANCE_REF_POINTS + 1] = cpu_to_be32(index);
+
+    return vcpu_assoc;
+}
+
+int spapr_numa_fixup_cpu_dt(SpaprMachineState *spapr, void *fdt,
+                            int offset, PowerPCCPU *cpu)
+{
+    g_autofree uint32_t *vcpu_assoc = NULL;
+    uint vcpu_assoc_size;
+
+    vcpu_assoc = spapr_numa_get_vcpu_assoc(spapr, cpu, &vcpu_assoc_size);
 
     /* Advertise NUMA via ibm,associativity */
     return fdt_setprop(fdt, offset, "ibm,associativity",
-                       vcpu_assoc, sizeof(vcpu_assoc));
+                       vcpu_assoc, vcpu_assoc_size);
 }
 
 
-- 
2.26.2


