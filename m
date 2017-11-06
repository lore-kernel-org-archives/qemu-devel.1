Received: from eggs.gnu.org ([2001:4830:134:3::10]:56812)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eBjPR-0000dd-5L
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 10:34:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eBjPL-0002cI-E6
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 10:33:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40276)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eBjPL-0002c5-7K
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 10:33:51 -0500
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Mon,  6 Nov 2017 15:33:40 +0000
Message-Id: <20171106153342.24147-1-berrange@redhat.com>
Subject: [Qemu-devel] [PULL v1 0/2] Merge IO 2017/11/06
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

The following changes since commit ec7a8bf0b8f7dc7288fe8745464ee8217528cc6c:

  Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into staging (2017-11-06 10:04:16 +0000)

are available in the git repository at:

  git://github.com/berrange/qemu tags/pull-qio-2017-11-06-1

for you to fetch changes up to 74c0035408d5b327eac5985d976bca3009e0c5d6:

  tests: Add test-listen - a stress test for QEMU socket listen (2017-11-06 11:49:15 +0000)

----------------------------------------------------------------
Merge qio 2017-11-06 v1

----------------------------------------------------------------

Daniel P. Berrange (1):
  sockets: avoid leak of listen file descriptor

Knut Omang (1):
  tests: Add test-listen - a stress test for QEMU socket listen

 tests/Makefile.include |   2 +
 tests/test-listen.c    | 253 +++++++++++++++++++++++++++++++++++++++++++++++++
 util/qemu-sockets.c    |  52 +++++-----
 3 files changed, 284 insertions(+), 23 deletions(-)
 create mode 100644 tests/test-listen.c

-- 
2.13.6
