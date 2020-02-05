Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E45A5C35247
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 17:25:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC31320702
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 17:25:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Hzkqcdso"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC31320702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54174 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izOQp-0004Ok-Ro
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 12:25:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38093)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1izOIb-0007w5-T8
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 12:17:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1izOIa-0006xw-M7
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 12:17:13 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:51002)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1izOIa-0006tU-FN
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 12:17:12 -0500
Received: by mail-wm1-x342.google.com with SMTP id a5so3348160wmb.0
 for <qemu-devel@nongnu.org>; Wed, 05 Feb 2020 09:17:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=/w5i8begHlcPmqRsbCuixBHyXAiI8PmeGKOVmeTRD2o=;
 b=Hzkqcdso2eauD88fkEoqAnoWRqXzo03GWnkuUa+i2gY9skyFzBvY40vFIf1azCqV2/
 tUi/iFTMoC3PMSmlRctMUwFgQsNJbhCXQURhxT/QVBHTk627lmzITOZ5g2tIMijMKAtZ
 gkhcTN9FLg6zsMg+QLSn7U3SSTELMtPU/ZxvUandgIsI0HR+kuF+ZC9SKh2qQlQVc3i0
 XOG+2tW5ghVYPD2pWvXlDm62J4gKSxPJ8cS/+C+dZSrJ193JVb2CSxJukQ0r/l1fr+97
 9fLYEAAp+43cUupUvYVao0ldEoDqic/DyHC4+O2ofwNo8i/hYH5BZ4J5GZCj5UsfVHhh
 xsIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/w5i8begHlcPmqRsbCuixBHyXAiI8PmeGKOVmeTRD2o=;
 b=GfOoq6RjUUJ27xXL0pG9FteTembZ4lQ5dO4AxrfYKWY0UBu8mW+F7hzKl0WXXfV4h2
 IWP9cYNZoBJWo91/05cxPYcFnIfkHZkB0AHxSufC6ydQixa+4gy1x9b7zq0+E5fusiH2
 9zwU91rxK7kER/mPolw0nL4UD8htUW1tL+ygXdqVUnDkBg/uvha50LUmpLP7yrowfQaU
 Cvka3bW7cOcwcECuHTiPDxNfL6AVT45QHQwhCbl1YBgeMwVWxwLrIXFeutsgd1GDlbOV
 buuJd7a3/THJmP1ZumbWDKJnnIdTMY+nby5yXw3LvaQmo/DIG6zEUQ5+cX3DIvDmBpqg
 sHsg==
X-Gm-Message-State: APjAAAVCiQRdcNtwHs7LwQJPrcOAvnpzq8xk/IvHa4kM7I3tthshLf9+
 9zjgeWPxnsCJ+5vW5SNa8i47IQ==
X-Google-Smtp-Source: APXvYqxUfjVVjXxwwSGCslQJNOvjKnOSZ7P00gIOF8BTDb29mlw/eZ/+x5RLBAQ78NknTFp1j1EaNA==
X-Received: by 2002:a05:600c:248:: with SMTP id 8mr6671878wmj.1.1580923031524; 
 Wed, 05 Feb 2020 09:17:11 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id f189sm296727wmf.16.2020.02.05.09.17.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Feb 2020 09:17:10 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id E39961FF9C;
 Wed,  5 Feb 2020 17:10:32 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 12/22] target/arm: default SVE length to 64 bytes for
 linux-user
Date: Wed,  5 Feb 2020 17:10:21 +0000
Message-Id: <20200205171031.22582-13-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200205171031.22582-1-alex.bennee@linaro.org>
References: <20200205171031.22582-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: damien.hedde@greensocs.com, Peter Maydell <peter.maydell@linaro.org>,
 luis.machado@linaro.org, richard.henderson@linaro.org,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>, alan.hayward@arm.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
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
index f86e71a260d..e5eac981b0a 100644
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


