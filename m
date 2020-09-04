Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAC87C433E2
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 18:31:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E033204EC
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 18:31:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DF5QkE/G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E033204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39856 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEFSs-0006pC-KL
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 13:25:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49636)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1kEFS4-0005Xf-DJ; Fri, 04 Sep 2020 13:24:40 -0400
Received: from mail-qk1-x741.google.com ([2607:f8b0:4864:20::741]:36321)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1kEFS2-0005DD-KZ; Fri, 04 Sep 2020 13:24:40 -0400
Received: by mail-qk1-x741.google.com with SMTP id f2so7043348qkh.3;
 Fri, 04 Sep 2020 10:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=7QLFzSnvMKavTsEqY+8UYuNGsBaZ2S7VcOLmTGXn2BU=;
 b=DF5QkE/GtDfzJLu8985VzRA+Swl8+PsODQPxNXzOqvYOYr9xn+RYfS9B/mR83rf0bf
 7vHAlYsig7RTqwBlAv/Dxc/KoIehiVCYIg4ziaEGISst3TjeYhq7jvPEfIxe2c2v6E75
 Cnb+8Nn9Chi00g5zgHzAoju5we45J+BX7tFOFC2RYsuLMVsm+71PW1Jh5rwtzOeyMwq/
 yJicaTCMVAYSc+WCFjCQnf5rT+vUBEim7yc4MTW++627pRIeVtevGUHLcatZfCGleFBD
 Q73IYMhKx1JZC64LBlan7dMgVFOV1ZAV+tTFKF9tBVelzxlD9kxdUyvzmMGRmA68N/xO
 zdOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=7QLFzSnvMKavTsEqY+8UYuNGsBaZ2S7VcOLmTGXn2BU=;
 b=CS21tITIJfGtxnh1ffAC0231++wMinAAlNE85KLe4R7Ekje69I6W3VnztLXXpygID6
 4Oh01IDUwFlsRtk9v9yPT4jXqQM331h4AIPQZLIvBpIJ/ktwmhrYkD3UPrIAdAETDndq
 lHcse6YbE6WHGTPr0XfdJCtswlMvadOBFInH2fumQMuIrvUQJ1MIOGjjhjd3nLC6h1oa
 0QuMtx0Z1W6w+DXG+93s9OMyQZTUxLIMqUe2EUNbgSNkg0lGbaoFDd8ZakGwg/cAUDUv
 lNCjysiYpXIxInX/cuhUOJ+8/xyG8xFGkb13XoVvAEQQcD9LNRGI26UliwP5lKHrdHOZ
 8ixg==
X-Gm-Message-State: AOAM533TWSLJjgytnveeadZhZIl4pqpvLzdwhQ0g7YTQ+jCw9RJFdANf
 Sz3/iQvlSXBvrf0i1u7OY6TTuCNTuy8=
X-Google-Smtp-Source: ABdhPJw+2wPT5mzC1MjLnzj/lHPnm7e8BMXsWTJ9GaMJJ8hBANNGUqTY1KvOoqOC38YAs2ZAXLG/Ew==
X-Received: by 2002:a37:9e81:: with SMTP id h123mr8257861qke.117.1599240277194; 
 Fri, 04 Sep 2020 10:24:37 -0700 (PDT)
Received: from rekt.ibmuc.com ([2804:431:c7c6:1dc:ffbd:d3fb:97ff:aaca])
 by smtp.gmail.com with ESMTPSA id s192sm3269245qke.50.2020.09.04.10.24.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2020 10:24:36 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 2/3] spapr_numa: create a vcpu associativity helper
Date: Fri,  4 Sep 2020 14:24:21 -0300
Message-Id: <20200904172422.617460-3-danielhb413@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200904172422.617460-1-danielhb413@gmail.com>
References: <20200904172422.617460-1-danielhb413@gmail.com>
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

Reviewed-by: Greg Kurz <groug@kaod.org>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 hw/ppc/spapr_numa.c    | 31 ++++++++++++++++++-------------
 include/hw/ppc/spapr.h |  7 ++++++-
 2 files changed, 24 insertions(+), 14 deletions(-)

diff --git a/hw/ppc/spapr_numa.c b/hw/ppc/spapr_numa.c
index 368c1a494d..066ffc2a5f 100644
--- a/hw/ppc/spapr_numa.c
+++ b/hw/ppc/spapr_numa.c
@@ -71,31 +71,36 @@ void spapr_numa_write_associativity_dt(SpaprMachineState *spapr, void *fdt,
                       sizeof(spapr->numa_assoc_array[nodeid]))));
 }
 
-int spapr_numa_fixup_cpu_dt(SpaprMachineState *spapr, void *fdt,
-                            int offset, PowerPCCPU *cpu)
+static uint32_t *spapr_numa_get_vcpu_assoc(SpaprMachineState *spapr,
+                                           PowerPCCPU *cpu)
 {
-    uint vcpu_assoc_size = NUMA_ASSOC_SIZE + 1;
-    uint32_t vcpu_assoc[vcpu_assoc_size];
+    uint32_t *vcpu_assoc = g_new(uint32_t, VCPU_ASSOC_SIZE);
     int index = spapr_get_vcpu_id(cpu);
-    int i;
 
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


