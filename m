Received: from eggs.gnu.org ([2001:4830:134:3::10]:47435)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ddJ4U-0005cu-Qt
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 12:34:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ddJ4U-00043G-08
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 12:34:02 -0400
From: Eric Blake <eblake@redhat.com>
Date: Thu,  3 Aug 2017 11:33:49 -0500
Message-Id: <20170803163353.19558-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 for-2.10 0/4] improved --version/--help
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
Cc: kwolf@redhat.com, pbonzini@redhat.com, berrange@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org, peter.maydell@linaro.org

Not sure if this should go through Kevin's block tree, Paolo's
miscellaneous patches, or if I should just do a pull request
myself (since patch 4 includes a change to qemu-nbd)

since v2: add R-b on 2-4; also sort 'qemu-img --help' create text

001/4:[0012] [FC] 'qemu-img: Sort sub-command names in --help'
002/4:[----] [--] 'qemu-io: Give more --version information'
003/4:[----] [--] 'qga: Give more --version information'
004/4:[----] [--] 'maint: Include bug-reporting info in --help output'

Eric Blake (4):
  qemu-img: Sort sub-command names in --help
  qemu-io: Give more --version information
  qga: Give more --version information
  maint: Include bug-reporting info in --help output

 include/qemu-common.h |  5 +++++
 vl.c                  |  4 +++-
 bsd-user/main.c       |  2 ++
 linux-user/main.c     |  4 +++-
 qemu-img.c            |  2 +-
 qemu-io.c             |  9 ++++++---
 qemu-nbd.c            |  2 +-
 qga/main.c            |  8 +++++---
 qemu-img-cmds.hx      | 21 ++++++++++++---------
 9 files changed, 38 insertions(+), 19 deletions(-)

--=20
2.13.3
