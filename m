Return-Path: <SRS0=r6E1=T6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08B38C28CC0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 11:05:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF197257B7
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 11:05:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF197257B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52064 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWIsF-00037I-19
	for qemu-devel@archiver.kernel.org; Thu, 30 May 2019 07:05:31 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40424)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hWIqB-0001oW-VA
	for qemu-devel@nongnu.org; Thu, 30 May 2019 07:03:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hWIqA-0003od-0y
	for qemu-devel@nongnu.org; Thu, 30 May 2019 07:03:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58568)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>)
	id 1hWIq5-0003ao-Cl; Thu, 30 May 2019 07:03:17 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EAC9330C31AA;
	Thu, 30 May 2019 11:03:11 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-116-119.ams2.redhat.com
	[10.36.116.119])
	by smtp.corp.redhat.com (Postfix) with ESMTP id EB74B6B8E0;
	Thu, 30 May 2019 11:03:08 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Date: Thu, 30 May 2019 13:02:52 +0200
Message-Id: <20190530110255.16225-4-kwolf@redhat.com>
In-Reply-To: <20190530110255.16225-1-kwolf@redhat.com>
References: <20190530110255.16225-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.40]);
	Thu, 30 May 2019 11:03:16 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v4 3/6] tests/qapi-schema: Error case tests for
 features in structs
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: kwolf@redhat.com, pkrempa@redhat.com, armbru@redhat.com,
	qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qapi-schema/features-bad-type.json       | 3 +++
 tests/qapi-schema/features-duplicate-name.json | 3 +++
 tests/qapi-schema/features-missing-name.json   | 3 +++
 tests/qapi-schema/features-name-bad-type.json  | 3 +++
 tests/qapi-schema/features-no-list.json        | 3 +++
 tests/qapi-schema/features-unknown-key.json    | 3 +++
 tests/Makefile.include                         | 6 ++++++
 tests/qapi-schema/features-bad-type.err        | 1 +
 tests/qapi-schema/features-bad-type.exit       | 1 +
 tests/qapi-schema/features-bad-type.out        | 0
 tests/qapi-schema/features-duplicate-name.err  | 1 +
 tests/qapi-schema/features-duplicate-name.exit | 1 +
 tests/qapi-schema/features-duplicate-name.out  | 0
 tests/qapi-schema/features-missing-name.err    | 1 +
 tests/qapi-schema/features-missing-name.exit   | 1 +
 tests/qapi-schema/features-missing-name.out    | 0
 tests/qapi-schema/features-name-bad-type.err   | 1 +
 tests/qapi-schema/features-name-bad-type.exit  | 1 +
 tests/qapi-schema/features-name-bad-type.out   | 0
 tests/qapi-schema/features-no-list.err         | 1 +
 tests/qapi-schema/features-no-list.exit        | 1 +
 tests/qapi-schema/features-no-list.out         | 0
 tests/qapi-schema/features-unknown-key.err     | 2 ++
 tests/qapi-schema/features-unknown-key.exit    | 1 +
 tests/qapi-schema/features-unknown-key.out     | 0
 25 files changed, 37 insertions(+)
 create mode 100644 tests/qapi-schema/features-bad-type.json
 create mode 100644 tests/qapi-schema/features-duplicate-name.json
 create mode 100644 tests/qapi-schema/features-missing-name.json
 create mode 100644 tests/qapi-schema/features-name-bad-type.json
 create mode 100644 tests/qapi-schema/features-no-list.json
 create mode 100644 tests/qapi-schema/features-unknown-key.json
 create mode 100644 tests/qapi-schema/features-bad-type.err
 create mode 100644 tests/qapi-schema/features-bad-type.exit
 create mode 100644 tests/qapi-schema/features-bad-type.out
 create mode 100644 tests/qapi-schema/features-duplicate-name.err
 create mode 100644 tests/qapi-schema/features-duplicate-name.exit
 create mode 100644 tests/qapi-schema/features-duplicate-name.out
 create mode 100644 tests/qapi-schema/features-missing-name.err
 create mode 100644 tests/qapi-schema/features-missing-name.exit
 create mode 100644 tests/qapi-schema/features-missing-name.out
 create mode 100644 tests/qapi-schema/features-name-bad-type.err
 create mode 100644 tests/qapi-schema/features-name-bad-type.exit
 create mode 100644 tests/qapi-schema/features-name-bad-type.out
 create mode 100644 tests/qapi-schema/features-no-list.err
 create mode 100644 tests/qapi-schema/features-no-list.exit
 create mode 100644 tests/qapi-schema/features-no-list.out
 create mode 100644 tests/qapi-schema/features-unknown-key.err
 create mode 100644 tests/qapi-schema/features-unknown-key.exit
 create mode 100644 tests/qapi-schema/features-unknown-key.out

