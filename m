Received: from eggs.gnu.org ([2001:4830:134:3::10]:38435)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1coPSg-0001r3-9f
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 03:04:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1coPSd-0005yt-4G
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 03:04:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47292)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1coPSc-0005ya-VQ
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 03:04:35 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Thu, 16 Mar 2017 15:04:24 +0800
Message-Id: <20170316070427.17120-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL 0/3] Tracing patches
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

The following changes since commit 1883ff34b540daacae948f493b0ba525edf5f642:

  Merge remote-tracking branch 'remotes/mst/tags/for_upstream' into staging (2017-03-15 18:44:05 +0000)

are available in the git repository at:

  git://github.com/stefanha/qemu.git tags/tracing-pull-request

for you to fetch changes up to 8755b4afbdcf1c274cab7545a9f76d3d6c7f5c29:

  trace: ensure $(tracetool-y) is defined in top level makefile (2017-03-16 11:51:26 +0800)

----------------------------------------------------------------
Pull request

Tracing makefile fixes for QEMU 2.9.

----------------------------------------------------------------

Daniel P. Berrange (3):
  makefile: merge GENERATED_HEADERS & GENERATED_SOURCES variables
  makefile: generate trace-events-all upfront
  trace: ensure $(tracetool-y) is defined in top level makefile

 Makefile                   | 42 ++++++++++++++++++++++--------------------
 Makefile.target            |  6 +++---
 target/s390x/Makefile.objs |  2 +-
 tests/Makefile.include     |  2 +-
 trace/Makefile.objs        |  8 --------
 5 files changed, 27 insertions(+), 33 deletions(-)

-- 
2.9.3
