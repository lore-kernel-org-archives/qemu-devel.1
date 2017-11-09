Received: from eggs.gnu.org ([2001:4830:134:3::10]:57190)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1eCr9C-0005Iy-Ps
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 13:01:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1eCr98-0002Ks-AV
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 13:01:50 -0500
Received: from hera.aquilenet.fr ([2a01:474::1]:34600)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1eCr98-0002K4-3t
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 13:01:46 -0500
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Thu,  9 Nov 2017 19:01:41 +0100
Message-Id: <20171109180142.13923-1-samuel.thibault@ens-lyon.org>
Subject: [Qemu-devel] [PULL 0/1] slirp update
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

warning: redirection vers https://people.debian.org/~sthibault/qemu.git/
The following changes since commit b0fbe46ad82982b289a44ee2495b59b0bad8a842:

  Update version for v2.11.0-rc0 release (2017-11-07 16:05:28 +0000)

are available in the git repository at:

  http://people.debian.org/~sthibault/qemu.git tags/samuel-thibault

for you to fetch changes up to 990132cda9baa27bdc558df6c9c15aacb0322d2c:

  slirp: don't zero the whole ti_i when m == NULL (2017-11-09 18:59:22 +0100)

----------------------------------------------------------------
slirp updates

----------------------------------------------------------------
Tao Wu (1):
      slirp: don't zero the whole ti_i when m == NULL

This fixes the qemu slirp behavior is some rare cases (some RST cases,
keep alive probes), packets would be sent to 0.0.0.0.

 slirp/tcp_subr.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)
