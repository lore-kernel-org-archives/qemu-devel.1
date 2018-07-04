Received: from eggs.gnu.org ([2001:4830:134:3::10]:57570)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fajsx-0006yA-Pp
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 11:40:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fajsw-0003bm-UV
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 11:40:03 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed,  4 Jul 2018 12:39:11 -0300
Message-Id: <20180704153919.12432-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 0/8] Coccinelle cleanups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Anthony Perard <anthony.perard@citrix.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Stefano Stabellini <sstabellini@kernel.org>, Peter Maydell <peter.maydell@linaro.org>, xen-devel@lists.xenproject.org, qemu-arm@nongnu.org, qemu-block@nongnu.org, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Markus Armbruster <armbru@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>

Nothing exciting here, patches created mechanically
(common after soft freeze).

Philippe Mathieu-Daudé (8):
  qobject: Catch another straggler for use of qdict_put_str()
  error: Remove NULL checks on error_propagate() calls
  crypto: Remove useless casts
  xen: Remove useless casts
  tests/bios-tables-test: Remove useless casts
  ui/vnc: Remove useless parenthesis around DIV_ROUND_UP macro
  hw/pci-host: Remove useless parenthesis around DIV_ROUND_UP macro
  hw/intc/gicv3: Remove useless parenthesis around DIV_ROUND_UP macro

 include/hw/intc/arm_gicv3_common.h | 2 +-
 crypto/cipher-builtin.c            | 4 ++--
 hw/pci-host/piix.c                 | 2 +-
 hw/pci-host/q35.c                  | 2 +-
 hw/s390x/virtio-ccw.c              | 4 +---
 hw/xen/xen_pt_config_init.c        | 2 +-
 qobject/block-qdict.c              | 2 +-
 tests/bios-tables-test.c           | 2 +-
 ui/vnc-enc-tight.c                 | 2 +-
 ui/vnc.c                           | 3 ++-
 10 files changed, 12 insertions(+), 13 deletions(-)

-- 
2.18.0
