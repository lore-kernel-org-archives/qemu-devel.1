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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C480C433E2
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 18:46:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C14FA20665
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 18:46:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GV1U1ser"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C14FA20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44810 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEFUD-0000Zi-1d
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 13:26:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49650)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1kEFS6-0005b7-3C; Fri, 04 Sep 2020 13:24:42 -0400
Received: from mail-qk1-x741.google.com ([2607:f8b0:4864:20::741]:37996)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1kEFS4-0005DS-ES; Fri, 04 Sep 2020 13:24:41 -0400
Received: by mail-qk1-x741.google.com with SMTP id d20so7028863qka.5;
 Fri, 04 Sep 2020 10:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=0g5HndXT5oEGs5Ygz3OSEu/DbagArUsuah/DY8mAiyY=;
 b=GV1U1serhQmMQIFq8wEvfrQENTAfNaDN/bEX8F0F0BlVvN5zqtyiEIWWF0WCFcFmJi
 r76dXEDN2lVZUz5mE6AUPj7pDNdI8oEbivJ3Lfvma//NUDRPHLZsiRiFJqfGEPUXoKHU
 fD9mKhiceYVf1j4nZ3znyGYpYO2xhPv0weGBJpkBY2rKf4xUW7BWZAG0OgpisrzyXZ+J
 VV6carV1Xcboa3LsCOZ043Lwc1YMIWjJUTbGK96S5HCxFVlOgjpz/uGgXhgdr5ocdJ32
 mHY9kJP6GCqQWzHwxt3Wfe9w2eB5v7NFGd57rzMTKPd8nArmNeIc+6VxPFjd8v6ixIwd
 qjHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=0g5HndXT5oEGs5Ygz3OSEu/DbagArUsuah/DY8mAiyY=;
 b=preONPYP1156QNSwqMiYuYB5w4o12HkfVNpkqigr12qi97jpV9UgsK0nmkapCr9vRI
 1G8u9aLd0FW5PKwUV27Aoj2ruMVg+iEQkZOi17ofrtkDsNN4BC16Cr+CzKJ8oPe3yY8H
 MlQ8k34urmPZQBFU8aTzkNi7ZzpChDgq485bjAIZe6ztOzmvh77kx5iSEzqKOmwELv2t
 hQp0zxjbRbThUBfrTwCHMornlkNEgZbj85CgdIeR3E9rzUmW+m8PTl91Q0/IUTPn1Zvd
 63BaslfwaIO9MBSED5+hm5UoZrsX6J8qd3O5IYlnkQIaCuSixk1O2tn3I6dxTCX6O1MP
 a3vQ==
X-Gm-Message-State: AOAM531w1vwjRMQQm/lGuIgEZesq7xBPnjqb4kV767IWjFWwz90Jo+bI
 fFgkHnLQ/YAQKtuebIUtWY7xvYDxSHM=
X-Google-Smtp-Source: ABdhPJxJps5zoqVf3On6bicrfXiLJpP60DhVjRfdwAGppRgCnMUwcACxp+VtVVrMSOWBYP+d6fzeRA==
X-Received: by 2002:a37:6441:: with SMTP id y62mr2472519qkb.144.1599240279022; 
 Fri, 04 Sep 2020 10:24:39 -0700 (PDT)
Received: from rekt.ibmuc.com ([2804:431:c7c6:1dc:ffbd:d3fb:97ff:aaca])
 by smtp.gmail.com with ESMTPSA id s192sm3269245qke.50.2020.09.04.10.24.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2020 10:24:38 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 3/3] spapr_numa: use spapr_numa_get_vcpu_assoc() in
 home_node hcall
Date: Fri,  4 Sep 2020 14:24:22 -0300
Message-Id: <20200904172422.617460-4-danielhb413@gmail.com>
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

The current implementation of h_home_node_associativity hard codes
the values of associativity domains of the vcpus. Let's make
it consider the values already initialized in spapr->numa_assoc_array,
via the spapr_numa_get_vcpu_assoc() helper.

We want to set it and forget it, and for that we also need to
assert that we don't overflow the registers of the hypercall.
From R4 to R9 we can squeeze in 12 associativity domains for
vcpus, so let's assert that VCPU_ASSOC_SIZE -1 isn't greater
than that.

Reviewed-by: Greg Kurz <groug@kaod.org>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 hw/ppc/spapr_numa.c | 41 +++++++++++++++++++++++++++++++++--------
 1 file changed, 33 insertions(+), 8 deletions(-)

diff --git a/hw/ppc/spapr_numa.c b/hw/ppc/spapr_numa.c
index 066ffc2a5f..64fe567f5d 100644
--- a/hw/ppc/spapr_numa.c
+++ b/hw/ppc/spapr_numa.c
@@ -176,10 +176,11 @@ static target_ulong h_home_node_associativity(PowerPCCPU *cpu,
                                               target_ulong opcode,
                                               target_ulong *args)
 {
+    g_autofree uint32_t *vcpu_assoc = NULL;
     target_ulong flags = args[0];
     target_ulong procno = args[1];
     PowerPCCPU *tcpu;
-    int idx;
+    int idx, assoc_idx;
 
     /* only support procno from H_REGISTER_VPA */
     if (flags != 0x1) {
@@ -191,16 +192,40 @@ static target_ulong h_home_node_associativity(PowerPCCPU *cpu,
         return H_P2;
     }
 
-    /* sequence is the same as in the "ibm,associativity" property */
+    /*
+     * Given that we want to be flexible with the sizes and indexes,
+     * we must consider that there is a hard limit of how many
+     * associativities domain we can fit in R4 up to R9, which would be
+     * 12 associativity domains for vcpus. Assert and bail if that's
+     * not the case.
+     */
+    G_STATIC_ASSERT((VCPU_ASSOC_SIZE - 1) <= 12);
+
+    vcpu_assoc = spapr_numa_get_vcpu_assoc(spapr, tcpu);
+    /* assoc_idx starts at 1 to skip associativity size */
+    assoc_idx = 1;
 
-    idx = 0;
 #define ASSOCIATIVITY(a, b) (((uint64_t)(a) << 32) | \
                              ((uint64_t)(b) & 0xffffffff))
-    args[idx++] = ASSOCIATIVITY(0, 0);
-    args[idx++] = ASSOCIATIVITY(0, tcpu->node_id);
-    args[idx++] = ASSOCIATIVITY(procno, -1);
-    for ( ; idx < 6; idx++) {
-        args[idx] = -1;
+
+    for (idx = 0; idx < 6; idx++) {
+        int32_t a, b;
+
+        /*
+         * vcpu_assoc[] will contain the associativity domains for tcpu,
+         * including tcpu->node_id and procno, meaning that we don't
+         * need to use these variables here.
+         *
+         * We'll read 2 values at a time to fill up the ASSOCIATIVITY()
+         * macro. The ternary will fill the remaining registers with -1
+         * after we went through vcpu_assoc[].
+         */
+        a = assoc_idx < VCPU_ASSOC_SIZE ?
+            be32_to_cpu(vcpu_assoc[assoc_idx++]) : -1;
+        b = assoc_idx < VCPU_ASSOC_SIZE ?
+            be32_to_cpu(vcpu_assoc[assoc_idx++]) : -1;
+
+        args[idx] = ASSOCIATIVITY(a, b);
     }
 #undef ASSOCIATIVITY
 
-- 
2.26.2


