Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 217BBC432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 22:34:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D35D62146E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 22:34:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EOp7R/yL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D35D62146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43168 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCtNp-0008WB-OU
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 18:34:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56789)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iCs5C-0003MD-V1
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 17:11:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iCs51-0007ZN-UE
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 17:10:50 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:50476)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iCs51-0007ZB-O2
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 17:10:39 -0400
Received: by mail-wm1-x342.google.com with SMTP id 5so1936633wmg.0
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2019 14:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=/SabVeqMLjGlYBjbqwgWwIsgPvMvXk0prLQNMqx1ZLQ=;
 b=EOp7R/yLAGPOjPQJx5VofqF+e281XD8/DfNgMVi45BH4RIs7dZlatN0WtCsrAewNZB
 IMIbIj77Yj9nIhnbN1ON1KLSuffIvdo0Bd7UTIW/V8wr8VNjjfIRQcsDPjGLsmFI7A52
 RLHRDdrY5c50zhXe652zwqtU7+0mWiCm78IaryLZJsS9DLn7neibSW9Zm24JKQuMGvDx
 hQjLGZSzNkQAjPWsH/0/yMNpErcfqsgXV4rcGM1nyZ+IBtOF1KCWJnptRWCCjOlO2zs5
 QTfnMHTokiPfThzzUZsqC3LkAac9zL9NevkQh1uus2+3Z5UTX6lBhujHsbX4mMiuuzB0
 eHUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/SabVeqMLjGlYBjbqwgWwIsgPvMvXk0prLQNMqx1ZLQ=;
 b=MuQqiudvUpvwCuKTkcRbAW1hn0Gn2GL1g+B9PtxFDh+dY/sq8hd1Et7bCpi8+hcSUj
 NYe6Zqs7ijIS3XBin7nJN7LBcjDQDroym3/D6bgyB/oPs/U1qku/eUTR6499jrRXLTzG
 q1P7O0X6Z6g8MJ8vKT4zfossr/rDogj+TG9SGqERoXzuYdD/QwvLXvNDyt4RTzxvgsdr
 e7Lv7KY/D28y5fAd2DtZbIYohvMzT+RKjuseFXUMd3OjkzGBdSJVnVzOOMyFa96mEBof
 so/ZrtADRVYZptk0okzbCwG2cwrsgCTfloZekk1L5eUsYiXwopAYZn9IV2dkU/akSSAL
 hGlA==
X-Gm-Message-State: APjAAAXht6UviDJZE2WJZf4M9LWmtvEWIza/YSw8yN26ZdyjCEIbpXJh
 1XRJr3Z+lClMKZOXIMJHYmprLw==
X-Google-Smtp-Source: APXvYqwZJHnkNYldbXkvQz2EF/Kq4iJdPyjByqpxKIFRotoxbo6D6oUiQYWGVzz+qEkmXf9n3FWXlw==
X-Received: by 2002:a1c:c78f:: with SMTP id x137mr2731128wmf.42.1569359438641; 
 Tue, 24 Sep 2019 14:10:38 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id d193sm1962005wmd.0.2019.09.24.14.10.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Sep 2019 14:10:35 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 042281FFAB;
 Tue, 24 Sep 2019 22:01:09 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v3 23/33] docs/devel: add "check-tcg" to testing.rst
Date: Tue, 24 Sep 2019 22:00:56 +0100
Message-Id: <20190924210106.27117-24-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190924210106.27117-1-alex.bennee@linaro.org>
References: <20190924210106.27117-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, jsnow@redhat.com,
 f4bug@amsat.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It was pointed out we haven't documented the check-tcg part of the
build system. Attempt to rectify that now.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 docs/devel/testing.rst | 62 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/docs/devel/testing.rst b/docs/devel/testing.rst
index bf75675fb04..1feee3ad101 100644
--- a/docs/devel/testing.rst
+++ b/docs/devel/testing.rst
@@ -266,6 +266,8 @@ another application on the host may have locked the file, possibly leading to a
 test failure.  If using such devices are explicitly desired, consider adding
 ``locking=off`` option to disable image locking.
 
+.. _docker-ref:
+
 Docker based tests
 ==================
 
@@ -799,3 +801,63 @@ And remove any package you want with::
 
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


