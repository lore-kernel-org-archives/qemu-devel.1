Received: from eggs.gnu.org ([2001:4830:134:3::10]:52154)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cnJJl-0007Wj-9A
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 02:18:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cnJJi-0003WN-1K
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 02:18:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49194)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cnJJh-0003Vo-Qb
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 02:18:49 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 13 Mar 2017 07:18:04 +0100
Message-Id: <1489385927-6735-5-git-send-email-armbru@redhat.com>
In-Reply-To: <1489385927-6735-1-git-send-email-armbru@redhat.com>
References: <1489385927-6735-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.9 04/47] docs/qapi-code-gen.txt: Drop
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
---
 docs/qapi-code-gen.txt | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/docs/qapi-code-gen.txt b/docs/qapi-code-gen.txt
index 88de5c7..d9c1f91 100644
--- a/docs/qapi-code-gen.txt
+++ b/docs/qapi-code-gen.txt
@@ -555,22 +555,20 @@ The 'data' argument maps to the "arguments" dictionary passed in as
 part of a Client JSON Protocol command.  The 'data' member is optional
 and defaults to {} (an empty dictionary).  If present, it must be the
 string name of a complex type, or a dictionary that declares an
-anonymous type with the same semantics as a 'struct' expression, with
-one exception noted below when 'gen' is used.
+anonymous type with the same semantics as a 'struct' expression.
 
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
 
 All commands in Client JSON Protocol use a dictionary to report
 failure, with no way to specify that in QAPI.  Where the error return
-- 
2.7.4
