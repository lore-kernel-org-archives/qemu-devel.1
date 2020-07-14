Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99FB4C433E8
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 09:54:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68B6F21D7D
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 09:54:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jCcUTPPv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68B6F21D7D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56416 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvHdd-0005An-MB
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 05:54:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58448)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jvHcS-0003WU-Jp
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 05:53:00 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a]:36957)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jvHcQ-0003xM-J0
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 05:53:00 -0400
Received: by mail-wm1-x32a.google.com with SMTP id o2so4415749wmh.2
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2020 02:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=5OziHlIm1D2m/j1XzyWy/gSoDZmDvA7wpzFEAFDGd5g=;
 b=jCcUTPPvgZOnaybzBkeGXp0lTT2PADB66MxUFM/Qxr1O08zRSlqvXpN2b4y4hLqKgW
 IMGps7a/fEdrpwtFUyZGSkHyU6bpXnzLufJ9M0RTAvgR7OHGLrTIo10TyGCp4nQ90IXT
 8knugF88O6deJbUGtR7Mg6fZC9/mpu0vRfFt/XQtqg0WvaZ27xipf8KnWenkVd4n1TuQ
 j9Knsre6czKQF9H9C6ml/YPKxFmw+Py+thxWjglTM7q7rAca7HClMcxLAvbD1QZgnf8V
 GpMiPrLABJeEuXHADMNCO+RwG9jP2N5+ZMv7Yvi2puVOWQ91cckrn4Hl7eSi7CSKnGiO
 k8KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5OziHlIm1D2m/j1XzyWy/gSoDZmDvA7wpzFEAFDGd5g=;
 b=kMvlnA5mYSYe8t5WGaWffoAYktjwkuKHQ66G2zjCUA3yoyQudLNdrkmaaLJ7VUxWlT
 54wpzKW17hhiBo17s6CES1KIYlLgo96iH9QAhz9V35+HQ2yye+w7c8TdYc2IexJ9usdt
 cgwK/qPQJEfoH7zeygb8dvzYU3jm4laHfVNiwCzvBZhdk5eZszmmu97TYcQ+C3Nyadhh
 Hgmezc9J9/P0DiyJPnuOMOpX0tYq41Le8UUYdPxfu7rTiFNHAZ9rSMRKuCzpYaz2w49E
 glftUkgUc19E6uA+SdHEpXORL4Fnezs63R2GSpM2inz04pD509hytp5tNcFEWtRJhXcO
 DKcw==
X-Gm-Message-State: AOAM530b/s16Vd5xhfVO8RMysOltc0EUvmwIdaG4Nmh07dBjXqutJvEy
 ZnXUnkM3x1bIi8boTrYHlFCY9Q==
X-Google-Smtp-Source: ABdhPJx6RBf1g9XV/uTblFVLJPwNbrnyDkhl+PtvG34iTNklCsgQ2wkSLPv0kOmbGe7bYGxoAaGkHQ==
X-Received: by 2002:a7b:c197:: with SMTP id y23mr3626146wmi.114.1594720377183; 
 Tue, 14 Jul 2020 02:52:57 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id u10sm3484318wml.29.2020.07.14.02.52.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2020 02:52:53 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id BBD991FF91;
 Tue, 14 Jul 2020 10:52:47 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 5/9] gitlab-ci/containers: Add missing wildcard where we should
 look for changes
Date: Tue, 14 Jul 2020 10:52:43 +0100
Message-Id: <20200714095247.19573-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200714095247.19573-1-alex.bennee@linaro.org>
References: <20200714095247.19573-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32a.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Thomas Huth <thuth@redhat.com>

The tests/docker/* wildcard seems to only match the files that are directly
in the tests/docker folder - but changes to the files in the directory
tests/docker/dockerfiles are currently ignored. Seems like we need a
separate entry to match the files in that folder. With this wildcard added,
the stages now get re-run successfully when something in the dockerfiles
has been changed.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20200713182235.30379-1-thuth@redhat.com>

diff --git a/.gitlab-ci.d/containers.yml b/.gitlab-ci.d/containers.yml
index f3c0ca4d61..8c89efeb6d 100644
--- a/.gitlab-ci.d/containers.yml
+++ b/.gitlab-ci.d/containers.yml
@@ -24,6 +24,7 @@
     - changes:
       - .gitlab-ci.d/containers.yml
       - tests/docker/*
+      - tests/docker/dockerfiles/*
     - if: '$CI_COMMIT_BRANCH == $CI_DEFAULT_BRANCH'
     - if: '$CI_COMMIT_REF_NAME == "testing/next"'
 
-- 
2.20.1


