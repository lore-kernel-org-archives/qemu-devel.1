Received: from eggs.gnu.org ([2001:4830:134:3::10]:51426)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eQwi9-0000JU-Ta
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 09:48:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eQwi6-0007fS-Mv
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 09:48:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56658)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eQwi6-0007dR-H8
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 09:48:06 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Mon, 18 Dec 2017 14:47:56 +0000
Message-Id: <20171218144800.27337-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL 0/4] Tracing patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>

The following changes since commit 411ad78115ebeb3411cf4b7622784b93dfabe259:

  Merge remote-tracking branch 'remotes/stefanberger/tags/pull-tpm-2017-12-15-1' into staging (2017-12-17 15:27:41 +0000)

are available in the Git repository at:

  git://github.com/stefanha/qemu.git tags/tracing-pull-request

for you to fetch changes up to 5c9522b358faf9688fd83cd0a881e1990bb84516:

  gdbstub: add tracing (2017-12-18 14:37:36 +0000)

----------------------------------------------------------------

----------------------------------------------------------------

Doug Gale (1):
  gdbstub: add tracing

Namhyung Kim (3):
  trace: Simplify find_debugfs()
  trace: Generalize searching for debugfs
  trace: Try using tracefs first

 gdbstub.c      | 113 +++++++++++++++++++++++++++++++++++++++------------------
 trace/ftrace.c |  33 ++++++++++-------
 trace-events   |  28 ++++++++++++++
 3 files changed, 125 insertions(+), 49 deletions(-)

-- 
2.14.3
