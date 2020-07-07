Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95166C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 07:19:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63679206E2
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 07:19:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CsamUib+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63679206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54920 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jshtI-0008RZ-Kd
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 03:19:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43624)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jshoI-0006hl-46
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 03:14:34 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:46644)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jshoG-0004rK-Fg
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 03:14:33 -0400
Received: by mail-wr1-x430.google.com with SMTP id r12so43920459wrj.13
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2020 00:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=QcDsGkNTaeJACoHN9Zi8eoA/LmcFjDZTuPYv9J/13u0=;
 b=CsamUib+kh/ukEfM4sBKp7U6RVCw/zg0f0XctfckiI3X9EwWY6vSgR9pyhzVh3E5Q/
 OmknDa8+3dY9kRH+CkJ4BaRqWBI9fau7TDaTLFkHWTHR32+C5LjjZoBbbmrjcJdaodw/
 RA38T2OjQRtN/OJV0CQD6MbF6GpBtmUnTImKX+It89XY+h2RT7dNOJGagzmorb0FqEvr
 QeVLSCPWhAvxMo0bGv2z67qB/k0f6WT2eUZF4v2tJUQ7QPCzw1Ri3i054qDvymZzNngn
 mlg+NeNsyX3as+yhNh50EYX4+qiiTEwICHrVZEUCCX1ArjSwdNZDLPrbj9HXQD1OKI3q
 EP5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=QcDsGkNTaeJACoHN9Zi8eoA/LmcFjDZTuPYv9J/13u0=;
 b=kkfIBuWYeCxhsvAKWho7l41d9ofQM8GwteJRV6Ze2U1QT+OGHBSwQ993W8ZjmnBffC
 jvdt/q2jjvN9SDXFd0c2e7jqLC61KXRAl7FcWEJ9OQkQgf/MeUiFYdVGP3F1vk5fJ4ri
 21fozWHBOO/ZZiFOJJOT6Xk1hB3tTAxTEstCRR2Px7iginWcEDxHYQPNULGOOiPE+RuQ
 f55QjfEHMjJNA/GN2gymoeNqI32HJLQI/Ol4/GmcoXxHhii2vaTtWpIhBpK7T9HNbqyg
 fEnepo/3dYDluPXCXGewqK5QkocLKax1f6JXzjKqucz1kgJWzszxgmgqQE3WE3ZAbZOl
 8+Gg==
X-Gm-Message-State: AOAM5317n8dPjMAKeLvZd0IS+/qcX/oep+IKkkDdL5PTlAFo9+54USFR
 mHD1Mv8EFyvV7KGGbI9C0o1oXQ==
X-Google-Smtp-Source: ABdhPJxCy12zDGlE8PAdQk8DlOrg6KGDeEbOmeuaYbBkMXDnRBwskD9/uoZ5rEs70KA/bbJrb+9b7A==
X-Received: by 2002:adf:fa8b:: with SMTP id h11mr52440866wrr.391.1594106071075; 
 Tue, 07 Jul 2020 00:14:31 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id j15sm17963248wrx.69.2020.07.07.00.14.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2020 00:14:31 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 4B1491FFA5;
 Tue,  7 Jul 2020 08:09:00 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 17/41] gitlab-ci: Fix the change rules after moving the YML
 files
Date: Tue,  7 Jul 2020 08:08:34 +0100
Message-Id: <20200707070858.6622-18-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200707070858.6622-1-alex.bennee@linaro.org>
References: <20200707070858.6622-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x430.google.com
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
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Laszlo Ersek <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Thomas Huth <thuth@redhat.com>

The edk2.yml and opensbi.yml files have recently been moved/renamed,
but the change has not been reflected in the rules in the YML files
yet.

Fixes: 922febe2af ("Move edk2 and opensbi YAML files to .gitlab-ci.d folder")
Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Laszlo Ersek <lersek@redhat.com>
Message-Id: <20200625151627.24986-1-thuth@redhat.com>
Message-Id: <20200701135652.1366-20-alex.bennee@linaro.org>

diff --git a/.gitlab-ci.d/edk2.yml b/.gitlab-ci.d/edk2.yml
index 088ba4b43a33..a9990b71475f 100644
--- a/.gitlab-ci.d/edk2.yml
+++ b/.gitlab-ci.d/edk2.yml
@@ -2,7 +2,7 @@ docker-edk2:
  stage: build
  rules: # Only run this job when the Dockerfile is modified
  - changes:
-   - .gitlab-ci-edk2.yml
+   - .gitlab-ci.d/edk2.yml
    - .gitlab-ci.d/edk2/Dockerfile
    when: always
  image: docker:19.03.1
diff --git a/.gitlab-ci.d/opensbi.yml b/.gitlab-ci.d/opensbi.yml
index dd051c01245d..6a1750784ac1 100644
--- a/.gitlab-ci.d/opensbi.yml
+++ b/.gitlab-ci.d/opensbi.yml
@@ -2,7 +2,7 @@ docker-opensbi:
  stage: build
  rules: # Only run this job when the Dockerfile is modified
  - changes:
-   - .gitlab-ci-opensbi.yml
+   - .gitlab-ci.d/opensbi.yml
    - .gitlab-ci.d/opensbi/Dockerfile
    when: always
  image: docker:19.03.1
-- 
2.20.1


