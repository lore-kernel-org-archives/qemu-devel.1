Received: from eggs.gnu.org ([2001:4830:134:3::10]:41302)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ashijeetacharya@gmail.com>) id 1cmfas-0004WM-VW
	for qemu-devel@nongnu.org; Sat, 11 Mar 2017 06:53:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ashijeetacharya@gmail.com>) id 1cmfap-0007x4-51
	for qemu-devel@nongnu.org; Sat, 11 Mar 2017 06:53:55 -0500
From: Ashijeet Acharya <ashijeetacharya@gmail.com>
Date: Sat, 11 Mar 2017 17:24:03 +0530
Message-Id: <1489233245-27057-1-git-send-email-ashijeetacharya@gmail.com>
Subject: [Qemu-devel] [PATCH 0/2] Allocate mutiple clusters for VMDK I/O
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: famz@redhat.com
Cc: kwolf@redhat.com, jsnow@redhat.com, mreitz@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org, Ashijeet Acharya <ashijeetacharya@gmail.com>

This series optimizes the I/O performance of VMDK driver.

Patch 1 makes the VMDK driver to allocate multiple clusters at once. Earlier
it used to allocate cluster by cluster which slowed down its performance to a
great extent.

Patch 2 changes the metadata update code to update the L2 tables for multiple
clusters at once.

Note: These changes pass all 41/41 tests suitable for VMDK driver.

Ashijeet Acharya (2):
  vmdk: Optimize I/O by allocating multiple clusters
  vmdk: Update metadata for multiple clusters

 block/vmdk.c | 596 ++++++++++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 444 insertions(+), 152 deletions(-)

-- 
2.6.2
