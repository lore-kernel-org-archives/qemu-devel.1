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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73F5CC433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 22:21:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3295620716
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 22:21:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G0OVBXWg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3295620716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33312 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDxbr-0006Za-7m
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 18:21:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45072)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1kDxNj-0006Kn-MM; Thu, 03 Sep 2020 18:07:00 -0400
Received: from mail-qt1-x842.google.com ([2607:f8b0:4864:20::842]:42514)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1kDxNf-0007Ri-Tm; Thu, 03 Sep 2020 18:06:59 -0400
Received: by mail-qt1-x842.google.com with SMTP id 60so3175829qtc.9;
 Thu, 03 Sep 2020 15:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=nAIWifC+pb4N38iKkEPwaKDP1cXqlraF9U9iDbNdAqM=;
 b=G0OVBXWgMZFjFHo0IyBrZjMbmwWWuXJlo/layXbmsBS+andsr4Txv9O9+rrbNKijT8
 T43vUhqC4qNYr2TXdMIUez77KMEHTwVrEFRTWjmLy0KRQbXa2uvJC5xrtHTjuAHucfkq
 9ZmfCM4ZI3qnr03LnjiEiPia6UbggAdcdrwXWb5gH7lnki31xEtFbWU5+mJ4/IX9l/O5
 VykwwaSXtWf1UDYEd136WZ/OCc9OQwCgjSnBjJEiN3WXyulGFE992jmhTtOmK+4hJld8
 dKFn8TWpPwu5jcqdwnFOE9LxzjxKzZ4+xWkbV+7BUVD9yS9Gz17u//Yhw3ZOQW4+93OA
 U0+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=nAIWifC+pb4N38iKkEPwaKDP1cXqlraF9U9iDbNdAqM=;
 b=UUJbQneniZ+1Xs3If2lQR5rJVBuwLTmLnUBewPJOAHSb3s0oQk/l+BEI0pkn50XIQD
 OYQ9kRzdOAMMEBl0tFauy8f19DplTCDf/XbcHpx0E/8yaOW10Ud9fOgZ0p75ijpcQFHK
 CpGZ/OIbeuIRR9ShB8uKv6xqbD6KqKflwD5B0dJbNmxzAaH7owiqrGSJckpVbCKj6Y6S
 hpIc8QAGMX6kFYZ5zSruKj7R5O+Ljx2nGekCmLqj4PRr40ORm6Tptl3lrLpsOsjVB2Ip
 zoeqh7YAtWJdbCKWJXaVcZPdx0ZF90TYkgiA7XJgbPquslfrPfHrSTzv48N8b39wKaXd
 6hEQ==
X-Gm-Message-State: AOAM530WV2zp9KKvBwjkEafVVVdWbsmGDufTww/TSZoBgBMYQIYisqHL
 DIL5bInp0QxQY9/6CIKUEgz3uHzQGoP/Jw==
X-Google-Smtp-Source: ABdhPJyeEovHg6+5ZkFJHkYgb1Yx6QE0fA2gHOcegYn6zFHwfHJ+6GZGCdvlLXjwnfgS+7gWopXxwQ==
X-Received: by 2002:ac8:72d3:: with SMTP id o19mr5741226qtp.190.1599170814327; 
 Thu, 03 Sep 2020 15:06:54 -0700 (PDT)
Received: from rekt.ibmuc.com ([2804:431:c7c6:1dc:ffbd:d3fb:97ff:aaca])
 by smtp.gmail.com with ESMTPSA id j1sm1798757qtk.91.2020.09.03.15.06.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2020 15:06:53 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 3/7] spapr,
 spapr_numa: move lookup-arrays handling to spapr_numa.c
Date: Thu,  3 Sep 2020 19:06:35 -0300
Message-Id: <20200903220639.563090-4-danielhb413@gmail.com>
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

