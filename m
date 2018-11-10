Received: from eggs.gnu.org ([2001:4830:134:3::10]:53532)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1gLK9M-0003u8-Kh
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 22:41:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1gLK9G-0003uH-HM
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 22:41:30 -0500
Received: from m12-14.163.com ([220.181.12.14]:46659)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1gLK9E-0003po-VK
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 22:41:26 -0500
From: Li Qiang <liq3ea@163.com>
Date: Fri,  9 Nov 2018 19:41:13 -0800
Message-Id: <20181110034115.103335-1-liq3ea@163.com>
Subject: [Qemu-devel] [PATCH 0/2] refactor fw_cfg_bootsplash() and
 fw_cfg_reboot()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, kraxel@redhat.com, armbru@redhat.com, lersek@redhat.com, philmd@redhat.com
Cc: qemu-devel@nongnu.org, Li Qiang <liq3ea@163.com>

This patchset comes out as the result of the following review as per 
Markus's and Gerd's advice:
-->https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg06975.html
-->http://lists.gnu.org/archive/html/qemu-devel/2018-11/msg00701.html

The second patch also fix that the user can set a negative
reboot_timeout.

Li Qiang (2):
  hw: fw_cfg: refactor fw_cfg_bootsplash()
  hw: fw_cfg: refactor fw_cfg_reboot()

 hw/nvram/fw_cfg.c | 63 ++++++++++++++++++++---------------------------
 vl.c              |  4 +--
 2 files changed, 29 insertions(+), 38 deletions(-)

-- 
2.17.1
