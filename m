Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B71D4C352AA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 20:41:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B6C120842
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 20:41:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B6C120842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47946 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFOxW-0000E0-7Z
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 16:41:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54928)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iFO8g-0005Rn-04
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 15:48:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iFO8f-0008MF-1R
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 15:48:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58704)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iFO8c-0008KO-Qn; Tue, 01 Oct 2019 15:48:46 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2083730832EA;
 Tue,  1 Oct 2019 19:48:46 +0000 (UTC)
Received: from localhost (unknown [10.40.205.251])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AFE3D5D9C9;
 Tue,  1 Oct 2019 19:48:45 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 38/67] iotests/194: Honor $IMGOPTS
Date: Tue,  1 Oct 2019 21:46:46 +0200
Message-Id: <20191001194715.2796-39-mreitz@redhat.com>
In-Reply-To: <20191001194715.2796-1-mreitz@redhat.com>
References: <20191001194715.2796-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Tue, 01 Oct 2019 19:48:46 +0000 (UTC)
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
 tests/qemu-iotests/194 | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tests/qemu-iotests/194 b/tests/qemu-iotests/194
index c8aeb6d0e4..70cae2d8ef 100755
--- a/tests/qemu-iotests/194
+++ b/tests/qemu-iotests/194
@@ -20,19 +20,20 @@
 # Non-shared storage migration test using NBD server and drive-mirror
=20
 import iotests
+from iotests import create_test_image
=20
 iotests.script_initialize(supported_fmts=3D['qcow2', 'qed', 'raw'])
=20
-with iotests.FilePath('source.img') as source_img_path, \
-     iotests.FilePath('dest.img') as dest_img_path, \
+with iotests.ImagePath('source.img') as source_img_path, \
+     iotests.ImagePath('dest.img') as dest_img_path, \
      iotests.FilePath('migration.sock') as migration_sock_path, \
      iotests.FilePath('nbd.sock') as nbd_sock_path, \
      iotests.VM('source') as source_vm, \
      iotests.VM('dest') as dest_vm:
=20
     img_size =3D '1G'
-    iotests.qemu_img_pipe('create', '-f', iotests.imgfmt, source_img_pat=
h, img_size)
-    iotests.qemu_img_pipe('create', '-f', iotests.imgfmt, dest_img_path,=
 img_size)
+    create_test_image(source_img_path, img_size)
+    create_test_image(dest_img_path, img_size)
=20
     iotests.log('Launching VMs...')
     (source_vm.add_drive(source_img_path)
--=20
2.21.0


