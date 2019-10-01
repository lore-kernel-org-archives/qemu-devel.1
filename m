Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D550CC352AA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 22:01:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A388C21855
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 22:01:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A388C21855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48714 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFQCm-00025h-LF
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 18:01:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55724)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iFO9m-0006qX-ND
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 15:50:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iFO9k-0000Wg-6B
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 15:49:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53546)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iFO9h-0000Uj-6S; Tue, 01 Oct 2019 15:49:53 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6CBDE30842AF;
 Tue,  1 Oct 2019 19:49:52 +0000 (UTC)
Received: from localhost (unknown [10.40.205.251])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 065955D9C9;
 Tue,  1 Oct 2019 19:49:51 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 66/67] iotests.py: Forbid qemu_img*('create', ...)
Date: Tue,  1 Oct 2019 21:47:14 +0200
Message-Id: <20191001194715.2796-67-mreitz@redhat.com>
In-Reply-To: <20191001194715.2796-1-mreitz@redhat.com>
References: <20191001194715.2796-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Tue, 01 Oct 2019 19:49:52 +0000 (UTC)
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

All tests should use create_test_image().

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/iotests.py | 36 +++++++++++++++++++++++++++--------
 1 file changed, 28 insertions(+), 8 deletions(-)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.p=
y
index f3c80ba4e9..2e377b8379 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -82,12 +82,20 @@ luks_default_secret_object =3D 'secret,id=3Dkeysec0,d=
ata=3D' + \
 luks_default_key_secret_opt =3D 'key-secret=3Dkeysec0'
=20
=20
-def qemu_img(*args):
+# @from_create_test_image is purely for use in create_test_image
+def qemu_img(*args, from_create_test_image=3DFalse):
     '''Run qemu-img and return the exit code'''
+    args =3D list(args)
+
+    assert args[0] !=3D 'create' or from_create_test_image, \
+        'Use iotests.create_test_image for image creation'
+
     devnull =3D open('/dev/null', 'r+')
-    exitcode =3D subprocess.call(qemu_img_args + list(args), stdin=3Ddev=
null, stdout=3Ddevnull)
+    exitcode =3D subprocess.call(qemu_img_args + args,
+                               stdin=3Ddevnull, stdout=3Ddevnull)
     if exitcode < 0:
-        sys.stderr.write('qemu-img received signal %i: %s\n' % (-exitcod=
e, ' '.join(qemu_img_args + list(args))))
+        sys.stderr.write('qemu-img received signal %i: %s\n' %
+                         (-exitcode, ' '.join(qemu_img_args + args)))
     return exitcode
=20
 def ordered_qmp(qmsg, conv_keys=3DTrue):
@@ -162,7 +170,7 @@ def create_test_image(filename, size=3DNone, fmt=3Dim=
gfmt, opts=3D[],
     if size is not None:
         args.append(str(size))
=20
-    return qemu_img(*args)
+    return qemu_img(*args, from_create_test_image=3DTrue)
=20
 # Use this to remove images create with create_test_image in the
 # default image format (iotests.imgfmt)
@@ -180,20 +188,32 @@ def remove_test_image(filename):
=20
 def qemu_img_verbose(*args):
     '''Run qemu-img without suppressing its output and return the exit c=
ode'''
-    exitcode =3D subprocess.call(qemu_img_args + list(args))
+    args =3D list(args)
+
+    assert args[0] !=3D 'create', \
+            'Use iotests.create_test_image for image creation'
+
+    exitcode =3D subprocess.call(qemu_img_args + args)
     if exitcode < 0:
-        sys.stderr.write('qemu-img received signal %i: %s\n' % (-exitcod=
e, ' '.join(qemu_img_args + list(args))))
+        sys.stderr.write('qemu-img received signal %i: %s\n' %
+                         (-exitcode, ' '.join(qemu_img_args + args)))
     return exitcode
=20
 def qemu_img_pipe(*args):
     '''Run qemu-img and return its output'''
-    subp =3D subprocess.Popen(qemu_img_args + list(args),
+    args =3D list(args)
+
+    assert args[0] !=3D 'create', \
+            'Use iotests.create_test_image for image creation'
+
+    subp =3D subprocess.Popen(qemu_img_args + args,
                             stdout=3Dsubprocess.PIPE,
                             stderr=3Dsubprocess.STDOUT,
                             universal_newlines=3DTrue)
     exitcode =3D subp.wait()
     if exitcode < 0:
-        sys.stderr.write('qemu-img received signal %i: %s\n' % (-exitcod=
e, ' '.join(qemu_img_args + list(args))))
+        sys.stderr.write('qemu-img received signal %i: %s\n' %
+                         (-exitcode, ' '.join(qemu_img_args + args)))
     return subp.communicate()[0]
=20
 def qemu_img_log(*args):
--=20
2.21.0


