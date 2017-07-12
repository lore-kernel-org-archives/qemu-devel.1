Received: from eggs.gnu.org ([2001:4830:134:3::10]:35714)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dVHyP-0006kq-Ob
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 09:46:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dVHyL-0003PG-CG
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 09:46:37 -0400
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Wed, 12 Jul 2017 16:38:08 +0300
Message-Id: <9f98da52e8bf0515d204861bbef2bf4d5abb618f.1499866676.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1499866676.git.mjt@msgid.tls.msk.ru>
References: <cover.1499866676.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1499866676.git.mjt@msgid.tls.msk.ru>
References: <cover.1499866676.git.mjt@msgid.tls.msk.ru>
Subject: [Qemu-devel] [PULL 12/13] qobject: Catch another straggler for use
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
Cc: Eric Blake <eblake@redhat.com>, qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>

From: Eric Blake <eblake@redhat.com>

Dan's addition of key-secret improvements in commit 29cf9336 was
developed prior to the addition of QDict scalar insertion macros,
but merged after the general cleanup in commit 46f5ac20.
Patch created mechanically by rerunning:
  spatch --sp-file scripts/coccinelle/qobject.cocci \
         --macro-file scripts/cocci-macro-file.h --dir . --in-place

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 qemu-img.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qemu-img.c b/qemu-img.c
index f7ffb79db6..02900ce1d1 100644
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
2.11.0
