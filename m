Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7819C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 10:12:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1C3520757
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 10:12:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eIp4tgrP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1C3520757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53148 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKJJM-00082L-SF
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 06:12:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35041)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jKJIb-00076C-Nb
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 06:11:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1jKJIa-0003aE-Gd
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 06:11:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51969
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1jKJIa-0003ZJ-CB
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 06:11:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585908700;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=SM9raZenXC6EQiQs7eo5tdMZnZYHcSBHvBwpQLuDCU4=;
 b=eIp4tgrPh9BDHS29IsrRRuDjO5gwj+82A67/vqYdEJioxI88A3EmzR2OaL7/T4WlWArUcg
 6eNEwaX+TmigUhYAOjFka1UPk8PzQptRTBRhOKj8EYh51DYRUJtPACjVB6MvffsXwujJDM
 dmdMbq66AUm3hRmq00jAsOorys2fp64=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-345-XzBzykFgMXy2Zj8qGpbmzg-1; Fri, 03 Apr 2020 06:11:38 -0400
X-MC-Unique: XzBzykFgMXy2Zj8qGpbmzg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 69E7B477;
 Fri,  3 Apr 2020 10:11:37 +0000 (UTC)
Received: from localhost (ovpn-113-97.ams2.redhat.com [10.36.113.97])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D388760BF1;
 Fri,  3 Apr 2020 10:11:36 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH] iotests/common.pattern: Quote echos
Date: Fri,  3 Apr 2020 12:11:34 +0200
Message-Id: <20200403101134.805871-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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

From time to time, my shell decides to repace the bracketed numbers here
by the numbers inside (i.e., "=3D=3D=3D Clusters to be compressed [1]" is
printed as "=3D=3D=3D Clusters to be compressed 1").  That makes tests that
use common.pattern fail.  Prevent that from happening by quoting the
arguments to all echos in common.pattern.

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


