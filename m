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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C7A9C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 12:58:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6211C206CD
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 12:58:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J7sc2BeZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6211C206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59112 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD5rb-0003Dr-Hq
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 08:58:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36390)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1kD5qU-0001RX-A8; Tue, 01 Sep 2020 08:57:06 -0400
Received: from mail-qt1-x843.google.com ([2607:f8b0:4864:20::843]:46137)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1kD5qS-0002my-Fm; Tue, 01 Sep 2020 08:57:05 -0400
Received: by mail-qt1-x843.google.com with SMTP id b3so722642qtg.13;
 Tue, 01 Sep 2020 05:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2JShfyJfS/zPyW00aOHuTSz2uDpf88AEIFLQZdU+7JY=;
 b=J7sc2BeZIc0F4Jnwj5qicUhFh+x5JuIcpu081afNgAZIkrWbpYAJa3WCgW5KuNKx//
 rqw1FZl6symCFL2Mo9BoKwUdD37Ik8YHzeh611mwwHiBgX4VFdezts5LkwsmxPb2g+x/
 D8EQ/9K6pLx9qymbVFqDxjZ0U/Q4lFWMH9l+ROFQQYUBLMPGUfUU7YjijqQ1oYCZxtsy
 NnaOw51elqSk9KJyMQ8w7rmJIyenhIjCEn54h83vV+8aC2ly/Ucs0SYmuBxJDWrB2ixc
 ri72G/yJjrRI0RaKPb3co5niUW7RmojUVNa+MuhpWGNrhHm72EJKorZb2ve1D2JPn0m3
 8U4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2JShfyJfS/zPyW00aOHuTSz2uDpf88AEIFLQZdU+7JY=;
 b=V4xCWSNvsmOw4k0rflEYyvsWyYPtQBs6LFk6PsIplA71dqURpukcwJndoV/mKYaQ9a
 1VcCnHWBbCpeCqi5iQP6NWVsiOlswkuBON3Upd9dl0d3kW/F6nkgLD+OCtxp7On43XeB
 snRu3+db1XfNxgyLWNQmawTnLlwHCXPYDFw42C29Mo8Ka+qz+Pw9yXuSJ6zzza6hUQWg
 loyFiMrGBT03eN+ihVVwHFnhoOjmlMopiwGdN2gHdl0nUZXLrBs7zbdCh8xbIY3KH/HL
 fLAYb38SfScH/z+JLhdX9Aa/wwtHCA0Bu0SqTUukGu3UorQnnqsZO8/eYX/KfEOUrA7n
 dL+g==
X-Gm-Message-State: AOAM532ozrgawhnCUS9+RpZ2wHgdff+8sSM0LL27RX42/sdpxPEm+EOn
 tV7Eq7GQwFf62BW5egV6VgLT7isfwx4VcA==
X-Google-Smtp-Source: ABdhPJyfcDPQTDj+bsXpBCGAEOG9XcnhUPfsOoUlXG/rcNBnlQ9NTnHWkx2bSj/8Ltx6H/W+t0SbJQ==
X-Received: by 2002:aed:30e1:: with SMTP id 88mr1719972qtf.66.1598965023028;
 Tue, 01 Sep 2020 05:57:03 -0700 (PDT)
Received: from rekt.ibmuc.com ([2804:431:c7c7:6be:f6e3:c671:cefe:b943])
 by smtp.gmail.com with ESMTPSA id q7sm1430164qkf.35.2020.09.01.05.57.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2020 05:57:02 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 5/7] spapr,
 spapr_numa: move lookup-arrays handling to spapr_numa.c
Date: Tue,  1 Sep 2020 09:56:43 -0300
Message-Id: <20200901125645.118026-6-danielhb413@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200901125645.118026-1-danielhb413@gmail.com>
References: <20200901125645.118026-1-danielhb413@gmail.com>
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

In a similar fashion as the previous patch, let's move the
handling of ibm,associativity-lookup-arrays from spapr.c to
spapr_numa.c. A spapr_numa_write_assoc_lookup_arrays() helper was
created, and spapr_dt_dynamic_reconfiguration_memory() can now
use it to advertise the lookup-arrays.

Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 hw/ppc/spapr.c              | 25 ++----------------------
 hw/ppc/spapr_numa.c         | 39 +++++++++++++++++++++++++++++++++++++
 include/hw/ppc/spapr_numa.h |  2 ++
 3 files changed, 43 insertions(+), 23 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 172f965fe0..65d2ccd578 100644
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
index b8882d209e..9eb4bdbe80 100644
--- a/hw/ppc/spapr_numa.c
+++ b/hw/ppc/spapr_numa.c
@@ -75,6 +75,45 @@ int spapr_numa_fixup_cpu_dt(SpaprMachineState *spapr, void *fdt,
                        vcpu_assoc, sizeof(vcpu_assoc));
 }
 
+
+int spapr_numa_write_assoc_lookup_arrays(SpaprMachineState *spapr, void *fdt,
+                                         int offset)
+{
+    MachineState *machine = MACHINE(spapr);
+    SpaprMachineClass *smc = SPAPR_MACHINE_GET_CLASS(spapr);
+    int nb_numa_nodes = machine->numa_state->num_nodes;
+    int nr_nodes = nb_numa_nodes ? nb_numa_nodes : 1;
+    uint32_t *int_buf, *cur_index, buf_len;
+    int ret, i, j;
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
+        uint32_t associativity[MAX_DISTANCE_REF_POINTS];
+
+        for (j = 0; j < MAX_DISTANCE_REF_POINTS; j++) {
+            associativity[j] = smc->numa_assoc_array[i][j + 1];
+        }
+
+        memcpy(cur_index, associativity, sizeof(associativity));
+        cur_index += 4;
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
index f92fb4f28a..f6127501a6 100644
--- a/include/hw/ppc/spapr_numa.h
+++ b/include/hw/ppc/spapr_numa.h
@@ -22,6 +22,8 @@ void spapr_numa_write_associativity_dt(SpaprMachineState *spapr, void *fdt,
                                        int offset, int nodeid);
 int spapr_numa_fixup_cpu_dt(SpaprMachineState *spapr, void *fdt,
                             int offset, PowerPCCPU *cpu);
+int spapr_numa_write_assoc_lookup_arrays(SpaprMachineState *spapr, void *fdt,
+                                         int offset);
 
 
 #endif /* HW_SPAPR_NUMA_H */
-- 
2.26.2


