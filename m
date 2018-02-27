Received: from eggs.gnu.org ([2001:4830:134:3::10]:49038)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eqhbH-0002Es-Dp
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 10:55:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eqhbG-0005hh-LB
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 10:55:31 -0500
From: Eric Blake <eblake@redhat.com>
Date: Tue, 27 Feb 2018 09:55:09 -0600
Message-Id: <20180227155514.16721-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v4 0/5] minor compression improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: berto@igalia.com, qemu-block@nongnu.org, kwolf@redhat.com

In v4:
- patch 2 has even more wording tweaks [Kevin]
- patch 3 is new [Berto]
- patch 5 fixes an off-by-one [Berto]

Eric Blake (5):
  qcow2: Prefer byte-based calls into bs->file
  qcow2: Document some maximum size constraints
  qcow2: Reduce REFT_OFFSET_MASK
  qcow2: Don't allow overflow during cluster allocation
  qcow2: Avoid memory over-allocation on compressed images

 docs/interop/qcow2.txt | 38 +++++++++++++++++++++++++++++++++++---
 block/qcow2.h          |  8 +++++++-
 block/qcow2-cluster.c  | 32 ++++++++++++++++++++------------
 block/qcow2-refcount.c | 27 +++++++++++++++++----------
 block/qcow2.c          |  2 +-
 5 files changed, 80 insertions(+), 27 deletions(-)

-- 
2.14.3
