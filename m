Received: from eggs.gnu.org ([2001:4830:134:3::10]:37086)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dhbsz-0002wk-4w
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 09:27:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dhbsw-0002q9-GX
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 09:27:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50568)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1dhbsw-0002pe-Aq
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 09:27:54 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Tue, 15 Aug 2017 14:27:44 +0100
Message-Id: <20170815132746.12540-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL 0/2] Tracing patches
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

The following changes since commit 5681da292242550f37ba4c03f46a8a6f8ee9278a:

  Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20170815' into staging (2017-08-15 09:39:14 +0100)

are available in the git repository at:

  git://github.com/stefanha/qemu.git tags/tracing-pull-request

for you to fetch changes up to 840d8351774664d01c328d31ed33b0e2d85c866e:

  simpletrace: fix flight recorder --no-header option (2017-08-15 12:50:29 +0100)

----------------------------------------------------------------

----------------------------------------------------------------

Stefan Hajnoczi (2):
  trace: use static event ID mapping in simpletrace.stp
  simpletrace: fix flight recorder --no-header option

 scripts/simpletrace.py                       | 24 +++++++++++++++------
 scripts/tracetool/format/simpletrace_stap.py | 31 ++--------------------------
 2 files changed, 20 insertions(+), 35 deletions(-)

-- 
2.13.4
