Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BB95C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 16:07:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3D272076C
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 16:07:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dcitO43s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3D272076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50474 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kS0M3-0000jy-Q2
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 12:07:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58162)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kRztm-0003ks-TP
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 11:38:07 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:36634)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kRztf-0007mG-Hx
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 11:38:06 -0400
Received: by mail-wm1-x344.google.com with SMTP id e2so17980872wme.1
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2020 08:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=opfFFdiJTvPsa0Rt8+QLDrx/1PtCB63M7TE5N8kT7gs=;
 b=dcitO43sZZUgwbfkLpwyRTR4JtoPcc9v4SgUBWc5WGnpcaF/XqfPfL8X9d3O6NQREN
 rogrGD7sI625G1VzOwbp6kRL5JpshtvqN7kNLsV2HoeC618Lt/zAY49CvQY+zmXGL5fz
 9xH7WNzKYlKfCiXELXDF1FjRL2PXjSVbHxQh15aekYPC4t6LqKtM2H1fY2ipW7NDHZKy
 FXNxlK5QXA09YGkeO6J029KBVK5Q3O/M4j9WVZOj4EjxhdDV1w+8CP5BYNp48fByBzJG
 AfwVUiyhBfEEFdSwY+5+HdDzTrysEyU55qiGw/KwbAlBhtnm4kPy7cx7jw6mu6Q1rcUJ
 t11Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=opfFFdiJTvPsa0Rt8+QLDrx/1PtCB63M7TE5N8kT7gs=;
 b=UKHt0xChD0Kfa/xNKucaG4Qkd0D8kBOxcDFXN5Z9JkjeJpEcaUvUDT+mu5y/OGQb/9
 g5fkObXqnxYD6b2DHUovBGvad7eRToRtSbFPB2SaVI5XQkkuRK8GNpmfNNU1FTnFrG2d
 Nonzozmsn+JUFsdWNpd79glWQ71PVJevBoAHmIdgo6tOs8EpMuqqfHnTZw2R7YawKOVk
 rfRZbWVmcNCxLTqIC+dN/HZF3o5PVTTLokCiHeCyZ+lMCmah96o7Q2SAsEF1V8h46MVf
 kStVjJVqSfdCX3eTPeSJn50E8h/1wFh6vOsiKpP/YcPeuZh4+4EJ+AnXmg1wFNKEPPge
 0Fqg==
X-Gm-Message-State: AOAM531T9DFOxy0wfN1bvNVJjl/3v7h5AmbjD5ZMnyKmzO5RlQJ+qcBq
 M5diXnUuQxwxQEuBd2UsANChDd1Xlzd87eth
X-Google-Smtp-Source: ABdhPJxQQypodSp76AUEbNyAC56Eh/uBOicOhq9AY/YPyoRpBkb3jDMWwV67DhwDO7xcUXEUT16+tA==
X-Received: by 2002:a1c:b6d5:: with SMTP id g204mr11316451wmf.65.1602517075224; 
 Mon, 12 Oct 2020 08:37:55 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id y66sm7095961wmd.14.2020.10.12.08.37.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2020 08:37:54 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 06/10] target/arm: Implement v8.1M branch-future insns (as
 NOPs)
Date: Mon, 12 Oct 2020 16:37:42 +0100
Message-Id: <20201012153746.9996-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201012153746.9996-1-peter.maydell@linaro.org>
References: <20201012153746.9996-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

v8.1M implements a new 'branch future' feature, which is a
set of instructions that request the CPU to perform a branch
"in the future", when it reaches a particular execution address.
In hardware, the expected implementation is that the information
about the branch location and destination is cached and then
acted upon when execution reaches the specified address.
However the architecture permits an implementation to discard
this cached information at any point, and so guest code must
always include a normal branch insn at the branch point as
a fallback. In particular, an implementation is specifically
permitted to treat all BF insns as NOPs (which is equivalent
to discarding the cached information immediately).

For QEMU, implementing this caching of branch information
would be complicated and would not improve the speed of
execution at all, so we make the IMPDEF choice to implement
all BF insns as NOPs.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h       |  6 ++++++
 target/arm/t32.decode  | 13 ++++++++++++-
 target/arm/translate.c | 20 ++++++++++++++++++++
 3 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 74392fa0295..a432f301f11 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3473,6 +3473,12 @@ static inline bool isar_feature_aa32_arm_div(const ARMISARegisters *id)
     return FIELD_EX32(id->id_isar0, ID_ISAR0, DIVIDE) > 1;
 }
 
+static inline bool isar_feature_aa32_lob(const ARMISARegisters *id)
+{
+    /* (M-profile) low-overhead loops and branch future */
+    return FIELD_EX32(id->id_isar0, ID_ISAR0, CMPBRANCH) >= 3;
+}
+
 static inline bool isar_feature_aa32_jazelle(const ARMISARegisters *id)
 {
     return FIELD_EX32(id->id_isar1, ID_ISAR1, JAZELLE) != 0;
diff --git a/target/arm/t32.decode b/target/arm/t32.decode
index 7d5e000e82c..3015731a8d0 100644
--- a/target/arm/t32.decode
+++ b/target/arm/t32.decode
@@ -648,4 +648,15 @@ MRC              1110 1110 ... 1 .... .... .... ... 1 .... @mcr
 
 B                1111 0. .......... 10.1 ............         @branch24
 BL               1111 0. .......... 11.1 ............         @branch24
-BLX_i            1111 0. .......... 11.0 ............         @branch24
+{
+  # BLX_i is non-M-profile only
+  BLX_i          1111 0. .......... 11.0 ............         @branch24
+  # M-profile only: loop and branch insns
+  [
+    # All these BF insns have boff != 0b0000; we NOP them all
+    BF           1111 0 boff:4  ------- 1100 - ---------- 1    # BFL
+    BF           1111 0 boff:4 0 ------ 1110 - ---------- 1    # BFCSEL
+    BF           1111 0 boff:4 10 ----- 1110 - ---------- 1    # BF
+    BF           1111 0 boff:4 11 ----- 1110 0 0000000000 1    # BFX, BFLX
+  ]
+}
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 0c35efb1014..9e72d719c6f 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -7933,6 +7933,26 @@ static bool trans_BLX_suffix(DisasContext *s, arg_BLX_suffix *a)
     return true;
 }
 
+static bool trans_BF(DisasContext *s, arg_BF *a)
+{
+    /*
+     * M-profile branch future insns. The architecture permits an
+     * implementation to implement these as NOPs (equivalent to
+     * discarding the LO_BRANCH_INFO cache immediately), and we
+     * take that IMPDEF option because for QEMU a "real" implementation
+     * would be complicated and wouldn't execute any faster.
+     */
+    if (!dc_isar_feature(aa32_lob, s)) {
+        return false;
+    }
+    if (a->boff == 0) {
+        /* SEE "Related encodings" (loop insns) */
+        return false;
+    }
+    /* Handle as NOP */
+    return true;
+}
+
 static bool op_tbranch(DisasContext *s, arg_tbranch *a, bool half)
 {
     TCGv_i32 addr, tmp;
-- 
2.20.1


