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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BE9FC433E2
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 13:58:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0DE020709
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 13:58:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pQdjT9Ly"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0DE020709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56316 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kECEG-0005g3-UI
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 09:58:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55290)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1kECCx-00043v-0v; Fri, 04 Sep 2020 09:56:51 -0400
Received: from mail-qk1-x741.google.com ([2607:f8b0:4864:20::741]:33054)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1kECCv-00087C-8a; Fri, 04 Sep 2020 09:56:50 -0400
Received: by mail-qk1-x741.google.com with SMTP id p4so6370199qkf.0;
 Fri, 04 Sep 2020 06:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=B25qamJo3FWxLu1J43XkdjSAaW2Gpibu700qwm6H0C4=;
 b=pQdjT9Ly6b6PtK/+7rEmuzzwBaqMi6ZYqpYaOxj7XuYd62FWZq46fnvqtITY0WhI82
 n8U9H2v6Nj+bAGsqXnJD1cPhjeEIHX47MxkYynDnH/wRy8ZR4XMjSIioDzEmAqUpGi1R
 9DLxBWOasTkv4Hsay1Z4+BYSN7iKHVwbmpRFfR02LlrQaiTAYlBfcaoP4URTf4/xToT+
 Gw9FLL5l/H7wyF8RR2L+x9p9W+s162pFY16xbKBTNqmbygLh0SU9wke/m4285NB5L2of
 E24wcKA3b5Otp4BqTn4h+9Tj5lX8lJ/Aghjuw8K/+xgUHF/8P2FoW7ds4uLY4WzItvC0
 gAbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=B25qamJo3FWxLu1J43XkdjSAaW2Gpibu700qwm6H0C4=;
 b=K+KtR69fEuH4KzWpi5MgZqoQZYOLoQnKt2HiKpbaCiznRbi70W8IcJVMZFXsns9Km/
 33463w+JCCp1BL3nhvQ5HvN1+OlH9ADaKw0Vpt7l/xg3k7gYmIUaRI2MXBUpOWrOyIH8
 A2Q0JLIUKsF4LxAUF1ZJ5YyJSl36Kd9kTwEhQub8LNWJej1cGG2lKzfxUHIV67sHC22n
 qzvISH3bw9eCnK7x7Uq8ZZx5qh7sIwtKdevqzLuUOCED/j2fSa3l1V7e2mGYLAxNBG/E
 psMC+JjaeXf+41KcYDUCphIeIVbcig8Y5/OCO4kOb/BkIR0b2iaZfCUZIQ6DejESEPe/
 SAkA==
X-Gm-Message-State: AOAM532F1BQuicfhTUa8KFZGRg328LQZ7NdNEHwvc9H+cdXo9TjlFWq5
 CIQRvvxoyqfg/d9Q4udqEM+ryXLiUb8=
X-Google-Smtp-Source: ABdhPJzhS6UGHelboVCRbZbULbq61hbuYEXERaccmy+HlfLqvXI9xj/9YrZcLFJD9EOhVnQZ3dV7Kg==
X-Received: by 2002:a37:c4b:: with SMTP id 72mr8027024qkm.176.1599227807551;
 Fri, 04 Sep 2020 06:56:47 -0700 (PDT)
Received: from rekt.ibmuc.com ([2804:431:c7c6:1dc:ffbd:d3fb:97ff:aaca])
 by smtp.gmail.com with ESMTPSA id y30sm4682993qth.7.2020.09.04.06.56.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2020 06:56:47 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 2/3] spapr_numa: create a vcpu associativity helper
Date: Fri,  4 Sep 2020 10:56:30 -0300
Message-Id: <20200904135631.605094-3-danielhb413@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200904135631.605094-1-danielhb413@gmail.com>
References: <20200904135631.605094-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::741;
 envelope-from=danielhb413@gmail.com; helo=mail-qk1-x741.google.com
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

The work to be done in h_home_node_associativity() intersects
with what is already done in spapr_numa_fixup_cpu_dt(). This
patch creates a new helper, spapr_numa_get_vcpu_assoc(), to
be used for both spapr_numa_fixup_cpu_dt() and
h_home_node_associativity().

