Received: from eggs.gnu.org ([2001:4830:134:3::10]:51632)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fvUIc-0004ts-8a
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 17:16:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fvUIa-0003KW-0R
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 17:16:18 -0400
From: John Snow <jsnow@redhat.com>
Date: Thu, 30 Aug 2018 17:16:03 -0400
Message-Id: <20180830211605.13683-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH 0/2] block: add 'bitmap' argument to
 blockdev-backup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>

Eric brought to my attention that we don't currently allow
incremental backups made to a node. There's no reason we can't,
though, so enable this.

A better test in en-route, this is mostly a PoC chainsaw job
on the second patch to see if patchew knows something I don't.

--js

John Snow (2):
  blockdev-backup: add bitmap argument
  HACK: test blockdev-backup instead of drive-backup

 blockdev.c             | 16 +++++++-
 qapi/block-core.json   |  7 +++-
 tests/qemu-iotests/124 | 99 ++++++++++++++++++++++++++++++++++----------------
 3 files changed, 88 insertions(+), 34 deletions(-)

-- 
2.14.4
