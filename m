Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F743C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 09:14:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D099421019
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 09:14:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SdYcgGAl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D099421019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36284 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7cEX-00047Z-Bo
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 05:14:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37209)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i7bqs-0000id-2x
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 04:50:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i7bqq-0000aI-VM
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 04:50:17 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:37403)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i7bqq-0000Zq-Ov
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 04:50:16 -0400
Received: by mail-wr1-x42a.google.com with SMTP id i1so17824193wro.4
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2019 01:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=7YP0ftcr2FXQMfJCJokh8qETOMycMBIgpMRzzjrBHa8=;
 b=SdYcgGAlDAUfWySmmBRMQ8zKSlz1Et8GLZpxhkxt94ntclGNGDgo+REt+KAVjlJ8Ym
 OckDW9vwwGRfVscd0W5jGDJR4G0ysH4bUocxVUwp/9ldQerTDk4COTo0urucOPgHWw1I
 juexghakBQTwEkshy2s6DsSezYHoNcUVqQDqiHKRyeq6ClkjvSEDEmNFRkx1Idi7QYjE
 uf/Tr5wnzl1w+H1vjXHPdbufOWLWR8gpPRGhQiXooyFle51ZN2CO3yLl30V0ftvvpZGf
 SUOKbVGZk2ECkLBmMrXLku4O9m5VI0SKQAIXHl6gHjru2P86M4gZ3pgkncCPM2Gy3zk1
 Pu1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=7YP0ftcr2FXQMfJCJokh8qETOMycMBIgpMRzzjrBHa8=;
 b=byXvEyla4Z5gXPt/2YfWIbV9Rrgay0cFvfyoCuxERrYuVpPJdPhk6Dvru30su7HQPi
 1O1RldAg1EvIRIuc1L1jGrL0ncPnU8MKhso7QXHnoOCOrZJ2qfik9LfqxD6piFo3TiyI
 fnxKV0AJYmFs09/FugF9uvBdABi5QQTTx5I/jlewD0gA645vp01fpCPbMR7wl0z3dp7e
 4ndrcGaH1uyE0SzvisEVbF5ryqbj7hfeVEhDlO1IlaZVezSIjP1VIw956yOqSOogHZ/C
 rmFTilFIdpz4Gk/kHO/TRSXEIuYoBoi12t72Ze7OYl/Fz1thtaTNNz7vwZXDtNEuxPFE
 s51g==
X-Gm-Message-State: APjAAAVrh86KpKBSM7Yp1VxKGpXZnKx/+FXmXUGZ4sRSuwfhMbdy094s
 BSuiLpfPL5hISs+OoVgbjlFXvw==
X-Google-Smtp-Source: APXvYqwA3HPPH4cFG2s6VJ/RhptlJduEOsVpP5jyCUKpgsUtMCWHz3WBC9INwgUaO71K7U4ystxn8A==
X-Received: by 2002:a5d:6ac8:: with SMTP id u8mr24670009wrw.104.1568105415725; 
 Tue, 10 Sep 2019 01:50:15 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id s3sm1679008wmj.48.2019.09.10.01.50.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2019 01:50:14 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 6D9FA1FFA9;
 Tue, 10 Sep 2019 09:43:51 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Tue, 10 Sep 2019 09:43:24 +0100
Message-Id: <20190910084349.28817-21-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190910084349.28817-1-alex.bennee@linaro.org>
References: <20190910084349.28817-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42a
Subject: [Qemu-devel] [PULL 20/45] tests/docker: move our sh4 cross compile
 to Buster
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
index 50c5e64212a..e946aae14fa 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -103,9 +103,9 @@ docker-image-debian-arm64-cross: docker-image-debian10
 docker-image-debian-hppa-cross: docker-image-debian10
 docker-image-debian-m68k-cross: docker-image-debian10
 docker-image-debian-powerpc-cross: docker-image-debian10
+docker-image-debian-sh4-cross: docker-image-debian10
 docker-image-debian-sparc64-cross: docker-image-debian10
 
-docker-image-debian-sh4-cross: docker-image-debian-sid
 docker-image-debian-mips64-cross: docker-image-debian-sid
 docker-image-debian-riscv64-cross: docker-image-debian-sid
 docker-image-debian-ppc64-cross: docker-image-debian-sid
diff --git a/tests/docker/dockerfiles/debian-sh4-cross.docker b/tests/docker/dockerfiles/debian-sh4-cross.docker
index 29983b2d75b..9d7663764e4 100644
--- a/tests/docker/dockerfiles/debian-sh4-cross.docker
+++ b/tests/docker/dockerfiles/debian-sh4-cross.docker
@@ -1,10 +1,9 @@
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
-- 
2.20.1


