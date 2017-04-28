Received: from eggs.gnu.org ([2001:4830:134:3::10]:33866)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1d42Ux-0004f7-6p
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 05:47:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1d42Us-0001Sl-7d
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 05:47:35 -0400
Received: from [59.151.112.132] (port=20529 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1d42Ur-0001QC-SJ
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 05:47:30 -0400
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Date: Fri, 28 Apr 2017 17:47:10 +0800
Message-ID: <1493372840-24551-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH V3 00/10] Add COLO-proxy virtio-net support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu devel <qemu-devel@nongnu.org>, Jason Wang <jasowang@redhat.com>
Cc: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, weifuqiang <weifuqiang@huawei.com>, "eddie
	. dong" <eddie.dong@intel.com>, bian naimeng <biannm@cn.fujitsu.com>, Li Zhijian <lizhijian@cn.fujitsu.com>

If user use -device virtio-net-pci, virtio-net driver will add a header
to raw net packet that colo-proxy can't handle it. COLO-proxy just
focus on the packet payload, so we skip the virtio-net header to compare
the sent packet that primary guest's to secondary guest's.

Zhang Chen (10):
  net: Add vnet_hdr_len related callback in NetClientInfo
  net/tap.c: Add tap_get_vnet_hdr_len and tap_get_using_vnet_hdr
    function
  net/netmap.c: Add netmap_get_vnet_hdr_len function
  net/filter-mirror.c: Add filter-mirror and filter-redirector vnet
    support.
  net/net.c: Add vnet header length to SocketReadState
  tests/e1000e-test.c : change e1000e test case send data format
  tests/virtio-net-test.c : change virtio-net test case iov send data
    format
  net/colo-compare.c: Make colo-compare support vnet_hdr_len
  net/colo.c: Add vnet packet parse feature in colo-proxy
  net/colo-compare.c: Add vnet packet's tcp/udp/icmp compare

 include/net/net.h       | 10 +++++++++-
 net/colo-compare.c      | 48 +++++++++++++++++++++++++++++++++++++++---------
 net/colo.c              |  9 +++++----
 net/colo.h              |  4 +++-
 net/filter-mirror.c     | 28 +++++++++++++++++++++++-----
 net/filter-rewriter.c   |  2 +-
 net/net.c               | 42 ++++++++++++++++++++++++++++++++++++++++--
 net/netmap.c            |  8 ++++++++
 net/tap-win32.c         | 12 ++++++++++++
 net/tap.c               | 20 ++++++++++++++++++++
 tests/e1000e-test.c     | 10 ++++++++--
 tests/virtio-net-test.c | 18 ++++++++++++++----
 12 files changed, 182 insertions(+), 29 deletions(-)

-- 
2.7.4
