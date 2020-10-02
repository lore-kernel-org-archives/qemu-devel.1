Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A25E4C4363D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 11:49:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46CE1206B7
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 11:49:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P/GMOXfY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46CE1206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOJZ3-0002yD-D8
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 07:49:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48606)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kOJNI-0006vB-NY
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 07:37:21 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:41132)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kOJND-0007cw-7t
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 07:37:20 -0400
Received: by mail-wr1-x42d.google.com with SMTP id w5so1436843wrp.8
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2020 04:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=DGPu6xjpfVcU2cvvFnAej/PDIX48+sbuTihWwVf3EwU=;
 b=P/GMOXfY1MSIp/9VqV+MovMG4OzhnGnTjZHpUhQRCA+tXr2yMR0L9ZZniVy7kshy8V
 XNQuLF2vQSDwtQj0oCmarryr7HmG5gZx+gmkr4DErsy01JdwWs90kHTFX/hSiDdNI+wG
 Q69oV49pjTxl3pkKZKqRw0koi00fzZJ4anKtnt/R3EUr0LaHKoELLxtSGbktbvD0AnEJ
 +Hh3oHT6W8n5Cb7LihTwTN/2A2sWE2Z9aD7I8anMi34o26XfBcSeaYF2TiPoplrMk80l
 ew5BqQ2Y5x3sKbgHA7zhT59xdJZXUSs61AecYU3L55fHkwm0KqyTPRFYj2vWmiGICLW9
 f96g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=DGPu6xjpfVcU2cvvFnAej/PDIX48+sbuTihWwVf3EwU=;
 b=I38/0caeeIugC8040CbTCZKDELtRmx7eWPrQAwreVcyEdVrhUbISJwYQAECvGZweRD
 PoohuPvCFXO1rlP+PuNDeZgZlalaH2RTxWDS5nWdwCLFqxa9EH13yFk2oMMoZLsVQY0f
 DJoP9Asis/6UsX28BXc/zndjhlZlG8ff0cYMd/KkOQDT1rTB2VX4aYgoKAbulYq0pLoY
 uk/Hu7xHpvWhAy4H5BL/rJ+wvVVmy4/Bt7zQlM9Vi+g0sbEhWE4840iOE53NkVVykD72
 77yqAiCU8pW06Zi70nMl1IYZwbbLi1PbqtGghqw+lLBlXmDOHE4E83LS+Hv+1dUQKmcY
 chYA==
X-Gm-Message-State: AOAM530qth7G6N+TMAdUdnXTCKfZ1JXy8v0GvY7kBr698WLm0I3WgmG3
 F1sCMJPE7dEa1Edcl72OBRg3LbDGHUBtOQ==
X-Google-Smtp-Source: ABdhPJx1oOG1dtvMTzeUDBI6/JNQIq+1+TQGpsWvqtXCPKZJl3rCuUZbIhNj+1PNsviC7zXu+rif3Q==
X-Received: by 2002:adf:e5c8:: with SMTP id a8mr2631011wrn.5.1601638621859;
 Fri, 02 Oct 2020 04:37:01 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id a10sm1424062wmj.38.2020.10.02.04.36.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2020 04:36:51 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 619241FF91;
 Fri,  2 Oct 2020 12:36:46 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 05/14] travis.yml: Drop the Python 3.5 build
Date: Fri,  2 Oct 2020 12:36:36 +0100
Message-Id: <20201002113645.17693-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201002113645.17693-1-alex.bennee@linaro.org>
References: <20201002113645.17693-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42d.google.com
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Thomas Huth <thuth@redhat.com>

We are soon going to remove the support for Python 3.5. So remove
the CI job now.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20200922070441.48844-1-thuth@redhat.com>
Message-Id: <20200925154027.12672-9-alex.bennee@linaro.org>

diff --git a/.travis.yml b/.travis.yml
index 990dd11e6f..c255c331a7 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -253,15 +253,6 @@ jobs:
         - TEST_CMD=""
 
 
-    # Python builds
-    - name: "GCC Python 3.5 (x86_64-softmmu)"
-      env:
-        - CONFIG="--target-list=x86_64-softmmu"
-        - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-default"
-      language: python
-      python: 3.5
-
-
     # Using newer GCC with sanitizers
     - name: "GCC9 with sanitizers (softmmu)"
       dist: bionic
-- 
2.20.1


