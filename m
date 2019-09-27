Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E62BC4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 10:04:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7C15217D7
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 10:04:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7C15217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49168 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDn6e-0008TU-0J
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 06:04:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33616)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iDmme-0003nz-4Q
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 05:43:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iDmmc-00088n-Qy
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 05:43:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34024)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iDmma-00082l-5E; Fri, 27 Sep 2019 05:43:24 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 64239E8CD9;
 Fri, 27 Sep 2019 09:43:23 +0000 (UTC)
Received: from localhost (ovpn-204-76.brq.redhat.com [10.40.204.76])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F334360606;
 Fri, 27 Sep 2019 09:43:22 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 16/18] iotests: Make 198 work with data_file
Date: Fri, 27 Sep 2019 11:42:40 +0200
Message-Id: <20190927094242.11152-17-mreitz@redhat.com>
In-Reply-To: <20190927094242.11152-1-mreitz@redhat.com>
References: <20190927094242.11152-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Fri, 27 Sep 2019 09:43:23 +0000 (UTC)
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

We do not care about the json:{} filenames here, so we can just filter
them out and thus make the test work both with and without external data
files.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/198     | 6 ++++--
 tests/qemu-iotests/198.out | 4 ++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/tests/qemu-iotests/198 b/tests/qemu-iotests/198
index c8f824cfae..d9981942a7 100755
--- a/tests/qemu-iotests/198
+++ b/tests/qemu-iotests/198
@@ -92,13 +92,15 @@ echo
 echo "=3D=3D checking image base =3D=3D"
 $QEMU_IMG info --image-opts $IMGSPECBASE | _filter_img_info --format-spe=
cific \
     | sed -e "/^disk size:/ D" -e '/refcount bits:/ D' -e '/compat:/ D' =
\
-          -e '/lazy refcounts:/ D' -e '/corrupt:/ D'
+          -e '/lazy refcounts:/ D' -e '/corrupt:/ D' -e '/^\s*data file/=
 D' \
+          -e 's#image: json:.*#image: json:{ /* filtered */ }#'
=20
 echo
 echo "=3D=3D checking image layer =3D=3D"
 $QEMU_IMG info --image-opts $IMGSPECLAYER | _filter_img_info --format-sp=
ecific \
     | sed -e "/^disk size:/ D" -e '/refcount bits:/ D' -e '/compat:/ D' =
\
-          -e '/lazy refcounts:/ D' -e '/corrupt:/ D'
+          -e '/lazy refcounts:/ D' -e '/corrupt:/ D' -e '/^\s*data file/=
 D' \
+          -e 's#image: json:.*#image: json:{ /* filtered */ }#'
=20
=20
 # success, all done
diff --git a/tests/qemu-iotests/198.out b/tests/qemu-iotests/198.out
index e86b175e39..831ce3a289 100644
--- a/tests/qemu-iotests/198.out
+++ b/tests/qemu-iotests/198.out
@@ -32,7 +32,7 @@ read 16777216/16777216 bytes at offset 0
 16 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
=20
 =3D=3D checking image base =3D=3D
-image: json:{"encrypt.key-secret": "sec0", "driver": "IMGFMT", "file": {=
"driver": "file", "filename": "TEST_DIR/t.IMGFMT.base"}}
+image: json:{ /* filtered */ }
 file format: IMGFMT
 virtual size: 16 MiB (16777216 bytes)
 Format specific information:
@@ -74,7 +74,7 @@ Format specific information:
         master key iters: 1024
=20
 =3D=3D checking image layer =3D=3D
-image: json:{"encrypt.key-secret": "sec1", "driver": "IMGFMT", "file": {=
"driver": "file", "filename": "TEST_DIR/t.IMGFMT"}}
+image: json:{ /* filtered */ }
 file format: IMGFMT
 virtual size: 16 MiB (16777216 bytes)
 backing file: TEST_DIR/t.IMGFMT.base
--=20
2.21.0


