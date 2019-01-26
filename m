Received: from eggs.gnu.org ([209.51.188.92]:59649)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gnVNA-0007Wf-JQ
	for qemu-devel@nongnu.org; Sat, 26 Jan 2019 16:20:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gnVN9-0004Wz-UM
	for qemu-devel@nongnu.org; Sat, 26 Jan 2019 16:20:16 -0500
Received: from hera.aquilenet.fr ([185.233.100.1]:35584)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1gnVN9-0004WR-Np
	for qemu-devel@nongnu.org; Sat, 26 Jan 2019 16:20:15 -0500
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Sat, 26 Jan 2019 22:20:07 +0100
Message-Id: <20190126212010.11730-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/3] slirp updates
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>, stefanha@redhat.com, jan.kiszka@siemens.com

The following changes since commit ad7a21e81231ae64540310384fb0f87ac8758b=
02:

  Merge remote-tracking branch 'remotes/ehabkost/tags/python-next-pull-re=
quest' into staging (2019-01-25 17:22:20 +0000)

are available in the Git repository at:

  https://people.debian.org/~sthibault/qemu.git tags/samuel-thibault

for you to fetch changes up to 4956f29c43c2105dc37ee9826959b3aa1d3b0b69:

  slirp: Don't mark struct ipq or struct ipasfrag as packed (2019-01-26 2=
2:09:48 +0100)

----------------------------------------------------------------
slirp updates

Peter Maydell (2):
  slirp: Avoid marking naturally packed structs as QEMU_PACKED
  slirp: Don't mark struct ipq or struct ipasfrag as packed

Samuel Thibault (1):
  slirp: Avoid unaligned 16bit memory access

----------------------------------------------------------------
Peter Maydell (2):
      slirp: Avoid marking naturally packed structs as QEMU_PACKED
      slirp: Don't mark struct ipq or struct ipasfrag as packed

Samuel Thibault (1):
      slirp: Avoid unaligned 16bit memory access

 slirp/ip.h       |  7 +++++--
 slirp/ip6.h      | 12 ++++++++++--
 slirp/ip6_icmp.h | 20 +++++++++++++++-----
 slirp/slirp.c    |  2 +-
 4 files changed, 31 insertions(+), 10 deletions(-)
