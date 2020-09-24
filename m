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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 952DBC4727D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 19:53:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F03562220D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 19:53:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jiA+hdRl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F03562220D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44030 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLXJI-0003Yq-Cg
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 15:53:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55552)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1kLXGr-0001m3-6z; Thu, 24 Sep 2020 15:51:13 -0400
Received: from mail-qk1-x729.google.com ([2607:f8b0:4864:20::729]:44516)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1kLXGp-00018P-1X; Thu, 24 Sep 2020 15:51:12 -0400
Received: by mail-qk1-x729.google.com with SMTP id n133so642155qkn.11;
 Thu, 24 Sep 2020 12:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=neaS6yuMeaOowQGU9uSi8JXfUOeAiUye6JSFdgemN/M=;
 b=jiA+hdRlmHAhG56t8bq0cPNBlATbNdiOkZUeP0KdzlfPo/6gnax16VIxyRu6QU3VFt
 0G7UPzFXmZPgadysSJl++PfH3gVE+eHkXEI5gpgTwpXTBBa16MYlyqOV+TYmIJwjqczP
 EGR/LJVz22+1C1Rubz7j3n9Awwi073ZHCniPqsgYi42IrZcDId7twebIP459t03TVS8i
 7seJpLGnA8Ys6V7AZ6qvBF8p7faqxsLUO2+Vr/c4sSnk9T8hKoMVoY4qpQ9hwllbrn/Y
 /QD1ZCay/4zhtAenIlaSsK6lEytRDoE1m3UliGMuMyUpz9t6q+LKAWa439fg71kmPtH2
 pXmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=neaS6yuMeaOowQGU9uSi8JXfUOeAiUye6JSFdgemN/M=;
 b=PiFyqqLSX6E28nwSdpCU0b1o6c+ZuQu2d4Ay96dem8uy0wnmahfi4RzUGgCLD6IZn4
 Bo/rO2jb2CcxKm3+bTP0zyr3bbE05MD/KyWI5NRJGARTSYRjuIq1HBH/n8GoQDghuVMZ
 YaNfpA+CGwH+8fsK9ny4zTspehtMZmO/Ha6wjEYFbbRW9Dd4syjR0gJOuDa+Chykwj9z
 jN8ijQl4Ra10CHBT/WCMW3M0AmphdpIqe3NHvdfTvx3D1b9Tm/siBjtPMNjE5AUmS584
 fF8gmxigM6zS2uvCRXBs5C9w1GRYmJBgMexETSKODdwZrx59GyydGNOJdEPgJzo3mkwd
 FqJQ==
X-Gm-Message-State: AOAM532Ttrk8VLoyHPbN4qPf4VrmuTkVGOJ1/TnRZRsnirzGOnejnMMp
 LUz36Lje6fzJ/B6vatpl8r+Oh7aWYQu03w==
X-Google-Smtp-Source: ABdhPJw5ELdcy5TGb+zN6YKjbxYmovHTJQgmwxR2VNHMTVntehVM8u0PVkd6KKFCjXV1R9x+16AsOg==
X-Received: by 2002:a05:620a:683:: with SMTP id
 f3mr744340qkh.491.1600977069487; 
 Thu, 24 Sep 2020 12:51:09 -0700 (PDT)
Received: from rekt.ibmuc.com ([2804:431:c7c7:c625:6c0e:4720:8228:5f68])
 by smtp.gmail.com with ESMTPSA id f3sm381613qtg.71.2020.09.24.12.51.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2020 12:51:09 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/6] spapr: add spapr_machine_using_legacy_numa() helper
Date: Thu, 24 Sep 2020 16:50:53 -0300
Message-Id: <20200924195058.362984-2-danielhb413@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200924195058.362984-1-danielhb413@gmail.com>
References: <20200924195058.362984-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::729;
 envelope-from=danielhb413@gmail.com; helo=mail-qk1-x729.google.com
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

The changes to come to NUMA support are all guest visible. In
theory we could just create a new 5_1 class option flag to
avoid the changes to cascade to 5.1 and under. The reality is that
these changes are only relevant if the machine has more than one
NUMA node. There is no need to change guest behavior that has
been around for years needlesly.

This new helper will be used by the next patches to determine
whether we should retain the (soon to be) legacy NUMA behavior
in the pSeries machine. The new behavior will only be exposed
if:

- machine is pseries-5.2 and newer;
- more than one NUMA node is declared in NUMA state.

Reviewed-by: Greg Kurz <groug@kaod.org>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 hw/ppc/spapr.c         | 12 ++++++++++++
 include/hw/ppc/spapr.h |  2 ++
 2 files changed, 14 insertions(+)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index e813c7cfb9..c5d8910a74 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -294,6 +294,15 @@ static hwaddr spapr_node0_size(MachineState *machine)
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
@@ -4522,8 +4531,11 @@ DEFINE_SPAPR_MACHINE(5_2, "5.2", true);
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
index 114e819969..d1aae03b97 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -143,6 +143,7 @@ struct SpaprMachineClass {
     bool smp_threads_vsmt; /* set VSMT to smp_threads by default */
     hwaddr rma_limit;          /* clamp the RMA to this size */
     bool pre_5_1_assoc_refpoints;
+    bool pre_5_2_numa_associativity;
 
     void (*phb_placement)(SpaprMachineState *spapr, uint32_t index,
                           uint64_t *buid, hwaddr *pio, 
@@ -860,6 +861,7 @@ int spapr_max_server_number(SpaprMachineState *spapr);
 void spapr_store_hpte(PowerPCCPU *cpu, hwaddr ptex,
                       uint64_t pte0, uint64_t pte1);
 void spapr_mce_req_event(PowerPCCPU *cpu, bool recovered);
+bool spapr_machine_using_legacy_numa(SpaprMachineState *spapr);
 
 /* DRC callbacks. */
 void spapr_core_release(DeviceState *dev);
-- 
2.26.2


