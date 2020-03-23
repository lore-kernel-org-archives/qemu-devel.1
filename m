Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFEE9C3F2CD
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 16:22:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77CAB2051A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 16:22:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HGatRUUi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77CAB2051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36686 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGPqa-0003PG-NH
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 12:22:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35444)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jGPji-00015e-M3
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 12:15:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jGPjh-0002VH-Ex
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 12:15:34 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:38880)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jGPjh-0002UO-7J
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 12:15:33 -0400
Received: by mail-wr1-x431.google.com with SMTP id s1so17841407wrv.5
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2020 09:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=GWpaGgJBBKHI2u82TdJ05zR+bPFqQ/v/yXnHLn6lLAk=;
 b=HGatRUUi424vxqWstzhFt4pEox7tInipvJjE0U5Bi2fobsaU2Rwasw9e3gLw9R7dgW
 nPwTI2oqR0BGjeW1WYD3F2NIBKcNDFqje7i7f0PrmQiTITFUr6Kyp+ao2vJkGucKX0ZD
 gKB71wLeCoEjP+1Cz0eHjU/tI1JT9fsG61urZQS3vyQuGX54QKQBOSTMy5wO8c0BjAG8
 ESQjG+muQV9f7EXFgN3PUF+9J29FOrm2S6kK6OglDsQCDALLrl4wo129TomlOSYrMuve
 fWg63fQyFlBT/77Olb0RmzhXuG7XUE/Ooqv5l7dUlv2huYVklv3+EN2BhAnLiHMAY3un
 QXGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=GWpaGgJBBKHI2u82TdJ05zR+bPFqQ/v/yXnHLn6lLAk=;
 b=ToXEmJ9qofooK1lNlLDunixELtOGD6jCililrRVi5kweWrGKeF4iatI6QEJupCY6zz
 Nyd4ST2zAiHjuGJtYu3S40Dujp1FhXbPERIaXVuoiqlL/xAqn+YC+VPibZaCWwIq19Cd
 xelUyIC+2jtnKoKlzkNQ4XwMPBbidlELMnUa21gclBode+JyhcjGRAZXhS1H1ZV5CSk0
 HhrtzD3Y1kLVrS+iykG5c6rCozH0BzhNGgkdFrlpCG/8UJxpXOUrPu52ZmH1cKKrTbH7
 TvqeiVLFLC+h3lQUKmc1XxMrs4Dd2Mkx4XG67rSCcIY+DewjY7DY79HMXsNLkEc6wxdr
 rVhA==
X-Gm-Message-State: ANhLgQ1aau78960WMoC4yi8kTBHTqBTZ4f+BYb8OEjr6ngiDu3NcFhdm
 xFF4e8yeBHjayE5l+KAeUbbWVAQABos=
X-Google-Smtp-Source: ADFU+vsWoc7N33ut8AjYWF9aXG2mJzsmQiKTRJIPnaVy2Z3cbIL4FSi25nAjxckJIUrL2GUHwt3Kmg==
X-Received: by 2002:a5d:4e05:: with SMTP id p5mr31005646wrt.59.1584980131129; 
 Mon, 23 Mar 2020 09:15:31 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id i67sm25000775wri.50.2020.03.23.09.15.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2020 09:15:24 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 03C151FF93;
 Mon, 23 Mar 2020 16:15:16 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 07/11] tests/docker: Keep package list sorted
Date: Mon, 23 Mar 2020 16:15:10 +0000
Message-Id: <20200323161514.23952-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200323161514.23952-1-alex.bennee@linaro.org>
References: <20200323161514.23952-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::431
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
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Keep package list sorted, this eases rebase/cherry-pick.

Fixes: 3a6784813
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20200322120104.21267-2-philmd@redhat.com>
---
 tests/docker/dockerfiles/centos7.docker | 6 ++++--
 tests/docker/dockerfiles/fedora.docker  | 6 ++++--
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/tests/docker/dockerfiles/centos7.docker b/tests/docker/dockerfiles/centos7.docker
index cdd72de7ebf..9a2a2e515d7 100644
--- a/tests/docker/dockerfiles/centos7.docker
+++ b/tests/docker/dockerfiles/centos7.docker
@@ -2,6 +2,8 @@ FROM centos:7
 RUN yum install -y epel-release centos-release-xen-48
 
 RUN yum -y update
+
+# Please keep this list sorted alphabetically
 ENV PACKAGES \
     bison \
     bzip2 \
@@ -19,6 +21,7 @@ ENV PACKAGES \
     libepoxy-devel \
     libfdt-devel \
     librdmacm-devel \
+    libzstd-devel \
     lzo-devel \
     make \
     mesa-libEGL-devel \
@@ -33,7 +36,6 @@ ENV PACKAGES \
     tar \
     vte-devel \
     xen-devel \
-    zlib-devel \
-    libzstd-devel
+    zlib-devel
 RUN yum install -y $PACKAGES
 RUN rpm -q $PACKAGES | sort > /packages.txt
diff --git a/tests/docker/dockerfiles/fedora.docker b/tests/docker/dockerfiles/fedora.docker
index a6522228c02..019eb12dcb1 100644
--- a/tests/docker/dockerfiles/fedora.docker
+++ b/tests/docker/dockerfiles/fedora.docker
@@ -1,4 +1,6 @@
 FROM fedora:30
+
+# Please keep this list sorted alphabetically
 ENV PACKAGES \
     bc \
     bison \
@@ -38,6 +40,7 @@ ENV PACKAGES \
     libubsan \
     libusbx-devel \
     libxml2-devel \
+    libzstd-devel \
     llvm \
     lzo-devel \
     make \
@@ -92,8 +95,7 @@ ENV PACKAGES \
     vte291-devel \
     which \
     xen-devel \
-    zlib-devel \
-    libzstd-devel
+    zlib-devel
 ENV QEMU_CONFIGURE_OPTS --python=/usr/bin/python3
 
 RUN dnf install -y $PACKAGES
-- 
2.20.1


