Received: from eggs.gnu.org ([2001:4830:134:3::10]:46433)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gAWpw-0007kg-6b
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 05:01:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gAWpa-0005Ze-Cm
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 05:00:52 -0400
Received: from cmccmta2.chinamobile.com ([221.176.66.80]:15206)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gAWpQ-0005TR-Qo
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 05:00:23 -0400
From: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
Date: Thu, 11 Oct 2018 17:00:03 +0800
Message-Id: <20181011090007.1103-1-maozhongyi@cmss.chinamobile.com>
Subject: [Qemu-devel] [PATCH 0/4] use object link instead of qdev property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>

According to qdev-properties.h, properties of pointer type
should be avoid, so convert qdev property to link, Whilst we
are here, also update some hardcoded strings with already
defineded macros.

Mao Zhongyi (4):
  wm8750: remove duplicate macro
  audio: use TYPE_WM8750 instead of a hardcoded string
  audio: use object link instead of qdev property to pass wm8750
    reference
  audio: use existing macros istead of hardcoded strings

 hw/arm/musicpal.c          | 19 ++++++++++---------
 hw/audio/marvell_88w8618.c | 17 +++++++----------
 hw/audio/wm8750.c          | 18 ++++++++----------
 include/hw/audio/wm8750.h  |  1 +
 4 files changed, 26 insertions(+), 29 deletions(-)

-- 
2.17.1
