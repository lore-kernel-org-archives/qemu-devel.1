Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CDA1C004C9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 20:38:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 211F320449
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 20:38:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 211F320449
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54437 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hO6qp-0007yJ-7f
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 16:38:11 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34745)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hO6oR-0005K4-QQ
	for qemu-devel@nongnu.org; Tue, 07 May 2019 16:35:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hO6oP-000408-Vv
	for qemu-devel@nongnu.org; Tue, 07 May 2019 16:35:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53002)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hO6oK-0003lB-IC; Tue, 07 May 2019 16:35:36 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1FED3309B163;
	Tue,  7 May 2019 20:35:30 +0000 (UTC)
Received: from localhost (unknown [10.40.205.217])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id A949560BF4;
	Tue,  7 May 2019 20:35:29 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Tue,  7 May 2019 22:35:08 +0200
Message-Id: <20190507203508.18026-8-mreitz@redhat.com>
In-Reply-To: <20190507203508.18026-1-mreitz@redhat.com>
References: <20190507203508.18026-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.49]);
	Tue, 07 May 2019 20:35:30 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v4 7/7] iotests: Test qemu-img convert -C
 --salvage
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
Cc: Kevin Wolf <kwolf@redhat.com>,
	Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
	qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We do not support this combination (yet), so this should yield an error
message.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Tested-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 tests/qemu-iotests/082     | 1 +
 tests/qemu-iotests/082.out | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/tests/qemu-iotests/082 b/tests/qemu-iotests/082
index 278511dba4..804610c7eb 100755
--- a/tests/qemu-iotests/082
+++ b/tests/qemu-iotests/082
@@ -163,6 +163,7 @@ echo =3D=3D=3D convert: -C and other options =3D=3D=3D
 run_qemu_img convert -C -S 4k -O $IMGFMT "$TEST_IMG" "$TEST_IMG".target
 run_qemu_img convert -C -S 8k -O $IMGFMT "$TEST_IMG" "$TEST_IMG".target
 run_qemu_img convert -C -c -O $IMGFMT "$TEST_IMG" "$TEST_IMG".target
+run_qemu_img convert -C --salvage -O $IMGFMT "$TEST_IMG" "$TEST_IMG".tar=
get
=20
 echo
 echo =3D=3D=3D amend: Options specified more than once =3D=3D=3D
diff --git a/tests/qemu-iotests/082.out b/tests/qemu-iotests/082.out
index 7e25706813..58de358b38 100644
--- a/tests/qemu-iotests/082.out
+++ b/tests/qemu-iotests/082.out
@@ -567,6 +567,9 @@ qemu-img: Cannot enable copy offloading when -S is us=
ed
 Testing: convert -C -c -O qcow2 TEST_DIR/t.qcow2 TEST_DIR/t.qcow2.target
 qemu-img: Cannot enable copy offloading when -c is used
=20
+Testing: convert -C --salvage -O qcow2 TEST_DIR/t.qcow2 TEST_DIR/t.qcow2=
.target
+qemu-img: Cannot use copy offloading in salvaging mode
+
 =3D=3D=3D amend: Options specified more than once =3D=3D=3D
=20
 Testing: amend -f foo -f qcow2 -o lazy_refcounts=3Don TEST_DIR/t.qcow2
--=20
2.20.1


