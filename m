Received: from eggs.gnu.org ([2001:4830:134:3::10]:48489)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1coJf8-00067j-OX
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 20:53:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1coJf5-0006mo-Nm
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 20:53:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54660)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1coJf5-0006mk-He
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 20:53:03 -0400
From: John Snow <jsnow@redhat.com>
Date: Wed, 15 Mar 2017 20:52:56 -0400
Message-Id: <20170316005259.21970-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL for-rc1 0/3] Ide patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, jsnow@redhat.com

The following changes since commit 1883ff34b540daacae948f493b0ba525edf5f6=
42:

  Merge remote-tracking branch 'remotes/mst/tags/for_upstream' into stagi=
ng (2017-03-15 18:44:05 +0000)

are available in the git repository at:

  https://github.com/jnsnow/qemu.git tags/ide-pull-request

for you to fetch changes up to d68f0f778e7f4fbd674627274267f269e40f0b04:

  ide: ahci: call cleanup function in ahci unit (2017-03-15 20:50:14 -040=
0)

----------------------------------------------------------------

----------------------------------------------------------------

Li Qiang (3):
  ide: qdev: register ide bus unrealize function
  ide: core: add cleanup function
  ide: ahci: call cleanup function in ahci unit

 hw/ide/ahci.c             | 12 ++++++++++++
 hw/ide/core.c             |  8 ++++++++
 hw/ide/qdev.c             | 12 ++++++------
 include/hw/ide/internal.h |  1 +
 4 files changed, 27 insertions(+), 6 deletions(-)

--=20
2.9.3
