Return-Path: <SRS0=i/12=ZI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0907AC432C3
	for <qemu-devel@archiver.kernel.org>; Sat, 16 Nov 2019 11:07:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8BC9206E1
	for <qemu-devel@archiver.kernel.org>; Sat, 16 Nov 2019 11:07:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EmBxhjx8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8BC9206E1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47356 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVvve-0003D9-TR
	for qemu-devel@archiver.kernel.org; Sat, 16 Nov 2019 06:07:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57168)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iVvv1-0002n9-DS
 for qemu-devel@nongnu.org; Sat, 16 Nov 2019 06:07:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iVvv0-0006DD-38
 for qemu-devel@nongnu.org; Sat, 16 Nov 2019 06:07:07 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:36759)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iVvuz-0006C8-Ry
 for qemu-devel@nongnu.org; Sat, 16 Nov 2019 06:07:06 -0500
Received: by mail-wr1-x444.google.com with SMTP id r10so13722561wrx.3
 for <qemu-devel@nongnu.org>; Sat, 16 Nov 2019 03:07:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=r5/4/U12EWC18Vtj87MOva04DZB5a9pp9lqOfXjV2j8=;
 b=EmBxhjx8LpxI2pIQeBDMXrlcIVjEaOYEaIQHbrRyWJO2fQ6GcrJoatP0GUXYfqMnCL
 bw2lecejSGTnOs909IZSY7SOZ96mpNXDYNcBtu0mG86uX+CutRAl9bR3JQgsvgOisfML
 0OwhrCY5UBf2pbcvQLf9Anfcb11w7My46q5kcnvHK9Ac1+9VV2NPwc/x12gfBLdnfEak
 LK5BIiBSbHhPAKRytlBspsuXADtgpOJTa1DgPj75fmOr1R3EJcCAFYaHEdYLqD8dUmds
 ezKtN1R1pwSCCzkT/xHe9fl7yt9O8mSUGsBbgZsRQIN7Q70e0cgoDhEX60wrk3ARlfqr
 nSLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=r5/4/U12EWC18Vtj87MOva04DZB5a9pp9lqOfXjV2j8=;
 b=KDAIM3gUa3oBVHhCWYlSPH0weIqPDWkf4CYmwQDkYrMkV/R9qX8tj6YZNeSKj8scpf
 J/FPSCyZWC5c8CegJWYGyWzzkiG5ZxPdk9WDy6QGTsnQ52FoGoxx2/zYwZ460AuBpB47
 ZQCTtbNQLCep24uupZ9uCiZEw+uUEmJ5aMpyBEsFdhR4aG75bc/SBFmGN9HPq3Gw0zUV
 Ijm2eXDQruI9mZGKAZrlsydj5WoXmvT00p8plKynJpjOhr9Vig9i2qP2jjSUDlEf1gzH
 XmgxFbEkgeQkmUmtgCKZShvl/WIHYcokzhxGB0jovfkajsMrenMYQfxUcPwC/r5KfWnV
 /EaQ==
X-Gm-Message-State: APjAAAWSVcCHuH2biMukkm2x4XS5ud9NvwwlQGqhiq54STEBEoXlp2kU
 GBDny/AfeZBxsps3VZ8ep0wNMEK/y2lgPA==
X-Google-Smtp-Source: APXvYqzrc3OEtVngO63Z5t7+XPJL9NlTILLdIC5uOWYvtj4Yfn2eK8Nivg6zesBMgNCOQPAWUyKAwA==
X-Received: by 2002:adf:cf10:: with SMTP id o16mr21341181wrj.334.1573902423642; 
 Sat, 16 Nov 2019 03:07:03 -0800 (PST)
Received: from localhost.localdomain (87.red-176-87-99.dynamicip.rima-tde.net.
 [176.87.99.87])
 by smtp.gmail.com with ESMTPSA id k14sm15766980wrw.46.2019.11.16.03.07.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 Nov 2019 03:07:02 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2] target/arm: Merge arm_cpu_vq_map_next_smaller into sole
 caller
