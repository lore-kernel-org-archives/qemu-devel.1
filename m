Received: from eggs.gnu.org ([2001:4830:134:3::10]:44558)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1d45H6-0000A5-Lh
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 08:45:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1d45H6-0004wA-2x
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 08:45:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43454)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1d45H5-0004vp-SY
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 08:45:27 -0400
From: marcandre.lureau@redhat.com
Date: Fri, 28 Apr 2017 16:45:07 +0400
Message-Id: <20170428124510.23654-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/3] fw_cfg: add DMA operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: somlo@cmu.edu, linux-kernel@vger.kernel.org, mst@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Hi,

This series brings DMA operations support to the fw_cfg kernel module.
There is a few FIXME that I don't know how to improve.

The 'write' operation is only meant as a proof-of-concept, since some
qemu firmware maintainers are strongly against the usage of this
operation by the kernel/user-space.

Marc-Andr=C3=A9 Lureau (3):
  fw_cfg: add DMA register
  fw_cfg: do DMA read operation
  fw_cfg: add DMA write operation proof-of-concept

 drivers/firmware/qemu_fw_cfg.c | 240 +++++++++++++++++++++++++++++++++++=
+-----
 1 file changed, 211 insertions(+), 29 deletions(-)

--=20
2.12.0.191.gc5d8de91d
