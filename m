Received: from eggs.gnu.org ([2001:4830:134:3::10]:33919)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1dwBKp-0004Z0-7U
	for qemu-devel@nongnu.org; Sun, 24 Sep 2017 14:08:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1dwBKm-00057u-2Q
	for qemu-devel@nongnu.org; Sun, 24 Sep 2017 14:08:55 -0400
Received: from hera.aquilenet.fr ([141.255.128.1]:49404)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1dwBKl-00057E-RZ
	for qemu-devel@nongnu.org; Sun, 24 Sep 2017 14:08:51 -0400
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Sun, 24 Sep 2017 20:08:45 +0200
Message-Id: <20170924180848.19168-1-samuel.thibault@ens-lyon.org>
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

warning: redirection vers https://people.debian.org/~sthibault/qemu.git/
The following changes since commit 460b6c8e581aa06b86f59eebd9e52edfe7adf4=
17:

  Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into s=
taging (2017-09-23 12:55:40 +0100)

are available in the git repository at:

  http://people.debian.org/~sthibault/qemu.git tags/samuel-thibault

for you to fetch changes up to 13146a83951e045c810c37c5c11c2a016ebc0663:

  slirp: Add a special case for the NULL socket (2017-09-24 20:04:09 +020=
0)

----------------------------------------------------------------
slirp updates

----------------------------------------------------------------
Dr. David Alan Gilbert (1):
      slirp: Add explanation for hostfwd parsing failure

Kevin Cernekee (2):
      slirp: Fix intermittent send queue hangs on a socket
      slirp: Add a special case for the NULL socket

 net/slirp.c   | 13 ++++++++++-
 slirp/if.c    | 69 +++++++++++++++++++++++------------------------------=
------
 slirp/slirp.h |  1 -
 3 files changed, 39 insertions(+), 44 deletions(-)
