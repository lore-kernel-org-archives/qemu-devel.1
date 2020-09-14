Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2F48C43461
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 15:15:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76A52208B3
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 15:15:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YTjShj4R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76A52208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56848 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHqC5-00083f-9e
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 11:15:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37962)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kHq4x-0000jp-QG
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 11:07:39 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:41723)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kHq4q-0000ES-T3
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 11:07:37 -0400
Received: by mail-wr1-x442.google.com with SMTP id w5so8400wrp.8
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2020 08:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=AxePx8oOqocKMREyg0WDjugaJREHStftt0HCq39PBRY=;
 b=YTjShj4RCRH/EkoLHM2yai1lrk60a7ywpKZumVpSiCBn6XLv206v2dPeG8XAdWW+tB
 fXB23ZZDzIXZoefZvUG9M0UWzljqXZkprvQJINhP2dKOOO6p8BRl5C83kV23b942CtV6
 swBlsfUw47DEYjljyD5ufnKRgCM3yMiz+hH9sXHdgHjXWyBMQu9mZLF0l1xK5bWIZi+b
 /P75HBHjjNEPeAQoBAhNklUg0yaaa5+j4to8g56G04X3WRbxyXb4PhQzjVHJsmC8LCWF
 QZRPlhl7yFuvfg/1bvRUfK3kknGpkkJHl08umMEc+I84EYQIMpjWHlUGJxpGp+dtX/dW
 pDVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=AxePx8oOqocKMREyg0WDjugaJREHStftt0HCq39PBRY=;
 b=ZcIhnwuukpscTryeBzoIiiitFp8BboVcTW10c5VT5ccLrurVHtfEAZqJjKnRdPz4cf
 oODejeYMATTuD8g2ishnCH1u6Yid7eNOxPRBOVA0K525ahN50XpJraxbyY+mbw+bkr+F
 PuekH9YtsN3qi5rzNPjvyorVo9HnfUTv6g6F8J2K7NumgpU49ro4nOlLPGTp2bnnmyLD
 pUhHewmXrG/x+zzscO5RSbyYeZvnt0oqEB05/ALH3vC+UpJb/SneJf2PabtJ3/rEp7lC
 LFFkvbocTpTFhmEgJYWYl2SGtwNzwnyrPY702OPnZB8N+Ns/LA7XDgrVLMhN9oMUkWI5
 4Smg==
X-Gm-Message-State: AOAM532r9CgkUX7TGygT/rkoUvJ9iRWOUb4bdLcDVhrxpo/w4vEh83ps
 Gfq89yu/mhDwvnQqt2zxearZBZuWnZ17AQ==
X-Google-Smtp-Source: ABdhPJwJN7ScZirFamp+WoxA23mZIXWEo01uQjBgJPbWRvVlLXhasv9qNWobOFZXuuubmaTK34aicw==
X-Received: by 2002:adf:e407:: with SMTP id g7mr16263896wrm.349.1600096048068; 
 Mon, 14 Sep 2020 08:07:28 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id a127sm20206161wmh.34.2020.09.14.08.07.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2020 08:07:23 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 55A1F1FF91;
 Mon, 14 Sep 2020 16:07:17 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 5/6] gitlab: create a build-deprecated target
Date: Mon, 14 Sep 2020 16:07:15 +0100
Message-Id: <20200914150716.10501-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200914150716.10501-1-alex.bennee@linaro.org>
References: <20200914150716.10501-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

These targets might be deprecated but we should keep them building
before the final axe comes down. Lets keep them all in one place and
don't hold up the CI if they do fail. They are either poorly tested or
already flaky anyway,

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .gitlab-ci.yml | 10 ++++++++++
 .travis.yml    |  3 +--
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 72e8604579ee..f027b55aef15 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -254,6 +254,16 @@ build-clang:
       ppc-softmmu s390x-softmmu arm-linux-user
     MAKE_CHECK_ARGS: check
 
+# These targets are on the way out
+build-deprecated:
+  <<: *native_build_job_definition
+  variables:
+    IMAGE: debian-all-test-cross
+    CONFIGURE_ARGS: --disable-docs --disable-tools --disable-system
+    MAKE_CHECK_ARGS: check-tcg
+    TARGETS: ppc64abi32-linux-user tilegx-linux-user
+  allow_failure: true
+
 build-oss-fuzz:
   <<: *native_build_job_definition
   variables:
diff --git a/.travis.yml b/.travis.yml
index 65341634d02a..c75221dca3e7 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -344,10 +344,9 @@ jobs:
     # Run check-tcg against linux-user (with plugins)
     # we skip sparc64-linux-user until it has been fixed somewhat
     # we skip cris-linux-user as it doesn't use the common run loop
-    # we skip ppc64abi32-linux-user as it seems to have a broken libc
     - name: "GCC plugins check-tcg (user)"
       env:
-        - CONFIG="--disable-system --enable-plugins --enable-debug-tcg --target-list-exclude=sparc64-linux-user,cris-linux-user,ppc64abi32-linux-user"
+        - CONFIG="--disable-system --enable-plugins --enable-debug-tcg --target-list-exclude=sparc64-linux-user,cris-linux-user"
         - TEST_BUILD_CMD="make build-tcg"
         - TEST_CMD="make check-tcg"
         - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-debug-tcg"
-- 
2.20.1


