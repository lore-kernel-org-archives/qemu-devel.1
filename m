Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECB13C43461
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 22:11:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB32320716
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 22:11:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b7msyaBz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB32320716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40988 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDxSQ-0006KR-U1
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 18:11:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45108)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1kDxNn-0006NZ-H4; Thu, 03 Sep 2020 18:07:03 -0400
Received: from mail-qt1-x843.google.com ([2607:f8b0:4864:20::843]:37087)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1kDxNj-0007T9-N5; Thu, 03 Sep 2020 18:07:03 -0400
Received: by mail-qt1-x843.google.com with SMTP id k25so2249816qtu.4;
 Thu, 03 Sep 2020 15:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=rkIDipTQJyp7b+9IYufFx9hAJCjuKNzbTlrb+coLwpE=;
 b=b7msyaBzZPfCMg+6ek1fTFsbGkN3+bI34jB7b2kUNRkNxM3oftErId6D7WLIcyURXS
 IbuAfGNbN22zDBS3p97oxW+y4tpi40huq8LeJlWISRFlHkHJSEoFNtNmRpHfettVkO9g
 qQqJwC3q0RAIl1pYy34xeIHaq5mgWVlynvQWNMmmVZBStwLgL/NfL0e3xSrdi1FRs1oT
 zoECyMzvpmr6IjvwurjBI6C23tNGwsNegfUrd5XhbmWkoDT7ejaKqTdISu2prIxUWLjK
 iaYiwmLKEhYlGoRp1vyP9rRt4TjrAE0c4Dh1HGbgnykv7PlxTxelUXnYseTx3S7Gi5Sw
 qRCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=rkIDipTQJyp7b+9IYufFx9hAJCjuKNzbTlrb+coLwpE=;
 b=qIAs840TnRAYQKxkSgWL1hxokOv7BA1k4hOelZ+5k6fM6DgWI1ehvoc0kuePt7JqZt
 tIaTn8virGKknupX1damXuIcwyDtOnzBa6OEba6DiRx06hx6rJh5ZAGrmeqvwvx/9UOY
 //wYuQsk2zphKKm7Ok1eZDma8fuBFPmKhxzi340S87TupJsT7Hj2OS+3ksOpBZ/pHJtA
 lGhDcn0eFgQAIIK8AD9VwAbPzYdyOguWXlv7/O43xeSRkzHcBVTunaugAlycTLl5TJiO
 /GEkwVX/wFIpLPpplkuhP+wkoZDPDZz8r/KQPDmxr3JYvppnrQ0Pb1e10eGTF4uKM+di
 o84g==
X-Gm-Message-State: AOAM530SK3Fv6ruLcrmg77BDxHsnrjRMEN9HZu1AsqN0KCxLs9zdHryS
 O/Fgeu3cM5i2aYtocqmp5ZdB7FJ6whhCSw==
X-Google-Smtp-Source: ABdhPJy7ebtJHK/a/vk0+/QWaFqGfiFUMkT/BFFKsg14mAKCU6Rbh74TOJgVdNN59mKzKCJnJE37RQ==
X-Received: by 2002:ac8:44b5:: with SMTP id a21mr5806713qto.36.1599170817999; 
 Thu, 03 Sep 2020 15:06:57 -0700 (PDT)
Received: from rekt.ibmuc.com ([2804:431:c7c6:1dc:ffbd:d3fb:97ff:aaca])
 by smtp.gmail.com with ESMTPSA id j1sm1798757qtk.91.2020.09.03.15.06.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2020 15:06:57 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 5/7] spapr: move h_home_node_associativity to spapr_numa.c
Date: Thu,  3 Sep 2020 19:06:37 -0300
Message-Id: <20200903220639.563090-6-danielhb413@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200903220639.563090-1-danielhb413@gmail.com>
References: <20200903220639.563090-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::843;
 envelope-from=danielhb413@gmail.com; helo=mail-qt1-x843.google.com
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
 hw/ppc/spapr_hcall.c        | 37 +------------------------------------
 hw/ppc/spapr_numa.c         | 36 ++++++++++++++++++++++++++++++++++++
 include/hw/ppc/spapr_numa.h |  4 ++++
 3 files changed, 41 insertions(+), 36 deletions(-)

diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index c1d01228c6..9e9b959bbd 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -18,6 +18,7 @@
 #include "kvm_ppc.h"
 #include "hw/ppc/fdt.h"
 #include "hw/ppc/spapr_ovec.h"
+#include "hw/ppc/spapr_numa.h"
 #include "mmu-book3s-v3.h"
 #include "hw/mem/memory-device.h"
 
@@ -1873,42 +1874,6 @@ static target_ulong h_client_architecture_support(PowerPCCPU *cpu,
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
diff --git a/hw/ppc/spapr_numa.c b/hw/ppc/spapr_numa.c
index 93a000b729..d4dca57321 100644
--- a/hw/ppc/spapr_numa.c
+++ b/hw/ppc/spapr_numa.c
@@ -165,3 +165,39 @@ void spapr_numa_write_rtas_dt(SpaprMachineState *spapr, void *fdt, int rtas)
     _FDT(fdt_setprop(fdt, rtas, "ibm,max-associativity-domains",
                      maxdomains, sizeof(maxdomains)));
 }
+
+target_ulong h_home_node_associativity(PowerPCCPU *cpu,
+                                       SpaprMachineState *spapr,
+                                       target_ulong opcode,
+                                       target_ulong *args)
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
diff --git a/include/hw/ppc/spapr_numa.h b/include/hw/ppc/spapr_numa.h
index b3fd950634..5b4d165c06 100644
--- a/include/hw/ppc/spapr_numa.h
+++ b/include/hw/ppc/spapr_numa.h
@@ -31,5 +31,9 @@ int spapr_numa_fixup_cpu_dt(SpaprMachineState *spapr, void *fdt,
                             int offset, PowerPCCPU *cpu);
 int spapr_numa_write_assoc_lookup_arrays(SpaprMachineState *spapr, void *fdt,
                                          int offset);
+target_ulong h_home_node_associativity(PowerPCCPU *cpu,
+                                       SpaprMachineState *spapr,
+                                       target_ulong opcode,
+                                       target_ulong *args);
 
 #endif /* HW_SPAPR_NUMA_H */
-- 
2.26.2


