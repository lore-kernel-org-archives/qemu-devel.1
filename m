Received: from eggs.gnu.org ([2001:4830:134:3::10]:38786)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <otubo@redhat.com>) id 1dsmCS-0000RZ-Sk
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 04:42:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <otubo@redhat.com>) id 1dsmCP-00030w-PX
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 04:42:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37012)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <otubo@redhat.com>) id 1dsmCP-00030Y-Jb
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 04:42:09 -0400
From: Eduardo Otubo <otubo@redhat.com>
Date: Fri, 15 Sep 2017 10:41:33 +0200
Message-Id: <20170915084139.4481-1-otubo@redhat.com>
Subject: [Qemu-devel] [PULL 00/06] seccomp branch queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Fam Zheng <famz@redhat.com>, Thomas Huth <thuth@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>

The following changes since commit 3dabde1128b671f36ac6cb36b97b273139964420:

  Merge remote-tracking branch 'remotes/dgilbert/tags/pull-hmp-20170914' into staging (2017-09-14 16:33:02 +0100)

are available in the git repository at:

  https://github.com/otubo/qemu.git tags/pull-seccomp-20170915

for you to fetch changes up to c3883e1f935bf11ef0d2b8157b0022ace3d0e77d:

  buildsys: Move seccomp cflags/libs to per object (2017-09-15 10:16:05 +0200)

----------------------------------------------------------------
pull-seccomp-20170915

----------------------------------------------------------------
Eduardo Otubo (5):
      seccomp: changing from whitelist to blacklist
      seccomp: add obsolete argument to command line
      seccomp: add elevateprivileges argument to command line
      seccomp: add spawn argument to command line
      seccomp: add resourcecontrol argument to command line

Fam Zheng (1):
      buildsys: Move seccomp cflags/libs to per object

 Makefile.objs            |   2 +
 configure                |   6 +-
 include/sysemu/seccomp.h |   8 +-
 qemu-options.hx          |  26 +++-
 qemu-seccomp.c           | 303 +++++++++++------------------------------------
 vl.c                     |  84 ++++++++++++-
 6 files changed, 190 insertions(+), 239 deletions(-)

-- 
2.13.5
