Received: from eggs.gnu.org ([2001:4830:134:3::10]:50209)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eotHg-00041O-HE
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 10:59:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eotHf-0001hl-Pr
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 10:59:48 -0500
From: Eric Blake <eblake@redhat.com>
Date: Thu, 22 Feb 2018 09:59:18 -0600
Message-Id: <20180222155922.9833-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v3 0/4] qcow2: minor compression improvements
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

Since v2:
- new patch 2, spec changes based on list followup
- tweak patch 3 to use MIN() and stop open-coding a calculation [Berto]
- tweak patch 4 to stop overallocating by a sector [Berto]

Eric Blake (4):
  qcow2: Prefer byte-based calls into bs->file
  qcow2: Document some maximum size constraints
  qcow2: Don't allow overflow during cluster allocation
  qcow2: Avoid memory over-allocation on compressed images

 docs/interop/qcow2.txt | 29 ++++++++++++++++++++++++++---
 block/qcow2.h          |  6 ++++++
 block/qcow2-cluster.c  | 32 ++++++++++++++++++++------------
 block/qcow2-refcount.c | 27 +++++++++++++++++----------
 block/qcow2.c          |  2 +-
 5 files changed, 70 insertions(+), 26 deletions(-)

-- 
2.14.3
