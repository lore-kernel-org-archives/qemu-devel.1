Received: from eggs.gnu.org ([2001:4830:134:3::10]:37063)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=19091db4e=Paul.Durrant@citrix.com>)
	id 1cVzCW-0005Ht-Mu
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 06:23:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=19091db4e=Paul.Durrant@citrix.com>)
	id 1cVzCT-0007BV-IN
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 06:23:48 -0500
Received: from smtp.citrix.com ([66.165.176.89]:9757)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=19091db4e=Paul.Durrant@citrix.com>)
	id 1cVzCT-0007Ab-BZ
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 06:23:45 -0500
From: Paul Durrant <paul.durrant@citrix.com>
Date: Tue, 24 Jan 2017 11:23:37 +0000
Message-ID: <1485257020-18542-1-git-send-email-paul.durrant@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 0/3] xen-platform: disk unplug modifications
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, xen-devel@lists.xenproject.org
Cc: Paul Durrant <paul.durrant@citrix.com>

These patches modify the implementation of Xen HVM disk unplug.

Paul Durrant (3):
  xen-platform: re-structure unplug_disks
  xen-platform: add support for unplugging NVMe disks...
  xen-platform: add missing disk unplug option

 hw/i386/xen/xen_platform.c | 50 +++++++++++++++++++++++++++-------------------
 hw/ide/piix.c              |  4 ++--
 include/hw/ide.h           |  2 +-
 3 files changed, 33 insertions(+), 23 deletions(-)

-- 
2.1.4
