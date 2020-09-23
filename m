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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6323C2D0A8
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 19:37:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AB76235FD
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 19:37:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tEix+9XX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AB76235FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLAZZ-0004NW-7A
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 15:37:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39658)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1kLAY0-0002fm-Nb; Wed, 23 Sep 2020 15:35:24 -0400
Received: from mail-qv1-xf42.google.com ([2607:f8b0:4864:20::f42]:43341)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1kLAXy-0008WP-Ki; Wed, 23 Sep 2020 15:35:24 -0400
Received: by mail-qv1-xf42.google.com with SMTP id cr8so589691qvb.10;
 Wed, 23 Sep 2020 12:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=XcKpR+WmJ49fFEjtlAWzJFbmoZJR2cMvUq//la+WRc4=;
 b=tEix+9XXmwcpRRdu9Cu3TRTSjDPYJHM7Vp/gnGVPW3uYx1oGeRcsjsziwy8Hk0zwZg
 N+fR+3GQhpRQmkN2d83EpWE2tthMgLn9YdHlJ3cjRvupjPrSTqrrz+u2CiS7CGFPEBZw
 P3GVTlFrKinUeeAXRMxytcj48tk27Zg0E1PK+zws0rjZxeniRUZkIoQ2S0y6poS3KHtO
 wbm0j2NeMh6XM+1L6tqARvLyS9jUsjXN4Ci8PXs6JO8da/T/Jc19MScFYQr4oEBVfJs4
 mk95WDYZ3JnAILHWGMLLjvZuLQKcGIeuaItLqIBwRYn4S16Yu7dk2I+YDFOjzb3Z9KJy
 Ivyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=XcKpR+WmJ49fFEjtlAWzJFbmoZJR2cMvUq//la+WRc4=;
 b=uXLPzLz9y4kpmxuVc4iFeNDtW1j0++/76+l91kiEWN1/lPFOuWfYCif0AOvgp4BDQC
 v8rW6GwplJNiyvYhhTywbT27wbWwLNmg6Axgoe4GBP1EuaRVBbVsi/aDIheaI9XdrnUR
 bUpyD6FAdiLMecWfTMAbwp0sAVASzGIstdfSuEutL6F7txuITZTtczikESaksIuU4vSs
 93EM7JF0YVsg/VT3vnchjpAnCGs4J9e7BLz041mmh6naccQeawjW501wjwShEcknZrf/
 vVC5P3gG6amHN33dT6zgcv2OgySZDyq37tk3XrlT7Z15zWM/HHDO3dyP1ONOSgwI0REC
 mfjQ==
X-Gm-Message-State: AOAM5316Yv0hO2y13rHy3lXSrJi4EOR+m2sPRhDgh/qIDaPEzRG0uiD7
 glIqyesFL8V1lwb/8DxeIYDmicFQqbwg1g==
X-Google-Smtp-Source: ABdhPJxio3jZS59c8Ja6iOc8PY8nPFQgJDbWTykpw00TYkVXFJxOP5BtUbj1E1kSme+sjTRIhDQ8sw==
X-Received: by 2002:a0c:e294:: with SMTP id r20mr1518845qvl.60.1600889720932; 
 Wed, 23 Sep 2020 12:35:20 -0700 (PDT)
Received: from rekt.ibmuc.com ([2804:431:c7c7:9e50:6b84:53b8:5d9d:d408])
 by smtp.gmail.com with ESMTPSA id u4sm612362qkk.68.2020.09.23.12.35.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2020 12:35:20 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 4/6] spapr_numa: change reference-points and maxdomain settings
Date: Wed, 23 Sep 2020 16:34:56 -0300
Message-Id: <20200923193458.203186-5-danielhb413@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200923193458.203186-1-danielhb413@gmail.com>
References: <20200923193458.203186-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f42;
 envelope-from=danielhb413@gmail.com; helo=mail-qv1-xf42.google.com
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
 hw/ppc/spapr_numa.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/hw/ppc/spapr_numa.c b/hw/ppc/spapr_numa.c
index 180800b2f3..688391278e 100644
--- a/hw/ppc/spapr_numa.c
+++ b/hw/ppc/spapr_numa.c
@@ -222,21 +222,30 @@ int spapr_numa_write_assoc_lookup_arrays(SpaprMachineState *spapr, void *fdt,
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
-    uint32_t maxdomains[] = {
-        cpu_to_be32(4),
-        maxdomain,
-        maxdomain,
-        maxdomain,
-        cpu_to_be32(spapr->gpu_numa_id),
-    };
+    uint32_t maxdomain = cpu_to_be32(ms->numa_state->num_nodes +
+                                     spapr->gpu_numa_id);
+    uint32_t maxdomains[] = {0x4, maxdomain, maxdomain, maxdomain, maxdomain};
+
+    if (spapr_machine_using_legacy_numa(spapr)) {
+        refpoints[1] =  cpu_to_be32(0x4);
+        refpoints[2] =  cpu_to_be32(0x2);
+        nr_refpoints = 3;
+
+        maxdomain = cpu_to_be32(spapr->gpu_numa_id > 1 ? 1 : 0);
+        maxdomains[1] = maxdomain;
+        maxdomains[2] = maxdomain;
+        maxdomains[3] = maxdomain;
+        maxdomains[4] = cpu_to_be32(spapr->gpu_numa_id);
+    }
 
     if (smc->pre_5_1_assoc_refpoints) {
         nr_refpoints = 2;
-- 
2.26.2


