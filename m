Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB02EC433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 07:22:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 763742065D
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 07:22:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZwAaBEp2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 763742065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39518 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jshvn-0005JP-MH
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 03:22:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43640)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jshoJ-0006lH-C1
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 03:14:35 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c]:54862)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jshoH-0004rU-K3
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 03:14:35 -0400
Received: by mail-wm1-x32c.google.com with SMTP id o8so42116085wmh.4
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2020 00:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ghYwsDv8y9AcQ/2pLkPngqM/jomzSL1uaEsogMN8yjA=;
 b=ZwAaBEp2m32zYdEjsxYfPLNW+Rr4BeBFvs4P9zd7IRvhyAh388q1dePAcoZFUMxnYr
 v0f5od3tplSIgYsWsQlIFSKTLrXSdBgOJIC4LDLizUik+nJTHMGYx4XWOOTq49hqWR24
 Fhe85TwFNBHz3MSy+zDJV7lMX+O+iFJ6ny+KUd+lDvO/XjU7KTphv5yea2Px8tUDdqHy
 sqFzZgQfNQyA3hepmm4778QSkHkQ1ak9Gu8HPn33rDyZJ+wZt1rHoStZzQtwBdLSlNRr
 oGEnRfToO2Mtv1d0T/Anlme3EhBPgcr3VEU8BcX6OgcOd9d8mLk2CTI+BwW7XyyYa788
 DENQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ghYwsDv8y9AcQ/2pLkPngqM/jomzSL1uaEsogMN8yjA=;
 b=dx45DmGlFpFiRfipm9diaKXy7jSVzAyyPC7jvvTXS8p865MZN8cgVIblV3wNZun2e8
 irBQqspXzKxzktTnQ2KKKVvTQk9OEfnOqBAl9mFKsUIMY/ZgQroxNefIppcyOjfNo6bo
 sEvOp3BScAN54NSsl4USq7qHBMzdjbAqA8Sw5GtOpCGD6oaqDgoQjOW37acW05DdpOfz
 CJYDJd5Wdf7f/ZzX5stZbY9lyexqo43xPZgAYA+1/vA+TPTPZ6gKFs/BjjNQUehbEUV9
 pmITcA5L078OhrpnxLwdLvzUnSZCBnzp+y87woHlg8xhO0uL+lpv1DIIzFs7coE2ZKpI
 PF8g==
X-Gm-Message-State: AOAM531qETlSVItGvCOwwdY0s3u3g2swId5zgmxhLJYO4XmeKNj0UBhn
 GF8FXomZFk2EpFJYzKbwpIFTCQ==
X-Google-Smtp-Source: ABdhPJxWlTAKI5pZppOM0EHLp6+lp6mV7ZFdDX1RdSz4OUtWdzgjjXybfrxQQAnq8x2OHAVQm9MnbA==
X-Received: by 2002:a1c:1fd1:: with SMTP id f200mr2592718wmf.162.1594106072232; 
 Tue, 07 Jul 2020 00:14:32 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id g13sm28007940wro.84.2020.07.07.00.14.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2020 00:14:27 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 15B181FFBD;
 Tue,  7 Jul 2020 08:09:02 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 36/41] containers.yml: build with docker.py tooling
Date: Tue,  7 Jul 2020 08:08:53 +0100
Message-Id: <20200707070858.6622-37-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200707070858.6622-1-alex.bennee@linaro.org>
References: <20200707070858.6622-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32c.google.com
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
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
Message-Id: <20200701135652.1366-39-alex.bennee@linaro.org>

diff --git a/.gitlab-ci.d/containers.yml b/.gitlab-ci.d/containers.yml
index ea350eacff70..b1e39cfd9ac1 100644
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


