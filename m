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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F15BC433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2020 09:26:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1C87206D5
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2020 09:26:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gncmjEyW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1C87206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60800 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jaFZE-00011x-0W
	for qemu-devel@archiver.kernel.org; Sun, 17 May 2020 05:26:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36642)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jaFWt-00044o-E6
 for qemu-devel@nongnu.org; Sun, 17 May 2020 05:24:19 -0400
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:46607)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jaFWr-0001mn-I8
 for qemu-devel@nongnu.org; Sun, 17 May 2020 05:24:19 -0400
Received: by mail-lj1-x242.google.com with SMTP id f18so6610410lja.13
 for <qemu-devel@nongnu.org>; Sun, 17 May 2020 02:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=xJKvZWQFMn9VprRv2pADfNDp4/qI8q0H7WxNbnq8wtU=;
 b=gncmjEyWKQ2W6nHmJEJZ8jJB4dyZsVLL6hW13vX32OzwO3y6JwQpF4N8WaE0QsvQqt
 jtw1eZEcrjFi7k92EKcFbMg6O6zEUxOYdoZV5lR3nVZ4Wn8/VZPw+7FCz8lHbYTu4AGQ
 ARfnZimWh0CtmnRNTWntDJo6YwEaKGID6jsBwCfYAB0OGycqdCTYARI9ACqIpYKjqDG5
 RaKUV5tCCsd+RQqSXWCObuX0tzoAuyhVpB0yRnRGLlroVJi9Cw8O/nHKbksXH+die94+
 b8FhILx49XQYWWX3TLyyYHfFEQnMAk46H/inBaRuGks3WB1ImNI3GmfRtxIKtqxQ6Txo
 d+zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=xJKvZWQFMn9VprRv2pADfNDp4/qI8q0H7WxNbnq8wtU=;
 b=tPM7OwfK/rBZPQRyKfE9BP4s6Dj/Wjc83blw8DeLu7FzxBXio4Ty1uYQkIE0yGHn2n
 kOHThR6BtknmWWl5oEDPOySeSbm8LiRd9xuOPq8MTfiRA9afDyidUjusVj2NUPI9KmY7
 DhEqFwUtt6sytUj6nI/oXHKREmsOw3uHBTR10CzWJQi1tqt+FYVGqqdE36LssYNbkrrG
 YTRtk8SLWFSJoyfoHCLyIBkPV4EBaysg2rT7Wy/HZrhCxstWu546NHKtX6jz/JsDLSQN
 tYfLiJ/Y8zV+sPJIvRl02yW8QsBxaRGfBl8wc6kyYpLqeSQsTzzx8ZvDEZf3OG14sobm
 IeqQ==
X-Gm-Message-State: AOAM532kDC/BU58SnePlPMpu1Wo7BrHrE9q8DQOPVa2G8IBYrP+7ak/1
 GN6yrvfGadm85PwrYBdSQDmqEt/WXiY=
X-Google-Smtp-Source: ABdhPJxLWt+pmDUveyw+nnOhEHJVkDzjoTeqlJOoAl2/eDarnOC3JUoJ4bYjsUrKnWK/tfjoZYPuYw==
X-Received: by 2002:a2e:b5a2:: with SMTP id f2mr300987ljn.261.1589707455923;
 Sun, 17 May 2020 02:24:15 -0700 (PDT)
Received: from localhost.localdomain ([109.245.227.98])
 by smtp.gmail.com with ESMTPSA id l2sm3872138ljg.89.2020.05.17.02.24.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 May 2020 02:24:15 -0700 (PDT)
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 02/19] target/mips: fpu: Demacro SUB.<D|S|PS>
Date: Sun, 17 May 2020 11:23:40 +0200
Message-Id: <20200517092357.1469-3-aleksandar.qemu.devel@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200517092357.1469-1-aleksandar.qemu.devel@gmail.com>
References: <20200517092357.1469-1-aleksandar.qemu.devel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::242;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-lj1-x242.google.com
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
index 984f3f4dfb..715a872cae 100644
--- a/target/mips/fpu_helper.c
+++ b/target/mips/fpu_helper.c
@@ -1208,7 +1208,6 @@ uint64_t helper_float_ ## name ## _ps(CPUMIPSState *env,           \
     return ((uint64_t)wth2 << 32) | wt2;                           \
 }
 
-FLOAT_BINOP(sub)
 FLOAT_BINOP(mul)
 FLOAT_BINOP(div)
 #undef FLOAT_BINOP
@@ -1249,6 +1248,42 @@ uint64_t helper_float_add_ps(CPUMIPSState *env,
     return ((uint64_t)wth2 << 32) | wtl2;
 }
 
+uint64_t helper_float_sub_d(CPUMIPSState *env,
+                            uint64_t fdt0, uint64_t fdt1)
+{
+    uint64_t dt2;
+
+    dt2 = float64_sub(fdt0, fdt1, &env->active_fpu.fp_status);
+    update_fcr31(env, GETPC());
+    return dt2;
+}
+
+uint32_t helper_float_sub_s(CPUMIPSState *env,
+                            uint32_t fst0, uint32_t fst1)
+{
+    uint32_t wt2;
+
+    wt2 = float32_sub(fst0, fst1, &env->active_fpu.fp_status);
+    update_fcr31(env, GETPC());
+    return wt2;
+}
+
+uint64_t helper_float_sub_ps(CPUMIPSState *env,
+                             uint64_t fdt0, uint64_t fdt1)
+{
+    uint32_t fstl0 = fdt0 & 0XFFFFFFFF;
+    uint32_t fsth0 = fdt0 >> 32;
+    uint32_t fstl1 = fdt1 & 0XFFFFFFFF;
+    uint32_t fsth1 = fdt1 >> 32;
+    uint32_t wtl2;
+    uint32_t wth2;
+
+    wtl2 = float32_sub(fstl0, fstl1, &env->active_fpu.fp_status);
+    wth2 = float32_sub(fsth0, fsth1, &env->active_fpu.fp_status);
+    update_fcr31(env, GETPC());
+    return ((uint64_t)wth2 << 32) | wtl2;
+}
+
 
 /* MIPS specific binary operations */
 uint64_t helper_float_recip2_d(CPUMIPSState *env, uint64_t fdt0, uint64_t fdt2)
-- 
2.20.1


