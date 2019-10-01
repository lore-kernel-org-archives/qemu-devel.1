Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DBB5ECE587
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 20:07:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 055632133F
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 20:07:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 055632133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47692 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFOQR-0003zs-FP
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 16:07:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54204)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iFO7o-0004b1-2f
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 15:47:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iFO7m-0007s7-DX
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 15:47:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57178)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iFO7g-0007kF-NA; Tue, 01 Oct 2019 15:47:48 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D53CD3082149;
 Tue,  1 Oct 2019 19:47:45 +0000 (UTC)
Received: from localhost (unknown [10.40.205.251])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6F843100197A;
 Tue,  1 Oct 2019 19:47:45 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 12/67] iotests/228: Filter json:{} filenames
Date: Tue,  1 Oct 2019 21:46:20 +0200
Message-Id: <20191001194715.2796-13-mreitz@redhat.com>
In-Reply-To: <20191001194715.2796-1-mreitz@redhat.com>
References: <20191001194715.2796-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Tue, 01 Oct 2019 19:47:45 +0000 (UTC)
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

We only care about where we get json:{} filenames (and what the
non-json:{} filenames look like), but not about how the json:{}
filenames look.

Filter them so we will not get a different output for qcow2 images with
external data files.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/228     | 8 ++++----
 tests/qemu-iotests/228.out | 8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/tests/qemu-iotests/228 b/tests/qemu-iotests/228
index 9785868ab3..e507db4f27 100755
--- a/tests/qemu-iotests/228
+++ b/tests/qemu-iotests/228
@@ -22,7 +22,7 @@
=20
 import iotests
 from iotests import log, qemu_img, filter_testfiles, filter_imgfmt, \
-        filter_qmp_testfiles, filter_qmp_imgfmt
+        filter_qmp_testfiles, filter_qmp_imgfmt, filter_json_filename
=20
 # Need backing file and change-backing-file support
 iotests.script_initialize(supported_fmts=3D['qcow2', 'qed'])
@@ -32,14 +32,14 @@ def log_node_info(node):
     log('')
=20
     log('bs->filename: ' + node['image']['filename'],
-        filters=3D[filter_testfiles, filter_imgfmt])
+        filters=3D[filter_testfiles, filter_imgfmt, filter_json_filename=
])
     log('bs->backing_file: ' + node['backing_file'],
-        filters=3D[filter_testfiles, filter_imgfmt])
+        filters=3D[filter_testfiles, filter_imgfmt, filter_json_filename=
])
=20
     if 'backing-image' in node['image']:
         log('bs->backing->bs->filename: ' +
             node['image']['backing-image']['filename'],
-            filters=3D[filter_testfiles, filter_imgfmt])
+            filters=3D[filter_testfiles, filter_imgfmt, filter_json_file=
name])
     else:
         log('bs->backing: (none)')
=20
diff --git a/tests/qemu-iotests/228.out b/tests/qemu-iotests/228.out
index 4217df24fe..f8155019d5 100644
--- a/tests/qemu-iotests/228.out
+++ b/tests/qemu-iotests/228.out
@@ -17,7 +17,7 @@ bs->backing->bs->filename: TEST_DIR/PID-base.img
 {"execute": "change-backing-file", "arguments": {"backing-file": "null-c=
o://", "device": "node0", "image-node-name": "node0"}}
 {"return": {}}
=20
-bs->filename: json:{"backing": {"driver": "IMGFMT", "file": {"driver": "=
file", "filename": "TEST_DIR/PID-base.img"}}, "driver": "IMGFMT", "file":=
 {"driver": "file", "filename": "TEST_DIR/PID-top.img"}}
+bs->filename: json:{ /* filtered */ }
 bs->backing_file: null-co://
 bs->backing->bs->filename: TEST_DIR/PID-base.img
=20
@@ -31,7 +31,7 @@ bs->backing->bs->filename: TEST_DIR/PID-base.img
 {"execute": "change-backing-file", "arguments": {"backing-file": "file:T=
EST_DIR/PID-base.img", "device": "node0", "image-node-name": "node0"}}
 {"return": {}}
=20
-bs->filename: json:{"backing": {"driver": "IMGFMT", "file": {"driver": "=
file", "filename": "TEST_DIR/PID-base.img"}}, "driver": "IMGFMT", "file":=
 {"driver": "file", "filename": "TEST_DIR/PID-top.img"}}
+bs->filename: json:{ /* filtered */ }
 bs->backing_file: file:TEST_DIR/PID-base.img
 bs->backing->bs->filename: TEST_DIR/PID-base.img
=20
@@ -54,7 +54,7 @@ bs->backing->bs->filename: TEST_DIR/PID-base.img
 {"execute": "blockdev-add", "arguments": {"backing": "null", "driver": "=
IMGFMT", "file": {"driver": "file", "filename": "TEST_DIR/PID-top.img"}, =
"node-name": "node0"}}
 {"return": {}}
=20
-bs->filename: json:{"backing": {"driver": "null-co"}, "driver": "IMGFMT"=
, "file": {"driver": "file", "filename": "TEST_DIR/PID-top.img"}}
+bs->filename: json:{ /* filtered */ }
 bs->backing_file: null-co://
 bs->backing->bs->filename: null-co://
=20
@@ -65,7 +65,7 @@ bs->backing->bs->filename: null-co://
 {"execute": "blockdev-add", "arguments": {"backing": null, "driver": "IM=
GFMT", "file": {"driver": "file", "filename": "TEST_DIR/PID-top.img"}, "n=
ode-name": "node0"}}
 {"return": {}}
=20
-bs->filename: json:{"backing": null, "driver": "IMGFMT", "file": {"drive=
r": "file", "filename": "TEST_DIR/PID-top.img"}}
+bs->filename: json:{ /* filtered */ }
 bs->backing_file: TEST_DIR/PID-base.img
 bs->backing: (none)
=20
--=20
2.21.0


