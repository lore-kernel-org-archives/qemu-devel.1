Received: from eggs.gnu.org ([2001:4830:134:3::10]:39332)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1fjmnY-00060K-6b
	for qemu-devel@nongnu.org; Sun, 29 Jul 2018 10:35:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1fjmnX-0004hF-DV
	for qemu-devel@nongnu.org; Sun, 29 Jul 2018 10:35:52 -0400
Received: from hera.aquilenet.fr ([2a0c:e300::1]:34034)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1fjmnX-0004fT-69
	for qemu-devel@nongnu.org; Sun, 29 Jul 2018 10:35:51 -0400
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Sun, 29 Jul 2018 16:35:44 +0200
Message-Id: <20180729143545.6978-1-samuel.thibault@ens-lyon.org>
Subject: [Qemu-devel] [PULL 0/1] slirp fix for qemu 3.0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org, mdroth@linux.vnet.ibm.com
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>, stefanha@redhat.com, jan.kiszka@siemens.com

The following changes since commit 18a398f6a39df4b08ff86ac0d38384193ca5f4cc:

  Update version for v3.0.0-rc2 release (2018-07-24 22:06:31 +0100)

are available in the Git repository at:

  https://people.debian.org/~sthibault/qemu.git tags/samuel-thibault

for you to fetch changes up to 176e8672834d2038e744d7f230c3d75ecfec66aa:

  slirp: fix ICMP handling on macOS hosts (2018-07-29 16:28:58 +0200)

----------------------------------------------------------------
slirp fixes

Andrew Oates (1):
  slirp: fix ICMP handling on macOS hosts

----------------------------------------------------------------
Andrew Oates (1):
      slirp: fix ICMP handling on macOS hosts

 slirp/ip_icmp.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)
