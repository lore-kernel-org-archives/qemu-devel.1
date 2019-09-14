Return-Path: <SRS0=fVwN=XJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F548C4CEC9
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Sep 2019 15:51:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9BE92081B
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Sep 2019 15:51:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9BE92081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50848 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9AKe-0004la-1S
	for qemu-devel@archiver.kernel.org; Sat, 14 Sep 2019 11:51:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54355)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1i9A5B-0004zQ-QH
 for qemu-devel@nongnu.org; Sat, 14 Sep 2019 11:35:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1i9A59-0004y8-Uo
 for qemu-devel@nongnu.org; Sat, 14 Sep 2019 11:35:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56172)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1i9A57-0004r8-QL
 for qemu-devel@nongnu.org; Sat, 14 Sep 2019 11:35:27 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B518F2BFD2;
 Sat, 14 Sep 2019 15:35:10 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-142.ams2.redhat.com
 [10.36.117.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0BCDD17CF8;
 Sat, 14 Sep 2019 15:35:08 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8F08E11386A7; Sat, 14 Sep 2019 17:35:06 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Date: Sat, 14 Sep 2019 17:34:49 +0200
Message-Id: <20190914153506.2151-3-armbru@redhat.com>
In-Reply-To: <20190914153506.2151-1-armbru@redhat.com>
References: <20190914153506.2151-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Sat, 14 Sep 2019 15:35:10 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 02/19] tests/qapi-schema: Delete two redundant
 tests
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
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Tests duplicate-key and double-data test the same thing.  The former
predates the latter, and it has a better name.  Delete the latter, and
tweak the former's comment.

Tests include-format-err and include-extra-junk test the same thing.
The former predates the latter, but the latter has a better name and a
comment.  Delete the former.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 tests/Makefile.include                    | 2 --
 tests/qapi-schema/double-data.err         | 1 -
 tests/qapi-schema/double-data.exit        | 1 -
 tests/qapi-schema/double-data.json        | 2 --
 tests/qapi-schema/double-data.out         | 0
 tests/qapi-schema/duplicate-key.json      | 2 +-
 tests/qapi-schema/include-format-err.err  | 1 -
 tests/qapi-schema/include-format-err.exit | 1 -
 tests/qapi-schema/include-format-err.json | 2 --
 tests/qapi-schema/include-format-err.out  | 0
 10 files changed, 1 insertion(+), 11 deletions(-)
 delete mode 100644 tests/qapi-schema/double-data.err
 delete mode 100644 tests/qapi-schema/double-data.exit
 delete mode 100644 tests/qapi-schema/double-data.json
 delete mode 100644 tests/qapi-schema/double-data.out
 delete mode 100644 tests/qapi-schema/include-format-err.err
 delete mode 100644 tests/qapi-schema/include-format-err.exit
 delete mode 100644 tests/qapi-schema/include-format-err.json
 delete mode 100644 tests/qapi-schema/include-format-err.out

diff --git a/tests/Makefile.include b/tests/Makefile.include
index bb071d2ba9..a1deaa5456 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -360,7 +360,6 @@ qapi-schema +=3D doc-missing-expr.json
 qapi-schema +=3D doc-missing-space.json
 qapi-schema +=3D doc-missing.json
 qapi-schema +=3D doc-no-symbol.json
-qapi-schema +=3D double-data.json
 qapi-schema +=3D double-type.json
 qapi-schema +=3D duplicate-key.json
 qapi-schema +=3D empty.json
@@ -405,7 +404,6 @@ qapi-schema +=3D ident-with-escape.json
 qapi-schema +=3D include-before-err.json
 qapi-schema +=3D include-cycle.json
 qapi-schema +=3D include-extra-junk.json
-qapi-schema +=3D include-format-err.json
 qapi-schema +=3D include-nested-err.json
 qapi-schema +=3D include-no-file.json
 qapi-schema +=3D include-non-file.json
diff --git a/tests/qapi-schema/double-data.err b/tests/qapi-schema/double=
-data.err
deleted file mode 100644
index cc765c4ff2..0000000000
--- a/tests/qapi-schema/double-data.err
+++ /dev/null
@@ -1 +0,0 @@
-tests/qapi-schema/double-data.json:2:41: Duplicate key "data"
diff --git a/tests/qapi-schema/double-data.exit b/tests/qapi-schema/doubl=
e-data.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/double-data.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/double-data.json b/tests/qapi-schema/doubl=
e-data.json
deleted file mode 100644
index e76b519538..0000000000
--- a/tests/qapi-schema/double-data.json
+++ /dev/null
@@ -1,2 +0,0 @@
-# we reject an expression with duplicate top-level keys
-{ 'struct': 'bar', 'data': { }, 'data': { 'string': 'str'} }
diff --git a/tests/qapi-schema/double-data.out b/tests/qapi-schema/double=
-data.out
deleted file mode 100644
index e69de29bb2..0000000000
diff --git a/tests/qapi-schema/duplicate-key.json b/tests/qapi-schema/dup=
licate-key.json
index 14ac0e8a40..06b55840c9 100644
--- a/tests/qapi-schema/duplicate-key.json
+++ b/tests/qapi-schema/duplicate-key.json
@@ -1,3 +1,3 @@
-# QAPI cannot include the same key more than once in any {}
+# Cannot include the same key more than once in any {}
 { 'key': 'value',
   'key': 'value' }
diff --git a/tests/qapi-schema/include-format-err.err b/tests/qapi-schema=
/include-format-err.err
deleted file mode 100644
index 721ff4eccc..0000000000
--- a/tests/qapi-schema/include-format-err.err
+++ /dev/null
@@ -1 +0,0 @@
-tests/qapi-schema/include-format-err.json:1: Invalid 'include' directive
diff --git a/tests/qapi-schema/include-format-err.exit b/tests/qapi-schem=
a/include-format-err.exit
deleted file mode 100644
index d00491fd7e..0000000000
--- a/tests/qapi-schema/include-format-err.exit
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/tests/qapi-schema/include-format-err.json b/tests/qapi-schem=
a/include-format-err.json
deleted file mode 100644
index 44980f026f..0000000000
--- a/tests/qapi-schema/include-format-err.json
+++ /dev/null
@@ -1,2 +0,0 @@
-{ 'include': 'include-simple-sub.json',
-  'foo': 'bar' }
diff --git a/tests/qapi-schema/include-format-err.out b/tests/qapi-schema=
/include-format-err.out
deleted file mode 100644
index e69de29bb2..0000000000
--=20
2.21.0


