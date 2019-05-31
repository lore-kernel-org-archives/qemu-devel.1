Return-Path: <SRS0=hY9S=T7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD5ABC04AB6
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 06:44:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A29B2264AD
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 06:44:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A29B2264AD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37544 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWbHU-0006dy-U4
	for qemu-devel@archiver.kernel.org; Fri, 31 May 2019 02:44:48 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33992)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hWbGf-0006D6-TN
	for qemu-devel@nongnu.org; Fri, 31 May 2019 02:43:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hWbGe-0006c7-Rb
	for qemu-devel@nongnu.org; Fri, 31 May 2019 02:43:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43384)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hWbGe-0006ZR-M8
	for qemu-devel@nongnu.org; Fri, 31 May 2019 02:43:56 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3898AC04FFF6;
	Fri, 31 May 2019 06:43:50 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-242.brq.redhat.com [10.40.204.242])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 2F1432B5A6;
	Fri, 31 May 2019 06:43:45 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 31 May 2019 08:43:41 +0200
Message-Id: <20190531064341.29730-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.31]);
	Fri, 31 May 2019 06:43:50 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH] Makefile: Rename the 'vm-test' target as
 'vm-help'
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
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We already have 'make check-help', use the 'make vm-help' form
to display helps about VM testing. Keep the old target to not
bother old customs.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
Based-on: <20190530101603.22254-1-alex.bennee@linaro.org>
          "testing/next queue"
---
 Makefile                  | 4 ++--
 docs/devel/testing.rst    | 4 ++--
 tests/vm/Makefile.include | 5 +++--
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/Makefile b/Makefile
index f0be624f47..f67739df7c 100644
--- a/Makefile
+++ b/Makefile
@@ -9,7 +9,7 @@ SRC_PATH=3D.
 UNCHECKED_GOALS :=3D %clean TAGS cscope ctags dist \
     html info pdf txt \
     help check-help print-% \
-    docker docker-% vm-test vm-build-%
+    docker docker-% vm-help vm-test vm-build-%
=20
 print-%:
 	@echo '$*=3D$($*)'
@@ -1121,7 +1121,7 @@ endif
 	@echo  'Test targets:'
 	@echo  '  check           - Run all tests (check-help for details)'
 	@echo  '  docker          - Help about targets running tests inside Doc=
ker containers'
-	@echo  '  vm-test         - Help about targets running tests inside VM'
+	@echo  '  vm-help         - Help about targets running tests inside VM'
 	@echo  ''
 	@echo  'Documentation targets:'
 	@echo  '  html info pdf txt'
diff --git a/docs/devel/testing.rst b/docs/devel/testing.rst
index da2d0fc964..68aba3926e 100644
--- a/docs/devel/testing.rst
+++ b/docs/devel/testing.rst
@@ -399,12 +399,12 @@ VM testing
=20
 This test suite contains scripts that bootstrap various guest images tha=
t have
 necessary packages to build QEMU. The basic usage is documented in ``Mak=
efile``
-help which is displayed with ``make vm-test``.
+help which is displayed with ``make vm-help``.
=20
 Quickstart
 ----------
=20
-Run ``make vm-test`` to list available make targets. Invoke a specific m=
ake
+Run ``make vm-help`` to list available make targets. Invoke a specific m=
ake
 command to run build test in an image. For example, ``make vm-build-free=
bsd``
 will build the source tree in the FreeBSD image. The command can be exec=
uted
 from either the source tree or the build dir; if the former, ``./configu=
re`` is
diff --git a/tests/vm/Makefile.include b/tests/vm/Makefile.include
index 5e37063d32..b7311d7bd9 100644
--- a/tests/vm/Makefile.include
+++ b/tests/vm/Makefile.include
@@ -8,8 +8,9 @@ IMAGE_FILES :=3D $(patsubst %, $(IMAGES_DIR)/%.img, $(IMA=
GES))
=20
 .PRECIOUS: $(IMAGE_FILES)
=20
-vm-test:
-	@echo "vm-test: Test QEMU in preconfigured virtual machines"
+# 'vm-help' target was historically named 'vm-test'
+vm-help vm-test:
+	@echo "vm-help: Test QEMU in preconfigured virtual machines"
 	@echo
 	@echo "  vm-build-ubuntu.i386            - Build QEMU in ubuntu i386 VM=
"
 	@echo "  vm-build-freebsd                - Build QEMU in FreeBSD VM"
--=20
2.20.1


