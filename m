Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C78A9C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 10:51:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CF9521D7D
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 10:51:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IfmD/gpF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CF9521D7D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38716 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihtOi-00007x-3k
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 05:51:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38138)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1ihtNF-0006Xp-De
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 05:49:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1ihtNE-000841-D0
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 05:49:41 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d]:36697)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1ihtNE-000804-4X
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 05:49:40 -0500
Received: by mail-wm1-x32d.google.com with SMTP id p17so5123588wma.1
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2019 02:49:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=bnYqPNG6o//7k1MDVkGUWOrGmJeXC2A4NyL/DVQdWXI=;
 b=IfmD/gpFylQLhGXqK+nVtQ09olHVMurWI7zlbaJ0LaPxbdJMnqZ+Lipa45kncwQ2kN
 F32f6KuWKQe+609O638kEAMVru4qwhWMuvEND5rYZeiDLAzNqkS9D74oIiVDISliWdDb
 o9usOx0JKodRdrRn9JOvEFd9v8M5I3DEPxCSUb1eyJN+S6nQRZgL+wSgJBOriWuRMpB9
 1DSXtt9nKBd2kXifSnSYWmN+vInv4a9W8HuddSokaUSqfwZDx6sTOfYiewt1RyhuQpu4
 CvqJOSDyO7yqP2iyJOsXhjctOLADvpESL57ix/zqhGrrbsHmxhYRoGlmn+uoxbfwPlvL
 zLcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=bnYqPNG6o//7k1MDVkGUWOrGmJeXC2A4NyL/DVQdWXI=;
 b=sonavFSi9CsCFDSzFF2rI9OcLj4p6aTNUpsEyduHlBdz5cJN+wo1Jhvb8+lHb2PW92
 6INlSONdei6w4MmFnz/pAsjbTJQSNDrwRePncr8ioHxm0Aa+66u7FAzZE7Lvz2TiCQ+V
 8TDj+hieYoo+XrFKf4RPlGvrCMq5tsItOUVjyp16pcLz9KO245J1oIGZho65QSJqClZ6
 YcTHb7V3jzTWL52o8tpV4eBYCz/LIXNY2EzO1O2xI6Hi9PfYAKkh1cbrBR2zsk1K3tET
 jB5XPQ9cZZOCjo7sQ6y7l4ADU0n4jd+rtaF/c8AnRJnFNti9RStMAt4EjzM9IowiJZfj
 Hr1g==
X-Gm-Message-State: APjAAAW5dhHQdS2sT2DK9/7rVdemm0KkOQmSQJLDJFhcZ2GsRIxP2Zof
 L+rz6ZY2vY6DbBvghlAwmqvcvw==
X-Google-Smtp-Source: APXvYqw3vp7uhelZoT1FHrP6gHRffw0nv3RXEsW2fMqO4sY7NZBC7pGz3YD9CSvb0uvBPns5cdItBA==
X-Received: by 2002:a1c:b456:: with SMTP id d83mr9017363wmf.172.1576752579049; 
 Thu, 19 Dec 2019 02:49:39 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id q19sm5631354wmc.12.2019.12.19.02.49.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2019 02:49:35 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id B6CE71FF90;
 Thu, 19 Dec 2019 10:49:34 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 03/25] travis.yml: Run tcg tests with tci
Date: Thu, 19 Dec 2019 10:49:12 +0000
Message-Id: <20191219104934.866-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191219104934.866-1-alex.bennee@linaro.org>
References: <20191219104934.866-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32d
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 Stefan Weil <sw@weilnetz.de>, Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Thomas Huth <thuth@redhat.com>

So far we only have compile coverage for tci. But since commit
2f160e0f9797c7522bfd0d09218d0c9340a5137c ("tci: Add implementation
for INDEX_op_ld16u_i64") has been included now, we can also run the
"tcg" and "qtest" tests with tci, so let's enable them in Travis now.
Since we don't gain much additional test coverage by compiling all
targets, and TCI is broken e.g. with the Sparc targets, we also limit
the target list to a reasonable subset now (which should still get us
test coverage by tests/boot-serial-test for example).

Tested-by: Stefan Weil <sw@weilnetz.de>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20191204083133.6198-1-thuth@redhat.com>
[AJB: just --enable-debug-tcg]
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

diff --git a/.travis.yml b/.travis.yml
index 6cb8af6fa59..15946293ff3 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -214,10 +214,11 @@ matrix:
         - TEST_CMD=""
 
 
-    # We manually include builds which we disable "make check" for
+    # Check the TCG interpreter (TCI)
     - env:
-        - CONFIG="--enable-debug --enable-tcg-interpreter"
-        - TEST_CMD=""
+        - CONFIG="--enable-debug-tcg --enable-tcg-interpreter --disable-kvm --disable-containers
+            --target-list=alpha-softmmu,arm-softmmu,hppa-softmmu,m68k-softmmu,microblaze-softmmu,moxie-softmmu,ppc-softmmu,s390x-softmmu,x86_64-softmmu"
+        - TEST_CMD="make check-qtest check-tcg V=1"
 
 
     # We don't need to exercise every backend with every front-end
-- 
2.20.1


