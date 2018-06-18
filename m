Received: from eggs.gnu.org ([2001:4830:134:3::10]:45616)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fUqvG-0001K0-5W
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 05:58:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fUqvF-0003Jf-FC
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 05:58:06 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 18 Jun 2018 11:57:55 +0200
Message-Id: <20180618095758.5006-2-kraxel@redhat.com>
In-Reply-To: <20180618095758.5006-1-kraxel@redhat.com>
References: <20180618095758.5006-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 1/4] configure: print virglrenderer version
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-arm@nongnu.org, Richard Henderson <rth@twiddle.net>, Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: J=C3=A1n Tomko <jtomko@redhat.com>
Message-id: 20180525153609.13187-1-marcandre.lureau@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 configure | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/configure b/configure
index a8c4094c87..6b2bcb3a0d 100755
--- a/configure
+++ b/configure
@@ -4599,6 +4599,7 @@ int main(void) { virgl_renderer_poll(); return 0; }
 EOF
   virgl_cflags=3D$($pkg_config --cflags virglrenderer 2>/dev/null)
   virgl_libs=3D$($pkg_config --libs virglrenderer 2>/dev/null)
+  virgl_version=3D$($pkg_config --modversion virglrenderer 2>/dev/null)
   if $pkg_config virglrenderer >/dev/null 2>&1 && \
      compile_prog "$virgl_cflags" "$virgl_libs" ; then
     virglrenderer=3D"yes"
@@ -5827,7 +5828,7 @@ echo "nettle            $nettle $(echo_version $net=
tle $nettle_version)"
 echo "nettle kdf        $nettle_kdf"
 echo "libtasn1          $tasn1"
 echo "curses support    $curses"
-echo "virgl support     $virglrenderer"
+echo "virgl support     $virglrenderer $(echo_version $virglrenderer $vi=
rgl_version)"
 echo "curl support      $curl"
 echo "mingw32 support   $mingw32"
 echo "Audio drivers     $audio_drv_list"
--=20
2.9.3
