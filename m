Received: from eggs.gnu.org ([2001:4830:134:3::10]:40941)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fY1az-0002pv-Ie
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 23:58:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fY1ay-00060V-SG
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 23:58:17 -0400
From: Fam Zheng <famz@redhat.com>
Date: Wed, 27 Jun 2018 11:57:50 +0800
Message-Id: <20180627035752.1425-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH 0/2] block: Two copy offloading corrections
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>



Fam Zheng (2):
  qcow2: Remove dead check on !ret
  block: Move request tracking to children in copy offloading

 block/io.c    | 59 ++++++++++++++++++++++++---------------------------
 block/qcow2.c |  2 +-
 2 files changed, 29 insertions(+), 32 deletions(-)

-- 
2.17.1
