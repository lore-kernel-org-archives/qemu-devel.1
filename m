Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28E7CC48BEA
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 14:01:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7394208E4
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 14:01:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rB/3XN8x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7394208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51418 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfPWw-0005wR-5f
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 10:01:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41589)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hfPGJ-0006jD-9s
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 09:44:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hfPGG-0007gE-PC
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 09:43:58 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c]:50526)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hfPGG-0007XQ-BX
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 09:43:56 -0400
Received: by mail-wm1-x32c.google.com with SMTP id c66so12881370wmf.0
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2019 06:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Q/rV4H+M74u+dhawBtWuITzFuv6kQ3ZswIz8UU+IjNo=;
 b=rB/3XN8xaJn+TXtKR1EHfDwWUioqbmCwAUR0RL/KXdhBbMVOlVpHNdSlvqLDXn0YZV
 67or258xLFQCKwIqIOvKunmwvdfFvo3hxooMIIO7DNjNKbSm5x1x0Z/1DMfUO/eLcA/j
 QYfu2bJdKufBfgj/+2/IHZEu0lvk9qqh48T2faX/vjG9yu/qeUV2HVFkj/3XTxCFtSta
 jKdz6MZpnNXIgkO/sA8kenxkZiFebzRKaLHQlXvY66xOOETldTNoD9juafhtZ7cbvlGk
 0kxVLkanNCEL7VhKgMZ18wUlerQOWsXFeQ3VpF1Upr2YJYQZ1bGKPf3TKPkFpu10qode
 rMrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Q/rV4H+M74u+dhawBtWuITzFuv6kQ3ZswIz8UU+IjNo=;
 b=GEC641m3dgN0jlOdlijPFZimjK2ApFdef0PGsbPo1GsgULs00qzbv7zcPv+V7fCr+b
 lO4PoT8iO63IFEcy1iGQhZGucl8GqSu7gXKojN772Sl3JlgGxYhl5OtxvAnD6aK3Vp9R
 RCiWaI3EdQOrgC/HXsxjzCFDp6VBUD8eBix3M6VXidiNS4lcCT/SPzv9h8M9qETCqcxB
 wyTAtPtMJvR/J46lFft2rgMht667hQbsXBTbdG/mV+8DgJOGGwqZ5Wyd+RgjGlJ+kpYu
 lG8VWkobdFlcFwHiCmEzTX2gYdqnrfB3nqNxCTNRWv6w31Wr7HB9VQnn9fPMimO0ng3n
 ucdQ==
X-Gm-Message-State: APjAAAXUqk4BPcTmPYmIrZW4CfdzEkbcsVWhxT4avuxr8PZrLlH8Xl0J
 7N7vhIrPP8ZCEHnLEkTW/fUkvQ==
X-Google-Smtp-Source: APXvYqxnuPpZWp9uwZ8TmRB9HCO4GS9BbWc7m64+nZc1wVERVsBWUam2gl6cRG1MlugvJblcSKrT3Q==
X-Received: by 2002:a05:600c:2549:: with SMTP id
 e9mr16443672wma.46.1561383830031; 
 Mon, 24 Jun 2019 06:43:50 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id e7sm8165642wmd.0.2019.06.24.06.43.42
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 24 Jun 2019 06:43:48 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 108131FF8C;
 Mon, 24 Jun 2019 14:43:39 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Mon, 24 Jun 2019 14:43:36 +0100
Message-Id: <20190624134337.10532-19-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190624134337.10532-1-alex.bennee@linaro.org>
References: <20190624134337.10532-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32c
Subject: [Qemu-devel] [PULL 18/19] Makefile: Rename the 'vm-test' target as
 'vm-help'
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
 qemu-devel@nongnu.org, Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

We already have 'make check-help', use the 'make vm-help' form
to display helps about VM testing. Keep the old target to not
bother old customs.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Message-Id: <20190531064341.29730-1-philmd@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/Makefile b/Makefile
index cfb18f1525..bdeb259dfa 100644
--- a/Makefile
+++ b/Makefile
@@ -9,7 +9,7 @@ SRC_PATH=.
 UNCHECKED_GOALS := %clean TAGS cscope ctags dist \
     html info pdf txt \
     help check-help print-% \
-    docker docker-% vm-test vm-build-%
+    docker docker-% vm-help vm-test vm-build-%
 
 print-%:
 	@echo '$*=$($*)'
@@ -1148,7 +1148,7 @@ endif
 	@echo  'Test targets:'
 	@echo  '  check           - Run all tests (check-help for details)'
 	@echo  '  docker          - Help about targets running tests inside Docker containers'
-	@echo  '  vm-test         - Help about targets running tests inside VM'
+	@echo  '  vm-help         - Help about targets running tests inside VM'
 	@echo  ''
 	@echo  'Documentation targets:'
 	@echo  '  html info pdf txt'
diff --git a/docs/devel/testing.rst b/docs/devel/testing.rst
index da2d0fc964..68aba3926e 100644
--- a/docs/devel/testing.rst
+++ b/docs/devel/testing.rst
@@ -399,12 +399,12 @@ VM testing
 
 This test suite contains scripts that bootstrap various guest images that have
 necessary packages to build QEMU. The basic usage is documented in ``Makefile``
-help which is displayed with ``make vm-test``.
+help which is displayed with ``make vm-help``.
 
 Quickstart
 ----------
 
-Run ``make vm-test`` to list available make targets. Invoke a specific make
+Run ``make vm-help`` to list available make targets. Invoke a specific make
 command to run build test in an image. For example, ``make vm-build-freebsd``
 will build the source tree in the FreeBSD image. The command can be executed
 from either the source tree or the build dir; if the former, ``./configure`` is
diff --git a/tests/vm/Makefile.include b/tests/vm/Makefile.include
index 809b80e2e5..3560716092 100644
--- a/tests/vm/Makefile.include
+++ b/tests/vm/Makefile.include
@@ -8,8 +8,9 @@ IMAGE_FILES := $(patsubst %, $(IMAGES_DIR)/%.img, $(IMAGES))
 
 .PRECIOUS: $(IMAGE_FILES)
 
-vm-test:
-	@echo "vm-test: Test QEMU in preconfigured virtual machines"
+# 'vm-help' target was historically named 'vm-test'
+vm-help vm-test:
+	@echo "vm-help: Test QEMU in preconfigured virtual machines"
 	@echo
 	@echo "  vm-build-ubuntu.i386            - Build QEMU in ubuntu i386 VM"
 	@echo "  vm-build-freebsd                - Build QEMU in FreeBSD VM"
-- 
2.20.1


