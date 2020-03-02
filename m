Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CDC5C3F2D1
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 18:25:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E18220842
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 18:25:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UGAo3r9w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E18220842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37036 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8pkv-0004eW-K4
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 13:25:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43597)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j8pfD-0002X4-FN
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 13:19:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j8pfC-0001Dk-B0
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 13:19:35 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:56149)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j8pfC-0001Ao-4l
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 13:19:34 -0500
Received: by mail-wm1-x344.google.com with SMTP id 6so66052wmi.5
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2020 10:19:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=0iM0DGDZ4ZSBxBSg0NI9sVRz/1idecs1gKgGJztSJQU=;
 b=UGAo3r9wQWDMWcOmThKUwtESe8haPaY+ahWbTcQdnKWFaH9SgE4drfZiHP2nihWP+o
 jmVACJTJikma2UEztj1KVQ+liMqRaCYe2tJ27B26Qm+7ExMrsf+JMft7xRqS9nmrI1sH
 GKKBg2cE1LeB7N5K4NJRPx3JtlJOHQnT5Q1ZyOOzgQ+L3b0J5Oro2Gdl+EBqgadFu2uI
 7uUi869QiP15iPVCGwYHFoSKrucez0qxzIJ3zjDF16SPkHs4Iwtb0qd5H3k46lsXnQtG
 WKPucjelBfnLo3VGbmzFVTdwBjOVAJgHjuRX0W+l7jdBsw2Oc789kG5o0m7FL/XUufaL
 oo6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=0iM0DGDZ4ZSBxBSg0NI9sVRz/1idecs1gKgGJztSJQU=;
 b=Xka3QLLibkfaUox9Frg1v8wtrA9uByldQdSoFni8GkTXLWutT+Ove1n3V1Yh3M7nII
 DjR+IUTQ6kvjPzsN2s9IB0VYrWhaqSDkYxCbLDr/RkB+ZNBmxVnaX3vqtQjWd95kxW33
 yMqY6r+CcZLonNQwEAhxv/rO0h1z82bkzFNYY9xSiobc3UEkYsyAvXcE4e4+96l6+yX9
 ot5pJ0YXA2N5pm1C2XFz5BCxk+25TepZxhaV9YyxF6nPjxh9WojgW5HrknmvWtrW9NLV
 DrOIE9dyp7tFwECFUoLXZKOuiTz1/7kvZFn3PziHhQqFBRpQmatSC6VNMj6kvzeXDn4m
 g5mg==
X-Gm-Message-State: ANhLgQ3chHuEq65hDeUrbJJvrpZ/5DdScXECx8S+hgA7cwCY+ATIYYHV
 VTJ8XcKi2NrfeR8Q6wAWgRa3wQ==
X-Google-Smtp-Source: ADFU+vsuAkL8zn1ak9Pt7XYeVV2FbEkKSMlDc9qKe/bsGAZliveuDl1MAfNtbSuCSFEUwCSRL1ja1A==
X-Received: by 2002:a1c:7e57:: with SMTP id z84mr297289wmc.148.1583173160098; 
 Mon, 02 Mar 2020 10:19:20 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id e11sm28390088wrm.80.2020.03.02.10.19.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2020 10:19:15 -0800 (PST)
Received: from zen.home.arpa (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 67CB71FF9A;
 Mon,  2 Mar 2020 18:19:08 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 10/10] travis.yml: install python3 numpy and opencv
 libraries
Date: Mon,  2 Mar 2020 18:19:07 +0000
Message-Id: <20200302181907.32110-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200302181907.32110-1-alex.bennee@linaro.org>
References: <20200302181907.32110-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

These are used for the acceptance framebuffer tests to count Tux.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .travis.yml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/.travis.yml b/.travis.yml
index 70a24bf2fc8..9db6c1557f1 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -323,6 +323,8 @@ jobs:
           packages:
             - python3-pil
             - python3-pip
+            - python3-numpy
+            - python3-opencv
             - python3.5-venv
             - rpm2cpio
             - tesseract-ocr
-- 
2.20.1


