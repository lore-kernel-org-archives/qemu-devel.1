Return-Path: <SRS0=EQsI=67=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2FDBC433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2020 09:26:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADE9D206D5
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2020 09:26:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="olK3iMxe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADE9D206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60462 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jaFZA-0000tn-RI
	for qemu-devel@archiver.kernel.org; Sun, 17 May 2020 05:26:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36650)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jaFWv-00049W-Ul
 for qemu-devel@nongnu.org; Sun, 17 May 2020 05:24:21 -0400
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:45699)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jaFWu-0001nA-V9
 for qemu-devel@nongnu.org; Sun, 17 May 2020 05:24:21 -0400
Received: by mail-lj1-x241.google.com with SMTP id h4so6610468ljg.12
 for <qemu-devel@nongnu.org>; Sun, 17 May 2020 02:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Hp/YCDbUF4k/Qi0Hzps0dHG39YUDYzBviudtOCIRUBo=;
 b=olK3iMxe7Pm0BQxoTVzWbJZrfUOS/VT3+S+QElbcfIu5HN4EXlZzYAIij96TahAeWw
 qqYPlAFRMweJJ845I0sbRMQAkf7rmkVKbJrrD9bQDgvoXHgFPkwJUyQZO9vTfp91Aj/3
 mYMazJgqeQKxveeCepsbzI5w9unWL1rBKck307hdiJkAkC5J4vE0xLf7L9IwRlEHZ7Iw
 t3pspr0BK9YiIr/zkvQ/iO72DmD1bJxTySCgkCJXSLEuyP8LcxuJuN8se/R/1XMtI2W/
 iZP1rk3ZGHwUhloSZj0FZzNZ2aFNWBbhvp7Q8VkMUO/dUratyG5886QBwZU5caDFW9a/
 nt2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Hp/YCDbUF4k/Qi0Hzps0dHG39YUDYzBviudtOCIRUBo=;
 b=n4NWKL/D2AULvqRs5o21eFDVddNPSYXYy04aHZW/Bv8KGgKg/E0olQycT+l31z7EEu
 V43yZqxOBgwtO7v+MRx78qyIvx/A5/Td3fJm/jbHaPuN99BWDJxXoUNqBdjurdocpeNW
 JtOo/+lZbTtuCrtRG6QIUY1lSuWZS6WXb7qzB1kV5kh0Xm3LmYVkbfvxOWkHl3N2gG6E
 dFQ7tm3P41rbkBbUbL5xvqO0jeAzX17Zw4mq9nMpPh4R1ZRGq0ot1v5ILiS498Y4Y/sL
 fdU726+wpMau5+TTDm5C81L9XpODxgk3LpWSFJ0Jn6txCC6XjxRqDRdJNMW0HvdNYNCK
 np/A==
X-Gm-Message-State: AOAM533kmL4AREIBPoQ9Uxqk32A12yPzet6JfHi6A+hZLqwZoWBFUvcf
 l2rbtSQgeH75LDSXbYyDVaTDx69dEvw=
X-Google-Smtp-Source: ABdhPJyhMH5/GgBWGHENNLibGqRC8AdvJU/W523TmFkVNi2lCO1b1r2ZN/h/nBpWHLLNlFwmAO+Kvw==
X-Received: by 2002:a2e:2245:: with SMTP id i66mr7406781lji.191.1589707459274; 
 Sun, 17 May 2020 02:24:19 -0700 (PDT)
Received: from localhost.localdomain ([109.245.227.98])
 by smtp.gmail.com with ESMTPSA id l2sm3872138ljg.89.2020.05.17.02.24.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 May 2020 02:24:18 -0700 (PDT)
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 03/19] target/mips: fpu: Demacro MUL.<D|S|PS>
Date: Sun, 17 May 2020 11:23:41 +0200
Message-Id: <20200517092357.1469-4-aleksandar.qemu.devel@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200517092357.1469-1-aleksandar.qemu.devel@gmail.com>
References: <20200517092357.1469-1-aleksandar.qemu.devel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::241;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-lj1-x241.google.com
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
Cc: aleksandar.rikalo@syrmia.com,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is just a cosmetic change to enable tools like gcov, gdb,
callgrind, etc. to better display involved source code.

Signed-off-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
---
 target/mips/fpu_helper.c | 37 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/target/mips/fpu_helper.c b/target/mips/fpu_helper.c
index 715a872cae..449e945166 100644
--- a/target/mips/fpu_helper.c
+++ b/target/mips/fpu_helper.c
@@ -1208,7 +1208,6 @@ uint64_t helper_float_ ## name ## _ps(CPUMIPSState *env,           \
     return ((uint64_t)wth2 << 32) | wt2;                           \
 }
 
-FLOAT_BINOP(mul)
 FLOAT_BINOP(div)
 #undef FLOAT_BINOP
 
@@ -1284,6 +1283,42 @@ uint64_t helper_float_sub_ps(CPUMIPSState *env,
     return ((uint64_t)wth2 << 32) | wtl2;
 }
 
+uint64_t helper_float_mul_d(CPUMIPSState *env,
+                            uint64_t fdt0, uint64_t fdt1)
+{
+    uint64_t dt2;
+
+    dt2 = float64_mul(fdt0, fdt1, &env->active_fpu.fp_status);
+    update_fcr31(env, GETPC());
+    return dt2;
+}
+
+uint32_t helper_float_mul_s(CPUMIPSState *env,
+                            uint32_t fst0, uint32_t fst1)
+{
+    uint32_t wt2;
+
+    wt2 = float32_mul(fst0, fst1, &env->active_fpu.fp_status);
+    update_fcr31(env, GETPC());
+    return wt2;
+}
+
+uint64_t helper_float_mul_ps(CPUMIPSState *env,
+                             uint64_t fdt0, uint64_t fdt1)
+{
+    uint32_t fstl0 = fdt0 & 0XFFFFFFFF;
+    uint32_t fsth0 = fdt0 >> 32;
+    uint32_t fstl1 = fdt1 & 0XFFFFFFFF;
+    uint32_t fsth1 = fdt1 >> 32;
+    uint32_t wtl2;
+    uint32_t wth2;
+
+    wtl2 = float32_mul(fstl0, fstl1, &env->active_fpu.fp_status);
+    wth2 = float32_mul(fsth0, fsth1, &env->active_fpu.fp_status);
+    update_fcr31(env, GETPC());
+    return ((uint64_t)wth2 << 32) | wtl2;
+}
+
 
 /* MIPS specific binary operations */
 uint64_t helper_float_recip2_d(CPUMIPSState *env, uint64_t fdt0, uint64_t fdt2)
-- 
2.20.1


