Received: from eggs.gnu.org ([2001:4830:134:3::10]:51147)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eeiZp-0005U6-AU
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 09:32:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eeiZl-0006t2-5r
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 09:32:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58150)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eeiZl-0006s0-12
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 09:32:25 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5D93212E4FC
	for <qemu-devel@nongnu.org>; Thu, 25 Jan 2018 14:32:24 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 25 Jan 2018 15:32:16 +0100
Message-Id: <20180125143218.29528-7-kraxel@redhat.com>
In-Reply-To: <20180125143218.29528-1-kraxel@redhat.com>
References: <20180125143218.29528-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 6/8] ui: deprecate use of SDL 1.2 in favour of
 2.0 series
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Daniel P. Berrange" <berrange@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

From: "Daniel P. Berrange" <berrange@redhat.com>

The SDL 2.0 release was made in Aug, 2013:

  https://www.libsdl.org/release/

That will soon be 4 + 1/2 years ago, which is enough time to consider
the 2.0 series widely supported.

Thus we deprecate the SDL 1.2 support, which will allow us to delete it
in the last release of 2018. By this time, SDL 2.0 will be more than 5
years old.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-id: 20180115142533.24585-1-berrange@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 configure     | 6 ++++++
 ui/sdl.c      | 3 +++
 qemu-doc.texi | 7 +++++++
 3 files changed, 16 insertions(+)

diff --git a/configure b/configure
index 044c6fafe2..96dee6572c 100755
--- a/configure
+++ b/configure
@@ -5668,6 +5668,12 @@ if test "$gtkabi" =3D "2.0"; then
     echo "WARNING: future releases. Please switch to using GTK 3.0"
 fi
=20
+if test "$sdlabi" =3D "1.2"; then
+    echo
+    echo "WARNING: Use of SDL 1.2 is deprecated and will be removed in"
+    echo "WARNING: future releases. Please switch to using SDL 2.0"
+fi
+
 if test "$supported_cpu" =3D "no"; then
     echo
     echo "WARNING: SUPPORT FOR THIS HOST CPU WILL GO AWAY IN FUTURE RELE=
ASES!"
diff --git a/ui/sdl.c b/ui/sdl.c
index afb4992da2..f26048d3a2 100644
--- a/ui/sdl.c
+++ b/ui/sdl.c
@@ -918,6 +918,9 @@ void sdl_display_init(DisplayState *ds, int full_scre=
en, int no_frame)
             exit(1);
     }
=20
+    g_printerr("Running QEMU with SDL 1.2 is deprecated, and will be rem=
oved\n"
+               "in a future release. Please switch to SDL 2.0 instead\n"=
);
+
     if (no_frame)
         gui_noframe =3D 1;
=20
diff --git a/qemu-doc.texi b/qemu-doc.texi
index 3e9eb819a6..79d08b3f04 100644
--- a/qemu-doc.texi
+++ b/qemu-doc.texi
@@ -2596,6 +2596,13 @@ and 3.x series APIs. Support for the GTK 2.x build=
s will be
 discontinued, so maintainers should switch to using GTK 3.x,
 which is the default.
=20
+@subsection SDL 1.2
+
+Previously QEMU has supported building against both SDL 1.2
+and 2.0 series APIs. Support for the SDL 1.2 builds will be
+discontinued, so maintainers should switch to using SDL 2.0,
+which is the default.
+
 @section System emulator command line arguments
=20
 @subsection -tdf (since 1.3.0)
--=20
2.9.3
