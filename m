Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EA4FCA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 13:53:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBA6A2184C
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 13:53:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l4uahlPp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBA6A2184C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57770 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMuaw-00019i-GW
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 09:53:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36865)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iMuGw-0002qN-Kt
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 09:32:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iMuGv-0001MJ-Ee
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 09:32:26 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:35171)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iMuGv-0001M6-8b
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 09:32:25 -0400
Received: by mail-wm1-x342.google.com with SMTP id v9so267854wml.0
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2019 06:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=QWlvz9xoCtL9FPUpzDpAooVc9XHZ3LGO0EPWiVhUPtw=;
 b=l4uahlPp3p+6sqjOpsjWFo/nUVlBGKvgkXX7b0oZR3CqIvIKYkMmKsIbkvFIzaXOBe
 cv+hMiQU92mvARh+vjCOa1a8lW/qpGU//wz2FIp3sJLJoW6isWLIV7ke2Uq23vuKetc9
 4fBUEWS8SG8SbCif4UfuTs5QbccB9hROSuAZ9OO1JWtoZJ00O9e3SFuPh8SZxWiXdc8Y
 KuXoo6mXDcka/CpvBy5FgMUI4c4FGggryVo3Ctn7ASEEupHKLAl9GC7B5EqTxqEzXyU8
 51t9JVhx29Mw3DntCfMRFIggA3bss9CvdM6zlKg0UUdpUjA9mqmKvzu00dCxOl2vWekK
 DvfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=QWlvz9xoCtL9FPUpzDpAooVc9XHZ3LGO0EPWiVhUPtw=;
 b=qBlf6ZdiIac4mGE0P4Y4JzZvZPhKdKF1TxpX6dNMZe7BAwaFgIuIBo8roYlp1emaRr
 eHI9oKABKFHshmGnIDekRCuGkbxAktqyMlZ9hhJSMOF6SE9SvW7VqUpNnQzK8M53EkOM
 ZmQjQMMyyCunZiUO6zRwst+kH2KmeBHnBRf+BWjYW2VraKKI/Mo4u4Iqd5PNfqBbn640
 vaEmv2FowhSXNCmAGEAS+f8+/zYmOvnvwIfjsTVqHkqv81Y87moEGtsZVZd3ZfG9VNEz
 D7Jf8VdLItB0pdKNlWIbtnfLzOeMLH1KYUy+wUTJFO/N2RSfQpJNbEiSbH3Hfn75+HGV
 +R9A==
X-Gm-Message-State: APjAAAVFiRnwQSnk5UZ3hUNA0ubnh1gdn6vkcnBOrnTpgZ5ShyLXCjMG
 vfh0IalxWz/rO3ZuMhojnSPrSgQHc0w=
X-Google-Smtp-Source: APXvYqw00BvZvPvTYZ/37N5PRWnTWWVeNduXOJe/cBw+9PwPbHPEMkZrDk7wc4hcdHOsgk+nrqSvfg==
X-Received: by 2002:a05:600c:28d:: with SMTP id
 13mr3288572wmk.100.1571751143281; 
 Tue, 22 Oct 2019 06:32:23 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id r2sm20263856wma.1.2019.10.22.06.32.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2019 06:32:21 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 19/41] target/arm: Hoist XSCALE_CPAR, VECLEN,
 VECSTRIDE in cpu_get_tb_cpu_state
Date: Tue, 22 Oct 2019 14:31:12 +0100
Message-Id: <20191022133134.14487-20-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191022133134.14487-1-peter.maydell@linaro.org>
References: <20191022133134.14487-1-peter.maydell@linaro.org>
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
Message-id: 20191018174431.1784-10-richard.henderson@linaro.org
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


