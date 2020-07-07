Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93918C433E1
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 07:18:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62B0E206F6
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 07:18:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R9v8p9Ae"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62B0E206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45144 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jshre-0004M4-Kg
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 03:18:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43622)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jshoH-0006hH-TP
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 03:14:33 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:36104)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jshoG-0004rI-8b
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 03:14:33 -0400
Received: by mail-wr1-x436.google.com with SMTP id k6so44006533wrn.3
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2020 00:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=fVpFU3Bn0gx8fweRN9XBf8loHnsbKZ9F1g1Uyun+Gsg=;
 b=R9v8p9AeUq2v6ydPU9XeLm7KEUpSWIYFUsXmqGq/pcbaCLgExX3UzYb8WSY1ZVO7vS
 R0N9dhWsat59BvoOOTpVaWsq+1k6+04KSYhwWYPOrSBpOMbJDz9mc+pN0Xi7yI33Pvvf
 BaAmOlCK2xYKRpG4koFGnaHFQhjGnZrCnw1BWd8o2toAK71FS24ephW2oWZCE9orVsz4
 PcDNLtKH18/L3PO470NtrWJh2FuzMVAbuDgM1jpeCfw/uXHf2EBhTjhxxrgEbAXJZ3bw
 75en7898w2I+hSoX/2ZPLXCmZdsQeWeE3LwHRXHvQEm81XLQVmlmdqOE0AESDX0S9mL8
 ewPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=fVpFU3Bn0gx8fweRN9XBf8loHnsbKZ9F1g1Uyun+Gsg=;
 b=bzvimRNmisSAHlk65IIVwkGZpREcyVja/94++UkT/ZuRnUBTSXCdfpmgKeSRLL36pS
 y9tDo5MH/BVNrNZVI4kfGrK9f8H9wiKo2Ri6tZ00GoBURHWlhatvwUSBhPTEp2+MlCtG
 t4/oqDUyBZ8Y5pTEzGAPnKJCXK+6zxCJPhitWFke3tupHxczoSSgtap8Co6KvwqGL2Lp
 4JvjGGrO4crCp7D16tUYQSpWqO/OULPVHRZipXMO6mDWoNYj+usVhwvLj0UFuSNJ/E3a
 0Osxuf7kOlU43wxfkU/wRVo5QDPY/SaQn2aJIBYAQt7zXKg6YRzhfVfCqBxc+cXR7xLb
 +tBg==
X-Gm-Message-State: AOAM533WchUaytXSomYHuTQSWdBi3jKWiw3cxaq3ZJHmWagux9JSx2Az
 gM/TENOW9UzIzWjHOkSpfpsNbQ==
X-Google-Smtp-Source: ABdhPJxmGtovh0WxrLk3sQG75lLyAVsh6Ydo/nY/kSLQ8+wgsSfpXm/1liGjffbk+W4UqRDoqXXIRA==
X-Received: by 2002:adf:b1ca:: with SMTP id r10mr24403519wra.150.1594106070886; 
 Tue, 07 Jul 2020 00:14:30 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id c25sm2107501wml.46.2020.07.07.00.14.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2020 00:14:27 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 3CCD21FFB3;
 Tue,  7 Jul 2020 08:09:01 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 27/41] tests/acceptance: skip LinuxInitrd 2gib with v4.16 on
 GitLab
Date: Tue,  7 Jul 2020 08:08:44 +0100
Message-Id: <20200707070858.6622-28-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200707070858.6622-1-alex.bennee@linaro.org>
References: <20200707070858.6622-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x436.google.com
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
 qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This fails on GitLab but not when run locally on the same container
image. It's very confusing.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Acked-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20200701135652.1366-30-alex.bennee@linaro.org>

diff --git a/tests/acceptance/linux_initrd.py b/tests/acceptance/linux_initrd.py
index a3e54d3fc915..a249e2f14a24 100644
--- a/tests/acceptance/linux_initrd.py
+++ b/tests/acceptance/linux_initrd.py
@@ -8,10 +8,12 @@
 # This work is licensed under the terms of the GNU GPL, version 2 or
 # later.  See the COPYING file in the top-level directory.
 
+import os
 import logging
 import tempfile
 
 from avocado_qemu import Test
+from avocado import skipIf
 
 
 class LinuxInitrd(Test):
@@ -51,6 +53,7 @@ class LinuxInitrd(Test):
                 max_size + 1)
             self.assertRegex(self.vm.get_log(), expected_msg)
 
+    @skipIf(os.getenv('GITLAB_CI'), 'Running on GitLab')
     def test_with_2gib_file_should_work_with_linux_v4_16(self):
         """
         QEMU has supported up to 4 GiB initrd for recent kernel
-- 
2.20.1


