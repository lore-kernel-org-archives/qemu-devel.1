Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48B2DECE587
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 20:37:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B36720842
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 20:37:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B36720842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFOtn-00046F-9D
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 16:37:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54550)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iFO8F-0004x7-QK
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 15:48:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iFO8D-00087P-Nc
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 15:48:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44440)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iFO85-00081k-Hc; Tue, 01 Oct 2019 15:48:13 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id AA3632A09B2;
 Tue,  1 Oct 2019 19:48:11 +0000 (UTC)
Received: from localhost (unknown [10.40.205.251])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 44C54611DB;
 Tue,  1 Oct 2019 19:48:11 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 23/67] iotests/065: Honor $IMGOPTS
Date: Tue,  1 Oct 2019 21:46:31 +0200
Message-Id: <20191001194715.2796-24-mreitz@redhat.com>
In-Reply-To: <20191001194715.2796-1-mreitz@redhat.com>
References: <20191001194715.2796-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Tue, 01 Oct 2019 19:48:11 +0000 (UTC)
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
 tests/qemu-iotests/065 | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/tests/qemu-iotests/065 b/tests/qemu-iotests/065
index 9db9552784..221a87417d 100755
--- a/tests/qemu-iotests/065
+++ b/tests/qemu-iotests/065
@@ -23,7 +23,7 @@ import os
 import re
 import json
 import iotests
-from iotests import qemu_img, qemu_img_pipe
+from iotests import create_test_image, remove_test_image, qemu_img_pipe
 import unittest
=20
 test_img =3D os.path.join(iotests.test_dir, 'test.img')
@@ -34,11 +34,10 @@ class TestImageInfoSpecific(iotests.QMPTestCase):
     def setUp(self):
         if self.img_options is None:
             self.skipTest('Skipping abstract test class')
-        qemu_img('create', '-f', iotests.imgfmt, '-o', self.img_options,
-                 test_img, '128K')
+        create_test_image(test_img, '128K', opts=3Dself.img_options)
=20
     def tearDown(self):
-        os.remove(test_img)
+        remove_test_image(test_img)
=20
 class TestQemuImgInfo(TestImageInfoSpecific):
     '''Abstract base class for qemu-img info tests'''
@@ -87,13 +86,13 @@ class TestQMP(TestImageInfoSpecific):
=20
 class TestQCow2(TestQemuImgInfo):
     '''Testing a qcow2 version 2 image'''
-    img_options =3D 'compat=3D0.10'
+    img_options =3D ['compat=3D0.10']
     json_compare =3D { 'compat': '0.10', 'refcount-bits': 16 }
     human_compare =3D [ 'compat: 0.10', 'refcount bits: 16' ]
=20
 class TestQCow3NotLazy(TestQemuImgInfo):
     '''Testing a qcow2 version 3 image with lazy refcounts disabled'''
-    img_options =3D 'compat=3D1.1,lazy_refcounts=3Doff'
+    img_options =3D ['compat=3D1.1', 'lazy_refcounts=3Doff']
     json_compare =3D { 'compat': '1.1', 'lazy-refcounts': False,
                      'refcount-bits': 16, 'corrupt': False }
     human_compare =3D [ 'compat: 1.1', 'lazy refcounts: false',
@@ -101,7 +100,7 @@ class TestQCow3NotLazy(TestQemuImgInfo):
=20
 class TestQCow3Lazy(TestQemuImgInfo):
     '''Testing a qcow2 version 3 image with lazy refcounts enabled'''
-    img_options =3D 'compat=3D1.1,lazy_refcounts=3Don'
+    img_options =3D ['compat=3D1.1', 'lazy_refcounts=3Don']
     json_compare =3D { 'compat': '1.1', 'lazy-refcounts': True,
                      'refcount-bits': 16, 'corrupt': False }
     human_compare =3D [ 'compat: 1.1', 'lazy refcounts: true',
@@ -110,7 +109,7 @@ class TestQCow3Lazy(TestQemuImgInfo):
 class TestQCow3NotLazyQMP(TestQMP):
     '''Testing a qcow2 version 3 image with lazy refcounts disabled, ope=
ning
        with lazy refcounts enabled'''
-    img_options =3D 'compat=3D1.1,lazy_refcounts=3Doff'
+    img_options =3D ['compat=3D1.1', 'lazy_refcounts=3Doff']
     qemu_options =3D 'lazy-refcounts=3Don'
     compare =3D { 'compat': '1.1', 'lazy-refcounts': False,
                 'refcount-bits': 16, 'corrupt': False }
@@ -119,7 +118,7 @@ class TestQCow3NotLazyQMP(TestQMP):
 class TestQCow3LazyQMP(TestQMP):
     '''Testing a qcow2 version 3 image with lazy refcounts enabled, open=
ing
        with lazy refcounts disabled'''
-    img_options =3D 'compat=3D1.1,lazy_refcounts=3Don'
+    img_options =3D ['compat=3D1.1', 'lazy_refcounts=3Don']
     qemu_options =3D 'lazy-refcounts=3Doff'
     compare =3D { 'compat': '1.1', 'lazy-refcounts': True,
                 'refcount-bits': 16, 'corrupt': False }
--=20
2.21.0


