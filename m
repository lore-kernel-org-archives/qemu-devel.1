Received: from eggs.gnu.org ([2001:4830:134:3::10]:60670)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dq8fn-0002vl-D8
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 22:05:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dq8fi-0001tn-Ce
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 22:05:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35940)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1dq8fi-0001tW-7D
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 22:05:30 -0400
From: Jason Wang <jasowang@redhat.com>
Date: Fri,  8 Sep 2017 10:05:06 +0800
Message-Id: <1504836324-4871-1-git-send-email-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/18] Net patches
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

The following changes since commit cda4a338c4243fa3bff4498b935340ac7121cc=
76:

  tcg/tci: Add TCG_TARGET_DEFAULT_MO (2017-09-07 18:57:34 +0100)

are available in the git repository at:

  https://github.com/jasowang/qemu.git tags/net-pull-request

for you to fetch changes up to 861d51e62bb197b43606f888dbefbabebaf0d854:

  colo-compare: Update the COLO document to add the IOThread configuratio=
n (2017-09-08 09:34:40 +0800)

----------------------------------------------------------------

----------------------------------------------------------------
Kamil Rytarowski (1):
      e1000: Rename the SEC symbol to SEQEC

Mao Zhongyi (8):
      net/rocker: Remove the dead error handling
      net/rocker: Plug memory leak in pci_rocker_init()
      net/rocker: Convert to realize()
      net/rocker: Fix the unusual macro name
      net/socket: Don't treat odd socket type as SOCK_STREAM
      net/socket: Convert several helper functions to Error
      net/net: Convert parse_host_port() to Error
      net/socket: Improve -net socket error reporting

Matt Parker (1):
      net: rtl8139: do not use old_mmio accesses

Wang Yong (3):
      qemu-iothread: IOThread supports the GMainContext event loop
      colo-compare: Use IOThread to Check old packet regularly and Proces=
s pactkets of the primary
      colo-compare: Update the COLO document to add the IOThread configur=
ation

Zhang Chen (5):
      net/filter-rewriter.c: Fix rewirter checksum bug when use virtio-ne=
t
      MAINTAINERS: Update mail address for COLO Proxy
      net/colo-compare.c: Optimize unpredictable tcp options comparison
      net/colo-compare.c: Adjust net queue pop order for performance
      net/colo-compare.c: Fix comments and scheme

 MAINTAINERS                   |   2 +-
 docs/colo-proxy.txt           |   3 +-
 hw/net/e1000.c                |   4 +-
 hw/net/e1000_regs.h           |   2 +-
 hw/net/e1000e_core.c          |   2 +-
 hw/net/e1000x_common.h        |   2 +-
 hw/net/rocker/rocker.c        |  94 ++++++----------------
 hw/net/rocker/rocker_desc.c   |  10 ---
 hw/net/rocker/rocker_fp.c     |   4 -
 hw/net/rocker/rocker_of_dpa.c |  20 -----
 hw/net/rocker/rocker_world.c  |  12 ++-
 hw/net/rtl8139.c              |  53 +-----------
 include/qemu/sockets.h        |   3 +-
 include/sysemu/iothread.h     |   4 +
 iothread.c                    |  45 +++++++++++
 net/colo-compare.c            | 183 ++++++++++++++++++++++++------------=
------
 net/filter-rewriter.c         |   6 +-
 net/net.c                     |  22 +++--
 net/socket.c                  | 156 +++++++++++++++++++----------------
 19 files changed, 304 insertions(+), 323 deletions(-)
