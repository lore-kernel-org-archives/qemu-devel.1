Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B161DC432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 12:56:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A420207FD
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 12:56:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A420207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45332 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCkMQ-0003FW-5v
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 08:56:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50491)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iCk0m-0001J4-5e
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 08:33:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iCk0i-0006vv-Os
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 08:33:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42778)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iCk0i-0006ua-DD
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 08:33:40 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9ED31307D923
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2019 12:33:39 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-142.ams2.redhat.com
 [10.36.117.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 476575C21F;
 Tue, 24 Sep 2019 12:33:39 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C39E51136420; Tue, 24 Sep 2019 14:33:34 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 20/37] tests/qapi-schema: Delete two redundant tests
Date: Tue, 24 Sep 2019 14:33:17 +0200
Message-Id: <20190924123334.30645-21-armbru@redhat.com>
In-Reply-To: <20190924123334.30645-1-armbru@redhat.com>
References: <20190924123334.30645-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Tue, 24 Sep 2019 12:33:39 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Message-Id: <20190914153506.2151-3-armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
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
index 089cc3ea95..0c862dbc42 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -359,7 +359,6 @@ qapi-schema +=3D doc-missing-expr.json
 qapi-schema +=3D doc-missing-space.json
 qapi-schema +=3D doc-missing.json
 qapi-schema +=3D doc-no-symbol.json
-qapi-schema +=3D double-data.json
 qapi-schema +=3D double-type.json
 qapi-schema +=3D duplicate-key.json
 qapi-schema +=3D empty.json
@@ -404,7 +403,6 @@ qapi-schema +=3D ident-with-escape.json
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


