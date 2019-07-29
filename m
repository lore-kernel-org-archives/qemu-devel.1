Return-Path: <SRS0=7VQp=V2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64B21C41514
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 21:37:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3ABE221655
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 21:37:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3ABE221655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56564 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsDKS-0001Hc-He
	for qemu-devel@archiver.kernel.org; Mon, 29 Jul 2019 17:37:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59892)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jsnow@redhat.com>) id 1hsDJS-0008RD-3h
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 17:36:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1hsDJQ-0000Qj-IB
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 17:36:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45040)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>)
 id 1hsDJN-0000Hk-M0; Mon, 29 Jul 2019 17:36:05 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 087E92DE09;
 Mon, 29 Jul 2019 21:36:05 +0000 (UTC)
Received: from probe.bos.redhat.com (dhcp-17-74.bos.redhat.com [10.18.17.74])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4CEEE60461;
 Mon, 29 Jul 2019 21:36:04 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Date: Mon, 29 Jul 2019 17:35:58 -0400
Message-Id: <20190729213559.20913-3-jsnow@redhat.com>
In-Reply-To: <20190729213559.20913-1-jsnow@redhat.com>
References: <20190729213559.20913-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Mon, 29 Jul 2019 21:36:05 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 2/3] iotests: add protocol support to
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
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 ehabkost@redhat.com, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This will add supported_protocols and unsupported_protocols to all of
iotests.main, iotests.script_main, and iotests.script_initialize.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 tests/qemu-iotests/207        | 4 ++--
 tests/qemu-iotests/210        | 4 ++--
 tests/qemu-iotests/211        | 4 ++--
 tests/qemu-iotests/212        | 4 ++--
 tests/qemu-iotests/213        | 4 ++--
 tests/qemu-iotests/iotests.py | 5 ++++-
 6 files changed, 14 insertions(+), 11 deletions(-)

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
diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.p=
y
index 0229ffee0e..d15260e5ad 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -909,7 +909,9 @@ def execute_unittest(debug=3DFalse):
 def execute_setup_common(supported_fmts=3D[],
                          supported_oses=3D['linux'],
                          supported_cache_modes=3D[],
-                         unsupported_fmts=3D[]):
+                         unsupported_fmts=3D[],
+                         supported_protocols=3D[],
+                         unsupported_protocols=3D[]):
     """
     Perform necessary setup for either script-style or unittest-style te=
sts.
     """
@@ -925,6 +927,7 @@ def execute_setup_common(supported_fmts=3D[],
     verify_image_format(supported_fmts, unsupported_fmts)
     verify_platform(supported_oses)
     verify_cache_mode(supported_cache_modes)
+    verify_protocol(supported_protocols, unsupported_protocols)
=20
     debug =3D '-d' in sys.argv
     if debug:
--=20
2.21.0


