Received: from eggs.gnu.org ([2001:4830:134:3::10]:37321)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dokdM-0005Vg-Rk
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 02:13:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dokdJ-0002je-Et
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 02:13:20 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:56337
	helo=heian.cn.fujitsu.com) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dokdJ-0002eu-4D
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 02:13:17 -0400
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Date: Mon, 4 Sep 2017 14:14:45 +0800
Message-ID: <1504505688-32455-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH V5 0/3] Optimize COLO-compare performance
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu devel <qemu-devel@nongnu.org>, Jason Wang <jasowang@redhat.com>
Cc: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>, Zhang Chen <zhangckid@gmail.com>, Li Zhijian <lizhijian@cn.fujitsu.com>

In this serise, we do a lot of job to optimize COLO net performance.
Mainly focus on TCP protocol.

V5:
 - Fix bug in colo_packet_compare_common().
 - Fix patch3 ascii graph style.

V4:
 - Remove the old patch1.

V3:
 - Rebase on upstream.
 - Remove origin p2.
 - Move the "checkpoint_time_ms" to CompareState,
   in order to aviod multi colo-compare instance conflict.
 - Add "TODO comments" for reset s->checkpoint_time_ms.
 - Add a new patch fix comments and scheme.

V2:
 - Rename p2's subject.


Zhang Chen (3):
  net/colo-compare.c: Optimize unpredictable tcp options comparison
  net/colo-compare.c: Adjust net queue pop order for performance
  net/colo-compare.c: Fix comments and scheme

 net/colo-compare.c | 103 +++++++++++++++++++++++++++++++----------------------
 1 file changed, 61 insertions(+), 42 deletions(-)

-- 
2.7.4
