Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F109FC352AA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 20:10:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C714E2133F
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 20:10:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C714E2133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47722 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFOU5-0007s6-6t
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 16:10:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54208)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iFO7o-0004b4-4U
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 15:47:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iFO7m-0007sK-Hx
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 15:47:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36219)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iFO7c-0007j5-Ne; Tue, 01 Oct 2019 15:47:46 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 913BDC04D293;
 Tue,  1 Oct 2019 19:47:43 +0000 (UTC)
Received: from localhost (unknown [10.40.205.251])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2AB731001947;
 Tue,  1 Oct 2019 19:47:42 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 11/67] iotests/224: Filter json:{} from commit command
Date: Tue,  1 Oct 2019 21:46:19 +0200
Message-Id: <20191001194715.2796-12-mreitz@redhat.com>
In-Reply-To: <20191001194715.2796-1-mreitz@redhat.com>
References: <20191001194715.2796-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Tue, 01 Oct 2019 19:47:43 +0000 (UTC)
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

We only care that block-commit works with json:{} filenames, we do not
need to see their exact values in the output.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/224     | 15 ++++++++++++---
 tests/qemu-iotests/224.out |  4 ++--
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/tests/qemu-iotests/224 b/tests/qemu-iotests/224
index d0d0c44104..e227d3ab3c 100755
--- a/tests/qemu-iotests/224
+++ b/tests/qemu-iotests/224
@@ -22,12 +22,19 @@
=20
 import iotests
 from iotests import log, qemu_img, qemu_io_silent, filter_qmp_testfiles,=
 \
-                    filter_qmp_imgfmt
+                    filter_qmp_imgfmt, filter_json_filename
 import json
+import re
=20
 # Need backing file support (for arbitrary backing formats)
 iotests.script_initialize(supported_fmts=3D['qcow2', 'qcow', 'qed'])
=20
+def filter_json_top_or_base(qmsg):
+    def _filter(key, value):
+        if key =3D=3D 'base' or key =3D=3D 'top':
+            return filter_json_filename(value)
+        return value
+    return iotests.filter_qmp(qmsg, _filter)
=20
 # There are two variations of this test:
 # (1) We do not set filter_node_name.  In that case, the commit_top
@@ -104,7 +111,8 @@ for filter_node_name in False, True:
                         top=3Dmid_name,
                         base=3Dbase_name,
                         speed=3D1,
-                        filters=3D[filter_qmp_testfiles, filter_qmp_imgf=
mt])
+                        filters=3D[filter_qmp_testfiles, filter_qmp_imgf=
mt,
+                                 filter_json_top_or_base])
         else:
             vm.qmp_log('block-commit',
                         job_id=3D'commit',
@@ -112,7 +120,8 @@ for filter_node_name in False, True:
                         top=3Dmid_name,
                         base=3Dbase_name,
                         speed=3D1,
-                        filters=3D[filter_qmp_testfiles, filter_qmp_imgf=
mt])
+                        filters=3D[filter_qmp_testfiles, filter_qmp_imgf=
mt,
+                                 filter_json_top_or_base])
=20
         vm.qmp_log('job-pause', id=3D'commit')
=20
diff --git a/tests/qemu-iotests/224.out b/tests/qemu-iotests/224.out
index 23374a1d29..287d2eac7a 100644
--- a/tests/qemu-iotests/224.out
+++ b/tests/qemu-iotests/224.out
@@ -3,7 +3,7 @@
=20
 {"execute": "blockdev-add", "arguments": {"backing": {"backing": {"backi=
ng": {"driver": "null-co"}, "driver": "IMGFMT", "file": {"driver": "file"=
, "filename": "TEST_DIR/PID-base.img"}, "node-name": "base"}, "driver": "=
IMGFMT", "file": {"driver": "file", "filename": "TEST_DIR/PID-mid.img"}, =
"node-name": "mid"}, "driver": "IMGFMT", "file": {"driver": "file", "file=
name": "TEST_DIR/PID-top.img"}, "node-name": "top"}}
 {"return": {}}
-{"execute": "block-commit", "arguments": {"base": "json:{\"backing\": {\=
"driver\": \"null-co\"}, \"driver\": \"IMGFMT\", \"file\": {\"driver\": \=
"file\", \"filename\": \"TEST_DIR/PID-base.img\"}}", "device": "top", "jo=
b-id": "commit", "speed": 1, "top": "json:{\"backing\": {\"backing\": {\"=
driver\": \"null-co\"}, \"driver\": \"IMGFMT\", \"file\": {\"driver\": \"=
file\", \"filename\": \"TEST_DIR/PID-base.img\"}}, \"driver\": \"IMGFMT\"=
, \"file\": {\"driver\": \"file\", \"filename\": \"TEST_DIR/PID-mid.img\"=
}}"}}
+{"execute": "block-commit", "arguments": {"base": "json:{ /* filtered */=
 }", "device": "top", "job-id": "commit", "speed": 1, "top": "json:{ /* f=
iltered */ }"}}
 {"return": {}}
 {"execute": "job-pause", "arguments": {"id": "commit"}}
 {"return": {}}
@@ -12,7 +12,7 @@
=20
 {"execute": "blockdev-add", "arguments": {"backing": {"backing": {"backi=
ng": {"driver": "null-co"}, "driver": "IMGFMT", "file": {"driver": "file"=
, "filename": "TEST_DIR/PID-base.img"}, "node-name": "base"}, "driver": "=
IMGFMT", "file": {"driver": "file", "filename": "TEST_DIR/PID-mid.img"}, =
"node-name": "mid"}, "driver": "IMGFMT", "file": {"driver": "file", "file=
name": "TEST_DIR/PID-top.img"}, "node-name": "top"}}
 {"return": {}}
-{"execute": "block-commit", "arguments": {"base": "json:{\"backing\": {\=
"driver\": \"null-co\"}, \"driver\": \"IMGFMT\", \"file\": {\"driver\": \=
"file\", \"filename\": \"TEST_DIR/PID-base.img\"}}", "device": "top", "fi=
lter-node-name": "filter_node", "job-id": "commit", "speed": 1, "top": "j=
son:{\"backing\": {\"backing\": {\"driver\": \"null-co\"}, \"driver\": \"=
IMGFMT\", \"file\": {\"driver\": \"file\", \"filename\": \"TEST_DIR/PID-b=
ase.img\"}}, \"driver\": \"IMGFMT\", \"file\": {\"driver\": \"file\", \"f=
ilename\": \"TEST_DIR/PID-mid.img\"}}"}}
+{"execute": "block-commit", "arguments": {"base": "json:{ /* filtered */=
 }", "device": "top", "filter-node-name": "filter_node", "job-id": "commi=
t", "speed": 1, "top": "json:{ /* filtered */ }"}}
 {"return": {}}
 {"execute": "job-pause", "arguments": {"id": "commit"}}
 {"return": {}}
--=20
2.21.0


