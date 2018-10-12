Received: from eggs.gnu.org ([2001:4830:134:3::10]:34236)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gAxNw-0006qT-Sf
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 09:21:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gAxNr-0002Xp-UU
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 09:21:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47370)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gAxNr-0002WU-Kq
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 09:21:39 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D7D8130026CD
	for <qemu-devel@nongnu.org>; Fri, 12 Oct 2018 13:21:38 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 12 Oct 2018 15:21:35 +0200
Message-Id: <20181012132135.12313-4-kraxel@redhat.com>
In-Reply-To: <20181012132135.12313-1-kraxel@redhat.com>
References: <20181012132135.12313-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 3/3] gtk: fix uninitialized variable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

From: Paolo Bonzini <pbonzini@redhat.com>

zoom_to_fit is never initialized to false, Coverity complains
(not sure why GCC does not).

Fixes: e8b1386ea1719525a1a92df03377764703fe8c64
Cc: kraxel@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-id: 20181003121138.22037-1-pbonzini@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/gtk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ui/gtk.c b/ui/gtk.c
index 1d68276253..c4dd17a6fa 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -2138,7 +2138,7 @@ static GSList *gd_vc_gfx_init(GtkDisplayState *s, V=
irtualConsole *vc,
                               QemuConsole *con, int idx,
                               GSList *group, GtkWidget *view_menu)
 {
-    bool zoom_to_fit;
+    bool zoom_to_fit =3D false;
=20
     vc->label =3D qemu_console_get_label(con);
     vc->s =3D s;
--=20
2.9.3
