Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8243BC49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 22:29:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 105FE206C2
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 22:29:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 105FE206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35806 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBRCj-00061X-5q
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 18:16:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57767)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1iBR9L-0000QX-PP
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 18:13:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1iBR9K-00071K-Id
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 18:13:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:7572)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1iBR9K-00070y-Cp
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 18:13:10 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 959A6307CDE7;
 Fri, 20 Sep 2019 22:13:09 +0000 (UTC)
Received: from probe.bos.redhat.com (dhcp-17-38.bos.redhat.com [10.18.17.38])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 008A55D9C3;
 Fri, 20 Sep 2019 22:13:08 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 5/5] docker: removed unused debian8 partial image
Date: Fri, 20 Sep 2019 18:12:55 -0400
Message-Id: <20190920221255.30412-6-jsnow@redhat.com>
In-Reply-To: <20190920221255.30412-1-jsnow@redhat.com>
References: <20190920221255.30412-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Fri, 20 Sep 2019 22:13:09 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
 John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

debian8 partial base is also not consumed by any image, so remove it.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 tests/docker/Makefile.include           |  3 +--
 tests/docker/dockerfiles/debian8.docker | 33 -------------------------
 2 files changed, 1 insertion(+), 35 deletions(-)
 delete mode 100644 tests/docker/dockerfiles/debian8.docker

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.includ=
e
index cb41652885..b9430822b8 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -5,8 +5,7 @@
 DOCKER_SUFFIX :=3D .docker
 DOCKER_FILES_DIR :=3D $(SRC_PATH)/tests/docker/dockerfiles
 # we don't run tests on intermediate images (used as base by another ima=
ge)
-DOCKER_PARTIAL_IMAGES :=3D debian8 debian9 debian10
-DOCKER_PARTIAL_IMAGES +=3D debian9-mxe debian-bootstrap
+DOCKER_PARTIAL_IMAGES :=3D debian9 debian9-mxe debian10 debian-bootstrap
 DOCKER_IMAGES :=3D $(sort $(notdir $(basename $(wildcard $(DOCKER_FILES_=
DIR)/*.docker))))
 DOCKER_TARGETS :=3D $(patsubst %,docker-image-%,$(DOCKER_IMAGES))
 # Use a global constant ccache directory to speed up repetitive builds
diff --git a/tests/docker/dockerfiles/debian8.docker b/tests/docker/docke=
rfiles/debian8.docker
deleted file mode 100644
index be67023826..0000000000
--- a/tests/docker/dockerfiles/debian8.docker
+++ /dev/null
@@ -1,33 +0,0 @@
-#
-# Docker multiarch cross-compiler target
-#
-# This docker target is builds on Debian and Emdebian's cross compiler t=
argets
-# to build distro with a selection of cross compilers for building test =
binaries.
-#
-# On its own you can't build much but the docker-foo-cross targets
-# build on top of the base debian image.
-#
-FROM debian:jessie-slim
-
-MAINTAINER Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
-
-# Duplicate deb line as deb-src
-RUN cat /etc/apt/sources.list | sed "s/^deb\ /deb-src /" >> /etc/apt/sou=
rces.list
-
-# Setup some basic tools we need
-RUN apt update && \
-    DEBIAN_FRONTEND=3Dnoninteractive apt-get install -yy eatmydata && \
-    DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
-    apt-get install -y --no-install-recommends \
-        bison \
-        binutils-multiarch \
-        build-essential \
-        ca-certificates \
-        clang \
-        curl \
-        flex \
-        gettext \
-        git \
-        gnupg \
-        pkg-config \
-        python3-minimal
--=20
2.21.0


