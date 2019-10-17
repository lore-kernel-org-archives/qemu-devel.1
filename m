Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ED62ECE58E
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 14:58:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D7FF2064B
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 14:58:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sg38O9ix"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D7FF2064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50033 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL7Ee-0006lF-U6
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 10:58:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41245)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iL6FW-0004eO-39
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:55:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iL6FV-0004Em-4H
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:55:30 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336]:51107)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iL6FU-0004DY-Tc
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:55:29 -0400
Received: by mail-wm1-x336.google.com with SMTP id 5so2687069wmg.0
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 06:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=3fGY4DwdRI3LBI7/7yBxn4Qiw9VPVjBHI4jv3b7spHY=;
 b=sg38O9ixtMuSo4XEVoTNhBDbTkrgd+K3+vxNRpbnnNRtjbPWayuV4QzDOrDcGyz/pR
 6ccxmqpQbb34kLpavxZiTE6gm9iieAJP4qPIeK4BtQUnNzzL3hAgsRMWv3bLLRLEwis1
 m21BhqeufBkvxm0Y5l5fd6ll/wSuLk27gFbONI5DA6tfJ4KQ2utumf6RLx+lcpzqhA6c
 pJMQHMHFxnVRig22tAl0hBtl/7lGd0YqdCbyOnz0RWkhOmuNFIaTvfJGe4DvYpkB2VkS
 3YtPZ1ly/vA3c+2FNbyaf15tjWAQcUTZgI+iRVKd3YQzjVKxJGvRmwBySnnPsUAF6C39
 YAdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=3fGY4DwdRI3LBI7/7yBxn4Qiw9VPVjBHI4jv3b7spHY=;
 b=a8rVMaK2PV8YtU0XbngkzBUwhBrcQqO7JIrsvPvTUs9on8CMmlN/Xt4gpuxrqwEBL9
 5t4ErQldru/iJMik/7kObKgG75afKUdHnYJJAXw8P3B+5JtiD7SHvi2ucYFBBTZwYlQ2
 w79x5Pv6L4aJ/+iBdUy/4Oy4FU5X0kDBd3DnHk1NfVqblou7/Eos7zCxiUtxd7HmFSKi
 f6zMKQcbiAvtnhW2xi+SrTGj9FEU0hHbALVdWCPJ+jiZZD7SErb6+0+KGdP9q9VTA1Sl
 2RvgiTA34gx9O7RL4JwPv66raI8F2Nje6bZ4B4IpssK+hxijXsnWmKERC8D1UgiXGzmI
 EhGg==
X-Gm-Message-State: APjAAAX5x4FTkQ0/x6fXbzlFFyJobqsM/HF+bJ6FqVDLFUp3iVbVS3lk
 dQLi1rzJFW8mncgMMCC8Sn3w9w==
X-Google-Smtp-Source: APXvYqyk0uc4zWzJPhwaKz8HcKrrFb5spk3sJ0zyDcQgo4VEsjL/YCVjrrJECIxWkZXLY94tAtaiHQ==
X-Received: by 2002:a1c:990a:: with SMTP id b10mr2965757wme.39.1571320522855; 
 Thu, 17 Oct 2019 06:55:22 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id r140sm2710271wme.47.2019.10.17.06.55.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2019 06:55:21 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 25B4A1FFC3;
 Thu, 17 Oct 2019 14:16:20 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v6 45/54] tests/tcg: move "virtual" tests to EXTRA_TESTS
Date: Thu, 17 Oct 2019 14:16:06 +0100
Message-Id: <20191017131615.19660-46-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191017131615.19660-1-alex.bennee@linaro.org>
References: <20191017131615.19660-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::336
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 robert.foley@futurewei.com, Richard Henderson <richard.henderson@linaro.org>,
 peter.puhov@futurewei.com, aaron@os.amperecomputing.com, cota@braap.org,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Otherwise clever expanders like the plugins test get unstuck.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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


