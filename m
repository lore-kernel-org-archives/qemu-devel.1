Received: from eggs.gnu.org ([209.51.188.92]:53526)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mopsfelder@gmail.com>) id 1gyHBQ-0006I9-9a
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 09:24:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mopsfelder@gmail.com>) id 1gyHBP-0001Il-L0
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 09:24:40 -0500
From: Murilo Opsfelder Araujo <mopsfelder@gmail.com>
Date: Mon, 25 Feb 2019 11:24:05 -0300
Message-Id: <20190225142407.9477-1-muriloo@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 0/2] ppc/pnv: increase kernel size limit to
 256MiB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mopsfelder@gmail.com, Murilo Opsfelder Araujo <muriloo@linux.ibm.com>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org

First patch increases kernel size limit to 256MiB to fit images generated with
CONFIG_DEBUG_INFO.

Second patch just fixes a misleading comment regarding initrd size limit.

Murilo Opsfelder Araujo (2):
  ppc/pnv: increase kernel size limit to 256MiB
  ppc/pnv: add INITRD_MAX_SIZE constant

 hw/ppc/pnv.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

-- 
2.20.1
