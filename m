Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C521DC5B578
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 22:09:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C10B21882
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 22:09:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C10B21882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41268 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hinRd-0004zL-O4
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 18:09:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46420)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jsnow@redhat.com>) id 1hinFL-0006Cc-I3
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 17:57:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1hinFK-0004Rf-IC
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 17:56:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44000)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>)
 id 1hinFH-0004OW-Uu; Wed, 03 Jul 2019 17:56:56 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3BBFA85550;
 Wed,  3 Jul 2019 21:56:55 +0000 (UTC)
Received: from probe.redhat.com (ovpn-123-117.rdu2.redhat.com [10.10.123.117])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9B24B5235E;
 Wed,  3 Jul 2019 21:56:51 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Date: Wed,  3 Jul 2019 17:55:39 -0400
Message-Id: <20190703215542.16123-16-jsnow@redhat.com>
In-Reply-To: <20190703215542.16123-1-jsnow@redhat.com>
References: <20190703215542.16123-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Wed, 03 Jul 2019 21:56:55 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 15/18] iotests: teach FilePath to produce
 multiple paths
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

Use "FilePaths" instead of "FilePath" to request multiple files be
cleaned up after we leave that object's scope.

This is not crucial; but it saves a little typing.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 tests/qemu-iotests/iotests.py | 33 ++++++++++++++++++++++-----------
 1 file changed, 22 insertions(+), 11 deletions(-)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.p=
y
index c544659ecb..db00fd2adf 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -358,31 +358,43 @@ class Timeout:
     def timeout(self, signum, frame):
         raise Exception(self.errmsg)
=20
+def file_pattern(name):
+    return "{0}-{1}".format(os.getpid(), name)
=20
-class FilePath(object):
-    '''An auto-generated filename that cleans itself up.
+class FilePaths(object):
+    """
+    FilePaths is an auto-generated filename that cleans itself up.
=20
     Use this context manager to generate filenames and ensure that the f=
ile
     gets deleted::
=20
-        with TestFilePath('test.img') as img_path:
+        with FilePaths(['test.img']) as img_path:
             qemu_img('create', img_path, '1G')
         # migration_sock_path is automatically deleted
-    '''
-    def __init__(self, name):
-        filename =3D '{0}-{1}'.format(os.getpid(), name)
-        self.path =3D os.path.join(test_dir, filename)
+    """
+    def __init__(self, names):
+        self.paths =3D []
+        for name in names:
+            self.paths.append(os.path.join(test_dir, file_pattern(name))=
)
=20
     def __enter__(self):
-        return self.path
+        return self.paths
=20
     def __exit__(self, exc_type, exc_val, exc_tb):
         try:
-            os.remove(self.path)
+            for path in self.paths:
+                os.remove(path)
         except OSError:
             pass
         return False
=20
+class FilePath(FilePaths):
+    """FilePath is a specialization of FilePaths that takes a single fil=
ename."""
+    def __init__(self, name):
+        super(FilePath, self).__init__([name])
+
+    def __enter__(self):
+        return self.paths[0]
=20
 def file_path_remover():
     for path in reversed(file_path_remover.paths):
@@ -391,7 +403,6 @@ def file_path_remover():
         except OSError:
             pass
=20
-
 def file_path(*names):
     ''' Another way to get auto-generated filename that cleans itself up=
.
=20
@@ -407,7 +418,7 @@ def file_path(*names):
=20
     paths =3D []
     for name in names:
-        filename =3D '{0}-{1}'.format(os.getpid(), name)
+        filename =3D file_pattern(name)
         path =3D os.path.join(test_dir, filename)
         file_path_remover.paths.append(path)
         paths.append(path)
--=20
2.21.0