diff --git a/tests/qapi-schema/features-bad-type.json b/tests/qapi-schema=
/features-bad-type.json
new file mode 100644
index 0000000000..57db5540e7
--- /dev/null
+++ b/tests/qapi-schema/features-bad-type.json
@@ -0,0 +1,3 @@
+{ 'struct': 'FeatureStruct0',
+  'data': { 'foo': 'int' },
+  'features': [ [ 'a feature cannot be an array' ] ] }
diff --git a/tests/qapi-schema/features-duplicate-name.json b/tests/qapi-=
schema/features-duplicate-name.json
new file mode 100644
index 0000000000..29358e6220
--- /dev/null
+++ b/tests/qapi-schema/features-duplicate-name.json
@@ -0,0 +1,3 @@
+{ 'struct': 'FeatureStruct0',
+  'data': { 'foo': 'int' },
+  'features': [ 'foo', 'bar', 'foo' ] }
diff --git a/tests/qapi-schema/features-missing-name.json b/tests/qapi-sc=
hema/features-missing-name.json
new file mode 100644
index 0000000000..2314f97c00
--- /dev/null
+++ b/tests/qapi-schema/features-missing-name.json
@@ -0,0 +1,3 @@
+{ 'struct': 'FeatureStruct0',
+  'data': { 'foo': 'int' },
+  'features': [ { 'if': 'defined(NAMELESS_FEATURES)' } ] }
diff --git a/tests/qapi-schema/features-name-bad-type.json b/tests/qapi-s=
chema/features-name-bad-type.json
new file mode 100644
index 0000000000..b07139978a
--- /dev/null
+++ b/tests/qapi-schema/features-name-bad-type.json
@@ -0,0 +1,3 @@
+{ 'struct': 'FeatureStruct0',
+  'data': { 'foo': 'int' },
+  'features': [ { 'name': { 'feature-type': 'object' } } ] }
diff --git a/tests/qapi-schema/features-no-list.json b/tests/qapi-schema/=
features-no-list.json
new file mode 100644
index 0000000000..9484fd94fc
--- /dev/null
+++ b/tests/qapi-schema/features-no-list.json
@@ -0,0 +1,3 @@
+{ 'struct': 'FeatureStruct0',
+  'data': { 'foo': 'int' },
+  'features': 'bar' }
diff --git a/tests/qapi-schema/features-unknown-key.json b/tests/qapi-sch=
ema/features-unknown-key.json
new file mode 100644
index 0000000000..134df3b503
--- /dev/null
+++ b/tests/qapi-schema/features-unknown-key.json
@@ -0,0 +1,3 @@
+{ 'struct': 'FeatureStruct0',
+  'data': { 'foo': 'int' },
+  'features': [ { 'name': 'bar', 'colour': 'red' } ] }
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 1865f6b322..0f6c4583c5 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -377,6 +377,12 @@ qapi-schema +=3D event-boxed-empty.json
 qapi-schema +=3D event-case.json
 qapi-schema +=3D event-member-invalid-dict.json
 qapi-schema +=3D event-nest-struct.json
+qapi-schema +=3D features-bad-type.json
+qapi-schema +=3D features-duplicate-name.json
+qapi-schema +=3D features-missing-name.json
+qapi-schema +=3D features-name-bad-type.json
+qapi-schema +=3D features-no-list.json
+qapi-schema +=3D features-unknown-key.json
 qapi-schema +=3D flat-union-array-branch.json
 qapi-schema +=3D flat-union-bad-base.json
 qapi-schema +=3D flat-union-bad-discriminator.json
