Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A55DC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 18:25:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BF4D20836
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 18:25:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uNC4KkaH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BF4D20836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52158 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jot23-0007Wh-KP
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 14:24:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58242)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jot04-0003O0-Qv
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 14:22:56 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:38720)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jot02-0004zb-H8
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 14:22:56 -0400
Received: by mail-wm1-x341.google.com with SMTP id f18so10241811wml.3
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2020 11:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=eb5iaPGhoDcsV6Aa17DQE5OucQ4Fpz4RuFDlJP0p52E=;
 b=uNC4KkaHxCWcXRRXRdQ9md/cOiYDqzKBxBQNnFLTeKoBa5AaGNATDMbxaetRG7ctEW
 8r0MusUUcJm2mElNpRnqf6x0vSlMHa6f2JqNdbX7YAtw7YU6U7RPAZfPfCdryQHKBf4B
 gnUGLRSNim48zPvSkBovrGvpHo/z7ndYzGIASCg+2XPp459GrMuB59rBK6t7g8D6SPIJ
 qDQYx0P6sKVzkyYszmygKnIPhCOL7AM+0X12wyjDai3rOwkslZLd7oEvdoZyQHr4CIsE
 tTIyb/re3tsl1sNi+rbHNeBs+CRLsOTDD76gqW3AqdvAfWYpSpNbDZxJyjDioX3VtQV9
 xZYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=eb5iaPGhoDcsV6Aa17DQE5OucQ4Fpz4RuFDlJP0p52E=;
 b=gecC2f/5vmalNs1X9s74P9E3uuxPm+Uw0cl+FYGW/KUuuO5O5d1sRWf5ArUi1aigSD
 bvXDZNQSafuDJX8qKtUDZltfQwtBV7LKgDCskhWhcXunR6Xj6BhyXxC2J63oWFYLll/n
 KmARtXbZutOXe0ID0u2wxN/L2D5p4XO5iob6A8JgzwMfSEXEd2CZf7kPtk2hUc57CKKr
 2vaGJ1hLijTG0jhZ5iYkTKPvyPIMlK1RqwbrLLyJsgESX5tgxezyNi89DMv493hog7wk
 zKaucX9YaK4uWzLTdHoQX3v70iCdtudu3sr5AVyW+vG4Htn5BLeQ4DVKkQmw6ZGb0pgF
 5E0w==
X-Gm-Message-State: AOAM532YrID/nFIk5maW1fhc+dwD5/NYrDEIpDr4ZNoC45HFea0L58F1
 HaexAgNAhsOpQfH1m/SH4eMTnQ==
X-Google-Smtp-Source: ABdhPJxOzGSfd64ZnHWc4IydZ+IGHrJykHaFsgXJ4pQCJrM3pRqnqdQ5aQYlrC3fpZz/g4xIFl2piA==
X-Received: by 2002:a1c:28c5:: with SMTP id o188mr4573163wmo.62.1593195772856; 
 Fri, 26 Jun 2020 11:22:52 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 11sm18436456wmg.41.2020.06.26.11.22.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2020 11:22:51 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 1BA401FF8F;
 Fri, 26 Jun 2020 19:14:04 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v3 30/30] containers.yml: build with docker.py tooling
Date: Fri, 26 Jun 2020 19:13:57 +0100
Message-Id: <20200626181357.26211-31-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200626181357.26211-1-alex.bennee@linaro.org>
References: <20200626181357.26211-1-alex.bennee@linaro.org>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Cc: fam@euphon.net, berrange@redhat.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org, cota@braap.org,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Instead of building the docker files directly use the same docker.py
scripting as we do for building locally. This should help ensure we
use the exact same steps and allow us to cache properly when building
locally.

To get this working you have to have a fairly recent docker binary
otherwise you will see the error message:

 => ERROR importing cache manifest from registry.gitlab....

So far docker 19.03.12 works (from the docker apt repos) but 18.09.1,
build 4c52b90 which is packaged in Debian Buster fails.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .gitlab-ci.d/containers.yml | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/.gitlab-ci.d/containers.yml b/.gitlab-ci.d/containers.yml
index f56aa44f711..e332af3cc46 100644
--- a/.gitlab-ci.d/containers.yml
+++ b/.gitlab-ci.d/containers.yml
@@ -8,14 +8,17 @@
   before_script:
     - export TAG="$CI_REGISTRY_IMAGE/qemu/$NAME:latest"
     - export COMMON_TAG="$CI_REGISTRY/qemu-project/qemu/$NAME:latest"
+    - apk add python3
     - docker info
     - docker login registry.gitlab.com -u "$CI_REGISTRY_USER" -p "$CI_REGISTRY_PASSWORD"
   script:
+    - echo "TAG:$TAG"
+    - echo "COMMON_TAG:$COMMON_TAG"
     - docker pull "$TAG" || docker pull "$COMMON_TAG" || true
-    - sed -i -e "s,FROM qemu/,FROM $CI_REGISTRY_IMAGE/qemu/," tests/docker/dockerfiles/$NAME.docker
-    - DOCKER_BUILDKIT=1 docker build --cache-from "$TAG" --cache-from "$COMMON_TAG" --tag "$TAG"
-                                     --build-arg BUILDKIT_INLINE_CACHE=1
-                                     -f "tests/docker/dockerfiles/$NAME.docker" tests/docker/dockerfiles
+    - ./tests/docker/docker.py --engine docker build
+          -t "qemu:$NAME" -f "tests/docker/dockerfiles/$NAME.docker"
+          -r $CI_REGISTRY_IMAGE
+    - docker tag "qemu:$NAME" "$TAG"
     - docker push "$TAG"
   after_script:
     - docker logout
-- 
2.20.1


