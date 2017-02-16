Received: from eggs.gnu.org ([2001:4830:134:3::10]:47553)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dmitry@daynix.com>) id 1ceLC7-0002z9-9y
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 07:29:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dmitry@daynix.com>) id 1ceLC4-0007oN-7K
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 07:29:55 -0500
Received: from mail-wm0-x234.google.com ([2a00:1450:400c:c09::234]:38559)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dmitry@daynix.com>) id 1ceLC4-0007o6-0A
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 07:29:52 -0500
Received: by mail-wm0-x234.google.com with SMTP id r141so13921552wmg.1
	for <qemu-devel@nongnu.org>; Thu, 16 Feb 2017 04:29:51 -0800 (PST)
From: Dmitry Fleytman <dmitry@daynix.com>
Date: Thu, 16 Feb 2017 14:29:31 +0200
Message-Id: <1487248176-29602-1-git-send-email-dmitry@daynix.com>
Subject: [Qemu-devel] [PATCH 0/5] A few VLAN-related bugfixes for RX packet
 abstraction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, Yan Vugenfirer <yan@daynix.com>, P J P <ppandit@redhat.com>, Dmitry Fleytman <dmitry@daynix.com>

This series fix a few issues related
to processing of RX packets with VLAN headers.

See commit messages of specific patches
for information regarding affected devices.

Dmitry Fleytman (5):
  eth: Extend vlan stripping functions
  NetRxPkt: Fix memory corruption on VLAN header stripping
  NetRxPkt: Do not try to pull more data than present
  NetRxPkt: Account buffer with ETH header in IOV length
  NetRxPkt: Remove code duplication in net_rx_pkt_pull_data()

 hw/net/net_rx_pkt.c | 40 +++++++++++++++++++++-------------------
 include/net/eth.h   |  4 ++--
 net/eth.c           | 25 ++++++++++++++-----------
 3 files changed, 37 insertions(+), 32 deletions(-)

-- 
2.7.4
