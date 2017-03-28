Received: from eggs.gnu.org ([2001:4830:134:3::10]:39573)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1cszzb-0000Q5-2l
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 18:53:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1cszzY-0000HH-18
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 18:53:35 -0400
Received: from hera.aquilenet.fr ([141.255.128.1]:52515)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1cszzX-0000GO-Qt
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 18:53:31 -0400
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Wed, 29 Mar 2017 00:53:24 +0200
Message-Id: <20170328225327.16707-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The following changes since commit df9046363220e57d45818312759b954c033c58=
ab:

  Update version for v2.9.0-rc2 release (2017-03-28 19:11:16 +0100)

are available in the git repository at:

  http://people.debian.org/~sthibault/qemu.git tags/samuel-thibault

for you to fetch changes up to a2f80fdfc683019901cdf4c0863a5920c0ca7245:

  slirp: Send RDNSS in RA only if host has an IPv6 DNS server (2017-03-29=
 00:51:25 +0200)

----------------------------------------------------------------
slirp updates

----------------------------------------------------------------
Laurent Vivier (1):
      slirp: fix compilation errors with DEBUG set

Samuel Thibault (2):
      slirp: Make RA build more flexible
      slirp: Send RDNSS in RA only if host has an IPv6 DNS server

 slirp/ip6_icmp.c | 47 ++++++++++++++++++++++-------------------------
 slirp/slirp.c    |  2 +-
 2 files changed, 23 insertions(+), 26 deletions(-)
