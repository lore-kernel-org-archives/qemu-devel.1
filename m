Received: from eggs.gnu.org ([2001:4830:134:3::10]:58159)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1ckl9n-0007dj-0J
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 00:26:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1ckl9j-0000xh-TT
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 00:26:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42782)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1ckl9j-0000xZ-Jq
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 00:25:59 -0500
From: Jason Wang <jasowang@redhat.com>
Date: Mon,  6 Mar 2017 13:25:35 +0800
Message-Id: <1488777954-4578-1-git-send-email-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL RESEND 00/19] Net patches
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

The following changes since commit 17783ac828adc694d986698d2d7014aedfeb48=
c6:

  Merge remote-tracking branch 'remotes/dgibson/tags/ppc-for-2.9-20170303=
' into staging (2017-03-04 16:31:14 +0000)

are available in the git repository at:

  https://github.com/jasowang/qemu.git tags/net-pull-request

for you to fetch changes up to f0aabd5c4ae11fde704d138e8f06c69e5c902a16:

  net/filter-mirror: Follow CODING_STYLE (2017-03-06 11:46:02 +0800)

----------------------------------------------------------------
Preview pull does not reach list.

- fix vlan issues for e1000e
- convert to use vmstate for vmxnet3
- several fixes for colo
----------------------------------------------------------------
Dmitry Fleytman (5):
      eth: Extend vlan stripping functions
      NetRxPkt: Fix memory corruption on VLAN header stripping
      NetRxPkt: Do not try to pull more data than present
      NetRxPkt: Account buffer with ETH header in IOV length
      NetRxPkt: Remove code duplication in net_rx_pkt_pull_data()

Dr. David Alan Gilbert (2):
      vmxnet3: Convert ring values to uint32_t's
      vmxnet3: VMStatify rx/tx q_descr and int_state

Fam Zheng (1):
      net: Remove useless local var pkt

Zhang Chen (5):
      net/colo-compare: Fix memory free error
      COLO-compare: Rename compare function and remove duplicate codes
      COLO-compare: Optimize compare_common and compare_tcp
      COLO-compare: Fix icmp and udp compare different packet always dump=
 bug
      net/filter-mirror: Follow CODING_STYLE

zhanghailiang (6):
      colo-compare: use g_timeout_source_new() to process the stale packe=
ts
      colo-compare: kick compare thread to exit after some cleanup in fin=
alization
      char: remove the right fd been watched in qemu_chr_fe_set_handlers(=
)
      colo-compare: Fix removing fds been watched incorrectly in finaliza=
tion
      net/colo: fix memory double free error
      filter-rewriter: skip net_checksum_calculate() while offset =3D 0

 chardev/char-fd.c     |   6 +-
 chardev/char-io.c     |   8 +-
 chardev/char-io.h     |   2 +-
 chardev/char-pty.c    |   2 +-
 chardev/char-socket.c |   4 +-
 chardev/char-udp.c    |   6 +-
 chardev/char.c        |   2 +-
 hw/net/net_rx_pkt.c   |  41 ++++----
 hw/net/vmxnet3.c      | 284 +++++++++++++++++---------------------------=
------
 include/net/eth.h     |   4 +-
 net/colo-compare.c    | 189 +++++++++++++++++++--------------
 net/colo.c            |   4 +-
 net/eth.c             |  25 +++--
 net/filter-mirror.c   |   7 +-
 net/filter-rewriter.c |  17 +--
 15 files changed, 273 insertions(+), 328 deletions(-)
