Received: from eggs.gnu.org ([2001:4830:134:3::10]:49664)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fhyFR-0007Ps-SL
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 10:25:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fhyFO-00008g-FZ
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 10:25:09 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44060 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1fhyFN-00008S-Pm
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 10:25:05 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Tue, 24 Jul 2018 15:25:03 +0100
Message-Id: <20180724142504.15092-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL for-3.0 0/1] Tracing patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

The following changes since commit 768cef2974fb1fa30dd188b043ea737e13fea477:

  Merge remote-tracking branch 'remotes/ehabkost/tags/x86-next-pull-request' into staging (2018-07-24 10:37:52 +0100)

are available in the Git repository at:

  git://github.com/stefanha/qemu.git tags/tracing-pull-request

for you to fetch changes up to b6ad6a528f2356b357bd1d210048dd7988dc9a7b:

  trace/simple: fix hang in child after fork(2) (2018-07-24 14:27:51 +0100)

----------------------------------------------------------------
Pull request

Fix qemu-iotests 147 when QEMU was built with ./configure --enable-trace-backend=simple.

----------------------------------------------------------------

Stefan Hajnoczi (1):
  trace/simple: fix hang in child after fork(2)

 trace/simple.c | 80 ++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 71 insertions(+), 9 deletions(-)

-- 
2.17.1
