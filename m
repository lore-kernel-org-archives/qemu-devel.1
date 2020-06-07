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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D97C1C433E0
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Jun 2020 20:02:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2C1B2075A
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Jun 2020 20:02:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZGSKPZVm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2C1B2075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ji1VC-0006cv-VX
	for qemu-devel@archiver.kernel.org; Sun, 07 Jun 2020 16:02:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59898)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1ji1Fi-0003yE-CS
 for qemu-devel@nongnu.org; Sun, 07 Jun 2020 15:46:43 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330]:38073)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1ji1Fg-0004ms-2m
 for qemu-devel@nongnu.org; Sun, 07 Jun 2020 15:46:42 -0400
Received: by mail-wm1-x330.google.com with SMTP id f185so14380226wmf.3
 for <qemu-devel@nongnu.org>; Sun, 07 Jun 2020 12:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=bMx4kzjHRHhQJjT8ZJt6++cIuGHlJtI86oQzfpzysks=;
 b=ZGSKPZVmOiAY1DygNYH9KslpilPMW5s46d4TNCNxMGbEtDFp+e0Zyd22BjwG4S5RuA
 3iHsS6zwlq2cff64LHb+o3ytOmNDJmrcZHQUl4soBTEdI0v84G3QgdBgIVlTzHFmQ5B4
 YELnis8Qkdb+y9qssMOiXqfxm7RK4B8DMV688vXQj/PZDY2ht6vyVPDoAPPpf6EpPbEv
 ikvOWqnaL6Zuu7h3kVV/k4PgVw4mjYfXA2GDZScbQkJEpCNCeqiIv+NPQx/v2g2jX68K
 2lgcYvakKkBgUYmKxrKk3Gc0pepjxYcXVNtQOsGfdkHQPXCugI9mgd+6X01T3EIjvud2
 /6qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=bMx4kzjHRHhQJjT8ZJt6++cIuGHlJtI86oQzfpzysks=;
 b=O0UblokSWaQ/U5UGw0FBXPnseK+32+bHGkGZ+x7XMgmqkYRkUKMtmbF4XxCKXOQ2Vb
 7P3BO2lLGwWnzMNDTT9GOtIEskzdnh9J87Y9VjNDUNBoIbKgEn4rMPHL9+Mk6/HJmmE2
 DvaKsmhpMZmxoCGxBK7Jyig+lMsd7+V8v1QbuQeR1hreR42pixNbq25z3SzNJdP5id9P
 Dp6sQgqacbQI+5WrQsuooUkD39BTFGwLFXNvbTotaHhKpTsOU4ScuRLRI4RwbXePlxbN
 bpfoX7UaSLamCcI7Sk9qTs8n6GqrpoxX+GP2IvF/fWmkL2InfSs3ADDxaki+sl5b0gVU
 FLSQ==
X-Gm-Message-State: AOAM533hgj/f8YCwyMe8BApd6ZyakLM3aHKD515kY7D1vtvWzJzCyqGd
 QJT//MOC0M8eiwjk3+I2V3jhHnL5
X-Google-Smtp-Source: ABdhPJzSrEKObrdV4Ls31HkME4Sw9Euz2BNCBU1jULluqTN+mJE9K/5sHvGYHNuZDKOVGJaM2E1MHw==
X-Received: by 2002:a1c:19c1:: with SMTP id 184mr12422572wmz.29.1591559197175; 
 Sun, 07 Jun 2020 12:46:37 -0700 (PDT)
Received: from rtrkw774-lin.syrmia.com ([46.240.135.226])
 by smtp.gmail.com with ESMTPSA id u130sm21091339wmg.32.2020.06.07.12.46.36
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 07 Jun 2020 12:46:36 -0700 (PDT)
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Subject: [PULL 15/21] target/mips: fpu: Demacro RINT.<D|S>
Date: Sun,  7 Jun 2020 21:46:19 +0200
Message-Id: <1591559185-31287-16-git-send-email-aleksandar.qemu.devel@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1591559185-31287-1-git-send-email-aleksandar.qemu.devel@gmail.com>
References: <1591559185-31287-1-git-send-email-aleksandar.qemu.devel@gmail.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wm1-x330.google.com
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
Message-Id: <20200518200920.17344-14-aleksandar.qemu.devel@gmail.com>
---
 target/mips/fpu_helper.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/target/mips/fpu_helper.c b/target/mips/fpu_helper.c
index e227e53..dae1331 100644
--- a/target/mips/fpu_helper.c
+++ b/target/mips/fpu_helper.c
@@ -1113,10 +1113,26 @@ uint ## bits ## _t helper_float_ ## name(CPUMIPSState *env,                 \
     return fdret;                                                           \
 }
 
-FLOAT_RINT(rint_s, 32)
-FLOAT_RINT(rint_d, 64)
 #undef FLOAT_RINT
 
+uint64_t helper_float_rint_d(CPUMIPSState *env, uint64_t fs)
+{
+    uint64_t fdret;
+
+    fdret = float64_round_to_int(fs, &env->active_fpu.fp_status);
+    update_fcr31(env, GETPC());
+    return fdret;
+}
+
+uint32_t helper_float_rint_s(CPUMIPSState *env, uint32_t fs)
+{
+    uint32_t fdret;
+
+    fdret = float32_round_to_int(fs, &env->active_fpu.fp_status);
+    update_fcr31(env, GETPC());
+    return fdret;
+}
+
 #define FLOAT_CLASS_SIGNALING_NAN      0x001
 #define FLOAT_CLASS_QUIET_NAN          0x002
 #define FLOAT_CLASS_NEGATIVE_INFINITY  0x004
-- 
2.7.4


