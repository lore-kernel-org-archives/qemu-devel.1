Received: from eggs.gnu.org ([209.51.188.92]:44092)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hGKA9-0004Py-Ib
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 05:13:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hGKA8-0004V3-P0
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 05:13:57 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 16 Apr 2019 11:13:45 +0200
Message-Id: <20190416091348.26075-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 0/3] hw/arm/virt: Support firmware
 configuration with -blockdev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: lersek@redhat.com, peter.maydell@linaro.org, qemu-arm@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org, philmd@redhat.com

L=C3=A1szl=C3=B3 asked for feature parity with the PC machine types.

v2:
* PATCH 1: Split off PATCH 2 [L=C3=A1szl=C3=B3]
* PATCH 2: Factor out the loop body, not the whole loop
* PATCH 3: Rebase on previous change
           More detailed commit message [L=C3=A1szl=C3=B3]

Markus Armbruster (3):
  pc: Rearrange pc_system_firmware_init()'s legacy -drive loop
  pflash_cfi01: New pflash_cfi01_legacy_drive()
  hw/arm/virt: Support firmware configuration with -blockdev

 hw/arm/virt.c            | 198 +++++++++++++++++++++++++--------------
 hw/block/pflash_cfi01.c  |  28 ++++++
 hw/i386/pc_sysfw.c       |  18 +---
 include/hw/arm/virt.h    |   2 +
 include/hw/block/flash.h |   1 +
 5 files changed, 161 insertions(+), 86 deletions(-)

--=20
2.17.2
