Received: from eggs.gnu.org ([2001:4830:134:3::10]:33666)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gAlFM-0006ct-Sb
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 20:24:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gAlFL-0006lF-4z
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 20:24:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44932)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gAlFK-0006ko-VQ
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 20:24:03 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 51846308A95D
	for <qemu-devel@nongnu.org>; Fri, 12 Oct 2018 00:24:02 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Fri, 12 Oct 2018 02:22:17 +0200
Message-Id: <20181012002217.2864-12-philmd@redhat.com>
In-Reply-To: <20181012002217.2864-1-philmd@redhat.com>
References: <20181012002217.2864-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 11/11] chardev: FDChardev::max_size be
 unsigned
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Prasad J Pandit <ppandit@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, qemu-devel@nongnu.org, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 chardev/char-fd.c         | 2 +-
 include/chardev/char-fd.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/chardev/char-fd.c b/chardev/char-fd.c
index bb426fa4b1..900da2f935 100644
--- a/chardev/char-fd.c
+++ b/chardev/char-fd.c
@@ -43,7 +43,7 @@ static gboolean fd_chr_read(QIOChannel *chan, GIOCondit=
ion cond, void *opaque)
 {
     Chardev *chr =3D CHARDEV(opaque);
     FDChardev *s =3D FD_CHARDEV(opaque);
-    int len;
+    size_t len;
     uint8_t buf[CHR_READ_BUF_LEN];
     ssize_t ret;
=20
diff --git a/include/chardev/char-fd.h b/include/chardev/char-fd.h
index e7c2b176f9..36c6b89cee 100644
--- a/include/chardev/char-fd.h
+++ b/include/chardev/char-fd.h
@@ -31,7 +31,7 @@ typedef struct FDChardev {
     Chardev parent;
=20
     QIOChannel *ioc_in, *ioc_out;
-    int max_size;
+    size_t max_size;
 } FDChardev;
=20
 #define TYPE_CHARDEV_FD "chardev-fd"
--=20
2.17.1
