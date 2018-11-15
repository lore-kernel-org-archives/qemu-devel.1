Received: from eggs.gnu.org ([2001:4830:134:3::10]:48967)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eskultet@redhat.com>) id 1gNJOr-0004A6-OQ
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 10:17:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eskultet@redhat.com>) id 1gNJOl-0003Ml-4V
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 10:17:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44060)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eskultet@redhat.com>) id 1gNJOf-0003ES-J5
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 10:17:35 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 279B23002F84
	for <qemu-devel@nongnu.org>; Thu, 15 Nov 2018 15:17:26 +0000 (UTC)
From: Erik Skultety <eskultet@redhat.com>
Date: Thu, 15 Nov 2018 16:15:55 +0100
Message-Id: <9f7b6b74de7f2122378f1e140de84845fbaf3280.1542294676.git.eskultet@redhat.com>
In-Reply-To: <cover.1542294676.git.eskultet@redhat.com>
References: <cover.1542294676.git.eskultet@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 2/3] ui: Allow specifying 'rendernode' display
 option for egl-headless
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Erik Skultety <eskultet@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

As libvirt can't predict which rendernode QEMU would pick, it
won't adjust the permissions on the device, hence QEMU getting
"Permission denied" when opening the DRI device. Therefore, enable
'rendernode' option for egl-headless display type.

Resolves: https://bugzilla.redhat.com/show_bug.cgi?id=3D1648236

Signed-off-by: Erik Skultety <eskultet@redhat.com>
---
 ui/egl-headless.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ui/egl-headless.c b/ui/egl-headless.c
index 42a41310b0..4cf3bbc0e4 100644
--- a/ui/egl-headless.c
+++ b/ui/egl-headless.c
@@ -176,7 +176,7 @@ static void egl_headless_init(DisplayState *ds, Displ=
ayOptions *opts)
     egl_dpy *edpy;
     int idx;
=20
-    if (egl_rendernode_init(NULL, mode) < 0) {
+    if (egl_rendernode_init(opts->u.egl_headless.rendernode, mode) < 0) =
{
         error_report("egl: render node init failed");
         exit(1);
     }
--=20
2.19.1
