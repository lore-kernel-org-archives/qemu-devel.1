Received: from eggs.gnu.org ([2001:4830:134:3::10]:39117)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ftHxR-0003Mo-8O
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 15:41:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ftHxN-0001Cr-SA
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 15:41:20 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56126 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ftHxN-0001C0-LV
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 15:41:17 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5332E7DAC2
	for <qemu-devel@nongnu.org>; Fri, 24 Aug 2018 19:41:17 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-97.ams2.redhat.com
	[10.36.116.97])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 201EB2156899
	for <qemu-devel@nongnu.org>; Fri, 24 Aug 2018 19:41:17 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Fri, 24 Aug 2018 21:32:06 +0200
Message-Id: <20180824193206.25475-59-armbru@redhat.com>
In-Reply-To: <20180824193206.25475-1-armbru@redhat.com>
References: <20180824193206.25475-1-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 58/58] json: Update references to RFC 7159 to
 RFC 8259
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

RFC 8259 (December 2017) obsoletes RFC 7159 (March 2014).

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20180823164025.12553-59-armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 include/qapi/qmp/qnum.h | 2 +-
 qapi/introspect.json    | 2 +-
 qobject/json-parser.c   | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/qapi/qmp/qnum.h b/include/qapi/qmp/qnum.h
index 45bf02a036..bbae0a5ec8 100644
--- a/include/qapi/qmp/qnum.h
+++ b/include/qapi/qmp/qnum.h
@@ -25,7 +25,7 @@ typedef enum {
 
 /*
  * QNum encapsulates how our dialect of JSON fills in the blanks left
- * by the JSON specification (RFC 7159) regarding numbers.
+ * by the JSON specification (RFC 8259) regarding numbers.
  *
  * Conceptually, we treat number as an abstract type with three
  * concrete subtypes: floating-point, signed integer, unsigned
diff --git a/qapi/introspect.json b/qapi/introspect.json
index 137b39b992..3d22166b2b 100644
--- a/qapi/introspect.json
+++ b/qapi/introspect.json
@@ -120,7 +120,7 @@
 ##
 # @JSONType:
 #
-# The four primitive and two structured types according to RFC 7159
+# The four primitive and two structured types according to RFC 8259
 # section 1, plus 'int' (split off 'number'), plus the obvious top
 # type 'value'.
 #
diff --git a/qobject/json-parser.c b/qobject/json-parser.c
index 3318b8dad0..5a840dfd86 100644
--- a/qobject/json-parser.c
+++ b/qobject/json-parser.c
@@ -516,7 +516,7 @@ static QObject *parse_literal(JSONParserContext *ctxt)
     }
     case JSON_FLOAT:
         /* FIXME dependent on locale; a pervasive issue in QEMU */
-        /* FIXME our lexer matches RFC 7159 in forbidding Inf or NaN,
+        /* FIXME our lexer matches RFC 8259 in forbidding Inf or NaN,
          * but those might be useful extensions beyond JSON */
         return QOBJECT(qnum_from_double(strtod(token->str, NULL)));
     default:
-- 
2.17.1
