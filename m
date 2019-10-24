Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD550CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 17:04:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 898E92166E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 17:04:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f+xZduZy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 898E92166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48244 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNgWw-0003xi-3u
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 13:04:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57801)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iNfxg-0007C5-OI
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 12:27:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iNfxf-0000jo-K4
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 12:27:44 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:39151)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iNfxf-0000jJ-EF
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 12:27:43 -0400
Received: by mail-wm1-x342.google.com with SMTP id r141so3205804wme.4
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 09:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=zVsNlJ5N2k9sc9bIq4CoBW6EYZLcHxwA40pi1YP50Gg=;
 b=f+xZduZykPOGzSiLR04A1ZUnnV/7uoM9IOOoGmqo+xFRQXg6O93/kE3z5SvWXNMsHV
 INvWCuMfjzyfoh4O0DUxs4T2tJgiwmLHhj1c5CIzrPmsTU53MxcOq0qiCF8dbm5Fqrq/
 D9DT8EHjxdY1AU+evC4e9WahTtJ1oK9bcuTQHMMc22tlsHJQEObtqjwUAzrjOSpZreSS
 iKyaVeEM6Gj8LpxKUonTdo6vTlDPU4fNfwZzCi4D6Q0qS9PKouyqJKwQ7T+KZIL9/OWx
 3ObNgZJL+TZob9dwhgyB2mO01Qt5hpi001+dfvZxUI2nnHguoRus53OqBzBPXmgcmiLT
 o5uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=zVsNlJ5N2k9sc9bIq4CoBW6EYZLcHxwA40pi1YP50Gg=;
 b=mtbYPlEWvjgBAeiZ6Wc/gXKYFc1Ey7fLtm9I876aRildITG56Bo9cz3X9QqktfAeM3
 ka8JFf8XHXj84Jhl+Dh5ijZGhHErTjoWQxbdTPF3UGzJGng98ZA638xHSHCs09K2Y5I/
 XL+/4GWvCa6HqAEjpBgehg44k7e2aiIPvvTbftYzMwlRsvA+dk7i4xsngCN4LbR6kasz
 Lb4HIPK9EzpTNV7zjNK6vOhVpLs9ullc4gEgoCR/Klf8ftsS+fK+S8RBuLMyvPqXFddL
 HgcLaX0S47SLbPHjxkyCaCScRzfruoAvitljJiPUd6YKtno0EqTikl4dnzcAi8W9H9O0
 m8cA==
X-Gm-Message-State: APjAAAXqIRcdYJ9p1D7GFHlhIKGQjN9hqAqjN6D0isbM//S/+ClA0Ssx
 t+YNHmmZTIiJ4YmiIEKOrkiREh9/YII=
X-Google-Smtp-Source: APXvYqwyTfo6h5Mx+ZGqcKQ4WCXiQLKo2WdGvDi8qlf7A28S0LyXebmajJtZwfo0qC5FqPvMkD6fPA==
X-Received: by 2002:a1c:2407:: with SMTP id k7mr5322298wmk.99.1571934461369;
 Thu, 24 Oct 2019 09:27:41 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id r27sm42606124wrc.55.2019.10.24.09.27.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2019 09:27:40 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/51] target/arm: Hoist XSCALE_CPAR, VECLEN,
 VECSTRIDE in cpu_get_tb_cpu_state
Date: Thu, 24 Oct 2019 17:26:44 +0100
Message-Id: <20191024162724.31675-12-peter.maydell@linaro.org>
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

We do not need to compute any of these values for M-profile.
Further, XSCALE_CPAR overlaps VECSTRIDE so obviously the two
sets must be mutually exclusive.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20191023150057.25731-10-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index ddd21edfcf1..e2a62cf19a0 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -11235,21 +11235,28 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
             }
         } else {
             flags = rebuild_hflags_a32(env, fp_el, mmu_idx);
+
+            /*
+             * Note that XSCALE_CPAR shares bits with VECSTRIDE.
+             * Note that VECLEN+VECSTRIDE are RES0 for M-profile.
+             */
+            if (arm_feature(env, ARM_FEATURE_XSCALE)) {
+                flags = FIELD_DP32(flags, TBFLAG_A32,
+                                   XSCALE_CPAR, env->cp15.c15_cpar);
+            } else {
+                flags = FIELD_DP32(flags, TBFLAG_A32, VECLEN,
+                                   env->vfp.vec_len);
+                flags = FIELD_DP32(flags, TBFLAG_A32, VECSTRIDE,
+                                   env->vfp.vec_stride);
+            }
         }
 
         flags = FIELD_DP32(flags, TBFLAG_A32, THUMB, env->thumb);
-        flags = FIELD_DP32(flags, TBFLAG_A32, VECLEN, env->vfp.vec_len);
-        flags = FIELD_DP32(flags, TBFLAG_A32, VECSTRIDE, env->vfp.vec_stride);
         flags = FIELD_DP32(flags, TBFLAG_A32, CONDEXEC, env->condexec_bits);
         if (env->vfp.xregs[ARM_VFP_FPEXC] & (1 << 30)
             || arm_el_is_aa64(env, 1) || arm_feature(env, ARM_FEATURE_M)) {
             flags = FIELD_DP32(flags, TBFLAG_A32, VFPEN, 1);
         }
-        /* Note that XSCALE_CPAR shares bits with VECSTRIDE */
-        if (arm_feature(env, ARM_FEATURE_XSCALE)) {
-            flags = FIELD_DP32(flags, TBFLAG_A32,
-                               XSCALE_CPAR, env->cp15.c15_cpar);
-        }
     }
 
     /* The SS_ACTIVE and PSTATE_SS bits correspond to the state machine
-- 
2.20.1


