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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1589C43461
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 01:06:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E02020758
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 01:06:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sWzQjXUY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E02020758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58664 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kE0Bo-0005ra-HQ
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 21:06:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54018)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1kE09z-0002Rk-LI; Thu, 03 Sep 2020 21:04:59 -0400
Received: from mail-il1-x143.google.com ([2607:f8b0:4864:20::143]:42952)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1kE09y-0002kE-1d; Thu, 03 Sep 2020 21:04:59 -0400
Received: by mail-il1-x143.google.com with SMTP id t13so4921046ile.9;
 Thu, 03 Sep 2020 18:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=l8hA6A+tm06gP00jolVs7Fv1lM2u7W2UYOunpzAJwCY=;
 b=sWzQjXUYwtwQOND70k9caF6CZplXeNAxEslfRn2eXESe0Yp5yO5J4rz8/c+rsuWkov
 uSne8FLzswP+QbdrG5TgQeJwh1pbBpkgBVVofsgdJcpVTbRQDoA/qIa9G28B0ezXtTE7
 8MCVYfC7JsDDYj/N6bxr2BQLBJxbd9EUKL4u0AILKbbciaraa2BQhTAWsSKW3EtG6Hc+
 IeH+IOoxoAChTRMonovBPGB2LjBAOMjMAg/bDt/10+VzP2e5gmQZoUpgLyV5No1/F6k4
 fQ7i9KB0TbacpDKMsTKukCTxLqF6f3Z06p+/9vTFvFY6n1fxbm0icewO4qFFzXnWmBEq
 JfIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=l8hA6A+tm06gP00jolVs7Fv1lM2u7W2UYOunpzAJwCY=;
 b=YP+2CAnyVXrXX9vN3VqFojGVdVWeX51xSH+ADLS0ywooAAw1X6gYaZFl/8wr2lmIAI
 YAWNaSxRFjptpN9LtWtblJ27Ad83f82AK/DNnxXtJIQ832hTY2fs01hVMSfj27uwuII4
 ZN3qFJJGyOGr8Ose8eESvibaaNLxdj+m0UAFsKhuHoITT0qVguxi+etJzBS2fYtGHkVh
 r25Dh/W2mPhIz7V+ptCfAU9pFe0im1NQZjthrDNlsmrZpcR6f0zpq6uPQtIvf+J2d68B
 hXhTgv/kuDG/yH003q5IOukQ7ckhvIupq0h9usM9kkjMRFtLORUfwQB+Sn4xf75qrbp7
 Dmmw==
X-Gm-Message-State: AOAM530PBAaztKkZ2C9I3hGxJKVdaQGVowzFVXT+2udTJVak0e6n+1BJ
 XrH7z0NLV2QPiXXW6Y6ypt999Wz8jsk=
X-Google-Smtp-Source: ABdhPJxI/GOVULQ9va9WpRu1SFClwhDmVn3hIJy26XtzAWiE6btbMQF9Ds481ff7E0dHLyQR9K6t/w==
X-Received: by 2002:a92:7754:: with SMTP id s81mr5535730ilc.304.1599181496449; 
 Thu, 03 Sep 2020 18:04:56 -0700 (PDT)
Received: from rekt.ibmuc.com ([2804:431:c7c6:1dc:ffbd:d3fb:97ff:aaca])
 by smtp.gmail.com with ESMTPSA id o18sm205907ilj.77.2020.09.03.18.04.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2020 18:04:55 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 2/3] spapr_numa: create a vcpu associativity helper
Date: Thu,  3 Sep 2020 22:04:38 -0300
Message-Id: <20200904010439.581957-3-danielhb413@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200904010439.581957-1-danielhb413@gmail.com>
References: <20200904010439.581957-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::143;
 envelope-from=danielhb413@gmail.com; helo=mail-il1-x143.google.com
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

The work to be done in h_home_node_associativity() intersects
with what is already done in spapr_numa_fixup_cpu_dt(). This
patch creates a new helper, spapr_numa_get_vcpu_assoc(), to
be used for both spapr_numa_fixup_cpu_dt() and
h_home_node_associativity().

While we're at it, use memcpy() instead of loop assignment
to created the returned array.

Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 hw/ppc/spapr_numa.c | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/hw/ppc/spapr_numa.c b/hw/ppc/spapr_numa.c
index 368c1a494d..980a6488bf 100644
--- a/hw/ppc/spapr_numa.c
+++ b/hw/ppc/spapr_numa.c
@@ -71,13 +71,15 @@ void spapr_numa_write_associativity_dt(SpaprMachineState *spapr, void *fdt,
                       sizeof(spapr->numa_assoc_array[nodeid]))));
 }
 
-int spapr_numa_fixup_cpu_dt(SpaprMachineState *spapr, void *fdt,
-                            int offset, PowerPCCPU *cpu)
+static uint32_t *spapr_numa_get_vcpu_assoc(SpaprMachineState *spapr,
+                                          PowerPCCPU *cpu,
+                                          uint *vcpu_assoc_size)
 {
-    uint vcpu_assoc_size = NUMA_ASSOC_SIZE + 1;
-    uint32_t vcpu_assoc[vcpu_assoc_size];
+    uint32_t *vcpu_assoc = NULL;
     int index = spapr_get_vcpu_id(cpu);
-    int i;
+
+    *vcpu_assoc_size = (NUMA_ASSOC_SIZE + 1) * sizeof(uint32_t);
+    vcpu_assoc = g_malloc(*vcpu_assoc_size);
 
     /*
      * VCPUs have an extra 'cpu_id' value in ibm,associativity
@@ -86,16 +88,24 @@ int spapr_numa_fixup_cpu_dt(SpaprMachineState *spapr, void *fdt,
      * cpu_id last.
      */
     vcpu_assoc[0] = cpu_to_be32(MAX_DISTANCE_REF_POINTS + 1);
+    memcpy(vcpu_assoc + 1, spapr->numa_assoc_array[cpu->node_id],
+           MAX_DISTANCE_REF_POINTS);
+    vcpu_assoc[MAX_DISTANCE_REF_POINTS + 1] = cpu_to_be32(index);
 
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
+    uint vcpu_assoc_size;
 
-    vcpu_assoc[vcpu_assoc_size - 1] = cpu_to_be32(index);
+    vcpu_assoc = spapr_numa_get_vcpu_assoc(spapr, cpu, &vcpu_assoc_size);
 
     /* Advertise NUMA via ibm,associativity */
     return fdt_setprop(fdt, offset, "ibm,associativity",
-                       vcpu_assoc, sizeof(vcpu_assoc));
+                       vcpu_assoc, vcpu_assoc_size);
 }
 
 
-- 
2.26.2


