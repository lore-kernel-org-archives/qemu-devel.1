Return-Path: <SRS0=PlQC=BZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA3FDC433E1
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2020 15:50:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2826820656
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2020 15:50:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bP7Vs9w0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2826820656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59768 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6yRs-0005rW-CL
	for qemu-devel@archiver.kernel.org; Sat, 15 Aug 2020 11:50:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48726)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1k6yQG-0004pz-CW; Sat, 15 Aug 2020 11:48:44 -0400
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43]:40550)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1k6yQE-0007kD-JJ; Sat, 15 Aug 2020 11:48:44 -0400
Received: by mail-io1-xd43.google.com with SMTP id b17so13561949ion.7;
 Sat, 15 Aug 2020 08:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ZLdHTMCooza0md3IdUNjy83s0br5pKO42KABfoYHIJQ=;
 b=bP7Vs9w0Xpg0KGET5jaVFAgeC+i6JUKyygQRES20KGUnseHHT7EUpQaXN+UmnzHPJc
 TcTgUjvDaU3CpuVMWGzhlthaRqCkROdOSksOy7ULfGX0qGiQ7rxSLKe1bB4MrQ24ss96
 rwAQCI4x37BYjwbr+92LWS6BxLcmlcQYL9qPLVk3VD7Vww5HUJdZUxNyFX5YvUtyI0WG
 A7uS3cRBTahHDjZtqRvmO81hptFHdOtCT2B8tJaGRvosEK4SvRRZecIz/BK6v5MqGloj
 KvdbjSCNsSzJivrfUBE6GiFG2u/+3Wz7WMXzhWt36P8REiwC507+hPCnW5oMTO27jq7/
 E0bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ZLdHTMCooza0md3IdUNjy83s0br5pKO42KABfoYHIJQ=;
 b=P8QqpwUsBhgRBdugzwFrUvzpV/ltOXRK03CrsNPmgY/q8PpugosZM+tiIl7ZdOwDJ6
 dN1Ae+8rqQSQvvIux3w5sktz1ZgjeClRWAu3LNTz84N7rp8FAcQILPkwbdNgOMQGZzcz
 aQIDuM61ScEysrzlPfhUdMTWbVZSazrEUieNF/N9Dokmd91JDWlzXuD80hnzv3aAKf/B
 jh2C1d7pUmnKnyhF6CAnplN7vIJv/b7h8rYme5XLGev5TuLrwR4smWztKblKl9NaxeJk
 UnRlVDGHRJJcBm1k4tzXnnpu5HjP3+FzsI/2mGH0JA5ZuQgglci8lSiY8a4WrT730ynb
 VW7g==
X-Gm-Message-State: AOAM533FRSfS68vv38gX46X9EtlDcocmgf+6yh0CacCRT70vR/Ls5Esr
 K4nqUVFpAgqfTicVcyoXc+DmcPVj/67THA==
X-Google-Smtp-Source: ABdhPJybTH1B98PkxJgVRQWTVm3cj2/0Byw1MK3GG0zEVdYHSlO9ZqOzuiOKil9bUaU57HDjdynQjA==
X-Received: by 2002:a05:620a:789:: with SMTP id
 9mr3614349qka.199.1597438489554; 
 Fri, 14 Aug 2020 13:54:49 -0700 (PDT)
Received: from rekt.ibmuc.com ([2804:431:c7c6:303f:d1dc:35d8:e9f6:c8b])
 by smtp.gmail.com with ESMTPSA id p33sm12301018qtp.49.2020.08.14.13.54.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2020 13:54:49 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 07/10] spapr: create helper to set ibm,associativity
Date: Fri, 14 Aug 2020 17:54:21 -0300
Message-Id: <20200814205424.543857-8-danielhb413@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200814205424.543857-1-danielhb413@gmail.com>
References: <20200814205424.543857-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::d43;
 envelope-from=danielhb413@gmail.com; helo=mail-io1-xd43.google.com
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

We have several places around hw/ppc files where we use the
same code to set the ibm,associativity array. This patch
creates a helper called spapr_set_associativity() to do
that in a single place. It'll also make it saner to change
the value of ibm,associativity in the next patches.

After this patch, only 2 places are left with open code
ibm,associativity assignment:

- spapr_dt_dynamic_reconfiguration_memory()
- h_home_node_associativity() in spapr_hcall.c

The update of associativity values will be made in these places
manually later on.

Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 hw/ppc/spapr.c         | 32 +++++++++++++++++++++-----------
 hw/ppc/spapr_nvdimm.c  |  8 +++-----
 hw/ppc/spapr_pci.c     |  8 +++-----
 include/hw/ppc/spapr.h |  1 +
 4 files changed, 28 insertions(+), 21 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index bc51d2db90..b80a6f6936 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -201,15 +201,27 @@ static int spapr_fixup_cpu_smt_dt(void *fdt, int offset, PowerPCCPU *cpu,
     return ret;
 }
 
