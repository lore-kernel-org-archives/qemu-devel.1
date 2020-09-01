Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1525DC433E6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 13:01:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFD6F206EB
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 13:01:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qCRO+HCz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFD6F206EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43528 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD5us-0008RM-Uk
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 09:01:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36424)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1kD5qW-0001X3-BF; Tue, 01 Sep 2020 08:57:08 -0400
Received: from mail-qk1-x744.google.com ([2607:f8b0:4864:20::744]:36327)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1kD5qQ-0002mj-ON; Tue, 01 Sep 2020 08:57:08 -0400
Received: by mail-qk1-x744.google.com with SMTP id f2so779330qkh.3;
 Tue, 01 Sep 2020 05:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=fmYFoJEOIU4mP5jnAooDQQH/NJrDz9DrWxhjpnPtt1Q=;
 b=qCRO+HCzWdheAic9XZckzuR4cCeHmdLQ1HZva5Jb1PhdKK/ABydDPLRjcrnOm8wrHc
 tkYPQ63aMCB0e1oB5i3gCg/erT+IWCE8wQJjyKSx2vj1PHOHuQBhe/tpv6JwvEDAKUFo
 1gZyERxV2enVnK1rAojbj2n2QoMhuwFeVAQe/aFtrpmeRScxskFeDkV0ovBorNL2mx94
 4oXK2U/mF3rEdKYsM4GzWA+Fi2y0HKJtjUfq/lYfAQIn1Uzu2DduHT6JRacDIJWmModW
 jM8ttuSv8alXvlXQOn930VfvRv/8o19XFBfY+95uRgNja2Hi2onDOW1bwJkBpdn4K44O
 +U7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=fmYFoJEOIU4mP5jnAooDQQH/NJrDz9DrWxhjpnPtt1Q=;
 b=ImlUHhxz/aYFt+wtpRgL6YZ7XZBGy4IUGBt2QyGIou9omXnEGY58eVedNlzpgXJnUG
 4hRgYdvOzzA8HO1fsp3QYq2oAxoErYUS5h8a1PGMUcy9hounRSCp48+DVXwM8nkWTELu
 FtDqqwlByVzj+GYgNUXmyIx4dZb8NlpZRZqVps6yawDLuy9lQ89skfESba9TdAISkADh
 LREpFUmPqH/P86dchIviGEo35q4/8IIONU7u9BVr5V965guFb7Y5MXne/tflhhcnnv6B
 299vsTSvwr4mhMcFdpwocY/qcKPfI2RWg3+bt4zGdB0uJhIcgey8MWI7I34VYXc8pQlk
 L30A==
X-Gm-Message-State: AOAM530RO/dZvX10qYXpFwT0I4AlBZf8KPAOuncHuxvlDOQz2J7eKxue
 K12XZVCJ9wAXMPBgVDSGdUAecafhK4ARIg==
X-Google-Smtp-Source: ABdhPJxmzNZVWVJZM+eKDgQ1h7lhCQnQpzJAYsYHmcbFjcrxTM3CEQwWCnAI4RCEKRsLhUk5tC/rNQ==
X-Received: by 2002:a37:a602:: with SMTP id p2mr1747878qke.254.1598965021337; 
 Tue, 01 Sep 2020 05:57:01 -0700 (PDT)
Received: from rekt.ibmuc.com ([2804:431:c7c7:6be:f6e3:c671:cefe:b943])
 by smtp.gmail.com with ESMTPSA id q7sm1430164qkf.35.2020.09.01.05.56.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2020 05:57:00 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 4/7] spapr, spapr_numa: handle vcpu ibm,associativity
Date: Tue,  1 Sep 2020 09:56:42 -0300
Message-Id: <20200901125645.118026-5-danielhb413@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200901125645.118026-1-danielhb413@gmail.com>
References: <20200901125645.118026-1-danielhb413@gmail.com>
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

Vcpus have an additional paramenter to be appended, vcpu_id. This
also changes the size of the of property itself, which is being
represented in index 0 of numa_assoc_array[cpu->node_id],
and defaults to MAX_DISTANCE_REF_POINTS for all cases but
vcpus.

All this logic makes more sense in spapr_numa.c, where we handle
everything NUMA and associativity. A new helper spapr_numa_fixup_cpu_dt()
was added, and spapr.c uses it the same way as it was using the former
spapr_fixup_cpu_numa_dt().

Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 hw/ppc/spapr.c              | 17 +----------------
 hw/ppc/spapr_numa.c         | 28 ++++++++++++++++++++++++++++
 include/hw/ppc/spapr_numa.h |  2 ++
 3 files changed, 31 insertions(+), 16 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index fb9b2572fe..172f965fe0 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -202,21 +202,6 @@ static int spapr_fixup_cpu_smt_dt(void *fdt, int offset, PowerPCCPU *cpu,
     return ret;
 }
 
