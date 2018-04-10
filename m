Received: from eggs.gnu.org ([2001:4830:134:3::10]:38288)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1f5vmZ-0002Ti-3W
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 12:06:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1f5vmV-0003vZ-16
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 12:06:07 -0400
From: Alberto Garcia <berto@igalia.com>
Date: Tue, 10 Apr 2018 18:05:02 +0200
Message-Id: <cover.1523376013.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH 0/2] Minor fixes about compressed clusters with
 OFLAG_COPIED
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

Hi,

while reviewing one previous patch about data corruption and
compressed clusters we discussed that the documentation doesn't
clarify that L2 entries for compressed clusters are not supposed to
have the OFLAG_COPIED bit set.

Here's a patch to update the documentation and another one to fix the
error message that "qemu-img check" produces.

Regards,

Berto

Alberto Garcia (2):
  Fix error message about compressed clusters with OFLAG_COPIED
  specs/qcow2: Clarify that compressed clusters have the COPIED bit
    reset

 block/qcow2-refcount.c | 4 ++--
 docs/interop/qcow2.txt | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

-- 
2.11.0
