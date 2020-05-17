Return-Path: <SRS0=EQsI=67=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EA65C433E1
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2020 09:26:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EA31206D5
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2020 09:26:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F7BspipO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EA31206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33422 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jaFZL-0001Ma-73
	for qemu-devel@archiver.kernel.org; Sun, 17 May 2020 05:26:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36714)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jaFX7-0004OU-Rg
 for qemu-devel@nongnu.org; Sun, 17 May 2020 05:24:33 -0400
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142]:35234)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jaFX5-0001oY-B3
 for qemu-devel@nongnu.org; Sun, 17 May 2020 05:24:33 -0400
Received: by mail-lf1-x142.google.com with SMTP id 82so5410456lfh.2
 for <qemu-devel@nongnu.org>; Sun, 17 May 2020 02:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=y+crpwaRbz+NuIRuZ2Ykd3V1TrXmhpx6yRUQr18fFhI=;
 b=F7BspipOSEGzE/ofO/51uncWB5CsqZ1GOflLsUlXccQE83AFVLHeiJ43rzoYjdd3VH
 h0gm8+AfXz+79jMi8DD/f4od7l5epwGTSHC0N36Nd+zwWiayiY7eDFcvATHLWJ0m6Q/A
 z5y2WljKOQndY5wkx72/hvG37up9kDi+XsdgZih91phvr+Mv1Ejabd12u4IabdpgCDtP
 IHA+mzJee3KJdafqALEOhpKDD/Uu6jKBUK9bnQNnyKeJcxJ9qveBSZrs6ZfYNVMcoLGp
 KEGqExPV8V7ldiwllzzwDqBgl93Xys+tySxeYNCP+FH2e6HCLXrQL5AcWwrGMFPhes9T
 jLWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=y+crpwaRbz+NuIRuZ2Ykd3V1TrXmhpx6yRUQr18fFhI=;
 b=ofK5uIx9YNzzqkac1ce6oIkePFHq5xH4brccIdmivzr2XSO4zrJPOkwmeDviGymXIj
 e+6nJrqU7we3D76t/3PlpNWmPH34ElRegkQUBE2hnApJTvCJEaoq8DtwKP5IE9VCw58C
 KE7bpLH/HgrCOYVYtLZu0eC4F05cIKqsnqGEQP0V8oy9xGOGzbnAbfk+XrkG5ObYTCBY
 oDGQnTtGESHT3QUutxVUbo3bVVwS6PKEcPg0jUclloHBgZ5jOZ25/meDTTfsM+d4lceW
 sJqm9raZQXbrk6GOTl6sTAu03RhZreAdj69KWqwGtrte7etYDZv5tZyw4sqayZ71ZXuK
 w9ng==
X-Gm-Message-State: AOAM53244ysh8QZOdt5lsTUSIaiZztDXACabulejq7hSljkK1lviAmWk
 TRwOzpJZPeZjlMdA0J3dnsZm5IvFX5k=
X-Google-Smtp-Source: ABdhPJxXIXnkIpGVGhonE0i/D49lsCpOGN/9C3OwCybGfZpBuay0Dtjn7IuJXaBcWpAHT9guguP6Tw==
X-Received: by 2002:ac2:55b2:: with SMTP id y18mr820120lfg.55.1589707469712;
 Sun, 17 May 2020 02:24:29 -0700 (PDT)
Received: from localhost.localdomain ([109.245.227.98])
 by smtp.gmail.com with ESMTPSA id l2sm3872138ljg.89.2020.05.17.02.24.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 May 2020 02:24:29 -0700 (PDT)
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 13/19] target/mips: fpu: Demacro RINT.<D|S>
Date: Sun, 17 May 2020 11:23:51 +0200
Message-Id: <20200517092357.1469-14-aleksandar.qemu.devel@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200517092357.1469-1-aleksandar.qemu.devel@gmail.com>
References: <20200517092357.1469-1-aleksandar.qemu.devel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::142;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-lf1-x142.google.com
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
 target/mips/fpu_helper.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/target/mips/fpu_helper.c b/target/mips/fpu_helper.c
index e227e53f70..dae1331f23 100644
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
2.20.1


