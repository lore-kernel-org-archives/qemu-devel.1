Received: from eggs.gnu.org ([2001:4830:134:3::10]:52086)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1gG2u5-0001wb-SS
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 10:15:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1gG2tz-0005wJ-1M
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 10:15:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35008)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1gG2tu-0005ma-1S
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 10:15:47 -0400
From: Fam Zheng <famz@redhat.com>
Date: Fri, 26 Oct 2018 22:15:21 +0800
Message-Id: <20181026141529.4305-2-famz@redhat.com>
In-Reply-To: <20181026141529.4305-1-famz@redhat.com>
References: <20181026141529.4305-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 1/9] tests: docker: update test-mingw for GTK+
 2.0 removal
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

From: Paolo Bonzini <pbonzini@redhat.com>

--with-gtkabi does not exist anymore; remove it from the configure invoca=
tion.

Fixes: 89d85cde75143325205e332dd97bf1bb8402d7c1
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-Id: <1539886203-33670-1-git-send-email-pbonzini@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Fam Zheng <famz@redhat.com>
---
 tests/docker/test-mingw | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tests/docker/test-mingw b/tests/docker/test-mingw
index 7cca7e16a6..b078f22879 100755
--- a/tests/docker/test-mingw
+++ b/tests/docker/test-mingw
@@ -28,8 +28,7 @@ for prefix in x86_64-w64-mingw32- i686-w64-mingw32-; do
         --enable-vnc \
         --enable-bzip2 \
         --enable-guest-agent \
-        --with-sdlabi=3D2.0 \
-        --with-gtkabi=3D3.0
+        --with-sdlabi=3D2.0
     install_qemu
     make clean
=20
--=20
2.17.1
