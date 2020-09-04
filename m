Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AEBCC43461
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 01:07:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D83B20758
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 01:07:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="umH80TQA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D83B20758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33140 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kE0CP-0006vM-GR
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 21:07:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54030)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1kE0A1-0002Wn-MT; Thu, 03 Sep 2020 21:05:01 -0400
Received: from mail-il1-x144.google.com ([2607:f8b0:4864:20::144]:41536)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1kE09z-0002kP-VH; Thu, 03 Sep 2020 21:05:01 -0400
Received: by mail-il1-x144.google.com with SMTP id w8so4938267ilj.8;
 Thu, 03 Sep 2020 18:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=DPxxBWeC4FEvN6MAD2yhRYDcWf1dgWl/eqzDkL21hmc=;
 b=umH80TQA95CeA3tNVazBrDNksqHOGtpELXgK/wqy4lUj2O0aYvVQ+Mqk0dVpzFKWi8
 uEHMRouQdDeLxXsUMpHHY9kQTTCz+3Pr/gCf/M5d5zBt6QNrLwhgKkHdPUkO1CIc7g35
 wzPeRWYULkoAxCVXMhdCDP5G7kV2RqOYeqBcmtbCEOYQwYIRWazZlak4fFu7cOvva8iY
 RBC3ZfH3Uf1GzH298z9iJCtmD6g8hSBdGEFeIYiQS4jqITPQCi7P6JtyIqM34k3idVYz
 iyj3Uu/xGbboTHMYALLdkTbQY59v5Oql/gfZGWgJnHIZ/a1QE45BXpvAVItZV9lZY4/F
 RdGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=DPxxBWeC4FEvN6MAD2yhRYDcWf1dgWl/eqzDkL21hmc=;
 b=m7LNEvT62oL5fI8TpmL+jjtES0c9+TYIQFz+tob7ftTt4YcjxZk1isxMEoyjOF+8P0
 wVBj2r0BiV4pcOajIAFTxkyIlVsMIx9UZDrozJfgqLjMb4K4xg+aD7bI0nk9QDvEchNE
 YZgVLo/plAOks1LUXvIgzW6rdSW91ckQ00zOg4gYCB5KEM9uf0rKWiYFYVoBucW062Qt
 wB6NOkYqLNltjdZ4llb5tz7Rz/chaBPPmiJqWL1OnNJbBz84WKq/S1EAX3agbe4cM4WU
 KeNVtnxjEd5SYAyUAoxTEfEG9223jd6FReykSkMY2JDYw9MX+P5hxpgrgsgWdXqZBAU/
 /7Fg==
X-Gm-Message-State: AOAM533JywSox96+LisBDEniEexusXaAz73y9YatkxHzle5k+O1e0QVB
 D9FNJ7tjC5rk+tv+T7wa63iTteQL5bY=
X-Google-Smtp-Source: ABdhPJzn+u3OW8do4dAEjQfcrKWLvZBttD6+KTOjyGpnrpHRtc/AlRhwQ9ssxwDaS/4elNXUs2Hhrw==
X-Received: by 2002:a05:6e02:1107:: with SMTP id
 u7mr5723047ilk.165.1599181498361; 
 Thu, 03 Sep 2020 18:04:58 -0700 (PDT)
Received: from rekt.ibmuc.com ([2804:431:c7c6:1dc:ffbd:d3fb:97ff:aaca])
 by smtp.gmail.com with ESMTPSA id o18sm205907ilj.77.2020.09.03.18.04.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2020 18:04:57 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 3/3] spapr_numa: use spapr_numa_get_vcpu_assoc() in
 home_node hcall
Date: Thu,  3 Sep 2020 22:04:39 -0300
Message-Id: <20200904010439.581957-4-danielhb413@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200904010439.581957-1-danielhb413@gmail.com>
References: <20200904010439.581957-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::144;
 envelope-from=danielhb413@gmail.com; helo=mail-il1-x144.google.com
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

The current implementation of h_home_node_associativity hard codes
the values of associativity domains of the vcpus. Let's make
it consider the values already initialized in spapr->numa_assoc_array,
via the spapr_numa_get_vcpu_assoc() helper.

We want to set it and forget it, and for that we also need to
assert that we don't overflow the registers of the hypercall.
From R4 to R9 we can squeeze in 12 associativity domains, so
let's assert that MAX_DISTANCE_REF_POINTS isn't greater
than that.

Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 hw/ppc/spapr_numa.c | 33 +++++++++++++++++++++++++--------
 1 file changed, 25 insertions(+), 8 deletions(-)

diff --git a/hw/ppc/spapr_numa.c b/hw/ppc/spapr_numa.c
index 980a6488bf..0a7e07fe60 100644
--- a/hw/ppc/spapr_numa.c
+++ b/hw/ppc/spapr_numa.c
@@ -181,10 +181,12 @@ static target_ulong h_home_node_associativity(PowerPCCPU *cpu,
                                               target_ulong opcode,
                                               target_ulong *args)
 {
+    g_autofree uint32_t *vcpu_assoc = NULL;
     target_ulong flags = args[0];
     target_ulong procno = args[1];
     PowerPCCPU *tcpu;
-    int idx;
+    uint vcpu_assoc_size;
+    int idx, assoc_idx;
 
     /* only support procno from H_REGISTER_VPA */
     if (flags != 0x1) {
@@ -196,16 +198,31 @@ static target_ulong h_home_node_associativity(PowerPCCPU *cpu,
         return H_P2;
     }
 
-    /* sequence is the same as in the "ibm,associativity" property */
+    /*
+     * Given that we want to be flexible with the sizes and indexes,
+     * we must consider that there is a hard limit of how many
+     * associativities domain we can fit in R4 up to R9, which
+     * would be 12. Assert and bail if that's not the case.
+     */
+    G_STATIC_ASSERT(MAX_DISTANCE_REF_POINTS <= 12);
+
+    vcpu_assoc = spapr_numa_get_vcpu_assoc(spapr, tcpu, &vcpu_assoc_size);
+    vcpu_assoc_size /= sizeof(uint32_t);
+    /* assoc_idx starts at 1 to skip associativity size */
+    assoc_idx = 1;
 
-    idx = 0;
 #define ASSOCIATIVITY(a, b) (((uint64_t)(a) << 32) | \
                              ((uint64_t)(b) & 0xffffffff))
-    args[idx++] = ASSOCIATIVITY(0, 0);
-    args[idx++] = ASSOCIATIVITY(0, tcpu->node_id);
-    args[idx++] = ASSOCIATIVITY(procno, -1);
-    for ( ; idx < 6; idx++) {
-        args[idx] = -1;
+
+    for (idx = 0; idx < 6; idx++) {
+        int32_t a, b;
+
+        a = assoc_idx < vcpu_assoc_size ?
+            be32_to_cpu(vcpu_assoc[assoc_idx++]) : -1;
+        b = assoc_idx < vcpu_assoc_size ?
+            be32_to_cpu(vcpu_assoc[assoc_idx++]) : -1;
+
+        args[idx] = ASSOCIATIVITY(a, b);
     }
 #undef ASSOCIATIVITY
 
-- 
2.26.2


