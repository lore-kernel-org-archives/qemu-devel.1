Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E54BC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 19:54:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5511420657
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 19:54:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="khLPBYRz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5511420657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48248 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jalqT-0004DU-FR
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 15:54:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56122)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jalef-0002zv-6Z
 for qemu-devel@nongnu.org; Mon, 18 May 2020 15:42:29 -0400
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141]:36196)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jalee-0004cb-L8
 for qemu-devel@nongnu.org; Mon, 18 May 2020 15:42:28 -0400
Received: by mail-lf1-x141.google.com with SMTP id c21so9140754lfb.3
 for <qemu-devel@nongnu.org>; Mon, 18 May 2020 12:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=srHp7y7eaB09Ui78FaKO8YiovpWzYiDiwsRE19M0Saw=;
 b=khLPBYRzxg8x3tGqWqZujt++OUsh1EN0lPPcYre89k8Yb6zWnz1W2zS5VF8bsK9wHs
 C6RL9AZw7E6jrxqmuvsPnvF+o9XMZEGZ56k/sbKQ9H79CAHzrdLLY5zPx4Jdiw99a6v+
 ynEZGQ8FwcnEzQK79pOXGgzcJkeOUsc53ZdfF8X1G1zXkxdxbyluYFmLsCUIKwitno1u
 avbjwAVnjGezCkrNKH4IOqP/gUREmuy9HAlLd4TiXTiq/U98A+GQ1ELMAvOcJlhET50Q
 NBJWcihqtBaxFmoOQpp17AQvgdMIKMf3wG93Ymqawgzv0Q0TPlSEWiSlLxxPqfQb6+JR
 9vmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=srHp7y7eaB09Ui78FaKO8YiovpWzYiDiwsRE19M0Saw=;
 b=KnpDhpFtSZOTR/cBDPX2KxnBNdkU8I7wy/e5DQUSf69gDVtua3vk/4jCFGxQf0tD+9
 dwJaeAO9PHqJXxwZ625CxFPuae5o5cAARaIyA/J2ne6JX2Su1YiFtFoIq/8R3xzhLJ8+
 u3LkAvMEDsvFpn6ESvm/u7HHVBrpzasdZuvzjY+nq+iXJq3+awK1Lyhnk/QSVEYmA9R2
 J5+5yBtSbRv2XOuYWiWyF6wCDxLm2otTi5H3r5wwXU05P69T4BIOz3UcisSrcKOkI/XT
 9958RqtP4yQ8HnGHTdsf3g8Ch11k2WPrXGRC1KflM9/iNfO1CF6aUI32kg80I/KFe7Xk
 neAg==
X-Gm-Message-State: AOAM532W96pGd8kbSmYjuHGCbplXU9OU4URGzLg0r8hetQzxKTk9/AJ7
 dq0EaG8cLA1uqEF5Np7ASeiO+QlimIk=
X-Google-Smtp-Source: ABdhPJya/TNRqjJBU3FjbCwnMBGH7ZhdGTtqcP/fJvEnxoFuZ31SaUFThyofxcuxlmj9axiGg+U1IA==
X-Received: by 2002:ac2:4c83:: with SMTP id d3mr13025316lfl.92.1589830947113; 
 Mon, 18 May 2020 12:42:27 -0700 (PDT)
Received: from localhost.localdomain ([109.245.227.98])
 by smtp.gmail.com with ESMTPSA id r15sm7593128lfp.34.2020.05.18.12.42.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2020 12:42:26 -0700 (PDT)
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 14/22] target/mips: fpu: Demacro RINT.<D|S>
Date: Mon, 18 May 2020 21:41:41 +0200
Message-Id: <20200518194149.16281-15-aleksandar.qemu.devel@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200518194149.16281-1-aleksandar.qemu.devel@gmail.com>
References: <20200518194149.16281-1-aleksandar.qemu.devel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::141;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-lf1-x141.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335, SPF_PASS=-0.001,
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
Cc: aleksandar.rikalo@syrmia.com,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is just a cosmetic change to enable tools like gcov, gdb,
callgrind, etc. to better display involved source code.

Reviewed-by: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
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


