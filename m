Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 705CBC352AA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 21:57:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 432602133F
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 21:57:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 432602133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48642 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFQ9M-0007qy-0p
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 17:57:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55672)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iFO9h-0006j6-DT
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 15:49:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iFO9g-0000UY-A7
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 15:49:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35854)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iFO9d-0000S3-ML; Tue, 01 Oct 2019 15:49:49 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id CE8B8C0546F1;
 Tue,  1 Oct 2019 19:49:47 +0000 (UTC)
Received: from localhost (unknown [10.40.205.251])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 69C9160623;
 Tue,  1 Oct 2019 19:49:47 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 64/67] iotests/258: Honor $IMGOPTS
Date: Tue,  1 Oct 2019 21:47:12 +0200
Message-Id: <20191001194715.2796-65-mreitz@redhat.com>
In-Reply-To: <20191001194715.2796-1-mreitz@redhat.com>
References: <20191001194715.2796-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Tue, 01 Oct 2019 19:49:47 +0000 (UTC)
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
 tests/qemu-iotests/258 | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/tests/qemu-iotests/258 b/tests/qemu-iotests/258
index 1372522c7a..3e9505d8d4 100755
--- a/tests/qemu-iotests/258
+++ b/tests/qemu-iotests/258
@@ -20,7 +20,7 @@
 # Creator/Owner: Max Reitz <mreitz@redhat.com>
=20
 import iotests
-from iotests import log, qemu_img, qemu_io_silent, \
+from iotests import log, create_test_image, qemu_io_silent, \
         filter_qmp_testfiles, filter_qmp_imgfmt
=20
 # Returns a node for blockdev-add
@@ -65,22 +65,22 @@ def test_concurrent_finish(write_to_stream_node):
     # and the other way around, depending on whether the commit job
     # is finalized before stream completes or not.
=20
-    with iotests.FilePath('node4.img') as node4_path, \
-         iotests.FilePath('node3.img') as node3_path, \
-         iotests.FilePath('node2.img') as node2_path, \
-         iotests.FilePath('node1.img') as node1_path, \
-         iotests.FilePath('node0.img') as node0_path, \
+    with iotests.ImagePath('node4.img') as node4_path, \
+         iotests.ImagePath('node3.img') as node3_path, \
+         iotests.ImagePath('node2.img') as node2_path, \
+         iotests.ImagePath('node1.img') as node1_path, \
+         iotests.ImagePath('node0.img') as node0_path, \
          iotests.VM() as vm:
=20
         # It is important to use raw for the base layer (so that
         # permissions are just handed through to the protocol layer)
-        assert qemu_img('create', '-f', 'raw', node0_path, '64M') =3D=3D=
 0
+        assert create_test_image(node0_path, '64M', fmt=3D'raw') =3D=3D =
0
=20
         stream_throttle=3DNone
         commit_throttle=3DNone
=20
         for path in [node1_path, node2_path, node3_path, node4_path]:
-            assert qemu_img('create', '-f', iotests.imgfmt, path, '64M')=
 =3D=3D 0
+            assert create_test_image(path, '64M') =3D=3D 0
=20
         if write_to_stream_node:
             # This is what (most of the time) makes commit finish
--=20
2.21.0


