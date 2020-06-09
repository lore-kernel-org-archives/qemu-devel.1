Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3D5DC433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 10:49:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71EA1207C3
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 10:49:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bQdrU3Du"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71EA1207C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38752 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jibp4-0005og-OM
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 06:49:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59588)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jibja-0007OY-GY
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 06:43:58 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:37234)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jibjZ-0005Dt-CT
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 06:43:58 -0400
Received: by mail-wr1-x435.google.com with SMTP id x13so20735060wrv.4
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 03:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=EcSax8hW8ZLVqC+hSKgHYBFjse/ULBtGcOiJDeEtXGs=;
 b=bQdrU3DuNoorRmJW85vBn1wYkwXSTWW76JiKoXwO55F4xUgxnNNamJtjoyZdfgVLzc
 VS92uykEqUvtXJgn4jQmAhT0S3HYIYFhWhGx6Ad8QptV8Xp3Rg49hDw4xqQ5dOAhd6hU
 eyUyOWZLIfMbAzXFLh7HCE4wJionTyGJv/VpLnOJq2WozEm4WNlYC+8ou3L6oUk32Ih8
 +ft35Vtle5j6Y50ABwN7LIDh1HZfdTgJRfP59gxUb985R9ynM+TcrAHeAvvHQIVDa222
 4c+TSNNFBNgkcXFG8U5b/9CBTwEDGnuO6m3uriyzReLx1fyWArcWo6zMy7vOq1WLAJ2q
 nGYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=EcSax8hW8ZLVqC+hSKgHYBFjse/ULBtGcOiJDeEtXGs=;
 b=RoT0bMRx8rT1XPr3OZok6zMiyRqWNzRdSAm0XG7lCG503ofv0p3mhsVj9goNOL68gi
 S0lcRmAD2vSl6xpbFdNKf+ZKfFPJqUMSoSDzZ+v5YhZs5etuFhjOhMzsaSm9P3pkxsHF
 AMRI9z7/6DIbHvTa7ZAn6tvO/d8LnkMTW8K8KVNop3FvlVrcSkD8Q32j1jp7+U7ssutK
 I5ap2uwP2K+OynoZwcJzWiCZYKhJuTEKbyK4m7JI80Uir1cQbvX5EpiPyaoSyGAAkgar
 XD8aW4Nt11wPsEEcIy4XLceyjruxOAyZhdLFeDJnxcYLwwFgGmQSl90pdkDDVnunEqeg
 G3ow==
X-Gm-Message-State: AOAM532aCzUZT0jpBcPVTAbEwKZEygLN4ApuH6rH7t5px6oLZ7gdmajo
 cHmbKOZrKpJfO7QxplPYc1qwjg==
X-Google-Smtp-Source: ABdhPJzjcq9w1UrDIUIiXA8cBEV9RCaQND+4zDsbHs848AyBA5NpL9bj/LkzGRkBfpg+gfoPYaZmCw==
X-Received: by 2002:a5d:6109:: with SMTP id v9mr3659604wrt.26.1591699435689;
 Tue, 09 Jun 2020 03:43:55 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id d9sm2913194wre.28.2020.06.09.03.43.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2020 03:43:51 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 6179F1FF9C;
 Tue,  9 Jun 2020 11:38:12 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 14/17] tests/docker: Remove flex/bison packages
Date: Tue,  9 Jun 2020 11:38:06 +0100
Message-Id: <20200609103809.23443-15-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200609103809.23443-1-alex.bennee@linaro.org>
References: <20200609103809.23443-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x435.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Claudio Fontana <cfontana@suse.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

QEMU does not use flex/bison packages.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Claudio Fontana <cfontana@suse.de>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20200515163029.12917-2-philmd@redhat.com>

diff --git a/tests/docker/dockerfiles/centos7.docker b/tests/docker/dockerfiles/centos7.docker
index 9a2a2e515d7..e197acdc3ce 100644
--- a/tests/docker/dockerfiles/centos7.docker
+++ b/tests/docker/dockerfiles/centos7.docker
@@ -5,13 +5,11 @@ RUN yum -y update
 
 # Please keep this list sorted alphabetically
 ENV PACKAGES \
-    bison \
     bzip2 \
     bzip2-devel \
     ccache \
     csnappy-devel \
     dbus-daemon \
-    flex \
     gcc-c++ \
     gcc \
     gettext \
