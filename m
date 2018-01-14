Received: from eggs.gnu.org ([2001:4830:134:3::10]:41434)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1ealxv-000084-Lu
	for qemu-devel@nongnu.org; Sun, 14 Jan 2018 12:21:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1ealxq-0002IB-NS
	for qemu-devel@nongnu.org; Sun, 14 Jan 2018 12:21:03 -0500
Received: from hera.aquilenet.fr ([185.233.100.1]:47660)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1ealxq-0002GC-GL
	for qemu-devel@nongnu.org; Sun, 14 Jan 2018 12:20:58 -0500
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Sun, 14 Jan 2018 18:20:48 +0100
Message-Id: <20180114172053.1051-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/5] slirp updates
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>

warning: redirection vers https://people.debian.org/~sthibault/qemu.git/
The following changes since commit 7398166ddf7c6dbbc9cae6ac69bb2feda14b40=
ac:

  Merge remote-tracking branch 'remotes/kraxel/tags/vnc-20180112-pull-req=
uest' into staging (2018-01-12 16:01:30 +0000)

are available in the Git repository at:

  http://people.debian.org/~sthibault/qemu.git tags/samuel-thibault

for you to fetch changes up to 318116a6ff36bee13c725a247a9395e80bcfbd6b:

  slirp: add in6_dhcp_multicast() (2018-01-14 18:16:13 +0100)

----------------------------------------------------------------
slirp updates

----------------------------------------------------------------
Philippe Mathieu-Daud=C3=A9 (5):
      slirp: avoid IN6_IS_ADDR_UNSPECIFIED(), rather use in6_zero()
      slirp: remove unused header
      slirp: remove unnecessary struct declaration
      slirp: removed unused code
      slirp: add in6_dhcp_multicast()

 slirp/dhcpv6.h    |  3 +++
 slirp/ip.h        | 13 -------------
 slirp/ip6_icmp.c  |  6 +++---
 slirp/libslirp.h  |  1 -
 slirp/ndp_table.c |  4 ++--
 slirp/slirp.h     |  1 -
 slirp/udp6.c      |  2 +-
 7 files changed, 9 insertions(+), 21 deletions(-)
