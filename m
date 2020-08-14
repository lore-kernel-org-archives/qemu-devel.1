Return-Path: <SRS0=PlQC=BZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94098C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2020 17:07:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B55323B3D
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2020 17:07:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qY5qZTA0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B55323B3D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37280 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6ze3-0003XH-If
	for qemu-devel@archiver.kernel.org; Sat, 15 Aug 2020 13:07:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42514)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1k6zdD-0002LH-KK; Sat, 15 Aug 2020 13:06:11 -0400
Received: from mail-qt1-x841.google.com ([2607:f8b0:4864:20::841]:39650)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1k6zdC-0001Nf-2T; Sat, 15 Aug 2020 13:06:11 -0400
Received: by mail-qt1-x841.google.com with SMTP id w9so9324292qts.6;
 Sat, 15 Aug 2020 10:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=C8DYrGMe3y/eVzf4pXQ5QA0B3zmxOvZQB53ARGNc55o=;
 b=qY5qZTA0p9G/ilHt/4N2AYlygJQ9zrO8zKkstj/82g21j3Z8fCgmNrpSVZF640E8ad
 zoPVZNecnlF0xyTfn71wWKYVDvEECWnCL4MscR04D44Xx0Knofxq6Z1bUsuTBpW7zlcS
 N2x3zc3wVIVJimwr9oltUyob0t/BabHUPYSSesv8Lr9OxYVOHb/PR3alyjxDpLJk4F2H
 fM2qOExcRkYU81OQJbX9Zx4OAoF8huoT2dPlAd1xEunHYExqoWqC8kv23/t+DCDT2MsJ
 h6luOzMZGKCL4PdQCp7DWdNAKp52LU2fcuFC9UGhnB2tNc+WIGuL3TZj1p8lxAAhnYk8
 Rl8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=C8DYrGMe3y/eVzf4pXQ5QA0B3zmxOvZQB53ARGNc55o=;
 b=i+1a358VZJu60xmJDP+o3+iH2TyWtAIQn6s7oR2Qgsd3KEY76dVUZC4e4pCSRCO1aY
 4aH/ZPFz/yTTb6muPk7GKdYWV667F8PSvPtbjSvJvci2wl7P4Khtb8TS0Z+6bNDMVERF
 C16GbOLr3Yz3YkoHXoT1E2MLQEDcw3eqPgStXVMeKQFDonVYHmnuc0c35gjTBx1jMw7v
 z1JWQFJZXVNNVEzr1fKGl/+K1KE0RMrXVz9uSK+riNlkozMtSzc76GqKyw8HpK2iM1L+
 Bd8H3XNj0+1UP5PbUbI7QweU7OX0U50DIF922hknW09aHd7nJvetmJe1rS45USHxDQSe
 9c7A==
X-Gm-Message-State: AOAM530G33cIr7jX/7OlaGogMGwzFmlx3h4fD3lWesQwmWFCWQ8UsJq6
 z7cJtz+LM81FCbhZrSkXuP5bqS08rMItCQ==
X-Google-Smtp-Source: ABdhPJyHKq14iTpKYc5wJdXofWA+1bw5OnGOmJEZleZvtQYkThyO13voRwfd9A4CwN83abl0C4k+4w==
X-Received: by 2002:ac8:44b9:: with SMTP id a25mr3618711qto.356.1597438480966; 
 Fri, 14 Aug 2020 13:54:40 -0700 (PDT)
Received: from rekt.ibmuc.com ([2804:431:c7c6:303f:d1dc:35d8:e9f6:c8b])
 by smtp.gmail.com with ESMTPSA id p33sm12301018qtp.49.2020.08.14.13.54.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2020 13:54:40 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 02/10] numa: introduce MachineClass::forbid_asymmetrical_numa
Date: Fri, 14 Aug 2020 17:54:16 -0300
Message-Id: <20200814205424.543857-3-danielhb413@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200814205424.543857-1-danielhb413@gmail.com>
References: <20200814205424.543857-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::841;
 envelope-from=danielhb413@gmail.com; helo=mail-qt1-x841.google.com
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
 Eduardo Habkost <ehabkost@redhat.com>, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The pSeries machine does not support asymmetrical NUMA configurations.

CC: Eduardo Habkost <ehabkost@redhat.com>
CC: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 hw/core/numa.c      | 7 +++++++
 hw/ppc/spapr.c      | 1 +
 include/hw/boards.h | 1 +
 3 files changed, 9 insertions(+)

diff --git a/hw/core/numa.c b/hw/core/numa.c
index d1a94a14f8..1e81233c1d 100644
--- a/hw/core/numa.c
+++ b/hw/core/numa.c
@@ -547,6 +547,7 @@ static int parse_numa(void *opaque, QemuOpts *opts, Error **errp)
  */
 static void validate_numa_distance(MachineState *ms)
 {
+    MachineClass *mc = MACHINE_GET_CLASS(ms);
     int src, dst;
     bool is_asymmetrical = false;
     int nb_numa_nodes = ms->numa_state->num_nodes;
@@ -575,6 +576,12 @@ static void validate_numa_distance(MachineState *ms)
     }
 
     if (is_asymmetrical) {
+        if (mc->forbid_asymmetrical_numa) {
+            error_report("This machine type does not support "
+                         "asymmetrical numa distances.");
+            exit(EXIT_FAILURE);
+        }
+
         for (src = 0; src < nb_numa_nodes; src++) {
             for (dst = 0; dst < nb_numa_nodes; dst++) {
                 if (src != dst && numa_info[src].distance[dst] == 0) {
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index dd2fa4826b..3b16edaf4c 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -4512,6 +4512,7 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
      */
     mc->numa_mem_align_shift = 28;
     mc->auto_enable_numa = true;
+    mc->forbid_asymmetrical_numa = true;
 
     smc->default_caps.caps[SPAPR_CAP_HTM] = SPAPR_CAP_OFF;
     smc->default_caps.caps[SPAPR_CAP_VSX] = SPAPR_CAP_ON;
diff --git a/include/hw/boards.h b/include/hw/boards.h
index bc5b82ad20..dc6cdd1c53 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -215,6 +215,7 @@ struct MachineClass {
     bool nvdimm_supported;
     bool numa_mem_supported;
     bool auto_enable_numa;
+    bool forbid_asymmetrical_numa;
     const char *default_ram_id;
 
     HotplugHandler *(*get_hotplug_handler)(MachineState *machine,
-- 
2.26.2


