Received: from eggs.gnu.org ([2001:4830:134:3::10]:52939)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fb6eM-0004KI-4X
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 11:58:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fb6eL-00053P-9g
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 11:58:30 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu,  5 Jul 2018 12:58:05 -0300
Message-Id: <20180705155811.20366-2-f4bug@amsat.org>
In-Reply-To: <20180705155811.20366-1-f4bug@amsat.org>
References: <20180705155811.20366-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 1/7] qobject: Catch another straggler for
 use of qdict_put_str()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-trivial@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>

Patch created mechanically by rerunning:

  $  spatch --sp-file scripts/coccinelle/qobject.cocci \
            --macro-file scripts/cocci-macro-file.h \
            --dir . --in-place

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
---
 qobject/block-qdict.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qobject/block-qdict.c b/qobject/block-qdict.c
index 80c653013f..ae363708ab 100644
--- a/qobject/block-qdict.c
+++ b/qobject/block-qdict.c
@@ -572,7 +572,7 @@ static QObject *qdict_crumple_for_keyval_qiv(QDict *src, Error **errp)
         if (!tmp) {
             tmp = qdict_clone_shallow(src);
         }
-        qdict_put(tmp, ent->key, qstring_from_str(s));
+        qdict_put_str(tmp, ent->key, s);
         g_free(buf);
     }
 
-- 
2.18.0
