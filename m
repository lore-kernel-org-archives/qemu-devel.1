Received: from eggs.gnu.org ([2001:4830:134:3::10]:46673)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cqk5f-0005J8-LT
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 13:30:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cqk5b-0003OL-Pn
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 13:30:31 -0400
From: Eric Blake <eblake@redhat.com>
Date: Wed, 22 Mar 2017 12:30:23 -0500
Message-Id: <20170322173023.22654-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH] fixup! qom: Avoid unvisited 'id'/'qom-type' in
 user_creatable_add_opts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, lvivier@redhat.com, qemu-stable@nongnu.org, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>

CC: qemu-stable@nongnu.org
Signed-off-by: Eric Blake <eblake@redhat.com>

---

Markus already issued the pull request, so if that goes in before
he can squash this for a v2, then I'll have to turn this into a
full-blown patch.

v3.5: avoid memory leak when id is not present
v3: enhance commit message
v2: new patch
---
 qom/object_interfaces.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/qom/object_interfaces.c b/qom/object_interfaces.c
index cc9a694..9c271ad 100644
--- a/qom/object_interfaces.c
+++ b/qom/object_interfaces.c
@@ -122,6 +122,7 @@ Object *user_creatable_add_opts(QemuOpts *opts, Error **errp)
     }
     if (!id) {
         error_setg(errp, QERR_MISSING_PARAMETER, "id");
+        g_free(type);
         return NULL;
     }

-- 
2.9.3
