Received: from eggs.gnu.org ([2001:4830:134:3::10]:50875)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eD9Kf-0004j7-HC
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 08:26:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eD9Kd-0001X8-CF
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 08:26:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54732)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eD9Kd-0001Vx-6y
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 08:26:51 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6A81034CD
	for <qemu-devel@nongnu.org>; Fri, 10 Nov 2017 13:26:50 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 10 Nov 2017 14:26:41 +0100
Message-Id: <20171110132644.8069-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/3] Vga 20171110 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

The following changes since commit b0fbe46ad82982b289a44ee2495b59b0bad8a8=
42:

  Update version for v2.11.0-rc0 release (2017-11-07 16:05:28 +0000)

are available in the git repository at:

  git://git.kraxel.org/qemu tags/vga-20171110-pull-request

for you to fetch changes up to cf7040e284069fc235172c187551b268c66d8553:

  vmsvga: use ARRAY_SIZE macro (2017-11-10 14:25:56 +0100)

----------------------------------------------------------------
vga: bugfixes for 2.11

----------------------------------------------------------------

Gerd Hoffmann (1):
  vga: fix region checks in wraparound case

Philippe Mathieu-Daud=C3=A9 (1):
  vmsvga: use ARRAY_SIZE macro

Tao Wu (1):
  virtio-gpu: fix bug in host memory calculation.

 hw/display/vga.c        |  4 ++--
 hw/display/virtio-gpu.c | 16 ++++++++++++++--
 hw/display/vmware_vga.c |  5 ++---
 3 files changed, 18 insertions(+), 7 deletions(-)

--=20
2.9.3
