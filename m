Received: from eggs.gnu.org ([2001:4830:134:3::10]:43230)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1chT7C-0003Zj-FQ
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 22:33:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1chT79-0006m9-By
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 22:33:46 -0500
Received: from [59.151.112.132] (port=47327 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1chT79-0006iV-0S
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 22:33:43 -0500
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Date: Sat, 25 Feb 2017 11:32:06 +0800
Message-ID: <1487993530-30875-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 0/3] COLO-compare: Optimize the code and fix
 some bug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu devel <qemu-devel@nongnu.org>
Cc: Jason Wang <jasowang@redhat.com>, Zhang Chen <zhangchen.fnst@cn.fujitsu.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, "eddie . dong" <eddie.dong@intel.com>, bian naimeng <biannm@cn.fujitsu.com>

This series we will Optimize the code and fix some bug.
Patch1: Add packet minimum size check in compare tcp/udp like compare icmp.
Patch2: Optimize compare_common and increase compare performance.
Patch3: Fix debug info always print bug.

V1:
  - init patch.

Zhang Chen (3):
  COLO-compare: Add minimum packet size check and some fix
  COLO-compare: Optimize colo_packet_compare_common
  COLO-compare: Make qemu_hexdump() print data when trace-event ON

 net/colo-compare.c | 68 ++++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 51 insertions(+), 17 deletions(-)

-- 
2.7.4
