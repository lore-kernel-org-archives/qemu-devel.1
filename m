Return-Path: <SRS0=aoXf=X5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2359CC4360C
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 11:10:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3E1620862
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 11:10:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3E1620862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46310 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGLTN-000572-H8
	for qemu-devel@archiver.kernel.org; Fri, 04 Oct 2019 07:10:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58022)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iGKNr-00037c-8J
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 06:00:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iGKNo-0007CT-VM
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 06:00:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55724)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1iGKNk-00079y-CD; Fri, 04 Oct 2019 06:00:16 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B22C02D6A04;
 Fri,  4 Oct 2019 10:00:14 +0000 (UTC)
Received: from linux.fritz.box.com (unknown [10.36.118.42])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E49C360852;
 Fri,  4 Oct 2019 10:00:10 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL v3 4/4] iotests: Remove Python 2 compatibility code
Date: Fri,  4 Oct 2019 11:59:59 +0200
Message-Id: <20191004095959.22891-5-kwolf@redhat.com>
In-Reply-To: <20191004095959.22891-1-kwolf@redhat.com>
References: <20191004095959.22891-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Fri, 04 Oct 2019 10:00:14 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Some scripts check the Python version number and have two code paths to
accomodate both Python 2 and 3. Remove the code specific to Python 2 and
assert the minimum version of 3.6 instead (check skips Python tests in
this case, so the assertion would only ever trigger if a Python script
is executed manually).

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 tests/qemu-iotests/044        |  3 ---
 tests/qemu-iotests/163        |  3 ---
 tests/qemu-iotests/iotests.py | 13 +++----------
 3 files changed, 3 insertions(+), 16 deletions(-)

diff --git a/tests/qemu-iotests/044 b/tests/qemu-iotests/044
index 05ea1f49c5..8b2afa2a11 100755
--- a/tests/qemu-iotests/044
+++ b/tests/qemu-iotests/044
@@ -28,9 +28,6 @@ import struct
 import subprocess
 import sys
=20
-if sys.version_info.major =3D=3D 2:
-    range =3D xrange
-
 test_img =3D os.path.join(iotests.test_dir, 'test.img')
=20
 class TestRefcountTableGrowth(iotests.QMPTestCase):
diff --git a/tests/qemu-iotests/163 b/tests/qemu-iotests/163
index 081ccc8ac1..d94728e080 100755
--- a/tests/qemu-iotests/163
+++ b/tests/qemu-iotests/163
@@ -21,9 +21,6 @@
 import os, random, iotests, struct, qcow2, sys
 from iotests import qemu_img, qemu_io, image_size
=20
-if sys.version_info.major =3D=3D 2:
-    range =3D xrange
-
 test_img =3D os.path.join(iotests.test_dir, 'test.img')
 check_img =3D os.path.join(iotests.test_dir, 'check.img')
=20
diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.p=
y
index b26271187c..9fb5181c3d 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -35,6 +35,7 @@ from collections import OrderedDict
 sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', 'pyt=
hon'))
 from qemu import qtest
=20
+assert sys.version_info >=3D (3,6)
=20
 # This will not work if arguments contain spaces but is necessary if we
 # want to support the override options that ./check supports.
@@ -250,10 +251,7 @@ def image_size(img):
     return json.loads(r)['virtual-size']
=20
 def is_str(val):
-    if sys.version_info.major >=3D 3:
-        return isinstance(val, str)
-    else:
-        return isinstance(val, str) or isinstance(val, unicode)
+    return isinstance(val, str)
=20
 test_dir_re =3D re.compile(r"%s" % test_dir)
 def filter_test_dir(msg):
@@ -935,12 +933,7 @@ def execute_test(test_function=3DNone,
     else:
         # We need to filter out the time taken from the output so that
         # qemu-iotest can reliably diff the results against master outpu=
t.
-        if sys.version_info.major >=3D 3:
-            output =3D io.StringIO()
-        else:
-            # io.StringIO is for unicode strings, which is not what
-            # 2.x's test runner emits.
-            output =3D io.BytesIO()
+        output =3D io.StringIO()
=20
     logging.basicConfig(level=3D(logging.DEBUG if debug else logging.WAR=
N))
=20
--=20
2.20.1


