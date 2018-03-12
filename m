Received: from eggs.gnu.org ([2001:4830:134:3::10]:49929)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1evJXA-0007CG-Bb
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 05:14:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1evJX5-0004YT-3V
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 05:14:20 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49946 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1evJX4-0004Vz-UX
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 05:14:15 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BF8EEBD9E
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 09:14:10 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 12 Mar 2018 10:13:54 +0100
Message-Id: <20180312091405.19610-4-kraxel@redhat.com>
In-Reply-To: <20180312091405.19610-1-kraxel@redhat.com>
References: <20180312091405.19610-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 03/14] sdl: workaround bug in sdl 2.0.8 headers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D892087

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Message-id: 20180307154258.9313-1-kraxel@redhat.com
---
 configure | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configure b/configure
index 356abee025..8c7124bf2b 100755
--- a/configure
+++ b/configure
@@ -2875,6 +2875,7 @@ if test "$sdl" !=3D "no" ; then
 int main( void ) { return SDL_Init (SDL_INIT_VIDEO); }
 EOF
   sdl_cflags=3D$($sdlconfig --cflags 2>/dev/null)
+  sdl_cflags=3D"$sdl_cflags -Wno-undef"  # workaround 2.0.8 bug
   if test "$static" =3D "yes" ; then
     if $pkg_config $sdlname --exists; then
       sdl_libs=3D$($pkg_config $sdlname --static --libs 2>/dev/null)
--=20
2.9.3
