Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48F37C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 11:47:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18D0420738
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 11:47:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sEYvR9c3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18D0420738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55302 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnhOX-0000Pj-Bz
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 07:47:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44172)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jnhH5-00035j-IO
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 07:39:35 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:33073)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jnhH2-0003FX-Vb
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 07:39:35 -0400
Received: by mail-wr1-x432.google.com with SMTP id l11so20186839wru.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 04:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=CRcL1zHmlF4QDBbu4+fZlTNeuC5DJJerfTa5V4msvfk=;
 b=sEYvR9c3ihh3VtLC6UjuVopFhD7z6UBmez1utthz2VMQOCoE6YTOcfettfesOjrRc9
 uVnJzqOL0I9kvAb5sJm8vuMjKNlUk2ZCRRDUUeEVkGg7wn+iyU4FjSNUgUB9XhLY7pHd
 PTFfyXO0+vm6cK65Xf8flVPf+wT7JOEv1PN5SdQqyEzdRbJeys7iSbjGBfNK/y63ixFl
 XnskdunOLQYOUoL5rcsHGlBtG2fcdbzYg33CeZvXkV1ec4cVBrWmxrYgQekOPoS95vwc
 +oCJncauXgIACIjHHOIbz0oRHIaEAGv0x9MrOdGKg20AFMdMW2hK1etevyK5I7mUmQZg
 tvSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=CRcL1zHmlF4QDBbu4+fZlTNeuC5DJJerfTa5V4msvfk=;
 b=GKqgOyfdEKef6pqV6z4UhkypJTQVP/net4vHpN29HJKunGwLD5lVbTPhR1OmwDmjB7
 jx3qPuLXX4tYE/L6XmEEPNh5yf8vbU7DAU7+su4dEjdud9gBEe7qL+NW0dvVxrpzE/gc
 iaRLZd9SuE8YiryvUAHl6c0Lchk9sjpfIQ/o9VPdSPj7LzVVOhQVqWm/tuJj/2eJPqtt
 7Ale2QdjNSU3j/GWH0ORfyPeC/i3+ADUHSqSOVabdCCnMzhet1wxHjP9Rz/aDub03zma
 i5OGq8Mvms3lBJzoUNC2ZG2k77go5NzINRZIwLNHcNr4ajljuYhMoAAeQyONxIGjmk+N
 Gz6w==
X-Gm-Message-State: AOAM531lsY1swi95PhCNhgHtssO2Fq+AFyTjMR2KcmV3zOSQaseWp5lM
 IthmpFsiXtVZH856ITMMELap+lZqUquOzg==
X-Google-Smtp-Source: ABdhPJws9f6AS8H28KKW9MLs+qeRsjLJH5rGnLkGiayQAp8ll1HNQrYuo+bt5Ye7Hwigfo0eV71R9w==
X-Received: by 2002:adf:e590:: with SMTP id l16mr23620728wrm.383.1592912370497; 
 Tue, 23 Jun 2020 04:39:30 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id m10sm4022177wru.4.2020.06.23.04.39.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2020 04:39:29 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 21/42] target/arm: Convert Neon VSWP to decodetree
Date: Tue, 23 Jun 2020 12:38:43 +0100
Message-Id: <20200623113904.28805-22-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200623113904.28805-1-peter.maydell@linaro.org>
References: <20200623113904.28805-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x432.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Convert the Neon VSWP insn to decodetree. Since the new implementation
doesn't have to share a pass-loop with the other 2-reg-misc operations
we can implement the swap with 64-bit accesses rather than 32-bits
(which brings us into line with the pseudocode and is more efficient).

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200616170844.13318-20-peter.maydell@linaro.org
---
 target/arm/neon-dp.decode       |  2 ++
 target/arm/translate-neon.inc.c | 41 +++++++++++++++++++++++++++++++++
 target/arm/translate.c          |  5 +---
 3 files changed, 44 insertions(+), 4 deletions(-)

diff --git a/target/arm/neon-dp.decode b/target/arm/neon-dp.decode
index 5507c3e4623..2f64841de52 100644
--- a/target/arm/neon-dp.decode
+++ b/target/arm/neon-dp.decode
@@ -488,6 +488,8 @@ Vimm_1r          1111 001 . 1 . 000 ... .... cmode:4 0 . op:1 1 .... @1reg_imm
     VABS_F       1111 001 11 . 11 .. 01 .... 0 1110 . . 0 .... @2misc
     VNEG_F       1111 001 11 . 11 .. 01 .... 0 1111 . . 0 .... @2misc
 
+    VSWP         1111 001 11 . 11 .. 10 .... 0 0000 . . 0 .... @2misc
+
     VUZP         1111 001 11 . 11 .. 10 .... 0 0010 . . 0 .... @2misc
     VZIP         1111 001 11 . 11 .. 10 .... 0 0011 . . 0 .... @2misc
 
diff --git a/target/arm/translate-neon.inc.c b/target/arm/translate-neon.inc.c
index 29bc161f36a..01da7fad462 100644
--- a/target/arm/translate-neon.inc.c
+++ b/target/arm/translate-neon.inc.c
@@ -3927,3 +3927,44 @@ DO_VCVT(VCVTPU, FPROUNDING_POSINF, false)
 DO_VCVT(VCVTPS, FPROUNDING_POSINF, true)
 DO_VCVT(VCVTMU, FPROUNDING_NEGINF, false)
 DO_VCVT(VCVTMS, FPROUNDING_NEGINF, true)
+
+static bool trans_VSWP(DisasContext *s, arg_2misc *a)
+{
+    TCGv_i64 rm, rd;
+    int pass;
+
+    if (!arm_dc_feature(s, ARM_FEATURE_NEON)) {
+        return false;
+    }
+
+    /* UNDEF accesses to D16-D31 if they don't exist. */
+    if (!dc_isar_feature(aa32_simd_r32, s) &&
+        ((a->vd | a->vm) & 0x10)) {
+        return false;
+    }
+
+    if (a->size != 0) {
+        return false;
+    }
+
+    if ((a->vd | a->vm) & a->q) {
+        return false;
+    }
+
+    if (!vfp_access_check(s)) {
+        return true;
+    }
+
+    rm = tcg_temp_new_i64();
+    rd = tcg_temp_new_i64();
+    for (pass = 0; pass < (a->q ? 2 : 1); pass++) {
+        neon_load_reg64(rm, a->vm + pass);
+        neon_load_reg64(rd, a->vd + pass);
+        neon_store_reg64(rm, a->vd + pass);
+        neon_store_reg64(rd, a->vm + pass);
+    }
+    tcg_temp_free_i64(rm);
+    tcg_temp_free_i64(rd);
+
+    return true;
+}
diff --git a/target/arm/translate.c b/target/arm/translate.c
index b0181062020..e8cd4a9c61f 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -4944,6 +4944,7 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                 case NEON_2RM_VCVTPS:
                 case NEON_2RM_VCVTMU:
                 case NEON_2RM_VCVTMS:
+                case NEON_2RM_VSWP:
                     /* handled by decodetree */
                     return 1;
                 case NEON_2RM_VTRN:
@@ -4965,10 +4966,6 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                     for (pass = 0; pass < (q ? 4 : 2); pass++) {
                         tmp = neon_load_reg(rm, pass);
                         switch (op) {
-                        case NEON_2RM_VSWP:
-                            tmp2 = neon_load_reg(rd, pass);
-                            neon_store_reg(rm, pass, tmp2);
-                            break;
                         case NEON_2RM_VTRN:
                             tmp2 = neon_load_reg(rd, pass);
                             switch (size) {
-- 
2.20.1


