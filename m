Received: from eggs.gnu.org ([2001:4830:134:3::10]:57962)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1e9fXz-00087m-Jg
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 19:02:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1e9fXv-0008RB-7S
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 19:02:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46996)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1e9fXv-0008Qd-10
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 19:02:11 -0400
From: John Snow <jsnow@redhat.com>
Date: Tue, 31 Oct 2017 19:02:04 -0400
Message-Id: <20171031230206.32731-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/2] Ide patches
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

The following changes since commit 7fa00e204902cee0b33a0c60de87e87319d180=
9f:

  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-201=
71031' into staging (2017-10-31 14:28:25 +0000)

are available in the git repository at:

  https://github.com/jnsnow/qemu.git tags/ide-pull-request

for you to fetch changes up to 96f43c2b0a663f4789b51ed97297163321e7ba5e:

  ide: avoid referencing NULL dev in rotational rate setting (2017-10-31 =
18:00:03 -0400)

----------------------------------------------------------------

----------------------------------------------------------------

Daniel P. Berrange (1):
  ide: avoid referencing NULL dev in rotational rate setting

Thomas Huth (1):
  hw/ide/ahci: Move allwinner code into a separate file

 hw/ide/Makefile.objs    |   1 +
 hw/ide/ahci-allwinner.c | 127 ++++++++++++++++++++++++++++++++++++++++++=
++++++
 hw/ide/ahci.c           |  95 ------------------------------------
 hw/ide/core.c           |   4 +-
 4 files changed, 131 insertions(+), 96 deletions(-)
 create mode 100644 hw/ide/ahci-allwinner.c

--=20
2.9.5
