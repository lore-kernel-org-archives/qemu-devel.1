Received: from eggs.gnu.org ([2001:4830:134:3::10]:44827)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cltaw-0006SB-E6
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 03:38:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cltar-00011x-IN
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 03:38:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36970)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cltar-00011X-D7
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 03:38:41 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8A83764CB
	for <qemu-devel@nongnu.org>; Thu,  9 Mar 2017 08:38:41 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu,  9 Mar 2017 09:38:26 +0100
Message-Id: <1489048710-22084-1-git-send-email-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 0/4] vga: make display size configurable
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

  Hi,

Next attempt, this time using device properties (xres and yres) instead
of extending the usage of the -g switch, as suggested by paolo.  This
series has support for virtio, qxl and stdvga.  For stdvga the virtual
hardware is updated with additional (read-only) registers.

cheers,
  Gerd

Gerd Hoffmann (4):
  virtio-gpu: add xres and yres properties
  qxl: add xres and yres properties
  stdvga: move common properties to common base class
  [RfC] stdvga: add xres and yres properties.

 hw/display/qxl.c               | 34 ++++++++++++++++-------
 hw/display/qxl.h               |  2 ++
 hw/display/vga-pci.c           | 63 +++++++++++++++++++++++++++---------=
------
 hw/display/vga_int.h           |  6 ++--
 hw/display/virtio-gpu.c        |  6 ++--
 hw/display/virtio-vga.c        |  3 +-
 include/hw/virtio/virtio-gpu.h |  2 ++
 7 files changed, 78 insertions(+), 38 deletions(-)

--=20
1.8.3.1
