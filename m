Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E773C32771
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 20:45:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2F282071A
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 20:45:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PC/jBEjW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2F282071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47756 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iv5pG-0007xo-3M
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 15:45:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42737)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iv5kt-00081R-IG
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 15:40:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iv5ks-0005x0-Cr
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 15:40:39 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:39811)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iv5ks-0005vQ-67
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 15:40:38 -0500
Received: by mail-wr1-x442.google.com with SMTP id y11so3595327wrt.6
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2020 12:40:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=qWVK9xW79o2SyKcnD6sKK7jgJNF31Jb/exBE+/34Imc=;
 b=PC/jBEjWM8bZydpb2myI59UE57n0+JTfSzMKj2URz3YuqmULhYS4KCRgNBvgybZitq
 C8HQe+dEtK7Jr8ntzduEO1C24tsvmHZkjJT5fVGtSe4YMZNjrrzzHjrYvUvlCbAT17Ob
 6qY8yKn5IH5E5C5DRPz7dXp+hP/cnyCAUnnOPGdkGe7yQl/MNkzdQdpM4J0buWyGVfoF
 UvUOWpRO7fNiAKViSyPLT7+n/DT0rXEMyrHL2H4CpRdeQkPKXJj07jfgeUnH8tsMJXgQ
 8rXctbtnk7GpSENuEzApp1VsQNk4w/DcaS6gQdedrxgIgqVjhNsRsTN1h7Yjpj9izRjH
 MILQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=qWVK9xW79o2SyKcnD6sKK7jgJNF31Jb/exBE+/34Imc=;
 b=KvnqozcsOurjiw1nH43JxqzNZxorEIkqQjoJiN00c8N+bE0k9Ozcna5tGagjpg5piB
 irt+X3LyxzTWjbMYua6bAcHrO7fQQiFOUA+MAACrK1nszpBGgqwc3mYAdPFm1x2fdNuf
 1Pec4AniPjjNRJ5CsVdIxbgHfaxTcqRCEFqZ/Ryhscvw+CDjOEKQh3R16iU+U+LguhaL
 9SbP0VPDFywotU5lG+XPGVRE4dX19Jj0q7g9tiKNzdlzq2y0VOFYANFx3iMqhEkLS3lj
 Kmxn12cjhKuyvMC21Qwr5Z5T1I9iYRBkhkPKTCi2mV5ibM2gxUrM2Zt2pl1yKlpFHxQ/
 JMWw==
X-Gm-Message-State: APjAAAXJs69HOOFwpEXXZr9nqxAoWANRxo8xhynGhNfuyjZmFg8dYaby
 inX00+7WAs+T/+QUh++f+rAEEA==
X-Google-Smtp-Source: APXvYqyd6BzxiSI4s1rlRFyvWWV9K+sC157d7f1Ci8rKpc0yTAXIe94oC0hWvZi+Fi76PlrWe3uvnQ==
X-Received: by 2002:adf:9427:: with SMTP id 36mr6617368wrq.166.1579898437227; 
 Fri, 24 Jan 2020 12:40:37 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id b16sm7926036wmj.39.2020.01.24.12.40.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2020 12:40:33 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 088B61FF96;
 Fri, 24 Jan 2020 20:40:27 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 07/13] tests/docker: move all multiarch containers into
 dockerfiles.multiarch
Date: Fri, 24 Jan 2020 20:40:20 +0000
Message-Id: <20200124204026.2107-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200124204026.2107-1-alex.bennee@linaro.org>
References: <20200124204026.2107-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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

We define multiarch as base distributions that are likely to have
images for any given host architecture.

They will shortly be re-included in the make Makefile.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/Makefile.include                   |  4 +---
 .../dockerfiles.multiarch/Makefile.include      | 17 +++++++++++++++++
 .../debian10.docker                             |  0
 .../debian9.docker                              |  0
 4 files changed, 18 insertions(+), 3 deletions(-)
 create mode 100644 tests/docker/dockerfiles.multiarch/Makefile.include
 rename tests/docker/{dockerfiles => dockerfiles.multiarch}/debian10.docker (100%)
 rename tests/docker/{dockerfiles => dockerfiles.multiarch}/debian9.docker (100%)

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index 43a8678688..c9e8bc40a1 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -62,8 +62,7 @@ docker-image-%: $(DOCKER_FILES_DIR)/%.docker
 		$(if $(EXECUTABLE),--include-executable=$(EXECUTABLE)),\
 		"BUILD","$*")
 
-# Special rule for debootstraped binfmt linux-user images
-docker-binfmt-image-debian-%: $(DOCKER_FILES_DIR)/debian-bootstrap.docker
+docker-binfmt-image-debian-%: $(MULTARCH_BASE)/debian-bootstrap.docker
 	$(if $(EXECUTABLE),,\
 		$(error EXECUTABLE not set, debootstrap of debian-$* would fail))
 	$(if $(DEB_ARCH),,\
@@ -85,7 +84,6 @@ docker-binfmt-image-debian-%: $(DOCKER_FILES_DIR)/debian-bootstrap.docker
 			$(DOCKER_SCRIPT) check --quiet qemu:debian-$* $< || 	\
 			{ echo "You will need to build $(EXECUTABLE)"; exit 1;},\
 			"CHECK", "debian-$* exists"))
-
 endif
 
 # Enforce dependencies for composite images
diff --git a/tests/docker/dockerfiles.multiarch/Makefile.include b/tests/docker/dockerfiles.multiarch/Makefile.include
new file mode 100644
index 0000000000..60617dd7db
--- /dev/null
+++ b/tests/docker/dockerfiles.multiarch/Makefile.include
@@ -0,0 +1,17 @@
+# -*- Mode: makefile -*-
+#
+# Multiarch Containers
+#
+# These containers are ones that will build on any of the major
+# architectures. As a result we can share the rules with whatever
+# system we are installed on.
+#
+
+MULTIARCH_BASE = $(DOCKER_BASE)/dockerfiles.multiarch
+VPATH += $(MULTIARCH_BASE)
+
+#
+# None of the multiarch images can build anything by themselves so
+# they are all BASE containers.
+#
+BASE_CONTAINERS += $(sort $(notdir $(basename $(wildcard $(MULTIARCH_BASE)/*.docker))))
diff --git a/tests/docker/dockerfiles/debian10.docker b/tests/docker/dockerfiles.multiarch/debian10.docker
similarity index 100%
rename from tests/docker/dockerfiles/debian10.docker
rename to tests/docker/dockerfiles.multiarch/debian10.docker
diff --git a/tests/docker/dockerfiles/debian9.docker b/tests/docker/dockerfiles.multiarch/debian9.docker
similarity index 100%
rename from tests/docker/dockerfiles/debian9.docker
rename to tests/docker/dockerfiles.multiarch/debian9.docker
-- 
2.20.1


