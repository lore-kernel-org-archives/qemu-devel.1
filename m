Received: from eggs.gnu.org ([2001:4830:134:3::10]:38957)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1eTIyz-0001yI-MZ
	for qemu-devel@nongnu.org; Sun, 24 Dec 2017 21:59:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1eTIyv-0001tj-RH
	for qemu-devel@nongnu.org; Sun, 24 Dec 2017 21:59:17 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:22715
	helo=heian.cn.fujitsu.com) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1eTIyv-0001ra-FM
	for qemu-devel@nongnu.org; Sun, 24 Dec 2017 21:59:13 -0500
From: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Date: Mon, 25 Dec 2017 10:54:10 +0800
Message-ID: <cover.1514169758.git.maozy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v4 0/2] Rewrite TCP packet comparison in colo
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

v4:
  p2: fix some typo
                                                [Zhang Chen]
v3:
  p1: merged the patch1 and patch2 from v2 
  p2: -merged the patch3 and patch4 from v2
      -implement the same process flow for tcp, udp and icmp

                                                [Zhang Chen]
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

Mao Zhongyi (2):
  colo: modified the payload compare function
  colo: compare the packet based on the tcp sequence number

 net/colo-compare.c | 411 +++++++++++++++++++++++++++++++++--------------------
 net/colo.c         |   9 ++
 net/colo.h         |  15 ++
 net/trace-events   |   2 +-
 4 files changed, 284 insertions(+), 153 deletions(-)

-- 
2.9.4
