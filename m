Return-Path: <SRS0=0Zkw=4R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15601C3F2D2
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Feb 2020 01:29:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5C502468D
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Feb 2020 01:29:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TvRi+YXc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5C502468D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55794 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7qwe-0006qQ-0f
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 20:29:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36990)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j7qvW-0004kt-BO
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 20:28:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j7qvV-00060k-CJ
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 20:28:22 -0500
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:37814)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j7qvV-000608-7O
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 20:28:21 -0500
Received: by mail-pj1-x1043.google.com with SMTP id o2so67187pjp.2
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2020 17:28:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=lD3FYS9OIbqt/7rZmxRR9Ucvpf5WCTg8Pk1gx8FKewE=;
 b=TvRi+YXcZh9gcJikXK9coMz/2htbtC9rHOisjlUaVrG63xZ3frhynSwcyMQDvAXS34
 Nz24MnTDsoq6FtwQbQug/V7b2uj3Rtf+3fqYjn05ctDxwEEPpkqIdE7DZyj3waqix/at
 t4Ko+cXIJnxvay7RODwZhdmcxaJnT+o9CixVftYyEedMGZiUT0QSjr50+YbyVk7cpXoA
 VIzow+zV8UU0ocrDttICXwfrfhy93OONuZlm45rZtx/BH1PHXGWQVh1LmXq7ICQCzobe
 BVHCKX8BQas1pEcstmd4RsMG7ynaarQ+oZEaGqlhbIXULiHZBCUAIXY/2zJv8W1g65LV
 /pIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=lD3FYS9OIbqt/7rZmxRR9Ucvpf5WCTg8Pk1gx8FKewE=;
 b=aDbNGXANU/fCCi2ovucbUbEK8+IitkeNppYL0f/C7BYizc9kONFt5A/EnsAB6WxTEf
 0fDLSn7Kzg/AEAvYahnthHDcfC0rKcg0lQerSwajTqMVtzMFTEv2CgDeq1ZhTlS5ApKp
 9b8C6Gjk9bQyUsr7yHmO9NxElagFk3oKm0urAuvujb1qTQcWBzWJ4Lv56wJXIaIvoRbW
 ixGwLeQdVmst6MsvYskF6YUE9R8RkGVoF4vTmzTQEtdd1MpWFfTgcXRJT7OZjwVJ29Xt
 MqWt6RR8lWeBda6BBoP9SFt8pWPjr66jqGkMLbkoRhiDp5UQXz3YlmFZwIbeM1+Up09z
 HZuA==
X-Gm-Message-State: APjAAAVROOdH6JdVAWowYOXs4kqZgJew8gOvcYfpvb6NDGr7JduMFuIB
 5qo5mErfHyTZDgW2tfx6s5+BcYvp6j8=
X-Google-Smtp-Source: APXvYqw5uR3jvCpfNT8/CxYprqUDl+y9pACxnaEH92QuUahNJGDKMn4fR9B5R10iQEqCNVB0piZNGA==
X-Received: by 2002:a17:902:523:: with SMTP id
 32mr6715470plf.148.1582939699893; 
 Fri, 28 Feb 2020 17:28:19 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id r3sm4606313pfq.126.2020.02.28.17.28.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2020 17:28:19 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 04/12] target/arm: Remove EL2 and EL3 setup from user-only
Date: Fri, 28 Feb 2020 17:28:03 -0800
Message-Id: <20200229012811.24129-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200229012811.24129-1-richard.henderson@linaro.org>
References: <20200229012811.24129-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1043
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

We have disabled EL2 and EL3 for user-only, which means that these
registers "don't exist" and should not be set.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 33c28fe868..af541431e6 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -191,19 +191,13 @@ static void arm_cpu_reset(CPUState *s)
         /* Enable all PAC keys.  */
         env->cp15.sctlr_el[1] |= (SCTLR_EnIA | SCTLR_EnIB |
                                   SCTLR_EnDA | SCTLR_EnDB);
-        /* Enable all PAC instructions */
-        env->cp15.hcr_el2 |= HCR_API;
-        env->cp15.scr_el3 |= SCR_API;
         /* and to the FP/Neon instructions */
         env->cp15.cpacr_el1 = deposit64(env->cp15.cpacr_el1, 20, 2, 3);
         /* and to the SVE instructions */
         env->cp15.cpacr_el1 = deposit64(env->cp15.cpacr_el1, 16, 2, 3);
-        env->cp15.cptr_el[3] |= CPTR_EZ;
         /* with maximum vector length */
         env->vfp.zcr_el[1] = cpu_isar_feature(aa64_sve, cpu) ?
                              cpu->sve_max_vq - 1 : 0;
-        env->vfp.zcr_el[2] = env->vfp.zcr_el[1];
-        env->vfp.zcr_el[3] = env->vfp.zcr_el[1];
         /*
          * Enable TBI0 and TBI1.  While the real kernel only enables TBI0,
          * turning on both here will produce smaller code and otherwise
-- 
2.20.1


