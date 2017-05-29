Received: from eggs.gnu.org ([2001:4830:134:3::10]:33655)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dFL90-000883-Nn
	for qemu-devel@nongnu.org; Mon, 29 May 2017 09:55:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dFL8w-0005CB-Qu
	for qemu-devel@nongnu.org; Mon, 29 May 2017 09:55:38 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60341)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1dFL8w-0005Bw-HY
	for qemu-devel@nongnu.org; Mon, 29 May 2017 09:55:34 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v4TDrWM2029658
	for <qemu-devel@nongnu.org>; Mon, 29 May 2017 09:55:32 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2aqfqk80dt-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 29 May 2017 09:55:31 -0400
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Mon, 29 May 2017 14:55:28 +0100
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Mon, 29 May 2017 15:55:13 +0200
Message-Id: <20170529135520.101429-1-pasic@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v2 0/7] migration: s390x css migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cornelia.huck@de.ibm.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org, Halil Pasic <pasic@linux.vnet.ibm.com>

The scope of this patch series is now limited to decoupling channel
subsystem migration from the migration of virtio-ccw proxies.

The vmstatifying of virtio-ccw proxies is now done by another series
currently consisting of a single  patch running under the name 'vmstatify
config migration for virtio-ccw'. Since this series depends on that
patch, I have included it here too (for convenience).

The reorganization was requested by Dave.

v1 --> v2:
* Split out the vmystatify virtio-ccw part, reorganize
* Use WITH_TMP instead of one-shot VMStateInfo's 

Halil Pasic (7):
  s390x: vmstatify config migration for virtio-ccw
  s390x: add helper get_machine_class
  s390x: add css_migration_enabled to machine class
  s390x/css: add missing css state conditionally
  s390x/css: add ORB to SubchDev
  s390x/css: activate ChannelSubSys migration
  s390x/css: use SubchDev.orb

 hw/intc/s390_flic.c                |  48 ++++
 hw/s390x/ccw-device.c              |  10 +
 hw/s390x/ccw-device.h              |   4 +
 hw/s390x/css.c                     | 494 +++++++++++++++++++++++++------------
 hw/s390x/s390-virtio-ccw.c         |  58 +++--
 hw/s390x/virtio-ccw.c              | 155 ++++++------
 include/hw/s390x/css.h             |  17 +-
 include/hw/s390x/s390-virtio-ccw.h |   7 +
 include/hw/s390x/s390_flic.h       |   5 +
 9 files changed, 544 insertions(+), 254 deletions(-)

-- 
2.11.2
