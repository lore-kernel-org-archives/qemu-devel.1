Received: from eggs.gnu.org ([2001:4830:134:3::10]:52928)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fb6eL-0004JY-4O
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 11:58:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fb6eK-00052n-8x
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 11:58:29 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu,  5 Jul 2018 12:58:04 -0300
Message-Id: <20180705155811.20366-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 0/7] Coccinelle cleanups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-trivial@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Laurent Vivier <laurent@vivier.eu>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Anthony Perard <anthony.perard@citrix.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, David Hildenbrand <david@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>

Hi Michael,

Nothing exciting here, patches created mechanically
(common after soft freeze).

All patches are reviewed, can you queue them in your Trivial tree?

Thanks,

Phil.

Since v1:
- rebased
- dropped incorrect "crypto: Remove useless casts" (Daniel)
- use PCI_DEVICE() to access XenPCIPassthroughState->dev (Peter)
- added R-b, A-b

Philippe Mathieu-Daudé (7):
  qobject: Catch another straggler for use of qdict_put_str()
  error: Remove NULL checks on error_propagate() calls
  xen: Use the PCI_DEVICE macro
  tests/bios-tables-test: Remove an useless cast
  ui/vnc: Remove useless parenthesis around DIV_ROUND_UP macro
  hw/pci-host: Remove useless parenthesis around DIV_ROUND_UP macro
  hw/intc/gicv3: Remove useless parenthesis around DIV_ROUND_UP macro

 include/hw/intc/arm_gicv3_common.h | 2 +-
 hw/pci-host/piix.c                 | 2 +-
 hw/pci-host/q35.c                  | 2 +-
 hw/s390x/virtio-ccw.c              | 4 +---
 hw/xen/xen_pt_config_init.c        | 8 ++++----
 qobject/block-qdict.c              | 2 +-
 tests/bios-tables-test.c           | 2 +-
 ui/vnc-enc-tight.c                 | 2 +-
 ui/vnc.c                           | 3 ++-
 9 files changed, 13 insertions(+), 14 deletions(-)

-- 
2.18.0
