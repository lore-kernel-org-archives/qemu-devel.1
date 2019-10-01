Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25956C352AA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 20:10:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5C8C2133F
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 20:10:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5C8C2133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47720 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFOTO-00075I-1A
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 16:10:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53896)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iFO7V-0004TX-07
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 15:47:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iFO7T-0007fp-JU
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 15:47:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44266)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iFO7O-0007dc-HN; Tue, 01 Oct 2019 15:47:30 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C4CEF2A09A1;
 Tue,  1 Oct 2019 19:47:29 +0000 (UTC)
Received: from localhost (unknown [10.40.205.251])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5ED0260C5D;
 Tue,  1 Oct 2019 19:47:29 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 05/67] iotests.py: Add ImagePaths
Date: Tue,  1 Oct 2019 21:46:13 +0200
Message-Id: <20191001194715.2796-6-mreitz@redhat.com>
In-Reply-To: <20191001194715.2796-1-mreitz@redhat.com>
References: <20191001194715.2796-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Tue, 01 Oct 2019 19:47:29 +0000 (UTC)
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

create_test_image() must be paired with an ImagePath so that the image
is properly cleaned up with remove_test_image() instead of just
os.remove().

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/iotests.py | 32 ++++++++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.p=
y
index fce1ab04c9..5be6ca674c 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -440,8 +440,8 @@ class FilePaths(object):
     Use this context manager to generate filenames and ensure that the f=
ile
     gets deleted::
=20
-        with FilePaths(['test.img']) as img_path:
-            qemu_img('create', img_path, '1G')
+        with FilePaths(['migration.sock']) as migration_sock_path:
+            # Set up and use UNIX socket on migration.sock
         # migration_sock_path is automatically deleted
     """
     def __init__(self, names):
@@ -460,6 +460,23 @@ class FilePaths(object):
             pass
         return False
=20
+class ImagePaths(FilePaths):
+    """
+    Same as FilePaths, except it calls remove_test_image() to clean up
+    (which ensures that external data files are cleaned up, too).
+
+    Use this class for test images in the default format
+    (iotests.imgfmt):
+
+    with ImagePaths(['test.img']) as img_path:
+        create_test_image(img_path, '1G')
+    # The test image is automatically cleaned up
+    """
+    def __exit__(self, exc_type, exc_val, exc_tb):
+        for path in self.paths:
+            remove_test_image(path)
+        return False
+
 class FilePath(FilePaths):
     """
     FilePath is a specialization of FilePaths that takes a single filena=
me.
@@ -470,6 +487,17 @@ class FilePath(FilePaths):
     def __enter__(self):
         return self.paths[0]
=20
+class ImagePath(ImagePaths):
+    """
+    ImagePath is a specialization of ImagePaths that takes a single
+    filename.
+    """
+    def __init__(self, name):
+        super(ImagePath, self).__init__([name])
+
+    def __enter__(self):
+        return self.paths[0]
+
 def file_path_remover():
     for path in reversed(file_path_remover.paths):
         try:
--=20
2.21.0


