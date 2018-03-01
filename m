Received: from eggs.gnu.org ([2001:4830:134:3::10]:43225)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1erJ3E-0005uy-D7
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 02:54:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1erJ3C-0001F0-DM
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 02:54:52 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40070 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1erJ3C-0001DN-8h
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 02:54:50 -0500
From: Fam Zheng <famz@redhat.com>
Date: Thu,  1 Mar 2018 15:54:27 +0800
Message-Id: <20180301075428.17320-1-famz@redhat.com>
Subject: [Qemu-devel] [PULL 0/1] Block patches 2018-03-01
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>

The following changes since commit 6697439794f72b3501ee16bb95d16854f9981421:

  Merge remote-tracking branch 'remotes/kraxel/tags/usb-20180227-pull-request' into staging (2018-02-27 17:50:46 +0000)

are available in the Git repository at:

  git://github.com/famz/qemu.git tags/staging-pull-request

for you to fetch changes up to 78d8c99e297eba32897d8a5bdaa005670549d6f7:

  block/nvme: fix Coverity reports (2018-03-01 15:21:46 +0800)

----------------------------------------------------------------

Coverity error fix for nvme://

----------------------------------------------------------------

Paolo Bonzini (1):
  block/nvme: fix Coverity reports

 block/nvme.c        | 10 +++++++---
 util/vfio-helpers.c |  2 +-
 2 files changed, 8 insertions(+), 4 deletions(-)

-- 
2.14.3
