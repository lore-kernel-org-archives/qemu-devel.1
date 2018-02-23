Received: from eggs.gnu.org ([2001:4830:134:3::10]:33172)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1epA3j-0005fw-BV
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 04:54:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1epA3e-0004j1-GB
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 04:54:31 -0500
From: Cornelia Huck <cohuck@redhat.com>
Date: Fri, 23 Feb 2018 10:54:06 +0100
Message-Id: <20180223095406.18251-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PATCH] s390x/sclp: remove duplicate MAX_AVAIL_SLOTS
 define
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>
Cc: Matthew Rosato <mjrosato@linux.vnet.ibm.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>

It's already defined in cpu.h (to the same value) and not used in
the sclp code.

Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 include/hw/s390x/sclp.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/hw/s390x/sclp.h b/include/hw/s390x/sclp.h
index 476cbf78f2..f9db243484 100644
--- a/include/hw/s390x/sclp.h
+++ b/include/hw/s390x/sclp.h
@@ -35,7 +35,6 @@
 #define SCLP_FC_ASSIGN_ATTACH_READ_STOR         0xE00000000000ULL
 #define SCLP_STARTING_SUBINCREMENT_ID           0x10001
 #define SCLP_INCREMENT_UNIT                     0x10000
-#define MAX_AVAIL_SLOTS                         32
 #define MAX_STORAGE_INCREMENTS                  1020
 
 /* CPU hotplug SCLP codes */
-- 
2.13.6
