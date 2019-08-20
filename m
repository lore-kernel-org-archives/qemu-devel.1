Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0FF5C3A589
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 21:29:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 622F0206DD
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 21:29:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eij0cmVB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 622F0206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0BhA-0003kw-Jh
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 17:29:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53901)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i0BM0-0000JP-L4
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 17:07:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i0BLz-00009u-90
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 17:07:44 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:40082)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i0BLz-0008T8-04
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 17:07:43 -0400
Received: by mail-pg1-x544.google.com with SMTP id w10so10801pgj.7
 for <qemu-devel@nongnu.org>; Tue, 20 Aug 2019 14:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=yxbpJRWxck0uWFUl/a/sUY0K0yqQ+42Z+aDE0x2Cf9o=;
 b=eij0cmVBA9PsJOVyV7dPQAbrVthpOec9elcRG0WGQNG8pWWE6SJDrp5R164UbPGBH7
 XBYuLshgkBzAWQTHj1e5neird9jVbxxyyU2BdsOIZbvLXY/GTNhZAQFDRuGAhzxv7tsd
 6DBdMuQemWY5NirBMv1fWd+5CJJWBcIfkYWFjnkGqfr1HnOxT+dQ+kC6DmS6dOhRXOzm
 C5AaTtzaIBqN0zjS+UJM5q4nBe7dh50Jnph2RhDxUFaUTIOp8uXE8qPi6yeRgQzonJoG
 bCIMR6hT0Aq6pqOCjAuXB/EKPkuifO5Zbp5x2FYg0Vt7NKLcw+gNzFVSSPk3OM0gBrmE
 QtEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=yxbpJRWxck0uWFUl/a/sUY0K0yqQ+42Z+aDE0x2Cf9o=;
 b=ZnuZcOIf4lYJfzUQG2LQ9y5Qz/pJJJiaNJDClD+X/T8FkrhTti74vvGI4RrEHblgAr
 6p2kXPDyqbfIFsSfNvU+Y9VU2tHywAQgx4GRE6LU98n7Pb+9vwxv3XN6KswtGDGj7IrZ
 3TIjy6TaQQFMJDhTAeGkADZ1ESE02asAMctr/YiLTORq1YsnOMY0fTFpVOc3X4f1IWR+
 pgW3T3UoN0NfWfBkmg/BNzDL1WQHouLruLfgqhXao3tnXm/B7tSLoTfhdQAavmrG5SpJ
 Ciz78rIz1/BaxMrASSJaot4SVCCr5tfWkhAVE+Q24ny7ab3ui72M+t6gryNK8J6Uar3S
 Ckeg==
X-Gm-Message-State: APjAAAWceFCZwbHdu36QEWPMO+kNsSS0iYO0i+bVvJJh6IE85CDGRva1
 WqlXfcbhwdECFpRIFCDeE/PFMz/vOHI=
X-Google-Smtp-Source: APXvYqyk+LXoB6OxMj+BgwgSEy+8u1H16WZMaEvNEzzMpo6XLsoYKfVPkvq8NTnUZTCPRi1FNhKu+A==
X-Received: by 2002:aa7:92d2:: with SMTP id k18mr32011830pfa.153.1566335253852; 
 Tue, 20 Aug 2019 14:07:33 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id k22sm21690743pfk.157.2019.08.20.14.07.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Aug 2019 14:07:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue, 20 Aug 2019 14:07:11 -0700
Message-Id: <20190820210720.18976-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190820210720.18976-1-richard.henderson@linaro.org>
References: <20190820210720.18976-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
Subject: [Qemu-devel] [PATCH v5 08/17] target/arm: Split out
 rebuild_hflags_aprofile
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 0fea62dc12..fc071f95db 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -11068,18 +11068,28 @@ static uint32_t rebuild_hflags_m32(CPUARMState *env, int fp_el,
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
 
@@ -11224,12 +11234,6 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
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


