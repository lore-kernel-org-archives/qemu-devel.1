Received: from eggs.gnu.org ([2001:4830:134:3::10]:37938)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1etbDY-0006o6-EO
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 10:43:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1etbDX-0004XG-DK
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 10:43:00 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42666 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1etbDX-0004Wq-8z
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 10:42:59 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CCA274023EFF
	for <qemu-devel@nongnu.org>; Wed,  7 Mar 2018 15:42:58 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed,  7 Mar 2018 16:42:57 +0100
Message-Id: <20180307154258.9313-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH] sdl: workaround bug in sdl 2.0.8 headers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=892087

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 configure | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configure b/configure
index 6f3921c02a..86240f97ac 100755
--- a/configure
+++ b/configure
@@ -2874,6 +2874,7 @@ if test "$sdl" != "no" ; then
 int main( void ) { return SDL_Init (SDL_INIT_VIDEO); }
 EOF
   sdl_cflags=$($sdlconfig --cflags 2>/dev/null)
+  sdl_cflags="$sdl_cflags -Wno-undef"  # workaround 2.0.8 bug
   if test "$static" = "yes" ; then
     if $pkg_config $sdlname --exists; then
       sdl_libs=$($pkg_config $sdlname --static --libs 2>/dev/null)
-- 
2.9.3
