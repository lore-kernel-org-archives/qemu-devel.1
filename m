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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 473A4C4727C
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 13:41:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79F3B207C4
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 13:41:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H/uV7vjO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79F3B207C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNFsp-0001BH-DC
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 09:41:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40698)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1kNFqF-0007Xu-Uj; Tue, 29 Sep 2020 09:38:51 -0400
Received: from mail-qk1-x743.google.com ([2607:f8b0:4864:20::743]:35396)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1kNFqE-0001Ct-6f; Tue, 29 Sep 2020 09:38:51 -0400
Received: by mail-qk1-x743.google.com with SMTP id q5so4299397qkc.2;
 Tue, 29 Sep 2020 06:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=lpsGtZ60cFvA7qd3INWQF05K0q47LnadRWDRZid09OA=;
 b=H/uV7vjOla3sESrVbk3eM+HuE1nNVTeDk78g8kjAaPX2+gv1+jmtcZxFoSg/UQdF99
 mTV9MJVpUXLjY1BhWTw6t96ZsIVG8Py6x3FqFY9qmxwS+i1rvubk6BoVl/KILplkp1+P
 YjXgNE8ZEj+NH30ln9OIZ9lyTUsY6idgcmAGYtmZlxhLHG82iQfWntIJg3r9k81MwaTx
 jDK/MAb09xYx88PZJFMr/hUItH2V+6Dn9/POe08Xlv5E26jMULbc2D5jM1l3NBpTXaEY
 CPb+U+wpawENtyvx40SFSLUlIWXhFurRRHnD3mKXreLGTnkRg3ZY6o/IjUBmOu7VU1F3
 p7YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=lpsGtZ60cFvA7qd3INWQF05K0q47LnadRWDRZid09OA=;
 b=a4Qg8/cfeFcsm4JCxqlRebrphaHYp2hGLOorEe1ltBcLY822bzfZWPg5XepQASU1vz
 vs150ApQMnJVnIhCyOkiqQuoNoj1KNnIh+KV1lv9Na9qEbm8M74kn6Yvw4PC3DfcE1nN
 Dw0QpsRknlS+ZfyY/ICmlcqOkt/TljwMETZ045Nkogp14046hqitVVREQctzHo0c1zWh
 h9Dky67c97rQjfh1EhB7cEmPOv6aXDzGS1f96fVwhfmudpkMxEjFU6MVqXT3FgBSllBY
 5iaRqOtNJtoFmY+V6qGtKO7/x8qxU7jAV+hiAs8j9L23X4Kp86oADNbBXk8Vz5p2HnCl
 KbXQ==
X-Gm-Message-State: AOAM532E6clPSCRcP+KxpW5GnQsHJ//ARNC8YJijvcC5Twqlte/V1uLl
 t4OycEX0TUHvZ4qciDfi/UwSgo9mx14=
X-Google-Smtp-Source: ABdhPJz4hg8XxM2dX6GASsamrBTDWHnF9RcFCoyxMzk5r0/A2kv2BXQQJCP95vrawguz7lpwQidmSg==
X-Received: by 2002:a05:620a:683:: with SMTP id
 f3mr4492944qkh.491.1601386728622; 
 Tue, 29 Sep 2020 06:38:48 -0700 (PDT)
Received: from rekt.ibmuc.com ([2804:431:c7c7:c625:6c0e:4720:8228:5f68])
 by smtp.gmail.com with ESMTPSA id j88sm5239938qte.96.2020.09.29.06.38.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2020 06:38:48 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 3/5] spapr_numa: change reference-points and maxdomain
 settings
Date: Tue, 29 Sep 2020 10:38:15 -0300
Message-Id: <20200929133817.560278-4-danielhb413@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200929133817.560278-1-danielhb413@gmail.com>
References: <20200929133817.560278-1-danielhb413@gmail.com>
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


