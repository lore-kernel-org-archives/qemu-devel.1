Received: from eggs.gnu.org ([209.51.188.92]:48145)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h38r0-0007jY-Ri
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 20:31:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h38r0-0003ce-2o
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 20:31:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44914)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1h38qz-0003bK-Qu
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 20:31:41 -0400
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Mon, 11 Mar 2019 01:30:51 +0100
Message-Id: <20190311003052.13778-5-philmd@redhat.com>
In-Reply-To: <20190311003052.13778-1-philmd@redhat.com>
References: <20190311003052.13778-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 4/5] NOTFORMERGE roms/edk2: Use
 arm-linux-gnueabihf-gcc on Debian based distribs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org, Laszlo Ersek <lersek@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, =?UTF-8?q?Michal=20Pr=C3=ADvozn=C3=ADk?= <mprivozn@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Fam Zheng <fam@euphon.net>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

Do not enforce GCCx_ARM_PREFIX=3Darm-linux-gnu- on Debian based
distributions.
This is a kludge not meant for merging!

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 roms/edk2-funcs.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/roms/edk2-funcs.sh b/roms/edk2-funcs.sh
index 402fc126fb..2f1fa2af1a 100644
--- a/roms/edk2-funcs.sh
+++ b/roms/edk2-funcs.sh
@@ -113,6 +113,11 @@ qemu_edk2_get_cross_prefix()
     # no cross-compiler needed
     :
   else
+    if [ -f /etc/lsb-release ] && [ "$gcc_arch" =3D arm ]; then
+      # XXX kludge for Debian-based distribs
+      printf 'arm-linux-gnueabihf-\n'
+      return 0
+    fi
     printf '%s-linux-gnu-\n' "$gcc_arch"
   fi
 }
--=20
2.20.1
