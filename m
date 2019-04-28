Return-Path: <SRS0=GiFh=S6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B0F7C43218
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Apr 2019 16:03:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23B292067D
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Apr 2019 16:03:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23B292067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45864 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hKmGe-0005I8-9a
	for qemu-devel@archiver.kernel.org; Sun, 28 Apr 2019 12:03:04 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52606)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hKm9V-00086M-2W
	for qemu-devel@nongnu.org; Sun, 28 Apr 2019 11:55:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hKm9T-000591-PT
	for qemu-devel@nongnu.org; Sun, 28 Apr 2019 11:55:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56918)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>)
	id 1hKm9Q-00053p-CH; Sun, 28 Apr 2019 11:55:37 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E9C56369CD;
	Sun, 28 Apr 2019 15:55:34 +0000 (UTC)
Received: from thuth.com (ovpn-116-50.ams2.redhat.com [10.36.116.50])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 66E1F28988;
	Sun, 28 Apr 2019 15:55:32 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Date: Sun, 28 Apr 2019 17:54:51 +0200
Message-Id: <20190428155451.15653-9-thuth@redhat.com>
In-Reply-To: <20190428155451.15653-1-thuth@redhat.com>
References: <20190428155451.15653-1-thuth@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.30]);
	Sun, 28 Apr 2019 15:55:35 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 8/8] tests: Run the iotests during "make
 check" again
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
	Ed Maste <emaste@freebsd.org>, qemu-block@nongnu.org,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	Markus Armbruster <armbru@redhat.com>,
	Christophe Fergeau <cfergeau@redhat.com>, Max Reitz <mreitz@redhat.com>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Wainer dos Santos Moschetta <wainersm@redhat.com>,
	Li-Wen Hsu <lwhsu@freebsd.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190428155451.KE6mkd8upNUmqAArW9NjaEWtaINlvwe3Pph8yX7FxN8@z>

People often forget to run the iotests before submitting patches or
pull requests - this is likely due to the fact that we do not run the
tests during our mandatory "make check" tests yet. Now that we've got
a proper "auto" group of iotests that should be fine to run in every
environment, we can enable the iotests during "make check" again by
running the "auto" tests by default from the check-block.sh script.

Some cases still need to be checked first, though: iotests need bash
and GNU sed (otherwise they fail), and if gprof is enabled, it spoils
the output of some test cases causing them to fail. So if we detect
that one of the required programs is missing or that gprof is enabled,
we still have to skip the iotests to avoid failures.

And finally, since we are using check-block.sh now again, this patch also
removes the qemu-iotests-quick.sh script since we do not need that anymor=
e
(and having two shell wrapper scripts around the block tests seem
rather confusing than helpful).

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/Makefile.include      |  8 +++----
 tests/check-block.sh        | 44 ++++++++++++++++++++++++++++---------
 tests/qemu-iotests-quick.sh |  8 -------
 3 files changed, 38 insertions(+), 22 deletions(-)
 delete mode 100755 tests/qemu-iotests-quick.sh

diff --git a/tests/Makefile.include b/tests/Makefile.include
index e2432d5e77..3bb7793d4a 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -140,7 +140,7 @@ check-unit-y +=3D tests/test-uuid$(EXESUF)
 check-unit-y +=3D tests/ptimer-test$(EXESUF)
 check-unit-y +=3D tests/test-qapi-util$(EXESUF)
=20
-check-block-$(CONFIG_POSIX) +=3D tests/qemu-iotests-quick.sh
+check-block-$(CONFIG_POSIX) +=3D tests/check-block.sh
=20
 # All QTests for now are POSIX-only, but the dependencies are
 # really in libqtest, not in the testcases themselves.
@@ -1096,8 +1096,8 @@ clean-tcg: $(CLEAN_TCG_TARGET_RULES)
=20
 QEMU_IOTESTS_HELPERS-$(call land,$(CONFIG_SOFTMMU),$(CONFIG_LINUX)) =3D =
tests/qemu-iotests/socket_scm_helper$(EXESUF)
=20
-.PHONY: check-tests/qemu-iotests-quick.sh
-check-tests/qemu-iotests-quick.sh: tests/qemu-iotests-quick.sh qemu-img$=
(EXESUF) qemu-io$(EXESUF) qemu-nbd$(EXESUF) $(QEMU_IOTESTS_HELPERS-y)
+.PHONY: check-tests/check-block.sh
+check-tests/check-block.sh: tests/check-block.sh qemu-img$(EXESUF) qemu-=
io$(EXESUF) qemu-nbd$(EXESUF) $(QEMU_IOTESTS_HELPERS-y)
 	$<
