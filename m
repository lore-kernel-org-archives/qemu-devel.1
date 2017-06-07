Received: from eggs.gnu.org ([2001:4830:134:3::10]:43067)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dIRja-0005Qv-6q
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 23:34:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dIRjV-0000w9-SF
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 23:34:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55930)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1dIRjV-0000vy-MC
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 23:34:09 -0400
From: Jason Wang <jasowang@redhat.com>
Date: Wed,  7 Jun 2017 11:34:02 +0800
Message-Id: <1496806444-27910-1-git-send-email-jasowang@redhat.com>
Subject: [Qemu-devel] [PULL 0/2] Net patches
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

The following changes since commit 199e19ee538eb61fd08b1c1ee5aa838ebdcc968e:

  Merge remote-tracking branch 'remotes/mjt/tags/trivial-patches-fetch' into staging (2017-06-05 15:28:12 +0100)

are available in the git repository at:

  https://github.com/jasowang/qemu.git tags/net-pull-request

for you to fetch changes up to 6701e5514beab7b781a10424a94e9850c707287c:

  Revert "Change net/socket.c to use socket_*() functions" again (2017-06-07 10:58:31 +0800)

----------------------------------------------------------------

----------------------------------------------------------------
Daniel P. Berrange (1):
      Revert "Change net/socket.c to use socket_*() functions" again

Mao Zhongyi (1):
      net/rocker: Cleanup the useless return value check

 hw/net/rocker/rocker.c      |   9 ++--
 hw/net/rocker/rocker_desc.c |   4 +-
 net/socket.c                | 127 +++++++++++++++++++-------------------------
 3 files changed, 60 insertions(+), 80 deletions(-)
