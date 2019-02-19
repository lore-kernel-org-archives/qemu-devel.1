Received: from eggs.gnu.org ([209.51.188.92]:49541)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gw4jo-0002EM-Pb
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 07:43:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gw4jo-0003vU-0U
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 07:43:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42332)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gw4jn-0003tN-OC
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 07:43:03 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7C79683F44
	for <qemu-devel@nongnu.org>; Tue, 19 Feb 2019 12:43:02 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 19 Feb 2019 13:42:57 +0100
Message-Id: <20190219124257.3001-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH v2] audio: don't build alsa and sdl by default
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
Cc: berrange@redhat.com, Gerd Hoffmann <kraxel@redhat.com>, david@redhat.com

In case no sound hardware is present both alsa and sdl drivers
initialize successfully and throw errors later on, i.e. effectively
the automatic probing doesn't work.  Drop them from the list of
default audio drivers for linux because of that.

Fixes: 6a48541873 audio: probe audio drivers by default
Buglink: https://bugs.launchpad.net/qemu/+bug/1816052
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 configure | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure b/configure
index fbd0825488..651b4f7514 100755
--- a/configure
+++ b/configure
@@ -877,7 +877,7 @@ Haiku)
   LIBS="-lposix_error_mapper -lnetwork $LIBS"
 ;;
 Linux)
-  audio_drv_list="try-pa try-alsa try-sdl oss"
+  audio_drv_list="try-pa oss"
   audio_possible_drivers="oss alsa sdl pa"
   linux="yes"
   linux_user="yes"
-- 
2.9.3
