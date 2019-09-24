Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1CA4C432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 22:48:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8693920872
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 22:48:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pjZZIqjS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8693920872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43384 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCtbT-0004IU-RP
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 18:48:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56812)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iCs5L-0003V6-30
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 17:11:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iCs57-0007aQ-IZ
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 17:10:58 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:35457)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iCs57-0007aI-CV
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 17:10:45 -0400
Received: by mail-wr1-x443.google.com with SMTP id v8so3653417wrt.2
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2019 14:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Y4sn+V6zk93CNQtl93c9e6kvD4R1gDhqrW8wkZbGN2Q=;
 b=pjZZIqjSlP7tg/5V742N7AEyEX0xddSI/NLojQ5JjLhXcdVs5Wd/YPq1pFxsUp5/jt
 +GppC1azN4UfEVulolW6CxFGnNN6Pysot04OhM1WTsgcBqCeMU3CsZdNkqTaiR+oE6XN
 0fUXCT8yDH7boc0gZCBM3nTfXR2TfkYxI3lM/vCeQEJPHP6ThaZi5uxGrEbR4YuhQ4cx
 /TslxLo/MsHgaDKE8xk3szxCdg2SsXZu4kjdlXVqPB3OIPalQLjTNnxkBlafw897wXmM
 c1T6zvc3a44gGcDXIYefzUkEefmJmRGiPFIIxOiYVFy8x5MmBPJmqWHEC8EVrSt6u6Yl
 Cdvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Y4sn+V6zk93CNQtl93c9e6kvD4R1gDhqrW8wkZbGN2Q=;
 b=hANHdwy1rO3FcpduzZxQwVDRu5HkAcwjAD0J2dgjOeuom9VN3izQ8VjSONLejCG0Dh
 7hMek90Whuwc70ygc4EiYxchB1BnwQWDrtrfnKgdtuKbsExvfisRGVWcZfjJDazgVAVV
 AtYCG4ChVQE0teM9H02U1o5dK15p1mF7g3YydzmYAxOGn5x59iWM6jxpkoZCVRHBW0f+
 CpbXIuQ87Tx3V2kfjUvr8eXIQ8Pwk7OVsTPcPSwctM2lsecLShSVVxHtaeF8Zq1o1/ad
 pCkLC3PgwOoBTQS8opU/Xm2oLASk4s1SgjQfTbu8DqN6vQPCPf4F4wq9pvxeGaTk50CO
 1uiQ==
X-Gm-Message-State: APjAAAX9xeN36hHmzFqWPs8anVtB4sV+zeDiQrFXSRGuFWbSNsbZjAUH
 Tgha1BD/2LqCF4z5/AAODzWqFQ==
X-Google-Smtp-Source: APXvYqyrzoSS4hUMWgCL5E7mHCuiUJB0OxhKur2fALaptM1Dn+iuI5bhbvHpzn/UFMoIa8ZP99cIRQ==
X-Received: by 2002:a5d:4ac9:: with SMTP id y9mr4914309wrs.371.1569359444270; 
 Tue, 24 Sep 2019 14:10:44 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id q3sm1897626wrm.86.2019.09.24.14.10.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Sep 2019 14:10:41 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 871531FFB3;
 Tue, 24 Sep 2019 22:01:09 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v3 29/33] docker: remove 'deprecated' image definitions
Date: Tue, 24 Sep 2019 22:01:02 +0100
Message-Id: <20190924210106.27117-30-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190924210106.27117-1-alex.bennee@linaro.org>
References: <20190924210106.27117-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, jsnow@redhat.com,
 f4bug@amsat.org, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: John Snow <jsnow@redhat.com>

There isn't a debian.dockerfile anymore,
so perform some ghost-busting.

Signed-off-by: John Snow <jsnow@redhat.com>
Message-Id: <20190923181140.7235-4-jsnow@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/Makefile.include | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index 82d5a8a5393..fd6f470fbf8 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -4,11 +4,10 @@
 
 DOCKER_SUFFIX := .docker
 DOCKER_FILES_DIR := $(SRC_PATH)/tests/docker/dockerfiles
-DOCKER_DEPRECATED_IMAGES := debian
 # we don't run tests on intermediate images (used as base by another image)
-DOCKER_PARTIAL_IMAGES := debian debian9 debian10 debian-sid
+DOCKER_PARTIAL_IMAGES := debian9 debian10 debian-sid
 DOCKER_PARTIAL_IMAGES += debian9-mxe debian-ports debian-bootstrap
-DOCKER_IMAGES := $(filter-out $(DOCKER_DEPRECATED_IMAGES),$(sort $(notdir $(basename $(wildcard $(DOCKER_FILES_DIR)/*.docker)))))
+DOCKER_IMAGES := $(sort $(notdir $(basename $(wildcard $(DOCKER_FILES_DIR)/*.docker))))
 DOCKER_TARGETS := $(patsubst %,docker-image-%,$(DOCKER_IMAGES))
 # Use a global constant ccache directory to speed up repetitive builds
 DOCKER_CCACHE_DIR := $$HOME/.cache/qemu-docker-ccache
@@ -160,7 +159,7 @@ docker-image-debian-powerpc-user-cross: docker-binfmt-image-debian-powerpc-user
 DOCKER_USER_IMAGES += debian-powerpc-user
 
 # Expand all the pre-requistes for each docker image and test combination
-$(foreach i,$(filter-out $(DOCKER_PARTIAL_IMAGES),$(DOCKER_IMAGES) $(DOCKER_DEPRECATED_IMAGES)), \
+$(foreach i,$(filter-out $(DOCKER_PARTIAL_IMAGES),$(DOCKER_IMAGES)), \
 	$(foreach t,$(DOCKER_TESTS) $(DOCKER_TOOLS), \
 		$(eval .PHONY: docker-$t@$i) \
 		$(eval docker-$t@$i: docker-image-$i docker-run-$t@$i) \
-- 
2.20.1


