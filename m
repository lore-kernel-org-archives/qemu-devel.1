Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C130C49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 00:18:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 367B8217D6
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 00:18:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 367B8217D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49992 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iB6cj-0006xi-0x
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 20:18:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43976)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1iB6Z6-00049g-Td
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 20:14:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1iB6Z5-00052U-HY
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 20:14:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42782)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1iB6Z5-00052G-A3
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 20:14:23 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9D59F20F2;
 Fri, 20 Sep 2019 00:14:22 +0000 (UTC)
Received: from probe.bos.redhat.com (dhcp-17-38.bos.redhat.com [10.18.17.38])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0410519C5B;
 Fri, 20 Sep 2019 00:14:21 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/3] docker: remove unused debian-sid and debian-ports
Date: Thu, 19 Sep 2019 20:14:13 -0400
Message-Id: <20190920001413.22567-4-jsnow@redhat.com>
In-Reply-To: <20190920001413.22567-1-jsnow@redhat.com>
References: <20190920001413.22567-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.71]); Fri, 20 Sep 2019 00:14:22 +0000 (UTC)
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

These are listed as "partial" images, but have no user.
Remove them.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 tests/docker/Makefile.include                |  4 +--
 tests/docker/dockerfiles/debian-ports.docker | 36 --------------------
 tests/docker/dockerfiles/debian-sid.docker   | 35 -------------------
 3 files changed, 2 insertions(+), 73 deletions(-)
 delete mode 100644 tests/docker/dockerfiles/debian-ports.docker
 delete mode 100644 tests/docker/dockerfiles/debian-sid.docker

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.includ=
e
index 7af476d957..c282b5c520 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -5,8 +5,8 @@
 DOCKER_SUFFIX :=3D .docker
 DOCKER_FILES_DIR :=3D $(SRC_PATH)/tests/docker/dockerfiles
 # we don't run tests on intermediate images (used as base by another ima=
ge)
-DOCKER_PARTIAL_IMAGES :=3D debian8 debian9 debian10 debian-sid
-DEBIAN_PARTIAL_IMAGES +=3D debian-9-mxe debian-ports debian-bootstrap
+DOCKER_PARTIAL_IMAGES :=3D debian8 debian9 debian10
+DEBIAN_PARTIAL_IMAGES +=3D debian-9-mxe debian-bootstrap
 DOCKER_IMAGES :=3D $(sort $(notdir $(basename $(wildcard $(DOCKER_FILES_=
DIR)/*.docker))))
 DOCKER_TARGETS :=3D $(patsubst %,docker-image-%,$(DOCKER_IMAGES))
 # Use a global constant ccache directory to speed up repetitive builds
diff --git a/tests/docker/dockerfiles/debian-ports.docker b/tests/docker/=
dockerfiles/debian-ports.docker
deleted file mode 100644
index 61bc3f2993..0000000000
--- a/tests/docker/dockerfiles/debian-ports.docker
+++ /dev/null
@@ -1,36 +0,0 @@
-#
-# Docker multiarch cross-compiler target
-#
-# This docker target is builds on Debian Ports cross compiler targets
-# to build distro with a selection of cross compilers for building test =
binaries.
-#
-# On its own you can't build much but the docker-foo-cross targets
-# build on top of the base debian image.
-#
-FROM debian:unstable
-
-MAINTAINER Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
-
-RUN echo "deb [arch=3Damd64] http://deb.debian.org/debian unstable main"=
 > /etc/apt/sources.list
-
-# Duplicate deb line as deb-src
-RUN cat /etc/apt/sources.list | sed -ne "s/^deb\ \(\[.*\]\ \)\?\(.*\)/de=
b-src \2/p" >> /etc/apt/sources.list
-
-# Setup some basic tools we need
-RUN apt-get update && \
-    DEBIAN_FRONTEND=3Dnoninteractive apt install -yy eatmydata && \
-    DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
-    apt-get install -y --no-install-recommends \
-        bison \
-        build-essential \
-        ca-certificates \
-        clang \
-        debian-ports-archive-keyring \
-        flex \
-        gettext \
-        git \
-        pkg-config \
-        psmisc \
-        python \
-        texinfo \
-        $(apt-get -s build-dep qemu | egrep ^Inst | fgrep '[all]' | cut =
-d\  -f2)
diff --git a/tests/docker/dockerfiles/debian-sid.docker b/tests/docker/do=
ckerfiles/debian-sid.docker
deleted file mode 100644
index 2a1bcc33b2..0000000000
--- a/tests/docker/dockerfiles/debian-sid.docker
+++ /dev/null
@@ -1,35 +0,0 @@
-#
-# Debian Sid Base
-#
-# Currently we can build all our guests with cross-compilers in the
-# latest Debian release (Buster). However new compilers will first
-# arrive in Sid. However Sid is a rolling distro which may be broken
-# at any particular time. To try and mitigate this we use Debian's
-# snapshot archive which provides a "stable" view of what state Sid
-# was in.
-#
-
-# This must be earlier than the snapshot date we are aiming for
-FROM debian:sid-20190812-slim
-
- # Use a snapshot known to work (see http://snapshot.debian.org/#Usage)
-ENV DEBIAN_SNAPSHOT_DATE "20190820"
-RUN sed -i "s%^deb \(https\?://\)deb.debian.org/debian/\? \(.*\)%deb [ch=
eck-valid-until=3Dno] \1snapshot.debian.org/archive/debian/${DEBIAN_SNAPS=
HOT_DATE} \2%" /etc/apt/sources.list
-
-# Duplicate deb line as deb-src
-RUN cat /etc/apt/sources.list | sed "s/^deb\ /deb-src /" >> /etc/apt/sou=
rces.list
-
-# Install common build utilities
-RUN apt update && \
-    DEBIAN_FRONTEND=3Dnoninteractive apt install -yy eatmydata && \
-    DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
-    apt install -y --no-install-recommends \
-        bison \
-        build-essential \
-        ca-certificates \
-        flex \
-        git \
-        pkg-config \
-        psmisc \
-        python \
-        texinfo || { echo "Failed to build - see debian-sid.docker notes=
"; exit 1; }
--=20
2.21.0


