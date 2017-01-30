Received: from eggs.gnu.org ([2001:4830:134:3::10]:50516)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from
	<BATV+019e3b66d60b86b6da8a+4908+infradead.org+hch@bombadil.srs.infradead.org>)
	id 1cYGTE-0000oJ-En
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 13:14:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from
	<BATV+019e3b66d60b86b6da8a+4908+infradead.org+hch@bombadil.srs.infradead.org>)
	id 1cYGTA-0001S7-Em
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 13:14:28 -0500
From: Christoph Hellwig <hch@lst.de>
Date: Mon, 30 Jan 2017 19:13:50 +0100
Message-Id: <1485800032-24404-1-git-send-email-hch@lst.de>
Subject: [Qemu-devel] [PATCH 0/2] two more NVMe commands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: keith.busch@intel.com, qemu-block@nongnu.org

Hi all,

this series implements two more NVMe commands: DSM and Write Zeroes.
Both trace their lineage to Keith's qemu-nvme.git repository, and
while the Write Zeroes one is taken from there almost literally
the DSM one has seen a major rewrite to not block the main thread
as well as various other small improvements.
