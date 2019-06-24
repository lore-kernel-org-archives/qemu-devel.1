Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D0A0C43613
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 14:58:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08C99205C9
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 14:58:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08C99205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52028 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfQQN-0003xf-Bh
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 10:58:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60129)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hfQGK-0002o6-KD
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 10:48:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hfQGI-0006FL-Vk
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 10:48:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35281)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hfQGG-0005pF-3D; Mon, 24 Jun 2019 10:48:00 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0E9D2C04B93D;
 Mon, 24 Jun 2019 14:47:51 +0000 (UTC)
Received: from localhost (ovpn-204-152.brq.redhat.com [10.40.204.152])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 998AD6090E;
 Mon, 24 Jun 2019 14:47:50 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Mon, 24 Jun 2019 16:47:35 +0200
Message-Id: <20190624144740.5338-4-mreitz@redhat.com>
In-Reply-To: <20190624144740.5338-1-mreitz@redhat.com>
References: <20190624144740.5338-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Mon, 24 Jun 2019 14:47:51 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL v2 3/8] iotest 134: test cluster-misaligned
 encrypted write
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Anton Nefedov <anton.nefedov@virtuozzo.com>

COW (even empty/zero) areas require encryption too

Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
Message-id: 20190516143028.81155-1-anton.nefedov@virtuozzo.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/134     |  9 +++++++++
 tests/qemu-iotests/134.out | 10 ++++++++++
 2 files changed, 19 insertions(+)

diff --git a/tests/qemu-iotests/134 b/tests/qemu-iotests/134
index 141a2eaa7e..5f0fb86211 100755
--- a/tests/qemu-iotests/134
+++ b/tests/qemu-iotests/134
@@ -56,6 +56,15 @@ echo
 echo "=3D=3D reading whole image =3D=3D"
 $QEMU_IO --object $SECRET -c "read 0 $size" --image-opts $IMGSPEC | _fil=
ter_qemu_io | _filter_testdir
=20
+echo
+echo "=3D=3D rewriting cluster part =3D=3D"
+$QEMU_IO --object $SECRET -c "write -P 0xb 512 512" --image-opts $IMGSPE=
C | _filter_qemu_io | _filter_testdir
+
+echo
+echo "=3D=3D verify pattern =3D=3D"
+$QEMU_IO --object $SECRET -c "read -P 0 0 512"  --image-opts $IMGSPEC | =
_filter_qemu_io | _filter_testdir
+$QEMU_IO --object $SECRET -c "read -P 0xb 512 512"  --image-opts $IMGSPE=
C | _filter_qemu_io | _filter_testdir
+
 echo
 echo "=3D=3D rewriting whole image =3D=3D"
 $QEMU_IO --object $SECRET -c "write -P 0xa 0 $size" --image-opts $IMGSPE=
C | _filter_qemu_io | _filter_testdir
diff --git a/tests/qemu-iotests/134.out b/tests/qemu-iotests/134.out
index 972be49d91..09d46f6b17 100644
--- a/tests/qemu-iotests/134.out
+++ b/tests/qemu-iotests/134.out
@@ -5,6 +5,16 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1342=
17728 encryption=3Don encrypt.
 read 134217728/134217728 bytes at offset 0
 128 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
=20
+=3D=3D rewriting cluster part =3D=3D
+wrote 512/512 bytes at offset 512
+512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+=3D=3D verify pattern =3D=3D
+read 512/512 bytes at offset 0
+512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 512/512 bytes at offset 512
+512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
 =3D=3D rewriting whole image =3D=3D
 wrote 134217728/134217728 bytes at offset 0
 128 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
--=20
2.21.0


