Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9934DC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 14:43:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 608E82071A
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 14:43:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xt3wuFU9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 608E82071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnNfJ-0006lm-KG
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 10:43:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41214)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jnNZj-0005zx-K9
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 10:37:31 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:53324)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jnNZh-0006a3-3Q
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 10:37:31 -0400
Received: by mail-wm1-x344.google.com with SMTP id j18so1567841wmi.3
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2020 07:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=PKCEcn+mdLK6k8p8iASrc3bnXSABtH0c5K5N75Qwt4o=;
 b=Xt3wuFU9VYYO57XBATug7KkGFR2WUZkBywG9zvvfEhAbdAKGYWym2KV5aH4mzB8ei1
 V2MuzC0FxrXxRoq5uMTT32cW+67JzEFFym4GssWW/r9ec199qvy7y82nU4TbKI+AdYaQ
 pqFcpLGCf+Y3pAQRMGw2giREW/xodO/dHGtkHjCKn9LDLrARQB5rXUb36L5DA8zNGVXu
 jS1FG40A0VskJ8dnrkaPDg/zpGYq0g1JhBsRsnl8UvcKdi72PNHERxiQ6aP51juR8p7m
 M3ids8X9geaMb9+fukRlaJTURLOxF5ZhF0MvKJxkYv4+TelvLrG4Vb3jy3co3HcXd6Or
 x0Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=PKCEcn+mdLK6k8p8iASrc3bnXSABtH0c5K5N75Qwt4o=;
 b=WRntHPWz/b3CuJNPdZ0g6lXZ72VMf2OKcYq5I7kylWzpLhUbpU1t8sUl9yVh/WcXmo
 ENkeIHTomB3dUOB4JUlkcCPnn2DbBNSEuwBvU6AlqQ9+l10tQnJDtbsnKsJgbSToxFxL
 MiYPgn8B56jJuYMOgkwXU1qwKoL+gxYaywGT8UnmOx6lJMMtTpQIy3j9giAxbiVWuWZM
 2WP1Uh2Kr+pgR0DTywkKTbD3NsTluzSsUaeHh8ac2i+RV7w2IaFeMQG3f0NAgRVouYYN
 7kz9czlnTVVh35hf0AoaeG2TClBletuhAXr0q4lVevaWFoaMldpw0NIkeKY8UkGO9orI
 eWkw==
X-Gm-Message-State: AOAM532czPE/d+2OCFALhtNWTAfs3GnnjSOdz6nwABXMRbAqp8qgqmyd
 JOeVkxJDyW2J40d9uj+kzcUkNg==
X-Google-Smtp-Source: ABdhPJzU4NLJ/C6C/+biU97nKod1xEXRe4AZiVo7LTtqoU5rTSXptnYR8ElvjQ6oOwbBK++GjRG7+Q==
X-Received: by 2002:a05:600c:2294:: with SMTP id
 20mr19658763wmf.51.1592836647516; 
 Mon, 22 Jun 2020 07:37:27 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id t188sm17525834wmt.27.2020.06.22.07.37.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2020 07:37:25 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 631D01FFA5;
 Mon, 22 Jun 2020 15:32:06 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 17/18] .gitlab: tag remaining jobs as builds
Date: Mon, 22 Jun 2020 15:32:03 +0100
Message-Id: <20200622143204.12921-18-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200622143204.12921-1-alex.bennee@linaro.org>
References: <20200622143204.12921-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x344.google.com
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

Technically these are build and test but there is no reason they need
to wait for other builds to finish to get going. They might get split
latter if the job ever gets too long.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .gitlab-ci.yml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 5c863562913..7816f1434c3 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -184,6 +184,7 @@ qtest:system-fedora-misc-disabled:
 
 build-tcg-disabled:
  image: centos:8
+ stage: build
  <<: *before_script_dnf
  script:
  - dnf install -y clang gtk3-devel libusbx-devel libgcrypt-devel
@@ -203,6 +204,7 @@ build-tcg-disabled:
             260 261 262 263 264 270 272 273 277 279
 
 build-user:
+ stage: build
  <<: *before_script_apt
  script:
  - mkdir build
@@ -214,6 +216,7 @@ build-user:
 
 build-clang:
  image: fedora:latest
+ stage: build
  <<: *before_script_dnf
  script:
  - yum install -y clang SDL2-devel libattr-devel libcap-ng-devel xfsprogs-devel
@@ -228,6 +231,7 @@ build-clang:
 
 build-tci:
  image: centos:8
+ stage: build
  <<: *before_script_dnf
  script:
  - TARGETS="aarch64 alpha arm hppa m68k microblaze moxie ppc64 s390x x86_64"
-- 
2.20.1


