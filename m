Received: from eggs.gnu.org ([2001:4830:134:3::10]:48474)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <otubo@redhat.com>) id 1fsqyY-0003zI-Ca
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 10:52:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <otubo@redhat.com>) id 1fsqyX-0008FX-FP
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 10:52:42 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55754 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <otubo@redhat.com>) id 1fsqyX-0008FH-A5
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 10:52:41 -0400
From: Eduardo Otubo <otubo@redhat.com>
Date: Thu, 23 Aug 2018 16:52:29 +0200
Message-Id: <20180823145230.13183-4-otubo@redhat.com>
In-Reply-To: <20180823145230.13183-1-otubo@redhat.com>
References: <20180823145230.13183-1-otubo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 3/4] configure: require libseccomp 2.2.0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, marcandre.lureau@redhat.com, pmoore@redhat.com, berrange@redhat.com, eblake@redhat.com

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

The following patch is going to require TSYNC, which is only available
since libseccomp 2.2.0.

libseccomp 2.2.0 was released February 12, 2015.

According to repology, libseccomp version in different distros:

  RHEL-7: 2.3.1
  Debian (Stretch): 2.3.1
  OpenSUSE Leap 15: 2.3.2
  Ubuntu (Xenial):  2.3.1

This will drop support for -sandbox on:

  Debian (Jessie): 2.1.1 (but 2.2.3 in backports)

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Acked-by: Eduardo Otubo <otubo@redhat.com>
---
 configure | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/configure b/configure
index e7bddc04b0..5fc2915096 100755
--- a/configure
+++ b/configure
@@ -2228,13 +2228,10 @@ fi
 ##########################################
 # libseccomp check
=20
+libseccomp_minver=3D"2.2.0"
 if test "$seccomp" !=3D "no" ; then
     case "$cpu" in
-    i386|x86_64)
-        libseccomp_minver=3D"2.1.0"
-        ;;
-    mips)
-        libseccomp_minver=3D"2.2.0"
+    i386|x86_64|mips)
         ;;
     arm|aarch64)
         libseccomp_minver=3D"2.2.3"
--=20
2.17.1
