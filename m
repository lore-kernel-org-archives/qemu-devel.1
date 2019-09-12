Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1192DC4CEC7
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 22:44:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D82EB20830
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 22:44:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D82EB20830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39359 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8Xoq-0005kN-0G
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 18:44:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42095)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1i8XcZ-0008EL-AD
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 18:31:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1i8XcX-000626-Sj
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 18:31:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59808)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1i8XcU-00060N-Qn; Thu, 12 Sep 2019 18:31:18 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2991B2A09B3;
 Thu, 12 Sep 2019 22:31:18 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.59])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E1E805C1B2;
 Thu, 12 Sep 2019 22:31:15 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 13 Sep 2019 01:30:27 +0300
Message-Id: <20190912223028.18496-11-mlevitsk@redhat.com>
In-Reply-To: <20190912223028.18496-1-mlevitsk@redhat.com>
References: <20190912223028.18496-1-mlevitsk@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Thu, 12 Sep 2019 22:31:18 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 10/11] iotests: filter few more luks
 specific create options
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
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Those options are test input anyway, and this allows more tests
to be able to have same output on both qcow2 luks encrypted images
and raw luks images

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 tests/qemu-iotests/087.out       | 6 +++---
 tests/qemu-iotests/134.out       | 2 +-
 tests/qemu-iotests/158.out       | 4 ++--
 tests/qemu-iotests/188.out       | 2 +-
 tests/qemu-iotests/189.out       | 4 ++--
 tests/qemu-iotests/198.out       | 4 ++--
 tests/qemu-iotests/common.filter | 6 ++++--
 7 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/tests/qemu-iotests/087.out b/tests/qemu-iotests/087.out
index 2d92ea847b..b61ba638af 100644
--- a/tests/qemu-iotests/087.out
+++ b/tests/qemu-iotests/087.out
@@ -34,7 +34,7 @@ QMP_VERSION
 
 === Encrypted image QCow ===
 
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728 encryption=on encrypt.key-secret=sec0
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728 encryption=on
 Testing:
 QMP_VERSION
 {"return": {}}
@@ -46,7 +46,7 @@ QMP_VERSION
 
 === Encrypted image LUKS ===
 
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728 encrypt.format=luks encrypt.key-secret=sec0
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728
 Testing:
 QMP_VERSION
 {"return": {}}
@@ -58,7 +58,7 @@ QMP_VERSION
 
 === Missing driver ===
 
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728 encryption=on encrypt.key-secret=sec0
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728 encryption=on
 Testing: -S
 QMP_VERSION
 {"return": {}}
diff --git a/tests/qemu-iotests/134.out b/tests/qemu-iotests/134.out
index 09d46f6b17..4abc5b5f7d 100644
--- a/tests/qemu-iotests/134.out
+++ b/tests/qemu-iotests/134.out
@@ -1,5 +1,5 @@
 QA output created by 134
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728 encryption=on encrypt.key-secret=sec0
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728 encryption=on
 
 == reading whole image ==
 read 134217728/134217728 bytes at offset 0
diff --git a/tests/qemu-iotests/158.out b/tests/qemu-iotests/158.out
index 6def216e55..f28a17626b 100644
--- a/tests/qemu-iotests/158.out
+++ b/tests/qemu-iotests/158.out
@@ -1,6 +1,6 @@
 QA output created by 158
 == create base ==
-Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=134217728 encryption=on encrypt.key-secret=sec0
+Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=134217728 encryption=on
 
 == writing whole image ==
 wrote 134217728/134217728 bytes at offset 0
@@ -10,7 +10,7 @@ wrote 134217728/134217728 bytes at offset 0
 read 134217728/134217728 bytes at offset 0
 128 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 == create overlay ==
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728 backing_file=TEST_DIR/t.IMGFMT.base encryption=on encrypt.key-secret=sec0
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728 backing_file=TEST_DIR/t.IMGFMT.base encryption=on
 
 == writing part of a cluster ==
 wrote 1024/1024 bytes at offset 0
diff --git a/tests/qemu-iotests/188.out b/tests/qemu-iotests/188.out
index c568ef3701..5426861b18 100644
--- a/tests/qemu-iotests/188.out
+++ b/tests/qemu-iotests/188.out
@@ -1,5 +1,5 @@
 QA output created by 188
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=16777216 encrypt.format=luks encrypt.key-secret=sec0 encrypt.iter-time=10
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=16777216
 
 == reading whole image ==
 read 16777216/16777216 bytes at offset 0
diff --git a/tests/qemu-iotests/189.out b/tests/qemu-iotests/189.out
index a0b7c9c24c..bc213cbe14 100644
--- a/tests/qemu-iotests/189.out
+++ b/tests/qemu-iotests/189.out
@@ -1,6 +1,6 @@
 QA output created by 189
 == create base ==
-Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=16777216 encrypt.format=luks encrypt.key-secret=sec0 encrypt.iter-time=10
+Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=16777216
 
 == writing whole image ==
 wrote 16777216/16777216 bytes at offset 0
@@ -10,7 +10,7 @@ wrote 16777216/16777216 bytes at offset 0
 read 16777216/16777216 bytes at offset 0
 16 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 == create overlay ==
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=16777216 backing_file=TEST_DIR/t.IMGFMT.base encrypt.format=luks encrypt.key-secret=sec1 encrypt.iter-time=10
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=16777216 backing_file=TEST_DIR/t.IMGFMT.base
 
 == writing part of a cluster ==
 wrote 1024/1024 bytes at offset 0
diff --git a/tests/qemu-iotests/198.out b/tests/qemu-iotests/198.out
index e86b175e39..2eff420795 100644
--- a/tests/qemu-iotests/198.out
+++ b/tests/qemu-iotests/198.out
@@ -1,12 +1,12 @@
 QA output created by 198
 == create base ==
-Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=16777216 encrypt.format=luks encrypt.key-secret=sec0 encrypt.iter-time=10
+Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=16777216
 
 == writing whole image base ==
 wrote 16777216/16777216 bytes at offset 0
 16 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 == create overlay ==
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=16777216 backing_file=TEST_DIR/t.IMGFMT.base encrypt.format=luks encrypt.key-secret=sec1 encrypt.iter-time=10
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=16777216 backing_file=TEST_DIR/t.IMGFMT.base
 
 == writing whole image layer ==
 wrote 16777216/16777216 bytes at offset 0
diff --git a/tests/qemu-iotests/common.filter b/tests/qemu-iotests/common.filter
index 445a1c23e0..b295a3fec7 100644
--- a/tests/qemu-iotests/common.filter
+++ b/tests/qemu-iotests/common.filter
@@ -138,8 +138,10 @@ _filter_img_create()
         -e "s# block_state_zero=\\(on\\|off\\)##g" \
         -e "s# log_size=[0-9]\\+##g" \
         -e "s# refcount_bits=[0-9]\\+##g" \
-        -e "s# key-secret=[a-zA-Z0-9]\\+##g" \
-        -e "s# iter-time=[0-9]\\+##g" \
+        -e "s# \\(encrypt\\.\\)\\?key-secret=[a-zA-Z0-9]\\+##g" \
+        -e "s# \\(encrypt\\.\\)\\?slot=[0-9]\\+##g" \
+        -e "s# \\(encrypt\\.\\)\\?iter-time=[0-9]\\+##g" \
+        -e "s# encrypt\\.format=[a-zA-Z0-9]\\+##g" \
         -e "s# force_size=\\(on\\|off\\)##g"
 }
 
-- 
2.17.2


