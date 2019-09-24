Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A3F3C432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 12:51:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D890A2146E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 12:51:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D890A2146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45306 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCkHm-0007MO-7f
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 08:51:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50494)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iCk0m-0001J5-Ak
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 08:33:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iCk0j-0006wn-8I
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 08:33:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38418)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iCk0i-0006uM-LO
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 08:33:41 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 705A9307C820
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2019 12:33:39 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-142.ams2.redhat.com
 [10.36.117.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 405A860C63;
 Tue, 24 Sep 2019 12:33:39 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id BE4111138408; Tue, 24 Sep 2019 14:33:34 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 19/37] tests/qapi-schema: Cover unknown pragma
Date: Tue, 24 Sep 2019 14:33:16 +0200
Message-Id: <20190924123334.30645-20-armbru@redhat.com>
In-Reply-To: <20190924123334.30645-1-armbru@redhat.com>
References: <20190924123334.30645-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Tue, 24 Sep 2019 12:33:39 +0000 (UTC)
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

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20190914153506.2151-2-armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 tests/Makefile.include                | 1 +
 tests/qapi-schema/pragma-unknown.err  | 1 +
 tests/qapi-schema/pragma-unknown.exit | 1 +
 tests/qapi-schema/pragma-unknown.json | 1 +
 tests/qapi-schema/pragma-unknown.out  | 0
 5 files changed, 4 insertions(+)
 create mode 100644 tests/qapi-schema/pragma-unknown.err
 create mode 100644 tests/qapi-schema/pragma-unknown.exit
 create mode 100644 tests/qapi-schema/pragma-unknown.json
 create mode 100644 tests/qapi-schema/pragma-unknown.out

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 2c3adb1530..089cc3ea95 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -427,6 +427,7 @@ qapi-schema +=3D pragma-doc-required-crap.json
 qapi-schema +=3D pragma-extra-junk.json
 qapi-schema +=3D pragma-name-case-whitelist-crap.json
 qapi-schema +=3D pragma-non-dict.json
+qapi-schema +=3D pragma-unknown.json
 qapi-schema +=3D pragma-returns-whitelist-crap.json
 qapi-schema +=3D qapi-schema-test.json
 qapi-schema +=3D quoted-structural-chars.json
diff --git a/tests/qapi-schema/pragma-unknown.err b/tests/qapi-schema/pra=
gma-unknown.err
new file mode 100644
index 0000000000..6ef2058316
--- /dev/null
+++ b/tests/qapi-schema/pragma-unknown.err
@@ -0,0 +1 @@
+tests/qapi-schema/pragma-unknown.json:1: Unknown pragma 'no-such-pragma'
diff --git a/tests/qapi-schema/pragma-unknown.exit b/tests/qapi-schema/pr=
agma-unknown.exit
new file mode 100644
index 0000000000..d00491fd7e
--- /dev/null
+++ b/tests/qapi-schema/pragma-unknown.exit
@@ -0,0 +1 @@
+1
diff --git a/tests/qapi-schema/pragma-unknown.json b/tests/qapi-schema/pr=
agma-unknown.json
new file mode 100644
index 0000000000..c51bbbb53f
--- /dev/null
+++ b/tests/qapi-schema/pragma-unknown.json
@@ -0,0 +1 @@
+{ 'pragma': { 'no-such-pragma': false } }
diff --git a/tests/qapi-schema/pragma-unknown.out b/tests/qapi-schema/pra=
gma-unknown.out
new file mode 100644
index 0000000000..e69de29bb2
--=20
2.21.0


