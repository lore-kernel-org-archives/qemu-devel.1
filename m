Received: from eggs.gnu.org ([2001:4830:134:3::10]:60923)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fmHDk-00067R-3n
	for qemu-devel@nongnu.org; Sun, 05 Aug 2018 07:29:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fmHDh-00053P-1B
	for qemu-devel@nongnu.org; Sun, 05 Aug 2018 07:29:12 -0400
Received: from chuckie.co.uk ([82.165.15.123]:60355
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1fmHDg-0004n2-PL
	for qemu-devel@nongnu.org; Sun, 05 Aug 2018 07:29:08 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Sun,  5 Aug 2018 12:28:48 +0100
Message-Id: <20180805112850.26063-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 0/2] machine: preparation for adding
 SPARC64/PPC bootindex support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: ehabkost@redhat.com, marcel.apfelbaum@gmail.com, lersek@redhat.com, qemu-devel@nongnu.org

Here is a patchset that contains the preparatory work to enable upcoming
bootindex support in OpenBIOS for SPARC64/PPC.

Patch 1 enables the OFW address generated via the sysbus explicit_ofw_unit_address()
method to always take precendence when generating fw paths, and has already been
discussed on-list with a R-B from Laszlo.

Patch 2 may require further review and discussion and is a consequence of older
device trees having irregular naming conventions for disk nodes. Rather than add
extra string handling complexity in OpenBIOS for handling "/disk" nodes on a
per-interface basis, it is much easier to provide a per-machine option to remove
them completely for these machines and handle the logic in QEMU via a custom
FWPathProvider instead.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


Mark Cave-Ayland (2):
  sysbus: always allow explicit_ofw_unit_address() to override address
    generation
  fw_cfg: set the get_boot_devices_list() ignore_suffixes parameter from
    machine property

 hw/core/machine.c   |  3 +++
 hw/core/sysbus.c    | 15 +++++++--------
 hw/nvram/fw_cfg.c   |  5 ++++-
 include/hw/boards.h |  1 +
 4 files changed, 15 insertions(+), 9 deletions(-)

-- 
2.11.0
