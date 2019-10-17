Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 581EEECE58E
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 19:07:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1656121835
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 19:07:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NxvEpzHc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1656121835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57268 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLB7W-0002n4-PZ
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 15:07:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35173)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iLArz-0001Dm-8y
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 14:51:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iLArt-0000tA-0U
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 14:51:28 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:36821)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iLArs-0000sf-MF
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 14:51:24 -0400
Received: by mail-pl1-x643.google.com with SMTP id j11so1564823plk.3
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 11:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=EExBny+oAa/2RvpDTj0xViQxKJSM6o83jutlTagIpwU=;
 b=NxvEpzHc9miC/SMKdGOWl7jKJnrn+I+GOrYGHIZY96dtR4Je9HPB41aY1uD00I7Y1b
 PPBNBcc+DRmf72mohzLzaEnuLezbbll1E8ES8BcgAZx/mZc09f0RUWHGx5FC3ZE4t0jF
 2swxCSMPXVmgDKAkm6bcm8OJ6GLmMT09IN3t2PYgbNDUQVmucX9aHNQXUO77Ksbr4YGp
 pAIN9d4nC2yBYqacG0hJSWRGTib1TkHvZuuqe5a03NNdEmIKiLHMHCrZfMSb4jeBpGjU
 59nNDoEidi45CW07mhH0cJtGFqeMO+UQVDb9NC8/s+Pe1WDGUUaHvUEz5JU2rhsl+0J6
 gxYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=EExBny+oAa/2RvpDTj0xViQxKJSM6o83jutlTagIpwU=;
 b=bo6Zi+EyRPu9ogNVn3RfIf4tUe4f1BQjQKP/iA3fHc0CRewQIbW699iS9xk56KaYVM
 WxPn1FwbN+L63zyX1EF8aMC/5u9jIuB/f1WRTgxemTKfikTH8ffAXPongWj7rWQYqHtc
 GKeWMNcfkbKbklpwVvlhc0L4JWLy5eHMnLJtrTd5ZC8YtqVHF86H+MMbGPE8E3Qh2Id7
 sp4W/pZE/zATzORk3LGOFn1SXVYcSQoqtSo41ghnvSyt5q5BRy8LJVUHhSyelhfJ5aLH
 uca2/xlwdvpuPdWr5AvrFBcHRIuj6e7Ij4mVVJpw/RoWdmM/rxeoLZXYL9YQ/0dyLUh2
 sxPw==
X-Gm-Message-State: APjAAAUaV4DlFXIdnS8n3scWpV3vIrfO922QwiE3fH/YKNAlF7QDhKZL
 1CwerU35nwQgax3uEDSlqFS1jPGOe0M=
X-Google-Smtp-Source: APXvYqyI3UWHBkUYhKa1gwOq3ZHF3NUMpIbHuGLnzY6LVHJJNorG0EdP0ylRrPnMC1Y0oCnn8uDucw==
X-Received: by 2002:a17:902:8601:: with SMTP id
 f1mr5665293plo.144.1571338282782; 
 Thu, 17 Oct 2019 11:51:22 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id s97sm5009256pjc.4.2019.10.17.11.51.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2019 11:51:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 08/20] target/arm: Split out rebuild_hflags_aprofile
Date: Thu, 17 Oct 2019 11:50:58 -0700
Message-Id: <20191017185110.539-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191017185110.539-1-richard.henderson@linaro.org>
References: <20191017185110.539-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::643
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Create a function to compute the values of the TBFLAG_ANY bits
that will be cached, and are used by A-profile.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index d1cd54cc93..ddd21edfcf 100644
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
2.17.1


