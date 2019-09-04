Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96ABAC3A5A9
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 20:54:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CB292087E
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 20:54:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tvSR6OPt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CB292087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39592 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5cIW-0006pn-Oe
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 16:54:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49899)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i5bvT-0008DN-9R
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 16:30:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i5bvJ-0006k2-HR
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 16:30:41 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:43565)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i5bvC-0006fP-G8
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 16:30:31 -0400
Received: by mail-wr1-x443.google.com with SMTP id y8so163853wrn.10
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2019 13:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=DJNOak01VaYIVfmTkJLzi54b9KZZCFhu5sQw2igRPWk=;
 b=tvSR6OPtRKLc39xyC7NzcaqJAmyLjTOuVgvJyob49BwwDpSg1dAgt3qPi9J5uV1WNC
 g8oEzKqFygoRcsGcRPw3NSbrpqbtHv/KECDl5FH+vh6E+rWccP7UHDrXR61TuIjPDLoD
 fwxcAScIOO514e1uKg+WojMei904ie7HIUWpCwjE+0bvHbg/T1CwzWqpmTMFawZvND8K
 oJd6A9AeeOF608EGuFEx9VDb4hqcM0rJ1lrBqUX+TqVMKrpOBNAW3vlYDRoldNMWVbsm
 sVkoRe4rOx6bcbkFirnL/kNLxWErIo8bHehP3M1qGiFEM0TKkAjnKndXK+ce35T33PnG
 ISDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=DJNOak01VaYIVfmTkJLzi54b9KZZCFhu5sQw2igRPWk=;
 b=QyPYn9R1f+RwDbuPhyf2KmSY3Twz4jWtKyFGX7+sxMrqyW/xiCMbCfruGHHSVxBSm7
 ZbTYvWHPurg/O4OTKQGf7R+E/9g7XD9v2f6ILwaxkForBGjj50WyfcacUjFney+Gc07R
 OyjLWrqonM7o3WWKiE6GlO/DgAM6vBIllQEhwlUQdPyp/Mo1CksfktubimZf4GI4cOhF
 MQrC8Y/2/MS5poyTpRaeyApLUR++kmBb/qTWJ/ZrsJDEpGNoYi+yeDV0VvLgzNLF0v5C
 iNpEyZexQ+kz0DhaLaiBWzgKf0ga7P/7Cy0V5OaEW30nmZEMiJL0qjAzLN+3yONQy/mL
 qLxg==
X-Gm-Message-State: APjAAAW/t/yZxezj7pUHvCcuUJbOgufELBXbpg7XtyR8h28GLJ7k8UTA
 TCXS1z3yRiHThZb9PeNAZggOxQ==
X-Google-Smtp-Source: APXvYqyIQhZyFlI03MxF7pN4AD0qI3NWJGYA0IWOnEW7MrrQgNlrLE267YO9oK4PcutYmXFT9a8UeA==
X-Received: by 2002:adf:dfc2:: with SMTP id q2mr22967813wrn.307.1567629028452; 
 Wed, 04 Sep 2019 13:30:28 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id w8sm5467058wmc.1.2019.09.04.13.30.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2019 13:30:25 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id A91C81FF9D;
 Wed,  4 Sep 2019 21:30:14 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed,  4 Sep 2019 21:29:44 +0100
Message-Id: <20190904203013.9028-14-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190904203013.9028-1-alex.bennee@linaro.org>
References: <20190904203013.9028-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: [Qemu-devel] [PATCH v1 13/42] tests/docker: move our Alpha cross
 compile to Buster
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

Now Buster is released we can stop relying on the movable feast that
is Sid for our cross-compiler for building tests.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/Makefile.include                      | 2 +-
 tests/docker/dockerfiles/debian-alpha-cross.docker | 7 +++----
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index 7c1ff677a13..e7379f1d732 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -98,10 +98,10 @@ docker-image-debian-s390x-cross: docker-image-debian9
 docker-image-debian-win32-cross: docker-image-debian9-mxe
 docker-image-debian-win64-cross: docker-image-debian9-mxe
 
+docker-image-debian-alpha-cross: docker-image-debian10
 docker-image-debian-arm64-cross: docker-image-debian10
 docker-image-debian-powerpc-cross: docker-image-debian10
 
-docker-image-debian-alpha-cross: docker-image-debian-sid
 docker-image-debian-hppa-cross: docker-image-debian-sid
 docker-image-debian-m68k-cross: docker-image-debian-sid
 docker-image-debian-sh4-cross: docker-image-debian-sid
diff --git a/tests/docker/dockerfiles/debian-alpha-cross.docker b/tests/docker/dockerfiles/debian-alpha-cross.docker
index 23444342f03..74bcabfdb12 100644
--- a/tests/docker/dockerfiles/debian-alpha-cross.docker
+++ b/tests/docker/dockerfiles/debian-alpha-cross.docker
@@ -1,13 +1,12 @@
 #
 # Docker cross-compiler target
 #
-# This docker target builds on the debian sid base image which
-# contains cross compilers for Debian "ports" targets.
+# This docker target builds on the debian Buster base image.
 #
-FROM qemu:debian-sid
+FROM qemu:debian10
 
 RUN apt update && \
     DEBIAN_FRONTEND=noninteractive eatmydata \
     apt install -y --no-install-recommends \
         gcc-alpha-linux-gnu \
-        libc6.1-dev-alpha-cross || { echo "Failed to build - see debian-sid.docker notes"; exit 1; }
+        libc6.1-dev-alpha-cross
-- 
2.20.1


