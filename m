Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5803FC3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 20:52:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2906C2189D
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 20:52:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2906C2189D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i34vF-0002o4-9H
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 16:52:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51883)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1i34Wn-0003gk-Ns
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 16:26:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1i34Wk-0002oX-Sl
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 16:26:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43714)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1i34Wk-0002n6-IM
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 16:26:46 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id BE979875219;
 Wed, 28 Aug 2019 20:26:45 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-142.ams2.redhat.com
 [10.36.117.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8DC425C1D6;
 Wed, 28 Aug 2019 20:26:44 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7AC011165613; Wed, 28 Aug 2019 22:26:41 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 28 Aug 2019 22:26:37 +0200
Message-Id: <20190828202641.24752-6-armbru@redhat.com>
In-Reply-To: <20190828202641.24752-1-armbru@redhat.com>
References: <20190828202641.24752-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.68]); Wed, 28 Aug 2019 20:26:45 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 5/9] tests/qapi-schema: Consistently name
 string tests string-FOO
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
Cc: mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 .../{unclosed-string.json =3D> string-unclosed.json}            | 0
 tests/qapi-schema/{unicode-str.json =3D> string-unicode.json}   | 0
 tests/Makefile.include                                        | 4 ++--
 tests/qapi-schema/string-unclosed.err                         | 1 +
 .../{unclosed-string.exit =3D> string-unclosed.exit}            | 0
 .../qapi-schema/{unclosed-string.out =3D> string-unclosed.out}  | 0
 tests/qapi-schema/string-unicode.err                          | 1 +
 tests/qapi-schema/{unicode-str.exit =3D> string-unicode.exit}   | 0
 tests/qapi-schema/{unicode-str.out =3D> string-unicode.out}     | 0
 tests/qapi-schema/unclosed-string.err                         | 1 -
 tests/qapi-schema/unicode-str.err                             | 1 -
 11 files changed, 4 insertions(+), 4 deletions(-)
 rename tests/qapi-schema/{unclosed-string.json =3D> string-unclosed.json=
} (100%)
 rename tests/qapi-schema/{unicode-str.json =3D> string-unicode.json} (10=
0%)
 create mode 100644 tests/qapi-schema/string-unclosed.err
 rename tests/qapi-schema/{unclosed-string.exit =3D> string-unclosed.exit=
} (100%)
 rename tests/qapi-schema/{unclosed-string.out =3D> string-unclosed.out} =
(100%)
 create mode 100644 tests/qapi-schema/string-unicode.err
 rename tests/qapi-schema/{unicode-str.exit =3D> string-unicode.exit} (10=
0%)
 rename tests/qapi-schema/{unicode-str.out =3D> string-unicode.out} (100%=
)
 delete mode 100644 tests/qapi-schema/unclosed-string.err
 delete mode 100644 tests/qapi-schema/unicode-str.err

diff --git a/tests/qapi-schema/unclosed-string.json b/tests/qapi-schema/s=
tring-unclosed.json
similarity index 100%
rename from tests/qapi-schema/unclosed-string.json
rename to tests/qapi-schema/string-unclosed.json
diff --git a/tests/qapi-schema/unicode-str.json b/tests/qapi-schema/strin=
g-unicode.json
similarity index 100%
rename from tests/qapi-schema/unicode-str.json
rename to tests/qapi-schema/string-unicode.json
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 543bac6f93..af1baca936 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -453,6 +453,8 @@ qapi-schema +=3D returns-dict.json
 qapi-schema +=3D returns-unknown.json
 qapi-schema +=3D returns-whitelist.json
 qapi-schema +=3D string-control.json
+qapi-schema +=3D string-unclosed.json
+qapi-schema +=3D string-unicode.json
 qapi-schema +=3D struct-base-clash-deep.json
 qapi-schema +=3D struct-base-clash.json
 qapi-schema +=3D struct-data-invalid.json
@@ -463,8 +465,6 @@ qapi-schema +=3D trailing-comma-object.json
 qapi-schema +=3D type-bypass-bad-gen.json
 qapi-schema +=3D unclosed-list.json
 qapi-schema +=3D unclosed-object.json
-qapi-schema +=3D unclosed-string.json
-qapi-schema +=3D unicode-str.json
 qapi-schema +=3D union-base-empty.json
 qapi-schema +=3D union-base-no-discriminator.json
 qapi-schema +=3D union-branch-case.json
diff --git a/tests/qapi-schema/string-unclosed.err b/tests/qapi-schema/st=
ring-unclosed.err
new file mode 100644
index 0000000000..bc6c00a0ec
--- /dev/null
+++ b/tests/qapi-schema/string-unclosed.err
@@ -0,0 +1 @@
+tests/qapi-schema/string-unclosed.json:1:11: Missing terminating "'"
diff --git a/tests/qapi-schema/unclosed-string.exit b/tests/qapi-schema/s=
tring-unclosed.exit
similarity index 100%
rename from tests/qapi-schema/unclosed-string.exit
rename to tests/qapi-schema/string-unclosed.exit
diff --git a/tests/qapi-schema/unclosed-string.out b/tests/qapi-schema/st=
ring-unclosed.out
similarity index 100%
rename from tests/qapi-schema/unclosed-string.out
rename to tests/qapi-schema/string-unclosed.out
diff --git a/tests/qapi-schema/string-unicode.err b/tests/qapi-schema/str=
ing-unicode.err
new file mode 100644
index 0000000000..9a1bb0bc22
--- /dev/null
+++ b/tests/qapi-schema/string-unicode.err
@@ -0,0 +1 @@
+tests/qapi-schema/string-unicode.json:2: 'command' uses invalid name '=C3=
=A9'
diff --git a/tests/qapi-schema/unicode-str.exit b/tests/qapi-schema/strin=
g-unicode.exit
similarity index 100%
rename from tests/qapi-schema/unicode-str.exit
rename to tests/qapi-schema/string-unicode.exit
diff --git a/tests/qapi-schema/unicode-str.out b/tests/qapi-schema/string=
-unicode.out
similarity index 100%
rename from tests/qapi-schema/unicode-str.out
rename to tests/qapi-schema/string-unicode.out
diff --git a/tests/qapi-schema/unclosed-string.err b/tests/qapi-schema/un=
closed-string.err
deleted file mode 100644
index 12b187074e..0000000000
--- a/tests/qapi-schema/unclosed-string.err
+++ /dev/null
@@ -1 +0,0 @@
-tests/qapi-schema/unclosed-string.json:1:11: Missing terminating "'"
diff --git a/tests/qapi-schema/unicode-str.err b/tests/qapi-schema/unicod=
e-str.err
deleted file mode 100644
index f621cd6448..0000000000
--- a/tests/qapi-schema/unicode-str.err
+++ /dev/null
@@ -1 +0,0 @@
-tests/qapi-schema/unicode-str.json:2: 'command' uses invalid name '=C3=A9=
'
--=20
2.21.0


