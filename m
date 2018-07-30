Received: from eggs.gnu.org ([2001:4830:134:3::10]:47511)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuchenlin@synology.com>) id 1fjyDq-0004IT-OT
	for qemu-devel@nongnu.org; Sun, 29 Jul 2018 22:47:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuchenlin@synology.com>) id 1fjyDq-0001eb-4a
	for qemu-devel@nongnu.org; Sun, 29 Jul 2018 22:47:46 -0400
From: yuchenlin@synology.com
Date: Mon, 30 Jul 2018 10:46:59 +0800
Message-Id: <20180730024701.7613-1-yuchenlin@synology.com>
Subject: [Qemu-devel] [PATCH 0/2] Refine some vdi code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: sw@weilnetz.de, qemu-block@nongnu.org, yuchenlin <yuchenlin@synology.com>

From: yuchenlin <yuchenlin@synology.com>

This series refine some code in vdi.c, includes:

* Remvoe CONFIG_VDI_WRITE because there is no reason to leave an always on
  and cannot configure option in the code-side.
* decouple if else if chain to get more readability.

Thanks,
yuchenlin

yuchenlin (2):
  vdi: remove CONFIG_VDI_WRITE
  vdi: refine code for vdi_open

 block/vdi.c | 32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

-- 
2.17.0
