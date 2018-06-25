Received: from eggs.gnu.org ([2001:4830:134:3::10]:42994)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fXYlx-0006z9-VU
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 17:11:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fXYlu-0002OE-RL
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 17:11:41 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43452 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1fXYlu-0002O5-Me
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 17:11:38 -0400
From: John Snow <jsnow@redhat.com>
Date: Mon, 25 Jun 2018 17:11:35 -0400
Message-Id: <20180625211136.21295-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PULL 0/1] Ide patches
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

The following changes since commit 35e238c9330669882487f9929e0aa97900431853:

  Merge remote-tracking branch 'remotes/kraxel/tags/audio-20180625-pull-request' into staging (2018-06-25 15:25:26 +0100)

are available in the Git repository at:

  https://github.com/jnsnow/qemu.git tags/ide-pull-request

for you to fetch changes up to ae79c2db150e17757ee1be080481be675a15ccea:

  ahci: fix FIS I bit and PIO Setup FIS interrupt (2018-06-25 16:50:48 -0400)

----------------------------------------------------------------
Pull request

----------------------------------------------------------------

Paolo Bonzini (1):
  ahci: fix FIS I bit and PIO Setup FIS interrupt

 hw/ide/ahci.c          | 37 +++++++++++++++++++++++++------------
 hw/ide/ahci_internal.h |  2 +-
 tests/libqos/ahci.c    | 25 ++++++++++++++++---------
 tests/libqos/ahci.h    |  2 +-
 4 files changed, 43 insertions(+), 23 deletions(-)

-- 
2.14.4
