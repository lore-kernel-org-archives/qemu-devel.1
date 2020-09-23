Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 788CFC4727E
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 19:40:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEB062371F
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 19:40:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hnFr3GD/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEB062371F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLAcR-0007f5-QF
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 15:39:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39584)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1kLAXs-0002bD-0W; Wed, 23 Sep 2020 15:35:16 -0400
Received: from mail-qk1-x729.google.com ([2607:f8b0:4864:20::729]:40527)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1kLAXq-0008VG-2f; Wed, 23 Sep 2020 15:35:15 -0400
Received: by mail-qk1-x729.google.com with SMTP id w16so902578qkj.7;
 Wed, 23 Sep 2020 12:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=3Pb2Hls/e8P7amLmEaCt/vqVuaxBFgGmr0SvcjklXJA=;
 b=hnFr3GD/OeaKVVZLyNDoUlj1EdQsYKWBbUI+IdYO8JYr+uqCwDHMMTwqb3DyBREul7
 OY7Knu+II9UvXQwVI5t1JRs2CPs5IrQy1VQ5x5njTRvFJZYrLzCNxWdj2yP9msEO+y9o
 8DBZSvYN0qIl+TDoDwBPCPPFxaRpkKX1TC5KLhJMXXb2stEsiUGAikDYIQvGqc4VSyXS
 WOqxGiL6tpy9twM6Jcu5TNE6NrawYlZi06Hkl2ZeFiSZjJ/dQom6SN5BMsDV3pldJfQd
 F/0lDMez6CrTiaxt+GV4YNq9QQBO1zgdbHgyK87ksG0Son2GvKqA8i6zSs8qLP8SqHzH
 71PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=3Pb2Hls/e8P7amLmEaCt/vqVuaxBFgGmr0SvcjklXJA=;
 b=sETwo8Jy5oPzuIFhsp1yRvVuTXqO7VSK1gFf3CLdQjJH74SUJguChkdlk+zkDMZTQG
 Ykv6an7Lp4516rQjTZIkU4UPOnkT3Uc4B/XsOJZryou7WouVSFfhmk/+9Mc0sNS2H4J3
 Pt3G5soOPihFmqnUd9rP6R3BJRmHTuPzesNnHthRbUOinR1yzkeTd0oq6G1BKYMjOJ+O
 VsNirM1wmUUxijO/BS43/qlBkxBCvpH45NDn6PbDinOUApILkXUFf/FKRNt4JIg4OcF8
 y0cM38iX82Y6Bl5elDShtqHllDynhfB2l5EHgDh7O6hcjuooVrUKHwIbAlqbdb0P49WA
 BAKA==
X-Gm-Message-State: AOAM531oz2d5d9IChZM7jJQe0AOXxUSj6/sWZSfzJgYsOojhytFUbzmR
 rHDD0FO/IDquJIQsxr1U0THIxdnzXcmjGw==
X-Google-Smtp-Source: ABdhPJwnuzciQgbf8B0kvcdSAsie8Po5lBusFMYMFuc4hZMa3M42i3xsg4/LpNGaIIrGnJCVjZyqhg==
X-Received: by 2002:a37:d207:: with SMTP id f7mr1476639qkj.302.1600889712031; 
 Wed, 23 Sep 2020 12:35:12 -0700 (PDT)
Received: from rekt.ibmuc.com ([2804:431:c7c7:9e50:6b84:53b8:5d9d:d408])
 by smtp.gmail.com with ESMTPSA id u4sm612362qkk.68.2020.09.23.12.35.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2020 12:35:08 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/6] spapr: add spapr_machine_using_legacy_numa() helper
Date: Wed, 23 Sep 2020 16:34:53 -0300
Message-Id: <20200923193458.203186-2-danielhb413@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200923193458.203186-1-danielhb413@gmail.com>
References: <20200923193458.203186-1-danielhb413@gmail.com>
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
if:

- machine is pseries-5.2 and newer;
- more than one NUMA node is declared in NUMA state.

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


