Received: from eggs.gnu.org ([2001:4830:134:3::10]:36647)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefan@weilnetz.de>) id 1cswBz-0000vu-8A
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 14:50:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefan@weilnetz.de>) id 1cswBw-0000So-7j
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 14:50:07 -0400
Received: from mail.weilnetz.de ([37.120.169.71]:40732
	helo=v2201612906741603.powersrv.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefan@weilnetz.de>) id 1cswBw-0000Si-0Z
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 14:50:04 -0400
From: Stefan Weil <sw@weilnetz.de>
Date: Tue, 28 Mar 2017 20:49:59 +0200
Message-Id: <20170328184959.5550-1-sw@weilnetz.de>
Subject: [Qemu-devel] [PATCH for-2.9?] configure: Remove unused code (found
 by shellcheck)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Stefan Weil <sw@weilnetz.de>

smartcard_cflags is no longer needed since commit
0b22ef0f57a8910d849602bef0940edcd0553d2c.

Signed-off-by: Stefan Weil <sw@weilnetz.de>
---

This is a very old patch which I just found in my patch queue.
It's not mandatory for 2.9, but I also think that there is
no risk to apply it.

Sorry for sending it so late.

Regards
Stefan

 configure | 1 -
 1 file changed, 1 deletion(-)

diff --git a/configure b/configure
index d1ce33bc79..b65ea2931c 100755
--- a/configure
+++ b/configure
@@ -4096,7 +4096,6 @@ EOF
 fi
 
 # check for smartcard support
-smartcard_cflags=""
 if test "$smartcard" != "no"; then
     if $pkg_config libcacard; then
         libcacard_cflags=$($pkg_config --cflags libcacard)
-- 
2.11.0