While we're at it, use memcpy() instead of loop assignment
to created the returned array.

Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 hw/ppc/spapr_numa.c    | 33 ++++++++++++++++++++-------------
 include/hw/ppc/spapr.h |  7 ++++++-
 2 files changed, 26 insertions(+), 14 deletions(-)

diff --git a/hw/ppc/spapr_numa.c b/hw/ppc/spapr_numa.c
index 368c1a494d..674d2ee86d 100644
--- a/hw/ppc/spapr_numa.c
+++ b/hw/ppc/spapr_numa.c
@@ -71,31 +71,38 @@ void spapr_numa_write_associativity_dt(SpaprMachineState *spapr, void *fdt,
                       sizeof(spapr->numa_assoc_array[nodeid]))));
 }
 
-int spapr_numa_fixup_cpu_dt(SpaprMachineState *spapr, void *fdt,
-                            int offset, PowerPCCPU *cpu)
+static uint32_t *spapr_numa_get_vcpu_assoc(SpaprMachineState *spapr,
+                                           PowerPCCPU *cpu)
 {
-    uint vcpu_assoc_size = NUMA_ASSOC_SIZE + 1;
-    uint32_t vcpu_assoc[vcpu_assoc_size];
+    uint32_t *vcpu_assoc = g_malloc(VCPU_ASSOC_SIZE * sizeof(uint32_t));
     int index = spapr_get_vcpu_id(cpu);
-    int i;
+
+    g_assert(vcpu_assoc != NULL);
 
     /*
      * VCPUs have an extra 'cpu_id' value in ibm,associativity
      * compared to other resources. Increment the size at index
-     * 0, copy all associativity domains already set, then put
-     * cpu_id last.
+     * 0, put cpu_id last, then copy the remaining associativity
+     * domains.
      */
     vcpu_assoc[0] = cpu_to_be32(MAX_DISTANCE_REF_POINTS + 1);
+    vcpu_assoc[VCPU_ASSOC_SIZE - 1] = cpu_to_be32(index);
+    memcpy(vcpu_assoc + 1, spapr->numa_assoc_array[cpu->node_id] + 1,
+           (VCPU_ASSOC_SIZE - 2) * sizeof(uint32_t));
 
-    for (i = 1; i <= MAX_DISTANCE_REF_POINTS; i++) {
-        vcpu_assoc[i] = spapr->numa_assoc_array[cpu->node_id][i];
-    }
+    return vcpu_assoc;
+}
+
+int spapr_numa_fixup_cpu_dt(SpaprMachineState *spapr, void *fdt,
+                            int offset, PowerPCCPU *cpu)
+{
+    g_autofree uint32_t *vcpu_assoc = NULL;
 
-    vcpu_assoc[vcpu_assoc_size - 1] = cpu_to_be32(index);
+    vcpu_assoc = spapr_numa_get_vcpu_assoc(spapr, cpu);
 
     /* Advertise NUMA via ibm,associativity */
-    return fdt_setprop(fdt, offset, "ibm,associativity",
-                       vcpu_assoc, sizeof(vcpu_assoc));
+    return fdt_setprop(fdt, offset, "ibm,associativity", vcpu_assoc,
+                       VCPU_ASSOC_SIZE * sizeof(uint32_t));
 }
 
 
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 9a63380801..e50a2672e3 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -107,13 +107,18 @@ typedef enum {
 
 /*
  * NUMA related macros. MAX_DISTANCE_REF_POINTS was taken
- * from Taken from Linux kernel arch/powerpc/mm/numa.h.
+ * from Linux kernel arch/powerpc/mm/numa.h. It represents the
+ * amount of associativity domains for non-CPU resources.
  *
  * NUMA_ASSOC_SIZE is the base array size of an ibm,associativity
  * array for any non-CPU resource.
+ *
+ * VCPU_ASSOC_SIZE represents the size of ibm,associativity array
+ * for CPUs, which has an extra element (vcpu_id) in the end.
  */
 #define MAX_DISTANCE_REF_POINTS    4
 #define NUMA_ASSOC_SIZE            (MAX_DISTANCE_REF_POINTS + 1)
+#define VCPU_ASSOC_SIZE            (NUMA_ASSOC_SIZE + 1)
 
 typedef struct SpaprCapabilities SpaprCapabilities;
 struct SpaprCapabilities {
-- 
2.26.2


