Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A78FC433E1
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 07:27:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A9FD2065D
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 07:27:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="luhIICYQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A9FD2065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60080 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsi0N-0005b2-7H
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 03:27:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45882)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jshxr-0001Tr-D0
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 03:24:27 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:42490)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jshxo-0006fx-Tv
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 03:24:27 -0400
Received: by mail-wr1-x42f.google.com with SMTP id o11so44048378wrv.9
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2020 00:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=YO+flFf+2yJ5JAaqokF7PDcUOrzGxTLuTO5KQlNjjuo=;
 b=luhIICYQJVM69XdfZZPLZIIyZcWs7GLRG9Y5ZAsStsAwji0nvEajCF1b65J0s4Jdu1
 sV4kW/4uDDRP4NUCd7VZQaGqwTG5imA5HDnkQsnot9aLkMLT2WRPMv7rS/iYmRHPnQhJ
 oCPeFypEIAqE8l1ojsux9Tw5XDGrp8tuJhrsSvndQJz1WvW7LRSDanVPBdQ9+ij5gKCT
 jTFykhjZdXHlx0UdXXS60z5mtSEBjcr9CEDl1+Fx2C80ra8XUqo6DHfaR3AY3ug/eag+
 OHBexttdjoo4x3+I6uAx9dyWEWTGNrawOAH0PeTQNbUbr7voGu8T/8EJRO5AaMZL/n/x
 h/Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=YO+flFf+2yJ5JAaqokF7PDcUOrzGxTLuTO5KQlNjjuo=;
 b=sgKO0hnf04kRKQsD2pMRrw+TCCuT/xxeN0Flz028kNjXGE/YkiIdf3oOIwrPhMAje9
 f2GHmNdPQs82u2Azwuxy3l8ZUKd3F65oEk41cFpOchOY5XG+zAclXGkSCN2q6Cx8H6/B
 jGW/TDlYYDpfL8jiszGEUjT5HnswOt9iDWv1YdXwUEOpG33Ku62lq7t64fYRowXIS7xD
 hxteGBSif4EWQinr7r93zno8DDKTGY2Ba0gPxmMK6xm1ukJOfebc7UXC1hd8MDCrNScO
 0xwL2GxDIqrAKGmqh3+8ixnpsj6IqURqorvpzp+LgIthWbS3kh4pEivV5UZ0b5c/LKdi
 OzeA==
X-Gm-Message-State: AOAM531uJJfuLLoqXr6yNYCkq1kTwcURzHKk5CMY8iaoYFgCorplvVy4
 mKeb8xCL6l0krp/dvuaA8kQQaw==
X-Google-Smtp-Source: ABdhPJw8IwbCSR2SvQIgUGTmbSilDeDoZkQuDyEuQ9gRLN+q7K8zN5RgQIzh2wwUkZX7F2wyLg/iig==
X-Received: by 2002:a5d:688d:: with SMTP id h13mr17459418wru.303.1594106663631; 
 Tue, 07 Jul 2020 00:24:23 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 22sm2386322wmb.11.2020.07.07.00.24.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2020 00:24:21 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id A811A1FF87;
 Tue,  7 Jul 2020 08:09:00 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 21/41] gitlab: build containers with buildkit and metadata
Date: Tue,  7 Jul 2020 08:08:38 +0100
Message-Id: <20200707070858.6622-22-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200707070858.6622-1-alex.bennee@linaro.org>
References: <20200707070858.6622-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42f.google.com
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

According to the documentation to be able to use --cache-from for
remote registries you need to enable both buildkit and inline the
metadata. We want to do this to support pulling from gitlab when users
build their local docker images.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20200701135652.1366-24-alex.bennee@linaro.org>

diff --git a/.gitlab-ci.d/containers.yml b/.gitlab-ci.d/containers.yml
index 2afd01f1d179..f353359fd8ba 100644
--- a/.gitlab-ci.d/containers.yml
+++ b/.gitlab-ci.d/containers.yml
@@ -11,7 +11,9 @@
   script:
     - docker pull "$TAG" || docker pull "$COMMON_TAG" || true
     - sed -i -e "s,FROM qemu/,FROM $CI_REGISTRY_IMAGE/qemu/," tests/docker/dockerfiles/$NAME.docker
-    - docker build --cache-from "$TAG" --cache-from "$COMMON_TAG" --tag "$TAG" -f "tests/docker/dockerfiles/$NAME.docker" tests/docker/dockerfiles
+    - DOCKER_BUILDKIT=1 docker build --cache-from "$TAG" --cache-from "$COMMON_TAG" --tag "$TAG"
+                                     --build-arg BUILDKIT_INLINE_CACHE=1
+                                     -f "tests/docker/dockerfiles/$NAME.docker" tests/docker/dockerfiles
     - docker push "$TAG"
   after_script:
     - docker logout
-- 
2.20.1


