Received: from eggs.gnu.org ([2001:4830:134:3::10]:35213)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dh680-0004oW-BO
	for qemu-devel@nongnu.org; Sun, 13 Aug 2017 23:33:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dh67x-0007oy-6r
	for qemu-devel@nongnu.org; Sun, 13 Aug 2017 23:33:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47536)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1dh67x-0007oj-0H
	for qemu-devel@nongnu.org; Sun, 13 Aug 2017 23:33:17 -0400
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 14 Aug 2017 11:33:06 +0800
Message-Id: <1502681591-31362-1-git-send-email-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/5] Net patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: Jason Wang <jasowang@redhat.com>

The following changes since commit 9db6ffc76676731a25a5538ab71e8ca6ac234f=
80:

  Merge remote-tracking branch 'remotes/kevin/tags/for-upstream' into sta=
ging (2017-08-11 15:11:50 +0100)

are available in the git repository at:

  https://github.com/jasowang/qemu.git tags/net-pull-request

for you to fetch changes up to 131f6055f1f0eba4cd2e862a8ff907dbde4d94d1:

  qemu-doc: Mention host_net_add/-remove in the deprecation chapter (2017=
-08-14 10:56:47 +0800)

----------------------------------------------------------------

----------------------------------------------------------------
Mao Zhongyi (4):
      net/rocker: Remove the dead error handling
      net/rocker: Plug memory leak in pci_rocker_init()
      net/rocker: Convert to realize()
      net/rocker: Fix the unusual macro name

Thomas Huth (1):
      qemu-doc: Mention host_net_add/-remove in the deprecation chapter

 hw/net/rocker/rocker.c        | 94 +++++++++++--------------------------=
------
 hw/net/rocker/rocker_desc.c   | 10 -----
 hw/net/rocker/rocker_fp.c     |  4 --
 hw/net/rocker/rocker_of_dpa.c | 20 ---------
 hw/net/rocker/rocker_world.c  | 12 +++---
 qemu-doc.texi                 |  8 ++++
 6 files changed, 36 insertions(+), 112 deletions(-)
