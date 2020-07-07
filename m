Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B203CC433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 07:21:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C80F2065D
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 07:21:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ylihklsg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C80F2065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33714 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jshud-0002xC-Ld
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 03:21:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43798)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jshoS-00074k-Og
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 03:14:44 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332]:40254)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jshoP-0004tZ-RC
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 03:14:44 -0400
Received: by mail-wm1-x332.google.com with SMTP id f139so45346811wmf.5
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2020 00:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=9MdVCtyPDmbjXZc45hJi3iId1MWBt9w+N3ZPMWL/v5c=;
 b=Ylihklsg8U5au/iLzdzfzydGIxQsLx82Yf2S5BjEBQjGepiGuAxAo0itBYp5bVH1q7
 /1bQVey+rEl4KoY6PFVSaekZs+6y87IVSiZVsyWGFrzQvk2gkQaiQjbs5dvpA9bUAc3o
 fHqgb8EAEWjz2Ux0Yn0Ds/pi+auYCrcSJx7CR0c9Xh2FtcpVMV1BKLbeggLuQ5p1w18G
 XAXBj4QJTCspomc1iYbk3oxyR7QgwQve+WZTRf8TgPWjFTpjzFj/yVHeNuTO+dVkBs2o
 nRewPlE1RULPw6qQVZcyu5N4r1AtNuGkw7rsYCvY3YzryqYM+sOYpsOT2Ms2K4CUiUek
 S11g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=9MdVCtyPDmbjXZc45hJi3iId1MWBt9w+N3ZPMWL/v5c=;
 b=kTVne41FMj9e0Sh41zzbjLs+zmvF3rFB+nB+L15WAckkmNNb3l/U2mnNlfrGvduUJ4
 MT3yQW2z7Ng1DGiiDJFrMWO8qSyImTlOpXz19k7EEnoKZly8NePT/yB9nLFKcKOccqgN
 Jevi4rsQ6BV1EQkfWIzZh14wgyG7VKj2MC/i5sjaE+e/lBvuNoANaoOVe3tmqdgz6nSq
 beD9+frsJgv21h7vNNsm1NVoUlF0Bd+5SCSA4b2LwJkg22M63AD/k/uR7zDqK+rxt2k6
 iDpRxQ7MBpkUHeSuYDvoZOIeh2ICVWDpVNVvJlu4dJlPYndAGFz6v23FInh9Nw4JhjpR
 Lsvw==
X-Gm-Message-State: AOAM530YcZ+WgofFNK9RQMt4ufSKTWauLcC3BEB80Bpol6cEKQsf4OBh
 5mcMnEvGrsMKy9smWv8Iz8dvoQ==
X-Google-Smtp-Source: ABdhPJxAzfF4MHspRBS+9qGvUVMwviK9fB8PT4Jy+WGf3jt4sjUpRthBE3QlBEolG4hvyGqnTALGXA==
X-Received: by 2002:a7b:c4d8:: with SMTP id g24mr2550855wmk.127.1594106080423; 
 Tue, 07 Jul 2020 00:14:40 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id z25sm2053697wmk.28.2020.07.07.00.14.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2020 00:14:30 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 418811FFBF;
 Tue,  7 Jul 2020 08:09:02 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 38/41] shippable: pull images from registry instead of building
Date: Tue,  7 Jul 2020 08:08:55 +0100
Message-Id: <20200707070858.6622-39-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200707070858.6622-1-alex.bennee@linaro.org>
References: <20200707070858.6622-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x332.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Now we have a source for registry images pull from there rather than
re-building every time on shippable.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20200701135652.1366-41-alex.bennee@linaro.org>

diff --git a/.shippable.yml b/.shippable.yml
index 81905727d14c..f6b742432e5f 100644
--- a/.shippable.yml
+++ b/.shippable.yml
@@ -26,12 +26,10 @@ env:
     - IMAGE=debian-ppc64el-cross
       TARGET_LIST=ppc64-softmmu,ppc64-linux-user,ppc64abi32-linux-user
 build:
-  pre_ci:
-    - make docker-image-${IMAGE} V=1
   pre_ci_boot:
-    image_name: qemu/${IMAGE}
+    image_name: registry.gitlab.com/qemu-project/qemu/${IMAGE}
     image_tag: latest
-    pull: false
+    pull: true
     options: "-e HOME=/root"
   ci:
     - unset CC
-- 
2.20.1


