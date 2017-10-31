Received: from eggs.gnu.org ([2001:4830:134:3::10]:38777)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1e9YKs-0000ox-Fc
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 11:20:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1e9YKp-0000Ti-A2
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 11:20:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60322)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1e9YKp-0000Ru-3u
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 11:20:11 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 31 Oct 2017 16:19:34 +0100
Message-Id: <20171031151938.14982-2-marcandre.lureau@redhat.com>
In-Reply-To: <20171031151938.14982-1-marcandre.lureau@redhat.com>
References: <20171031151938.14982-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 1/5] fw_cfg: fix the command line module name
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: linux-kernel@vger.kernel.org
Cc: somlo@cmu.edu, qemu-devel@nongnu.org, mst@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 drivers/firmware/qemu_fw_cfg.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/qemu_fw_cfg.c b/drivers/firmware/qemu_fw_cf=
g.c
index 0e2011636fbb..5cfe39f7a45f 100644
--- a/drivers/firmware/qemu_fw_cfg.c
+++ b/drivers/firmware/qemu_fw_cfg.c
@@ -10,9 +10,9 @@
  * and select subsets of aarch64), a Device Tree node (on arm), or using
  * a kernel module (or command line) parameter with the following syntax=
:
  *
- *      [fw_cfg.]ioport=3D<size>@<base>[:<ctrl_off>:<data_off>]
+ *      [qemu_fw_cfg.]ioport=3D<size>@<base>[:<ctrl_off>:<data_off>]
  * or
- *      [fw_cfg.]mmio=3D<size>@<base>[:<ctrl_off>:<data_off>]
+ *      [qemu_fw_cfg.]mmio=3D<size>@<base>[:<ctrl_off>:<data_off>]
  *
  * where:
  *      <size>     :=3D size of ioport or mmio range
@@ -21,9 +21,9 @@
  *      <data_off> :=3D (optional) offset of data register
  *
  * e.g.:
- *      fw_cfg.ioport=3D2@0x510:0:1		(the default on x86)
+ *      qemu_fw_cfg.ioport=3D2@0x510:0:1		(the default on x86)
  * or
- *      fw_cfg.mmio=3D0xA@0x9020000:8:0		(the default on arm)
+ *      qemu_fw_cfg.mmio=3D0xA@0x9020000:8:0	(the default on arm)
  */
=20
 #include <linux/module.h>
--=20
2.15.0.rc0.40.gaefcc5f6f
