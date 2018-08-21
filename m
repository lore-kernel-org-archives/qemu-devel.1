Received: from eggs.gnu.org ([2001:4830:134:3::10]:58298)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fs5Xq-0007Iu-HO
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 08:13:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fs5Px-0008KS-JW
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 08:05:55 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33478 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fs5Px-0008JZ-Ck
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 08:05:49 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1472B4021CC3
	for <qemu-devel@nongnu.org>; Tue, 21 Aug 2018 12:05:49 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 21 Aug 2018 14:05:33 +0200
Message-Id: <20180821120542.22610-4-kraxel@redhat.com>
In-Reply-To: <20180821120542.22610-1-kraxel@redhat.com>
References: <20180821120542.22610-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 03/12] ui: use enum to string helpers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: libvir-list@redhat.com, Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Minor code simplification.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Message-id: 20180801092508.4927-1-marcandre.lureau@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
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
2.9.3
