Return-Path: <SRS0=PhvJ=UY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AFA3C48BD6
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 21:23:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0371D2085A
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 21:23:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0371D2085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35332 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfsuL-0001ZZ-7E
	for qemu-devel@archiver.kernel.org; Tue, 25 Jun 2019 17:23:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41840)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hfsrj-0008U9-B3
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 17:20:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hfsri-0004cR-6Q
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 17:20:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55066)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hfsrQ-00048J-Pf; Tue, 25 Jun 2019 17:20:18 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D95ED308FFB1;
 Tue, 25 Jun 2019 21:20:10 +0000 (UTC)
Received: from localhost (ovpn-204-63.brq.redhat.com [10.40.204.63])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 707F3600C7;
 Tue, 25 Jun 2019 21:20:08 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Tue, 25 Jun 2019 23:19:52 +0200
Message-Id: <20190625211955.15664-3-mreitz@redhat.com>
In-Reply-To: <20190625211955.15664-1-mreitz@redhat.com>
References: <20190625211955.15664-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Tue, 25 Jun 2019 21:20:15 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 2/5] iotests: Prefer null-co over null-aio
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
index bc1ceb9792..ae169778b0 100644
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


