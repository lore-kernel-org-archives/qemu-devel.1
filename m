Received: from eggs.gnu.org ([2001:4830:134:3::10]:55471)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jgross@suse.com>) id 1coWG9-0002Zq-JX
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 10:20:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jgross@suse.com>) id 1coWG3-0008Ui-TY
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 10:20:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:60558)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jgross@suse.com>) id 1coWG3-0008ST-MT
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 10:20:03 -0400
From: Juergen Gross <jgross@suse.com>
Date: Thu, 16 Mar 2017 15:19:51 +0100
Message-Id: <20170316141953.16161-1-jgross@suse.com>
Subject: [Qemu-devel] [PATCH 0/2] xen: use pkg-config for configure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, xen-devel@lists.xenproject.org
Cc: anthony.perard@citrix.com, kraxel@redhat.com, sstabellini@kernel.org, paul.durrant@citrix.com, Juergen Gross <jgross@suse.com>

This small patch set is to be applied on top of Paul's series for
support of libxendevicemodel, or (maybe even better) it should be
merged into this series.

Juergen Gross (2):
  xen: use 5 digit xen versions
  configure: use pkg-config for obtaining xen version

 configure                   | 43 +++++++++++++++++--------------------------
 hw/block/xen_disk.c         |  2 +-
 include/hw/xen/xen_common.h | 22 +++++++++++-----------
 3 files changed, 29 insertions(+), 38 deletions(-)

-- 
2.10.2
