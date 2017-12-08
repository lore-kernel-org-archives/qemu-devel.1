Received: from eggs.gnu.org ([2001:4830:134:3::10]:38957)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1eNHVJ-0007Mz-Uo
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 07:11:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1eNHVG-00043P-Mx
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 07:11:45 -0500
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Date: Fri,  8 Dec 2017 15:10:31 +0300
Message-Id: <1512735034-35327-1-git-send-email-anton.nefedov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 0/3] ide: abort TRIM operation for invalid range
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, jsnow@redhat.com, Anton Nefedov <anton.nefedov@virtuozzo.com>

Started from the separate series discussion (trim statistics) , see
http://lists.nongnu.org/archive/html/qemu-devel/2017-12/msg01059.html

There is no range check for IDE trim requests now.
Such request will likely be rejected by the block layer and count as
failed and not an invalid/aborted operation.

Anton Nefedov (3):
  ide: pass IDEState to trim AIO callback
  ide: move ide_sect_range_ok() up
  ide: abort TRIM operation for invalid range

 hw/ide/core.c | 53 +++++++++++++++++++++++++++++++++--------------------
 1 file changed, 33 insertions(+), 20 deletions(-)

-- 
2.7.4
