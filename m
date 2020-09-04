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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19724C43461
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 13:58:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF90220709
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 13:58:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="epV1ofJL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF90220709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kECE7-0005JD-2Y
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 09:58:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55270)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1kECCu-0003yJ-N0; Fri, 04 Sep 2020 09:56:48 -0400
Received: from mail-qk1-x744.google.com ([2607:f8b0:4864:20::744]:43213)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1kECCs-00086q-RR; Fri, 04 Sep 2020 09:56:48 -0400
Received: by mail-qk1-x744.google.com with SMTP id o64so6296852qkb.10;
 Fri, 04 Sep 2020 06:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=yaXUGx5Z0/GOHdtMl0ca+JpE0hz+CrwFr6VPmXocPbo=;
 b=epV1ofJLCkqzww6Swar+AuCfhlaYpOY1ZlZV/FvRsYJcGJG7hJkYJKILGjbGSx/5M6
 IsMszHOLiYYcQ7cq3/6dB5a7oHbhde5HykBzpRdiHJ5gcIJ1WBsgu4TShfBeWxc3TiJK
 U4z2pn+d1GUKqsgHdAq6KhBxwrNUDDvtLUPE0ISzDli8iWpASwiONRESfzYhyyAlDFSy
 bJ6ckTC5CYOviLx/vMcylUCi9+q0VNv6Ca5yiFE1uFlMpmQxwaX8+mBo/QjSaNh+IErg
 FOn4b1e1t9FXkr/zpJeZgtdHLobg3NAfQ5JYwCxyMDyYWnyrifu3eM4Vf1L6JmiAxAIy
 dAgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=yaXUGx5Z0/GOHdtMl0ca+JpE0hz+CrwFr6VPmXocPbo=;
 b=p9lIsP4bvHALWEF2tzdsy/cvYkGl6vOQQ5VkOTdWYKfZE8N8pqgXkD4lwOPTrwIYRQ
 5aT0GMZbVUff7ZF897eWMuxGQBwmPKBkAl8pU52pR3e/L9jZ0GyiiueAVyOvqQjIGYqE
 ofEDAivUM96E/RjHQYi/DfWyz9uJJEqbzQiZMaHIBg10+r6FTm9cwhCXAZncOo2nK1Sc
 W+OEMQxM8+vhbqfxz0nJmcUaSzk/impS/DGBN7/pPVdI+8GSToN1pDA58CrPEmuiiCG+
 nLZNfhLjwOHeo0ZmGsjR0gpifhNtaZiUAgQXBZnRTFM8XTTnoATvV6gY8B2mKTpn4Erw
 nLbA==
X-Gm-Message-State: AOAM532ICW8mhinFPnQOxvSZqDw8zGQ4w9nhmuUv/gfW9rSv2RsmI/Ys
 c25ziGb7CAX+q1LZjsnY33moN7Nbi5w=
X-Google-Smtp-Source: ABdhPJxFvf3vZ0w3Utkxff9EV2w6ZbEWw+RQ46CTOtFyxfZd6nK1d6bdwBcYhIysiwPrh3mIQuaz8A==
X-Received: by 2002:a05:620a:1212:: with SMTP id
 u18mr8128242qkj.434.1599227805277; 
 Fri, 04 Sep 2020 06:56:45 -0700 (PDT)
Received: from rekt.ibmuc.com ([2804:431:c7c6:1dc:ffbd:d3fb:97ff:aaca])
 by smtp.gmail.com with ESMTPSA id y30sm4682993qth.7.2020.09.04.06.56.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2020 06:56:44 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 1/3] spapr: move h_home_node_associativity to spapr_numa.c
Date: Fri,  4 Sep 2020 10:56:29 -0300
Message-Id: <20200904135631.605094-2-danielhb413@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200904135631.605094-1-danielhb413@gmail.com>
References: <20200904135631.605094-1-danielhb413@gmail.com>
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
 groug@kaod.org, david@gibson.dropbear.id.au
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


