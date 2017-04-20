Received: from eggs.gnu.org ([2001:4830:134:3::10]:40990)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1d15jz-0004UA-5l
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 02:38:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1d15jx-0005TW-6H
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 02:38:55 -0400
Received: from [59.151.112.132] (port=59779 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1d15jw-0005Sl-Ps
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 02:38:53 -0400
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Date: Thu, 20 Apr 2017 14:39:00 +0800
Message-ID: <1492670346-18004-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH V2 0/6] Add COLO-proxy virtio-net support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu devel <qemu-devel@nongnu.org>, Jason Wang <jasowang@redhat.com>
Cc: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, "eddie . dong" <eddie.dong@intel.com>, bian naimeng <biannm@cn.fujitsu.com>, Li Zhijian <lizhijian@cn.fujitsu.com>

If user use -device virtio-net-pci, virtio-net driver will add a header
to raw net packet that colo-proxy can't handle it. COLO-proxy just
focus on the packet payload, so we skip the virtio-net header to compare
the sent packet that primary guest's to secondary guest's.

Zhang Chen (6):
  net/filter-mirror.c: Add filter-mirror and filter-redirector vnet
    support.
  net/net.c: Add vnet header length to SocketReadState
  net/colo-compare.c: Make colo-compare support vnet_hdr_len
  net/socket.c: Add vnet packet support in net_socket_receive()
  net/colo.c: Add vnet packet parse feature in colo-proxy
  net/colo-compare.c: Add vnet packet's tcp/udp/icmp compare

 include/net/net.h     |  4 +++-
 net/colo-compare.c    | 48 +++++++++++++++++++++++++++++++++++++++---------
 net/colo.c            |  9 +++++----
 net/colo.h            |  4 +++-
 net/filter-mirror.c   | 25 ++++++++++++++++++++-----
 net/filter-rewriter.c |  2 +-
 net/net.c             | 24 ++++++++++++++++++++++--
 net/socket.c          |  6 ++++++
 8 files changed, 99 insertions(+), 23 deletions(-)

-- 
2.7.4
