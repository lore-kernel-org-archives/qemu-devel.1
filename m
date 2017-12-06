Received: from eggs.gnu.org ([2001:4830:134:3::10]:55459)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1eMWWp-000822-P0
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 05:02:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1eMWWg-0004By-Ib
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 05:02:11 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:59003
	helo=heian.cn.fujitsu.com) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1eMWWg-00046x-4J
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 05:02:02 -0500
From: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Date: Wed, 6 Dec 2017 17:57:24 +0800
Message-ID: <cover.1512552817.git.maozy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2 0/4] Rewrite TCP packet comparison in colo
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

In this series, mainly rewrite the tcp packet comparison based on 
the tcp sequence number instead of original method that compare the
packet based on the payload size.

v2:
  p1: a new patch
  p2: a new patch
  p3: -rename the fill_pkt_seq to fill_pkt_tcp_info
      -rename pdsize & hdsize to payload_size & header_size
      -reuse duplicated code
      -modified colo_packet_compare_common() to suit the tcp packet
       comparison instead of build a new function service for tcp.
      -add more comments for the 'max_ack'
                                                [Zhang Chen]

Cc: Zhang Chen <zhangckid@gmail.com>
Cc: Li Zhijian <lizhijian@cn.fujitsu.com>
Cc: Jason Wang <jasowang@redhat.com>

Mao Zhongyi (4):
  colo: remove the incorrect if conditions in colo_compare_packet_tcp()
  colo: modified the payload compare function
  colo: compare the packet based on the tcp sequence number
  colo: add trace for the tcp packet comparison

 net/colo-compare.c | 353 ++++++++++++++++++++++++++++++++++-------------------
 net/colo.c         |   9 ++
 net/colo.h         |  15 +++
 net/trace-events   |   2 +-
 4 files changed, 250 insertions(+), 129 deletions(-)

-- 
2.9.4
