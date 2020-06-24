Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A74A9C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 14:15:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7752E2076E
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 14:15:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wskmbiq6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7752E2076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47496 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jo6Bv-0001qw-Nf
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 10:15:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33514)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jo68u-00047l-1q
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 10:12:48 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:40418)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jo68s-0005vN-BT
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 10:12:47 -0400
Received: by mail-wr1-x431.google.com with SMTP id h5so2443927wrc.7
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2020 07:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=WD6VNcX9MpLlUaAe843m6W+P0R0E6C+GHfBa0ZiWKL8=;
 b=wskmbiq6B0bDmhHqaq+JKx4A3ASBEDCd4VUB0g9n4AwmKCCjXDuy285gB64yqW6Jux
 TWfX08nwJNpDzaoFcHIq7HoVxEmWYlmj2zCq/Qa/CBGFB3DpJKjzJCMsPWAZwH9rSzAZ
 lfxBm6s1mLeNg20ch7zhUIehous6cLRbG/RwTCxC6L+b5qztarw/6I3LX3oCgInWHotT
 x0gYhiRDcHtfeyWtNoE1upryP7mfCiksNIrw/1+mqn6xYHtH9CuWnFOiWRZQLqiatZ+h
 MdH7714PQ9eLFwDPpc9Cufz3KavE0SYOLgJ7dEzKF88dTCdlShG32dc5dpVQRyKlX7F1
 7s0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=WD6VNcX9MpLlUaAe843m6W+P0R0E6C+GHfBa0ZiWKL8=;
 b=cPejsaQkjroCmx/qETIlb2Ut64pXVOX6XG0UzdX6287bLJRRLxoa8L4AfIx4gZU0YO
 6yq5+9owQNTadz1xp5ClLVDBGXNtvsRA35IULaBy/j7gYMIEijErNU11NIPEsSQGLiht
 aar4yJ2BAw5tyqrcfqd5vLJrab6TppccKt2nakFNyGorcJjdgGWLBelstNwnEExu/nNd
 t1v5AqqybyPL7xVlk5IIHjNJqE9n56ewoO4bkVmkUg3x2ESmDH9GQUlHsxL7XIWgQR8D
 WT9e5RJT0mG0byj/+oVrqb79WCDHh48hRC8kd62Xu/ewmmdS7GgmannrZtxSkMm/kgnW
 JXhw==
X-Gm-Message-State: AOAM531TFjKjPwxTP/N2B/1pf1SWH0j/INwskqox7lRaCiSOJgsSlTDf
 psmJkT1CxgU3DbJg4bpxrkg4mQ==
X-Google-Smtp-Source: ABdhPJyEHlX+IbTTV/DIhFY44XCWufllIbmo8GApP7tKEoJJNZHCUbfzE6xH6H7oWYbKAUypt8SUSA==
X-Received: by 2002:adf:81c8:: with SMTP id 66mr26929810wra.348.1593007964920; 
 Wed, 24 Jun 2020 07:12:44 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id e4sm1020934wrt.97.2020.06.24.07.12.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2020 07:12:40 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 59FE31FFA9;
 Wed, 24 Jun 2020 15:04:48 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 20/25] gitlab: build containers with buildkit and metadata
Date: Wed, 24 Jun 2020 15:04:41 +0100
Message-Id: <20200624140446.15380-21-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200624140446.15380-1-alex.bennee@linaro.org>
References: <20200624140446.15380-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x431.google.com
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
index 580439647ef..ba9c24e98f1 100644
--- a/.gitlab-ci.d/containers.yml
+++ b/.gitlab-ci.d/containers.yml
@@ -13,7 +13,9 @@
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


