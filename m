Received: from eggs.gnu.org ([2001:4830:134:3::10]:40653)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1erU6y-0000yi-Ti
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 14:43:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1erU6y-0007nJ-3D
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 14:43:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48676)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1erU6x-0007mc-R3
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 14:43:28 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 11F8FC04AC5F
	for <qemu-devel@nongnu.org>; Thu,  1 Mar 2018 19:43:27 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Thu,  1 Mar 2018 13:42:36 -0600
Message-Id: <20180301194245.29854-22-eblake@redhat.com>
In-Reply-To: <20180301194245.29854-1-eblake@redhat.com>
References: <20180301194245.29854-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 21/30] qapi/common: Fix guardname() for funny
 filenames
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>

From: Markus Armbruster <armbru@redhat.com>

guardname() fails to return a valid C identifier for arguments
containing anything but [A-Za-z0-9_.-'].  Fix that.  Don't bother
protecting ticklish identifiers; header guards are all-caps, and no
ticklish identifiers are.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <20180211093607.27351-22-armbru@redhat.com>
Reviewed-by: Michael Roth <mdroth@linux.vnet.ibm.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 scripts/qapi/common.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index 547656c8b29..069ec3715d7 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -1867,7 +1867,7 @@ def mcgen(code, **kwds):


 def guardname(filename):
-    return c_name(filename, protect=3DFalse).upper()
+    return re.sub(r'[^A-Za-z0-9_]', '_', filename).upper()


 def guardstart(name):
--=20
2.14.3
