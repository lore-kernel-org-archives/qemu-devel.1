Return-Path: <SRS0=2JTU=UU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54276C43613
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 06:15:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29AB7208C3
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 06:15:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29AB7208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55009 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1heCpx-0001zs-Bk
	for qemu-devel@archiver.kernel.org; Fri, 21 Jun 2019 02:15:49 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47109)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <crosa@redhat.com>) id 1heCkw-0005C7-Uc
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 02:10:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1heCkX-00046Y-2M
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 02:10:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:13970)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1heCkV-0003YM-O0
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 02:10:12 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1006C81F1B;
 Fri, 21 Jun 2019 06:09:52 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-120-204.rdu2.redhat.com
 [10.10.120.204])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 734735B683;
 Fri, 21 Jun 2019 06:09:44 +0000 (UTC)
From: Cleber Rosa <crosa@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 21 Jun 2019 02:09:25 -0400
Message-Id: <20190621060925.16214-3-crosa@redhat.com>
In-Reply-To: <20190621060925.16214-1-crosa@redhat.com>
References: <20190621060925.16214-1-crosa@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Fri, 21 Jun 2019 06:09:53 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 2/2] Acceptance tests: add SPICE protocol check
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
Cc: Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>,
 Aleksandar Rikalo <arikalo@wavecomp.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This fires a QEMU binary with SPICE enabled, and does a basic
handshake, doing a basic client/server interaction and protocol
validation.

Signed-off-by: Cleber Rosa <crosa@redhat.com>
---
 .travis.yml               |  5 +++-
 tests/Makefile.include    |  6 +++++
 tests/acceptance/spice.py | 54 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 64 insertions(+), 1 deletion(-)
 create mode 100644 tests/acceptance/spice.py

diff --git a/.travis.yml b/.travis.yml
index aeb9b211cd..6c9257a459 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -231,7 +231,7 @@ matrix:
=20
     # Acceptance (Functional) tests
     - env:
-        - CONFIG=3D"--python=3D/usr/bin/python3 --target-list=3Dx86_64-s=
oftmmu,mips-softmmu,mips64el-softmmu,aarch64-softmmu,arm-softmmu,s390x-so=
ftmmu,alpha-softmmu"
+        - CONFIG=3D"--python=3D/usr/bin/python3 --enable-spice --target-=
list=3Dx86_64-softmmu,mips-softmmu,mips64el-softmmu,aarch64-softmmu,arm-s=
oftmmu,s390x-softmmu,alpha-softmmu"
         - TEST_CMD=3D"make check-acceptance"
       after_failure:
         - cat tests/results/latest/job.log
@@ -240,6 +240,9 @@ matrix:
           packages:
             - python3-pip
             - python3.5-venv
+            - libspice-protocol-dev
+            - libspice-server-dev
+
     # Using newer GCC with sanitizers
     - addons:
         apt:
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 4c97da2878..7fc2d28099 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -1129,6 +1129,12 @@ AVOCADO_SHOW=3Dapp
 # Additional tags that are added to each occurence of "--filter-by-tags"
 AVOCADO_EXTRA_TAGS :=3D ,-flaky
=20
+# At last one test require spice to be enabled, allow it to be excluded
+# if it's not enabled
+ifneq ($(findstring y,"$(CONFIG_SPICE)"),y)
+AVOCADO_EXTRA_TAGS :=3D $(AVOCADO_EXTRA_TAGS),-spice
+endif
+
 AVOCADO_TAGS=3D$(patsubst %-softmmu,--filter-by-tags=3Darch:%$(AVOCADO_E=
XTRA_TAGS), $(filter %-softmmu,$(TARGET_DIRS)))
=20
 ifneq ($(findstring v2,"v$(PYTHON_VERSION)"),v2)
diff --git a/tests/acceptance/spice.py b/tests/acceptance/spice.py
new file mode 100644
index 0000000000..aa22b1992d
--- /dev/null
+++ b/tests/acceptance/spice.py
@@ -0,0 +1,54 @@
+# Simple functional tests for SPICE functionality
+#
+# Copyright (c) 2019 Red Hat, Inc.
+#
+# Author:
+#  Cleber Rosa <crosa@redhat.com>
+#
+# This work is licensed under the terms of the GNU GPL, version 2 or
+# later.  See the COPYING file in the top-level directory.
+
+import socket
+import struct
+
+from avocado_qemu import Test
+from avocado.utils.network import find_free_port
+
+
+class Spice(Test):
+
+    def test_protocol(self):
+        """
+        :avocado: tags=3Dquick
+        :avocado: tags=3Dspice
+        """
+        port =3D find_free_port(5001, 5500, sequent=3DFalse)
+        self.vm.add_args('-nodefaults', '-S',
+                         '-spice', 'port=3D%d,disable-ticketing' % port)
+        self.vm.launch()
+
+        RED_MAGIC =3D 0x51444552
+        MAJOR_VERSION =3D 0x2
+
+        client =3D socket.socket(socket.AF_INET, socket.SOCK_STREAM)
+        client.connect(('127.0.0.1', port))
+        red_link_mess =3D struct.pack('<10I',
+                                    RED_MAGIC,      # magic
+                                    MAJOR_VERSION,  # major version
+                                    0x0,            # minor version
+                                    0x18,           # size in bytes from=
 here
+                                    0x0,            # connection id
+                                    0x1,            # channel type RED_C=
HANNEL_MAIN
+                                    0x0,            # channel id
+                                    0x0,            # number of common c=
aps
+                                    0x0,            # number of channel =
caps
+                                    0x14)           # caps offset from s=
ize
+        client.send(red_link_mess)
+
+        RED_LINK_REPLY_BASE_FMT =3D '<5I'  # magic, major, minor, size, =
error
+        red_link_reply =3D client.recv(struct.calcsize(RED_LINK_REPLY_BA=
SE_FMT))
+        (magic, major, minor, size, error) =3D struct.unpack_from(RED_LI=
NK_REPLY_BASE_FMT,
+                                                                red_link=
_reply)
+        self.assertEqual(magic, RED_MAGIC, "Mismatch of MAGIC number")
+        self.assertEqual(major, MAJOR_VERSION, "Mismatch of major protoc=
ol version")
+        self.assertEqual(error, 0x0, "Unexpected error reported by serve=
r")
--=20
2.21.0


