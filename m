Received: from eggs.gnu.org ([2001:4830:134:3::10]:54780)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zxq_yx_007@163.com>) id 1cN8K5-0001QJ-Jq
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 20:19:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zxq_yx_007@163.com>) id 1cN8K3-0000Kp-4i
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 20:19:01 -0500
Received: from m12-14.163.com ([220.181.12.14]:45613)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zxq_yx_007@163.com>) id 1cN8K2-0000K6-Fx
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 20:18:59 -0500
From: xiaoqiang zhao <zxq_yx_007@163.com>
Date: Sat, 31 Dec 2016 09:18:42 +0800
Message-Id: <20161231011847.4153-1-zxq_yx_007@163.com>
Subject: [Qemu-devel] [PATCH 0/5] QOM'ify work for milkymist
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: michael@walle.cc

This patch series continues QOM'ify work for milkymist.
See each commit message for details.

xiaoqiang zhao (5):
  hw/misc: QOM'ify milkymist-hpdmc.c
  hw/misc: QOM'ify milkymist-pfpu.c
  hw/sd: QOM'ify milkymist-memcard.c
  hw/net: QOM'ify milkymist-minimac2.c
  hw/input: QOM'ify milkymist-softusb.c

 hw/input/milkymist-softusb.c | 21 +++++++++++++--------
 hw/misc/milkymist-hpdmc.c    | 12 +++++-------
 hw/misc/milkymist-pfpu.c     | 12 +++++-------
 hw/net/milkymist-minimac2.c  | 21 ++++++++++++---------
 hw/sd/milkymist-memcard.c    | 25 +++++++++++++++----------
 5 files changed, 50 insertions(+), 41 deletions(-)

-- 
2.11.0
