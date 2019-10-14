Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CD8BC4CECE
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 11:19:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9FC120673
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 11:19:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qbH0faCQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9FC120673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47592 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJyOG-0004w8-M7
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 07:19:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45416)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iJy27-0006Xc-RZ
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 06:57:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iJy26-00055g-K1
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 06:56:59 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:40117)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iJy25-00051X-SF
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 06:56:58 -0400
Received: by mail-wr1-x42d.google.com with SMTP id h4so19187452wrv.7
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 03:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=zgKKogRe87ORjvkyL8Bd5r+4c7iR9meeLjhfDNvmOGE=;
 b=qbH0faCQ9jnCEhBUCQH8pnoqojlDLD76S7SiqWpvEaayl5WitjxGq4a5IWWZXSNUsg
 o5c43sqNe1Q3HmhTFV+gI37XrZUUt+VmJpHnX4kOekMezW38L0l6kQVWnbbPB0X6Sqaj
 Jh2myrRobttOkn3MwbWuT7GsWA2KQuVfzwRoGXxIOIWWq4vKwTXFyrK6LG5/qxJm/iHn
 DQ3EBl6K6OVCtKCsP08cVcyZmYKbxq0sFbHP1CboEPdebRu4J0j7k0U2q334mEel0l07
 ifNAqt2zw3cTWlmsGkjOk4A7nDpp/nh9Ffq1iiXJxbdunXcWvSMDXTLRY9Y6ujEz7yFL
 WDNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=zgKKogRe87ORjvkyL8Bd5r+4c7iR9meeLjhfDNvmOGE=;
 b=AMX9A8kPL0jBNE7BVs4KIt4Qrf9yhQ9yVkspZ/8L2KXtIp3uVgVNEfRdmNH6CXmQlf
 r9kxq1xw1FC50LY3npv8ZFjAwxQlj5uXsp9bWuaBQS0iLiGQMand6urMxwUtJAv+BNI+
 lz6RdT2tE7e39LkaL8FaxyeQ9wNPSBdELb7bdcNhQh4jAZC6i7OeJgBL01Xtr65nMruJ
 uAiYtjwdqj68ydsLA7r1YQ00SWFHEw1yxA6rkA2bsF2zsqCBEYUu5ApCWHYvzZTX5LnX
 6mUrLiY3YTwKzkTMlc9FE98f93LMV6sriL7qk3tyVt7qYc2e77FtDrKGbqKYNiwylHqd
 MBlA==
X-Gm-Message-State: APjAAAUuABgF86sqEM/XL+0wE1Hb8QDjJXppBSfhVnW6E4oZLwkdjnUs
 TPwp3e2X3DqCiNKlSiygiVO/+Q==
X-Google-Smtp-Source: APXvYqz0fuwyFsl9Y8w98oy/R2Q7VnvhjtqY0yb5mo6HojYLC0cAUlO9d2f/GkglcCayZsoqyiK7ZA==
X-Received: by 2002:adf:e40a:: with SMTP id g10mr15807002wrm.395.1571050614791; 
 Mon, 14 Oct 2019 03:56:54 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id x129sm34203080wmg.8.2019.10.14.03.56.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2019 03:56:52 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 57AEF1FF96;
 Mon, 14 Oct 2019 11:49:58 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v5 42/55] tests/tcg: move "virtual" tests to EXTRA_TESTS
Date: Mon, 14 Oct 2019 11:49:35 +0100
Message-Id: <20191014104948.4291-43-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191014104948.4291-1-alex.bennee@linaro.org>
References: <20191014104948.4291-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42d
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 robert.foley@futurewei.com, peter.puhov@futurewei.com,
 aaron@os.amperecomputing.com, cota@braap.org,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Otherwise clever expanders like the plugins test get unstuck.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/tcg/Makefile.target                 | 4 +++-
 tests/tcg/aarch64/Makefile.softmmu-target | 2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/tests/tcg/Makefile.target b/tests/tcg/Makefile.target
index 84abbd24f3..9664613002 100644
--- a/tests/tcg/Makefile.target
+++ b/tests/tcg/Makefile.target
@@ -66,6 +66,8 @@ conditional-diff-out = 							\
 
 # Tests we are building
 TESTS=
+# additional tests which may re-use existing binaries
+EXTRA_TESTS=
 
 # Start with a blank slate, the build targets get to add stuff first
 CFLAGS=
@@ -109,7 +111,7 @@ else
 
 endif
 
-all: $(TESTS)
+all: $(TESTS) $(EXTRA_TESTS)
 
 #
 # Test Runners
diff --git a/tests/tcg/aarch64/Makefile.softmmu-target b/tests/tcg/aarch64/Makefile.softmmu-target
index b4b3957963..950dbb4bac 100644
--- a/tests/tcg/aarch64/Makefile.softmmu-target
+++ b/tests/tcg/aarch64/Makefile.softmmu-target
@@ -52,4 +52,4 @@ run-memory-replay: memory-replay run-memory-record
 	   	  $(QEMU_OPTS) memory, \
 	  "$< on $(TARGET_NAME)")
 
-TESTS+=memory-record memory-replay
+EXTRA_TESTS+=memory-record memory-replay
-- 
2.20.1


