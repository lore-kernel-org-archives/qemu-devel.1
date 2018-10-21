Received: from eggs.gnu.org ([2001:4830:134:3::10]:60441)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gEJQn-0001iD-TB
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 15:30:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gEJQm-0003id-W2
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 15:30:33 -0400
Received: from hera.aquilenet.fr ([2a0c:e300::1]:55674)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1gEJQi-0003fm-TR
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 15:30:29 -0400
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Sun, 21 Oct 2018 21:30:12 +0200
Message-Id: <20181021193014.22512-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/2] slirp updates
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>, stefanha@redhat.com, jan.kiszka@siemens.com

The following changes since commit b312532fd03413d0e6ae6767ec793a3e30f487=
b8:

  Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into s=
taging (2018-10-19 19:01:07 +0100)

are available in the Git repository at:

  https://people.debian.org/~sthibault/qemu.git tags/samuel-thibault

for you to fetch changes up to 0fca92b9077af9817c04545cdfc519fe95c6fde9:

  slirp: Implement RFC2132 TFTP server name (2018-10-21 21:24:55 +0200)

----------------------------------------------------------------
Fam Zheng (2):
  slirp: Add sanity check for str option length
  slirp: Implement RFC2132 TFTP server name

----------------------------------------------------------------
Fam Zheng (2):
      slirp: Add sanity check for str option length
      slirp: Implement RFC2132 TFTP server name

 net/slirp.c      | 21 +++++++++++++++++++--
 qapi/net.json    |  5 ++++-
 qemu-options.hx  |  7 ++++++-
 slirp/bootp.c    | 45 +++++++++++++++++++++++++++++++++++----------
 slirp/bootp.h    |  1 +
 slirp/libslirp.h |  1 +
 slirp/slirp.c    |  2 ++
 slirp/slirp.h    |  1 +
 8 files changed, 69 insertions(+), 14 deletions(-)
