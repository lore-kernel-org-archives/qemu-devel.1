Received: from eggs.gnu.org ([2001:4830:134:3::10]:47605)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cWhHm-0002Bk-1U
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 05:28:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cWhHi-0000Hi-36
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 05:28:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53582)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cWhHh-0000HW-Tb
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 05:28:06 -0500
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Thu, 26 Jan 2017 10:27:56 +0000
Message-Id: <20170126102757.23280-1-berrange@redhat.com>
Subject: [Qemu-devel] [PULL v1] Merge io/ 2017/01/26
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

The following changes since commit c7f1cf01b8245762ca5864e835d84f6677ae8b1f:

  Merge remote-tracking branch 'remotes/gkurz/tags/for-upstream' into staging (2017-01-25 17:54:14 +0000)

are available in the git repository at:

  git://github.com/berrange/qemu tags/pull-qio-2017-01-26-1

for you to fetch changes up to 80fb34eda099e7cc519a91e9701ab3c0262717b3:

  io: fix possible double free of task error object (2017-01-26 10:26:18 +0000)

----------------------------------------------------------------
Merge io/ 2017/01/26

----------------------------------------------------------------
Daniel P. Berrange (1):
  io: fix possible double free of task error object

 io/task.c            | 1 +
 tests/test-io-task.c | 4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)

-- 
2.9.3
