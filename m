Received: from eggs.gnu.org ([2001:4830:134:3::10]:52068)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1gQ7Kv-0008CP-28
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 04:01:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1gQ7Kp-0005yX-8x
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 04:01:17 -0500
Received: from mail-eopbgr60121.outbound.protection.outlook.com
	([40.107.6.121]:15680
	helo=EUR04-DB3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1gQ7Ko-0005wg-QA
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 04:01:11 -0500
From: Roman Kagan <rkagan@virtuozzo.com>
Date: Fri, 23 Nov 2018 09:01:06 +0000
Message-ID: <20181123090058.6931-1-rkagan@virtuozzo.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH] configure: fix elf2dmp check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Viktor Prutyanov <viktor.prutyanov@phystech.edu>
Cc: Paolo Bonzini <pbonzini@redhat.com>

elf2dmp is keyed on "$posix" =3D "yes", but "$posix" doesn't seem to be
set anywhere.

The original intent was presumably to skip building it on Windows, so
check for "$mingw32" =3D "no" instead.

Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>
---
 configure | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure b/configure
index 0a3c6a72c3..fc6ce0065d 100755
--- a/configure
+++ b/configure
@@ -5722,7 +5722,7 @@ if test "$want_tools" =3D "yes" ; then
   if [ "$ivshmem" =3D "yes" ]; then
     tools=3D"ivshmem-client\$(EXESUF) ivshmem-server\$(EXESUF) $tools"
   fi
-  if [ "$posix" =3D "yes" ] && [ "$curl" =3D "yes" ]; then
+  if [ "$mingw32" =3D "no" ] && [ "$curl" =3D "yes" ]; then
     tools=3D"elf2dmp $tools"
   fi
 fi
--=20
2.19.1
