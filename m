Received: from eggs.gnu.org ([2001:4830:134:3::10]:37222)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cgFb3-0007Eb-Hl
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 13:55:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cgFb0-0006nH-HZ
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 13:55:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:32792)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cgFb0-0006ms-Bu
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 13:55:30 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4B41DC05678C
	for <qemu-devel@nongnu.org>; Tue, 21 Feb 2017 18:55:30 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Tue, 21 Feb 2017 18:55:24 +0000
Message-Id: <20170221185527.3901-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PULL 0/3] hmp queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, phrdina@redhat.com, thuth@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

The following changes since commit 796b288f7be875045670f963ce99991b3c8e96ac:

  Merge remote-tracking branch 'remotes/cody/tags/block-pull-request' into staging (2017-02-21 15:48:22 +0000)

are available in the git repository at:

  git://github.com/dagrh/qemu.git tags/pull-hmp-20170221

for you to fetch changes up to 854e67fea6a6f181163a5467fc9ba04de8d181bb:

  monitor: Fix crashes when using HMP commands without CPU (2017-02-21 18:29:01 +0000)

----------------------------------------------------------------
HMP pull

Note, I had seen a fail in the vhost-user/flags-mismatch on one
host in one build, but not others with the same patches; and these patches
go nowhere near that, so I think that's a separate vhost-user issue.

----------------------------------------------------------------
Eric Blake (1):
      hmp: fix block_set_io_throttle

Pavel Hrdina (1):
      monitor: add poll-* properties into query-iothreads result

Thomas Huth (1):
      monitor: Fix crashes when using HMP commands without CPU

 hmp.c                   | 18 +++++++++++++++---
 iothread.c              |  3 +++
 monitor.c               | 42 ++++++++++++++++++++++++++++++++++--------
 qapi-schema.json        | 15 ++++++++++++++-
 target/i386/monitor.c   | 16 +++++++++++++++-
 target/ppc/monitor.c    |  4 ++++
 target/sh4/monitor.c    |  5 +++++
 target/sparc/monitor.c  |  4 ++++
 target/xtensa/monitor.c |  4 ++++
 9 files changed, 98 insertions(+), 13 deletions(-)
