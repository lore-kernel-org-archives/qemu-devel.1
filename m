Received: from eggs.gnu.org ([2001:4830:134:3::10]:44116)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eoe3H-0001nx-1A
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 18:44:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eoe1g-0007WP-QW
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 18:43:54 -0500
From: Eric Blake <eblake@redhat.com>
Date: Wed, 21 Feb 2018 17:39:50 -0600
Message-Id: <20180221233953.5142-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/3] qcow2: minor compression improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org, berto@igalia.com

Updates to v1:
- fix whitespace [Berto]
- fix g_try_malloc usage [Berto, Kevin]
- improve comments [Berto, Kevin]
- add a patch to avoid overflow on 512TB images with 2M clusters

Eric Blake (3):
  qcow2: Prefer byte-based calls into bs->file
  qcow2: Don't allow overflow during cluster allocation
  qcow2: Avoid memory over-allocation on compressed images

 block/qcow2.h          |  6 ++++++
 block/qcow2-cluster.c  | 32 ++++++++++++++++++++------------
 block/qcow2-refcount.c | 26 ++++++++++++++++----------
 block/qcow2.c          |  2 +-
 4 files changed, 43 insertions(+), 23 deletions(-)

-- 
2.14.3
