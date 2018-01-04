Received: from eggs.gnu.org ([2001:4830:134:3::10]:52213)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eX6hZ-0000b1-Mq
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 09:41:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eX6hU-0002fk-VC
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 09:41:01 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu,  4 Jan 2018 11:40:40 -0300
Message-Id: <20180104144046.30793-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH 0/6] qom: introduce TypeInfo name aliases
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>, Sascha Silbe <silbe@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>, Peter Crosthwaite <crosthwaite.peter@gmail.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-arm@nongnu.org, Fam Zheng <famz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Hi,

This RFC series is intended to simplify Flattened Device Tree support,
in particular the 'compatible' FDT entry, when Linux names mismatches
QEMU ones, but this is the same device modelled.

Eventually this might help to remove the QDevAlias qdev_alias_table[]
in qdev-monitor.c.

So far this is only a 'proof of concept'.
To see how the qtests perform, I only modified 3 devices, 2 used by the
Xilinx Zynq machines (Cadence), and the e1000 (used by the PXE test).

Regards,

Phil.

Philippe Mathieu-Daudé (6):
  qom: introduce TypeInfo name aliases
  hw/net/e1000: real device name is 'e1000-82540em', 'e1000' is an alias
  hw/char/cadence_uart: add FDT aliases
  arm/xlnx-zynq: use FDT names for the Cadence UART
  hw/net/cadence_gem: add FDT names as alias
  hw/arm/xlnx-zynq: use FDT names for the Cadence GEM

 include/qom/object.h   |  3 +++
 hw/arm/xilinx_zynq.c   |  2 ++
 hw/arm/xlnx-zynqmp.c   |  4 ++--
 hw/char/cadence_uart.c |  7 +++++++
 hw/net/cadence_gem.c   |  6 ++++++
 hw/net/e1000.c         |  5 ++++-
 qom/object.c           | 18 ++++++++++++++++--
 7 files changed, 40 insertions(+), 5 deletions(-)

-- 
2.15.1
