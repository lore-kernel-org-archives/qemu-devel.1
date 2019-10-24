Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A11D6CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 16:39:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B05F205C9
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 16:39:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r1LiLYvL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B05F205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47556 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNg8l-0001ch-1r
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 12:39:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57766)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iNfxf-00078S-0Y
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 12:27:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iNfxd-0000ij-RM
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 12:27:42 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:35409)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iNfxd-0000iP-L4
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 12:27:41 -0400
Received: by mail-wm1-x342.google.com with SMTP id v6so3230506wmj.0
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 09:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=HhJomiYWFoyGiQnBnfLm1DrjhXgk0FPd/bxO+44fxEo=;
 b=r1LiLYvL9/JKnkM0wrN8hqzHjWmnLUecPjgIlAub3XQ7/1G3U7cfIimsaJW7iv6Zd0
 eH4W3hct1VcH3t2Yi09DXHffkliUKwCaYhRY0doErRULRMXOyMWL22GFRUYBRZo6fB7I
 tnqWjp19Bebbs6G49Qpy6MuCU35g99lQuLI0L+9RQ8HfHacZrilOiIkrsGFhelmdGOV6
 tZLMXkPj8aQaKPGW1cvogRda8IvLigwBXtPewyn19q8Cms6Vdr7iDDTX8EdTxvx5Uknn
 HIYydQ8wXoaGjjEioqW6oGNKPcfpzoBLmTdOfAziVjSOyOfIrKEMOUpHH8tHA1xjwhrw
 naOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=HhJomiYWFoyGiQnBnfLm1DrjhXgk0FPd/bxO+44fxEo=;
 b=d4QnKfyHU8GoK2mjjtaV7JOCD6/ekpKeFuk0FWnFJcYQf9sUsjwgKrXY+IqAaU0ux5
 S6yyBsNOqH7mYdqE3t7GdqX2NYC9U77mm6k9m6GUwjUs7XNJlv1b7HFG14HkwVxBXYc4
 DwCT2L7+0xMr0Ep09OGG42mMGHTb0aqQBbjQbK3jib9YN33I+IhuBk/Z3ywOSXWtT1Aw
 JxC9/xeeGZuOi7Rzq+Pk1VwGdjubXTM2rMgcyyTepKmcarMrlwA29PHuXItNGjRgA/da
 54SvHHHnTvbLDMZLLqN5sz+YGpev5ayKGkrhg1CHBap2naXvZIoXyH9RPnou95eK1wEy
 myTQ==
X-Gm-Message-State: APjAAAUgnxRuipqkUHA1SDafA55vpKp5PFVXOMlkHnR4bGoXLMINr6c8
 cW7nd1fY+Fgci4alYKSE1KejKizF+0g=
X-Google-Smtp-Source: APXvYqxjR2WxSwhz4bEAQUSsnKhYdiFcGxTT4ztRx+OINZ1XgoECTUXCVt0h4aXXCpow7/yuCP1reQ==
X-Received: by 2002:a7b:c74a:: with SMTP id w10mr5674950wmk.30.1571934460028; 
 Thu, 24 Oct 2019 09:27:40 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id r27sm42606124wrc.55.2019.10.24.09.27.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2019 09:27:38 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/51] target/arm: Split out rebuild_hflags_aprofile
Date: Thu, 24 Oct 2019 17:26:43 +0100
Message-Id: <20191024162724.31675-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191024162724.31675-1-peter.maydell@linaro.org>
References: <20191024162724.31675-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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

From: Richard Henderson <richard.henderson@linaro.org>

Create a function to compute the values of the TBFLAG_ANY bits
that will be cached, and are used by A-profile.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20191023150057.25731-9-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index d1cd54cc931..ddd21edfcf1 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -11106,18 +11106,28 @@ static uint32_t rebuild_hflags_m32(CPUARMState *env, int fp_el,
     return rebuild_hflags_common_32(env, fp_el, mmu_idx, flags);
 }
 
+static uint32_t rebuild_hflags_aprofile(CPUARMState *env)
+{
+    int flags = 0;
+
+    flags = FIELD_DP32(flags, TBFLAG_ANY, DEBUG_TARGET_EL,
+                       arm_debug_target_el(env));
+    return flags;
+}
+
 static uint32_t rebuild_hflags_a32(CPUARMState *env, int fp_el,
                                    ARMMMUIdx mmu_idx)
 {
-    return rebuild_hflags_common_32(env, fp_el, mmu_idx, 0);
+    uint32_t flags = rebuild_hflags_aprofile(env);
+    return rebuild_hflags_common_32(env, fp_el, mmu_idx, flags);
 }
 
 static uint32_t rebuild_hflags_a64(CPUARMState *env, int el, int fp_el,
                                    ARMMMUIdx mmu_idx)
 {
+    uint32_t flags = rebuild_hflags_aprofile(env);
     ARMMMUIdx stage1 = stage_1_mmu_idx(mmu_idx);
     ARMVAParameters p0 = aa64_va_parameters_both(env, 0, stage1);
-    uint32_t flags = 0;
     uint64_t sctlr;
     int tbii, tbid;
 
@@ -11262,12 +11272,6 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
         }
     }
 
-    if (!arm_feature(env, ARM_FEATURE_M)) {
-        int target_el = arm_debug_target_el(env);
-
-        flags = FIELD_DP32(flags, TBFLAG_ANY, DEBUG_TARGET_EL, target_el);
-    }
-
     *pflags = flags;
     *cs_base = 0;
 }
-- 
2.20.1


