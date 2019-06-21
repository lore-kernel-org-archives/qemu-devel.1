Return-Path: <SRS0=2JTU=UU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB1D9C43613
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 22:59:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B15A2084E
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 22:59:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B15A2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38316 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1heSV9-0007nU-5f
	for qemu-devel@archiver.kernel.org; Fri, 21 Jun 2019 18:59:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33310)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <crosa@redhat.com>) id 1heSSm-0006ZX-2o
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 18:56:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1heSSj-0002QD-Ba
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 18:56:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41670)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1heSSi-0002Ji-2g
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 18:56:52 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3E11A3082E03;
 Fri, 21 Jun 2019 22:56:48 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-120-204.rdu2.redhat.com
 [10.10.120.204])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C4DF160BEC;
 Fri, 21 Jun 2019 22:56:42 +0000 (UTC)
From: Cleber Rosa <crosa@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 21 Jun 2019 18:56:40 -0400
Message-Id: <20190621225640.2188-1-crosa@redhat.com>
In-Reply-To: <20190621153806.13489-1-wainersm@redhat.com>
References: <20190621153806.13489-1-wainersm@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Fri, 21 Jun 2019 22:56:48 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [RFC PATCH] Acceptance tests: run generic tests on all
 built targets
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
Cc: Fam Zheng <fam@euphon.net>, peter.maydell@linaro.org,
 Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The intention here is to discuss the validity of running the the
acceptance tests are not depedent on target specific functionality on
all built targets.

Subtle but important questions that this topic brings:

 1) Should the QEMU binary target provide, as much as possible,
    a similar experience across targets, or should upper layer
    code deal with it?

 2) Are those tests exercising the same exact features and
    implementation, which just happen to be linked to various
    different binaries?  Or is the simple fact that they are
    integrated into different code worth testing?

 3) Should the default target match the host target?  Or the
    first binary found in the build tree?  Or something else?

An example of a Travis CI job based on this can be seen here:

 https://travis-ci.org/clebergnu/qemu/jobs/548905146

Signed-off-by: Cleber Rosa <crosa@redhat.com>
---
 .travis.yml                               |  2 +-
 tests/Makefile.include                    | 18 +++++++++++++++++-
 tests/acceptance/avocado_qemu/__init__.py |  9 +++++++++
 tests/acceptance/cpu_queries.py           |  3 +++
 tests/acceptance/migration.py             |  4 +++-
 5 files changed, 33 insertions(+), 3 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index aeb9b211cd..310febb866 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -232,7 +232,7 @@ matrix:
     # Acceptance (Functional) tests
     - env:
         - CONFIG=3D"--python=3D/usr/bin/python3 --target-list=3Dx86_64-s=
oftmmu,mips-softmmu,mips64el-softmmu,aarch64-softmmu,arm-softmmu,s390x-so=
ftmmu,alpha-softmmu"
-        - TEST_CMD=3D"make check-acceptance"
+        - TEST_CMD=3D"make check-acceptance-all"
       after_failure:
         - cat tests/results/latest/job.log
       addons:
diff --git a/tests/Makefile.include b/tests/Makefile.include
index db750dd6d0..34126167a5 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -1154,7 +1154,23 @@ check-acceptance: check-venv $(TESTS_RESULTS_DIR)
             --filter-by-tags-include-empty --filter-by-tags-include-empt=
y-key \
             $(AVOCADO_TAGS) \
             --failfast=3Don $(SRC_PATH)/tests/acceptance, \
-            "AVOCADO", "tests/acceptance")
+            "AVOCADO", "tests/acceptance (target arch based on test)")
+
+# Allows one to run tests that are generic (independent of target)
+# using a given target
+check-acceptance-generic-on-%: check-venv $(TESTS_RESULTS_DIR)
+	$(call quiet-command, \
+            $(TESTS_VENV_DIR)/bin/python -m avocado \
+            --show=3D$(AVOCADO_SHOW) run --job-results-dir=3D$(TESTS_RES=
ULTS_DIR) \
+            --filter-by-tags-include-empty --filter-by-tags-include-empt=
y-key \
+            --filter-by-tags=3D-arch -p arch=3D$* \
+            -p add-qtest=3Dyes -p set-arm-aarch64-machine=3Dyes \
+            --failfast=3Don $(SRC_PATH)/tests/acceptance, \
+            "AVOCADO", "tests/acceptance (target arch set to $*)")
+
+check-acceptance-generic: $(patsubst %-softmmu,check-acceptance-generic-=
on-%, $(filter %-softmmu,$(TARGET_DIRS)))
+
+check-acceptance-all: check-acceptance check-acceptance-generic
=20
 # Consolidated targets
=20
diff --git a/tests/acceptance/avocado_qemu/__init__.py b/tests/acceptance=
/avocado_qemu/__init__.py
index 2b236a1cf0..7a47f0d514 100644
--- a/tests/acceptance/avocado_qemu/__init__.py
+++ b/tests/acceptance/avocado_qemu/__init__.py
@@ -69,6 +69,15 @@ class Test(avocado.Test):
         vm =3D QEMUMachine(self.qemu_bin)
         if args:
             vm.add_args(*args)
+        if self.params.get('add-qtest', default=3DFalse):
+            # mips and sh4 targets require either a bios or a kernel or
+            # qtest enabled to not abort right at the commad line
+            if self.arch in ('mips', 'mipsel', 'mips64', 'mips64el', 'sh=
4'):
+                vm.add_args('-accel', 'qtest')
+        if self.params.get('set-arm-aarch64-machine', default=3DFalse):
+            # arm and aarch64 require a machine type to be set
+            if self.arch in ('arm', 'aarch64'):
+                vm.set_machine('virt')
         return vm
=20
     @property
diff --git a/tests/acceptance/cpu_queries.py b/tests/acceptance/cpu_queri=
es.py
index e71edec39f..af47d2795a 100644
--- a/tests/acceptance/cpu_queries.py
+++ b/tests/acceptance/cpu_queries.py
@@ -18,6 +18,9 @@ class QueryCPUModelExpansion(Test):
     """
=20
     def test(self):
+        """
+        :avocado: tags=3Darch:x86_64
+        """
         self.vm.set_machine('none')
         self.vm.add_args('-S')
         self.vm.launch()
diff --git a/tests/acceptance/migration.py b/tests/acceptance/migration.p=
y
index 6115cf6c24..c4ed87cd98 100644
--- a/tests/acceptance/migration.py
+++ b/tests/acceptance/migration.py
@@ -33,8 +33,10 @@ class Migration(Test):
             self.cancel('Failed to find a free port')
         return port
=20
-
     def test_migration_with_tcp_localhost(self):
+        blacklist_targets =3D ["arm", "ppc64", "sh4", "s390x"]
+        if self.arch in blacklist_targets:
+            self.cancel("Test failing on targets: %s" % ", ".join(blackl=
ist_targets))
         source_vm =3D self.get_vm()
         dest_uri =3D 'tcp:localhost:%u' % self._get_free_port()
         dest_vm =3D self.get_vm('-incoming', dest_uri)
--=20
2.21.0


