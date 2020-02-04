Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D86EC35247
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 18:48:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 275EB2084E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 18:48:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Uv7Ctlt+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 275EB2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36312 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iz3FQ-0000Iu-AX
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 13:48:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54440)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iz3Dz-0006wc-5i
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 13:47:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iz3Dy-0003aR-52
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 13:47:03 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:36642)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iz3Dw-0003Sy-UW
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 13:47:02 -0500
Received: by mail-wr1-x430.google.com with SMTP id z3so24479563wru.3
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2020 10:47:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=P4/xpMMF3K4/Oux9HJYkuwQlMciTvktcB7IAIMVNY54=;
 b=Uv7Ctlt+MI0FgJZTNuJP7eVKYOFUJVeqUGy86IyU/B5IzzHzbjV7kjyQ/NhSR2OEch
 GYnHeQT0GXN9rH3jKSdYbV+C4FcpbzcSxk0XgJNTF2GHB0asikIYHqmcsE3oxGxbuzCL
 a5JeO+i33wIYCveqElrnejqsiHA9B1kBD8oSC/fUpKXZV5213c4kVpo6DgqxpG41Y2y1
 JZHitotzf/fG4IpFl4Dw2pL0PUuPmcshb/QPBMj42YL9OriT4YdbkbLUeaDQohl30L1j
 GpCPCcGNg34KgwDzASJKiAkCYaU+wxqXhvIOzElOxnKXgiE6Fh5jDgSuk0YclzRBdPgk
 1igg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=P4/xpMMF3K4/Oux9HJYkuwQlMciTvktcB7IAIMVNY54=;
 b=UaVqxWqpaxmgxNeM7kMmk8o8p0WxmvX/sq1EmOGztXDxknTKthMzDKLCdiJvSaKjMa
 2EZc5b2x5325QO1JIhFBzX0c2wEaxLUONa4ZotgVZclQEw4LWb9VnUlHe5FmA1Onrfhu
 DUIEVhvVjCoRWBVrZhM/Yr5UOAfh+m73sf1PEqj7fhSAEONvDdH3vC4xKSmSo1DpA0d3
 wD7OM6tVmiP9pPMrGFliGB96OUZaAGkAZPmK6+nuxAjamfG6iZp9ajb/LoLZa32uoOjn
 ssSp2U6s1pD08Fq/Swjt5cqObp8dkB/49lntLPK/GMSOPQrWoFgFgKxmC9YM07NeKsfX
 nDpQ==
X-Gm-Message-State: APjAAAXAbuC25zGglesimirLwFiEXp3el9vA9CNAwOhlUSTqbU6yLBuO
 cK3Vua18sofbyhZYvMjYqw2RZA==
X-Google-Smtp-Source: APXvYqx6gWhVTY+V0Bhb1DFfARiANMe7qHmpGbHvX53s5R4ORgt5S0DKVcdrssIKjvWMPyiWusWYQQ==
X-Received: by 2002:adf:e984:: with SMTP id h4mr23822819wrm.275.1580842019749; 
 Tue, 04 Feb 2020 10:46:59 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id s139sm4888005wme.35.2020.02.04.10.46.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Feb 2020 10:46:57 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id B442B1FF9F;
 Tue,  4 Feb 2020 18:40:29 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 15/16] .travis.yml: single thread build-tcg
Date: Tue,  4 Feb 2020 18:40:27 +0000
Message-Id: <20200204184028.13708-16-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200204184028.13708-1-alex.bennee@linaro.org>
References: <20200204184028.13708-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::430
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

I've theorised that a parallel build-tcg is somehow getting confused
when two fedora-30 based cross compilers attempt to build at the same
time. From one data-point so far this may fix the problem although the
plugins job runs quite close to timeout.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20200203090932.19147-18-alex.bennee@linaro.org>

diff --git a/.travis.yml b/.travis.yml
index c1c6df475a8..3b35b7cf04d 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -380,7 +380,7 @@ matrix:
     - name: "GCC check-tcg (user)"
       env:
         - CONFIG="--disable-system --enable-debug-tcg"
-        - TEST_BUILD_CMD="make -j${JOBS} build-tcg"
+        - TEST_BUILD_CMD="make build-tcg"
         - TEST_CMD="make check-tcg"
         - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-debug-tcg"
 
@@ -391,7 +391,7 @@ matrix:
     - name: "GCC plugins check-tcg (user)"
       env:
         - CONFIG="--disable-system --enable-plugins --enable-debug-tcg --target-list-exclude=sparc64-linux-user,cris-linux-user"
-        - TEST_BUILD_CMD="make -j${JOBS} build-tcg"
+        - TEST_BUILD_CMD="make build-tcg"
         - TEST_CMD="make check-tcg"
         - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-debug-tcg"
 
-- 
2.20.1


