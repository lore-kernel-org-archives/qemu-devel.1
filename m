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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14C1FC41604
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 17:31:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71D072168B
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 17:31:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c8ffZQR5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71D072168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55096 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQDIA-0000v7-8s
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 13:31:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59226)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1kQDFT-00064d-3b; Wed, 07 Oct 2020 13:29:10 -0400
Received: from mail-qk1-x743.google.com ([2607:f8b0:4864:20::743]:41517)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1kQDFR-00007t-2e; Wed, 07 Oct 2020 13:29:06 -0400
Received: by mail-qk1-x743.google.com with SMTP id b69so3735746qkg.8;
 Wed, 07 Oct 2020 10:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=lpsGtZ60cFvA7qd3INWQF05K0q47LnadRWDRZid09OA=;
 b=c8ffZQR5F/tNv6y4AIs0q8JpuAeIjTTM8CyPfjDFpEneASmdq7Lv+9Ctrq/EIr/d5Y
 lv4vv5grGjt9lb1F27EIGVcIYHbQXLAhHxsB2MOw2LAmZIZQRdwO1PtgeHEfqS6wKkid
 oZu2RoWWgQKoEDa8VK3ulvUXNEkuy++4Dv+tvor4ulXRXtj2DNNo/AjFLpRnT4BaMZEH
 HWSb834vCqjgicxR7/YzPFVVbnw6tN6CRLSP3gh5FHItNARFKMK6OZr1JFd7VBH+HO5L
 Kau3PghRXAPCixiWzVw+Xx/POSLVERQVywKPPAT6s5I+uqNpcB0u9pvmvPHEaSJYbSt/
 R3iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=lpsGtZ60cFvA7qd3INWQF05K0q47LnadRWDRZid09OA=;
 b=mee1tN9/DjQnu2EAh9uczuTSipJwFq7z4HpyGn0K9pCCrFP8wrfY5TLvfzY0P/j9cE
 JZJJBDVDRmsbWgDq2XS9whhqJTIZRinXLq5ObpzDaIQ6YKrihmTIv9foxI4AS9bUXufB
 GvEAigICfFRU6OUD7/yPCE4NzJwlu4P4eC8B39ki08sY3qN9jbXzBwgGnAN1FkjAoIzb
 zqDl8zWeXqszbFfN2rrMwe09KSFLZEo52N9t6sjq68zLRgMVUstZFfGbGI7QhH/2tk6B
 up5nGqdr8Rpqn9xHiOM/UblJtjEdhk6QojLHrY1F3aHgifDXMCsbDNwyQ6acmP5JeKCU
 a3kw==
X-Gm-Message-State: AOAM532piwWrq7w4gOnGpTMVN6e+qhgUk3KiZeSE+E7VC9IVYv75cdYv
 y+YxJOD4d4+WRkp2gBNVWMBHPTeAcZ9IYg==
X-Google-Smtp-Source: ABdhPJzx3ij93kvLZoxbTbO4Wbzyh2kaav/ytc+FDEOc1O3zbCFFiHkP0lcZK2p4oju/D/pxj9ogGg==
X-Received: by 2002:a37:d41:: with SMTP id 62mr3840323qkn.444.1602091743437;
 Wed, 07 Oct 2020 10:29:03 -0700 (PDT)
Received: from rekt.ibmuc.com ([2804:431:c7c6:5a9b:54fc:df2a:8a5e:989b])
 by smtp.gmail.com with ESMTPSA id e39sm2080117qtk.32.2020.10.07.10.29.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2020 10:29:02 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 3/5] spapr_numa: change reference-points and maxdomain
 settings
Date: Wed,  7 Oct 2020 14:28:47 -0300
Message-Id: <20201007172849.302240-4-danielhb413@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201007172849.302240-1-danielhb413@gmail.com>
References: <20201007172849.302240-1-danielhb413@gmail.com>
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
 Greg Kurz <groug@kaod.org>, david@gibson.dropbear.id.au
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

Reviewed-by: Greg Kurz <groug@kaod.org>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 hw/ppc/spapr_numa.c | 43 +++++++++++++++++++++++++++++++++++--------
 1 file changed, 35 insertions(+), 8 deletions(-)

diff --git a/hw/ppc/spapr_numa.c b/hw/ppc/spapr_numa.c
index fe395e80a3..16badb1f4b 100644
--- a/hw/ppc/spapr_numa.c
+++ b/hw/ppc/spapr_numa.c
@@ -178,24 +178,51 @@ int spapr_numa_write_assoc_lookup_arrays(SpaprMachineState *spapr, void *fdt,
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
+        G_STATIC_ASSERT(sizeof(legacy_refpoints) <= sizeof(refpoints));
+        G_STATIC_ASSERT(sizeof(legacy_maxdomains) <= sizeof(maxdomains));
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


