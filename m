Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90C2AC3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 16:31:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 639882087E
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 16:31:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 639882087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55374 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzkZB-0003DD-I5
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 12:31:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35545)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1hzkM6-0003F7-SD
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 12:18:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hzkM4-0006Ss-Mk
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 12:18:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38088)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hzkM1-0006Qs-9g; Mon, 19 Aug 2019 12:17:57 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 924192A09C8;
 Mon, 19 Aug 2019 16:17:56 +0000 (UTC)
Received: from localhost (ovpn-204-64.brq.redhat.com [10.40.204.64])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2CDE29A060;
 Mon, 19 Aug 2019 16:17:55 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Mon, 19 Aug 2019 18:17:17 +0200
Message-Id: <20190819161723.7746-12-mreitz@redhat.com>
In-Reply-To: <20190819161723.7746-1-mreitz@redhat.com>
References: <20190819161723.7746-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Mon, 19 Aug 2019 16:17:56 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 11/17] iotests: Test convert -n to pre-filled
 image
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

Signed-off-by: Max Reitz <mreitz@redhat.com>
Message-id: 20190724171239.8764-11-mreitz@redhat.com
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/122     | 17 +++++++++++++++++
 tests/qemu-iotests/122.out |  8 ++++++++
 2 files changed, 25 insertions(+)

diff --git a/tests/qemu-iotests/122 b/tests/qemu-iotests/122
index 85c3a8d047..059011ebb1 100755
--- a/tests/qemu-iotests/122
+++ b/tests/qemu-iotests/122
@@ -257,6 +257,23 @@ for min_sparse in 4k 8k; do
     $QEMU_IMG map --output=3Djson "$TEST_IMG".orig | _filter_qemu_img_ma=
p
 done
=20
+
+echo
+echo '=3D=3D=3D -n to a non-zero image =3D=3D=3D'
+echo
+
+# Keep source zero
+_make_test_img 64M
+
+# Output is not zero, but has bdrv_has_zero_init() =3D=3D 1
+TEST_IMG=3D"$TEST_IMG".orig _make_test_img 64M
+$QEMU_IO -c "write -P 42 0 64k" "$TEST_IMG".orig | _filter_qemu_io
+
+# Convert with -n, which should not assume that the target is zeroed
+$QEMU_IMG convert -O $IMGFMT -n "$TEST_IMG" "$TEST_IMG".orig
+
+$QEMU_IMG compare "$TEST_IMG" "$TEST_IMG".orig
+
 # success, all done
 echo '*** done'
 rm -f $seq.full
diff --git a/tests/qemu-iotests/122.out b/tests/qemu-iotests/122.out
index c576705284..849b6cc2ef 100644
--- a/tests/qemu-iotests/122.out
+++ b/tests/qemu-iotests/122.out
@@ -220,4 +220,12 @@ convert -c -S 8k
 { "start": 9216, "length": 8192, "depth": 0, "zero": true, "data": false=
},
 { "start": 17408, "length": 1024, "depth": 0, "zero": false, "data": tru=
e},
 { "start": 18432, "length": 67090432, "depth": 0, "zero": true, "data": =
false}]
+
+=3D=3D=3D -n to a non-zero image =3D=3D=3D
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864
+Formatting 'TEST_DIR/t.IMGFMT.orig', fmt=3DIMGFMT size=3D67108864
+wrote 65536/65536 bytes at offset 0
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+Images are identical.
 *** done
--=20
2.21.0


