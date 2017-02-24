Received: from eggs.gnu.org ([2001:4830:134:3::10]:48849)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1chC5q-00038H-M8
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 04:23:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1chC5l-0004QE-H5
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 04:23:14 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40387)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1chC5l-0004Py-7V
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 04:23:09 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1O9JCQp118790
	for <qemu-devel@nongnu.org>; Fri, 24 Feb 2017 04:23:07 -0500
Received: from e06smtp06.uk.ibm.com (e06smtp06.uk.ibm.com [195.75.94.102])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28tc28dvpg-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 24 Feb 2017 04:23:07 -0500
Received: from localhost
	by e06smtp06.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Fri, 24 Feb 2017 09:23:04 -0000
From: Cornelia Huck <cornelia.huck@de.ibm.com>
Date: Fri, 24 Feb 2017 10:22:47 +0100
In-Reply-To: <20170224092259.16483-1-cornelia.huck@de.ibm.com>
References: <20170224092259.16483-1-cornelia.huck@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <20170224092259.16483-2-cornelia.huck@de.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 01/13] s390x/s390-virtio: get rid of DPRINTF
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: borntraeger@de.ibm.com, agraf@suse.de, jfrei@linux.vnet.ibm.com, qemu-devel@nongnu.org, Cornelia Huck <cornelia.huck@de.ibm.com>

The DPRINTF approach is likely to introduce bitrot, and the preferred
way for debugging is tracing anyway. Fortunately, there are no users
(left), so nuke it.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Reviewed-by: Halil Pasic <pasic@linux.vnet.ibm.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
 hw/s390x/s390-virtio.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/hw/s390x/s390-virtio.c b/hw/s390x/s390-virtio.c
index 7a3a7fe5fd..9cfb09057e 100644
--- a/hw/s390x/s390-virtio.c
+++ b/hw/s390x/s390-virtio.c
@@ -44,16 +44,6 @@
 #include "hw/s390x/ipl.h"
 #include "cpu.h"
=20
-//#define DEBUG_S390
-
-#ifdef DEBUG_S390
-#define DPRINTF(fmt, ...) \
-    do { fprintf(stderr, fmt, ## __VA_ARGS__); } while (0)
-#else
-#define DPRINTF(fmt, ...) \
-    do { } while (0)
-#endif
-
 #define MAX_BLK_DEVS                    10
=20
 #define S390_TOD_CLOCK_VALUE_MISSING    0x00
--=20
2.11.0
