Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B424C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 14:13:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEE8E20702
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 14:13:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wxl4gecI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEE8E20702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqdU2-0005OK-VH
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 10:13:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59124)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jqdEo-0002af-Qg
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 09:57:22 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:34376)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jqdEh-0005tA-8q
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 09:57:22 -0400
Received: by mail-wm1-x343.google.com with SMTP id g10so6888266wmc.1
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2020 06:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=TNPsrLyF7lXSFi67XMppVcIlDb8Jop3OMsLkQ8Zh/L0=;
 b=wxl4gecImMJT4THqkLYBACUbfKIZwB++ODONQkyqLDLENty9DzcVnMc4zxOo2CCPxn
 aJc14UHBUYQE8DVUPkzSrcTr2TMvfh+ysCqkBYgVPTthLELR84WzvrKtVWO5pkOE9Vot
 q8E744gVxYZdKsldP47c8lL5seuP8L7VGJvjzJpf3wrFd0jUK+uacvetIy0ZynmHz8Ie
 pqEO2UATz9jeUNhAd6GEbkkzdOkpSefXin5r2gne8VJbkuN6Pzn5URNTX6cCBAwnafC3
 zF1TSNYiPjsDxhdeCmZf2yNcuIb+nzMmrQqvhW0Zddj/PdO49B8cLi6a5wx8sC0woqMe
 CdrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=TNPsrLyF7lXSFi67XMppVcIlDb8Jop3OMsLkQ8Zh/L0=;
 b=eV46P/iYZ7bdg57MrcnS60zYo6XY96ZEaUwaG/BHWZAOf83wXADzOGqqziFNGGM7X3
 bfRtERRgn3x+FWYeeurIrqsAHo2Qj7Ma3MvM6vzcpZafrAnZuDyFMR+jq+eXBaOTC7Jq
 HIFiVWS0VH+pw10ORT5UiF3FmWaaneY+QXQAMQw3yjVNeoJzyCzpO1P8zRa/+w5/0H1U
 wqx/M0vuixP6//BzwciYm08HbKkW6fg9ExHHqYzcmUEMcJUpYc44QdHMrwG9XH7olJh7
 WMqCGMgWI5WNR3RI2SJ/TE91lBB4LiRlQMezYoQCfg6REMbv/2+w1ew3Wxe0HIgiFSAS
 xKIQ==
X-Gm-Message-State: AOAM5336D8aAL+lfphXslOlv4uVB5p6lw9aA0MZzyTklEEddO3tj3e8W
 Zy05QmuVpEdKjknqRSH9QWpSfw==
X-Google-Smtp-Source: ABdhPJz3Oe2JIUslinJf5GsWtAgOroJ0Trtcy+zO9BiT4TBtOJUDHEavxM30woe6ZRuvfQiv42SiCA==
X-Received: by 2002:a1c:f616:: with SMTP id w22mr27898939wmc.155.1593611833023; 
 Wed, 01 Jul 2020 06:57:13 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 1sm7109422wmf.21.2020.07.01.06.57.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2020 06:57:02 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 46B371FFAC;
 Wed,  1 Jul 2020 14:56:55 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 23/40] gitlab: build containers with buildkit and metadata
Date: Wed,  1 Jul 2020 14:56:35 +0100
Message-Id: <20200701135652.1366-24-alex.bennee@linaro.org>
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
Cc: fam@euphon.net, berrange@redhat.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org, cota@braap.org,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

According to the documentation to be able to use --cache-from for
remote registries you need to enable both buildkit and inline the
metadata. We want to do this to support pulling from gitlab when users
build their local docker images.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .gitlab-ci.d/containers.yml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/.gitlab-ci.d/containers.yml b/.gitlab-ci.d/containers.yml
index 2afd01f1d17..f353359fd8b 100644
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


