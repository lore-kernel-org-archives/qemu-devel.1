Received: from eggs.gnu.org ([2001:4830:134:3::10]:60523)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fMElY-0001gc-IG
	for qemu-devel@nongnu.org; Fri, 25 May 2018 11:36:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fMElV-0005F0-Fy
	for qemu-devel@nongnu.org; Fri, 25 May 2018 11:36:28 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54488 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1fMElV-00058f-C5
	for qemu-devel@nongnu.org; Fri, 25 May 2018 11:36:25 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1EB5FBB413
	for <qemu-devel@nongnu.org>; Fri, 25 May 2018 15:36:19 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 25 May 2018 17:36:09 +0200
Message-Id: <20180525153609.13187-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] configure: print virglrenderer version
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 configure | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/configure b/configure
index a8498ab393..4662e07a75 100755
--- a/configure
+++ b/configure
@@ -4606,6 +4606,7 @@ int main(void) { virgl_renderer_poll(); return 0; }
 EOF
   virgl_cflags=3D$($pkg_config --cflags virglrenderer 2>/dev/null)
   virgl_libs=3D$($pkg_config --libs virglrenderer 2>/dev/null)
+  virgl_version=3D$($pkg_config --modversion virglrenderer 2>/dev/null)
   if $pkg_config virglrenderer >/dev/null 2>&1 && \
      compile_prog "$virgl_cflags" "$virgl_libs" ; then
     virglrenderer=3D"yes"
@@ -5809,7 +5810,7 @@ echo "nettle            $nettle $(echo_version $net=
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
2.17.0.253.g3dd125b46d
