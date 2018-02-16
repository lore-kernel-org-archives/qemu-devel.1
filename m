Received: from eggs.gnu.org ([2001:4830:134:3::10]:48446)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1emk5v-0008EZ-0d
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 12:46:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1emk5q-0000kr-JK
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 12:46:47 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41592 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1emk5q-0000ke-ES
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 12:46:42 -0500
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Fri, 16 Feb 2018 17:46:38 +0000
Message-Id: <20180216174640.21765-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PULL 0/2] hmp queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, thuth@redhat.com, t.pagef.lt@gmail.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

The following changes since commit 5e8d6a12d643a38b82a0a713a77d1192117dbdca:

  Merge remote-tracking branch 'remotes/kraxel/tags/ui-20180216-pull-request' into staging (2018-02-16 15:55:45 +0000)

are available in the Git repository at:

  git://github.com/dagrh/qemu.git tags/pull-hmp-20180216

for you to fetch changes up to bf67f1c0b16c0de43b8a10cb53808dd62b0cdc04:

  monitor.c: Fix infinite loop in monitor's auto-complete (2018-02-16 17:36:16 +0000)

----------------------------------------------------------------
HMP pull 2018-02-16

----------------------------------------------------------------
Dr. David Alan Gilbert (1):
      monitor.c: Fix infinite loop in monitor's auto-complete

Thomas Huth (1):
      monitor: Remove legacy "-mon default=on" parameter

 monitor.c     | 9 ++++-----
 qemu-doc.texi | 9 ---------
 vl.c          | 4 ----
 3 files changed, 4 insertions(+), 18 deletions(-)
