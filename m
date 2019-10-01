Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FE46ECE587
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 20:24:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32E292133F
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 20:24:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32E292133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47810 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFOgp-0001y6-Ds
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 16:24:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54333)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iFO7w-0004kY-5z
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 15:48:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iFO7v-0007xS-4l
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 15:48:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35058)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iFO7t-0007wJ-1V; Tue, 01 Oct 2019 15:48:01 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 34B8F81DE1;
 Tue,  1 Oct 2019 19:48:00 +0000 (UTC)
Received: from localhost (unknown [10.40.205.251])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C403B19C6A;
 Tue,  1 Oct 2019 19:47:59 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 18/67] iotests/044: Honor $IMGOPTS
Date: Tue,  1 Oct 2019 21:46:26 +0200
Message-Id: <20191001194715.2796-19-mreitz@redhat.com>
In-Reply-To: <20191001194715.2796-1-mreitz@redhat.com>
References: <20191001194715.2796-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Tue, 01 Oct 2019 19:48:00 +0000 (UTC)
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
 tests/qemu-iotests/044 | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/qemu-iotests/044 b/tests/qemu-iotests/044
index 97ba98e628..a5e13751e1 100755
--- a/tests/qemu-iotests/044
+++ b/tests/qemu-iotests/044
@@ -23,7 +23,7 @@ import os
 import qcow2
 from qcow2 import QcowHeader
 import iotests
-from iotests import qemu_img, qemu_img_verbose, qemu_io
+from iotests import create_test_image, remove_test_image, qemu_img_verbo=
se, qemu_io
 import struct
 import subprocess
 import sys
@@ -100,13 +100,13 @@ class TestRefcountTableGrowth(iotests.QMPTestCase):
=20
=20
     def setUp(self):
-        qemu_img('create', '-f', iotests.imgfmt, '-o', 'cluster_size=3D5=
12', test_img, '16G')
+        create_test_image(test_img, '16G', opts=3D['cluster_size=3D512']=
)
         self.preallocate(test_img)
         pass
=20
=20
     def tearDown(self):
-        os.remove(test_img)
+        remove_test_image(test_img)
         pass
=20
     def test_grow_refcount_table(self):
--=20
2.21.0


