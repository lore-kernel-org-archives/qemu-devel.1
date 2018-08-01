Received: from eggs.gnu.org ([2001:4830:134:3::10]:38567)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fknNh-0008SK-Et
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 05:25:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fknNe-0005qP-4v
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 05:25:21 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48138 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1fknNd-0005qF-T3
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 05:25:18 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DDE8740241C0
	for <qemu-devel@nongnu.org>; Wed,  1 Aug 2018 09:25:16 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed,  1 Aug 2018 11:25:08 +0200
Message-Id: <20180801092508.4927-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] ui: use enum to string helpers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

Minor code simplification.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 qemu-keymap.c | 2 +-
 ui/console.c  | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/qemu-keymap.c b/qemu-keymap.c
index 6216371aa1..4d00468747 100644
--- a/qemu-keymap.c
+++ b/qemu-keymap.c
@@ -84,7 +84,7 @@ static void walk_map(struct xkb_keymap *map, xkb_keycod=
e_t code, void *data)
     }
     fprintf(outfile, "# evdev %d (0x%x), QKeyCode \"%s\", number 0x%x\n"=
,
             evdev, evdev,
-            QKeyCode_lookup.array[qcode],
+            QKeyCode_str(qcode),
             qcode_to_number(qcode));
=20
     /*
diff --git a/ui/console.c b/ui/console.c
index bc58458ee8..3a285bae00 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -2319,7 +2319,7 @@ bool qemu_display_find_default(DisplayOptions *opts=
)
=20
     for (i =3D 0; i < ARRAY_SIZE(prio); i++) {
         if (dpys[prio[i]] =3D=3D NULL) {
-            ui_module_load_one(DisplayType_lookup.array[prio[i]]);
+            ui_module_load_one(DisplayType_str(prio[i]));
         }
         if (dpys[prio[i]] =3D=3D NULL) {
             continue;
@@ -2337,11 +2337,11 @@ void qemu_display_early_init(DisplayOptions *opts=
)
         return;
     }
     if (dpys[opts->type] =3D=3D NULL) {
-        ui_module_load_one(DisplayType_lookup.array[opts->type]);
+        ui_module_load_one(DisplayType_str(opts->type));
     }
     if (dpys[opts->type] =3D=3D NULL) {
         error_report("Display '%s' is not available.",
-                     DisplayType_lookup.array[opts->type]);
+                     DisplayType_str(opts->type));
         exit(1);
     }
     if (dpys[opts->type]->early_init) {
--=20
2.18.0.321.gffc6fa0e39
