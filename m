Received: from eggs.gnu.org ([2001:4830:134:3::10]:36907)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dJLi4-0003co-Cf
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 11:20:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dJLi3-0006UO-Jt
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 11:20:24 -0400
From: Eric Blake <eblake@redhat.com>
Date: Fri,  9 Jun 2017 10:20:16 -0500
Message-Id: <20170609152017.7286-2-eblake@redhat.com>
In-Reply-To: <20170609152017.7286-1-eblake@redhat.com>
References: <20170609152017.7286-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH 1/2] qobject: Update coccinelle script to catch
 Q{INC, DEC}REF
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, marcandre.lureau@redhat.com, qemu-trivial@nongnu.org

A recent patch submission was about to use qobject_decref(QOBJECT(E)),
even though we already have QDECREF(E) for that purpose.  While our
tree is currently free from the longhand form, we might as well update
our coccinelle script to catch any future relapses.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 scripts/coccinelle/qobject.cocci | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/scripts/coccinelle/qobject.cocci b/scripts/coccinelle/qobject.cocci
index 97703a4..656dc3e 100644
--- a/scripts/coccinelle/qobject.cocci
+++ b/scripts/coccinelle/qobject.cocci
@@ -3,6 +3,12 @@
 expression Obj, Key, E;
 @@
 (
+- qobject_incref(QOBJECT(E));
++ QINCREF(E);
+|
+- qobject_decref(QOBJECT(E));
++ QDECREF(E);
+|
 - qdict_put_obj(Obj, Key, QOBJECT(E));
 + qdict_put(Obj, Key, E);
 |
-- 
2.9.4
