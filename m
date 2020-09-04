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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48A72C433E2
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 01:05:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 057F920758
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 01:05:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RYD8Yoxa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 057F920758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kE0Ao-0003hx-04
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 21:05:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53994)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1kE09x-0002O7-Nt; Thu, 03 Sep 2020 21:04:57 -0400
Received: from mail-il1-x141.google.com ([2607:f8b0:4864:20::141]:44507)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1kE09w-0002jy-1Z; Thu, 03 Sep 2020 21:04:57 -0400
Received: by mail-il1-x141.google.com with SMTP id h11so4915442ilj.11;
 Thu, 03 Sep 2020 18:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=yaXUGx5Z0/GOHdtMl0ca+JpE0hz+CrwFr6VPmXocPbo=;
 b=RYD8Yoxa8/9UI2F2/n6ZRCKjACDMtiXMtsbwBqMF6DyD4+KBQSKkbDojgQKzXUI7n8
 q71Ko51puobJ9viGEolopvgQbpd4qBAqLb4B4eGfOJKSauk1vV3E+Y9wnkNUmjgeg8ci
 d00aT1+K1KFiwBBRbedgKxvAQQFe7exMIQPHXD3yYq5dLkkNIOxVluDW+sr6kVi6+qLJ
 lz1KGKSq7Psk2rc8FIBLnIbmLppmlqF2pjUeOgDk7RbCr474EeneXN4QZwAD3qu/87cs
 KudUsKOmuvtDcVuJOzUZFbxQOaU4IN3SuRFEl6m+f1TNi7w4M84fJK3ik4tyqVGhN2H/
 4ixw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=yaXUGx5Z0/GOHdtMl0ca+JpE0hz+CrwFr6VPmXocPbo=;
 b=GlmGO+nwTLLua0kScD6hUfB9bDcVTdyC7Brmv2AE6S/2lqsiC2Q2nAJkZcdhOah1KI
 TLUmF6yCjZ5iR9xMrRXaK5OQTKzfAl+G7Znu6fw1F+b9UQuvCIGfTe/sYRBZSVG6OQBH
 bWBttH6/a7TZ57R2iANmUhFvuF8BHCSyew4CAkirhCvgJyQ7bR7QTevUChpevUn1pbNG
 uITMSoJuyIUOM/juc/wDJZ7CWje0dkDogA2Ac3LN45a8sUN2fmWBiYBAeRDEJE/9oCSK
 IwVdDRECwPulm5JWF9ZcuvWq8s9ZzTTu9+UHBuonoUhpPabOT7yV56LdbxytUx9NBF+/
 zRpg==
X-Gm-Message-State: AOAM531lalJKXytgp9uYFxSMmE1ERI2ZGVxU+H/+1xVDuvCJE9mtyTex
 w/Sp6l+8y66UAmQOztXEB7arNkn+WHM=
X-Google-Smtp-Source: ABdhPJzdQToa1ScAuXiim/oa4IxWq5vLhdF+UN758CkxOWJx3s/bU2GUREFXtU5LYlOXvlvC04lZQQ==
X-Received: by 2002:a92:98c5:: with SMTP id a66mr5900709ill.50.1599181494505; 
 Thu, 03 Sep 2020 18:04:54 -0700 (PDT)
Received: from rekt.ibmuc.com ([2804:431:c7c6:1dc:ffbd:d3fb:97ff:aaca])
 by smtp.gmail.com with ESMTPSA id o18sm205907ilj.77.2020.09.03.18.04.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2020 18:04:54 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 1/3] spapr: move h_home_node_associativity to spapr_numa.c
Date: Thu,  3 Sep 2020 22:04:37 -0300
Message-Id: <20200904010439.581957-2-danielhb413@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200904010439.581957-1-danielhb413@gmail.com>
References: <20200904010439.581957-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::141;
 envelope-from=danielhb413@gmail.com; helo=mail-il1-x141.google.com
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

The implementation of this hypercall will be modified to use
spapr->numa_assoc_arrays input. Moving it to spapr_numa.c makes
make more sense.

Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 hw/ppc/spapr_hcall.c | 40 ---------------------------------------
 hw/ppc/spapr_numa.c  | 45 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+), 40 deletions(-)

diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index c1d01228c6..c2776b6a7d 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -1873,42 +1873,6 @@ static target_ulong h_client_architecture_support(PowerPCCPU *cpu,
     return ret;
 }
 
-static target_ulong h_home_node_associativity(PowerPCCPU *cpu,
-                                              SpaprMachineState *spapr,
-                                              target_ulong opcode,
-                                              target_ulong *args)
-{
-    target_ulong flags = args[0];
-    target_ulong procno = args[1];
-    PowerPCCPU *tcpu;
-    int idx;
-
-    /* only support procno from H_REGISTER_VPA */
-    if (flags != 0x1) {
-        return H_FUNCTION;
-    }
-
-    tcpu = spapr_find_cpu(procno);
-    if (tcpu == NULL) {
-        return H_P2;
-    }
-
-    /* sequence is the same as in the "ibm,associativity" property */
-
-    idx = 0;
-#define ASSOCIATIVITY(a, b) (((uint64_t)(a) << 32) | \
-                             ((uint64_t)(b) & 0xffffffff))
-    args[idx++] = ASSOCIATIVITY(0, 0);
-    args[idx++] = ASSOCIATIVITY(0, tcpu->node_id);
-    args[idx++] = ASSOCIATIVITY(procno, -1);
-    for ( ; idx < 6; idx++) {
-        args[idx] = -1;
-    }
-#undef ASSOCIATIVITY
-
-    return H_SUCCESS;
-}
-
 static target_ulong h_get_cpu_characteristics(PowerPCCPU *cpu,
                                               SpaprMachineState *spapr,
                                               target_ulong opcode,
@@ -2139,10 +2103,6 @@ static void hypercall_register_types(void)
     spapr_register_hypercall(KVMPPC_H_CAS, h_client_architecture_support);
 
     spapr_register_hypercall(KVMPPC_H_UPDATE_DT, h_update_dt);
-
-    /* Virtual Processor Home Node */
-    spapr_register_hypercall(H_HOME_NODE_ASSOCIATIVITY,
-                             h_home_node_associativity);
 }
 
 type_init(hypercall_register_types)
diff --git a/hw/ppc/spapr_numa.c b/hw/ppc/spapr_numa.c
index 93a000b729..368c1a494d 100644
--- a/hw/ppc/spapr_numa.c
+++ b/hw/ppc/spapr_numa.c
@@ -165,3 +165,48 @@ void spapr_numa_write_rtas_dt(SpaprMachineState *spapr, void *fdt, int rtas)
     _FDT(fdt_setprop(fdt, rtas, "ibm,max-associativity-domains",
                      maxdomains, sizeof(maxdomains)));
 }
+
+static target_ulong h_home_node_associativity(PowerPCCPU *cpu,
+                                              SpaprMachineState *spapr,
+                                              target_ulong opcode,
+                                              target_ulong *args)
+{
+    target_ulong flags = args[0];
+    target_ulong procno = args[1];
+    PowerPCCPU *tcpu;
+    int idx;
+
+    /* only support procno from H_REGISTER_VPA */
+    if (flags != 0x1) {
+        return H_FUNCTION;
+    }
+
+    tcpu = spapr_find_cpu(procno);
+    if (tcpu == NULL) {
+        return H_P2;
+    }
+
+    /* sequence is the same as in the "ibm,associativity" property */
+
+    idx = 0;
+#define ASSOCIATIVITY(a, b) (((uint64_t)(a) << 32) | \
+                             ((uint64_t)(b) & 0xffffffff))
+    args[idx++] = ASSOCIATIVITY(0, 0);
+    args[idx++] = ASSOCIATIVITY(0, tcpu->node_id);
+    args[idx++] = ASSOCIATIVITY(procno, -1);
+    for ( ; idx < 6; idx++) {
+        args[idx] = -1;
+    }
+#undef ASSOCIATIVITY
+
+    return H_SUCCESS;
+}
+
+static void spapr_numa_register_types(void)
+{
+    /* Virtual Processor Home Node */
+    spapr_register_hypercall(H_HOME_NODE_ASSOCIATIVITY,
+                             h_home_node_associativity);
+}
+
+type_init(spapr_numa_register_types)
-- 
2.26.2


