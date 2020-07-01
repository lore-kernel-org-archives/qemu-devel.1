Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DD02C433E1
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 14:05:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FA6420663
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 14:05:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="evcPGZDx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FA6420663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56174 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqdMB-0006Vy-B2
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 10:04:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59130)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jqdEu-0002cC-Vt
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 09:57:29 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:40071)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jqdEj-0005tW-4e
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 09:57:28 -0400
Received: by mail-wr1-x443.google.com with SMTP id h5so23947241wrc.7
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2020 06:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=hCA6Fp1zjl/YcdAD2qr1JaESX1/DMtcBS8XPo6xk3BI=;
 b=evcPGZDx6VcoAplJ+O3WTf/V0gdN7LFhhqY+tWhKnSlyof1wl3pDaslalzqlh2Dtf3
 NUPMVrksla/BXss5p/QiJWzXEtzlOS997usukFS6idwW1PXEdmyPgT4c3a7PqDl0bHl/
 M01tgp2ktTtRsnjkOIip6Nsm80ZaKTcy+Wzv2ZW8ve4fWbbMMBWqxq6axU7AEsV9SdUg
 PEoDKzZWFXYOkAa2BjbCAMoCTUm/SKAk2uhIDtP7KXQIg9ZfNOsNKjBJv2d/pIj5mHvQ
 K+zO0Z+WVPBC/696VzTC0KyCT5CgzKrOO2fJUpeF1b+KUmh9cVkwKtV+GOKuEZxhNQxh
 cFsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=hCA6Fp1zjl/YcdAD2qr1JaESX1/DMtcBS8XPo6xk3BI=;
 b=m2+jBrbvfjpLHDN3h/qqsKqCHUmpYVcacrpLBOCqF8RPqKQxo7rb7q5sjSAFo/Gj4D
 bWbjVnsHXoYcP4lxcvwjVAOfTs0vVvEjb0GqCedSYUbNY0BEmB6zrH2U+/UQb8jqgfXg
 qZtKRzGKRCfcQi/6kNhJYCtPukFVI9Jm1GIvtYANQPmksqzYeMiVsKI2gReVuA43tnSs
 iqlj1GbuDGXhFGaSo/w24m6F5sd0FLtMTMNGfp/m8vMHDRRsH8AqTfI9WoQ8l1PbWSge
 IspLvILWWbJ/Hb3IHsaeDXjE42cena/cTNIsuSfkdM6IhpWHGeNOJEbBAKgrozggizBC
 rHUQ==
X-Gm-Message-State: AOAM531ZxbbEgWxlYGU5e23TfhHESey+mjW2R4af6ByQgLwBJEpmECbY
 E6Z9sc12WOBM/JmaZI6xRGNlSw==
X-Google-Smtp-Source: ABdhPJxqgGVcfXz/iXjs/wbts7Lh6N2/8Y1sAaQWeDpU1J/HgXNYgEIKNN8zJ8Z7cWUia4GkyyJ2wA==
X-Received: by 2002:adf:8b5a:: with SMTP id v26mr26527074wra.165.1593611835351; 
 Wed, 01 Jul 2020 06:57:15 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id y20sm7266415wmi.8.2020.07.01.06.57.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2020 06:57:05 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 973331FFBE;
 Wed,  1 Jul 2020 14:56:56 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v4 37/40] gitlab: limit re-builds of the containers
Date: Wed,  1 Jul 2020 14:56:49 +0100
Message-Id: <20200701135652.1366-38-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200701135652.1366-1-alex.bennee@linaro.org>
References: <20200701135652.1366-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x443.google.com
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
 richard.henderson@linaro.org, f4bug@amsat.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, cota@braap.org,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Most of the time we are just rebuilding the same things. We can skip
this although currently there is no mechanism for picking up new
distro releases.

Rather than try to be too fine grained allow any change to trigger all
the images being rebuilt.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

---
v4
  - try and include branches
  - use rules instead
---
 .gitlab-ci.d/containers.yml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/.gitlab-ci.d/containers.yml b/.gitlab-ci.d/containers.yml
index a7621c4204c..ea350eacff7 100644
--- a/.gitlab-ci.d/containers.yml
+++ b/.gitlab-ci.d/containers.yml
@@ -17,6 +17,12 @@
     - docker push "$TAG"
   after_script:
     - docker logout
+  rules:
+    - changes:
+      - .gitlab-ci.d/containers.yml
+      - tests/docker/*
+    - if: '$CI_COMMIT_BRANCH == $CI_DEFAULT_BRANCH'
+    - if: '$CI_COMMIT_REF_NAME == "testing/next"'
 
 amd64-centos7-container:
   <<: *container_job_definition
-- 
2.20.1


