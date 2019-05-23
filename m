Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F692C282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 23:44:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 356F62133D
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 23:44:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 356F62133D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44690 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTxNa-0000w5-Fr
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 19:44:10 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39008)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1hTxKJ-0007J7-TD
	for qemu-devel@nongnu.org; Thu, 23 May 2019 19:40:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1hTxKH-0003M5-TW
	for qemu-devel@nongnu.org; Thu, 23 May 2019 19:40:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40628)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1hTxKF-0003JO-Tx
	for qemu-devel@nongnu.org; Thu, 23 May 2019 19:40:44 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8172E811DE;
	Thu, 23 May 2019 23:40:30 +0000 (UTC)
Received: from localhost (ovpn-112-51.ams2.redhat.com [10.36.112.51])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E7BB360BF3;
	Thu, 23 May 2019 23:40:26 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 24 May 2019 01:40:09 +0200
Message-Id: <20190523234011.583-3-marcandre.lureau@redhat.com>
In-Reply-To: <20190523234011.583-1-marcandre.lureau@redhat.com>
References: <20190523234011.583-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.27]);
	Thu, 23 May 2019 23:40:30 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 2/4] tests/docker: add podman support
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Fam Zheng <fam@euphon.net>,
	=?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Gerd Hoffmann <kraxel@redhat.com>, Debarshi Ray <rishi@redhat.com>,
	=?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Allow to specify the container engine to run with ENGINE variable.

By default, ENGINE=3Dauto and will select either podman or docker.

With current podman, we have to use a uidmap trick in order to be able
to rw-share the ccache directory with the container user.

With a user 1000, the default mapping is:
1000 (host) -> 0 (container).

So write access to /var/tmp/ccache ends will end with permission
denied error.

With "--uidmap 1000:0:1 --uidmap 0:1:1000", the mapping is:
1000 (host) -> 0 (container, 1st namespace) -> 1000 (container, 2nd names=
pace).

(the rest is mumbo jumbo to avoid holes in the range of UIDs)

A future podman version may have an option such as --userns-keep-uid.
Thanks to Debarshi Ray for the help!

Cc: Debarshi Ray <rishi@redhat.com>
Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 Makefile                      |  2 +-
 tests/docker/Makefile.include | 17 ++++++++++++++---
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index e02b88bcb1..e3a150ac4c 100644
--- a/Makefile
+++ b/Makefile
@@ -1118,7 +1118,7 @@ endif
 	@echo  ''
 	@echo  'Test targets:'
 	@echo  '  check           - Run all tests (check-help for details)'
-	@echo  '  docker          - Help about targets running tests inside Doc=
ker containers'
+	@echo  '  docker          - Help about targets running tests inside con=
tainers'
 	@echo  '  vm-test         - Help about targets running tests inside VM'
 	@echo  ''
 	@echo  'Documentation targets:'
diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.includ=
e
index c0e1bf57a3..2bf679767e 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -17,7 +17,9 @@ DOCKER_TESTS :=3D $(notdir $(shell \
=20
 DOCKER_TOOLS :=3D travis
=20
-DOCKER_SCRIPT=3D$(SRC_PATH)/tests/docker/docker.py
+ENGINE :=3D auto
+
+DOCKER_SCRIPT=3D$(SRC_PATH)/tests/docker/docker.py --engine $(ENGINE)
=20
 TESTS ?=3D %
 IMAGES ?=3D %
@@ -145,7 +147,7 @@ $(foreach i,$(filter-out $(DOCKER_PARTIAL_IMAGES),$(D=
OCKER_IMAGES) $(DOCKER_DEPR
 )
=20
 docker:
-	@echo 'Build QEMU and run tests inside Docker containers'
+	@echo 'Build QEMU and run tests inside Docker or Podman containers'
 	@echo
 	@echo 'Available targets:'
 	@echo
@@ -192,6 +194,14 @@ endif
 	@echo '    EXECUTABLE=3D<path>    Include executable in image.'
 	@echo '    EXTRA_FILES=3D"<path> [... <path>]"'
 	@echo '                         Include extra files in image.'
+	@echo '    ENGINE=3Dauto/docker/podman'
+	@echo '                         Specify which container engine to run.'
+
+UID=3D$(shell id -u)
+UID1=3D$(shell expr $(UID) + 1)
+ifeq ($(shell $(DOCKER_SCRIPT) probe),podman)
+PODMAN=3D1
+endif
=20
 # This rule if for directly running against an arbitrary docker target.
 # It is called by the expanded docker targets (e.g. make
@@ -211,7 +221,8 @@ docker-run: docker-qemu-src
 			"  COPYING $(EXECUTABLE) to $(IMAGE)"))
 	$(call quiet-command,						\
 		$(DOCKER_SCRIPT) run 					\
-			$(if $(NOUSER),,-u $(shell id -u)) 		\
+			$(if $(NOUSER),,-u $(UID)			\
+				$(if $(PODMAN),--uidmap $(UID):0:1 --uidmap 0:1:$(UID) --uidmap $(UI=
D1):$(UID1):64536)) 		\
 			--security-opt seccomp=3Dunconfined		\
 			$(if $V,,--rm) 					\
 			$(if $(DEBUG),-ti,)				\
--=20
2.22.0.rc1.1.g079e7d2849.dirty


