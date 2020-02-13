Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1FF0C2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 14:52:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B1EA2082F
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 14:52:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vm0zVhJq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B1EA2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53938 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2Fqt-0008Uu-K9
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 09:52:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60311)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j2Fgz-0004RH-B5
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 09:42:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j2Fgy-0001vL-7q
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 09:42:13 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333]:37704)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j2Fgy-0001tt-15
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 09:42:12 -0500
Received: by mail-wm1-x333.google.com with SMTP id a6so7041220wme.2
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2020 06:42:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=9Yi95nyPVD4aME4UhBrkHEkCDFEbapmAEBFinOLLlkY=;
 b=Vm0zVhJqbbgXr1TV/bzIYQBvV7s+u2LYb4Iw53ZNPRd1FHKjqfc0QCN9zM4AXMqQgs
 03/ooQLlNFg8vXCQ1GH0mgJGH5hsNi6HA3yp/7n/Cd+7IAvov5qwB+vF0sk4Y9TZ2iY6
 3fB6pWiOQFDIN62z6IhXBZSaPuNHWO5gA+iVhOXpSugsZs+mQBRi8/N9sJzvQ99wblIB
 F5HYgKaptn4djVWdi5Mh/hNxHryQ9O9CLGcd/7J83KNQhJu0HXBr6y3xx/kI8WxXGgUw
 f5htOriNPZ1xUKVzwkh1+QqJ3164pzNvu6oBIx6tQTSRdYVHAlNgcdLjE8XWoXlk+Qgx
 rU4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=9Yi95nyPVD4aME4UhBrkHEkCDFEbapmAEBFinOLLlkY=;
 b=aO6VGsQsGEyVxkFI7sijeiQTak2isr0aLqliT4Xd5TKJHzb1eVCrsFo/5nVDC881bm
 Lfof+u3GzOfWPbUZ6bRKtNUG4hNyj7DA+n07f0GDHcolGLatsUL2+PT4+lC90xgR1R6U
 VPwEEtrDfJCPk2B5HNsnEPBjQdbSfd9rFhujf5hElW4PNZ1ELjB9OD1euprmjD2fF3Kq
 yrJLjEgDd/l5+GevWAg6e59bcjvpg7qdOjQSOyXRAdSI6tt4vC0Ot3MXJxT4UOe4PYvI
 S6CleZS0KS0IkKt1nSNNZgBzKW1dqMvmkLatri9Nv4HTjjmIKXPJ98gJgB6e/XnnhAim
 n8KA==
X-Gm-Message-State: APjAAAVI2j4zjYaF744+VSG1N08SCRyEuPyDy286QpU0xLTpEYmDalaC
 mYN+APcE6BNcR/wQsMUKeSO809fKUE0=
X-Google-Smtp-Source: APXvYqyUNRoC2ninHuHQ+7mmZCpvvkJWpPWZ33GScPmrAlyXshT1f4oKdbBrFG/MQgcaluVgTyeyEA==
X-Received: by 2002:a7b:cab1:: with SMTP id r17mr6140801wml.116.1581604930710; 
 Thu, 13 Feb 2020 06:42:10 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id e22sm3362454wme.45.2020.02.13.06.42.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2020 06:42:10 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 19/46] target/arm: Introduce aarch64_pstate_valid_mask
Date: Thu, 13 Feb 2020 14:41:18 +0000
Message-Id: <20200213144145.818-20-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200213144145.818-1-peter.maydell@linaro.org>
References: <20200213144145.818-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::333
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

Use this along the exception return path, where we previously
accepted any values.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200208125816.14954-11-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/internals.h  | 12 ++++++++++++
 target/arm/helper-a64.c |  1 +
 2 files changed, 13 insertions(+)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 0569c96fd94..034d98ad538 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1085,6 +1085,18 @@ static inline uint32_t aarch32_cpsr_valid_mask(uint64_t features,
     return valid;
 }
 
+static inline uint32_t aarch64_pstate_valid_mask(const ARMISARegisters *id)
+{
+    uint32_t valid;
+
+    valid = PSTATE_M | PSTATE_DAIF | PSTATE_IL | PSTATE_SS | PSTATE_NZCV;
+    if (isar_feature_aa64_bti(id)) {
+        valid |= PSTATE_BTYPE;
+    }
+
+    return valid;
+}
+
 /*
  * Parameters of a given virtual address, as extracted from the
  * translation control register (TCR) for a given regime.
diff --git a/target/arm/helper-a64.c b/target/arm/helper-a64.c
index 0c9feba3929..509ae930698 100644
--- a/target/arm/helper-a64.c
+++ b/target/arm/helper-a64.c
@@ -1032,6 +1032,7 @@ void HELPER(exception_return)(CPUARMState *env, uint64_t new_pc)
                       cur_el, new_el, env->regs[15]);
     } else {
         env->aarch64 = 1;
+        spsr &= aarch64_pstate_valid_mask(&env_archcpu(env)->isar);
         pstate_write(env, spsr);
         if (!arm_singlestep_active(env)) {
             env->pstate &= ~PSTATE_SS;
-- 
2.20.1


