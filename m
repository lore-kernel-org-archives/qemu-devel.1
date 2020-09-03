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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D6E3C433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 22:09:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C5E820722
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 22:09:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OvgCv+mf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C5E820722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58908 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDxQ0-00026J-DB
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 18:09:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45028)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1kDxNg-0006IX-4B; Thu, 03 Sep 2020 18:06:57 -0400
Received: from mail-qt1-x842.google.com ([2607:f8b0:4864:20::842]:39747)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1kDxNe-0007RO-AK; Thu, 03 Sep 2020 18:06:55 -0400
Received: by mail-qt1-x842.google.com with SMTP id 92so3194987qtb.6;
 Thu, 03 Sep 2020 15:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=mwvH00LlvAqHSvHjVx15zL8Ar9OIaFAfTOZGCWwV8uo=;
 b=OvgCv+mfFhWXhaIF9ZyTWN8GqzrDVNUXZqrq/amP0jAZY+UDqXIw0I72MsiEuJmtvR
 uazHfwSLdkmNoqzMJa11M0vy5fX+w6lkBxMzliwkw95idgurxWCc08cSqJIuvugk4xLX
 OecoJlENXWNRYeJ3bi7Zm5QSGTytuYe/q+gBZoO93DOc1ryw6I9MpNt4PdwkVK85khU3
 hgyMn4/Lq0LZKSInpKUerIMMQ1QoZIxDTmNobOeGhktmAJRcCB5LrBJMlkY8YhHmENOZ
 KBji2/D4TrwUqeUhngfve42DyPNqau/0pGN5h70KqO82SFvC+ampr6arkY6W7EHt6cy5
 vUlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=mwvH00LlvAqHSvHjVx15zL8Ar9OIaFAfTOZGCWwV8uo=;
 b=EJwb5d3fN9EEe75FJTAO/iQT9tsbJQ2A3TBV+2WPsC7DuEI8+0Vq66mYlVXY7ik2qQ
 0A5a5t5FEI8dI1L1kQDXQYp+QPICeFEmMgfVdbpdP6lHbk0K7yCGLK2urSX8Kp8Mo1OT
 xhcGeZv3psp2sUeRUcGIYQJXIFMqgATBtXKc91s12a43RML+1JzwX8may8sTBtnFKLBV
 v6w8Nd3LsGVS4FKtMGGXbW0sKNxL8cm1jXm/jSn11SDSg9xzQmPV03ZPblhNXqbKXKJ4
 7WmkC8GsGyio1/IJOq0ajV0+7geBcCnXI5p3ZzIKpZaVsoPZN3DtakCufPFcjiZtGq2Q
 uniQ==
X-Gm-Message-State: AOAM5314BrbUoxRXEWQPLRTjikOx/lyY7fqpsuK7O2ij04SuEdcX0eEt
 tjiyJYZVrclNDMdi+DpfAoEYdH9Wn4OJmg==
X-Google-Smtp-Source: ABdhPJy6kng+9K4VILrM0jDC/ESJ7uwdaZd23Uvt7Qbx+GfiZ16L50jPEbsbDg1NIFz//0jzXCGBcA==
X-Received: by 2002:ac8:2612:: with SMTP id u18mr5952963qtu.363.1599170812740; 
 Thu, 03 Sep 2020 15:06:52 -0700 (PDT)
Received: from rekt.ibmuc.com ([2804:431:c7c6:1dc:ffbd:d3fb:97ff:aaca])
 by smtp.gmail.com with ESMTPSA id j1sm1798757qtk.91.2020.09.03.15.06.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2020 15:06:52 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 2/7] spapr, spapr_numa: handle vcpu ibm,associativity
Date: Thu,  3 Sep 2020 19:06:34 -0300
Message-Id: <20200903220639.563090-3-danielhb413@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200903220639.563090-1-danielhb413@gmail.com>
References: <20200903220639.563090-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::842;
 envelope-from=danielhb413@gmail.com; helo=mail-qt1-x842.google.com
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
 hw/ppc/spapr_numa.c         | 27 +++++++++++++++++++++++++++
 include/hw/ppc/spapr_numa.h |  2 ++
 3 files changed, 30 insertions(+), 16 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 1ad6f59863..badfa86319 100644
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
index f6b6fe648f..1a1ec8bcff 100644
--- a/hw/ppc/spapr_numa.c
+++ b/hw/ppc/spapr_numa.c
@@ -45,6 +45,33 @@ void spapr_numa_write_associativity_dt(SpaprMachineState *spapr, void *fdt,
                       sizeof(spapr->numa_assoc_array[nodeid]))));
 }
 
+int spapr_numa_fixup_cpu_dt(SpaprMachineState *spapr, void *fdt,
+                            int offset, PowerPCCPU *cpu)
+{
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
+        vcpu_assoc[i] = spapr->numa_assoc_array[cpu->node_id][i];
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
index a2a4df55f7..43c6a16fe3 100644
--- a/include/hw/ppc/spapr_numa.h
+++ b/include/hw/ppc/spapr_numa.h
@@ -27,5 +27,7 @@ void spapr_numa_associativity_init(SpaprMachineState *spapr,
 void spapr_numa_write_rtas_dt(SpaprMachineState *spapr, void *fdt, int rtas);
 void spapr_numa_write_associativity_dt(SpaprMachineState *spapr, void *fdt,
                                        int offset, int nodeid);
+int spapr_numa_fixup_cpu_dt(SpaprMachineState *spapr, void *fdt,
+                            int offset, PowerPCCPU *cpu);
 
 #endif /* HW_SPAPR_NUMA_H */
-- 
2.26.2


