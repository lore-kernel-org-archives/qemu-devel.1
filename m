Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76B0DC04AB4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 10:11:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4532020848
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 10:11:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4532020848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45635 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRZpT-00085u-GX
	for qemu-devel@archiver.kernel.org; Fri, 17 May 2019 06:11:07 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44464)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hRZn2-00063L-1R
	for qemu-devel@nongnu.org; Fri, 17 May 2019 06:08:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hRZbf-0005uq-FU
	for qemu-devel@nongnu.org; Fri, 17 May 2019 05:56:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:64520)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hRZbe-0005bp-8U; Fri, 17 May 2019 05:56:50 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 123367E429;
	Fri, 17 May 2019 09:56:39 +0000 (UTC)
Received: from localhost (unknown [10.40.205.117])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 905EA348F4;
	Fri, 17 May 2019 09:56:37 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Fri, 17 May 2019 11:56:26 +0200
Message-Id: <20190517095628.10119-3-mreitz@redhat.com>
In-Reply-To: <20190517095628.10119-1-mreitz@redhat.com>
References: <20190517095628.10119-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.27]);
	Fri, 17 May 2019 09:56:39 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 2/4] iotests: Prefer null-co over null-aio
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
	Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We use null-co basically everywhere in the iotests.  Unless we want to
test null-aio specifically, we should use it instead (for consistency).

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/093 | 7 +++----
 tests/qemu-iotests/245 | 2 +-
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/tests/qemu-iotests/093 b/tests/qemu-iotests/093
index d88fbc182e..bd56c94708 100755
--- a/tests/qemu-iotests/093
+++ b/tests/qemu-iotests/093
@@ -267,13 +267,12 @@ class ThrottleTestCoroutine(ThrottleTestCase):
     test_img =3D "null-co://"
=20
 class ThrottleTestGroupNames(iotests.QMPTestCase):
-    test_img =3D "null-aio://"
     max_drives =3D 3
=20
     def setUp(self):
         self.vm =3D iotests.VM()
         for i in range(0, self.max_drives):
-            self.vm.add_drive(self.test_img, "throttling.iops-total=3D10=
0")
+            self.vm.add_drive("null-co://", "throttling.iops-total=3D100=
")
         self.vm.launch()
=20
     def tearDown(self):
@@ -377,10 +376,10 @@ class ThrottleTestRemovableMedia(iotests.QMPTestCas=
e):
=20
     def test_removable_media(self):
         # Add a couple of dummy nodes named cd0 and cd1
-        result =3D self.vm.qmp("blockdev-add", driver=3D"null-aio",
+        result =3D self.vm.qmp("blockdev-add", driver=3D"null-co",
                              node_name=3D"cd0")
         self.assert_qmp(result, 'return', {})
-        result =3D self.vm.qmp("blockdev-add", driver=3D"null-aio",
+        result =3D self.vm.qmp("blockdev-add", driver=3D"null-co",
                              node_name=3D"cd1")
         self.assert_qmp(result, 'return', {})
=20
diff --git a/tests/qemu-iotests/245 b/tests/qemu-iotests/245
index a04c6235c1..d888a1354c 100644
--- a/tests/qemu-iotests/245
+++ b/tests/qemu-iotests/245
@@ -598,7 +598,7 @@ class TestBlockdevReopen(iotests.QMPTestCase):
         ##################
         ###### null ######
         ##################
-        opts =3D {'driver': 'null-aio', 'node-name': 'root', 'size': 102=
4}
+        opts =3D {'driver': 'null-co', 'node-name': 'root', 'size': 1024=
}
=20
         result =3D self.vm.qmp('blockdev-add', conv_keys =3D False, **op=
ts)
         self.assert_qmp(result, 'return', {})
--=20
2.21.0