diff --git a/tests/docker/dockerfiles/centos8.docker b/tests/docker/dockerfiles/centos8.docker
index bfa0d33c9c8..9852c5b9eea 100644
--- a/tests/docker/dockerfiles/centos8.docker
+++ b/tests/docker/dockerfiles/centos8.docker
@@ -3,11 +3,9 @@ FROM centos:8.1.1911
 RUN dnf -y update
 ENV PACKAGES \
     SDL-devel \
-    bison \
     bzip2 \
     bzip2-devel \
     dbus-daemon \
-    flex \
     gcc \
     gcc-c++ \
     gettext \
diff --git a/tests/docker/dockerfiles/debian-xtensa-cross.docker b/tests/docker/dockerfiles/debian-xtensa-cross.docker
index e6f93f65ee2..beb73f46baa 100644
--- a/tests/docker/dockerfiles/debian-xtensa-cross.docker
+++ b/tests/docker/dockerfiles/debian-xtensa-cross.docker
@@ -11,11 +11,9 @@ RUN apt-get update && \
     DEBIAN_FRONTEND=noninteractive apt install -yy eatmydata && \
     DEBIAN_FRONTEND=noninteractive eatmydata \
     apt-get install -y --no-install-recommends \
-        bison \
         build-essential \
         ca-certificates \
         curl \
-        flex \
         gettext \
         git \
         python3-minimal
diff --git a/tests/docker/dockerfiles/debian10.docker b/tests/docker/dockerfiles/debian10.docker
index 0769700a416..bcdff04ddfe 100644
--- a/tests/docker/dockerfiles/debian10.docker
+++ b/tests/docker/dockerfiles/debian10.docker
@@ -18,12 +18,10 @@ RUN apt update && \
     DEBIAN_FRONTEND=noninteractive eatmydata \
     apt install -y --no-install-recommends \
         bc \
-        bison \
         build-essential \
         ca-certificates \
         clang \
         dbus \
-        flex \
         gdb-multiarch \
         gettext \
         git \
diff --git a/tests/docker/dockerfiles/debian9.docker b/tests/docker/dockerfiles/debian9.docker
index 08cc970feb1..0f0ebe530af 100644
--- a/tests/docker/dockerfiles/debian9.docker
+++ b/tests/docker/dockerfiles/debian9.docker
@@ -18,11 +18,9 @@ RUN apt update && \
     DEBIAN_FRONTEND=noninteractive eatmydata \
     apt install -y --no-install-recommends \
         bc \
-        bison \
         build-essential \
         ca-certificates \
         clang \
-        flex \
         gdb-multiarch \
         gettext \
         git \
diff --git a/tests/docker/dockerfiles/fedora.docker b/tests/docker/dockerfiles/fedora.docker
index 179575ecaaa..92b6e11c8a8 100644
--- a/tests/docker/dockerfiles/fedora.docker
+++ b/tests/docker/dockerfiles/fedora.docker
@@ -3,7 +3,6 @@ FROM fedora:30
 # Please keep this list sorted alphabetically
 ENV PACKAGES \
     bc \
-    bison \
     brlapi-devel \
     bzip2 \
     bzip2-devel \
@@ -13,7 +12,6 @@ ENV PACKAGES \
     dbus-daemon \
     device-mapper-multipath-devel \
     findutils \
-    flex \
     gcc \
     gcc-c++ \
     gettext \
diff --git a/tests/docker/dockerfiles/ubuntu.docker b/tests/docker/dockerfiles/ubuntu.docker
index 43872417dec..161806e6b8c 100644
--- a/tests/docker/dockerfiles/ubuntu.docker
+++ b/tests/docker/dockerfiles/ubuntu.docker
@@ -10,7 +10,7 @@
 #
 
 FROM ubuntu:20.04
-ENV PACKAGES flex bison \
+ENV PACKAGES \
     ccache \
     clang \
     dbus \
diff --git a/tests/docker/dockerfiles/ubuntu1804.docker b/tests/docker/dockerfiles/ubuntu1804.docker
index f66b06f4cff..a10ea2850b6 100644
--- a/tests/docker/dockerfiles/ubuntu1804.docker
+++ b/tests/docker/dockerfiles/ubuntu1804.docker
@@ -1,5 +1,5 @@
 FROM ubuntu:18.04
-ENV PACKAGES flex bison \
+ENV PACKAGES \
     ccache \
     clang \
     gcc \
-- 
2.20.1


