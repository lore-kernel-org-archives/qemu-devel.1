Received: from eggs.gnu.org ([2001:4830:134:3::10]:40831)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <agraf@suse.de>) id 1d2yrT-0001Ga-Vf
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 07:42:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <agraf@suse.de>) id 1d2yrP-0001RQ-S8
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 07:42:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:53128 helo=mx1.suse.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <agraf@suse.de>) id 1d2yrP-0001Qf-LJ
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 07:42:23 -0400
From: Alexander Graf <agraf@suse.de>
Date: Tue, 25 Apr 2017 13:42:40 +0200
Message-Id: <1493120560-117434-1-git-send-email-agraf@suse.de>
Subject: [Qemu-devel] [PULL 0/2] s390 patch queue 2017-04-25
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

Hi Peter,

This is my current patch queue for s390.  Please pull.

Alex


The following changes since commit f4b5b021c847669b1c78050aea26fe9abceef6dd:

  Merge remote-tracking branch 'remotes/cody/tags/block-pull-request' into staging (2017-04-25 09:21:54 +0100)

are available in the git repository at:


  git://github.com/agraf/qemu.git tags/signed-s390-for-upstream

for you to fetch changes up to 2cf9953beebd194a432ebd567399807d9b1f6a4d:

  s390x/misc_helper.c: wrap s390_virtio_hypercall in BQL (2017-04-25 13:39:43 +0200)

----------------------------------------------------------------
Patch queue for s390 - 2017-04-25

Two simple fixes this time around:

  - fix BQL for s390 virtio target
  - Fix SIGP emulation

----------------------------------------------------------------
Aurelien Jarno (1):
      s390x/misc_helper.c: wrap s390_virtio_hypercall in BQL

Philipp Kern (1):
      target-s390x: Mask the SIGP order_code to 8bit.

 target/s390x/misc_helper.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)
