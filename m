Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D341C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 14:14:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BCB720702
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 14:14:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jCZr9xE9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BCB720702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40838 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqdV0-0006sU-B2
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 10:14:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60730)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jqdKl-0004aB-JI
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 10:03:31 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:55343)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jqdKj-0006oT-8R
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 10:03:31 -0400
Received: by mail-wm1-x341.google.com with SMTP id g75so22535589wme.5
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2020 07:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=CVUuhZl1kRpSG6cEgnjsE0COEeahFDnSER/j+eEKc6g=;
 b=jCZr9xE9nR1d3zYqCBJt7t5WSy0BZ0dZCBT96JIZWT6qTeM4q+T6uyBf0cZKxPcI0c
 7VHiiVd363KH+6nw58INcwVrt0Ey8i4vDVPQlNAD4bQzS4cBfYyFF1kjVhsUY0Z6k2Xn
 1OC05zsHEo1IghT6cP2GENxesfnWtbwjkf2UZtZ4W3Ea1U+2LNvSzzG0rUVeO7g66YPy
 A6wuZDRHTkkDhnQHbA250JFJpdSgiq/ww9foF1wAuv/VKEoLbv7j3H2FF5KYgmTPkorf
 OyV/QOluFCT1gfWodnpN7C/AfHUEIxBCag/zxmxDkEliSOrEz1SBHjNAcTBQoy1P3u+M
 32lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=CVUuhZl1kRpSG6cEgnjsE0COEeahFDnSER/j+eEKc6g=;
 b=PRUppJD3AfOY+ZeTuhsJs+K1iEE0Sera8A+b9Er/TFwuB6Oekk+ivAnzSuGHY7+G4x
 8MOr5kyRNRL6SSI9x+8+udR2z5XSqeFnnEmvIUs+KVhS7goS+tJd21iCJyi/TciRgaI+
 2D8bzBSWqMhFjRo6P2gAUcxvmaSJkcj5IFDtFonv442k98YWVq9kqqPbeyEX7eQfEmF4
 gZZO4ZN0e4PdxGCXXxg8hakfTWufGDu0Ny2GfwYgoAd6+hTqqlRO4dg2t/aOgIyPpa84
 IsgWhsGnl5cMK9gGn7t7VbEFK4JJ8/Xqu53IyzkhLEWfWmO9kfJmMWaZY2vahgO4S0qu
 7RrA==
X-Gm-Message-State: AOAM531TrLVdHzrkhLsuNfNwiTh4P+h9PvlpQXOZ0Xo+GdDzH7rNYDST
 B8IEQIxEGT9Ap0U4y9+AcqxkHg==
X-Google-Smtp-Source: ABdhPJzotJu8tcY4xh1gB9a75LOOE903wS9ULwAr+m1xQvwvg6gHcxMv6l7zPxfrmyVdUOge6OxQgw==
X-Received: by 2002:a1c:48c5:: with SMTP id v188mr25965818wma.58.1593612207587; 
 Wed, 01 Jul 2020 07:03:27 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id p25sm7001372wmg.39.2020.07.01.07.03.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2020 07:03:26 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 54ED41FFBB;
 Wed,  1 Jul 2020 14:56:56 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v4 34/40] gitlab: enable check-tcg for linux-user tests
Date: Wed,  1 Jul 2020 14:56:46 +0100
Message-Id: <20200701135652.1366-35-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200701135652.1366-1-alex.bennee@linaro.org>
References: <20200701135652.1366-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x341.google.com
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
Cc: fam@euphon.net, Thomas Huth <thuth@redhat.com>, berrange@redhat.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, cota@braap.org,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Switch to building in the new debian-all-test-cross image which has
most of the cross compilers inline.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 .gitlab-ci.yml | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 93baf98232d..257947853b7 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -143,10 +143,9 @@ build-tcg-disabled:
 build-user:
   <<: *native_build_job_definition
   variables:
-    IMAGE: ubuntu2004
-    CONFIGURE_ARGS: --disable-system --disable-guest-agent
-      --disable-capstone --disable-slirp --disable-fdt
-    MAKE_CHECK_ARGS:  run-tcg-tests-i386-linux-user run-tcg-tests-x86_64-linux-user
+    IMAGE: debian-all-test-cross
+    CONFIGURE_ARGS: --disable-tools --disable-system
+    MAKE_CHECK_ARGS: check-tcg
 
 build-clang:
   <<: *native_build_job_definition
-- 
2.20.1