-static int spapr_fixup_cpu_numa_dt(void *fdt, int offset, PowerPCCPU *cpu)
-{
-    int index = spapr_get_vcpu_id(cpu);
-    uint32_t associativity[] = {cpu_to_be32(0x5),
-                                cpu_to_be32(0x0),
-                                cpu_to_be32(0x0),
-                                cpu_to_be32(0x0),
-                                cpu_to_be32(cpu->node_id),
-                                cpu_to_be32(index)};
-
-    /* Advertise NUMA via ibm,associativity */
-    return fdt_setprop(fdt, offset, "ibm,associativity", associativity,
-                          sizeof(associativity));
-}
-
 static void spapr_dt_pa_features(SpaprMachineState *spapr,
                                  PowerPCCPU *cpu,
                                  void *fdt, int offset)
@@ -785,7 +770,7 @@ static void spapr_dt_cpu(CPUState *cs, void *fdt, int offset,
                       pft_size_prop, sizeof(pft_size_prop))));
 
     if (ms->numa_state->num_nodes > 1) {
-        _FDT(spapr_fixup_cpu_numa_dt(fdt, offset, cpu));
+        _FDT(spapr_numa_fixup_cpu_dt(spapr, fdt, offset, cpu));
     }
 
     _FDT(spapr_fixup_cpu_smt_dt(fdt, offset, cpu, compat_smt));
diff --git a/hw/ppc/spapr_numa.c b/hw/ppc/spapr_numa.c
index 2cfe13eaed..b8882d209e 100644
--- a/hw/ppc/spapr_numa.c
+++ b/hw/ppc/spapr_numa.c
@@ -47,6 +47,34 @@ void spapr_numa_write_associativity_dt(SpaprMachineState *spapr, void *fdt,
                       sizeof(smc->numa_assoc_array[nodeid]))));
 }
 
+int spapr_numa_fixup_cpu_dt(SpaprMachineState *spapr, void *fdt,
+                            int offset, PowerPCCPU *cpu)
+{
+    SpaprMachineClass *smc = SPAPR_MACHINE_GET_CLASS(spapr);
+    uint vcpu_assoc_size = NUMA_ASSOC_SIZE + 1;
+    uint32_t vcpu_assoc[vcpu_assoc_size];
+    int index = spapr_get_vcpu_id(cpu);
+    int i;
+
+    /*
+     * VCPUs have an extra 'cpu_id' value in ibm,associativity
+     * compared to other resources. Increment the size at index
+     * 0, copy all associativity domains already set, then put
+     * cpu_id last.
+     */
+    vcpu_assoc[0] = cpu_to_be32(MAX_DISTANCE_REF_POINTS + 1);
+
+    for (i = 1; i <= MAX_DISTANCE_REF_POINTS; i++) {
+        vcpu_assoc[i] = smc->numa_assoc_array[cpu->node_id][i];
+    }
+
+    vcpu_assoc[vcpu_assoc_size - 1] = cpu_to_be32(index);
+
+    /* Advertise NUMA via ibm,associativity */
+    return fdt_setprop(fdt, offset, "ibm,associativity",
+                       vcpu_assoc, sizeof(vcpu_assoc));
+}
+
 /*
  * Helper that writes ibm,associativity-reference-points and
  * max-associativity-domains in the RTAS pointed by @rtas
diff --git a/include/hw/ppc/spapr_numa.h b/include/hw/ppc/spapr_numa.h
index 2625e3db67..f92fb4f28a 100644
--- a/include/hw/ppc/spapr_numa.h
+++ b/include/hw/ppc/spapr_numa.h
@@ -20,6 +20,8 @@ void spapr_numa_associativity_init(MachineState *machine);
 void spapr_numa_write_rtas_dt(SpaprMachineState *spapr, void *fdt, int rtas);
 void spapr_numa_write_associativity_dt(SpaprMachineState *spapr, void *fdt,
                                        int offset, int nodeid);
+int spapr_numa_fixup_cpu_dt(SpaprMachineState *spapr, void *fdt,
+                            int offset, PowerPCCPU *cpu);
 
 
 #endif /* HW_SPAPR_NUMA_H */
-- 
2.26.2


