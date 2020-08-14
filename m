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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDCBDC433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2020 15:52:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4EA720656
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2020 15:52:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MQ5jnwll"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4EA720656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36244 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6yTW-0007w2-W8
	for qemu-devel@archiver.kernel.org; Sat, 15 Aug 2020 11:52:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49546)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1k6ySW-0006at-AO; Sat, 15 Aug 2020 11:51:04 -0400
Received: from mail-qk1-x744.google.com ([2607:f8b0:4864:20::744]:39615)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1k6ySU-0008Ag-Oh; Sat, 15 Aug 2020 11:51:04 -0400
Received: by mail-qk1-x744.google.com with SMTP id n129so11138987qkd.6;
 Sat, 15 Aug 2020 08:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=l6kZ8mrb93TKELcxaCgtqBHtArIefirGpqL2DrfF1Fg=;
 b=MQ5jnwlliGOFTgbpoZII2JL5az72qnkkEUzSlcPjfa7O2NtVRzJjQJmfjIljNc7GPF
 VEXrFjjUftfaW9HInWXPolSJXyIaVmR39KYO/q8ochXjE21PLaMm4iC45JGvSqdGuF8A
 nji0dm3m0w2coSK8Y5EXxnu4M8ud5Q5XasTR9MNiyL+H0Pgh/4mewpEC79pt71Le2Yae
 FowZ/ObUr1UCVmbVJK9b5Wl9JKcGmULHJzX1UbWdYjGc8wP6ZhE3gtFaS+Q2Vn19ypCL
 CXt4VaI56lOyVRA3K1Y2g++8k5merXrsKimFsnF9itP+UNbpd+FQ7uuF+6d+2SCjVEO4
 OQZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=l6kZ8mrb93TKELcxaCgtqBHtArIefirGpqL2DrfF1Fg=;
 b=D8B+/GYbZrrrFcYmg4Xe83wWDDM3364rvrBOOvBCivwYOoayDy9MjhXuxolSphrGyC
 szr9tNA8iXe0trtV1GqGOiUoDXm8ScQXVhjNh/9xN/QtrB0lSIcLeHTD4GJbSwFBW/sS
 Agc9hdbEl4eOsRK4Q3YegAlV/78ZriroUG1aWgKoRWV1Rn8Z60/hf0B9f+lT9sUfYRDf
 HIgBrHcr16OWkU0Ybgidq/DS4s+0qamA3jA46SvX1A1NpPPPKIeo0K4AiLj2bdHc7uhc
 SOuRZK0BHJsk6BS6EyTNApAssYqc638lWTDY6kLZH3gGPHHPnCFM+d3BsQIW5ESLv+z/
 M0Yw==
X-Gm-Message-State: AOAM531rX9v27vj3s5gYsEt69ESv7PgZhhhqgKDI1a7ybWyZPk8rZZWl
 p5Dd0hAHnmHhnrY3OnaAD90uz4+XK2iy8A==
X-Google-Smtp-Source: ABdhPJzJyA0/LTVeazlm4yOwSb7VEMXnmvvcwDMZ3RWDs2CeXG7/GntqG2qtPVLB8pO44rhAeI9J3w==
X-Received: by 2002:ac8:4903:: with SMTP id e3mr3651827qtq.71.1597438484445;
 Fri, 14 Aug 2020 13:54:44 -0700 (PDT)
Received: from rekt.ibmuc.com ([2804:431:c7c6:303f:d1dc:35d8:e9f6:c8b])
 by smtp.gmail.com with ESMTPSA id p33sm12301018qtp.49.2020.08.14.13.54.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2020 13:54:43 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 04/10] spapr: add spapr_machine_using_legacy_numa() helper
Date: Fri, 14 Aug 2020 17:54:18 -0300
Message-Id: <20200814205424.543857-5-danielhb413@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200814205424.543857-1-danielhb413@gmail.com>
References: <20200814205424.543857-1-danielhb413@gmail.com>
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
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The changes to come to NUMA support are all guest visible. In
theory we could just create a new 5_1 class option flag to
avoid the changes to cascade to 5.1 and under. The reality is that
these changes are only relevant if the machine has more than one
NUMA node. There is no need to change guest behavior that has
been around for years needlesly.

This new helper will be used by the next patches to determine
whether we should retain the (soon to be) legacy NUMA behavior
in the pSeries machine. The new behavior will only be exposed
if::

- machine is pseries-5.2 and newer;
- more than one NUMA node is declared in NUMA state.

Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 hw/ppc/spapr.c         | 12 ++++++++++++
 include/hw/ppc/spapr.h |  2 ++
 2 files changed, 14 insertions(+)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 22e78cfc84..073a59c47d 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -308,6 +308,15 @@ static hwaddr spapr_node0_size(MachineState *machine)
     return machine->ram_size;
 }
 
+bool spapr_machine_using_legacy_numa(SpaprMachineState *spapr)
+{
+    MachineState *machine = MACHINE(spapr);
+    SpaprMachineClass *smc = SPAPR_MACHINE_GET_CLASS(machine);
+
+    return smc->pre_5_2_numa_associativity ||
+           machine->numa_state->num_nodes <= 1;
+}
+
 static void add_str(GString *s, const gchar *s1)
 {
     g_string_append_len(s, s1, strlen(s1) + 1);
@@ -4602,8 +4611,11 @@ DEFINE_SPAPR_MACHINE(5_2, "5.2", true);
  */
 static void spapr_machine_5_1_class_options(MachineClass *mc)
 {
+    SpaprMachineClass *smc = SPAPR_MACHINE_CLASS(mc);
+
     spapr_machine_5_2_class_options(mc);
     compat_props_add(mc->compat_props, hw_compat_5_1, hw_compat_5_1_len);
+    smc->pre_5_2_numa_associativity = true;
 }
 
 DEFINE_SPAPR_MACHINE(5_1, "5.1", false);
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 739a6a4942..d9f1afa8b2 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -130,6 +130,7 @@ struct SpaprMachineClass {
     bool smp_threads_vsmt; /* set VSMT to smp_threads by default */
     hwaddr rma_limit;          /* clamp the RMA to this size */
     bool pre_5_1_assoc_refpoints;
+    bool pre_5_2_numa_associativity;
 
     void (*phb_placement)(SpaprMachineState *spapr, uint32_t index,
                           uint64_t *buid, hwaddr *pio, 
@@ -847,6 +848,7 @@ int spapr_max_server_number(SpaprMachineState *spapr);
 void spapr_store_hpte(PowerPCCPU *cpu, hwaddr ptex,
                       uint64_t pte0, uint64_t pte1);
 void spapr_mce_req_event(PowerPCCPU *cpu, bool recovered);
+bool spapr_machine_using_legacy_numa(SpaprMachineState *spapr);
 
 /* DRC callbacks. */
 void spapr_core_release(DeviceState *dev);
-- 
2.26.2


