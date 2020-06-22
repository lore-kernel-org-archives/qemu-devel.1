Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CB39C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 14:40:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBFDC2071A
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 14:40:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TTGg/oHu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBFDC2071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47728 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnNd4-0003Lm-2X
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 10:40:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41186)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jnNZi-0005xY-C3
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 10:37:30 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:38430)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jnNZg-0006Zz-Lv
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 10:37:30 -0400
Received: by mail-wr1-x441.google.com with SMTP id z13so5177439wrw.5
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2020 07:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=r4zwLgzQI1wdPNBnB1IfLtnWJ7YheiR6CeL9tVns6/w=;
 b=TTGg/oHughCIbCBUy0ldQCAts8eXYCCTMrFM0zSPCYsW3XqYia57ITz/uM02j5gZ5g
 nUnWLThkc6sOTAcAUeRpFJjMo3/25+FY284/7m42dj+uLDz3FxEX3RpGs3ZSNd8WZFqf
 RSYX30whXPYz3e6mAcMATtqZo9CrOXIGivXu76Q1J8QZ53mACmIyUNBrJaXv37ALMob4
 mLFY5koHCCl3qyAdqSyJE1sDl1wAxl3PQwbHAzh2euzd+/0BW1sNEufwcrQVVkpvaHIA
 BU7Y1Xawg+9IeqiOFk0eB577fUu8E2Ps8tKKgGVUPSWcLJ1kvHYKKoSVzGzdzqGG+GD1
 Pt1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=r4zwLgzQI1wdPNBnB1IfLtnWJ7YheiR6CeL9tVns6/w=;
 b=sSM+alH6G7fCyuHsuFkQLQzeQIQc0YYL4sGopMEgdTdMmdMxwySoVyJS8TRjA+i9XC
 g0dBkFg/60rpyJB1GJR6//fr/T3Ez4wd3HFLbxOzPKNRgp7kNNqsS3WAfCLHf4eQAfjq
 50h/87xZVuiADiuX6M0UHfGFP6SeMLip8IA4oHrGo47SMR31i5osy45UNC9/nzLVAyEU
 oDPeH5Hp7JYREEwCuPS8IK7YcyuduBp/ZG3ebYYquPLT6V1FuqEkskMA1WtbC/eXC7CE
 lT6MzF9Yq+hBISY/l6+TOAjLKWcNGpcRr3rsNqZCpDeYN/HgvxMQ4Ik9HzXr9sQkL1Hg
 RDkg==
X-Gm-Message-State: AOAM532wiYEmI8HfZxgQER69xtktHaEQtx9BRzBYmopXNryDYerTIOUq
 ZzXpydYOnImOxkyQhje+z6fWNA==
X-Google-Smtp-Source: ABdhPJw/bU/1mGmYHKZvFb6aRExCiy3FF0xjpSOB2Ej02TAdBMc8glIH6VnBnc+mfixGyeiG0abHqg==
X-Received: by 2002:a5d:4f09:: with SMTP id c9mr19019698wru.3.1592836646931;
 Mon, 22 Jun 2020 07:37:26 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 104sm18688389wrl.25.2020.06.22.07.37.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2020 07:37:25 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 4BF441FF9F;
 Mon, 22 Jun 2020 15:32:06 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 16/18] .gitlab: split fedora-misc-disabled
Date: Mon, 22 Jun 2020 15:32:02 +0100
Message-Id: <20200622143204.12921-17-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200622143204.12921-1-alex.bennee@linaro.org>
References: <20200622143204.12921-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x441.google.com
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

As we run check-qtest in "SLOW" mode this can timeout so split into
two jobs.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .gitlab-ci.yml | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index fc3a561d9bc..5c863562913 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -153,8 +153,9 @@ acceptance:system-fedora-misc:
  - make check-acceptance
  <<: *post_acceptance
 
-build-disabled:
+build:system-fedora-misc-disabled:
  image: fedora:latest
+ stage: build
  <<: *before_script_dnf
  script:
  - mkdir build
@@ -167,7 +168,19 @@ build-disabled:
       --disable-vhost-net --disable-vhost-crypto --disable-vhost-user
       --target-list="i386-softmmu ppc64-softmmu mips64-softmmu i386-linux-user"
  - make -j"$JOBS"
- - make -j"$JOBS" check-qtest SPEED=slow
+ artifacts:
+   paths:
+     - build
+
+qtest:system-fedora-misc-disabled:
+ image: fedora:latest
+ stage: test
+ dependencies:
+ - build:system-fedora-misc-disabled
+ <<: *before_script_dnf
+ script:
+ - cd build
+ - make check-qtest SPEED=slow
 
 build-tcg-disabled:
  image: centos:8
-- 
2.20.1


