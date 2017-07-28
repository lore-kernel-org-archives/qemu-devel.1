Received: from eggs.gnu.org ([2001:4830:134:3::10]:53568)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1db8Q3-0004AI-Ot
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 12:47:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1db8Q2-0002Ca-Vi
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 12:47:19 -0400
From: Eric Blake <eblake@redhat.com>
Date: Fri, 28 Jul 2017 11:47:04 -0500
Message-Id: <20170728164708.12202-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v2 for-2.10 0/4] improved --version/--help
 tweaks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org, peter.maydell@linaro.org

Merge two previous postings. I'm not sure what tree this should
go through (Paolo's miscellaneous patches?)

Eric Blake (4):
  qemu-img: Sort sub-command names in --help
  qemu-io: Give more --version information
  qga: Give more --version information
  maint: Include bug-reporting info in --help output.

 include/qemu-common.h | 5 +++++
 vl.c                  | 4 +++-
 bsd-user/main.c       | 2 ++
 linux-user/main.c     | 4 +++-
 qemu-img.c            | 2 +-
 qemu-io.c             | 9 ++++++---
 qemu-nbd.c            | 2 +-
 qga/main.c            | 8 +++++---
 qemu-img-cmds.hx      | 9 ++++++---
 9 files changed, 32 insertions(+), 13 deletions(-)

-- 
2.13.3
