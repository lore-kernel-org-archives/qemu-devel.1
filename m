Received: from eggs.gnu.org ([209.51.188.92]:35705)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1goXfE-00051n-VP
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 12:59:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1goXfD-0002UW-JW
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 12:59:12 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Tue, 29 Jan 2019 18:53:59 +0100
Message-Id: <20190129175403.18017-15-philmd@redhat.com>
In-Reply-To: <20190129175403.18017-1-philmd@redhat.com>
References: <20190129175403.18017-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 14/18] tests/vm: Run tests on OpenBSD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Brad Smith <brad@comstyle.com>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, Fam Zheng <fam@euphon.net>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Kamil Rytarowski <kamil@netbsd.org>

Now than failing tests are commented out, let's reenable the testing
of this OS.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 tests/vm/openbsd | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tests/vm/openbsd b/tests/vm/openbsd
index 7c456e9706..ff6d5fa549 100755
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
