Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95885C33C8C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 14:55:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E47D2075A
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 14:55:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hHkDgngk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E47D2075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52970 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioTnJ-0006PW-UQ
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 09:55:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43550)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1ioTau-0006FO-KX
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 09:43:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1ioTat-0000CW-3H
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 09:43:00 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41117
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1ioTas-0000CG-W0
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 09:42:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578321778;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W0W6tNZ0LA7meTysDEAPtVwA/q4/ZNpLhybH76WkG28=;
 b=hHkDgngktW8ortgYuTVPSND+WxTlg/gEtAYtfHGKiPw5ByivsXAFcWU2COVrFaP/K7bJtv
 pQ3L5Q/s5cO2ApkCt4Rou/gawJgX0aljrR2UQ/XItmoCZ1n8bDVLQ3LqMir774ZmwSCfP8
 5Q16vRt1W/k4YDYEuOu0QfVxD2y4Y0w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-158-4iNOI0GwNm6fBQEOSqdQLA-1; Mon, 06 Jan 2020 09:42:57 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DCEF7132F3B;
 Mon,  6 Jan 2020 14:42:55 +0000 (UTC)
Received: from localhost (ovpn-117-91.ams2.redhat.com [10.36.117.91])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7B12160C88;
 Mon,  6 Jan 2020 14:42:55 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 13/34] iotests: Replace IMGOPTS by _unsupported_imgopts
Date: Mon,  6 Jan 2020 15:41:45 +0100
Message-Id: <20200106144206.698920-14-mreitz@redhat.com>
In-Reply-To: <20200106144206.698920-1-mreitz@redhat.com>
References: <20200106144206.698920-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: 4iNOI0GwNm6fBQEOSqdQLA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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

Some tests require compat=3D1.1 and thus set IMGOPTS=3D'compat=3D1.1'
globally.  That is not how it should be done; instead, they should
simply set _unsupported_imgopts to compat=3D0.10 (compat=3D1.1 is the
default anyway).

This makes the tests heed user-specified $IMGOPTS.  Some do not work
with all image options, though, so we need to disable them accordingly.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Maxim Levitsky <mlevitsky@redhat.com>
Message-id: 20191107163708.833192-7-mreitz@redhat.com
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
index 7439be894b..932bc2f3f9 100755
--- a/tests/qemu-iotests/060
+++ b/tests/qemu-iotests/060
@@ -48,6 +48,8 @@ _filter_io_error()
 _supported_fmt qcow2
 _supported_proto file
 _supported_os Linux
+# These tests only work for compat=3D1.1 images with refcount_bits=3D16
+_unsupported_imgopts 'compat=3D0.10' 'refcount_bits=3D\([^1]\|.\([^6]\|$\)=
\)'
=20
 # The repair process will create a large file - so check for availability =
first
 _require_large_file 64G
@@ -58,8 +60,6 @@ l1_offset=3D196608 # 0x30000 (XXX: just an assumption)
 l2_offset=3D262144 # 0x40000 (XXX: just an assumption)
 l2_offset_after_snapshot=3D524288 # 0x80000 (XXX: just an assumption)
=20
-IMGOPTS=3D"compat=3D1.1"
-
 OPEN_RW=3D"open -o overlap-check=3Dall $TEST_IMG"
 # Overlap checks are done before write operations only, therefore opening =
an
 # image read-only makes the overlap-check option irrelevant
diff --git a/tests/qemu-iotests/062 b/tests/qemu-iotests/062
index 79738b1c26..0df8667e5a 100755
--- a/tests/qemu-iotests/062
+++ b/tests/qemu-iotests/062
@@ -40,8 +40,9 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 # This tests qcow2-specific low-level functionality
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
index cacbdb6ae0..71e8df598a 100755
--- a/tests/qemu-iotests/066
+++ b/tests/qemu-iotests/066
@@ -39,9 +39,10 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 # This tests qcow2-specific low-level functionality
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
index c164ccc64a..fe9d7ae1be 100755
--- a/tests/qemu-iotests/068
+++ b/tests/qemu-iotests/068
@@ -39,8 +39,9 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 # This tests qcow2-specific low-level functionality
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
 for event in l1_update empty_image_prepare reftable_update refblock_alloc;=
 do
=20
--=20
2.24.1


