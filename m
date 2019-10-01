Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F178FC352AA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 20:56:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C54E2215EA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 20:56:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C54E2215EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48066 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFPC2-0003lh-9B
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 16:56:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55653)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iFO9g-0006hf-3y
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 15:49:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iFO9f-0000TW-0p
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 15:49:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44152)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iFO9a-0000QQ-8y; Tue, 01 Oct 2019 15:49:46 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 89E6C308FC4D;
 Tue,  1 Oct 2019 19:49:45 +0000 (UTC)
Received: from localhost (unknown [10.40.205.251])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 240EC5D6D0;
 Tue,  1 Oct 2019 19:49:44 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 63/67] iotests/257: Honor $IMGOPTS
Date: Tue,  1 Oct 2019 21:47:11 +0200
Message-Id: <20191001194715.2796-64-mreitz@redhat.com>
In-Reply-To: <20191001194715.2796-1-mreitz@redhat.com>
References: <20191001194715.2796-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Tue, 01 Oct 2019 19:49:45 +0000 (UTC)
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

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/257 | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/tests/qemu-iotests/257 b/tests/qemu-iotests/257
index 82c10e9b52..ea38945a71 100755
--- a/tests/qemu-iotests/257
+++ b/tests/qemu-iotests/257
@@ -23,7 +23,7 @@ import math
 import os
=20
 import iotests
-from iotests import log, qemu_img
+from iotests import log, create_test_image, qemu_img
=20
 SIZE =3D 64 * 1024 * 1024
 GRANULARITY =3D 64 * 1024
@@ -152,7 +152,7 @@ class Drive:
     def img_create(self, fmt, size):
         self.fmt =3D fmt
         self.size =3D size
-        iotests.qemu_img_create('-f', self.fmt, self.path, str(self.size=
))
+        create_test_image(self.path, self.size)
=20
     def create_target(self, name, fmt, size):
         basename =3D os.path.basename(self.path)
@@ -273,10 +273,10 @@ def test_bitmap_sync(bsync_mode, msync_mode=3D'bitm=
ap', failure=3DNone):
                         an incomplete backup. Testing limitations preven=
t
                         testing competing writes.
     """
-    with iotests.FilePaths(['img', 'bsync1', 'bsync2',
+    with iotests.ImagePath('img') as img_path, \
+        iotests.FilePaths(['bsync1', 'bsync2',
                             'fbackup0', 'fbackup1', 'fbackup2']) as \
-                            (img_path, bsync1, bsync2,
-                             fbackup0, fbackup1, fbackup2), \
+                            (bsync1, bsync2, fbackup0, fbackup1, fbackup=
2), \
          iotests.VM() as vm:
=20
         mode =3D "Mode {:s}; Bitmap Sync {:s}".format(msync_mode, bsync_=
mode)
@@ -439,8 +439,8 @@ def test_backup_api():
     """
     Test malformed and prohibited invocations of the backup API.
     """
-    with iotests.FilePaths(['img', 'bsync1']) as \
-         (img_path, backup_path), \
+    with iotests.ImagePath('img') as img_path, \
+         iotests.FilePath('bsync1') as backup_path, \
          iotests.VM() as vm:
=20
         log("\n=3D=3D=3D API failure tests =3D=3D=3D\n")
--=20
2.21.0