=20
 .PHONY: $(patsubst %, check-%, $(check-qapi-schema-y))
@@ -1168,7 +1168,7 @@ check-acceptance: check-venv $(TESTS_RESULTS_DIR)
 check-qapi-schema: $(patsubst %,check-%, $(check-qapi-schema-y)) check-t=
ests/qapi-schema/doc-good.texi
 check-qtest: $(patsubst %,check-qtest-%, $(QTEST_TARGETS))
 check-block: $(patsubst %,check-%, $(check-block-y))
-check: check-qapi-schema check-unit check-softfloat check-qtest check-de=
codetree
+check: check-qapi-schema check-unit check-softfloat check-qtest check-de=
codetree check-block
 check-clean:
 	rm -rf $(check-unit-y) tests/*.o $(QEMU_IOTESTS_HELPERS-y)
 	rm -rf $(sort $(foreach target,$(SYSEMU_TARGET_LIST), $(check-qtest-$(t=
arget)-y)) $(check-qtest-generic-y))
diff --git a/tests/check-block.sh b/tests/check-block.sh
index f3d12fd602..3b971d6cf4 100755
--- a/tests/check-block.sh
+++ b/tests/check-block.sh
@@ -1,24 +1,48 @@
 #!/bin/sh
=20
-FORMAT_LIST=3D"raw qcow2 qed vmdk vpc"
+# Honor the SPEED environment variable, just like we do it for the qtest=
s.
+if [ "$SPEED" =3D "slow" ]; then
+    format_list=3D"raw qcow2"
+    group=3D
+elif [ "$SPEED" =3D "thorough" ]; then
+    format_list=3D"raw qcow2 qed vmdk vpc"
+    group=3D
+else
+    format_list=3Dqcow2
+    group=3D"-g auto"
+fi
+
 if [ "$#" -ne 0 ]; then
-    FORMAT_LIST=3D"$@"
+    format_list=3D"$@"
+fi
+
+if grep -q "TARGET_GPROF=3Dy" *-softmmu/config-target.mak 2>/dev/null ; =
then
+    echo "GPROF is enabled =3D=3D> Not running the qemu-iotests."
+    exit 0
 fi
=20
-export QEMU_PROG=3D"$PWD/x86_64-softmmu/qemu-system-x86_64"
-export QEMU_IMG_PROG=3D"$PWD/qemu-img"
-export QEMU_IO_PROG=3D"$PWD/qemu-io"
+if [ -z "$(find . -name 'qemu-system-*' -print)" ]; then
+    echo "No qemu-system binary available =3D=3D> Not running the qemu-i=
otests."
+    exit 0
+fi
+
+if ! command -v bash >/dev/null 2>&1 ; then
+    echo "bash not available =3D=3D> Not running the qemu-iotests."
+    exit 0
+fi
=20
-if [ ! -x $QEMU_PROG ]; then
-    echo "'make check-block' requires qemu-system-x86_64"
-    exit 1
+if ! (sed --version | grep 'GNU sed') > /dev/null 2>&1 ; then
+    if ! command -v gsed >/dev/null 2>&1; then
+        echo "GNU sed not available =3D=3D> Not running the qemu-iotests=
."
+        exit 0
+    fi
 fi
=20
 cd tests/qemu-iotests
=20
 ret=3D0
-for FMT in $FORMAT_LIST ; do
-    ./check -T -nocache -$FMT || ret=3D1
+for fmt in $format_list ; do
+    ./check -$fmt $group || ret=3D1
 done
=20
 exit $ret
diff --git a/tests/qemu-iotests-quick.sh b/tests/qemu-iotests-quick.sh
deleted file mode 100755
index 0e554bb972..0000000000
--- a/tests/qemu-iotests-quick.sh
+++ /dev/null
@@ -1,8 +0,0 @@
-#!/bin/sh
-
-cd tests/qemu-iotests
-
-ret=3D0
-TEST_DIR=3D${TEST_DIR:-/tmp/qemu-iotests-quick-$$} ./check -T -qcow2 -g =
quick || ret=3D1
-
-exit $ret
--=20
2.21.0


