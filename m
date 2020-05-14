Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95B3EC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 19:31:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 677DA20643
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 19:31:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rkamHMJ0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 677DA20643
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40658 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZJa3-0005mp-I5
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 15:31:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58190)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jZJQE-0007UC-BH
 for qemu-devel@nongnu.org; Thu, 14 May 2020 15:21:34 -0400
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:38833)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jZJQ9-0007OD-Hl
 for qemu-devel@nongnu.org; Thu, 14 May 2020 15:21:30 -0400
Received: by mail-lj1-x244.google.com with SMTP id e25so4796577ljg.5
 for <qemu-devel@nongnu.org>; Thu, 14 May 2020 12:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=lJgCSZt5mHFIRGTCzDEMalJcIzhFOtdVx1BtWwULXEk=;
 b=rkamHMJ0m9RHTpi9egHe+ABVvl6YHcgFylxArkanii8e8JDMgb1rjAgj1TmaXvvvFo
 r0Mdm1ZWEx2pKqe4nbRMmT6BAac+jhRXT1Op74rEAVtpi5quPKqTFDW6YFly9c+DTbsg
 Has32i2aDwaq4lOH3GX3L6f67b/hd80I9JP6iskRLrvDPfXKX9agDLyxjYzY2Q9F8rXd
 lETGIlm+ZjjL8ITBPoRy79+kMWMD2Y1vT0XBBwtJRSoev0LthXWTDY3FNZrG81CJkW3y
 zWyWSBtOwP8WsFlMeoy/QVmiry0MbYdk0NtVTiSVW0l1tDOnLlRc7mtQT9cr9AU5AdFO
 hcSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=lJgCSZt5mHFIRGTCzDEMalJcIzhFOtdVx1BtWwULXEk=;
 b=iDdAuMeyJcwCGSpwhnb+ZdMpc+q+jrISyMkeTz6do8r3xCSMsG7nMMARfM11Rv94jv
 04UgN/IRpuX7ru0yFxJXq03dPs4Adj4UpAOGzPr4YpTeCVwvEaD/UJfMRZKCnRKYXK62
 8sHi9mzfr6cPA4EXJb0Tx0Nb9R8iI4e0tOaotLsRYYMjkNacBkI2oQTZqTg7ig8KHzB9
 CM5cJ37HfRz4eB/oOiihotZhfDir0l11Zs02yz1FBpjk4KyBgOt3iF/Ir1Ns31T5mTIc
 zqaVUenX23nzoHbaaLGS+BVv5XFWsdU4/Y944iCCpZLKXD/Y9TmukWyPRNJ7/wJceXsP
 SI+w==
X-Gm-Message-State: AOAM530VXATtdt5pFGbEo6awTM1gUD9Ar1yVlOaE1JvFKwq0Ty3/teqi
 KrimWBdX5i3kFGS2vcZGBUD+elN9ANo=
X-Google-Smtp-Source: ABdhPJzMA1lFMXdG84qiTO/LIfzTByLYzE3mM1vI+h2lVAPNjgYLAja/gqhIkw6WLlvDMe4pYbwD9Q==
X-Received: by 2002:a2e:9e45:: with SMTP id g5mr3941074ljk.180.1589484086555; 
 Thu, 14 May 2020 12:21:26 -0700 (PDT)
Received: from localhost.localdomain ([109.245.227.98])
 by smtp.gmail.com with ESMTPSA id h3sm2427257lfk.3.2020.05.14.12.21.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2020 12:21:26 -0700 (PDT)
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 14/17] target/mips: fpu: Remove now unused FLOAT_RINT macro
Date: Thu, 14 May 2020 21:20:44 +0200
Message-Id: <20200514192047.5297-15-aleksandar.qemu.devel@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200514192047.5297-1-aleksandar.qemu.devel@gmail.com>
References: <20200514192047.5297-1-aleksandar.qemu.devel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::244;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-lj1-x244.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: aleksandar.rikalo@rt-rk.com,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

After demacroing RINT.<D|S>, this macro is not needed anymore.

Signed-off-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
---
 target/mips/fpu_helper.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/target/mips/fpu_helper.c b/target/mips/fpu_helper.c
index dae1331f23..56ba49104e 100644
--- a/target/mips/fpu_helper.c
+++ b/target/mips/fpu_helper.c
@@ -1102,19 +1102,6 @@ uint64_t helper_float_rsqrt1_ps(CPUMIPSState *env, uint64_t fdt0)
     return ((uint64_t)fsth2 << 32) | fst2;
 }
 
-#define FLOAT_RINT(name, bits)                                              \
-uint ## bits ## _t helper_float_ ## name(CPUMIPSState *env,                 \
-                                         uint ## bits ## _t fs)             \
-{                                                                           \
-    uint ## bits ## _t fdret;                                               \
-                                                                            \
-    fdret = float ## bits ## _round_to_int(fs, &env->active_fpu.fp_status); \
-    update_fcr31(env, GETPC());                                             \
-    return fdret;                                                           \
-}
-
-#undef FLOAT_RINT
-
 uint64_t helper_float_rint_d(CPUMIPSState *env, uint64_t fs)
 {
     uint64_t fdret;
-- 
2.20.1


