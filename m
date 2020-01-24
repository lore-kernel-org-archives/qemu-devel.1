Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7079BC2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 20:45:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AB642071A
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 20:45:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bnPOY3Og"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AB642071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47752 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iv5pF-0007xC-Dm
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 15:45:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42822)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iv5l3-0008Fc-U7
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 15:40:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iv5l2-0006Ek-4c
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 15:40:49 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:54653)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iv5l0-0006Cy-Fj
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 15:40:48 -0500
Received: by mail-wm1-x344.google.com with SMTP id g1so709237wmh.4
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2020 12:40:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=/+jNmQLLkrLRuLeA6WjHIEWFKmBV3BttYfXACj4o0jI=;
 b=bnPOY3OgSY2zAdWMxMTSLM8Q3/0gfOqVnGAcY146rUK1eS4G0541hNdDKUkOS5zVFO
 RNdqgiljZCo5ZpR9jlidhcOKqanxTk3gpBEA2vcQDRRj+RMFhdPl1vIAWEtoqu88Esvz
 QmynrWwMCl4B0ZOBCqdyEcQ1h8oBBtUKS2XifK7SPQWBQVzbhMse0j9rC4kUkeZH3WVs
 vANiwD6VeIUiOijj5lW7IhmtVQjBujhRY0T8+tendeThwoI5q0PSahftTlbetmk/6JAq
 zdtsFhJ7pZ6qA/UIWWeIRILMuIQjpQgjNkPN1YWrN/g96/W+6FfNHWaUwx8WkK6EKCVm
 4CyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/+jNmQLLkrLRuLeA6WjHIEWFKmBV3BttYfXACj4o0jI=;
 b=Q2htjoA1wQHi/iHWNuLRMAaKMpLLrvivzdOcj10ae+7yCGIAi9DdI4fECQPdepFocD
 OJjrI69L8ytaQRX1i0aetHtDI+niZaHXXk3GsZVmpre8dCfYu1U0e+4+4vU0iNwThs7S
 IBQnUGlHb6gPZnJQ9AuTDRl0NcDYqQX/SoeD9/eDBcriEf8vpdhpDMC+75o1DoRR0465
 cnIfyyT9QXcdCUlCKsrFB3mgbNdXoejFCAlx7ieu3qJSWpcUbfszugrbvDJCfT94qiPU
 oWJUarV2h7iXYEJZCGlw4IbIY2IEqKJBX3IFIH2XgTukqQrZZxd4L3scBnaDej48lank
 caWA==
X-Gm-Message-State: APjAAAU+SLPaWp4BVnZWfnkncPOankH+U/XxGooX0abKsHq3r+0MBBIP
 Yqxve6AhTkqaQ4K0Iq6YdBpgFw==
X-Google-Smtp-Source: APXvYqyBayAIttlYT236O+LWhXNmGQN1lRgNfO+if479VsqTAvf78pf5UQKQSQoa/TLbBVLazpbKeA==
X-Received: by 2002:a05:600c:295a:: with SMTP id
 n26mr874082wmd.187.1579898444020; 
 Fri, 24 Jan 2020 12:40:44 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id w8sm14904131wmd.2.2020.01.24.12.40.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2020 12:40:41 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id B4CD21FF9D;
 Fri, 24 Jan 2020 20:40:27 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 13/13] tests/docker: enable cross-compilers for aarch64
Date: Fri, 24 Jan 2020 20:40:26 +0000
Message-Id: <20200124204026.2107-14-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200124204026.2107-1-alex.bennee@linaro.org>
References: <20200124204026.2107-1-alex.bennee@linaro.org>
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
Cc: fam@euphon.net, berrange@redhat.com, stefanb@linux.vnet.ibm.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, cota@braap.org,
 stefanha@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

While Debian's aarch64 mainly only packages other ARM compilers we do
have access to x86_64 cross compilers and a few system compilers for
various micro controllers.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .../dockerfiles.aarch64/Makefile.include      | 24 +++++++++++++++++++
 .../debian10-aarch64-qemu-build.docker        |  1 +
 .../debian10-x86_64-qemu-build.docker         |  1 +
 .../debian9-armel-qemu-build.docker           |  1 +
 4 files changed, 27 insertions(+)
 create mode 100644 tests/docker/dockerfiles.aarch64/Makefile.include
 create mode 120000 tests/docker/dockerfiles.aarch64/debian10-aarch64-qemu-build.docker
 create mode 120000 tests/docker/dockerfiles.aarch64/debian10-x86_64-qemu-build.docker
 create mode 120000 tests/docker/dockerfiles.aarch64/debian9-armel-qemu-build.docker

diff --git a/tests/docker/dockerfiles.aarch64/Makefile.include b/tests/docker/dockerfiles.aarch64/Makefile.include
new file mode 100644
index 0000000000..791ddf856b
--- /dev/null
+++ b/tests/docker/dockerfiles.aarch64/Makefile.include
@@ -0,0 +1,24 @@
+# -*- Mode: makefile -*-
+#
+# AArch64 Containers
+#
+# The cross-compilers are not as well packaged for AArch64 although we
+# do have access to 32 bit ARM, x86 and a smattering of the
+# microcontrollers.
+#
+
+AARCH64_BASE = $(DOCKER_BASE)/dockerfiles.aarch64
+VPATH += $(AARCH64_BASE)
+
+#
+# We have both QEMU build and TEST build containers we can access
+#
+QEMU_BUILD_CONTAINERS += $(call get-basenames,$(wildcard $(AARCH64_BASE)/*-qemu-build.docker))
+TEST_BUILD_CONTAINERS += $(call get-basenames,$(wildcard $(AARCH64_BASE)/*-test-build.docker))
+
+# Generate build-deps based on names
+#
+# Most of this architecture are based on Debian images
+AARCH64_CONTAINERS=$(call get-basenames,$(wildcard $(AARCH64_BASE)/*.docker))
+$(filter-out,debian9,$(AARCH64_CONTAINERS)): docker-image-debian9
+$(filter-out,debian10,$(AARCH64_CONTAINERS)): docker-image-debian10
diff --git a/tests/docker/dockerfiles.aarch64/debian10-aarch64-qemu-build.docker b/tests/docker/dockerfiles.aarch64/debian10-aarch64-qemu-build.docker
new file mode 120000
index 0000000000..cd1caa0704
--- /dev/null
+++ b/tests/docker/dockerfiles.aarch64/debian10-aarch64-qemu-build.docker
@@ -0,0 +1 @@
+../dockerfiles/debian10-native-qemu-build.docker
\ No newline at end of file
diff --git a/tests/docker/dockerfiles.aarch64/debian10-x86_64-qemu-build.docker b/tests/docker/dockerfiles.aarch64/debian10-x86_64-qemu-build.docker
new file mode 120000
index 0000000000..63e9a69855
--- /dev/null
+++ b/tests/docker/dockerfiles.aarch64/debian10-x86_64-qemu-build.docker
@@ -0,0 +1 @@
+../dockerfiles.cross/debian-amd64-full-cross.docker
\ No newline at end of file
diff --git a/tests/docker/dockerfiles.aarch64/debian9-armel-qemu-build.docker b/tests/docker/dockerfiles.aarch64/debian9-armel-qemu-build.docker
new file mode 120000
index 0000000000..b818459261
--- /dev/null
+++ b/tests/docker/dockerfiles.aarch64/debian9-armel-qemu-build.docker
@@ -0,0 +1 @@
+../dockerfiles.cross/debian-armel-full-cross.docker
\ No newline at end of file
-- 
2.20.1


