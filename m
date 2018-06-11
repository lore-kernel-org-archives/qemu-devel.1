Received: from eggs.gnu.org ([2001:4830:134:3::10]:36618)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fSVXM-0004Q0-VM
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 18:43:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fSVXM-0001TB-AY
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 18:43:45 -0400
From: John Snow <jsnow@redhat.com>
Date: Mon, 11 Jun 2018 18:43:37 -0400
Message-Id: <20180611224338.9743-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH 0/1] blockdev: implement n-ary bitmap merge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, vsementov@virtuozzo.com, Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>

requires: 20180606182449.1607-1-jsnow@redhat.com

See patch for details; this is somewhat an RFC that I suspect
will be useful for libvirt in some situations, but maybe it's
actually overkill.

John Snow (1):
  blockdev: n-ary bitmap merge

 blockdev.c           | 40 ++++++++++++++++++++++++++++++----------
 qapi/block-core.json | 10 +++++-----
 2 files changed, 35 insertions(+), 15 deletions(-)

-- 
2.14.3
