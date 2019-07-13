Return-Path: <SRS0=hUdw=VK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26B33C742D7
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jul 2019 14:35:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2FD020838
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jul 2019 14:35:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2FD020838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56594 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hmJ7C-0003Dz-PV
	for qemu-devel@archiver.kernel.org; Sat, 13 Jul 2019 10:35:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46625)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <marcandre.lureau@redhat.com>) id 1hmJ6B-0008NZ-9h
 for qemu-devel@nongnu.org; Sat, 13 Jul 2019 10:34:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1hmJ69-000770-U6
 for qemu-devel@nongnu.org; Sat, 13 Jul 2019 10:34:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40742)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1hmJ69-000762-Mq
 for qemu-devel@nongnu.org; Sat, 13 Jul 2019 10:34:01 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 01A323001808;
 Sat, 13 Jul 2019 14:34:01 +0000 (UTC)
Received: from localhost (ovpn-112-50.ams2.redhat.com [10.36.112.50])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D8C375D721;
 Sat, 13 Jul 2019 14:33:53 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Date: Sat, 13 Jul 2019 18:33:08 +0400
Message-Id: <20190713143311.17620-4-marcandre.lureau@redhat.com>
In-Reply-To: <20190713143311.17620-1-marcandre.lureau@redhat.com>
References: <20190713143311.17620-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Sat, 13 Jul 2019 14:34:01 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 3/6] tests/docker: add podman support
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
Cc: Fam Zheng <fam@euphon.net>, berrange@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 pbonzini@redhat.com, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Allow to specify the container engine to run with ENGINE variable.

By default, ENGINE=3Dauto and will select either podman or docker.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 Makefile                      | 2 +-
 tests/docker/Makefile.include | 8 ++++++--
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 1fcbaed62c..7863bb0cf5 100644
--- a/Makefile
+++ b/Makefile
@@ -1153,7 +1153,7 @@ endif
 	@echo  ''
 	@echo  'Test targets:'
 	@echo  '  check           - Run all tests (check-help for details)'
-	@echo  '  docker          - Help about targets running tests inside Doc=
ker containers'
+	@echo  '  docker          - Help about targets running tests inside con=
tainers'
 	@echo  '  vm-help         - Help about targets running tests inside VM'
 	@echo  ''
 	@echo  'Documentation targets:'
diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.includ=
e
index f4226b79d0..3c1aec862a 100644
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
@@ -146,7 +148,7 @@ $(foreach i,$(filter-out $(DOCKER_PARTIAL_IMAGES),$(D=
OCKER_IMAGES) $(DOCKER_DEPR
 )
=20
 docker:
-	@echo 'Build QEMU and run tests inside Docker containers'
+	@echo 'Build QEMU and run tests inside Docker or Podman containers'
 	@echo
 	@echo 'Available targets:'
 	@echo
@@ -193,6 +195,8 @@ endif
 	@echo '    EXECUTABLE=3D<path>    Include executable in image.'
 	@echo '    EXTRA_FILES=3D"<path> [... <path>]"'
 	@echo '                         Include extra files in image.'
+	@echo '    ENGINE=3Dauto/docker/podman'
+	@echo '                         Specify which container engine to run.'
=20
 # This rule if for directly running against an arbitrary docker target.
 # It is called by the expanded docker targets (e.g. make
--=20
2.22.0.428.g6d5b264208


