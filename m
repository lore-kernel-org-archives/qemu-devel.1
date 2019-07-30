Return-Path: <SRS0=D7Ry=V3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49223C0650F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 15:36:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F262206E0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 15:36:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F262206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34008 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsUAU-0001pH-Am
	for qemu-devel@archiver.kernel.org; Tue, 30 Jul 2019 11:36:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45188)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kwolf@redhat.com>) id 1hsU8M-0007kx-68
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 11:33:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1hsU8L-0004au-7V
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 11:33:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57438)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1hsU8J-0004YA-28; Tue, 30 Jul 2019 11:33:47 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 653FAC007359;
 Tue, 30 Jul 2019 15:33:46 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-117-75.ams2.redhat.com
 [10.36.117.75])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 580C7608C1;
 Tue, 30 Jul 2019 15:33:45 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Date: Tue, 30 Jul 2019 17:33:31 +0200
Message-Id: <20190730153331.24515-3-kwolf@redhat.com>
In-Reply-To: <20190730153331.24515-1-kwolf@redhat.com>
References: <20190730153331.24515-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Tue, 30 Jul 2019 15:33:46 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 2/2] iotests/118: Test inserting a read-only
 medium
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
---
 tests/qemu-iotests/118     | 6 +++++-
 tests/qemu-iotests/118.out | 4 ++--
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/tests/qemu-iotests/118 b/tests/qemu-iotests/118
index 603e10e8a2..499c5f0901 100755
--- a/tests/qemu-iotests/118
+++ b/tests/qemu-iotests/118
@@ -207,10 +207,11 @@ class GeneralChangeTestsBaseClass(ChangeBaseClass):
             self.assert_qmp(result, 'return[0]/tray_open', False)
         self.assert_qmp(result, 'return[0]/inserted/image/filename', new=
_img)
=20
-    def test_cycle(self):
+    def test_cycle(self, read_only_node=3DFalse):
         result =3D self.vm.qmp('blockdev-add',
                              node_name=3D'new',
                              driver=3Diotests.imgfmt,
+                             read_only=3Dread_only_node,
                              file=3D{'filename': new_img,
                                     'driver': 'file'})
         self.assert_qmp(result, 'return', {})
@@ -257,6 +258,9 @@ class GeneralChangeTestsBaseClass(ChangeBaseClass):
             self.assert_qmp(result, 'return[0]/tray_open', False)
         self.assert_qmp(result, 'return[0]/inserted/image/filename', new=
_img)
=20
+    def test_cycle_read_only_media(self):
+        self.test_cycle(True)
+
     def test_close_on_closed(self):
         result =3D self.vm.qmp('blockdev-close-tray', id=3Dself.device_n=
ame)
         # Should be a no-op
diff --git a/tests/qemu-iotests/118.out b/tests/qemu-iotests/118.out
index 6a917130b6..4823c113d5 100644
--- a/tests/qemu-iotests/118.out
+++ b/tests/qemu-iotests/118.out
@@ -1,5 +1,5 @@
-...........................................................
+...............................................................
 ----------------------------------------------------------------------
-Ran 59 tests
+Ran 63 tests
=20
 OK
--=20
2.20.1


