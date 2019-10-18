Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37D33CA9EA9
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 17:52:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0772E21835
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 17:52:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XRL03tO8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0772E21835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44314 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLWQ3-0005MS-PC
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 13:52:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59248)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iLWIw-0006YF-M4
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 13:44:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iLWIu-0005Rr-Ri
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 13:44:46 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:35604)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iLWIu-0005QW-Mj
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 13:44:44 -0400
Received: by mail-pf1-x441.google.com with SMTP id 205so4324305pfw.2
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2019 10:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+w+DpqTaqyThsFD3h0g6qTaqlae+kRMVgywC4mwAkDA=;
 b=XRL03tO8pYpwmYBVCiyu9Lv8vVDOHUC7ETMWAW7W1kc8cD43sIBCE0sWA3+7pu2dB7
 o0hkTWRIMmT/oMAPLYyHMBhvV66LFxSnNM0JYwwXGSQC4mOb2cH7Piku0f/HWqAzoz0j
 c8ViFL4Q+ohaJW9+58VcFaGAc1IJl9NEeddcAEZbpTujNH8WHR3HUc6k7Z0C8wdf5s5N
 MpgJM8k5CvUqak5s9CyqlLbClfN4BtqoUT8Y6nrPIgxR1vdImJUkBqQCLLZo9RLD7WXC
 /7UfyEoLA9MePfONCv1BsJ8FRSzf6v9WPYXSj4rSzE2Cc0KP05VNs2SCiXcs5CYZ1ov5
 xKgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+w+DpqTaqyThsFD3h0g6qTaqlae+kRMVgywC4mwAkDA=;
 b=aosH+gi21GO2qpAUtAUZD2SNezPjJu9XClpkr9MEAdJd2lmRJv6X6WWP4V0CgBdPWw
 XbcEWlVCTA8Jvum/sjBS74/s6NxovkAtPkKIZsOQ0aukqfH72Odo6cZnf3fIxoMLpMOm
 Rc/4RTAYOmCynxqCMiNRULeD9/1BlY9RkJOFit0kzGMHv3fJXoZkyHHDb0mHcEmPLHuG
 vxchvWcTEsfT52lTXi7wNlMrNMLcS10ZWXIggX9/HO0fixX+L/E8nPNu6Tw+uKfuzf+r
 ykGaadVsjEN1TnejcdgXbDhmJgsPj8kTITx7BxjQVW/TF7HsGohUik6AP1RM21tY2Ugp
 KhnA==
X-Gm-Message-State: APjAAAVKwaoOzqdBusujYVuxZB8hpvQIM7qQutrw9bRSq7OThQsQhtc5
 CNhbK7XPw1WadmIAfQGrlV5EFhrZSmk=
X-Google-Smtp-Source: APXvYqytVUYW2cMjAgUhtXmNs96M/WjGkTPmKysgz8cOAx+n+I4gJA9n9Woztx7W2tyHhTIEfPZzvw==
X-Received: by 2002:a62:b504:: with SMTP id y4mr7982540pfe.124.1571420683357; 
 Fri, 18 Oct 2019 10:44:43 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id d20sm7857534pfq.88.2019.10.18.10.44.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Oct 2019 10:44:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 09/22] target/arm: Hoist XSCALE_CPAR, VECLEN,
 VECSTRIDE in cpu_get_tb_cpu_state
Date: Fri, 18 Oct 2019 10:44:18 -0700
Message-Id: <20191018174431.1784-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191018174431.1784-1-richard.henderson@linaro.org>
References: <20191018174431.1784-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
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

We do not need to compute any of these values for M-profile.
Further, XSCALE_CPAR overlaps VECSTRIDE so obviously the two
sets must be mutually exclusive.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index ddd21edfcf..e2a62cf19a 100644
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
2.17.1


