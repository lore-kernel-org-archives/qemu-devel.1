Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58D9EC433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 14:12:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2653620702
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 14:12:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QqQwjLi6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2653620702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35566 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqdTm-0004is-Ca
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 10:12:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60916)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jqdKy-00056C-Tq
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 10:03:44 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:40161)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jqdKx-0006qf-4V
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 10:03:44 -0400
Received: by mail-wm1-x343.google.com with SMTP id f139so23386622wmf.5
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2020 07:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=6WtCLGQRv0MjUdUMAEZUN6efvnmj6vJqFczlhuv8qdY=;
 b=QqQwjLi6YMb46gu33K/TpzYfCNGIN43MXqPRXDIsa6R/ZiLe5p7ZJ/vE/Rg4yh3uVf
 Cbr2pw1JMakjN0l5veMvTSXzn+ueigEJCXFYJuxCpHVfvVJBTlql2K/MjcPcCVd0XCfT
 YAmpJ7VzFAwJO+LUR2w9LUeSO1AcuZGrBH33b7AxyyWg7EJ8PYyudr6kponaGkxAsGVX
 /xhXR8Vz+CUBRDxdTeh+/diUwy82SpCRlZ9ZdRhRHDDLH1Nt32JiYjsksqsSWoUCx55V
 WBvKSE9OJMANPshS8ZsltJnsXVCwcoSTtIRh2xY96mFDM717lqKc9q2ob1FdNLkVSPlX
 nU+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=6WtCLGQRv0MjUdUMAEZUN6efvnmj6vJqFczlhuv8qdY=;
 b=pdZosqypbE0bWMQ4+bGaCELH+o/+Qsz2T35aw4EQ4cTvizBw+wQV/ZSzq2HbzK6pTq
 iJV7EdBkDu3ki1t3rr9lUTodvsTL70p8d3V5jF/6MYXDA383x1j+LlkinyNLStVfhZcN
 fdCGd11dspSxPDvJoy4aU8BtRxS2LasI1Gy/fXI4XP4/QYaskRnpicMisY8UegC3ouae
 ZkW+2ZhQANvXxuI1qvCxWk5mzzfgFuUfBNi/ck1rQwp2H6eFIbS2S77MS2DuP+kxts2c
 L5VGFLPTD3d//GfwcCfGj7sAKlRVXtYzr0tW7sHzLvuYEHks879xn+8DroACGbKGsNYv
 JR4A==
X-Gm-Message-State: AOAM531IGyPl7kZ8G58ghPU5u+4/jmN4w9uL7rT+6rsgIL6pOb/EdsgS
 mcDrW2G+Wv5AQvirPjGUGsqo4Q==
X-Google-Smtp-Source: ABdhPJynAIgvGZh5lgT1dMB8QfCCj85+On1CbrvPE/MxzF0iEtzU0TFBEZLfQNsO6io9jXBsYOK7Hg==
X-Received: by 2002:a1c:4408:: with SMTP id r8mr26937260wma.100.1593612221643; 
 Wed, 01 Jul 2020 07:03:41 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id m4sm7346717wmi.48.2020.07.01.07.03.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2020 07:03:33 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id ABF9A1FFBF;
 Wed,  1 Jul 2020 14:56:56 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v4 38/40] containers.yml: build with docker.py tooling
Date: Wed,  1 Jul 2020 14:56:50 +0100
Message-Id: <20200701135652.1366-39-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200701135652.1366-1-alex.bennee@linaro.org>
References: <20200701135652.1366-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x343.google.com
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
index ea350eacff7..b1e39cfd9ac 100644
--- a/.gitlab-ci.d/containers.yml
+++ b/.gitlab-ci.d/containers.yml
@@ -6,14 +6,17 @@
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


