Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B1DCC3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 08:59:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 176F520863
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 08:59:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r217ERns"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 176F520863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35952 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7c07-0003cf-1I
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 04:59:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35938)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i7bkq-0003UD-PM
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 04:44:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i7bkp-0006Oi-Hw
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 04:44:04 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:45803)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i7bkp-0006ON-BW
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 04:44:03 -0400
Received: by mail-wr1-x431.google.com with SMTP id l16so18309850wrv.12
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2019 01:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=mWf/isVu3SS0Rczmwc2uroa954lrwbszbfgDt8fNvlU=;
 b=r217ERnsUXz/0XYVTC3QgGnfyVhTKay4pRMQYO+LZO0MumfdLZEg+sfwMWE5XTep+p
 gkxUM2jOJ+0Xgh2gaNAX5A86OUUb7IZA0Vqyjw/RC6+JItO81fJxf69sOmqczutWuE19
 Qg9qH9N2zmpTNRmFmI1+Jh6l7oRyF15A1pb9//5s1E8Pgq6biXQdhYgJiUi6+VF+Rq3s
 G1AsTepvn024gxHzABUqnI+rbSlW8HKaH6Imiek1GwwXqzIyx11SA7Mcz75xtCR5Yj1F
 Njeq8oMG9l+hHw+e5SWkH8IkPsoZL1FQ89TNGJr7KlVvc7QixcluFquvsXWAQMOqeEEt
 IHvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=mWf/isVu3SS0Rczmwc2uroa954lrwbszbfgDt8fNvlU=;
 b=U/GQ+a1U20+1HZfkSYqAm80IHKW1+3Jl0pnuJz+PUVb21z1KUFAeUV0pMz7OjM99ZG
 2aIxk6284mQi32nrALkJLO8K2JOxV+gEhExkDoJbTUyfa4SVod2eVW5m5ZrU9YJP3eFx
 veJhkbBLR4hDLR2q+lljFTHwmlKr/1E8FtdrSE3kyJUEcXn6oXDXgGlDTHUIQ1obYw0f
 wItUWrG/CjjigrxdkBkrkW8S/0qXd68QYfFvD6DzId+q+CEFvqdZYBWvxpXcP6NIsDD7
 panqg01VWKRdPGQv2IwUpYlF1WJPLVLo5jzT95L61U3hel8nnglmcNiSIiPLNLXnHF3Z
 Sn5Q==
X-Gm-Message-State: APjAAAWorCE/+5zNGRzt0xYJ4RjVukSdhTFY5u//6+w87dgO5qTcjyqJ
 0OoP9S3FkwkAv3+ku2cmagMsoA==
X-Google-Smtp-Source: APXvYqyLkUB5MNe7p75XbDr7Da4J8U1Fk2hMEDD2awNDUKvQY+WIgEvUOUC0RxQrYHRqeioVqtUC3Q==
X-Received: by 2002:a05:6000:1281:: with SMTP id
 f1mr11499024wrx.247.1568105042343; 
 Tue, 10 Sep 2019 01:44:02 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id q25sm2023953wmj.22.2019.09.10.01.43.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2019 01:43:58 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id ECFEC1FF9E;
 Tue, 10 Sep 2019 09:43:50 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Tue, 10 Sep 2019 09:43:19 +0100
Message-Id: <20190910084349.28817-16-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190910084349.28817-1-alex.bennee@linaro.org>
References: <20190910084349.28817-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::431
Subject: [Qemu-devel] [PULL 15/45] tests/docker: move our powerpc cross
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Now Buster is released we can stop relying on the movable feast that
is Sid for our cross-compiler for building tests.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index 48c22ae40c0..7c1ff677a13 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -99,6 +99,7 @@ docker-image-debian-win32-cross: docker-image-debian9-mxe
 docker-image-debian-win64-cross: docker-image-debian9-mxe
 
 docker-image-debian-arm64-cross: docker-image-debian10
+docker-image-debian-powerpc-cross: docker-image-debian10
 
 docker-image-debian-alpha-cross: docker-image-debian-sid
 docker-image-debian-hppa-cross: docker-image-debian-sid
@@ -107,7 +108,6 @@ docker-image-debian-sh4-cross: docker-image-debian-sid
 docker-image-debian-sparc64-cross: docker-image-debian-sid
 docker-image-debian-mips64-cross: docker-image-debian-sid
 docker-image-debian-riscv64-cross: docker-image-debian-sid
-docker-image-debian-powerpc-cross: docker-image-debian-sid
 docker-image-debian-ppc64-cross: docker-image-debian-sid
 docker-image-travis: NOUSER=1
 
diff --git a/tests/docker/dockerfiles/debian-powerpc-cross.docker b/tests/docker/dockerfiles/debian-powerpc-cross.docker
index 5d08fad7cd3..89dd4fbf870 100644
--- a/tests/docker/dockerfiles/debian-powerpc-cross.docker
+++ b/tests/docker/dockerfiles/debian-powerpc-cross.docker
@@ -1,14 +1,12 @@
 #
 # Docker powerpc cross-compiler target
 #
-# This docker target builds on the debian sid base image which
-# contains cross compilers for Debian "ports" targets. The original
-# Jessie based no longer builds.
+# This docker target builds on the debian Buster base image.
 #
-FROM qemu:debian-sid
+FROM qemu:debian10
 
 RUN apt update && \
     DEBIAN_FRONTEND=noninteractive eatmydata \
     apt install -y --no-install-recommends \
         gcc-powerpc-linux-gnu \
-        libc6-dev-powerpc-cross || { echo "Failed to build - see debian-sid.docker notes"; exit 1; }
+        libc6-dev-powerpc-cross
-- 
2.20.1


