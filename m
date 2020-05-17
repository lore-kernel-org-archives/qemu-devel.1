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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AAEEC433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2020 09:25:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E65A8206D5
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2020 09:25:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a/iTsoQ3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E65A8206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52812 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jaFXw-0006Bt-36
	for qemu-devel@archiver.kernel.org; Sun, 17 May 2020 05:25:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36660)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jaFWx-0004Cj-N0
 for qemu-devel@nongnu.org; Sun, 17 May 2020 05:24:23 -0400
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:36821)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jaFWx-0001nQ-04
 for qemu-devel@nongnu.org; Sun, 17 May 2020 05:24:23 -0400
Received: by mail-lj1-x242.google.com with SMTP id u15so6644888ljd.3
 for <qemu-devel@nongnu.org>; Sun, 17 May 2020 02:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=U9Bvm6vL09AIwqK4OvW6xKwpQP6QGlp9aoqhYUD54/M=;
 b=a/iTsoQ3osCKtLaIrmnQAjdz3Fy139XyJHIazlzjJo9m04dKuei24Hw7JXO6vVxHqN
 43FPeCmlP9IJ9svEzJRSu6ulxqR3ACIAzJ/p15KI/qMDAeruv2ieReRk/en4H2wTcsiS
 R7cSK8OfSq1k3YK00tXbfM9rs+yRrXzKwXWqyNx4S44NyY4N9iV+Un8rVWTAF4cuuykZ
 dHZRFVg8lNs2Edfrz94zN3oYUeA7Ryi3YNs0SoJVUcTdIKo/Cw0IJ1Mvor7RoMqjLInY
 f0nGMKVisKLKh7LQ0pgUi4cp+sseGfzw4BDoUM6MjTfjjQxmX4QxiqwlnlRqmjDajRET
 73yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=U9Bvm6vL09AIwqK4OvW6xKwpQP6QGlp9aoqhYUD54/M=;
 b=WSIA7zoXEipMWcOTB/hGvoet8Uqdr+jlApHXInkPj+zNiT6UNZgGxcjgqOXq5HC5wC
 l5vfRloL2nEtwxxZGiIHlon5HcUYgwh2ZSA3qKpJmT/5ETXqYVIHP+EyKAhnmMZFfVju
 nPOBbwQo5mV8K+6QZGXjVQDCYTETvuNVdJ/7f8Fub/NwlLIWs6js0i988XW09pEr/ruz
 w/jM7/Dken3JqQCNsnqyBdbc3DBPbOh+ELV2W5X65iC+p1wOUlRVdHPP+dr7mosvkDPO
 t8RYPH7vrpl/397DLoUTrn02YHY06j/0WnW38f/ixS/Wtpa+nliHfv7HTRZrG26MkrUd
 0EVQ==
X-Gm-Message-State: AOAM5304dV27gwbYihfwJBhCrhY16ph+6Q4SLybXzLqymKY5AoQLhrxc
 MvBDjErW58g08JrI6KYBpip7sbhfzN8=
X-Google-Smtp-Source: ABdhPJwH7b2htsmdwOnEDBucwXd2HncwrXl0W+YxI2mhyhIddDTMrWowX/+owAyh3q9l3KR8LcJQlw==
X-Received: by 2002:a2e:a211:: with SMTP id h17mr7548902ljm.289.1589707461380; 
 Sun, 17 May 2020 02:24:21 -0700 (PDT)
Received: from localhost.localdomain ([109.245.227.98])
 by smtp.gmail.com with ESMTPSA id l2sm3872138ljg.89.2020.05.17.02.24.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 May 2020 02:24:21 -0700 (PDT)
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 05/19] target/mips: fpu: Remove now unused macro FLOAT_BINOP
Date: Sun, 17 May 2020 11:23:43 +0200
Message-Id: <20200517092357.1469-6-aleksandar.qemu.devel@gmail.com>
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

After demacroing <ADD|SUB|MUL|DIV>.<D|S|PS>, this macro is not
needed anymore.

Signed-off-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
---
 target/mips/fpu_helper.c | 39 ---------------------------------------
 1 file changed, 39 deletions(-)

diff --git a/target/mips/fpu_helper.c b/target/mips/fpu_helper.c
index 2759c9989d..a3a39681f8 100644
--- a/target/mips/fpu_helper.c
+++ b/target/mips/fpu_helper.c
@@ -1170,45 +1170,6 @@ FLOAT_CLASS(class_d, 64)
 #undef FLOAT_CLASS
 
 /* binary operations */
-#define FLOAT_BINOP(name)                                          \
-uint64_t helper_float_ ## name ## _d(CPUMIPSState *env,            \
-                                     uint64_t fdt0, uint64_t fdt1) \
-{                                                                  \
-    uint64_t dt2;                                                  \
-                                                                   \
-    dt2 = float64_ ## name(fdt0, fdt1, &env->active_fpu.fp_status);\
-    update_fcr31(env, GETPC());                                    \
-    return dt2;                                                    \
-}                                                                  \
-                                                                   \
-uint32_t helper_float_ ## name ## _s(CPUMIPSState *env,            \
-                                     uint32_t fst0, uint32_t fst1) \
-{                                                                  \
-    uint32_t wt2;                                                  \
-                                                                   \
-    wt2 = float32_ ## name(fst0, fst1, &env->active_fpu.fp_status);\
-    update_fcr31(env, GETPC());                                    \
-    return wt2;                                                    \
-}                                                                  \
-                                                                   \
-uint64_t helper_float_ ## name ## _ps(CPUMIPSState *env,           \
-                                      uint64_t fdt0,               \
-                                      uint64_t fdt1)               \
-{                                                                  \
-    uint32_t fst0 = fdt0 & 0XFFFFFFFF;                             \
-    uint32_t fsth0 = fdt0 >> 32;                                   \
-    uint32_t fst1 = fdt1 & 0XFFFFFFFF;                             \
-    uint32_t fsth1 = fdt1 >> 32;                                   \
-    uint32_t wt2;                                                  \
-    uint32_t wth2;                                                 \
-                                                                   \
-    wt2 = float32_ ## name(fst0, fst1, &env->active_fpu.fp_status);     \
-    wth2 = float32_ ## name(fsth0, fsth1, &env->active_fpu.fp_status);  \
-    update_fcr31(env, GETPC());                                    \
-    return ((uint64_t)wth2 << 32) | wt2;                           \
-}
-
-#undef FLOAT_BINOP
 
 uint64_t helper_float_add_d(CPUMIPSState *env,
                             uint64_t fdt0, uint64_t fdt1)
-- 
2.20.1


