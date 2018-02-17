Received: from eggs.gnu.org ([208.118.235.92]:48984)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Paul.Burton@mips.com>) id 1en87D-0004pT-FQ
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 14:25:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Paul.Burton@mips.com>) id 1en878-00080Q-Id
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 14:25:43 -0500
Received: from 9pmail.ess.barracuda.com ([64.235.150.224]:40187)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Paul.Burton@mips.com>)
	id 1en878-0007yY-DM
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 14:25:38 -0500
From: Paul Burton <paul.burton@mips.com>
Date: Sat, 17 Feb 2018 11:22:13 -0800
Message-ID: <20180217192215.28581-1-paul.burton@mips.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 0/2] MIPS Boston / pch_gbe ethernet support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@mips.com>, Paul Burton <paul.burton@mips.com>

This short series introduces support for emulating the ethernet
controller found in the Intel EG20T Platform Controller Hub, and then
enables that device for the MIPS Boston board. This gives the Boston
board a network device matching that found on real Boston boards,
providing unmodified Boston Linux kernels with network access.

Applies atop master as of 5e8d6a12d643 ("Merge remote-tracking branch
'remotes/kraxel/tags/ui-20180216-pull-request' into staging").


Paul Burton (2):
  hw/net: Add support for Intel pch_gbe ethernet
  hw/mips/boston: Enable pch_gbe ethernet controller

 default-configs/mips64el-softmmu.mak |   1 +
 hw/mips/boston.c                     |   8 +-
 hw/net/Makefile.objs                 |   1 +
 hw/net/pch_gbe.c                     | 766 +++++++++++++++++++++++++++++++++++
 4 files changed, 775 insertions(+), 1 deletion(-)
 create mode 100644 hw/net/pch_gbe.c

-- 
2.16.1