diff --git a/tests/qapi-schema/features-bad-type.err b/tests/qapi-schema/=
features-bad-type.err
new file mode 100644
index 0000000000..5fb95c2f90
--- /dev/null
+++ b/tests/qapi-schema/features-bad-type.err
@@ -0,0 +1 @@
+tests/qapi-schema/features-bad-type.json:1: Feature of struct FeatureStr=
uct0 requires a string name
diff --git a/tests/qapi-schema/features-bad-type.exit b/tests/qapi-schema=
/features-bad-type.exit
new file mode 100644
index 0000000000..d00491fd7e
--- /dev/null
+++ b/tests/qapi-schema/features-bad-type.exit
@@ -0,0 +1 @@
+1
diff --git a/tests/qapi-schema/features-bad-type.out b/tests/qapi-schema/=
features-bad-type.out
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/qapi-schema/features-duplicate-name.err b/tests/qapi-s=
chema/features-duplicate-name.err
new file mode 100644
index 0000000000..c0a4cccae6
--- /dev/null
+++ b/tests/qapi-schema/features-duplicate-name.err
@@ -0,0 +1 @@
+tests/qapi-schema/features-duplicate-name.json:1: 'foo' (feature of Feat=
ureStruct0) collides with 'foo' (feature of FeatureStruct0)
diff --git a/tests/qapi-schema/features-duplicate-name.exit b/tests/qapi-=
schema/features-duplicate-name.exit
new file mode 100644
index 0000000000..d00491fd7e
--- /dev/null
+++ b/tests/qapi-schema/features-duplicate-name.exit
@@ -0,0 +1 @@
+1
diff --git a/tests/qapi-schema/features-duplicate-name.out b/tests/qapi-s=
chema/features-duplicate-name.out
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/qapi-schema/features-missing-name.err b/tests/qapi-sch=
ema/features-missing-name.err
new file mode 100644
index 0000000000..4f1d2715aa
--- /dev/null
+++ b/tests/qapi-schema/features-missing-name.err
@@ -0,0 +1 @@
+tests/qapi-schema/features-missing-name.json:1: Key 'name' is missing fr=
om feature of struct FeatureStruct0
diff --git a/tests/qapi-schema/features-missing-name.exit b/tests/qapi-sc=
hema/features-missing-name.exit
new file mode 100644
index 0000000000..d00491fd7e
--- /dev/null
+++ b/tests/qapi-schema/features-missing-name.exit
@@ -0,0 +1 @@
+1
diff --git a/tests/qapi-schema/features-missing-name.out b/tests/qapi-sch=
ema/features-missing-name.out
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/qapi-schema/features-name-bad-type.err b/tests/qapi-sc=
hema/features-name-bad-type.err
new file mode 100644
index 0000000000..8a3eecb972
--- /dev/null
+++ b/tests/qapi-schema/features-name-bad-type.err
@@ -0,0 +1 @@
+tests/qapi-schema/features-name-bad-type.json:1: Feature of struct Featu=
reStruct0 requires a string name
diff --git a/tests/qapi-schema/features-name-bad-type.exit b/tests/qapi-s=
chema/features-name-bad-type.exit
new file mode 100644
index 0000000000..d00491fd7e
--- /dev/null
+++ b/tests/qapi-schema/features-name-bad-type.exit
@@ -0,0 +1 @@
+1
diff --git a/tests/qapi-schema/features-name-bad-type.out b/tests/qapi-sc=
hema/features-name-bad-type.out
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/qapi-schema/features-no-list.err b/tests/qapi-schema/f=
eatures-no-list.err
new file mode 100644
index 0000000000..61ed68612b
--- /dev/null
+++ b/tests/qapi-schema/features-no-list.err
@@ -0,0 +1 @@
+tests/qapi-schema/features-no-list.json:1: Struct 'FeatureStruct0' requi=
res an array for 'features'
diff --git a/tests/qapi-schema/features-no-list.exit b/tests/qapi-schema/=
features-no-list.exit
new file mode 100644
index 0000000000..d00491fd7e
--- /dev/null
+++ b/tests/qapi-schema/features-no-list.exit
@@ -0,0 +1 @@
+1
diff --git a/tests/qapi-schema/features-no-list.out b/tests/qapi-schema/f=
eatures-no-list.out
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/qapi-schema/features-unknown-key.err b/tests/qapi-sche=
ma/features-unknown-key.err
new file mode 100644
index 0000000000..a1d693030d
--- /dev/null
+++ b/tests/qapi-schema/features-unknown-key.err
@@ -0,0 +1,2 @@
+tests/qapi-schema/features-unknown-key.json:1: Unknown key 'colour' in f=
eature of struct FeatureStruct0
+Valid keys are 'if', 'name'.
diff --git a/tests/qapi-schema/features-unknown-key.exit b/tests/qapi-sch=
ema/features-unknown-key.exit
new file mode 100644
index 0000000000..d00491fd7e
--- /dev/null
+++ b/tests/qapi-schema/features-unknown-key.exit
@@ -0,0 +1 @@
+1
diff --git a/tests/qapi-schema/features-unknown-key.out b/tests/qapi-sche=
ma/features-unknown-key.out
new file mode 100644
index 0000000000..e69de29bb2
--=20
2.20.1


