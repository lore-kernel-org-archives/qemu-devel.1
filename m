Received: from eggs.gnu.org ([2001:4830:134:3::10]:46553)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fV5iv-0002XT-Oj
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 21:46:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fV5iu-0000LM-Qn
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 21:46:21 -0400
Sender: fluxion <flukshun@gmail.com>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 18 Jun 2018 20:41:31 -0500
Message-Id: <20180619014319.28272-6-mdroth@linux.vnet.ibm.com>
In-Reply-To: <20180619014319.28272-1-mdroth@linux.vnet.ibm.com>
References: <20180619014319.28272-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 005/113] sdl: workaround bug in sdl 2.0.8
 headers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, Greg Kurz <groug@kaod.org>

From: Gerd Hoffmann <kraxel@redhat.com>

https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=892087

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-id: 20180307154258.9313-1-kraxel@redhat.com
(cherry picked from commit 2ca5c43091324a68772dc348cdf157c63888c168)
Signed-off-by: Greg Kurz <groug@kaod.org>
---
 configure | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configure b/configure
index 087a82ac50..3c8e66c750 100755
--- a/configure
+++ b/configure
@@ -2788,6 +2788,7 @@ if test "$sdl" != "no" ; then
 int main( void ) { return SDL_Init (SDL_INIT_VIDEO); }
 EOF
   sdl_cflags=$($sdlconfig --cflags 2>/dev/null)
+  sdl_cflags="$sdl_cflags -Wno-undef"  # workaround 2.0.8 bug
   if test "$static" = "yes" ; then
     if $pkg_config $sdlname --exists; then
       sdl_libs=$($pkg_config $sdlname --static --libs 2>/dev/null)
-- 
2.11.0
