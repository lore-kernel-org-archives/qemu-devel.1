Received: from eggs.gnu.org ([209.51.188.92]:35146)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1goXdS-0003Nf-DR
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 12:57:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1goXdQ-0001Tg-9I
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 12:57:22 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Tue, 29 Jan 2019 18:53:54 +0100
Message-Id: <20190129175403.18017-10-philmd@redhat.com>
In-Reply-To: <20190129175403.18017-1-philmd@redhat.com>
References: <20190129175403.18017-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 09/18] tests/vm/openbsd: Install Bash from
 the ports
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

Various iotests scripts (run via 'make check-block')  use bash
specific extentions.  OpenBSD comes with the Korn shell as default.
Install bash to be able to run those tests.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 tests/vm/openbsd | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/vm/openbsd b/tests/vm/openbsd
index 6263c8956b..e9c2a3f2c8 100755
--- a/tests/vm/openbsd
+++ b/tests/vm/openbsd
@@ -45,6 +45,8 @@ class OpenBSDVM(basevm.BaseVM):
         self.wait_ssh()
         sys.stderr.write("Disabling W^X on the build partition...\n")
         self.ssh_root_check("sed -E -i 's_(/tmp\ ffs)\ ([^\ ]*)_\\1 \\2,=
wxallowed_' /etc/fstab")
+        sys.stderr.write("Installing bash...\n")
+        self.ssh_root_check("PKG_PATH=3Dhttps://ftp.openbsd.org/pub/Open=
BSD/6.1/packages/amd64 pkg_add bash")
         self.ssh_root("shutdown -p now")
         self.wait()
=20
--=20
2.20.1
