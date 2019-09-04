Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AED91C3A5A9
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 21:42:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79C46208E4
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 21:42:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pMvsKvq5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79C46208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40418 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5d2N-0000gg-1V
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 17:41:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54169)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i5cDX-0001xL-V6
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 16:49:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i5cDW-0002SI-Ju
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 16:49:27 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:35565)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i5cDW-0002Rk-Dj
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 16:49:26 -0400
Received: by mail-wr1-x42a.google.com with SMTP id g7so248696wrx.2
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2019 13:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=nQUAtVsslkJ4r9+COAvvl/ujYC8YWVWBFis/DB41CnY=;
 b=pMvsKvq5smTCin/K1Ykk3d+3kVQgmNwEbNJat9rPEjBt1YYOLMLJAV5af9qWHjByvO
 sEZYKqqLPCIzgaZ7tzB1hzrxAEDVIZeNzHJJkvavpIduO2pvicZHsel9MkFcvhYe7cd6
 Fms+Aog14ZltZ0v4ATjM7RceHfwrDSZgRtT2uuCpJR7oPCUqB3uBTHv3FJZ0ivfrKPA2
 fpgznL/rcNYEeKMtBOEQHfiyvx4lPc2d6aJLfH/05dJhRfHd6BHeEyjycu/EsWLCTxtO
 AeiWZQJHw5/Pmy0DudxXtZIxFCKnuSfduOIkU2l89yu2ytx6a3hmKBifETpGj9cn7FDG
 UQ4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=nQUAtVsslkJ4r9+COAvvl/ujYC8YWVWBFis/DB41CnY=;
 b=FbTNZrAI2aRg3gsy5y3ZE6Nv81KygRnlxAEpFomP49Q8GfHVpT67/VTE9yQPnxgtQ9
 c0vnSheH2YHb3HpPc2qdZbAK+CQdLpEbPk43vCFpw6NjgHvKhNltIEB05N3+vuhd/NfQ
 LJiBcugBljj3puZ8oSooIPR0SoGCfjz/PqdVqcQOji/thMAwL/bWORINsQWelGtseYMM
 eaRnuTSFHU2083VZ78/MvWGfQKVSd2KTM5bw2yTpbPQoUVimL0Jai6JA3jagNia7LGP5
 V/9HVt0gsjtfXGWkp9Qi63yzJhwHgwF7OwGWOm1vFYwZdPvY2BrEd+QXaytbaRmCOSl4
 YOag==
X-Gm-Message-State: APjAAAVA1xB5hoNVY2LV54Atcqapy8Yic1fqYmSZVwGwPaNwr1ubwC9A
 frVKuIOykmR+ekF43Goo08qtWA==
X-Google-Smtp-Source: APXvYqylPZMG7Oc4vXhAxniVkCJvVhmzRHlHlvr8tT2fIyCWxEp+X0PQeEDa//BUMWOZfs42d41fcQ==
X-Received: by 2002:adf:e48f:: with SMTP id i15mr21475361wrm.26.1567630165274; 
 Wed, 04 Sep 2019 13:49:25 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id r17sm22396419wrt.68.2019.09.04.13.49.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2019 13:49:22 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 4D34A1FFA9;
 Wed,  4 Sep 2019 21:30:15 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed,  4 Sep 2019 21:29:51 +0100
Message-Id: <20190904203013.9028-21-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190904203013.9028-1-alex.bennee@linaro.org>
References: <20190904203013.9028-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42a
Subject: [Qemu-devel] [PATCH v1 20/42] tests/docker: move our ppc64 cross
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
 tests/docker/Makefile.include                      | 4 ++--
 tests/docker/dockerfiles/debian-ppc64-cross.docker | 7 +++----
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index 93190b1e2a2..b6c04059502 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -104,11 +104,11 @@ docker-image-debian-hppa-cross: docker-image-debian10
 docker-image-debian-m68k-cross: docker-image-debian10
 docker-image-debian-mips64-cross: docker-image-debian10
 docker-image-debian-powerpc-cross: docker-image-debian10
+docker-image-debian-ppc64-cross: docker-image-debian10
 docker-image-debian-riscv64-cross: docker-image-debian10
 docker-image-debian-sh4-cross: docker-image-debian10
 docker-image-debian-sparc64-cross: docker-image-debian10
 
-docker-image-debian-ppc64-cross: docker-image-debian-sid
 docker-image-travis: NOUSER=1
 
 # Specialist build images, sometimes very limited tools
@@ -117,7 +117,7 @@ docker-image-tricore-cross: docker-image-debian9
 # These images may be good enough for building tests but not for test builds
 DOCKER_PARTIAL_IMAGES += debian-alpha-cross debian-hppa-cross debian-m68k-cross debian-sh4-cross
 DOCKER_PARTIAL_IMAGES += debian-sparc64-cross debian-mips64-cross debian-riscv64-cross
-DOCKER_PARTIAL_IMAGES += debian-tricore-cross debian-powerpc-cross fedora-i386-cross
+DOCKER_PARTIAL_IMAGES += debian-tricore-cross debian-powerpc-cross debian-ppc64-cross fedora-i386-cross
 DOCKER_PARTIAL_IMAGES += fedora-cris-cross
 
 # Rules for building linux-user powered images
diff --git a/tests/docker/dockerfiles/debian-ppc64-cross.docker b/tests/docker/dockerfiles/debian-ppc64-cross.docker
index e5757fe46ee..4bf88ab02dd 100644
--- a/tests/docker/dockerfiles/debian-ppc64-cross.docker
+++ b/tests/docker/dockerfiles/debian-ppc64-cross.docker
@@ -1,12 +1,11 @@
 #
 # Docker ppc64 cross-compiler target
 #
-# This docker target builds on the debian sid base image which
-# contains cross compilers for Debian "ports" targets.
-FROM qemu:debian-sid
+# This docker target builds on the debian Buster base image.
+FROM qemu:debian10
 
 RUN apt update && \
     DEBIAN_FRONTEND=noninteractive eatmydata \
     apt install -y --no-install-recommends \
        gcc-powerpc64-linux-gnu \
-       libc6-dev-ppc64-cross || { echo "Failed to build - see debian-sid.docker notes"; exit 1; }
+       libc6-dev-ppc64-cross
-- 
2.20.1


