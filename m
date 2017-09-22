Received: from eggs.gnu.org ([2001:4830:134:3::10]:43653)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dvNwU-0000Lp-Ow
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 09:24:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dvNwT-0004xZ-Qu
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 09:24:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41812)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1dvNwT-0004ww-LV
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 09:24:29 -0400
From: marcandre.lureau@redhat.com
Date: Fri, 22 Sep 2017 15:24:08 +0200
Message-Id: <20170922132412.9408-2-marcandre.lureau@redhat.com>
In-Reply-To: <20170922132412.9408-1-marcandre.lureau@redhat.com>
References: <20170922132412.9408-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 1/5] fw_cfg: fix the command line module name
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

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

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
2.14.1.146.gd35faa819
