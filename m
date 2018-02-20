Received: from eggs.gnu.org ([2001:4830:134:3::10]:56313)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eoGLf-00047k-Td
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 17:25:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eoGLf-0005HK-4z
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 17:25:19 -0500
From: Eric Blake <eblake@redhat.com>
Date: Tue, 20 Feb 2018 16:24:57 -0600
Message-Id: <20180220222459.8461-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH 0/2] qcow2: minor compression improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, mreitz@redhat.com, berto@igalia.com

I noticed these while reviewing Berto's proposed change to the
qcow2 spec on how compression works.

Eric Blake (2):
  qcow2: Prefer byte-based calls into bs->file
  qcow2: Avoid memory over-allocation on compressed images

 block/qcow2-cluster.c  | 17 +++++------------
 block/qcow2-refcount.c |  6 +++---
 block/qcow2.c          |  2 +-
 3 files changed, 9 insertions(+), 16 deletions(-)

-- 
2.14.3
