Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E41E0C4CECD
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 23:49:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B425A216C8
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 23:49:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B425A216C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53620 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iANDb-0000yC-VN
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 19:49:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52836)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1iANAX-000730-OA
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 19:46:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1iANAW-0003ng-Fr
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 19:46:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43074)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>)
 id 1iANAT-0003lj-Js; Tue, 17 Sep 2019 19:45:57 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id BFA363083362;
 Tue, 17 Sep 2019 23:45:56 +0000 (UTC)
Received: from probe.bos.redhat.com (dhcp-17-165.bos.redhat.com [10.18.17.165])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 198CC600C4;
 Tue, 17 Sep 2019 23:45:56 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 17 Sep 2019 19:45:48 -0400
Message-Id: <20190917234549.22910-5-jsnow@redhat.com>
In-Reply-To: <20190917234549.22910-1-jsnow@redhat.com>
References: <20190917234549.22910-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Tue, 17 Sep 2019 23:45:57 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v5 4/5] iotests: specify protocol support via
 initialization info
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 John Snow <jsnow@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Any one of the iotests.main, iotests.script_main, or
iotests.script_initialize functions can specify verify_protocols.

Remove the last users of calling the function individually.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 tests/qemu-iotests/207 | 4 ++--
 tests/qemu-iotests/210 | 4 ++--
 tests/qemu-iotests/211 | 4 ++--
 tests/qemu-iotests/212 | 4 ++--
 tests/qemu-iotests/213 | 4 ++--
 5 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/tests/qemu-iotests/207 b/tests/qemu-iotests/207
index ab9e3b6747..35d98f2736 100755
--- a/tests/qemu-iotests/207
+++ b/tests/qemu-iotests/207
@@ -24,8 +24,8 @@ import iotests
 import subprocess
 import re
=20
-iotests.script_initialize(supported_fmts=3D['raw'])
-iotests.verify_protocol(supported=3D['ssh'])
+iotests.script_initialize(supported_fmts=3D['raw'],
+                          supported_protocols=3D['ssh'])
=20
 def filter_hash(qmsg):
     def _filter(key, value):
diff --git a/tests/qemu-iotests/210 b/tests/qemu-iotests/210
index 5a7013cd34..d9fe780c07 100755
--- a/tests/qemu-iotests/210
+++ b/tests/qemu-iotests/210
@@ -23,8 +23,8 @@
 import iotests
 from iotests import imgfmt
=20
-iotests.script_initialize(supported_fmts=3D['luks'])
-iotests.verify_protocol(supported=3D['file'])
+iotests.script_initialize(supported_fmts=3D['luks'],
+                          supported_protocols=3D['file'])
=20
 def blockdev_create(vm, options):
     result =3D vm.qmp_log('blockdev-create', job_id=3D'job0', options=3D=
options,
diff --git a/tests/qemu-iotests/211 b/tests/qemu-iotests/211
index 4d6aac497f..155fac4e87 100755
--- a/tests/qemu-iotests/211
+++ b/tests/qemu-iotests/211
@@ -23,8 +23,8 @@
 import iotests
 from iotests import imgfmt
=20
-iotests.script_initialize(supported_fmts=3D['vdi'])
-iotests.verify_protocol(supported=3D['file'])
+iotests.script_initialize(supported_fmts=3D['vdi'],
+                          supported_protocols=3D['file'])
=20
 def blockdev_create(vm, options):
     result =3D vm.qmp_log('blockdev-create', job_id=3D'job0', options=3D=
options,
diff --git a/tests/qemu-iotests/212 b/tests/qemu-iotests/212
index ec35bceb11..67e5a1dbb5 100755
--- a/tests/qemu-iotests/212
+++ b/tests/qemu-iotests/212
@@ -23,8 +23,8 @@
 import iotests
 from iotests import imgfmt
=20
-iotests.script_initialize(supported_fmts=3D['parallels'])
-iotests.verify_protocol(supported=3D['file'])
+iotests.script_initialize(supported_fmts=3D['parallels'],
+                          supported_protocols=3D['file'])
=20
 def blockdev_create(vm, options):
     result =3D vm.qmp_log('blockdev-create', job_id=3D'job0', options=3D=
options,
diff --git a/tests/qemu-iotests/213 b/tests/qemu-iotests/213
index 3d2c024375..23f387ab63 100755
--- a/tests/qemu-iotests/213
+++ b/tests/qemu-iotests/213
@@ -23,8 +23,8 @@
 import iotests
 from iotests import imgfmt
=20
-iotests.script_initialize(supported_fmts=3D['vhdx'])
-iotests.verify_protocol(supported=3D['file'])
+iotests.script_initialize(supported_fmts=3D['vhdx'],
+                          supported_protocols=3D['file'])
=20
 def blockdev_create(vm, options):
     result =3D vm.qmp_log('blockdev-create', job_id=3D'job0', options=3D=
options,
--=20
2.21.0


