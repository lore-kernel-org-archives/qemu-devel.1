Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2457EC5B578
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 02:10:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF188206A3
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 02:10:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xATTY6qF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF188206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47132 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hi8FZ-0000ql-C8
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 22:10:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56964)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hi4RQ-0008PJ-Mt
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 18:06:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hi4RP-0001kI-Gf
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 18:06:28 -0400
Received: from mail-wm1-f41.google.com ([209.85.128.41]:36806)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hi4RJ-0001is-R3
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 18:06:24 -0400
Received: by mail-wm1-f41.google.com with SMTP id u8so1110767wmm.1
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2019 15:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=WdrDS78k3n12ZSXX1AYlSfN84PXvZ6CqEJ/pNp8N1Lo=;
 b=xATTY6qFMeTxMqbBSLMEYuA9m2aRkKBCe89ww9WotIcH6/VDfYhg3LThhEGqWqcmXf
 Fy/rnfodvLDO0rb8WMdkkFBLo3AHD1HmihvRwgHUWEThMxbtDobGzNlPjxLzkMzm+csb
 nyv92t26wbaiZCpbCq7GHr1zguYVhzsiuaOdJmoA2VytC1iS7pTNMB7x0TjTv3IlGn4T
 f2OPh7O8+JN9MBgfh/tv5pw0x6Hhkih+Lruv3FFoCpDa3tD28D+5Fies72xgM01lZ1rl
 l2Du04elFue/gvn8C1+7wGEqWAwC3R0ZbDOkwGYcIsmqvml4fZpWecH2WevO+aJ+t1Km
 RYcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=WdrDS78k3n12ZSXX1AYlSfN84PXvZ6CqEJ/pNp8N1Lo=;
 b=NRRemThgPbYEsTTwnvd2HBGFwqRCZD6hec+y2V/vOcWUiGXnXUVb4Jxtp+kpTjLdp3
 XMDccSKxoMFRXVQJI9ZxKHLrZcLYbUmrdqcVv76C65Ba3PbKnn9wquJpuHtSkzefbMCt
 MmQNbFSJb6pwfA6EFBX+ejKxJ+oTLVqgbF40n1vbw0woKhP2YX4FQ1NluuUeYwUZmBt4
 wUS9V4eS3dBwYQyYbQC0t6HWZi+SnPmA7gZ+70SU1pDFeeGSwdnbebg4LrQyQX2VU6W9
 Pw6hKX/dQSgUKG/HIONFkNq6ZoI+5c6m8K3gXkJ8rZ5jfhpf30N3QyZUJIzTgSeonSM7
 ku3Q==
X-Gm-Message-State: APjAAAVCycRmNvePRFhN1tgbvMuVKxn2b4q4wCi4IPSpoYNehpCP4fEc
 L3JhW0E5JQ8i72aAxVLg1A+Hcbn8KPU3Hg==
X-Google-Smtp-Source: APXvYqzjwVc5DWrrHizc9O3RjJHKZSyeQ+n/oxtgmPcP64AAC+7FXXT4dGpKuEAY70ml5GbJIrYjZw==
X-Received: by 2002:a7b:ce01:: with SMTP id m1mr123227wmc.1.1561999230410;
 Mon, 01 Jul 2019 09:40:30 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id o6sm26573508wra.27.2019.07.01.09.40.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 01 Jul 2019 09:40:29 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon,  1 Jul 2019 17:39:37 +0100
Message-Id: <20190701163943.22313-41-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190701163943.22313-1-peter.maydell@linaro.org>
References: <20190701163943.22313-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.41
Subject: [Qemu-devel] [PULL 40/46] target/arm/vfp_helper: Move code around
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

To ease the review of the next commit,
move the vfp_exceptbits_to_host() function directly after
vfp_exceptbits_from_host().  Amusingly the diff shows we
are moving vfp_get_fpscr().

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20190701132516.26392-15-philmd@redhat.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/vfp_helper.c | 52 ++++++++++++++++++++---------------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/target/arm/vfp_helper.c b/target/arm/vfp_helper.c
index 121bdbd3aff..d54e3253240 100644
--- a/target/arm/vfp_helper.c
+++ b/target/arm/vfp_helper.c
@@ -55,32 +55,6 @@ static inline int vfp_exceptbits_from_host(int host_bits)
     return target_bits;
 }
 
-uint32_t HELPER(vfp_get_fpscr)(CPUARMState *env)
-{
-    uint32_t i, fpscr;
-
-    fpscr = env->vfp.xregs[ARM_VFP_FPSCR]
-            | (env->vfp.vec_len << 16)
-            | (env->vfp.vec_stride << 20);
-
-    i = get_float_exception_flags(&env->vfp.fp_status);
-    i |= get_float_exception_flags(&env->vfp.standard_fp_status);
-    /* FZ16 does not generate an input denormal exception.  */
-    i |= (get_float_exception_flags(&env->vfp.fp_status_f16)
-          & ~float_flag_input_denormal);
-    fpscr |= vfp_exceptbits_from_host(i);
-
-    i = env->vfp.qc[0] | env->vfp.qc[1] | env->vfp.qc[2] | env->vfp.qc[3];
-    fpscr |= i ? FPCR_QC : 0;
-
-    return fpscr;
-}
-
-uint32_t vfp_get_fpscr(CPUARMState *env)
-{
-    return HELPER(vfp_get_fpscr)(env);
-}
-
 /* Convert vfp exception flags to target form.  */
 static inline int vfp_exceptbits_to_host(int target_bits)
 {
@@ -107,6 +81,32 @@ static inline int vfp_exceptbits_to_host(int target_bits)
     return host_bits;
 }
 
+uint32_t HELPER(vfp_get_fpscr)(CPUARMState *env)
+{
+    uint32_t i, fpscr;
+
+    fpscr = env->vfp.xregs[ARM_VFP_FPSCR]
+            | (env->vfp.vec_len << 16)
+            | (env->vfp.vec_stride << 20);
+
+    i = get_float_exception_flags(&env->vfp.fp_status);
+    i |= get_float_exception_flags(&env->vfp.standard_fp_status);
+    /* FZ16 does not generate an input denormal exception.  */
+    i |= (get_float_exception_flags(&env->vfp.fp_status_f16)
+          & ~float_flag_input_denormal);
+    fpscr |= vfp_exceptbits_from_host(i);
+
+    i = env->vfp.qc[0] | env->vfp.qc[1] | env->vfp.qc[2] | env->vfp.qc[3];
+    fpscr |= i ? FPCR_QC : 0;
+
+    return fpscr;
+}
+
+uint32_t vfp_get_fpscr(CPUARMState *env)
+{
+    return HELPER(vfp_get_fpscr)(env);
+}
+
 void HELPER(vfp_set_fpscr)(CPUARMState *env, uint32_t val)
 {
     int i;
-- 
2.20.1


