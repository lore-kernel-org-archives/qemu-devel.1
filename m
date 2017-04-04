Received: from eggs.gnu.org ([2001:4830:134:3::10]:40140)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cvQG0-0007BT-EU
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 11:20:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cvQFv-0005fB-M2
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 11:20:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37900)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cvQFv-0005eh-Gj
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 11:20:27 -0400
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Tue,  4 Apr 2017 16:20:09 +0100
Message-Id: <20170404152011.16119-1-berrange@redhat.com>
Subject: [Qemu-devel] [PULL v1 0/2] Merge qio 2017/04/04 v1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, "Daniel P. Berrange" <berrange@redhat.com>

The following changes since commit 87cc4c61020addea6a001b94b662596b1896d1b3:

  Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into staging (2017-04-04 11:40:55 +0100)

are available in the git repository at:

  git://github.com/berrange/qemu tags/pull-qio-2017-04-04-1

for you to fetch changes up to b8a68728b6a3fad86f15aa5efdc31ea0b3cb8a62:

  io: fix FD socket handling in DNS lookup (2017-04-04 16:17:03 +0100)

----------------------------------------------------------------
Merge qio 2017/04/04 v1

----------------------------------------------------------------

Daniel P. Berrange (1):
  io: fix FD socket handling in DNS lookup

Wang guang (1):
  io: fix incoming client socket initialization

 io/channel-socket.c            | 8 +-------
 io/dns-resolver.c              | 5 +----
 tests/test-io-channel-socket.c | 8 ++++++++
 3 files changed, 10 insertions(+), 11 deletions(-)

-- 
2.9.3
