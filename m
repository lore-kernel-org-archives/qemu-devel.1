Received: from eggs.gnu.org ([2001:4830:134:3::10]:51038)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fBhBE-0005Nq-Mz
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 09:43:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fBhBD-0003o0-UK
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 09:43:24 -0400
From: Eric Blake <eblake@redhat.com>
Date: Thu, 26 Apr 2018 08:43:02 -0500
Message-Id: <20180426134305.642080-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH 0/3] block: byte-based blocking read/write
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com

A logical followup to my other recent cleanups.  The only remaining
mention of sectors in block.h APIs is in bdrv_nb_sectors()
(converting those callers to bdrv_getlength() not only requires more
work, but would be our opportunity to see if we could quit rounding
block sizes to sector boundaries for byte-based protocols that can
actually report an exact unaligned size) and for computing geometries
(where it actually makes sense).

Based-on: <20180424192506.149089-1-eblake@redhat.com>
([PATCH v2 0/6] block: byte-based AIO read/write)
Based-on: <20180426025129.621969-1-eblake@redhat.com>
([PATCH v6 0/6] minor qcow2 compression improvements)

Eric Blake (3):
  vdi: Switch to byte-based calls
  vvfat: Switch to byte-based calls
  block: Removed unused sector-based blocking I/O

 include/block/block.h |  4 ----
 block/io.c            | 48 ++++++++----------------------------------------
 block/vdi.c           | 14 +++++++-------
 block/vvfat.c         | 20 +++++++++++---------
 4 files changed, 26 insertions(+), 60 deletions(-)

-- 
2.14.3
