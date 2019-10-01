Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22429C352AA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 20:02:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE4282133F
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 20:02:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE4282133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47646 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFOLt-0008VR-Ls
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 16:02:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54205)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iFO7o-0004b2-0x
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 15:47:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iFO7m-0007sQ-J6
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 15:47:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52918)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iFO7h-0007l0-7X; Tue, 01 Oct 2019 15:47:49 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3226F30842AF;
 Tue,  1 Oct 2019 19:47:48 +0000 (UTC)
Received: from localhost (unknown [10.40.205.251])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B924919C6A;
 Tue,  1 Oct 2019 19:47:47 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 13/67] iotests/242: Hide refcount bit information
Date: Tue,  1 Oct 2019 21:46:21 +0200
Message-Id: <20191001194715.2796-14-mreitz@redhat.com>
In-Reply-To: <20191001194715.2796-1-mreitz@redhat.com>
References: <20191001194715.2796-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Tue, 01 Oct 2019 19:47:48 +0000 (UTC)
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

It does not matter, and this lets the test work with different refcount
widths.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/242     | 6 +++---
 tests/qemu-iotests/242.out | 5 -----
 2 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/tests/qemu-iotests/242 b/tests/qemu-iotests/242
index 7c2685b4cc..21f69a0d2c 100755
--- a/tests/qemu-iotests/242
+++ b/tests/qemu-iotests/242
@@ -35,7 +35,7 @@ flag_offset =3D 0x5000f
=20
 def print_bitmap(extra_args):
     log('qemu-img info dump:\n')
-    img_info_log(disk, extra_args=3Dextra_args)
+    img_info_log(disk, extra_args=3Dextra_args, hide_fields=3D['refcount=
 bits'])
     result =3D json.loads(qemu_img_pipe('info', '--force-share',
                                       '--output=3Djson', disk))
     if 'bitmaps' in result['format-specific']['data']:
@@ -98,9 +98,9 @@ add_bitmap(1, True, False)
 log('Write an unknown bitmap flag \'{}\' into a new QCOW2 image at offse=
t {}'
     .format(hex(bitmap_flag_unknown), flag_offset))
 toggle_flag(flag_offset)
-img_info_log(disk)
+img_info_log(disk, hide_fields=3D['refcount bits'])
 toggle_flag(flag_offset)
 log('Unset the unknown bitmap flag \'{}\' in the bitmap directory entry:=
\n'
     .format(hex(bitmap_flag_unknown)))
-img_info_log(disk)
+img_info_log(disk, hide_fields=3D['refcount bits'])
 log('Test complete')
diff --git a/tests/qemu-iotests/242.out b/tests/qemu-iotests/242.out
index 7ac8404d11..112b389241 100644
--- a/tests/qemu-iotests/242.out
+++ b/tests/qemu-iotests/242.out
@@ -13,7 +13,6 @@ cluster_size: 65536
 Format specific information:
     compat: 1.1
     lazy refcounts: false
-    refcount bits: 16
     corrupt: false
=20
 No bitmap in JSON format output
@@ -38,7 +37,6 @@ Format specific information:
             flags:
             name: bitmap-1
             granularity: 32768
-    refcount bits: 16
     corrupt: false
=20
 The same bitmaps in JSON format:
@@ -75,7 +73,6 @@ Format specific information:
                 [0]: auto
             name: bitmap-2
             granularity: 65536
-    refcount bits: 16
     corrupt: false
=20
 The same bitmaps in JSON format:
@@ -117,7 +114,6 @@ Format specific information:
                 [1]: auto
             name: bitmap-2
             granularity: 65536
-    refcount bits: 16
     corrupt: false
=20
 The same bitmaps in JSON format:
@@ -160,7 +156,6 @@ Format specific information:
                 [0]: auto
             name: bitmap-0
             granularity: 16384
-    refcount bits: 16
     corrupt: false
=20
 Test complete
--=20
2.21.0


