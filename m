Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B08EC4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 19:58:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4E902311B
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 19:58:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CsxrKril"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4E902311B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56958 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLXOK-0000nA-T1
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 15:58:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55564)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1kLXGt-0001nk-Lu; Thu, 24 Sep 2020 15:51:17 -0400
Received: from mail-qk1-x744.google.com ([2607:f8b0:4864:20::744]:40686)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1kLXGr-00018e-8F; Thu, 24 Sep 2020 15:51:15 -0400
Received: by mail-qk1-x744.google.com with SMTP id w16so672425qkj.7;
 Thu, 24 Sep 2020 12:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=wshH2JO2gAjBd9CysBLdg4RKPPUJNz/CuF2VnRWsINM=;
 b=CsxrKril2lvKKP9aWIOwvXRoxq3U7+0dYa2zUrapUfH7c6Yo1O60oIvI6RHeaD7EGI
 cDwuZknCjCyKhfqV11SxAfrOgIvmlc78MW+V86Ko8LAw2ddq90L2X2j3XseIUBKgFYhY
 +HrWc5e6JHdBPVP4g6vOmU+ZVgRl2xZu6mbP9kLUNvRNKnGGBDtXflcNL+lbcjMfK25f
 4Xj2Ny+B0DnaU78DUCw/fxtbxlLwrOggVC4qx8V+wVSl8E/EdnidexYIdFYV7Z1j9sMa
 +LzfJKqi/ryo5OBWf5IUABYwRp6djwS1Daj5t2FnJEl3LIKFKTN5EB834joIKZ8U7l8d
 u+tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=wshH2JO2gAjBd9CysBLdg4RKPPUJNz/CuF2VnRWsINM=;
 b=BjtlZhbVuLiJC9FempSp4zemL2BhvZMrSbLrkeg7C58W7bJuRC+i+2x1DkIXZw0pbi
 usPqd3djX20Guoik89+So/wpIPqDeHx85MF/K4LJzv/fTZD8STRrWArr+PNpcxosg/+7
 H9bsje7T91GhQpKaRdlfZqPI93QyKrYvckzypFkmsy+WLmA9CjU+Hae7cXVVpBQxZG9L
 vYkQeTzaubACBd9RRh2hVqeh03pvI0PlGQiiHDH+DEPNC2vaMwuvPOlpuGkf81x3o6nj
 OZpZRjotR7QOUKMYdNu2KkJoyzT5zxieDTGM/8Faml00ypZWzteDo7SuLzz2542LcuGV
 K6Dw==
X-Gm-Message-State: AOAM530OXIAWeOHvPOKtyhj+HUpB03pRzFz6W/ho5TIhnIRXkQbQGl0R
 t5n/wIhAiiw3RieGImA36h5PMge7S7zUug==
X-Google-Smtp-Source: ABdhPJx0+4vs6IX9q9IHocIYEErkIW0ylNUOrAfZMqBe2jcCQApyZHM7uyhEisHCSva0I4nZ/zXEBQ==
X-Received: by 2002:a05:620a:5b8:: with SMTP id
 q24mr749494qkq.492.1600977071520; 
 Thu, 24 Sep 2020 12:51:11 -0700 (PDT)
Received: from rekt.ibmuc.com ([2804:431:c7c7:c625:6c0e:4720:8228:5f68])
 by smtp.gmail.com with ESMTPSA id f3sm381613qtg.71.2020.09.24.12.51.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2020 12:51:11 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 2/6] spapr_numa: forbid asymmetrical NUMA setups
Date: Thu, 24 Sep 2020 16:50:54 -0300
Message-Id: <20200924195058.362984-3-danielhb413@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200924195058.362984-1-danielhb413@gmail.com>
References: <20200924195058.362984-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::744;
 envelope-from=danielhb413@gmail.com; helo=mail-qk1-x744.google.com
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


