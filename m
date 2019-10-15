Return-Path: <SRS0=6OCO=YI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01491ECE588
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 14:42:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9D8F20854
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 14:42:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9D8F20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47080 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKO1p-00050e-CU
	for qemu-devel@archiver.kernel.org; Tue, 15 Oct 2019 10:42:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36532)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iKNoN-0007LI-Ab
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 10:28:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iKNoM-0000Ld-27
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 10:28:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60106)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iKNoJ-0000Jx-JF; Tue, 15 Oct 2019 10:28:27 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id CAB79309DEE9;
 Tue, 15 Oct 2019 14:28:26 +0000 (UTC)
Received: from localhost (ovpn-117-226.ams2.redhat.com [10.36.117.226])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6E872104812F;
 Tue, 15 Oct 2019 14:28:26 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 19/21] iotests: Make 198 work with data_file
Date: Tue, 15 Oct 2019 16:27:27 +0200
Message-Id: <20191015142729.18123-20-mreitz@redhat.com>
In-Reply-To: <20191015142729.18123-1-mreitz@redhat.com>
References: <20191015142729.18123-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Tue, 15 Oct 2019 14:28:26 +0000 (UTC)
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
Cc: Kevin Wolf <kwolf@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
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
index c8f824cfae..fb0d5a29d3 100755
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
+    | _filter_json_filename
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
+    | _filter_json_filename
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


