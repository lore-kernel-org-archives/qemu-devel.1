Received: from eggs.gnu.org ([208.118.235.92]:40340)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gf406-0001kI-3L
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 09:29:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gf405-0008H9-Ej
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 09:29:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45044)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gf405-0008Gw-9R
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 09:29:33 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Thu,  3 Jan 2019 15:29:18 +0100
Message-Id: <20190103142919.30090-2-philmd@redhat.com>
In-Reply-To: <20190103142919.30090-1-philmd@redhat.com>
References: <20190103142919.30090-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 1/2] configure: Let the TARGET_GPROF var use
 the regular 'y' for Yes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G . Cota" <cota@braap.org>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

All other variables are set using 'y', which is what the rules.mak
functions expect to parse.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 configure | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure b/configure
index 79375affc1..fa5c079f98 100755
--- a/configure
+++ b/configure
@@ -7470,7 +7470,7 @@ alpha)
 esac
=20
 if test "$gprof" =3D "yes" ; then
-  echo "TARGET_GPROF=3Dyes" >> $config_target_mak
+  echo "TARGET_GPROF=3Dy" >> $config_target_mak
   if test "$target_linux_user" =3D "yes" ; then
     cflags=3D"-p $cflags"
     ldflags=3D"-p $ldflags"
--=20
2.17.2
