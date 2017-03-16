Received: from eggs.gnu.org ([2001:4830:134:3::10]:54634)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1coOtQ-00065Q-8T
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 02:28:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1coOtO-00070a-F1
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 02:28:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50382)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1coOtO-0006zo-6v
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 02:28:10 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 42D9564F4
	for <qemu-devel@nongnu.org>; Thu, 16 Mar 2017 06:28:10 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-26.ams2.redhat.com
	[10.36.116.26])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 104CF5DC1D
	for <qemu-devel@nongnu.org>; Thu, 16 Mar 2017 06:28:10 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 16 Mar 2017 07:27:22 +0100
Message-Id: <1489645685-4750-7-git-send-email-armbru@redhat.com>
In-Reply-To: <1489645685-4750-1-git-send-email-armbru@redhat.com>
References: <1489645685-4750-1-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL for 2.9 06/49] docs/qapi-code-gen.txt: Drop
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

Section "Commands" qualifies its rules on permitted argument and
return types "with one exception noted below when 'gen' is used".  The
note went away in commit 2d21291.  Clean up the dangling references.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-Id: <1489582656-31133-5-git-send-email-armbru@redhat.com>
---
 docs/qapi-code-gen.txt | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/docs/qapi-code-gen.txt b/docs/qapi-code-gen.txt
index 4b64ee7..5532b60 100644
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
