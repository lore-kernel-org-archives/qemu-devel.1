Return-Path: <SRS0=6OCO=YI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC282C10F14
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 14:38:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CDEE20854
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 14:38:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CDEE20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47050 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKNy2-0000RH-5e
	for qemu-devel@archiver.kernel.org; Tue, 15 Oct 2019 10:38:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35895)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iKNnk-0006d5-1x
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 10:27:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iKNnh-0008Nv-Kd
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 10:27:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37664)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iKNne-0008LS-NK; Tue, 15 Oct 2019 10:27:46 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id EC8FBC054C52;
 Tue, 15 Oct 2019 14:27:45 +0000 (UTC)
Received: from localhost (ovpn-117-226.ams2.redhat.com [10.36.117.226])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 64DB119C58;
 Tue, 15 Oct 2019 14:27:45 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 05/21] iotests: Replace IMGOPTS by _unsupported_imgopts
Date: Tue, 15 Oct 2019 16:27:13 +0200
Message-Id: <20191015142729.18123-6-mreitz@redhat.com>
In-Reply-To: <20191015142729.18123-1-mreitz@redhat.com>
References: <20191015142729.18123-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Tue, 15 Oct 2019 14:27:45 +0000 (UTC)
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

Some tests require compat=3D1.1 and thus set IMGOPTS=3D'compat=3D1.1'
globally.  That is not how it should be done; instead, they should
simply set _unsupported_imgopts to compat=3D0.10 (compat=3D1.1 is the
default anyway).

This makes the tests heed user-specified $IMGOPTS.  Some do not work
with all image options, though, so we need to disable them accordingly.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/036 | 3 +--
 tests/qemu-iotests/060 | 4 ++--
 tests/qemu-iotests/062 | 3 ++-
 tests/qemu-iotests/066 | 3 ++-
 tests/qemu-iotests/068 | 3 ++-
 tests/qemu-iotests/098 | 4 ++--
 6 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/tests/qemu-iotests/036 b/tests/qemu-iotests/036
index 5f929ad3be..bbaf0ef45b 100755
--- a/tests/qemu-iotests/036
+++ b/tests/qemu-iotests/036
@@ -43,9 +43,8 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 # This tests qcow2-specific low-level functionality
 _supported_fmt qcow2
 _supported_proto file
-
 # Only qcow2v3 and later supports feature bits
-IMGOPTS=3D"compat=3D1.1"
+_unsupported_imgopts 'compat=3D0.10'
=20
 echo
 echo =3D=3D=3D Image with unknown incompatible feature bit =3D=3D=3D
diff --git a/tests/qemu-iotests/060 b/tests/qemu-iotests/060
index b91d8321bb..9c2ef42522 100755
--- a/tests/qemu-iotests/060
+++ b/tests/qemu-iotests/060
@@ -48,6 +48,8 @@ _filter_io_error()
 _supported_fmt qcow2
 _supported_proto file
 _supported_os Linux
+# These tests only work for compat=3D1.1 images with refcount_bits=3D16
+_unsupported_imgopts 'compat=3D0.10' 'refcount_bits=3D\([^1]\|.\([^6]\|$=
\)\)'
=20
 rt_offset=3D65536  # 0x10000 (XXX: just an assumption)
 rb_offset=3D131072 # 0x20000 (XXX: just an assumption)
@@ -55,8 +57,6 @@ l1_offset=3D196608 # 0x30000 (XXX: just an assumption)
 l2_offset=3D262144 # 0x40000 (XXX: just an assumption)
 l2_offset_after_snapshot=3D524288 # 0x80000 (XXX: just an assumption)
=20
-IMGOPTS=3D"compat=3D1.1"
-
 OPEN_RW=3D"open -o overlap-check=3Dall $TEST_IMG"
 # Overlap checks are done before write operations only, therefore openin=
g an
 # image read-only makes the overlap-check option irrelevant
diff --git a/tests/qemu-iotests/062 b/tests/qemu-iotests/062
index d5f818fcce..ac0d2a9a3b 100755
--- a/tests/qemu-iotests/062
+++ b/tests/qemu-iotests/062
@@ -40,8 +40,9 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 # This tests qocw2-specific low-level functionality
 _supported_fmt qcow2
 _supported_proto generic
+# We need zero clusters and snapshots
+_unsupported_imgopts 'compat=3D0.10' 'refcount_bits=3D1[^0-9]'
=20
-IMGOPTS=3D"compat=3D1.1"
 IMG_SIZE=3D64M
=20
 echo
diff --git a/tests/qemu-iotests/066 b/tests/qemu-iotests/066
index 28f8c98412..00eb80d89e 100755
--- a/tests/qemu-iotests/066
+++ b/tests/qemu-iotests/066
@@ -39,9 +39,10 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 # This tests qocw2-specific low-level functionality
 _supported_fmt qcow2
 _supported_proto generic
+# We need zero clusters and snapshots
+_unsupported_imgopts 'compat=3D0.10' 'refcount_bits=3D1[^0-9]'
=20
 # Intentionally create an unaligned image
-IMGOPTS=3D"compat=3D1.1"
 IMG_SIZE=3D$((64 * 1024 * 1024 + 512))
=20
 echo
diff --git a/tests/qemu-iotests/068 b/tests/qemu-iotests/068
index 22f5ca3ba6..65650fca9a 100755
--- a/tests/qemu-iotests/068
+++ b/tests/qemu-iotests/068
@@ -39,8 +39,9 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 # This tests qocw2-specific low-level functionality
 _supported_fmt qcow2
 _supported_proto generic
+# Internal snapshots are (currently) impossible with refcount_bits=3D1
+_unsupported_imgopts 'compat=3D0.10' 'refcount_bits=3D1[^0-9]'
=20
-IMGOPTS=3D"compat=3D1.1"
 IMG_SIZE=3D128K
=20
 case "$QEMU_DEFAULT_MACHINE" in
diff --git a/tests/qemu-iotests/098 b/tests/qemu-iotests/098
index 1c1d1c468f..700068b328 100755
--- a/tests/qemu-iotests/098
+++ b/tests/qemu-iotests/098
@@ -40,8 +40,8 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
=20
 _supported_fmt qcow2
 _supported_proto file
-
-IMGOPTS=3D"compat=3D1.1"
+# The code path we want to test here only works for compat=3D1.1 images
+_unsupported_imgopts 'compat=3D0.10'
=20
 for event in l1_update empty_image_prepare reftable_update refblock_allo=
c; do
=20
--=20
2.21.0


