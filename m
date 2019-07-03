Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CBA0C5B578
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 22:21:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72B6520645
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 22:21:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72B6520645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41456 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hindR-0002Bf-MX
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 18:21:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46388)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jsnow@redhat.com>) id 1hinFJ-000683-Oo
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 17:56:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1hinFI-0004Pg-GG
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 17:56:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48408)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>)
 id 1hinFE-0004H9-0i; Wed, 03 Jul 2019 17:56:53 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 26D234E938;
 Wed,  3 Jul 2019 21:56:47 +0000 (UTC)
Received: from probe.redhat.com (ovpn-123-117.rdu2.redhat.com [10.10.123.117])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0DC1A5235E;
 Wed,  3 Jul 2019 21:56:39 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Date: Wed,  3 Jul 2019 17:55:37 -0400
Message-Id: <20190703215542.16123-14-jsnow@redhat.com>
In-Reply-To: <20190703215542.16123-1-jsnow@redhat.com>
References: <20190703215542.16123-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Wed, 03 Jul 2019 21:56:47 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 13/18] iotests: add testing shim for
 script-style python tests
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 vsementsov@virtuozzo.com, Juan Quintela <quintela@redhat.com>,
 John Snow <jsnow@redhat.com>, Xie Changlong <xiechanglong.d@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Wen Congyang <wencongyang2@huawei.com>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Because the new-style python tests don't use the iotests.main() test
launcher, we don't turn on the debugger logging for these scripts
when invoked via ./check -d.

Refactor the launcher shim into new and old style shims so that they
share environmental configuration.

Two cleanup notes: debug was not actually used as a global, and there
was no reason to create a class in an inner scope just to achieve
default variables; we can simply create an instance of the runner with
the values we want instead.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 tests/qemu-iotests/iotests.py | 40 +++++++++++++++++++++++------------
 1 file changed, 26 insertions(+), 14 deletions(-)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.p=
y
index 3ecef5bc90..fcad957d63 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -61,7 +61,6 @@ cachemode =3D os.environ.get('CACHEMODE')
 qemu_default_machine =3D os.environ.get('QEMU_DEFAULT_MACHINE')
=20
 socket_scm_helper =3D os.environ.get('SOCKET_SCM_HELPER', 'socket_scm_he=
lper')
-debug =3D False
=20
 luks_default_secret_object =3D 'secret,id=3Dkeysec0,data=3D' + \
                              os.environ.get('IMGKEYSECRET', '')
@@ -834,11 +833,22 @@ def skip_if_unsupported(required_formats=3D[], read=
_only=3DFalse):
         return func_wrapper
     return skip_test_decorator
=20
-def main(supported_fmts=3D[], supported_oses=3D['linux'], supported_cach=
e_modes=3D[],
-         unsupported_fmts=3D[]):
-    '''Run tests'''
+def execute_unittest(output, verbosity, debug):
+    runner =3D unittest.TextTestRunner(stream=3Doutput, descriptions=3DT=
rue,
+                                     verbosity=3Dverbosity)
+    try:
+        # unittest.main() will use sys.exit(); so expect a SystemExit
+        # exception
+        unittest.main(testRunner=3Drunner)
+    finally:
+        if not debug:
+            sys.stderr.write(re.sub(r'Ran (\d+) tests? in [\d.]+s',
+                                    r'Ran \1 tests', output.getvalue()))
=20
-    global debug
+def execute_test(test_function=3DNone,
+                 supported_fmts=3D[], supported_oses=3D['linux'],
+                 supported_cache_modes=3D[], unsupported_fmts=3D[]):
+    """Run either unittest or script-style tests."""
=20
     # We are using TEST_DIR and QEMU_DEFAULT_MACHINE as proxies to
     # indicate that we're not being run via "check". There may be
@@ -870,13 +880,15 @@ def main(supported_fmts=3D[], supported_oses=3D['li=
nux'], supported_cache_modes=3D[],
=20
     logging.basicConfig(level=3D(logging.DEBUG if debug else logging.WAR=
N))
=20
-    class MyTestRunner(unittest.TextTestRunner):
-        def __init__(self, stream=3Doutput, descriptions=3DTrue, verbosi=
ty=3Dverbosity):
-            unittest.TextTestRunner.__init__(self, stream, descriptions,=
 verbosity)
+    if not test_function:
+        execute_unittest(output, verbosity, debug)
+    else:
+        test_function()
=20
-    # unittest.main() will use sys.exit() so expect a SystemExit excepti=
on
-    try:
-        unittest.main(testRunner=3DMyTestRunner)
-    finally:
-        if not debug:
-            sys.stderr.write(re.sub(r'Ran (\d+) tests? in [\d.]+s', r'Ra=
n \1 tests', output.getvalue()))
+def script_main(test_function, *args, **kwargs):
+    """Run script-style tests outside of the unittest framework"""
+    execute_test(test_function, *args, **kwargs)
+
+def main(*args, **kwargs):
+    """Run tests using the unittest framework"""
+    execute_test(None, *args, **kwargs)
--=20
2.21.0


