Return-Path: <SRS0=TwS2=YA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6F5FC47404
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 12:27:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 898B22070B
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 12:27:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 898B22070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44012 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHS7E-0001HJ-J9
	for qemu-devel@archiver.kernel.org; Mon, 07 Oct 2019 08:27:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48421)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iHRrh-0003AU-Rr
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 08:11:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iHRrg-0005JR-L3
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 08:11:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54898)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>)
 id 1iHRrd-0005IX-T2; Mon, 07 Oct 2019 08:11:46 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 204A476521;
 Mon,  7 Oct 2019 12:11:45 +0000 (UTC)
Received: from localhost (unknown [10.36.118.98])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 108A55EE1D;
 Mon,  7 Oct 2019 12:11:35 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 14/16] tests/qemu-iotests: enable testing with aio options
Date: Mon,  7 Oct 2019 13:09:35 +0100
Message-Id: <20191007120937.5862-15-stefanha@redhat.com>
In-Reply-To: <20191007120937.5862-1-stefanha@redhat.com>
References: <20191007120937.5862-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Mon, 07 Oct 2019 12:11:45 +0000 (UTC)
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
Cc: oleksandr@redhat.com, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Julia Suvorova <jusual@mail.ru>, Julia Suvorova <jusual@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>, Aarushi Mehta <mehta.aaru20@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Aarushi Mehta <mehta.aaru20@gmail.com>

Signed-off-by: Aarushi Mehta <mehta.aaru20@gmail.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 tests/qemu-iotests/check      | 15 ++++++++++++++-
 tests/qemu-iotests/common.rc  | 14 ++++++++++++++
 tests/qemu-iotests/iotests.py | 12 ++++++++++--
 3 files changed, 38 insertions(+), 3 deletions(-)

diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
index 875399d79f..9737369512 100755
--- a/tests/qemu-iotests/check
+++ b/tests/qemu-iotests/check
@@ -132,6 +132,7 @@ sortme=3Dfalse
 expunge=3Dtrue
 have_test_arg=3Dfalse
 cachemode=3Dfalse
+aiomode=3Dfalse
=20
 tmp=3D"${TEST_DIR}"/$$
 rm -f $tmp.list $tmp.tmp $tmp.sed
@@ -141,6 +142,7 @@ export IMGFMT_GENERIC=3Dtrue
 export IMGPROTO=3Dfile
 export IMGOPTS=3D""
 export CACHEMODE=3D"writeback"
+export AIOMODE=3D"threads"
 export QEMU_IO_OPTIONS=3D""
 export QEMU_IO_OPTIONS_NO_FMT=3D""
 export CACHEMODE_IS_DEFAULT=3Dtrue
@@ -225,6 +227,11 @@ s/ .*//p
         CACHEMODE_IS_DEFAULT=3Dfalse
         cachemode=3Dfalse
         continue
+    elif $aiomode
+    then
+        AIOMODE=3D"$r"
+        aiomode=3Dfalse
+        continue
     fi
=20
     xpand=3Dtrue
@@ -269,6 +276,7 @@ other options
     -n                  show me, do not run tests
     -o options          -o options to pass to qemu-img create/convert
     -c mode             cache mode
+    -i mode             AIO mode
     -makecheck          pretty print output for make check
=20
 testlist options
@@ -433,10 +441,13 @@ testlist options
             cachemode=3Dtrue
             xpand=3Dfalse
             ;;
+        -i)
+            aiomode=3Dtrue
+            xpand=3Dfalse
+            ;;
         -T)        # deprecated timestamp option
             xpand=3Dfalse
             ;;
-
         -v)
             verbose=3Dtrue
             xpand=3Dfalse
@@ -515,6 +526,8 @@ done
=20
 # Set qemu-io cache mode with $CACHEMODE we have
 QEMU_IO_OPTIONS=3D"$QEMU_IO_OPTIONS --cache $CACHEMODE"
+# Set qemu-io aio mode with $AIOMODE we have
+QEMU_IO_OPTIONS=3D"$QEMU_IO_OPTIONS --aio $AIOMODE"
=20
 QEMU_IO_OPTIONS_NO_FMT=3D"$QEMU_IO_OPTIONS"
 if [ "$IMGOPTSSYNTAX" !=3D "true" ]; then
diff --git a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common.rc
index e45cdfa66b..e9630b365e 100644
--- a/tests/qemu-iotests/common.rc
+++ b/tests/qemu-iotests/common.rc
@@ -559,6 +559,20 @@ _default_cache_mode()
         return
     fi
 }
+_supported_aio_modes()
+{
+    for mode; do
+        if [ "$mode" =3D "$AIOMODE" ]; then
+            return
+        fi
+    done
+    _notrun "not suitable for aio mode: $AIOMODE"
+}
+_default_aio_mode()
+{
+    AIOMODE=3D"$1"
+    QEMU_IO=3D"$QEMU_IO --aio $1"
+}
=20
 _unsupported_imgopts()
 {
diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.p=
y
index b26271187c..a9e2050e73 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -58,6 +58,7 @@ imgproto =3D os.environ.get('IMGPROTO', 'file')
 test_dir =3D os.environ.get('TEST_DIR')
 output_dir =3D os.environ.get('OUTPUT_DIR', '.')
 cachemode =3D os.environ.get('CACHEMODE')
+aiomode =3D os.environ.get('AIOMODE')
 qemu_default_machine =3D os.environ.get('QEMU_DEFAULT_MACHINE')
=20
 socket_scm_helper =3D os.environ.get('SOCKET_SCM_HELPER', 'socket_scm_he=
lper')
@@ -474,6 +475,7 @@ class VM(qtest.QEMUQtestMachine):
             options.append('file=3D%s' % path)
             options.append('format=3D%s' % format)
             options.append('cache=3D%s' % cachemode)
+            options.append('aio=3D%s' % aiomode)
=20
         if opts:
             options.append(opts)
@@ -852,6 +854,10 @@ def verify_cache_mode(supported_cache_modes=3D[]):
     if supported_cache_modes and (cachemode not in supported_cache_modes=
):
         notrun('not suitable for this cache mode: %s' % cachemode)
=20
+def verify_aio_mode(supported_aio_modes=3D[]):
+    if supported_aio_modes and (aiomode not in supported_aio_modes):
+        notrun('not suitable for this aio mode: %s' % aiomode)
+
 def supports_quorum():
     return 'quorum' in qemu_img_pipe('--help')
=20
@@ -909,8 +915,9 @@ def execute_unittest(output, verbosity, debug):
=20
 def execute_test(test_function=3DNone,
                  supported_fmts=3D[], supported_oses=3D['linux'],
-                 supported_cache_modes=3D[], unsupported_fmts=3D[],
-                 supported_protocols=3D[], unsupported_protocols=3D[]):
+                 supported_cache_modes=3D[], supported_aio_modes=3D{},
+                 unsupported_fmts=3D[], supported_protocols=3D[],
+                 unsupported_protocols=3D[]):
     """Run either unittest or script-style tests."""
=20
     # We are using TEST_DIR and QEMU_DEFAULT_MACHINE as proxies to
@@ -927,6 +934,7 @@ def execute_test(test_function=3DNone,
     verify_protocol(supported_protocols, unsupported_protocols)
     verify_platform(supported_oses)
     verify_cache_mode(supported_cache_modes)
+    verify_aio_mode(supported_aio_modes)
=20
     if debug:
         output =3D sys.stdout
--=20
2.21.0


