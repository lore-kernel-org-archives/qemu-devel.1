Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE9D9C10F25
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 20:24:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF11D20828
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 20:24:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kUhopCZo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF11D20828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49362 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBOwn-0003P8-Rj
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 16:24:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60869)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jBOvr-0001p9-Ks
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 16:23:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jBOvq-000598-JY
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 16:23:23 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333]:40272)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jBOvq-00058l-Dx
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 16:23:22 -0400
Received: by mail-wm1-x333.google.com with SMTP id e26so54097wme.5
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2020 13:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=opP09aUpVqbLeEIEW2//0Q0JIWRT0FGPjndrXn93n2Y=;
 b=kUhopCZo+TC4h06Xv1pYZ5rlgl9pO5N5yoZJWM5juabuZTzR2Cpb9QF9hKsk9VCnRK
 TrP0yQ3XxBHz7t9ERmedvNehLpY3EUbHA0kf8m6539wyNWIyAE19MdVb/Ct/XeaWwX3e
 sxtkJjp2tgrS/VUlS1uWW4b232UQPRgF/cizQnL1bG/Jjbg5TTWPB7iYNKiJERN5rBNy
 fA/755aKqpGTvXyCl51ZYuVhQgT633v5Jdtcazp+qmfRbxlkLHNiFjnKfbg0TfPpxsXA
 PL2t0KvBLSlF24NaAxdjyUuc17A4UJxzBjStV5Uc15RsWcQb2XiqFW/ufrci6YMxVQgo
 CuUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=opP09aUpVqbLeEIEW2//0Q0JIWRT0FGPjndrXn93n2Y=;
 b=IQl6sbUushOYQjhdrPC0Mj8y1J76hX8RgVHN1gNaV7pZEk73wVeM+rZgvTFi1bv4X9
 RO4m5dYqVIZwz+RpVK2TnlnE2J40b6YPjTdSlPBvp2WX8x/PVikbrQfglOr7NsISOAJY
 Y2eMitbwucck4r4jRnHuTAUtssdhLaoC++K2TLxbSKnfXE7M7K5A7BoaEWXsOXtjkYGP
 1jVy3hbnk1Bu7uXO6AeJyjFCnraBtw4+2LrQ883MW2sbOSgSZznsrTdcmeKG9rbqqBHL
 OO/A52bVEm0IIjMaXf6Rvx6N0T0nTJ1gB+wzSYAhpJAkFYJkJF3UEx0MSRfD/P1LdEzV
 PxoA==
X-Gm-Message-State: ANhLgQ2LYhXVlMWpKw+v/2GGRnVoa/9867qtu4WuM6x7hnSqYWxhz4wA
 5EfYaHdbp+9KFUokbWG4SfE7yQ==
X-Google-Smtp-Source: ADFU+vucnKC1XQ3pTUvJ8DsafHA+UNSzCrrOxbkTk0mWbG76ZACB3m80vzRh/aS07BRji2YFO+78/Q==
X-Received: by 2002:a7b:c8d7:: with SMTP id f23mr97183wml.173.1583785401452;
 Mon, 09 Mar 2020 13:23:21 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id h20sm43417800wrc.47.2020.03.09.13.23.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2020 13:23:19 -0700 (PDT)
Received: from zen.home.arpa (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 994E41FF87;
 Mon,  9 Mar 2020 20:23:18 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 1/5] tests/docker: Install tools to cross-debug and build
 Linux kernels
Date: Mon,  9 Mar 2020 20:23:14 +0000
Message-Id: <20200309202318.3481-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200309202318.3481-1-alex.bennee@linaro.org>
References: <20200309202318.3481-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::333
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
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
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
---
 tests/docker/dockerfiles/debian10.docker | 3 +++
 tests/docker/dockerfiles/debian9.docker  | 3 +++
 2 files changed, 6 insertions(+)

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


