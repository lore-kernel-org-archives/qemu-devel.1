Received: from eggs.gnu.org ([209.51.188.92]:52991)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ghsOk-0000H8-6y
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 03:42:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ghsOj-0003Ez-CJ
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 03:42:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48472)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1ghsOj-0003Aw-6q
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 03:42:37 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Fri, 11 Jan 2019 09:42:28 +0100
Message-Id: <1547196148-12250-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] HACKING: Clarify the paragraph about typedefs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, peter.maydell@linaro.org, Markus Armbruster <armbru@redhat.com>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Greg Kurz <groug@kaod.org>, Eric Blake <eblake@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

The paragraph about typedefs is very sparse and caused some trouble
already: Is this mandatory coding style or just a recommendation?
... since this is the HACKING file and not in CODING_STYLE. And various
versions of GCC and Clang disallow duplicated typedefs in certain
language modes, so the "enforced" typedeffing repeatedly caused
compile errors in the past.
Thus let's reword this paragraph a little bit, so that it is clear
that typedefs are welcome, but not a mandatory coding style. Also
add some information about our include/qemu/typedefs.h file here
since most newcomers are not aware of this file yet.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 HACKING | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/HACKING b/HACKING
index 0fc3e0f..aa6fc3f 100644
--- a/HACKING
+++ b/HACKING
@@ -100,7 +100,13 @@ pointer, you're guaranteed that it is used to modify the storage
 it points to, or it is aliased to another pointer that is.
 
 2.3. Typedefs
-Typedefs are used to eliminate the redundant 'struct' keyword.
+Typedefs can be used to eliminate the redundant 'struct' keyword. This is
+especially helpful for common types that are used all over the place. Since
+certain C compilers choke on duplicated typedefs, you should avoid them and
+declare a typedef only in one header file. For common types, you can use
+"include/qemu/typedefs.h" for example. Note that it is also perfectly fine to
+use forward struct definitions without typedefs for references in headers
+to avoid the problem with duplicated typedefs.
 
 2.4. Reserved namespaces in C and POSIX
 Underscore capital, double underscore, and underscore 't' suffixes should be
-- 
1.8.3.1
