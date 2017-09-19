Received: from eggs.gnu.org ([2001:4830:134:3::10]:40555)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1duHAY-0007Iy-DX
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 07:58:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1duHAV-0001uG-Cl
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 07:58:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47104)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1duHAV-0001t1-6e
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 07:58:23 -0400
From: marcandre.lureau@redhat.com
Date: Tue, 19 Sep 2017 13:58:10 +0200
Message-Id: <20170919115814.14724-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 0/4] fw_cfg: add DMA operations &
 etc/vmcoreinfo support
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

Hi,

This series brings DMA operations support to the fw_cfg kernel module
and provide "etc/vmcoreinfo" support.

At the current iteration of "[Qemu-devel] [PATCH v6 0/7] KASLR kernel
dump support" patch series, a "etc/vmcoreinfo" entry is added with
qemu -device vmcoreinfo, where the guest during boot or later, can
write the addr/size location of a ELF note to be appended in the qemu
dump.

v2:
- use platform device for dma mapping
- add etc/vmcoreinfo patch
- some code cleanups

Marc-Andr=C3=A9 Lureau (4):
  fw_cfg: add DMA register
  fw_cfg: do DMA read operation
  fw_cfg: write vmcoreinfo details
  RFC: fw_cfg: add DMA write operation in sysfs

 drivers/firmware/qemu_fw_cfg.c | 284 +++++++++++++++++++++++++++++++++++=
+-----
 1 file changed, 254 insertions(+), 30 deletions(-)

--=20
2.14.1.146.gd35faa819
