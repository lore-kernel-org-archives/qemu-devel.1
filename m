Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51F68C432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 13:00:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2818E207FD
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 13:00:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2818E207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45359 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCkQS-0007If-Fo
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 09:00:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50572)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iCk0o-0001Kh-OH
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 08:33:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iCk0j-0006yB-Rw
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 08:33:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46518)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iCk0j-0006va-CY
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 08:33:41 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7675230A5A54
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2019 12:33:40 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-142.ams2.redhat.com
 [10.36.117.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4E98A5C220;
 Tue, 24 Sep 2019 12:33:39 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id DC7351136424; Tue, 24 Sep 2019 14:33:34 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 24/37] tests/qapi-schema: Demonstrate suboptimal lexical errors
Date: Tue, 24 Sep 2019 14:33:21 +0200
Message-Id: <20190924123334.30645-25-armbru@redhat.com>
In-Reply-To: <20190924123334.30645-1-armbru@redhat.com>
References: <20190924123334.30645-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Tue, 24 Sep 2019 12:33:40 +0000 (UTC)
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

The error message for forgotten quotes around a name shows just the
name's first character, which isn't as nice as it could be.  Same for
attempting to use a number.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20190914153506.2151-7-armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 tests/Makefile.include              | 1 +
 tests/qapi-schema/bad-type-int.json | 2 +-
 tests/qapi-schema/funny-word.err    | 1 +
 tests/qapi-schema/funny-word.exit   | 1 +
 tests/qapi-schema/funny-word.json   | 1 +
 tests/qapi-schema/funny-word.out    | 0
 6 files changed, 5 insertions(+), 1 deletion(-)
 create mode 100644 tests/qapi-schema/funny-word.err
 create mode 100644 tests/qapi-schema/funny-word.exit
 create mode 100644 tests/qapi-schema/funny-word.json
 create mode 100644 tests/qapi-schema/funny-word.out

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 799fd4af02..0595914526 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -402,6 +402,7 @@ qapi-schema +=3D flat-union-no-base.json
 qapi-schema +=3D flat-union-optional-discriminator.json
 qapi-schema +=3D flat-union-string-discriminator.json
 qapi-schema +=3D funny-char.json
+qapi-schema +=3D funny-word.json
 qapi-schema +=3D ident-with-escape.json
 qapi-schema +=3D include-before-err.json
 qapi-schema +=3D include-cycle.json
diff --git a/tests/qapi-schema/bad-type-int.json b/tests/qapi-schema/bad-=
type-int.json
index 56fc6f8126..f3ad803cb6 100644
--- a/tests/qapi-schema/bad-type-int.json
+++ b/tests/qapi-schema/bad-type-int.json
@@ -1,3 +1,3 @@
 # we reject an expression with a metatype that is not a string
 # FIXME: once the parser understands integer inputs, improve the error m=
essage
-{ 'struct': 1, 'data': { } }
+{ 'struct': 123, 'data': { } }
diff --git a/tests/qapi-schema/funny-word.err b/tests/qapi-schema/funny-w=
ord.err
new file mode 100644
index 0000000000..0a440574bd
--- /dev/null
+++ b/tests/qapi-schema/funny-word.err
@@ -0,0 +1 @@
+tests/qapi-schema/funny-word.json:1:3: Stray "c"
diff --git a/tests/qapi-schema/funny-word.exit b/tests/qapi-schema/funny-=
word.exit
new file mode 100644
index 0000000000..d00491fd7e
--- /dev/null
+++ b/tests/qapi-schema/funny-word.exit
@@ -0,0 +1 @@
+1
diff --git a/tests/qapi-schema/funny-word.json b/tests/qapi-schema/funny-=
word.json
new file mode 100644
index 0000000000..1153b9f12f
--- /dev/null
+++ b/tests/qapi-schema/funny-word.json
@@ -0,0 +1 @@
+{ command: 'foo' }
diff --git a/tests/qapi-schema/funny-word.out b/tests/qapi-schema/funny-w=
ord.out
new file mode 100644
index 0000000000..e69de29bb2
--=20
2.21.0


