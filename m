Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93FFEC432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 12:42:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 676F1214DA
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 12:42:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 676F1214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45228 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCk8w-0007VW-Ll
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 08:42:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50510)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iCk0n-0001JA-5w
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 08:33:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iCk0j-0006wQ-4B
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 08:33:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38420)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iCk0i-0006uY-JT
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 08:33:40 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8610E306085E
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2019 12:33:39 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-142.ams2.redhat.com
 [10.36.117.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 563D910013D9;
 Tue, 24 Sep 2019 12:33:39 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id F12871136426; Tue, 24 Sep 2019 14:33:34 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 26/37] qapi: Improve reporting of lexical errors
Date: Tue, 24 Sep 2019 14:33:23 +0200
Message-Id: <20190924123334.30645-27-armbru@redhat.com>
In-Reply-To: <20190924123334.30645-1-armbru@redhat.com>
References: <20190924123334.30645-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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

Show text up to next structural character, whitespace, or quote
character instead of just the first character.

Forgotten quotes now get reported like "Stray 'command'" instead of
"Stray 'c'".

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20190914153506.2151-9-armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 scripts/qapi/common.py             | 6 +++++-
 tests/qapi-schema/bad-type-int.err | 2 +-
 tests/qapi-schema/funny-word.err   | 2 +-
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index 142ab276ff..b3383b17ef 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -559,7 +559,11 @@ class QAPISchemaParser(object):
                 self.line +=3D 1
                 self.line_pos =3D self.cursor
             elif not self.tok.isspace():
-                raise QAPIParseError(self, "Stray '%s'" % self.tok)
+                # Show up to next structural, whitespace or quote
+                # character
+                match =3D re.match('[^[\\]{}:,\\s\'"]+',
+                                 self.src[self.cursor-1:])
+                raise QAPIParseError(self, "Stray '%s'" % match.group(0)=
)
=20
     def get_members(self):
         expr =3D OrderedDict()
diff --git a/tests/qapi-schema/bad-type-int.err b/tests/qapi-schema/bad-t=
ype-int.err
index 2021fda5d1..9b2c12c1eb 100644
--- a/tests/qapi-schema/bad-type-int.err
+++ b/tests/qapi-schema/bad-type-int.err
@@ -1 +1 @@
-tests/qapi-schema/bad-type-int.json:3:13: Stray '1'
+tests/qapi-schema/bad-type-int.json:3:13: Stray '123'
diff --git a/tests/qapi-schema/funny-word.err b/tests/qapi-schema/funny-w=
ord.err
index 18aedb4a99..af92fe2551 100644
--- a/tests/qapi-schema/funny-word.err
+++ b/tests/qapi-schema/funny-word.err
@@ -1 +1 @@
-tests/qapi-schema/funny-word.json:1:3: Stray 'c'
+tests/qapi-schema/funny-word.json:1:3: Stray 'command'
--=20
2.21.0


