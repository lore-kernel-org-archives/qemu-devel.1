Return-Path: <SRS0=Pynu=7U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90309C433E0
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Jun 2020 19:51:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5575920663
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Jun 2020 19:51:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vPNs+2F6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5575920663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40002 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ji1KO-0000qn-IS
	for qemu-devel@archiver.kernel.org; Sun, 07 Jun 2020 15:51:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59842)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1ji1FZ-0003qo-B8
 for qemu-devel@nongnu.org; Sun, 07 Jun 2020 15:46:33 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329]:33249)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1ji1FY-0004lC-GC
 for qemu-devel@nongnu.org; Sun, 07 Jun 2020 15:46:33 -0400
Received: by mail-wm1-x329.google.com with SMTP id j198so12847840wmj.0
 for <qemu-devel@nongnu.org>; Sun, 07 Jun 2020 12:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=LcgvF2tz7kWMpz1d96iDb8Fsi5AAlyDPfQKDrdqN35Q=;
 b=vPNs+2F6cXvbQmAC4T0Xx8VreHc91/eyhSi6aZUADxMbxZeo9hrdznEyc+FIGD3/7X
 r1IsbR7CLmJQCmq7jxOc4N6rErdYMeW6tBo2+wBOBDFfoD1Y1ehzZJ+ACC2o7w4hhdpT
 0ra1XQNGOKzL7x404lQSqJh43LndxRPkJAoDiFOOXuVcvFm06bFie3K/5GyrvyeWMnvL
 N7ugPd7c5iHkv0YaD2M3Awl3NNzD2ZYzMf7Wm0tnbJwOqaeiJUmV6XReoOs4WKWYUlAo
 ACMcsaFq11EYdl/73Cs0s0BhcxcHpdrptnR6EZBFSk1F4fWni2bAGgHSpvKY8XHrB9Yu
 A2Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=LcgvF2tz7kWMpz1d96iDb8Fsi5AAlyDPfQKDrdqN35Q=;
 b=UxU9Vgyt+NvsJQr3Go5MDsGCPrHnAhARKAZSat2FbGHAc761wxf/9WSgQKm2TnbTfc
 mXhyJBztjyxHspqQxiAOqla6QSjyvGixzK/VombpVsabo20RQ+iqlOiSkPrjE/3gdyfG
 Oz9Lvh5rvgGXhyGRUVqso7qFeWFUKeRR9z3FukDOaEJuxYh4OSyMyL8QfcwbAr5G8rlX
 bORWalb2jh3MStLOR4qCsI1N4K0VGBrl6i2IgksqT2QHEHez9/+rl0pZRymPd6eF44jI
 f4p/TlfaUc0jqVzqrg/ol5mbbTgiv8r8QkbziIGdgqzEXtc6JRB4MekIE0JaATtfTwOV
 nZYQ==
X-Gm-Message-State: AOAM532ySD/k2HAUoGI6QboFKqqpwJumZr3oBcCrs4Svn7C57l//aUaI
 +HcImVaCXckcU0bo5NwE5abyGwEs
X-Google-Smtp-Source: ABdhPJxG2c488faymFaOJ2cuvoV3wM78VMT4dZ9E98jxkrpI9D0xyu1DpR/YYZDK+IiLYktxuWbcfg==
X-Received: by 2002:a1c:4d14:: with SMTP id o20mr12657498wmh.164.1591559191047; 
 Sun, 07 Jun 2020 12:46:31 -0700 (PDT)
Received: from rtrkw774-lin.syrmia.com ([46.240.135.226])
 by smtp.gmail.com with ESMTPSA id u130sm21091339wmg.32.2020.06.07.12.46.30
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 07 Jun 2020 12:46:30 -0700 (PDT)
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Subject: [PULL 06/21] target/mips: fpu: Demacro DIV.<D|S|PS>
Date: Sun,  7 Jun 2020 21:46:10 +0200
Message-Id: <1591559185-31287-7-git-send-email-aleksandar.qemu.devel@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1591559185-31287-1-git-send-email-aleksandar.qemu.devel@gmail.com>
References: <1591559185-31287-1-git-send-email-aleksandar.qemu.devel@gmail.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wm1-x329.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: aleksandar.qemu.devel@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is just a cosmetic change to enable tools like gcov, gdb,
callgrind, etc. to better display involved source code.

Reviewed-by: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
Signed-off-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Message-Id: <20200518200920.17344-5-aleksandar.qemu.devel@gmail.com>
---
 target/mips/fpu_helper.c | 37 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/target/mips/fpu_helper.c b/target/mips/fpu_helper.c
index 449e945..2759c99 100644
--- a/target/mips/fpu_helper.c
+++ b/target/mips/fpu_helper.c
@@ -1208,7 +1208,6 @@ uint64_t helper_float_ ## name ## _ps(CPUMIPSState *env,           \
     return ((uint64_t)wth2 << 32) | wt2;                           \
 }
 
-FLOAT_BINOP(div)
 #undef FLOAT_BINOP
 
 uint64_t helper_float_add_d(CPUMIPSState *env,
@@ -1319,6 +1318,42 @@ uint64_t helper_float_mul_ps(CPUMIPSState *env,
     return ((uint64_t)wth2 << 32) | wtl2;
 }
 
+uint64_t helper_float_div_d(CPUMIPSState *env,
+                            uint64_t fdt0, uint64_t fdt1)
+{
+    uint64_t dt2;
+
+    dt2 = float64_div(fdt0, fdt1, &env->active_fpu.fp_status);
+    update_fcr31(env, GETPC());
+    return dt2;
+}
+
+uint32_t helper_float_div_s(CPUMIPSState *env,
+                            uint32_t fst0, uint32_t fst1)
+{
+    uint32_t wt2;
+
+    wt2 = float32_div(fst0, fst1, &env->active_fpu.fp_status);
+    update_fcr31(env, GETPC());
+    return wt2;
+}
+
+uint64_t helper_float_div_ps(CPUMIPSState *env,
+                             uint64_t fdt0, uint64_t fdt1)
+{
+    uint32_t fstl0 = fdt0 & 0XFFFFFFFF;
+    uint32_t fsth0 = fdt0 >> 32;
+    uint32_t fstl1 = fdt1 & 0XFFFFFFFF;
+    uint32_t fsth1 = fdt1 >> 32;
+    uint32_t wtl2;
+    uint32_t wth2;
+
+    wtl2 = float32_div(fstl0, fstl1, &env->active_fpu.fp_status);
+    wth2 = float32_div(fsth0, fsth1, &env->active_fpu.fp_status);
+    update_fcr31(env, GETPC());
+    return ((uint64_t)wth2 << 32) | wtl2;
+}
+
 
 /* MIPS specific binary operations */
 uint64_t helper_float_recip2_d(CPUMIPSState *env, uint64_t fdt0, uint64_t fdt2)
-- 
2.7.4


