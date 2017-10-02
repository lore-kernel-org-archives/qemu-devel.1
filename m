Received: from eggs.gnu.org ([2001:4830:134:3::10]:38759)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dz2bd-0007yK-4S
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 11:26:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dz2ba-0007w4-Js
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 11:26:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38212)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dz2ba-0007ur-8j
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 11:26:02 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  2 Oct 2017 17:25:38 +0200
Message-Id: <20171002152552.27999-19-armbru@redhat.com>
In-Reply-To: <20171002152552.27999-1-armbru@redhat.com>
References: <20171002152552.27999-1-armbru@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 18/32] docs/devel/qapi-code-gen.txt:
 Rewrite section on schema syntax
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mdroth@linux.vnet.ibm.com, marcandre.lureau@redhat.com, eblake@redhat.com
List-ID: <qemu-devel.nongnu.org>

Section "QMP/Guest agent schema" is one big paragraph, encumbered with
more detail than necessary.  It also claims JSON null isn't supported,
which is untrue since commit e53188a, v2.4.0.  Rewrite it.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 docs/devel/qapi-code-gen.txt | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/docs/devel/qapi-code-gen.txt b/docs/devel/qapi-code-gen.txt
index f5b7659caf..3186c36460 100644
--- a/docs/devel/qapi-code-gen.txt
+++ b/docs/devel/qapi-code-gen.txt
@@ -25,24 +25,24 @@ how the schemas, scripts, and resulting code are used.
 
 == QMP/Guest agent schema ==
 
-A QAPI schema file is designed to be loosely based on JSON
-(http://www.ietf.org/rfc/rfc7159.txt) with changes for quoting style
-and the use of comments; a QAPI schema file is then parsed by a python
-code generation program.  A valid QAPI schema consists of a series of
-top-level expressions, with no commas between them.  Where
-dictionaries (JSON objects) are used, they are parsed as python
-OrderedDicts so that ordering is preserved (for predictable layout of
-generated C structs and parameter lists).  Ordering doesn't matter
-between top-level expressions or the keys within an expression, but
-does matter within dictionary values for 'data' and 'returns' members
-of a single expression.  QAPI schema input is written using 'single
-quotes' instead of JSON's "double quotes" (in contrast, Client JSON
-Protocol uses no comments, and while input accepts 'single quotes' as
-an extension, output is strict JSON using only "double quotes").  As
-in JSON, trailing commas are not permitted in arrays or dictionaries.
-Input must be ASCII (although QMP supports full Unicode strings, the
-QAPI parser does not).  At present, there is no place where a QAPI
-schema requires the use of JSON numbers or null.
+Schema syntax is based on JSON (RFC 7159), with the following
+differences:
+
+* Comments (see below)
+
+* No JSON numbers
+
+* Strings use 'single quotes' instead of "double quotes"
+
+* The input character set is plain ASCII
+
+  Unicode characters need to be escaped.  In contrast, the Client JSON
+  Protocol uses UTF-8.
+
+A QAPI schema consists of a sequence of JSON values (top-level
+expressions), with no commas between them.  The order of top-level
+expressions doesn't matter.  The order of keys in JSON objects is
+generally relevant.
 
 
 === Comments ===
-- 
2.13.6
