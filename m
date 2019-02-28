Received: from eggs.gnu.org ([209.51.188.92]:52960)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gzIco-00031m-My
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 05:09:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gzIcm-0000xP-Pv
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 05:09:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56760)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gzIck-0000ql-Os
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 05:09:08 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 24CEFC71BD
	for <qemu-devel@nongnu.org>; Thu, 28 Feb 2019 10:09:02 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 28 Feb 2019 11:08:56 +0100
Message-Id: <20190228100858.28397-4-kraxel@redhat.com>
In-Reply-To: <20190228100858.28397-1-kraxel@redhat.com>
References: <20190228100858.28397-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 3/5] audio: don't build alsa and sdl by default
 on linux
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

In case no sound hardware is present both alsa and sdl drivers
initialize successfully and throw errors later on, i.e. effectively
the automatic probing doesn't work.  Drop them from the list of
default audio drivers for linux because of that.

Fixes: 6a48541873 audio: probe audio drivers by default
Buglink: https://bugs.launchpad.net/qemu/+bug/1816052
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Tested-by: David Hildenbrand <david@redhat.com>
Message-id: 20190219124257.3001-1-kraxel@redhat.com
---
 configure | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure b/configure
index 694088a4ec99..540bee19ba1d 100755
--- a/configure
+++ b/configure
@@ -879,7 +879,7 @@ Haiku)
   LIBS=3D"-lposix_error_mapper -lnetwork $LIBS"
 ;;
 Linux)
-  audio_drv_list=3D"try-pa try-alsa try-sdl oss"
+  audio_drv_list=3D"try-pa oss"
   audio_possible_drivers=3D"oss alsa sdl pa"
   linux=3D"yes"
   linux_user=3D"yes"
--=20
2.9.3
