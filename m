Received: from eggs.gnu.org ([209.51.188.92]:38431)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mopsfelder@gmail.com>) id 1gyJeN-0007Lp-Qx
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 12:02:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mopsfelder@gmail.com>) id 1gyJeJ-00081E-Uw
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 12:02:43 -0500
From: Murilo Opsfelder Araujo <mopsfelder@gmail.com>
Date: Mon, 25 Feb 2019 14:01:52 -0300
Message-Id: <20190225170155.1972-1-muriloo@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 0/3] ppc/pnv: increase kernel size limit to
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
Cc: mopsfelder@gmail.com, Murilo Opsfelder Araujo <muriloo@linux.ibm.com>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, David Gibson <david@gibson.dropbear.id.au>, Eric Blake <eblake@redhat.com>, qemu-ppc@nongnu.org

First patch increases kernel size limit to 256MiB to fit images generated with
CONFIG_DEBUG_INFO.

Second patch just fixes a misleading comment regarding initrd size limit.

Third patch uses IEC prefixes to represent size constants.

v1..v2:
  Use IEC prefixes as per Eric Blake' suggestion.

Murilo Opsfelder Araujo (3):
  ppc/pnv: increase kernel size limit to 256MiB
  ppc/pnv: add INITRD_MAX_SIZE constant
  ppc/pnv: use IEC binary prefixes to represent sizes

 hw/ppc/pnv.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

-- 
2.20.1
