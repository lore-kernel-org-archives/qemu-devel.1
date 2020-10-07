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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15905C41604
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 17:31:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F3622168B
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 17:31:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UR91BPCr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F3622168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQDHL-0007y0-T9
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 13:31:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59166)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1kQDFP-0005x2-86; Wed, 07 Oct 2020 13:29:03 -0400
Received: from mail-qk1-x731.google.com ([2607:f8b0:4864:20::731]:42315)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1kQDFN-000079-GK; Wed, 07 Oct 2020 13:29:02 -0400
Received: by mail-qk1-x731.google.com with SMTP id v123so3732401qkd.9;
 Wed, 07 Oct 2020 10:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=dfy/YADIKVcZjL8rRBgnq8l2LIPnOgr/q3i/W+Gmr0E=;
 b=UR91BPCrOEO5XEt0US02Z+mm7v7/UyBDGshDccn0Sc0dMAABok6O8R7jPcrIFBDI+m
 j9CcRr6vM7aGqBQpspDc+Mp9SANxkiVBW/JeVm7r9jbWw81jtdNjIrzKMwtZQrG/e9sr
 U+Zc9zUz3te1JLRS8BnnycGzVgF6pOjrN2KnjEF9irOK7tEFpkh911ASB/haYYsaZY3D
 m+cx/vtmjHZsvlp2KQgPI1RBu1N7GZVhyZdQugcGXDnLhe9a2NJlK2N+2Txls1XzgOkb
 1EQjQvoiSVvXgP7fi7kY/5eE+eTkB9bBFIw8ay33c6V4IvQoCyH3rWcmAYWxgALCfQIq
 iR1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=dfy/YADIKVcZjL8rRBgnq8l2LIPnOgr/q3i/W+Gmr0E=;
 b=uMkEIuwUm5MT4J1f1w6B+HFWEK500cTWsQZioHXiCVPcnTjxG47IdK/yiRGF0tWrFg
 /OWuAYzlSe4ThUF8iB57CDdMittFSSMc58btcvFUBU92NOBTeuUSaMpNKKPiV8wErGDO
 jJLwoYpyWtr0mHq1Qbj5zAHm6qod9xvQ+LmKfd9ybw0OEX/DxNJpYY2lVl8CyBu0J6eK
 kqCObav+X7M6BqwyJziwAho1Mah9h3fwvqMVYhjkmkx0AKWAumnDjLHr7msOP5AKKAem
 cqmOiBfI5/iQjsqOzawgTGf0ysl+9DBdK0BzL5GMtkewbFO0+x5qDK7ol3g8NbSDhRz5
 yMFA==
X-Gm-Message-State: AOAM5307Yn9HDWj4f+0mubEuG0b4/bu4/wo42dS1BwDYWiH3gSLkJpuZ
 o8wE/Y6l6jpAQxRqR3GFpZENit4DWgTzJw==
X-Google-Smtp-Source: ABdhPJyhm/64t2T7/On1W0KW3As/H/OeniK5eeHLHEGpRYOzh94OfLKjpNTPNJp32l3cemElLLnV6w==
X-Received: by 2002:a37:a1cd:: with SMTP id k196mr3864858qke.409.1602091739870; 
 Wed, 07 Oct 2020 10:28:59 -0700 (PDT)
Received: from rekt.ibmuc.com ([2804:431:c7c6:5a9b:54fc:df2a:8a5e:989b])
 by smtp.gmail.com with ESMTPSA id e39sm2080117qtk.32.2020.10.07.10.28.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2020 10:28:59 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 1/5] spapr: add spapr_machine_using_legacy_numa() helper
Date: Wed,  7 Oct 2020 14:28:45 -0300
Message-Id: <20201007172849.302240-2-danielhb413@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201007172849.302240-1-danielhb413@gmail.com>
References: <20201007172849.302240-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::731;
 envelope-from=danielhb413@gmail.com; helo=mail-qk1-x731.google.com
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
index 4256794f3b..63315f2d0f 100644
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
@@ -4519,8 +4528,11 @@ DEFINE_SPAPR_MACHINE(5_2, "5.2", true);
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
index bba8736269..bb47896f17 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -138,6 +138,7 @@ struct SpaprMachineClass {
     bool smp_threads_vsmt; /* set VSMT to smp_threads by default */
     hwaddr rma_limit;          /* clamp the RMA to this size */
     bool pre_5_1_assoc_refpoints;
+    bool pre_5_2_numa_associativity;
 
     void (*phb_placement)(SpaprMachineState *spapr, uint32_t index,
                           uint64_t *buid, hwaddr *pio, 
@@ -853,6 +854,7 @@ int spapr_max_server_number(SpaprMachineState *spapr);
 void spapr_store_hpte(PowerPCCPU *cpu, hwaddr ptex,
                       uint64_t pte0, uint64_t pte1);
 void spapr_mce_req_event(PowerPCCPU *cpu, bool recovered);
+bool spapr_machine_using_legacy_numa(SpaprMachineState *spapr);
 
 /* DRC callbacks. */
 void spapr_core_release(DeviceState *dev);
-- 
2.26.2