In a similar fashion as the previous patch, let's move the
handling of ibm,associativity-lookup-arrays from spapr.c to
spapr_numa.c. A spapr_numa_write_assoc_lookup_arrays() helper was
created, and spapr_dt_dynamic_reconfiguration_memory() can now
use it to advertise the lookup-arrays.

Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 hw/ppc/spapr.c              | 25 ++-----------------------
 hw/ppc/spapr_numa.c         | 34 ++++++++++++++++++++++++++++++++++
 include/hw/ppc/spapr_numa.h |  2 ++
 3 files changed, 38 insertions(+), 23 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index badfa86319..9bce1892b5 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -535,13 +535,10 @@ static int spapr_dt_dynamic_reconfiguration_memory(SpaprMachineState *spapr,
                                                    void *fdt)
 {
     MachineState *machine = MACHINE(spapr);
-    int nb_numa_nodes = machine->numa_state->num_nodes;
-    int ret, i, offset;
+    int ret, offset;
     uint64_t lmb_size = SPAPR_MEMORY_BLOCK_SIZE;
     uint32_t prop_lmb_size[] = {cpu_to_be32(lmb_size >> 32),
                                 cpu_to_be32(lmb_size & 0xffffffff)};
-    uint32_t *int_buf, *cur_index, buf_len;
-    int nr_nodes = nb_numa_nodes ? nb_numa_nodes : 1;
     MemoryDeviceInfoList *dimms = NULL;
 
     /*
@@ -582,25 +579,7 @@ static int spapr_dt_dynamic_reconfiguration_memory(SpaprMachineState *spapr,
         return ret;
     }
 
-    /* ibm,associativity-lookup-arrays */
-    buf_len = (nr_nodes * 4 + 2) * sizeof(uint32_t);
-    cur_index = int_buf = g_malloc0(buf_len);
-    int_buf[0] = cpu_to_be32(nr_nodes);
-    int_buf[1] = cpu_to_be32(4); /* Number of entries per associativity list */
-    cur_index += 2;
-    for (i = 0; i < nr_nodes; i++) {
-        uint32_t associativity[] = {
-            cpu_to_be32(0x0),
-            cpu_to_be32(0x0),
-            cpu_to_be32(0x0),
-            cpu_to_be32(i)
-        };
-        memcpy(cur_index, associativity, sizeof(associativity));
-        cur_index += 4;
-    }
-    ret = fdt_setprop(fdt, offset, "ibm,associativity-lookup-arrays", int_buf,
-            (cur_index - int_buf) * sizeof(uint32_t));
-    g_free(int_buf);
+    ret = spapr_numa_write_assoc_lookup_arrays(spapr, fdt, offset);
 
     return ret;
 }
diff --git a/hw/ppc/spapr_numa.c b/hw/ppc/spapr_numa.c
index 1a1ec8bcff..5a82a84438 100644
--- a/hw/ppc/spapr_numa.c
+++ b/hw/ppc/spapr_numa.c
@@ -72,6 +72,40 @@ int spapr_numa_fixup_cpu_dt(SpaprMachineState *spapr, void *fdt,
                        vcpu_assoc, sizeof(vcpu_assoc));
 }
 
+
+int spapr_numa_write_assoc_lookup_arrays(SpaprMachineState *spapr, void *fdt,
+                                         int offset)
+{
+    MachineState *machine = MACHINE(spapr);
+    int nb_numa_nodes = machine->numa_state->num_nodes;
+    int nr_nodes = nb_numa_nodes ? nb_numa_nodes : 1;
+    uint32_t *int_buf, *cur_index, buf_len;
+    int ret, i;
+
+    /* ibm,associativity-lookup-arrays */
+    buf_len = (nr_nodes * MAX_DISTANCE_REF_POINTS + 2) * sizeof(uint32_t);
+    cur_index = int_buf = g_malloc0(buf_len);
+    int_buf[0] = cpu_to_be32(nr_nodes);
+     /* Number of entries per associativity list */
+    int_buf[1] = cpu_to_be32(MAX_DISTANCE_REF_POINTS);
+    cur_index += 2;
+    for (i = 0; i < nr_nodes; i++) {
+        /*
+         * For the lookup-array we use the ibm,associativity array,
+         * from numa_assoc_array. without the first element (size).
+         */
+        uint32_t *associativity = spapr->numa_assoc_array[i];
+        memcpy(cur_index, ++associativity,
+               sizeof(uint32_t) * MAX_DISTANCE_REF_POINTS);
+        cur_index += MAX_DISTANCE_REF_POINTS;
+    }
+    ret = fdt_setprop(fdt, offset, "ibm,associativity-lookup-arrays", int_buf,
+                      (cur_index - int_buf) * sizeof(uint32_t));
+    g_free(int_buf);
+
+    return ret;
+}
+
 /*
  * Helper that writes ibm,associativity-reference-points and
  * max-associativity-domains in the RTAS pointed by @rtas
diff --git a/include/hw/ppc/spapr_numa.h b/include/hw/ppc/spapr_numa.h
index 43c6a16fe3..b3fd950634 100644
--- a/include/hw/ppc/spapr_numa.h
+++ b/include/hw/ppc/spapr_numa.h
@@ -29,5 +29,7 @@ void spapr_numa_write_associativity_dt(SpaprMachineState *spapr, void *fdt,
                                        int offset, int nodeid);
 int spapr_numa_fixup_cpu_dt(SpaprMachineState *spapr, void *fdt,
                             int offset, PowerPCCPU *cpu);
+int spapr_numa_write_assoc_lookup_arrays(SpaprMachineState *spapr, void *fdt,
+                                         int offset);
 
 #endif /* HW_SPAPR_NUMA_H */
-- 
2.26.2


