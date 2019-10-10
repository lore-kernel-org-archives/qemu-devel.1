Return-Path: <SRS0=X6L9=YD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04461C4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 15:30:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDEFE206B6
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 15:30:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDEFE206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41146 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIaOk-0003JA-CH
	for qemu-devel@archiver.kernel.org; Thu, 10 Oct 2019 11:30:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60510)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iIaJW-0005nz-Re
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 11:25:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iIaJV-0004LV-RH
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 11:25:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39350)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iIaJS-0004HU-8m; Thu, 10 Oct 2019 11:25:10 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7FB8710C092D;
 Thu, 10 Oct 2019 15:25:09 +0000 (UTC)
Received: from localhost (unknown [10.36.118.5])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EED661001B11;
 Thu, 10 Oct 2019 15:25:08 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 03/23] iotests.py: Add @base_dir to FilePaths etc.
Date: Thu, 10 Oct 2019 17:24:37 +0200
Message-Id: <20191010152457.17713-4-mreitz@redhat.com>
In-Reply-To: <20191010152457.17713-1-mreitz@redhat.com>
References: <20191010152457.17713-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.66]); Thu, 10 Oct 2019 15:25:09 +0000 (UTC)
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
Cc: Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Specifying this optional parameter allows creating temporary files in
other directories than the test_dir; for example in sock_dir.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/iotests.py | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.p=
y
index 49cd205a97..5373149ae1 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -375,10 +375,10 @@ class FilePaths(object):
             qemu_img('create', img_path, '1G')
         # migration_sock_path is automatically deleted
     """
-    def __init__(self, names):
+    def __init__(self, names, base_dir=3Dtest_dir):
         self.paths =3D []
         for name in names:
-            self.paths.append(os.path.join(test_dir, file_pattern(name))=
)
+            self.paths.append(os.path.join(base_dir, file_pattern(name))=
)
=20
     def __enter__(self):
         return self.paths
@@ -395,8 +395,8 @@ class FilePath(FilePaths):
     """
     FilePath is a specialization of FilePaths that takes a single filena=
me.
     """
-    def __init__(self, name):
-        super(FilePath, self).__init__([name])
+    def __init__(self, name, base_dir=3Dtest_dir):
+        super(FilePath, self).__init__([name], base_dir)
=20
     def __enter__(self):
         return self.paths[0]
@@ -409,7 +409,7 @@ def file_path_remover():
             pass
=20
=20
-def file_path(*names):
+def file_path(*names, base_dir=3Dtest_dir):
     ''' Another way to get auto-generated filename that cleans itself up=
.
=20
     Use is as simple as:
@@ -425,7 +425,7 @@ def file_path(*names):
     paths =3D []
     for name in names:
         filename =3D file_pattern(name)
-        path =3D os.path.join(test_dir, filename)
+        path =3D os.path.join(base_dir, filename)
         file_path_remover.paths.append(path)
         paths.append(path)
=20
--=20
2.21.0


