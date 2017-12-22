Received: from eggs.gnu.org ([2001:4830:134:3::10]:37517)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1eSCsD-0007DG-PY
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 21:15:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1eSCsB-0008Uj-55
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 21:15:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50174)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1eSCsA-0008Tl-VI
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 21:15:43 -0500
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 22 Dec 2017 10:15:19 +0800
Message-Id: <1513908937-16034-1-git-send-email-jasowang@redhat.com>
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

The following changes since commit 43ab9a5376c95c61ae898a222c4d04bdf60e23=
9b:

  hw/i386/vmport: fix missing definitions with non-log trace backends (20=
17-12-21 22:52:28 +0000)

are available in the git repository at:

  https://github.com/jasowang/qemu.git tags/net-pull-request

for you to fetch changes up to 0065e915192cdf83c2700bb377e5323c2649476e:

  qemu-doc: Update the deprecation information of -tftp, -bootp, -redir a=
nd -smb (2017-12-22 10:06:05 +0800)

----------------------------------------------------------------

----------------------------------------------------------------
Ed Swierk via Qemu-devel (2):
      e1000, e1000e: Move per-packet TX offload flags out of context stat=
e
      e1000: Separate TSO and non-TSO contexts, fixing UDP TX corruption

Mark Cave-Ayland (13):
      net: move CRC32 calculation from compute_mcast_idx() into its own n=
et_crc32() function
      net: introduce net_crc32_le() function
      pcnet: switch pcnet over to use net_crc32_le()
      eepro100: switch eepro100 e100_compute_mcast_idx() over to use net_=
crc32()
      sunhme: switch sunhme over to use net_crc32_le()
      sungem: fix multicast filter CRC calculation
      eepro100: use inline net_crc32() and bitshift instead of compute_mc=
ast_idx()
      opencores_eth: use inline net_crc32() and bitshift instead of compu=
te_mcast_idx()
      lan9118: use inline net_crc32() and bitshift instead of compute_mca=
st_idx()
      ftgmac100: use inline net_crc32() and bitshift instead of compute_m=
cast_idx()
      ne2000: use inline net_crc32() and bitshift instead of compute_mcas=
t_idx()
      rtl8139: use inline net_crc32() and bitshift instead of compute_mca=
st_idx()
      net: remove unused compute_mcast_idx() function

Thomas Huth (3):
      net: Remove the legacy "-net channel" parameter
      qemu-doc: The "-net nic" option can be used with "netdev=3D...", to=
o
      qemu-doc: Update the deprecation information of -tftp, -bootp, -red=
ir and -smb

 hw/net/e1000.c         | 92 ++++++++++++++++++++++++++++----------------=
------
 hw/net/e1000e.c        |  4 +--
 hw/net/e1000e_core.c   | 16 ++++-----
 hw/net/e1000e_core.h   |  2 ++
 hw/net/e1000x_common.h |  2 --
 hw/net/eepro100.c      | 32 +++---------------
 hw/net/ftgmac100.c     |  2 +-
 hw/net/lan9118.c       |  3 +-
 hw/net/ne2000.c        |  4 ++-
 hw/net/opencores_eth.c |  3 +-
 hw/net/pcnet.c         | 22 ++----------
 hw/net/rtl8139.c       |  2 +-
 hw/net/sungem.c        |  5 ++-
 hw/net/sunhme.c        | 25 +-------------
 include/net/net.h      |  5 ++-
 include/net/slirp.h    |  2 --
 net/net.c              | 40 +++++++++++++++-------
 net/slirp.c            | 34 -------------------
 qemu-doc.texi          | 38 +++++++++++----------
 qemu-options.hx        | 14 ++++----
 20 files changed, 144 insertions(+), 203 deletions(-)
