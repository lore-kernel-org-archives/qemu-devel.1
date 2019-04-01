Received: from eggs.gnu.org ([209.51.188.92]:46814)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1hAxgO-00064l-TI
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 10:13:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1hAxgJ-0006wD-LR
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 10:13:04 -0400
From: Laurent Vivier <lvivier@redhat.com>
Date: Mon,  1 Apr 2019 16:12:20 +0200
Message-Id: <20190401141222.30034-4-lvivier@redhat.com>
In-Reply-To: <20190401141222.30034-1-lvivier@redhat.com>
References: <20190401141222.30034-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 3/5] configure: qemu-ga is only needed with
 softmmu targets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, qemu-s390x@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, Richard Henderson <rth@twiddle.net>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Laurent Vivier <lvivier@redhat.com>

Remove it from the list of tools if --disable-system
and --disable-tools are used as we don't need it for
linux-user targets.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
[lv: I also disable it with disable-tools, not only with disable-system]
Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 configure | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/configure b/configure
index 1c563a70276a..b627efede6cf 100755
--- a/configure
+++ b/configure
@@ -6083,7 +6083,9 @@ fi
 # Probe for guest agent support/options
=20
 if [ "$guest_agent" !=3D "no" ]; then
-  if [ "$linux" =3D "yes" -o "$bsd" =3D "yes" -o "$solaris" =3D "yes" -o=
 "$mingw32" =3D "yes" ] ; then
+  if [ "$softmmu" =3D no -a "$want_tools" =3D no ] ; then
+      guest_agent=3Dno
+  elif [ "$linux" =3D "yes" -o "$bsd" =3D "yes" -o "$solaris" =3D "yes" =
-o "$mingw32" =3D "yes" ] ; then
       tools=3D"qemu-ga $tools"
       guest_agent=3Dyes
   elif [ "$guest_agent" !=3D yes ]; then
--=20
2.20.1
