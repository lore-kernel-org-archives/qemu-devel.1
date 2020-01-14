Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42BB6C33CB1
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 15:18:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A454222C4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 15:18:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fcSKaYL5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A454222C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41770 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irNy0-0007nI-8g
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 10:18:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37831)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1irNpZ-0005B3-Q6
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 10:10:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1irNpY-0007W4-5i
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 10:10:09 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:36058)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1irNpX-0007UX-Ta
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 10:10:08 -0500
Received: by mail-wr1-x441.google.com with SMTP id z3so12530922wru.3
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2020 07:10:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=gtTyiABJNzKbT4Hcxk69PnKRIOdsWQYqpdkNpdscjO8=;
 b=fcSKaYL5RIXTOvSeIFKI2+EUmiNjinug2EPGoLbooNYoru9YNGgl1x94qyPf3+AKVB
 BsattieJNQUdOz5YEZsdsxUbq5c6FtO5M8D9mr7c8vbR0MOcXo3gR9evm0XeUSjB01M4
 YhtpqauhM53Gn6c/YzV0rlGcNwKvH5CIYSgHV/RgZl8iNaNdg+MOd5lJUad6dQIgVgxE
 PeL7wVKIYyUVr7hgsm3HhKbuhh2VH4ypAjiyrzE868oRJKI4D58lGnrAIggDzhBMYOBS
 qPbay9MLlc1BznwI6AC+LtAoEDjvnFSGMvmzT2JvF/EV6Lh++chbkPMTO6dYaJK63cfO
 lC5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=gtTyiABJNzKbT4Hcxk69PnKRIOdsWQYqpdkNpdscjO8=;
 b=bwKSdSrsdBDN1w0FB63ohbFGuMl5FtGOztMoGzPEHwH0iOZnnxdllY3ToTXLcMJQx1
 IMgDmGZaa+cVu7C1isodepTpAEAriVU8U5sD77rLeQQb353k2bphXTXOqeoMU3LJ0W++
 O2Sy26gti8xSsj8r/S2w/+VhCWThktUoG+HAOGe+ekc8EydCI40VkqvB85UOdh7CUs7E
 Cpj1ur01OvjByTOH51LMS4R2iLzIDelPBHCMebFiSxESPMcZz86kGxpotcdshvln6yoT
 s0LfNvWmcWzPUFVvKnyJJiquVvEN0rs9TyrysY+W5/q9yOKCSU70fcHFk+VtDvLLLcOI
 Wc1g==
X-Gm-Message-State: APjAAAVPFtzSiV2NHifNdybWVLYCXQ2pJiG+au4oP6ey57gqAc7uIgiJ
 pk9x4+Q+mhHu+thQTKlS9ay6qA==
X-Google-Smtp-Source: APXvYqz13a11d6b0hnHET0gjRyEJNHXz97y3j8DQkqIRXr8efdvLoGwZzBxc9dV+Ra1TFFJZKpJifw==
X-Received: by 2002:a5d:6a02:: with SMTP id m2mr24831190wru.52.1579014606899; 
 Tue, 14 Jan 2020 07:10:06 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id o15sm20309211wra.83.2020.01.14.07.09.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2020 07:10:02 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 0D12D1FF9A;
 Tue, 14 Jan 2020 15:09:56 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 11/22] target/arm: default SVE length to 64 bytes for
 linux-user
Date: Tue, 14 Jan 2020 15:09:42 +0000
Message-Id: <20200114150953.27659-12-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200114150953.27659-1-alex.bennee@linaro.org>
References: <20200114150953.27659-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The Linux kernel chooses the default of 64 bytes for SVE registers on
the basis that it is the largest size on known hardware that won't
grow the signal frame. We still honour the sve-max-vq property and
userspace can expand the number of lanes by calling PR_SVE_SET_VL.

This should not make any difference to SVE enabled software as the SVE
is of course vector length agnostic.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

---
v2
  - tweak zcr_el[1] instead
---
 target/arm/cpu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index d62fd5fdc6..1c1f34ee5d 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -199,9 +199,9 @@ static void arm_cpu_reset(CPUState *s)
         /* and to the SVE instructions */
         env->cp15.cpacr_el1 = deposit64(env->cp15.cpacr_el1, 16, 2, 3);
         env->cp15.cptr_el[3] |= CPTR_EZ;
-        /* with maximum vector length */
+        /* with reasonable vector length */
         env->vfp.zcr_el[1] = cpu_isar_feature(aa64_sve, cpu) ?
-                             cpu->sve_max_vq - 1 : 0;
+            MIN(cpu->sve_max_vq - 1, 3) : 0;
         env->vfp.zcr_el[2] = env->vfp.zcr_el[1];
         env->vfp.zcr_el[3] = env->vfp.zcr_el[1];
         /*
-- 
2.20.1