Date: Sat, 16 Nov 2019 12:06:42 +0100
Message-Id: <20191116110642.12454-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: peter.maydell@linaro.org, drjones@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Coverity reports, in sve_zcr_get_valid_len,

"Subtract operation overflows on operands
arm_cpu_vq_map_next_smaller(cpu, start_vq + 1U) and 1U"

First, the aarch32 stub version of arm_cpu_vq_map_next_smaller,
returning 0, does exactly what Coverity reports.  Remove it.

Second, the aarch64 version of arm_cpu_vq_map_next_smaller has
a set of asserts, but they don't cover the case in question.
Further, there is a fair amount of extra arithmetic needed to
convert from the 0-based zcr register, to the 1-base vq form,
to the 0-based bitmap, and back again.  This can be simplified
by leaving the value in the 0-based form.

Finally, use test_bit to simplify the common case, where the
length in the zcr registers is in fact a supported length.

Reported-by: Coverity (CID 1407217)
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---

v2: Merge arm_cpu_vq_map_next_smaller into sve_zcr_get_valid_len,
    as suggested by Andrew Jones.

    Use test_bit to make the code even more obvious; the
    current_length + 1 thing to let us find current_length in the
    bitmap seemed unnecessarily clever.

---
 target/arm/cpu.h    |  3 ---
 target/arm/cpu64.c  | 15 ---------------
 target/arm/helper.c |  8 ++++++--
 3 files changed, 6 insertions(+), 20 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index e1a66a2d1c..47d24a5375 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -185,12 +185,9 @@ typedef struct {
 #ifdef TARGET_AARCH64
 # define ARM_MAX_VQ    16
 void arm_cpu_sve_finalize(ARMCPU *cpu, Error **errp);
-uint32_t arm_cpu_vq_map_next_smaller(ARMCPU *cpu, uint32_t vq);
 #else
 # define ARM_MAX_VQ    1
 static inline void arm_cpu_sve_finalize(ARMCPU *cpu, Error **errp) { }
-static inline uint32_t arm_cpu_vq_map_next_smaller(ARMCPU *cpu, uint32_t vq)
-{ return 0; }
 #endif
 
 typedef struct ARMVectorReg {
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 68baf0482f..a39d6fcea3 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -458,21 +458,6 @@ void arm_cpu_sve_finalize(ARMCPU *cpu, Error **errp)
     cpu->sve_max_vq = max_vq;
 }
 
-uint32_t arm_cpu_vq_map_next_smaller(ARMCPU *cpu, uint32_t vq)
-{
-    uint32_t bitnum;
-
-    /*
-     * We allow vq == ARM_MAX_VQ + 1 to be input because the caller may want
-     * to find the maximum vq enabled, which may be ARM_MAX_VQ, but this
-     * function always returns the next smaller than the input.
-     */
-    assert(vq && vq <= ARM_MAX_VQ + 1);
-
-    bitnum = find_last_bit(cpu->sve_vq_map, vq - 1);
-    return bitnum == vq - 1 ? 0 : bitnum + 1;
-}
-
 static void cpu_max_get_sve_max_vq(Object *obj, Visitor *v, const char *name,
                                    void *opaque, Error **errp)
 {
diff --git a/target/arm/helper.c b/target/arm/helper.c
index be67e2c66d..b5ee35a174 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -5363,9 +5363,13 @@ int sve_exception_el(CPUARMState *env, int el)
 
 static uint32_t sve_zcr_get_valid_len(ARMCPU *cpu, uint32_t start_len)
 {
-    uint32_t start_vq = (start_len & 0xf) + 1;
+    uint32_t end_len;
 
-    return arm_cpu_vq_map_next_smaller(cpu, start_vq + 1) - 1;
+    start_len &= 0xf;
+    end_len = find_last_bit(cpu->sve_vq_map, start_len + 1);
+
+    assert(end_len <= start_len);
+    return end_len;
 }
 
 /*
-- 
2.17.1


