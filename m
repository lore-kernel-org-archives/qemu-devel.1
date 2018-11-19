Received: from eggs.gnu.org ([2001:4830:134:3::10]:41445)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1gOlmU-0003TH-Vr
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 10:48:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1gOlmR-00014M-1S
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 10:48:10 -0500
Received: from m12-16.163.com ([220.181.12.16]:51309)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1gOlmQ-00013t-Bh
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 10:48:06 -0500
From: Li Qiang <liq3ea@163.com>
Date: Mon, 19 Nov 2018 07:47:34 -0800
Message-Id: <20181119154737.9840-1-liq3ea@163.com>
Subject: [Qemu-devel] [PATCH 0/3] fw_cfg: fix boot bootsplash and
 reboot-timeout error checking
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, kraxel@redhat.com, lersek@redhat.com, philmd@redhat.com, armbru@redhat.com
Cc: qemu-devel@nongnu.org, Li Qiang <liq3ea@163.com>

And also do some code cleanup.
A lot of thanks to Markus's review and advice.

Li Qiang (3):
  fw_cfg: fix -boot bootsplash error checking
  fw_cfg: fix -boot reboot-timeout error checking
  fw_cfg: make qemu_extra_params_fw locally

 hw/nvram/fw_cfg.c       | 68 ++++++++++++++++++-----------------------
 include/sysemu/sysemu.h |  1 -
 vl.c                    |  4 +--
 3 files changed, 32 insertions(+), 41 deletions(-)

-- 
2.17.1
