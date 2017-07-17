Received: from eggs.gnu.org ([2001:4830:134:3::10]:48230)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dX52G-0000Xy-23
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 08:22:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dX52A-0007j6-6A
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 08:22:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47348)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1dX529-0007i2-Vv
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 08:21:54 -0400
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 17 Jul 2017 20:21:31 +0800
Message-Id: <1500294105-13713-1-git-send-email-jasowang@redhat.com>
Subject: [Qemu-devel] [PULL 00/14] Net patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>

The following changes since commit 6632f6ff96f0537fc34cdc00c760656fc62e23c5:

  Merge remote-tracking branch 'remotes/famz/tags/block-and-testing-pull-request' into staging (2017-07-17 11:46:36 +0100)

are available in the git repository at:

  https://github.com/jasowang/qemu.git tags/net-pull-request

for you to fetch changes up to 189ae6bb5ce1f5a322f8691d00fe942ba43dd601:

  virtio-net: fix offload ctrl endian (2017-07-17 20:13:56 +0800)

----------------------------------------------------------------

- fix virtio-net ctrl offload endian
- vnet header support for variou COLO netfilters and compare thread

----------------------------------------------------------------
Jason Wang (1):
      virtio-net: fix offload ctrl endian

Michal Privoznik (1):
      virtion-net: Prefer is_power_of_2()

Zhang Chen (12):
      net: Add vnet_hdr_len arguments in NetClientState
      net/net.c: Add vnet_hdr support in SocketReadState
      net/filter-mirror.c: Introduce parameter for filter_send()
      net/filter-mirror.c: Make filter mirror support vnet support.
      net/filter-mirror.c: Add new option to enable vnet support for filter-redirector
      net/colo.c: Make vnet_hdr_len as packet property
      net/colo-compare.c: Introduce parameter for compare_chr_send()
      net/colo-compare.c: Make colo-compare support vnet_hdr_len
      net/colo.c: Add vnet packet parse feature in colo-proxy
      net/colo-compare.c: Add vnet packet's tcp/udp/icmp compare
      net/filter-rewriter.c: Make filter-rewriter support vnet_hdr_len
      docs/colo-proxy.txt: Update colo-proxy usage of net driver with vnet_header

 docs/colo-proxy.txt   | 26 ++++++++++++++++
 hw/net/virtio-net.c   |  4 ++-
 include/net/net.h     | 10 ++++--
 net/colo-compare.c    | 84 ++++++++++++++++++++++++++++++++++++++++++---------
 net/colo.c            |  9 +++---
 net/colo.h            |  4 ++-
 net/filter-mirror.c   | 75 +++++++++++++++++++++++++++++++++++++++++----
 net/filter-rewriter.c | 37 ++++++++++++++++++++++-
 net/net.c             | 37 ++++++++++++++++++++---
 net/socket.c          |  8 ++---
 qemu-options.hx       | 19 ++++++------
 11 files changed, 265 insertions(+), 48 deletions(-)
