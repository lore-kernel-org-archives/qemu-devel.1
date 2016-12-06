Received: from eggs.gnu.org ([2001:4830:134:3::10]:35007)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cEHUR-0004d9-IN
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 10:17:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cEHUQ-0002IC-Pc
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 10:17:07 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue,  6 Dec 2016 16:16:57 +0100
Message-Id: <1481037418-10239-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL] Block layer patches for 2.8.0-rc3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, stefanha@redhat.com, qemu-devel@nongnu.org

The following changes since commit bc66cedb4141fb7588f2462c74310d8fb5dd4cf1:

  Merge remote-tracking branch 'yongbok/tags/mips-20161204' into staging (2016-12-05 10:56:45 +0000)

are available in the git repository at:


  git://repo.or.cz/qemu/kevin.git tags/for-upstream

for you to fetch changes up to a3e1505daec31ef56f0489f8c8fff1b8e4ca92bd:

  qcow2: Don't strand clusters near 2G intervals during commit (2016-12-06 15:37:02 +0100)

----------------------------------------------------------------
Block layer patches for 2.8.0-rc3

----------------------------------------------------------------
Eric Blake (1):
      qcow2: Don't strand clusters near 2G intervals during commit

 block/qcow2.c              |   3 +-
 tests/qemu-iotests/097     |  41 +++++---
 tests/qemu-iotests/097.out | 249 +++++++++++++++++++++++++++++++++------------
 3 files changed, 210 insertions(+), 83 deletions(-)
