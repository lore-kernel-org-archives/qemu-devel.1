Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACC06C2BB1D
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 12:40:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 756FF20719
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 12:40:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jDN9ytwX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 756FF20719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46738 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLnWt-0003Vl-K6
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 08:40:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34720)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jLnUB-0007Xt-Ai
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 08:37:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1jLnUA-0006nK-7J
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 08:37:47 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:25272
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1jLnUA-0006l5-1p
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 08:37:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586263063;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P9sMMcwTn/qfPhGYjkb+FTpCQd50xWJGCzLtpVpetcw=;
 b=jDN9ytwXR6CNEYaKdiT3IuHhdxEaHsxJ3dAypUWOYG/7r/vP76clTgpi33NVRCPbYF4gXO
 texVjFOKSoymdZEmqZTnKDKN/K/dRG8d8XSPX5yH0Mcd5YxQ/xJYyxGIrJrnsFOdgAdxkw
 tJUVJmYCbzimTJTWgfXTfRbMyDdWeK0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-392-9JvTchx-MiOWMdobkPiW8w-1; Tue, 07 Apr 2020 08:37:41 -0400
X-MC-Unique: 9JvTchx-MiOWMdobkPiW8w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B6FE01B18BC6;
 Tue,  7 Apr 2020 12:37:40 +0000 (UTC)
Received: from localhost (ovpn-114-84.ams2.redhat.com [10.36.114.84])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 340AC5DA7C;
 Tue,  7 Apr 2020 12:37:40 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 4/5] iotests/common.pattern: Quote echos
Date: Tue,  7 Apr 2020 14:37:26 +0200
Message-Id: <20200407123727.829933-5-mreitz@redhat.com>
In-Reply-To: <20200407123727.829933-1-mreitz@redhat.com>
References: <20200407123727.829933-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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

From time to time, my shell decides to repace the bracketed numbers here
by the numbers inside (i.e., "=3D=3D=3D Clusters to be compressed [1]" is
printed as "=3D=3D=3D Clusters to be compressed 1").  That makes tests that
use common.pattern fail.  Prevent that from happening by quoting the
arguments to all echos in common.pattern.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Message-Id: <20200403101134.805871-1-mreitz@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/common.pattern | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/tests/qemu-iotests/common.pattern b/tests/qemu-iotests/common.=
pattern
index 4f5e5bcea0..4caa5de187 100644
--- a/tests/qemu-iotests/common.pattern
+++ b/tests/qemu-iotests/common.pattern
@@ -23,7 +23,7 @@ do_is_allocated() {
     local count=3D$4
=20
     for ((i=3D1;i<=3D$count;i++)); do
-        echo alloc $(( start + (i - 1) * step )) $size
+        echo "alloc $(( start + (i - 1) * step )) $size"
     done
 }
=20
@@ -39,9 +39,9 @@ do_io() {
     local count=3D$5
     local pattern=3D$6
=20
-    echo =3D=3D=3D IO: pattern $pattern >&2
+    echo "=3D=3D=3D IO: pattern $pattern" >&2
     for ((i=3D1;i<=3D$count;i++)); do
-        echo $op -P $pattern $(( start + (i - 1) * step )) $size
+        echo "$op -P $pattern $(( start + (i - 1) * step )) $size"
     done
 }
=20
@@ -110,31 +110,31 @@ io_test2() {
     #        free - free - compressed
=20
     # Write the clusters to be compressed
-    echo =3D=3D=3D Clusters to be compressed [1]
+    echo '=3D=3D=3D Clusters to be compressed [1]'
     io_pattern writev $((offset + 4 * $cluster_size)) $cluster_size $((9 *=
 $cluster_size)) $num 165
-    echo =3D=3D=3D Clusters to be compressed [2]
+    echo '=3D=3D=3D Clusters to be compressed [2]'
     io_pattern writev $((offset + 5 * $cluster_size)) $cluster_size $((9 *=
 $cluster_size)) $num 165
-    echo =3D=3D=3D Clusters to be compressed [3]
+    echo '=3D=3D=3D Clusters to be compressed [3]'
     io_pattern writev $((offset + 8 * $cluster_size)) $cluster_size $((9 *=
 $cluster_size)) $num 165
=20
     mv "$TEST_IMG" "$TEST_IMG.orig"
     $QEMU_IMG convert -f $IMGFMT -O $IMGFMT -c "$TEST_IMG.orig" "$TEST_IMG=
"
=20
     # Write the used clusters
-    echo =3D=3D=3D Used clusters [1]
+    echo '=3D=3D=3D Used clusters [1]'
     io_pattern writev $((offset + 0 * $cluster_size)) $cluster_size $((9 *=
 $cluster_size)) $num 165
-    echo =3D=3D=3D Used clusters [2]
+    echo '=3D=3D=3D Used clusters [2]'
     io_pattern writev $((offset + 1 * $cluster_size)) $cluster_size $((9 *=
 $cluster_size)) $num 165
-    echo =3D=3D=3D Used clusters [3]
+    echo '=3D=3D=3D Used clusters [3]'
     io_pattern writev $((offset + 3 * $cluster_size)) $cluster_size $((9 *=
 $cluster_size)) $num 165
=20
     # Read them
-    echo =3D=3D=3D Read used/compressed clusters
+    echo '=3D=3D=3D Read used/compressed clusters'
     io_pattern readv $((offset + 0 * $cluster_size)) $((2 * $cluster_size)=
) $((9 * $cluster_size)) $num 165
     io_pattern readv $((offset + 3 * $cluster_size)) $((3 * $cluster_size)=
) $((9 * $cluster_size)) $num 165
     io_pattern readv $((offset + 8 * $cluster_size)) $((1 * $cluster_size)=
) $((9 * $cluster_size)) $num 165
=20
-    echo =3D=3D=3D Read zeros
+    echo '=3D=3D=3D Read zeros'
     io_zero readv $((offset + 2 * $cluster_size)) $((1 * $cluster_size)) $=
((9 * $cluster_size)) $num
     io_zero readv $((offset + 6 * $cluster_size)) $((2 * $cluster_size)) $=
((9 * $cluster_size)) $num
 }
--=20
2.25.1


