Received: from eggs.gnu.org ([2001:4830:134:3::10]:35401)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1e2tZf-00080k-3t
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 02:36:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1e2tZb-0004ur-Vh
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 02:35:59 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:34094
	helo=heian.cn.fujitsu.com) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1e2tZb-0004qA-Ke
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 02:35:55 -0400
From: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Date: Fri, 13 Oct 2017 14:32:05 +0800
Message-ID: <20171013063209.15617-1-maozy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 0/4] Optimize COLO-compare performance
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Zhang Chen <zhangckid@gmail.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, Jason Wang <jasowang@redhat.com>

In this series, adjust the way that the packet are queued and compared
to improve the colo net performence.

Cc: Zhang Chen <zhangckid@gmail.com>
Cc: Li Zhijian <lizhijian@cn.fujitsu.com>
Cc: Jason Wang <jasowang@redhat.com>

Mao Zhongyi (4):
  colo-compare: Insert packet into the suitable position of packet queue
    directly
  colo-compare: compare the packet in a specified Connection
  colo-compare: Fix comments
  colo: Consolidate the duplicate code chunk into a routine

 net/colo-compare.c | 61 +++++++++++++++++++++++++++++++-----------------------
 net/colo.c         | 18 +++++++++-------
 net/colo.h         |  1 +
 3 files changed, 46 insertions(+), 34 deletions(-)

-- 
2.9.4
