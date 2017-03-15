Received: from eggs.gnu.org ([2001:4830:134:3::10]:33260)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1co8Uo-0001V5-TV
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 08:57:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1co8Ul-0000Fg-Rf
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 08:57:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51530)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1co8Ul-0000F6-Iv
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 08:57:39 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Wed, 15 Mar 2017 13:56:53 +0100
Message-Id: <1489582656-31133-5-git-send-email-armbru@redhat.com>
In-Reply-To: <1489582656-31133-1-git-send-email-armbru@redhat.com>
References: <1489582656-31133-1-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 for-2.9 04/47] docs/qapi-code-gen.txt: Drop
 confusing reference to 'gen'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, eblake@redhat.com, mdroth@linux.vnet.ibm.com

Section "Commands" qualifies its rules on permitted argument and
return types "with one exception noted below when 'gen' is used".  The
note went away in commit 2d21291.  Clean up the dangling references.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 docs/qapi-code-gen.txt | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/docs/qapi-code-gen.txt b/docs/qapi-code-gen.txt
index 9b429ab..31fa35b 100644
--- a/docs/qapi-code-gen.txt
+++ b/docs/qapi-code-gen.txt
@@ -558,22 +558,20 @@ The 'data' argument maps to the "arguments" diction=
ary passed in as
 part of a Client JSON Protocol command.  The 'data' member is optional
 and defaults to {} (an empty dictionary).  If present, it must be the
 string name of a complex type, or a dictionary that declares an
-anonymous type with the same semantics as a 'struct' expression, with
-one exception noted below when 'gen' is used.
+anonymous type with the same semantics as a 'struct' expression.
=20
 The 'returns' member describes what will appear in the "return" member
 of a Client JSON Protocol reply on successful completion of a command.
 The member is optional from the command declaration; if absent, the
 "return" member will be an empty dictionary.  If 'returns' is present,
 it must be the string name of a complex or built-in type, a
-one-element array containing the name of a complex or built-in type,
-with one exception noted below when 'gen' is used.  Although it is
-permitted to have the 'returns' member name a built-in type or an
-array of built-in types, any command that does this cannot be extended
-to return additional information in the future; thus, new commands
-should strongly consider returning a dictionary-based type or an array
-of dictionaries, even if the dictionary only contains one member at the
-present.
+one-element array containing the name of a complex or built-in type.
+Although it is permitted to have the 'returns' member name a built-in
+type or an array of built-in types, any command that does this cannot
+be extended to return additional information in the future; thus, new
+commands should strongly consider returning a dictionary-based type or
+an array of dictionaries, even if the dictionary only contains one
+member at the present.
=20
 All commands in Client JSON Protocol use a dictionary to report
 failure, with no way to specify that in QAPI.  Where the error return
--=20
2.7.4
