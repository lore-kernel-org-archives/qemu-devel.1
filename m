Received: from eggs.gnu.org ([209.51.188.92]:38108)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gn7Ae-0006A3-5N
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 14:29:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gn78r-0005gi-5m
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 14:27:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37146)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gn78r-0005gX-0K
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 14:27:53 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Fri, 25 Jan 2019 20:27:19 +0100
Message-Id: <20190125192719.15339-4-philmd@redhat.com>
In-Reply-To: <20190125192719.15339-1-philmd@redhat.com>
References: <20190125192719.15339-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 3/3] WIP tests/vm: Run tests on OpenBSD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Brad Smith <brad@comstyle.com>, Kamil Rytarowski <kamil@netbsd.org>, Peter Maydell <peter.maydell@linaro.org>
Cc: Fam Zheng <fam@euphon.net>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>, Thomas Huth <thuth@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Li Qiang <liq3ea@163.com>, Paolo Bonzini <pbonzini@redhat.com>

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 tests/vm/openbsd | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tests/vm/openbsd b/tests/vm/openbsd
index cfe0572c59..de907dd21c 100755
--- a/tests/vm/openbsd
+++ b/tests/vm/openbsd
@@ -25,9 +25,7 @@ class OpenBSDVM(basevm.BaseVM):
         cd $(mktemp -d /var/tmp/qemu-test.XXXXXX);
         tar -xf /dev/rsd1c;
         ./configure --cc=3Dx86_64-unknown-openbsd6.1-gcc-4.9.4 --python=3D=
python2.7 {configure_opts};
-        gmake --output-sync -j{jobs} {verbose};
-        # XXX: "gmake check" seems to always hang or fail
-        #gmake --output-sync -j{jobs} check {verbose};
+        gmake --output-sync -j{jobs} check {verbose};
     """
=20
     def build_image(self, img):
--=20
2.20.1
