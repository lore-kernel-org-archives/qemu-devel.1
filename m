Received: from eggs.gnu.org ([209.51.188.92]:42880)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h0taP-0001YF-MD
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 14:49:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h0taO-0000QD-N5
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 14:49:17 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Mon,  4 Mar 2019 20:48:53 +0100
Message-Id: <20190304194857.9780-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC PATCH 0/4] pc: Support firmware configuration
 with -blockdev (splitted)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
Cc: Laszlo Ersek <lersek@redhat.com>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

While reviewing Markus' series [*] I splitted the last patch (6/6) to
understand it better.

[*] https://lists.gnu.org/archive/html/qemu-devel/2019-02/msg06798.html

Based-on: <20190225183757.27378-6-armbru@redhat.com>

Markus Armbruster (1):
  pc: Support firmware configuration with -blockdev

Philippe Mathieu-Daud=C3=A9 (3):
  pflash_cfi01: Add pflash_cfi01_get_blk() helper
  hw/i386/pc_sysfw: Remove obsolete PcSysFwDevice
  hw/i386/pc_sysfw: Let pc_system_firmware_init() access PCMachineState

 hw/block/pflash_cfi01.c  |   5 +
 hw/i386/pc.c             |   4 +-
 hw/i386/pc_sysfw.c       | 232 +++++++++++++++++++++++++--------------
 include/hw/block/flash.h |   1 +
 include/hw/i386/pc.h     |   6 +-
 5 files changed, 164 insertions(+), 84 deletions(-)

--=20
2.20.1
