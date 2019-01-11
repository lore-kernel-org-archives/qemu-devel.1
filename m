Received: from eggs.gnu.org ([209.51.188.92]:49898)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gi1V0-0007lA-KP
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 13:25:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gi1Uz-0007JW-VH
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 13:25:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58613)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gi1Uz-0007JE-Pk
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 13:25:41 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri, 11 Jan 2019 16:25:32 -0200
Message-Id: <20190111182533.31593-2-ehabkost@redhat.com>
In-Reply-To: <20190111182533.31593-1-ehabkost@redhat.com>
References: <20190111182533.31593-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 1/2] configure: Let the TARGET_GPROF var use the
 regular 'y' for Yes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, "Emilio G. Cota" <cota@braap.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

All other variables are set using 'y', which is what the rules.mak
functions expect to parse.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-Id: <20190103150951.17592-2-philmd@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 configure | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure b/configure
index cf763d4674..0c433ec043 100755
--- a/configure
+++ b/configure
@@ -7490,7 +7490,7 @@ alpha)
 esac
=20
 if test "$gprof" =3D "yes" ; then
-  echo "TARGET_GPROF=3Dyes" >> $config_target_mak
+  echo "TARGET_GPROF=3Dy" >> $config_target_mak
   if test "$target_linux_user" =3D "yes" ; then
     cflags=3D"-p $cflags"
     ldflags=3D"-p $ldflags"
--=20
2.18.0.rc1.1.g3f1ff2140
