Received: from eggs.gnu.org ([2001:4830:134:3::10]:42202)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dJfXV-0006iE-Ok
	for qemu-devel@nongnu.org; Sat, 10 Jun 2017 08:30:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dJfXR-0001d6-Pw
	for qemu-devel@nongnu.org; Sat, 10 Jun 2017 08:30:49 -0400
Received: from chuckie.co.uk ([82.165.15.123]:33294
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1dJfXR-0001cV-IW
	for qemu-devel@nongnu.org; Sat, 10 Jun 2017 08:30:45 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Sat, 10 Jun 2017 13:30:15 +0100
Message-Id: <1497097821-32754-1-git-send-email-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 0/6] fw_cfg: qdev-related tidy-ups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, rjones@redhat.com, pbonzini@redhat.com, somlo@cmu.edu, lersek@redhat.com, mst@redhat.com, ehabkost@redhat.com

As part of some ongoing sun4u work, I need to be able to wire the fw_cfg
IO interface to a separate IO space by instantiating the qdev device instead
of calling fw_cfg_init_io(). This patchset brings FW_CFG_IO in line with
FW_CFG_MEM and tidies up the realize methods accordingly.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Mark Cave-Ayland (6):
  fw_cfg: move initialisation of FWCfgState into instance_init
  fw_cfg: move qdev_init_nofail() out from fw_cfg_init1() into callers
  fw_cfg: move setting of FW_CFG_ID into fw_cfg_init1()
  fw_cfg: move fw_cfg_init1() into the fw_cfg_*_realize() functions
  fw_cfg: use sysbus_init_mmio() in fw_cfg_io_realize()
  fw_cfg: move QOM type defines into fw_cfg.h

 hw/nvram/fw_cfg.c         |   60 ++++++++++++++++++++++++---------------------
 include/hw/nvram/fw_cfg.h |    8 ++++++
 2 files changed, 40 insertions(+), 28 deletions(-)

-- 
1.7.10.4
