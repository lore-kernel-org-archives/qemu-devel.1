Received: from eggs.gnu.org ([2001:4830:134:3::10]:53379)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cPLGb-0001ce-PN
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 22:32:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cPLGX-0006qH-SN
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 22:32:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60002)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1cPLGX-0006pg-L4
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 22:32:29 -0500
From: Jason Wang <jasowang@redhat.com>
Date: Fri,  6 Jan 2017 11:32:21 +0800
Message-Id: <1483673544-10663-1-git-send-email-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/3] Net patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, stefanha@redhat.com, qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>

The following changes since commit e92fbc753df4fab9ee524b5ea07a51bee8b6ba=
e4:

  Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request'=
 into staging (2017-01-05 12:44:23 +0000)

are available in the git repository at:

  https://github.com/jasowang/qemu.git tags/net-pull-request

for you to fetch changes up to 7e354ed4df9787ff95cdb189374739e476be4f9a:

  fsl_etsec: Fix Tx BD ring wrapping handling (2017-01-06 10:38:21 +0800)

----------------------------------------------------------------

- network support for record/replay

----------------------------------------------------------------
Andrey Smirnov (1):
      fsl_etsec: Fix Tx BD ring wrapping handling

Herv=C3=A9 Poussineau (1):
      rtl8139: correctly handle PHY reset

Pavel Dovgalyuk (1):
      record/replay: add network support

 docs/replay.txt          |  14 +++++++
 hw/net/fsl_etsec/rings.c |  19 +++++----
 hw/net/rtl8139.c         |  34 ++++++++++------
 include/sysemu/replay.h  |  12 ++++++
 net/Makefile.objs        |   1 +
 net/filter-replay.c      |  92 +++++++++++++++++++++++++++++++++++++++++=
+
 replay/Makefile.objs     |   1 +
 replay/replay-events.c   |  11 +++++
 replay/replay-internal.h |  10 +++++
 replay/replay-net.c      | 102 +++++++++++++++++++++++++++++++++++++++++=
++++++
 replay/replay.c          |   2 +-
 vl.c                     |   3 +-
 12 files changed, 276 insertions(+), 25 deletions(-)
 create mode 100644 net/filter-replay.c
 create mode 100644 replay/replay-net.c
