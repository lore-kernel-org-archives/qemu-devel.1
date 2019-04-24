Return-Path: <SRS0=3XOk=S2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F54DC282CE
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 10:43:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 402E820811
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 10:43:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 402E820811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39412 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJFMl-0001qv-ED
	for qemu-devel@archiver.kernel.org; Wed, 24 Apr 2019 06:43:03 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39108)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hJFI3-0006B9-5D
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 06:38:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hJFI1-0007dW-KD
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 06:38:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47842)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>)
	id 1hJFHy-0007bR-Eg; Wed, 24 Apr 2019 06:38:06 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9BB52D4D67;
	Wed, 24 Apr 2019 10:38:05 +0000 (UTC)
Received: from thuth.com (ovpn-116-69.ams2.redhat.com [10.36.116.69])
	by smtp.corp.redhat.com (Postfix) with ESMTP id AC22D5D704;
	Wed, 24 Apr 2019 10:38:03 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 24 Apr 2019 12:37:46 +0200
Message-Id: <20190424103747.10173-6-thuth@redhat.com>
In-Reply-To: <20190424103747.10173-1-thuth@redhat.com>
References: <20190424103747.10173-1-thuth@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.39]);
	Wed, 24 Apr 2019 10:38:05 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 5/6] tests: Run the iotests during "make check"
 again
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
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Max Reitz <mreitz@redhat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	Li-Wen Hsu <lwhsu@freebsd.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190424103746.ewQgfBkUiK_vOzfZWdx6CFHjIiuulCrp5DdXldV9ATQ@z>

People often forget to run the iotests before submitting patches or
pull requests - this is likely due to the fact that we do not run the
tests during our mandatory "make check" tests yet. Now that we've got
a new "ci" group of iotests that should be fine to run in every environ-
ment, it should be OK to enable the iotests during "make check" again.
Thus we now run the "ci" tests by default from the qemu-iotests-quick.sh
script, and only use the former "quick" group (that contains some tests
that are failing in some environments) when the user decided to run
"make check SPEED=3Dthorough" or something similar.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/Makefile.include      |  2 +-
 tests/qemu-iotests-quick.sh | 17 ++++++++++++++++-
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 36fc73fef5..eb6a7a41e2 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
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
diff --git a/tests/qemu-iotests-quick.sh b/tests/qemu-iotests-quick.sh
index 0e554bb972..416b3fc48b 100755
--- a/tests/qemu-iotests-quick.sh
+++ b/tests/qemu-iotests-quick.sh
@@ -1,8 +1,23 @@
 #!/bin/sh
=20
+# Honor the SPEED environment variable, just like we do it for the qtest=
s.
+# The default is to run all tests that still work fine in a CI environme=
nts,
+# but if the user set SPEED=3Dslow or SPEED=3Dthorough, we also run all =
other
+# tests that are still marked as "quick"
+if [ "$SPEED" =3D "slow" -o "$SPEED" =3D "thorough" ]; then
+    group=3Dquick
+else
+    group=3Dci
+fi
+
+if [ -z "$(find . -name 'qemu-system-*' -print)" ]; then
+    echo "No qemu-system binary available. Skipped qemu-iotests."
+    exit 0
+fi
+
 cd tests/qemu-iotests
=20
 ret=3D0
-TEST_DIR=3D${TEST_DIR:-/tmp/qemu-iotests-quick-$$} ./check -T -qcow2 -g =
quick || ret=3D1
+TEST_DIR=3D${TEST_DIR:-/tmp/qemu-iotests-quick-$$} ./check -T -qcow2 -g =
"$group" || ret=3D1
=20
 exit $ret
--=20
2.21.0


