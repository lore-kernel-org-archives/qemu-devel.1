Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F5F9C352AA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 21:52:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E53A62133F
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 21:52:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E53A62133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48594 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFQ4H-0003sz-Cp
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 17:52:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55568)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iFO9b-0006dD-Qq
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 15:49:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iFO9a-0000Qs-2d
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 15:49:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52362)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iFO9T-0000Ll-GC; Tue, 01 Oct 2019 15:49:39 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 59546A44AF5;
 Tue,  1 Oct 2019 19:49:36 +0000 (UTC)
Received: from localhost (unknown [10.40.205.251])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E972F6012C;
 Tue,  1 Oct 2019 19:49:35 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 59/67] iotests/248: Honor $IMGOPTS
Date: Tue,  1 Oct 2019 21:47:07 +0200
Message-Id: <20191001194715.2796-60-mreitz@redhat.com>
In-Reply-To: <20191001194715.2796-1-mreitz@redhat.com>
References: <20191001194715.2796-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.68]); Tue, 01 Oct 2019 19:49:36 +0000 (UTC)
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
 tests/qemu-iotests/248 | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tests/qemu-iotests/248 b/tests/qemu-iotests/248
index 0adc4da802..90821eaeda 100755
--- a/tests/qemu-iotests/248
+++ b/tests/qemu-iotests/248
@@ -19,7 +19,7 @@
 #
=20
 import iotests
-from iotests import qemu_img_create, qemu_io, file_path, filter_qmp_test=
files
+from iotests import create_test_image, qemu_io, image_path, filter_qmp_t=
estfiles
=20
 iotests.script_initialize(supported_fmts=3D['qcow2'],
                           # With an external data file, we would need
@@ -27,12 +27,12 @@ iotests.script_initialize(supported_fmts=3D['qcow2'],
                           # of @file
                           unsupported_imgopts=3D['data_file'])
=20
-source, target =3D file_path('source', 'target')
+source, target =3D image_path('source', 'target')
 size =3D 5 * 1024 * 1024
 limit =3D 2 * 1024 * 1024
=20
-qemu_img_create('-f', iotests.imgfmt, source, str(size))
-qemu_img_create('-f', iotests.imgfmt, target, str(size))
+create_test_image(source, size)
+create_test_image(target, size)
 qemu_io('-c', 'write 0 {}'.format(size), source)
=20
 # raw format don't like empty files
--=20
2.21.0


