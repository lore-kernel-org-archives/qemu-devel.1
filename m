Received: from eggs.gnu.org ([2001:4830:134:3::10]:56648)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1f0gfO-0007Q5-F3
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 00:57:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1f0gfK-0002wf-KL
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 00:57:02 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41538 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1f0gfK-0002uf-G1
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 00:56:58 -0400
From: John Snow <jsnow@redhat.com>
Date: Tue, 27 Mar 2018 00:56:44 -0400
Message-Id: <20180327045646.21112-1-jsnow@redhat.com>
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

The following changes since commit 7b93d78a04aa242d377ae213b79db6c319c71847:

  Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into staging (2018-03-26 15:17:25 +0100)

are available in the Git repository at:

  https://github.com/jnsnow/qemu.git tags/ide-pull-request

for you to fetch changes up to eb69953ecb1cbe7b4c4093a97a4dab3daa315d4e:

  macio: fix NULL pointer dereference when issuing IDE trim (2018-03-27 00:38:00 -0400)

----------------------------------------------------------------

----------------------------------------------------------------

Anton Nefedov (1):
  ide: fix invalid TRIM range abortion for macio

Mark Cave-Ayland (1):
  macio: fix NULL pointer dereference when issuing IDE trim

 hw/ide/core.c  | 17 +++++++++--------
 hw/ide/macio.c |  2 +-
 2 files changed, 10 insertions(+), 9 deletions(-)

-- 
2.14.3
