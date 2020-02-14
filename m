Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86153C2BA83
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 17:54:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58ED6206B6
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 17:54:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RrmcKadG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58ED6206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42838 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2fAG-0003M0-JZ
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 12:54:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55853)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j2f7e-0005lr-D2
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 12:51:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j2f7d-0000fN-1D
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 12:51:26 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:55173)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j2f7c-0000eT-QK
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 12:51:24 -0500
Received: by mail-wm1-x343.google.com with SMTP id g1so10828127wmh.4
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2020 09:51:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Rq8pejBQpyfpBvg4MHykyjE8mwu9sHhOGcsrOcoZVak=;
 b=RrmcKadGWzlb3rsABzU8q5x+n3s+OuOkKhA9Msf3q/bLe24/66mDf8gJJS4szkY6rI
 kcmHf0LEuKfSRINe2qidCVI7ShBK1cPGbybRHIrnf9Gu5lHbaDS3h7qXf4fpNahUebBM
 O+c/EdqgyMquekt3WSf5P7VD3ZgDVoiSFRiD2ftXdqIvxeuPKy+vBt6z0112g7MwJnv9
 UqJxIwyEobtqeLQhZLQgze1QGr91YwNzFwl2lT+Gs3ikWftuqzZz6qmvIU4ttYHoyUJe
 SaHhbKRlgVP6hLu7KNPSRcPV2HUjHykNNZ8MKcPpCXOf5sMpTK3QA/w6R8zhyghRlppq
 Avsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Rq8pejBQpyfpBvg4MHykyjE8mwu9sHhOGcsrOcoZVak=;
 b=PvGweb4fesEGzUqQDzn+xsnsk28IYegCpKM7hSDeHqPXwTVdHSaOu0t+J+uTWzoBya
 dFAcr87UKgu6e3SKNDIAsLgkAG6dguLGIxeJpUY2/WJBuWEpy9b+47Iu6F9B3ZElxqjA
 JFLfcSBnqjgHKR0cZnEasYk1LsVHzX/f5X2Hb0R4O9CqYu09uE9TZ/67FK9GKq5iAtLt
 AVtA1VIQGRUuZ6Ozzld+hBBGJjvQalpZ4ORafIPpZF5vLPl5eW5zqHa+KyhQ2ZTCHNSM
 HKLd/Wnu8XP+smm3tI1GuGICyClDL0wTn4Plk/UgSPNxd7vO+PZdlS5AO/JwCAbApcBj
 75Vg==
X-Gm-Message-State: APjAAAW6agpQwPkCB34DBHnOp4pmcWQwKG9tGsedPAoaxV9zQXl+Sy5D
 lwtn6l7iwUj+p8CeG1FCg0gOBQ==
X-Google-Smtp-Source: APXvYqzbHhH9wNc1N5m4OyPYQhcixSq6xo4qEpcyKoKJWtGTBJLZz8BJr17kEA7WcZynU5HjFUXwaA==
X-Received: by 2002:a1c:9e13:: with SMTP id h19mr5955605wme.21.1581702681729; 
 Fri, 14 Feb 2020 09:51:21 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id v8sm8001857wrw.2.2020.02.14.09.51.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Feb 2020 09:51:21 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 02/21] target/arm: Check aa32_pan in
 take_aarch32_exception(), not aa64_pan
Date: Fri, 14 Feb 2020 17:50:57 +0000
Message-Id: <20200214175116.9164-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214175116.9164-1-peter.maydell@linaro.org>
References: <20200214175116.9164-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
Cc: Eric Auger <eric.auger@redhat.com>,
 Aaron Lindsay <aaron@os.amperecomputing.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In take_aarch32_exception(), we know we are dealing with a CPU that
has AArch32, so the right isar_feature test is aa32_pan, not aa64_pan.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index eec3876610c..d4ed52981fa 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -8858,7 +8858,7 @@ static void take_aarch32_exception(CPUARMState *env, int new_mode,
         env->elr_el[2] = env->regs[15];
     } else {
         /* CPSR.PAN is normally preserved preserved unless...  */
-        if (cpu_isar_feature(aa64_pan, env_archcpu(env))) {
+        if (cpu_isar_feature(aa32_pan, env_archcpu(env))) {
             switch (new_el) {
             case 3:
                 if (!arm_is_secure_below_el3(env)) {
-- 
2.20.1


