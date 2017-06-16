Received: from eggs.gnu.org ([2001:4830:134:3::10]:57917)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dLpzH-0001WL-7D
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 08:04:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dLpzE-0007bJ-4c
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 08:04:27 -0400
Received: from chuckie.co.uk ([82.165.15.123]:52914
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1dLpzD-0007XE-Ta
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 08:04:24 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Fri, 16 Jun 2017 13:04:06 +0100
Message-Id: <1497614651-1017-1-git-send-email-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCHv3 0/5] fw_cfg: qdev-related tidy-ups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, lersek@redhat.com, somlo@cmu.edu, ehabkost@redhat.com, mst@redhat.com, pbonzini@redhat.com, rjones@redhat.com, peter.maydell@linaro.org

As part of some ongoing sun4u work, I need to be able to wire the fw_cfg
IO interface to a separate IO space by instantiating the qdev device instead
of calling fw_cfg_init_io(). This patchset brings FW_CFG_IO in line with
FW_CFG_MEM and tidies up the realize methods accordingly.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

v3:
- Rework patch 1 to use sysbus_add_io() as suggested by Laszlo
- Add Reviewed-By from Laszlo for patch 2
- Fix assert() when instantiating > 1 fw_cfg device (new patch 3)
- Rename fw_cfg_init1() to fw_cfg_common_realize() as part of patch 4

v2:
- Fix the QOM bug in patch 1 as indicated by Laszlo
- Minimise code churn compared to v1


Mark Cave-Ayland (5):
  fw_cfg: don't map the fw_cfg IO ports in fw_cfg_io_realize()
  fw_cfg: move setting of FW_CFG_VERSION_DMA bit to fw_cfg_init1()
  fw_cfg: move assert() and linking of fw_cfg device to the machine
    into instance_init()
  fw_cfg: move qdev_init_nofail() from fw_cfg_init1() to callers
  fw_cfg: move QOM type defines and fw_cfg types into fw_cfg.h

 hw/nvram/fw_cfg.c         |  113 +++++++++++++--------------------------------
 include/hw/nvram/fw_cfg.h |   58 +++++++++++++++++++++++
 2 files changed, 90 insertions(+), 81 deletions(-)

-- 
1.7.10.4
