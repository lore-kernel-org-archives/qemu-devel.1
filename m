Received: from eggs.gnu.org ([209.51.188.92]:38708)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gpbnT-0007Br-EA
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 11:36:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gpbnQ-0008Ch-Qt
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 11:36:06 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  1 Feb 2019 17:34:56 +0100
Message-Id: <20190201163518.31157-6-kwolf@redhat.com>
In-Reply-To: <20190201163518.31157-1-kwolf@redhat.com>
References: <20190201163518.31157-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 05/27] block: Replace qdict_put() by
 qdict_put_obj() where appropriate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

From: Markus Armbruster <armbru@redhat.com>

Patch created mechanically by rerunning:

  $  spatch --sp-file scripts/coccinelle/qobject.cocci \
	    --macro-file scripts/cocci-macro-file.h \
	    --dir block --in-place

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/blklogwrites.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/block/blklogwrites.c b/block/blklogwrites.c
index ff98cd5533..d2e01bdb1d 100644
--- a/block/blklogwrites.c
+++ b/block/blklogwrites.c
@@ -295,10 +295,9 @@ static void blk_log_writes_refresh_filename(BlockDri=
verState *bs,
         qdict_put_str(opts, "driver", "blklogwrites");
=20
         qobject_ref(bs->file->bs->full_open_options);
-        qdict_put_obj(opts, "file", QOBJECT(bs->file->bs->full_open_opti=
ons));
+        qdict_put(opts, "file", bs->file->bs->full_open_options);
         qobject_ref(s->log_file->bs->full_open_options);
-        qdict_put_obj(opts, "log",
-                      QOBJECT(s->log_file->bs->full_open_options));
+        qdict_put(opts, "log", s->log_file->bs->full_open_options);
         qdict_put_int(opts, "log-sector-size", s->sectorsize);
=20
         bs->full_open_options =3D opts;
--=20
2.20.1
