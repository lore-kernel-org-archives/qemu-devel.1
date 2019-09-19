Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5028C3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 17:33:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73FF621929
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 17:33:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yaYHrIYM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73FF621929
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47032 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iB0J8-0003RE-VK
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 13:33:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50174)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iB07Q-0008UJ-RI
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 13:21:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iAzwh-0004Kj-68
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 13:10:20 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332]:52486)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iAzwg-0004KD-Uy
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 13:10:19 -0400
Received: by mail-wm1-x332.google.com with SMTP id x2so5535851wmj.2
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2019 10:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=QUh3NVS0+++zbl6WS3omFFjk+nAk4Oz62zwaYtcIJbk=;
 b=yaYHrIYMwj60iB+h00ZOp8E4oitW1BLS07x2xMQl1yRTRkIttrn5M6eqL9+HtZ9zkm
 8CXemClrMETqkXcD5X7NWFKieIbrY3y7IHPQq8Cyz3wOytACckmp0NLrmbF2t+8NISOk
 x3gjFmv49oYV8OZwjdCeUG2DDNQwf+eVvLAeegLlQc3Q3zO8iKhd5NDpJKs6pWURI1KT
 Snjpx9JlIt8NT/skBvvzU4FgaluBlb6Ho9QHq3tSFafcTCvf4UUcs4xIR9tix0j2DyaD
 7bSBquH3JXbmWBnI2vYIGifQUWuP+FLabUCKMJKULgH68P4FpyYArCAbkaMp3jbDZJBa
 SEfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=QUh3NVS0+++zbl6WS3omFFjk+nAk4Oz62zwaYtcIJbk=;
 b=qiO22IkFqAdt4eFyB17KMbZMWGcnYPT/GwoBBgvnyE3xsZHCmynaW28Q4OCbvDTx0d
 +vm2jqLpG/y6GOJwd90vw07aWC4A7iWt3psEdrbInWKPNzqFzyTag3cnpxDOMaWoS6Uv
 GN9xGiCyIVI+huUll/aYy/Cj44fmxY5nenrSoh9aMQAbqXkXVw44kjjJdj4GeJW3vw8r
 PHnGg4cPvixcz0tWpcn0hNMctzR8n/PNSD7S2iQvyuGZjPLXFb6J/7urtZcdnRWUHl37
 K8wUc2qk8tFiecXLH50odgjfubXenbYNEJDQlaqREHRvzc/nQEAWlKSr0YTQaVlVLt2r
 62zg==
X-Gm-Message-State: APjAAAWHR0mH2FJa+XKEMzPEoKYe6KldxpJquGllJFylGmwR4O7g/ra3
 r1M/KKdLcTClf6vsLIezzAopOQ==
X-Google-Smtp-Source: APXvYqzIxGK1qJBLcTIxSCpNWtp1qldpsBXxgWOSh96BhWHIk37C3wztdvN66uvMaunSOLSrKFkNYA==
X-Received: by 2002:a1c:f01a:: with SMTP id a26mr3709735wmb.84.1568913017757; 
 Thu, 19 Sep 2019 10:10:17 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id w4sm9016322wrv.66.2019.09.19.10.10.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Sep 2019 10:10:16 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id D4B1E1FF8F;
 Thu, 19 Sep 2019 18:10:15 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v2 02/16] tests/docker: fix DOCKER_PARTIAL_IMAGES
Date: Thu, 19 Sep 2019 18:10:01 +0100
Message-Id: <20190919171015.12681-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190919171015.12681-1-alex.bennee@linaro.org>
References: <20190919171015.12681-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::332
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
Cc: Fam Zheng <fam@euphon.net>, peter.maydell@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-arm@nongnu.org, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Finger trouble in a previous clean-up inadvertently set
DEBIAN_PARTIAL_IMAGES instead of DOCKER_PARTIAL_IMAGES. Also fix the
typo to debian-9-mxe.

Fixes: 44d5a8bf5d2
Signed-off-by: John Snow <jsnow@redhat.com>
[AJB: merged fix from Message-Id: <20190917185537.25417-1-jsnow@redhat.com>]
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 tests/docker/Makefile.include | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index 50a400b573a..3fc7a863e51 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -7,7 +7,7 @@ DOCKER_FILES_DIR := $(SRC_PATH)/tests/docker/dockerfiles
 DOCKER_DEPRECATED_IMAGES := debian
 # we don't run tests on intermediate images (used as base by another image)
 DOCKER_PARTIAL_IMAGES := debian debian8 debian9 debian10 debian-sid
-DEBIAN_PARTIAL_IMAGES += debian8-mxe debian-9-mxe debian-ports debian-bootstrap
+DOCKER_PARTIAL_IMAGES += debian8-mxe debian9-mxe debian-ports debian-bootstrap
 DOCKER_IMAGES := $(filter-out $(DOCKER_DEPRECATED_IMAGES),$(sort $(notdir $(basename $(wildcard $(DOCKER_FILES_DIR)/*.docker)))))
 DOCKER_TARGETS := $(patsubst %,docker-image-%,$(DOCKER_IMAGES))
 # Use a global constant ccache directory to speed up repetitive builds
-- 
2.20.1


