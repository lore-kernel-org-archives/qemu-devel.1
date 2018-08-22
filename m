Received: from eggs.gnu.org ([2001:4830:134:3::10]:33645)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1fsK3O-0001fP-VT
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 23:43:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1fsK3O-0001vI-7l
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 23:43:30 -0400
From: Jeff Cody <jcody@redhat.com>
Date: Tue, 21 Aug 2018 23:43:17 -0400
Message-Id: <20180822034319.686504-1-jcody@redhat.com>
Subject: [Qemu-devel] [PULL 0/2] Block patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: peter.maydell@linaro.org, jcody@redhat.com, qemu-devel@nongnu.org

The following changes since commit ee135aa0428fe5af2af7be04ff16d2b596a9330a:

  Merge remote-tracking branch 'remotes/dgibson/tags/ppc-for-3.1-20180821' into staging (2018-08-21 13:27:11 +0100)

are available in the Git repository at:

  git://github.com/codyprime/qemu-kvm-jtc.git tags/block-pull-request

for you to fetch changes up to 26bf474ba92c76e61bea51726e22da6dfd185296:

  block: iotest to catch abort on forced blockjob cancel (2018-08-21 15:20:37 -0400)

----------------------------------------------------------------
Block job patches
----------------------------------------------------------------

Jeff Cody (2):
  block: for jobs, do not clear user_paused until after the resume
  block: iotest to catch abort on forced blockjob cancel

 job.c                      |  2 +-
 tests/qemu-iotests/229     | 95 ++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/229.out | 23 +++++++++
 tests/qemu-iotests/group   |  1 +
 4 files changed, 120 insertions(+), 1 deletion(-)
 create mode 100755 tests/qemu-iotests/229
 create mode 100644 tests/qemu-iotests/229.out

-- 
2.17.1
