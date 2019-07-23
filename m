Return-Path: <SRS0=3Ld+=VU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83785C7618B
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 10:43:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52A712081B
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 10:43:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k2hVK6Rl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52A712081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41134 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpsGu-0002EB-LN
	for qemu-devel@archiver.kernel.org; Tue, 23 Jul 2019 06:43:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39766)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hpsFA-0002ro-5C
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 06:42:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hpsF8-0004NQ-4E
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 06:42:04 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:35989)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hpsF6-0004Au-A3
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 06:42:02 -0400
Received: by mail-wr1-x433.google.com with SMTP id n4so42696151wrs.3
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2019 03:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=4Y8RTTqYls9hTDUlXAyFNq7X+0z2NbmIykj1cvcDx80=;
 b=k2hVK6Rl6dco9+BS0IJnAVgDy0iPf64Ic9elKBlDGFoBbnXQVUn0sOsIeQpnA9SK76
 uTNLEvl2IQcIqeEnyr5LHx8X1jhpKHK2XnYLLkRdzQtqOsO703zMg92lRvdfS9cQ3Y4B
 30vaKWF02b6crOyQPXCLn0yXtabohBJlHGYL23DQmyUEZOG9qWSCs8uif/js+ext5+kf
 83X+sAT0oEnPZUAgVdtW8K++Z0MvMorNqrLWEvFJG7iT58LE2epQ0ifWUScYiZFl4yyN
 AAA1lG7CQSELKNcET3w97uruVH4zzFkeCxG+r1eVT/F7oPcyxDrZiTzj2ak+ahjbs56z
 Ij9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=4Y8RTTqYls9hTDUlXAyFNq7X+0z2NbmIykj1cvcDx80=;
 b=i9CtB3OjOaEahhDQc80M8/o5B4kmQU49JifpcF779ajUgZ/JmDKPMktdzVh3GRtELa
 ZOmLp0KC9rMZDpVFQY9Si9/K0l4W7QpTlxB3fQlCtgGJ8HWGJ91+0/wj+3Gd30ZHObe7
 KA5VVDWkKCbqYpTM8wY+u3uwDCno5mtzDCjSfcszinqrjp8yMNtuxbIZmx47zK9iqgYH
 mJztKlSqDpyNC1WKllMX4KSEAaJ9POa5yBw/16uqXy+ln0ZW6WsRyRrA5/afJM+LIncx
 CYJXX/bnBJMXC8/mtwI3ZtxzG/urDebeOR59i8XMdU3wq3SjdW4+jORRxOF/iXp+qmwn
 UYKA==
X-Gm-Message-State: APjAAAV2pXfKUwpZ4R5/QJWHGl2vlWqt03P9OPexUJ1nLccZZcHMNAZ3
 FEURY/toI/qeqTaonGt17qnLXQ==
X-Google-Smtp-Source: APXvYqz/pAGdf74Ov3MUjAQn9WG+X/bIZ2DbUsjsvwpIjVcwNAePn6dZQh+BSdFbPJlmyla9WX2VyA==
X-Received: by 2002:adf:e50c:: with SMTP id j12mr10369413wrm.117.1563878513427; 
 Tue, 23 Jul 2019 03:41:53 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id c30sm73689022wrb.15.2019.07.23.03.41.49
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 23 Jul 2019 03:41:52 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id B073E1FF9E;
 Tue, 23 Jul 2019 11:36:13 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Tue, 23 Jul 2019 11:36:04 +0100
Message-Id: <20190723103612.5600-16-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190723103612.5600-1-alex.bennee@linaro.org>
References: <20190723103612.5600-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::433
Subject: [Qemu-devel] [PULL 15/23] tests/docker: Let the test-mingw test
 generate a NSIS installer
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
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

The NSIS installer generates an executable suitable to install
QEMU on Windows.

Suggested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20190715174817.18981-9-philmd@redhat.com>
[AJB: also --enable-docs in configure step]
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/docker/test-mingw b/tests/docker/test-mingw
index 4b84cfe120a..fdb1c2c879d 100755
--- a/tests/docker/test-mingw
+++ b/tests/docker/test-mingw
@@ -27,8 +27,10 @@ for prefix in x86_64-w64-mingw32- i686-w64-mingw32-; do
         --enable-curl \
         --enable-vnc \
         --enable-bzip2 \
-        --enable-guest-agent
+        --enable-guest-agent \
+        --enable-docs
     install_qemu
+    make installer
     make clean
 
 done
-- 
2.20.1