+void spapr_set_associativity(uint32_t *assoc, int node_id, int cpu_index)
+{
+    uint8_t assoc_size = 0x4;
+
+    if (cpu_index >= 0) {
+        assoc_size = 0x5;
+        assoc[5] = cpu_to_be32(cpu_index);
+    }
+
+    assoc[0] = cpu_to_be32(assoc_size);
+    assoc[1] = cpu_to_be32(0x0);
+    assoc[2] = cpu_to_be32(0x0);
+    assoc[3] = cpu_to_be32(0x0);
+    assoc[4] = cpu_to_be32(node_id);
+}
+
 static int spapr_fixup_cpu_numa_dt(void *fdt, int offset, PowerPCCPU *cpu)
 {
     int index = spapr_get_vcpu_id(cpu);
-    uint32_t associativity[] = {cpu_to_be32(0x5),
-                                cpu_to_be32(0x0),
-                                cpu_to_be32(0x0),
-                                cpu_to_be32(0x0),
-                                cpu_to_be32(cpu->node_id),
-                                cpu_to_be32(index)};
+    uint32_t associativity[6];
+    spapr_set_associativity(associativity, cpu->node_id, index);
 
     /* Advertise NUMA via ibm,associativity */
     return fdt_setprop(fdt, offset, "ibm,associativity", associativity,
@@ -325,15 +337,13 @@ static void add_str(GString *s, const gchar *s1)
 static int spapr_dt_memory_node(void *fdt, int nodeid, hwaddr start,
                                 hwaddr size)
 {
-    uint32_t associativity[] = {
-        cpu_to_be32(0x4), /* length */
-        cpu_to_be32(0x0), cpu_to_be32(0x0),
-        cpu_to_be32(0x0), cpu_to_be32(nodeid)
-    };
+    uint32_t associativity[5];
     char mem_name[32];
     uint64_t mem_reg_property[2];
     int off;
 
+    spapr_set_associativity(associativity, nodeid, -1);
+
     mem_reg_property[0] = cpu_to_be64(start);
     mem_reg_property[1] = cpu_to_be64(size);
 
diff --git a/hw/ppc/spapr_nvdimm.c b/hw/ppc/spapr_nvdimm.c
index 81410aa63f..bd109bfc00 100644
--- a/hw/ppc/spapr_nvdimm.c
+++ b/hw/ppc/spapr_nvdimm.c
@@ -115,15 +115,13 @@ int spapr_dt_nvdimm(void *fdt, int parent_offset,
                                              &error_abort);
     uint64_t slot = object_property_get_uint(OBJECT(nvdimm), PC_DIMM_SLOT_PROP,
                                              &error_abort);
-    uint32_t associativity[] = {
-        cpu_to_be32(0x4), /* length */
-        cpu_to_be32(0x0), cpu_to_be32(0x0),
-        cpu_to_be32(0x0), cpu_to_be32(node)
-    };
+    uint32_t associativity[5];
     uint64_t lsize = nvdimm->label_size;
     uint64_t size = object_property_get_int(OBJECT(nvdimm), PC_DIMM_SIZE_PROP,
                                             NULL);
 
+    spapr_set_associativity(associativity, node, -1);
+
     drc = spapr_drc_by_id(TYPE_SPAPR_DRC_PMEM, slot);
     g_assert(drc);
 
diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 09ac58fd7f..c02ace226c 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -2321,11 +2321,8 @@ int spapr_dt_phb(SpaprMachineState *spapr, SpaprPhbState *phb,
         cpu_to_be32(1),
         cpu_to_be32(RTAS_IBM_RESET_PE_DMA_WINDOW)
     };
-    uint32_t associativity[] = {cpu_to_be32(0x4),
-                                cpu_to_be32(0x0),
-                                cpu_to_be32(0x0),
-                                cpu_to_be32(0x0),
-                                cpu_to_be32(phb->numa_node)};
+    uint32_t associativity[5];
+
     SpaprTceTable *tcet;
     SpaprDrc *drc;
     Error *err = NULL;
@@ -2358,6 +2355,7 @@ int spapr_dt_phb(SpaprMachineState *spapr, SpaprPhbState *phb,
 
     /* Advertise NUMA via ibm,associativity */
     if (phb->numa_node != -1) {
+        spapr_set_associativity(associativity, phb->numa_node, -1);
         _FDT(fdt_setprop(fdt, bus_off, "ibm,associativity", associativity,
                          sizeof(associativity)));
     }
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index d9f1afa8b2..cd158bf95a 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -863,6 +863,7 @@ int spapr_phb_dt_populate(SpaprDrc *drc, SpaprMachineState *spapr,
 
 void spapr_rtc_read(SpaprRtcState *rtc, struct tm *tm, uint32_t *ns);
 int spapr_rtc_import_offset(SpaprRtcState *rtc, int64_t legacy_offset);
+void spapr_set_associativity(uint32_t *assoc, int node_id, int cpu_index);
 
 #define TYPE_SPAPR_RNG "spapr-rng"
 
-- 
2.26.2


