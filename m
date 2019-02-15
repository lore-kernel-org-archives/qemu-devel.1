Received: from eggs.gnu.org ([209.51.188.92]:60532)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1guanm-000860-9V
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 05:33:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1guanl-0004St-83
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 05:33:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:14029)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1guanl-0003vd-0J
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 05:33:01 -0500
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Fri, 15 Feb 2019 10:32:37 +0000
Message-Id: <20190215103239.28640-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 0/2] hw: provide error checking of
 disable-legacy/modern property usage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Gonglei <arei.gonglei@huawei.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>

Changed in v2:

 - Fix properties set for v2.6 machine type compat so that it
   only affects the virtio devices which support both legacy
   and modern modes.
 - Revert unneccessary patch allowing optional properties in
   machine prop back compat

Daniel P. Berrang=C3=A9 (2):
  hw: report invalid disable-legacy|modern usage for virtio-1-only devs
  Revert "globals: Allow global properties to be optional"

 hw/core/machine.c             | 23 ++++++++++++++++++++---
 hw/display/virtio-gpu-pci.c   |  4 +++-
 hw/display/virtio-vga.c       |  4 +++-
 hw/virtio/virtio-crypto-pci.c |  4 +++-
 hw/virtio/virtio-input-pci.c  |  4 +++-
 hw/virtio/virtio-pci.c        | 26 ++++++++++++++++----------
 hw/virtio/virtio-pci.h        | 31 +++++++++++++++++++++++++------
 include/hw/qdev-core.h        |  3 ---
 qom/object.c                  |  3 ---
 9 files changed, 73 insertions(+), 29 deletions(-)

--=20
2.20.1
