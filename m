Return-Path: <SRS0=2JTU=UU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14D84C43613
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 06:12:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D95962089E
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 06:12:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D95962089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54962 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1heCn3-0007Rv-KV
	for qemu-devel@archiver.kernel.org; Fri, 21 Jun 2019 02:12:49 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47109)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <crosa@redhat.com>) id 1heCks-0005C7-GW
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 02:10:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1heCkb-00049U-6T
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 02:10:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41860)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1heCka-0003JO-Ul
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 02:10:17 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4528B85539;
 Fri, 21 Jun 2019 06:09:44 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-120-204.rdu2.redhat.com
 [10.10.120.204])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7E42F5D772;
 Fri, 21 Jun 2019 06:09:36 +0000 (UTC)
From: Cleber Rosa <crosa@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 21 Jun 2019 02:09:24 -0400
Message-Id: <20190621060925.16214-2-crosa@redhat.com>
In-Reply-To: <20190621060925.16214-1-crosa@redhat.com>
References: <20190621060925.16214-1-crosa@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Fri, 21 Jun 2019 06:09:45 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 1/2] Acceptance tests: exclude "flaky" tests
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

It's a fact that some tests may not be 100% reliable in all
environments.  While it's a tough call to remove a useful test that
from the tree because it may fail every 1/100th time (or so), having
human attention drawn to known issues is very bad for humans and for
the projects they manage.

As a compromise solution, this marks tests that are known to have
issues, or that exercises known issues in QEMU or other components,
and excludes them from the entry point.  As a consequence, tests
marked as "flaky" will not be executed as part of "make
check-acceptance".

Because such tests should be forgiven but never be forgotten, it's
possible to list them with (assuming "make check-venv" or "make
check-acceptance" has already initiatilized the venv):

  $ ./tests/venv/bin/avocado list -t flaky tests/acceptance

The current list of tests marked as flaky are a result of running
the entire set of acceptance tests around 20 times.  The results
were then processed with a helper script[1].  That either confirmed
known issues (in the case of aarch64 and arm)[2] or revealed new
ones (mips).

This also bumps the Avocado version to one that includes a fix to the
parsing of multiple and mix "key:val" and simple tag values.

[1] https://raw.githubusercontent.com/avocado-framework/avocado/master/co=
ntrib/scripts/summarize-job-failures.py
[2] https://bugs.launchpad.net/qemu/+bug/1829779

Signed-off-by: Cleber Rosa <crosa@redhat.com>
---
 docs/devel/testing.rst                   | 17 +++++++++++++++++
 tests/Makefile.include                   |  6 +++++-
 tests/acceptance/boot_linux_console.py   |  2 ++
 tests/acceptance/linux_ssh_mips_malta.py |  2 ++
 tests/requirements.txt                   |  2 +-
 5 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/docs/devel/testing.rst b/docs/devel/testing.rst
index da2d0fc964..ff4d8e2e1c 100644
--- a/docs/devel/testing.rst
+++ b/docs/devel/testing.rst
@@ -574,6 +574,23 @@ may be invoked by running:
=20
   tests/venv/bin/avocado run $OPTION1 $OPTION2 tests/acceptance/
=20
+Tagging tests
+-------------
+
+flaky
+~~~~~
+
+If a test is known to fail intermittently, even if only every one
+hundredth time, it's highly advisable to mark it as a flaky test.
+This will prevent these individual tests from failing much larger
+jobs, will avoid human interaction and time wasted to verify a known
+issue, and worse of all, can lead to the discredit of automated
+testing.
+
+To mark a test as flaky, add to its docstring.::
+
+  :avocado: tags=3Dflaky
+
 Manual Installation
 -------------------
=20
diff --git a/tests/Makefile.include b/tests/Makefile.include
index db750dd6d0..4c97da2878 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -1125,7 +1125,11 @@ TESTS_RESULTS_DIR=3D$(BUILD_DIR)/tests/results
 # Any number of command separated loggers are accepted.  For more
 # information please refer to "avocado --help".
 AVOCADO_SHOW=3Dapp
-AVOCADO_TAGS=3D$(patsubst %-softmmu,-t arch:%, $(filter %-softmmu,$(TARG=
ET_DIRS)))
+
+# Additional tags that are added to each occurence of "--filter-by-tags"
+AVOCADO_EXTRA_TAGS :=3D ,-flaky
+
+AVOCADO_TAGS=3D$(patsubst %-softmmu,--filter-by-tags=3Darch:%$(AVOCADO_E=
XTRA_TAGS), $(filter %-softmmu,$(TARGET_DIRS)))
=20
 ifneq ($(findstring v2,"v$(PYTHON_VERSION)"),v2)
 $(TESTS_VENV_DIR): $(TESTS_VENV_REQ)
diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/bo=
ot_linux_console.py
index 32159503e9..6bd5c1ab53 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -249,6 +249,7 @@ class BootLinuxConsole(Test):
         """
         :avocado: tags=3Darch:aarch64
         :avocado: tags=3Dmachine:virt
+        :avocado: tags=3Dflaky
         """
         kernel_url =3D ('https://download.fedoraproject.org/pub/fedora/l=
inux/'
                       'releases/29/Everything/aarch64/os/images/pxeboot/=
vmlinuz')
@@ -270,6 +271,7 @@ class BootLinuxConsole(Test):
         """
         :avocado: tags=3Darch:arm
         :avocado: tags=3Dmachine:virt
+        :avocado: tags=3Dflaky
         """
         kernel_url =3D ('https://download.fedoraproject.org/pub/fedora/l=
inux/'
                       'releases/29/Everything/armhfp/os/images/pxeboot/v=
mlinuz')
diff --git a/tests/acceptance/linux_ssh_mips_malta.py b/tests/acceptance/=
linux_ssh_mips_malta.py
index aafb0c39f6..ae70b658e0 100644
--- a/tests/acceptance/linux_ssh_mips_malta.py
+++ b/tests/acceptance/linux_ssh_mips_malta.py
@@ -208,6 +208,7 @@ class LinuxSSH(Test):
         :avocado: tags=3Dmachine:malta
         :avocado: tags=3Dendian:big
         :avocado: tags=3Ddevice:pcnet32
+        :avocado: tags=3Dflaky
         """
         kernel_url =3D ('https://people.debian.org/~aurel32/qemu/mips/'
                       'vmlinux-3.2.0-4-5kc-malta')
@@ -222,6 +223,7 @@ class LinuxSSH(Test):
         :avocado: tags=3Dmachine:malta
         :avocado: tags=3Dendian:little
         :avocado: tags=3Ddevice:pcnet32
+        :avocado: tags=3Dflaky
         """
         kernel_url =3D ('https://people.debian.org/~aurel32/qemu/mipsel/=
'
                       'vmlinux-3.2.0-4-5kc-malta')
diff --git a/tests/requirements.txt b/tests/requirements.txt
index 3ae0e29ad7..58d63d171f 100644
--- a/tests/requirements.txt
+++ b/tests/requirements.txt
@@ -1,5 +1,5 @@
 # Add Python module requirements, one per line, to be installed
 # in the tests/venv Python virtual environment. For more info,
 # refer to: https://pip.pypa.io/en/stable/user_guide/#id1
-avocado-framework=3D=3D68.0
+avocado-framework=3D=3D69.1
 paramiko
--=20
2.21.0


