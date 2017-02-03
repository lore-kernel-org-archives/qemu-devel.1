Received: from eggs.gnu.org ([2001:4830:134:3::10]:41843)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cZgO2-0007Qf-Jb
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 11:06:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cZgNy-0007R9-KX
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 11:06:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33762)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cZgNy-0007QT-F1
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 11:06:54 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7E092C057FA4
	for <qemu-devel@nongnu.org>; Fri,  3 Feb 2017 16:06:54 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Fri,  3 Feb 2017 16:06:47 +0000
Message-Id: <20170203160651.19917-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH 0/4] virtio-net VMState conversion and new
 VMSTATE macros
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, mst@redhat.com, quintela@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Hi,
  This set converts the virtio-net device to VMState;
it uses a couple of new VMSTATE macros I've added, of which
the VMSTATE_WITH_TMP is a bit unusual, but is intended for dealing
with migration data that doesn't quite look like the data structure
we have in memory.

Dave


Dr. David Alan Gilbert (4):
  migration: Add VMSTATE_UNUSED_VARRAY_UINT32
  migration: Add VMSTATE_WITH_TMP
  tests/migration: Add test for VMSTATE_WITH_TMP
  virtio/migration: Migrate virtio-net to VMState

 hw/net/virtio-net.c            | 316 +++++++++++++++++++++++++++--------------
 include/hw/virtio/virtio-net.h |   4 +-
 include/migration/vmstate.h    |  30 ++++
 migration/vmstate.c            |  40 ++++++
 tests/test-vmstate.c           |  98 ++++++++++++-
 5 files changed, 375 insertions(+), 113 deletions(-)

-- 
2.9.3
