Received: from eggs.gnu.org ([2001:4830:134:3::10]:43812)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcin.krzeminski@nokia.com>) id 1cHuvQ-0004MN-NM
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 11:00:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcin.krzeminski@nokia.com>) id 1cHuvN-0007AR-L6
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 11:00:00 -0500
From: <marcin.krzeminski@nokia.com>
Date: Fri, 16 Dec 2016 14:27:40 +0100
Message-ID: <1481894862-14102-1-git-send-email-marcin.krzeminski@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 0/2]block: m25p80: Improve mt25qu01g chip model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, rfsw-patches@mlist.nokia.com, clg@kaod.org

From: Marcin Krzeminski <marcin.krzeminski@nokia.com>

This series introduce some improvememnt targeting mt25qu01g.

Marcin Krzeminski (2):
  block: m25p80: Add Quad Page Program 4byte version op
  block: m25p80: Introduce Die Erase command

 hw/block/m25p80.c | 37 +++++++++++++++++++++++++++++++++----
 1 file changed, 33 insertions(+), 4 deletions(-)

-- 
2.7.4
