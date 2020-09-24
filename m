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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54BA2C4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 19:56:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFBC42220C
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 19:56:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pwmf4l/R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFBC42220C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49344 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLXLb-0005u8-IT
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 15:56:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55596)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1kLXGx-0001ou-LW; Thu, 24 Sep 2020 15:51:20 -0400
Received: from mail-qk1-x743.google.com ([2607:f8b0:4864:20::743]:35795)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1kLXGv-000192-7R; Thu, 24 Sep 2020 15:51:19 -0400
Received: by mail-qk1-x743.google.com with SMTP id q5so704489qkc.2;
 Thu, 24 Sep 2020 12:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Plnnc/TLWC8T+VLBC0ieE5wAsZmgCaOLQWd67VMkILc=;
 b=Pwmf4l/RUBfCAwXWhArAxUGhChP0YYD9JtbUd5Cd+RLHJQi4VXBbal3Z2/5WNiCtBv
 d+xnx6R2h8bvlAmQwbHQLkoxL6nPJt0gPbYcWNKU1Dwuf45Bzjc4dhZTS3eS4W+j+/G5
 2jUTyjjMzPOqsvhJ+vuVQ285MvknAauqa4+kjSpwUENPgKDOPJ0jZL6JFqRnDdcaloXV
 5OptgHxWCLfHylrp1AgYzDMasMgyODUR3C3p0iJdcO2yxiSZWq2V1Xdm0A+s7O2Dgwx3
 jZLbinRiQu+1/Xll5hMtB++2gHFAxFcW9vH8EBB1apwV5MS8HkEdpLwx+UD0pAfXQo0v
 XCEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Plnnc/TLWC8T+VLBC0ieE5wAsZmgCaOLQWd67VMkILc=;
 b=R32gHzmSoXyaRmEhKwIph6a3vq4US60bmh7+6azuPlybD3c73eSqFY3pTvBrD4TO/g
 /iSD404N1FbuuAfeP/LiwCfb2Dv0bwU7g/KPGBSMgNBJ6g1LjcjN9sHzVvdaYZDQJcYr
 tYiDhCc6EupK8r7yw0iLjj4BqFgfCSC2okerRAL1KgCJHdm2+uqkDGwq6WdmaUphnLzi
 4eyhofqJQQyX6gvA30x2N9FYEQ0GktWXuGv895rSr/oFnq5ezmeC69xn2QdXSGJGUsKs
 m2O4Va2z35Tl5g5zTuETuyTl1UWa8EYy2P6TewOn0RUsScQHezhwJOKACizaiNIh+vuT
 EMPw==
X-Gm-Message-State: AOAM531EdkRZAyRel2Bp3ongQB61+52c5d7TAr3EeCOuYSRbbr52jbfq
 HN6JRhfV/IhQ4CqKoKuHAj2AcrLnxov0Ig==
X-Google-Smtp-Source: ABdhPJyt2hIQXqMbZKbEepfS6aeTm5FITkrJ6A8C/rX4u+fspQQDfyXlT1lYZSbkH2o1eX9MaQtNjQ==
X-Received: by 2002:a05:620a:94e:: with SMTP id
 w14mr783437qkw.86.1600977075536; 
 Thu, 24 Sep 2020 12:51:15 -0700 (PDT)
Received: from rekt.ibmuc.com ([2804:431:c7c7:c625:6c0e:4720:8228:5f68])
 by smtp.gmail.com with ESMTPSA id f3sm381613qtg.71.2020.09.24.12.51.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2020 12:51:15 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 4/6] spapr_numa: change reference-points and maxdomain
 settings
Date: Thu, 24 Sep 2020 16:50:56 -0300
Message-Id: <20200924195058.362984-5-danielhb413@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200924195058.362984-1-danielhb413@gmail.com>
References: <20200924195058.362984-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::743;
 envelope-from=danielhb413@gmail.com; helo=mail-qk1-x743.google.com
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

This is the first guest visible change introduced in
spapr_numa.c. The previous settings of both reference-points
and maxdomains were too restrictive, but enough for the
existing associativity we're setting in the resources.

We'll change that in the following patches, populating the
associativity arrays based on user input. For those changes
to be effective, reference-points and maxdomains must be
more flexible. After this patch, we'll have 4 distinct
levels of NUMA (0x4, 0x3, 0x2, 0x1) and maxdomains will
allow for any type of configuration the user intends to
do - under the scope and limitations of PAPR itself, of
course.

Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 hw/ppc/spapr_numa.c | 40 ++++++++++++++++++++++++++++++++--------
 1 file changed, 32 insertions(+), 8 deletions(-)

diff --git a/hw/ppc/spapr_numa.c b/hw/ppc/spapr_numa.c
index 990a5fce08..ea33439a15 100644
--- a/hw/ppc/spapr_numa.c
+++ b/hw/ppc/spapr_numa.c
@@ -222,24 +222,48 @@ int spapr_numa_write_assoc_lookup_arrays(SpaprMachineState *spapr, void *fdt,
  */
 void spapr_numa_write_rtas_dt(SpaprMachineState *spapr, void *fdt, int rtas)
 {
+    MachineState *ms = MACHINE(spapr);
     SpaprMachineClass *smc = SPAPR_MACHINE_GET_CLASS(spapr);
     uint32_t refpoints[] = {
         cpu_to_be32(0x4),
-        cpu_to_be32(0x4),
+        cpu_to_be32(0x3),
         cpu_to_be32(0x2),
+        cpu_to_be32(0x1),
     };
     uint32_t nr_refpoints = ARRAY_SIZE(refpoints);
-    uint32_t maxdomain = cpu_to_be32(spapr->gpu_numa_id > 1 ? 1 : 0);
+    uint32_t maxdomain = ms->numa_state->num_nodes + spapr->gpu_numa_id;
     uint32_t maxdomains[] = {
         cpu_to_be32(4),
-        maxdomain,
-        maxdomain,
-        maxdomain,
-        cpu_to_be32(spapr->gpu_numa_id),
+        cpu_to_be32(maxdomain),
+        cpu_to_be32(maxdomain),
+        cpu_to_be32(maxdomain),
+        cpu_to_be32(maxdomain)
     };
 
-    if (smc->pre_5_1_assoc_refpoints) {
-        nr_refpoints = 2;
+    if (spapr_machine_using_legacy_numa(spapr)) {
+        uint32_t legacy_refpoints[] = {
+            cpu_to_be32(0x4),
+            cpu_to_be32(0x4),
+            cpu_to_be32(0x2),
+        };
+        uint32_t legacy_maxdomain = spapr->gpu_numa_id > 1 ? 1 : 0;
+        uint32_t legacy_maxdomains[] = {
+            cpu_to_be32(4),
+            cpu_to_be32(legacy_maxdomain),
+            cpu_to_be32(legacy_maxdomain),
+            cpu_to_be32(legacy_maxdomain),
+            cpu_to_be32(spapr->gpu_numa_id),
+        };
+
+        nr_refpoints = 3;
+
+        memcpy(refpoints, legacy_refpoints, sizeof(legacy_refpoints));
+        memcpy(maxdomains, legacy_maxdomains, sizeof(legacy_maxdomains));
+
+        /* pseries-5.0 and older reference-points array is {0x4, 0x4} */
+        if (smc->pre_5_1_assoc_refpoints) {
+            nr_refpoints = 2;
+        }
     }
 
     _FDT(fdt_setprop(fdt, rtas, "ibm,associativity-reference-points",
-- 
2.26.2


