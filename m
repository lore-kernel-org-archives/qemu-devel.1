Received: from eggs.gnu.org ([209.51.188.92]:54046)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1guc3N-000615-LL
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 06:53:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1guc3M-0000Vz-JU
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 06:53:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34120)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1guc3M-0000CF-8r
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 06:53:12 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5EC711555C
	for <qemu-devel@nongnu.org>; Fri, 15 Feb 2019 11:52:44 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 15 Feb 2019 12:52:39 +0100
Message-Id: <20190215115239.3159-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] build-sys: remove baum SDL CFLAGS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

SDL dependency was removed in commit
f29b3431f6294168e5f8fc63edb91c15c6a08e41.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 chardev/Makefile.objs | 1 -
 1 file changed, 1 deletion(-)

diff --git a/chardev/Makefile.objs b/chardev/Makefile.objs
index d68e1347f9..7749bc0ec2 100644
--- a/chardev/Makefile.objs
+++ b/chardev/Makefile.objs
@@ -19,7 +19,6 @@ chardev-obj-$(CONFIG_WIN32) +=3D char-win-stdio.o
=20
 common-obj-y +=3D msmouse.o wctablet.o testdev.o
 common-obj-$(CONFIG_BRLAPI) +=3D baum.o
-baum.o-cflags :=3D $(SDL_CFLAGS)
 baum.o-libs :=3D $(BRLAPI_LIBS)
=20
 common-obj-$(CONFIG_SPICE) +=3D spice.o
--=20
2.21.0.rc1
