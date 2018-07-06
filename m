Received: from eggs.gnu.org ([2001:4830:134:3::10]:58599)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fbORi-0000CA-RF
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 06:58:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fbORf-0000m7-PS
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 06:58:38 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40950 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1fbORf-0000l4-LQ
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 06:58:35 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3330E40122D9
	for <qemu-devel@nongnu.org>; Fri,  6 Jul 2018 10:58:35 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri,  6 Jul 2018 12:57:48 +0200
Message-Id: <20180706105753.26700-23-marcandre.lureau@redhat.com>
In-Reply-To: <20180706105753.26700-1-marcandre.lureau@redhat.com>
References: <20180706105753.26700-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v6 22/27] docs: document schema configuration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 docs/devel/qapi-code-gen.txt | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/docs/devel/qapi-code-gen.txt b/docs/devel/qapi-code-gen.txt
index c2e11465f0..799aef7728 100644
--- a/docs/devel/qapi-code-gen.txt
+++ b/docs/devel/qapi-code-gen.txt
@@ -752,6 +752,25 @@ gets its generated code guarded like this:
  #endif /* defined(HAVE_BAR) */
  #endif /* defined(CONFIG_FOO) */
=20
+Where a member can be defined with a single string value for its type,
+it is also possible to supply a dictionary instead with both 'type'
+and 'if' keys.
+
+Example: a conditional 'bar' member
+
+{ 'struct': 'IfStruct', 'data':
+  { 'foo': 'int',
+    'bar': { 'type': 'int', 'if': 'defined(IFCOND)'} } }
+
+An enum value can be replaced by a dictionary with a 'name' and a 'if'
+key.
+
+Example: a conditional 'bar' enum member.
+
+{ 'enum': 'IfEnum', 'data':
+  [ 'foo',
+    { 'name' : 'bar', 'if': 'defined(IFCOND)' } ] }
+
 Please note that you are responsible to ensure that the C code will
 compile with an arbitrary combination of conditions, since the
 generators are unable to check it at this point.
--=20
2.18.0.rc1
