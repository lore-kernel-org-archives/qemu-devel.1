Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69B40C5ACD6
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 17:54:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C89B20714
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 17:54:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xYM9l+MO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C89B20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEGPo-0005e1-Bg
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 13:54:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56916)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jEGMs-0000In-1i
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 13:51:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jEGMm-0001us-5s
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 13:51:04 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:44334)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jEGMl-0001iS-UW
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 13:51:00 -0400
Received: by mail-wr1-x436.google.com with SMTP id y2so11392748wrn.11
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2020 10:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Wo5mRBpfwNfsZY5/P5VVd4CS2W0ErWEgaoPNHTJ7c5w=;
 b=xYM9l+MOVgtLwt7nitW5+c1idOSWGV6iidJuwcT2936jTC20FAuhDYgSameg6EtcIl
 0RF6K+cbCnwhE30ck+tTTYqxD0JP9+Fddlfb/z68LrWvbRVRHXlxKXdYZAGjITJDUVqa
 btIB3srCipRDN4AhXtrvlbzhCRByISI1nf6xLe6FaEAvq3cxOP/WYslooPxT75qjyiV/
 ypGNu1b2O2bulzi/uAFPdLaJj54LwZz36ZokHJwTw2hMMEok3JPNc83I/kWW+9gl+EDo
 G3b61tlGzY9CS3EldCsL/d64UyfpSFoz/fC3DFV0bKaO2Pi3io1GAHaSKxPHpPiMHjV9
 FP0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Wo5mRBpfwNfsZY5/P5VVd4CS2W0ErWEgaoPNHTJ7c5w=;
 b=Q8dXsoQWu5/8HQQcqToUWKXL1brwjpjdBVqJHC2/YbZFD6VjEMAOCCj/BssIO0noBn
 6+zo74XqwLRUMIpikHMAiFik+3PGtT1Z3tTZ62rBSDUk5acgdPNn6ydQeMrz9rI/iGiK
 3WnbTOtyadw9JnvwXffvcnUb7/1Pr87ShMBTLNdp+nMEMT0BGuwDXIK5/UWTyhvwUYmt
 i0mnUbCD+Gxaeirhz+EmiCYO6SR31vMILvmZwe5WGGF/g5ibnyQNYSw0QhNfPXI69mPt
 8GVsj/gafjbZ9hvzitRKUmd0u4tKZSezqTNH5EdxkesS4HQdoLKU8yC29u0qFoWzagRF
 NXbA==
X-Gm-Message-State: ANhLgQ17Ttq07iyglZAXlmc2FDGKXc/0Y+0QtiCSqOl418OIgQiJZIsl
 FTYUoAvtQ5JpUEaVSc2DTxhkNQ==
X-Google-Smtp-Source: ADFU+vt0ca0LgZkgHSbwvtuFimEU6fDvS8J1zRrhBZifzOmgEh+83qftcYvPDlt1+J1g+6UokxAGYQ==
X-Received: by 2002:a5d:4c47:: with SMTP id n7mr190248wrt.254.1584467457822;
 Tue, 17 Mar 2020 10:50:57 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 19sm238300wma.3.2020.03.17.10.50.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2020 10:50:54 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 588221FF87;
 Tue, 17 Mar 2020 17:50:53 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 01/28] tests/docker: Install tools to cross-debug and build
 Linux kernels
Date: Tue, 17 Mar 2020 17:50:26 +0000
Message-Id: <20200317175053.5278-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200317175053.5278-1-alex.bennee@linaro.org>
References: <20200317175053.5278-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::436
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
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

We often run Linux kernels to test QEMU. We sometimes need
to build them manually to use non-default features. We only
miss the tiny 'bc' tool.

The ncurses library is helpful to run 'make menuconfig'.

Finally, gdb-multiarch allow us to debug a TCG guest when its
architecture is different than the host.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20200212202738.12986-1-philmd@redhat.com>
Message-Id: <20200316172155.971-2-alex.bennee@linaro.org>

diff --git a/tests/docker/dockerfiles/debian10.docker b/tests/docker/dockerfiles/debian10.docker
index 5de79ae5527..2fcdc406e83 100644
--- a/tests/docker/dockerfiles/debian10.docker
+++ b/tests/docker/dockerfiles/debian10.docker
@@ -17,14 +17,17 @@ RUN apt update && \
     DEBIAN_FRONTEND=noninteractive apt install -yy eatmydata && \
     DEBIAN_FRONTEND=noninteractive eatmydata \
     apt install -y --no-install-recommends \
+        bc \
         bison \
         build-essential \
         ca-certificates \
         clang \
         dbus \
         flex \
+        gdb-multiarch \
         gettext \
         git \
+        libncurses5-dev \
         pkg-config \
         psmisc \
         python3 \
diff --git a/tests/docker/dockerfiles/debian9.docker b/tests/docker/dockerfiles/debian9.docker
index 8cbd742bb5f..92edbbf0f48 100644
--- a/tests/docker/dockerfiles/debian9.docker
+++ b/tests/docker/dockerfiles/debian9.docker
@@ -17,13 +17,16 @@ RUN apt update && \
     DEBIAN_FRONTEND=noninteractive apt install -yy eatmydata && \
     DEBIAN_FRONTEND=noninteractive eatmydata \
     apt install -y --no-install-recommends \
+        bc \
         bison \
         build-essential \
         ca-certificates \
         clang \
         flex \
+        gdb-multiarch \
         gettext \
         git \
+        libncurses5-dev \
         pkg-config \
         psmisc \
         python3 \
-- 
2.20.1


