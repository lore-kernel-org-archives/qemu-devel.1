Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE513C4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 18:53:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABDC3222C3
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 18:53:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Mw1bv4Vu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABDC3222C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42874 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDYtl-00028U-Ef
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 14:53:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45445)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iDYmA-0002Ix-Eb
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 14:46:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iDYm8-00053u-LS
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 14:46:02 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:45061)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iDYm4-0004vs-QL
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 14:45:58 -0400
Received: by mail-wr1-x444.google.com with SMTP id r5so3612873wrm.12
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2019 11:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=VYw966nJJ2hpRmmeKqunnrmY8rWAa8RXw4YQKvCOc7g=;
 b=Mw1bv4VuLCrM88xdbnGcDQJUiBwq06LDSe68UHsXpiJG14S0H49HVBowg2qqgVOvH3
 28luVGbSHGTwMawIg3xizUxDbW6CNLYDymap0QO3NTDAkvn6KLnAQ33Z7VvLpSWe+Ve4
 LotM/sXP6e4YQ4rlOzDhtRnENSgRaht0iLEPJrG99649aJHXLBxsNLBFHmKrrwYmNSnb
 fzaIPQlUiFbrLn386YlL/o4Zf1r36Vul8E5Zi0AuyrCj46mwJAtz9rvk1cqFd6NLCEmY
 x3btdS3qFOCuNOMaqxY10/5kWcQkWEwg5iUDPQ1/oUSDgqDu+q6qiMNVkBA64liMgqZe
 4tlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=VYw966nJJ2hpRmmeKqunnrmY8rWAa8RXw4YQKvCOc7g=;
 b=E2ZdxWVXZuB/kd9RvDW6czyZ93LmnLIaTiu1FOhXBBenHZwczYVB7ULLGLWcC78Hjd
 ZToJTtaFjk9PmQKNWIBnPQe87KIwm+UYXhhuon7LjlPSzE88QLLEmu4aYwlK+ta6WcM1
 aOH4cxyrtbZFGNDkhQjvsEr5FAAOHPUrXm7q9YUOM+P3UmDUfytwBWHlPIxwRL9Obkzc
 M4wKyXt+V9jEYHtNdBUHvdqoGdn9u0kAvr9VUsv6+3SQ6WCy2M+wig+p6EZK1e8FXQVJ
 qKEq+HNxuIRwe2LufaNXhAX0n/mmcxrqRV8Wj0OFWxLWiYI+89Jg/o5IS8NMWidqJUuF
 +Ljg==
X-Gm-Message-State: APjAAAWwGLyWs0M0B/YLGqFgaaT61X+ogkJMwWuimxF+lVe+Mn0OFcIE
 6urVxmpArHbRvvlnrOVJsXE4yQ==
X-Google-Smtp-Source: APXvYqw0NppToZMt3egznkL76hyneOSOtB7G6+9Asej3K1bg4EgNcmz+ruKSgD0fTQM4fDowx1LGyA==
X-Received: by 2002:a5d:4689:: with SMTP id u9mr4153825wrq.78.1569523551544;
 Thu, 26 Sep 2019 11:45:51 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id e30sm165595wra.48.2019.09.26.11.45.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2019 11:45:48 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 169911FFA9;
 Thu, 26 Sep 2019 19:35:55 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 20/28] docs/devel: add "check-tcg" to testing.rst
Date: Thu, 26 Sep 2019 19:35:45 +0100
Message-Id: <20190926183553.13895-21-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190926183553.13895-1-alex.bennee@linaro.org>
References: <20190926183553.13895-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It was pointed out we haven't documented the check-tcg part of the
build system. Attempt to rectify that now.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

diff --git a/docs/devel/testing.rst b/docs/devel/testing.rst
index bf75675fb0..8e981e062d 100644
--- a/docs/devel/testing.rst
+++ b/docs/devel/testing.rst
@@ -266,6 +266,8 @@ another application on the host may have locked the file, possibly leading to a
 test failure.  If using such devices are explicitly desired, consider adding
 ``locking=off`` option to disable image locking.
 
+.. _docker-ref:
+
 Docker based tests
 ==================
 
@@ -799,3 +801,77 @@ And remove any package you want with::
 
 If you've used ``make check-acceptance``, the Python virtual environment where
 Avocado is installed will be cleaned up as part of ``make check-clean``.
+
+Testing with "make check-tcg"
+=============================
+
+The check-tcg tests are intended for simple smoke tests of both
+linux-user and softmmu TCG functionality. However to build test
+programs for guest targets you need to have cross compilers available.
+If your distribution supports cross compilers you can do something as
+simple as::
+
+  apt install gcc-aarch64-linux-gnu
+
+The configure script will automatically pick up their presence.
+Sometimes compilers have slightly odd names so the availability of
+them can be prompted by passing in the appropriate configure option
+for the architecture in question, for example::
+
+  $(configure) --cross-cc-aarch64=aarch64-cc
+
+There is also a ``--cross-cc-flags-ARCH`` flag in case additional
+compiler flags are needed to build for a given target.
+
+If you have the ability to run containers as the user you can also
+take advantage of the build systems "Docker" support. It will then use
+containers to build any test case for an enabled guest where there is
+no system compiler available. See :ref: `_docker-ref` for details.
+
+Running subset of tests
+-----------------------
+
+You can build the tests for one architecture::
+
+  make build-tcg-tests-$TARGET
+
+And run with::
+
+  make run-tcg-tests-$TARGET
+
+Adding ``V=1`` to the invocation will show the details of how to
+invoke QEMU for the test which is useful for debugging tests.
+
+TCG test dependencies
+---------------------
+
+The TCG tests are deliberately very light on dependencies and are
+either totally bare with minimal gcc lib support (for softmmu tests)
+or just glibc (for linux-user tests). This is because getting a cross
+compiler to work with additional libraries can be challenging.
+
+Other TCG Tests
+---------------
+
+There are a number of out-of-tree test suites that are used for more
+extensive testing of processor features.
+
+KVM Unit Tests
+~~~~~~~~~~~~~~
+
+The KVM unit tests are designed to run as a Guest OS under KVM but
+there is no reason why they can't exercise the TCG as well. It
+provides a minimal OS kernel with hooks for enabling the MMU as well
+as reporting test results via a special device::
+
+  https://git.kernel.org/pub/scm/virt/kvm/kvm-unit-tests.git
+
+Linux Test Project
+~~~~~~~~~~~~~~~~~~
+
+The LTP is focused on exercising the syscall interface of a Linux
+kernel. It checks that syscalls behave as documented and strives to
+exercise as many corner cases as possible. It is a useful test suite
+to run to exercise QEMU's linux-user code::
+
+  https://linux-test-project.github.io/
-- 
2.20.1


