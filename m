Received: from eggs.gnu.org ([2001:4830:134:3::10]:53991)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eko3a-00070W-2E
	for qemu-devel@nongnu.org; Sun, 11 Feb 2018 04:36:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eko3W-0006Kd-Vn
	for qemu-devel@nongnu.org; Sun, 11 Feb 2018 04:36:21 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54006 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1eko3W-0006JN-Nn
	for qemu-devel@nongnu.org; Sun, 11 Feb 2018 04:36:18 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Sun, 11 Feb 2018 10:35:59 +0100
Message-Id: <20180211093607.27351-22-armbru@redhat.com>
In-Reply-To: <20180211093607.27351-1-armbru@redhat.com>
References: <20180211093607.27351-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 21/29] qapi/common: Fix guardname() for
 funny filenames
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mdroth@linux.vnet.ibm.com, marcandre.lureau@redhat.com, eblake@redhat.com

guardname() fails to return a valid C identifier for arguments
containing anything but [A-Za-z0-9_.-'].  Fix that.  Don't bother
protecting ticklish identifiers; header guards are all-caps, and no
ticklish identifiers are.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 scripts/qapi/common.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index de12f8469a..6e5152b173 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -1867,7 +1867,7 @@ def mcgen(code, **kwds):
=20
=20
 def guardname(filename):
-    return c_name(filename, protect=3DFalse).upper()
+    return re.sub(r'[^A-Za-z0-9_]', '_', filename).upper()
=20
=20
 def guardstart(name):
--=20
2.13.6
