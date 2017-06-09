Received: from eggs.gnu.org ([2001:4830:134:3::10]:36983)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dJLiB-0003g5-44
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 11:20:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dJLi6-0006W8-KQ
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 11:20:31 -0400
From: Eric Blake <eblake@redhat.com>
Date: Fri,  9 Jun 2017 10:20:17 -0500
Message-Id: <20170609152017.7286-3-eblake@redhat.com>
In-Reply-To: <20170609152017.7286-1-eblake@redhat.com>
References: <20170609152017.7286-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH 2/2] qobject: Catch another straggler for use
 of qdict_put_str()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, marcandre.lureau@redhat.com, qemu-trivial@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>

Dan's addition of key-secret improvements in commit 29cf9336 was
developed prior to the addition of QDict scalar insertion macros,
but merged after the general cleanup in commit 46f5ac20.
Patch created mechanically by rerunning:
  spatch --sp-file scripts/coccinelle/qobject.cocci \
         --macro-file scripts/cocci-macro-file.h --dir . --in-place

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 qemu-img.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qemu-img.c b/qemu-img.c
index 0ad698d..6c972f7 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -355,7 +355,7 @@ static int img_add_key_secrets(void *opaque,
     QDict *options = opaque;

     if (g_str_has_suffix(name, "key-secret")) {
-        qdict_put(options, name, qstring_from_str(value));
+        qdict_put_str(options, name, value);
     }

     return 0;
-- 
2.9.4
