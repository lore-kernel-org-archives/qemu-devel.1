Received: from eggs.gnu.org ([2001:4830:134:3::10]:45013)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cRFLx-0000Zl-LN
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 04:37:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cRFLs-0000gw-P8
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 04:37:57 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38660
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1cRFLs-0000gm-I0
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 04:37:52 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	v0B9YfVd104660
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 04:37:51 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
	by mx0b-001b2d01.pphosted.com with ESMTP id 27wh7nak7f-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 04:37:51 -0500
Received: from localhost
	by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Wed, 11 Jan 2017 09:37:50 -0000
From: Cornelia Huck <cornelia.huck@de.ibm.com>
Date: Wed, 11 Jan 2017 10:37:32 +0100
In-Reply-To: <20170111093742.21946-1-cornelia.huck@de.ibm.com>
References: <20170111093742.21946-1-cornelia.huck@de.ibm.com>
Message-Id: <20170111093742.21946-2-cornelia.huck@de.ibm.com>
Subject: [Qemu-devel] [PATCH 01/11] s390x: remove double compat statement
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, agraf@suse.de, jfrei@linux.vnet.ibm.com, Cornelia Huck <cornelia.huck@de.ibm.com>

From: Christian Borntraeger <borntraeger@de.ibm.com>

We chain our compat handler via the CCW_COMPAT macros and via the
class_init function. (e.g. ccw_machine_2_7_class_options calls
ccw_machine_2_8_class_options). As all class_init functions in that
chain call SET_MACHINE_COMPAT for their compat settings, and
SET_MACHINE_COMPAT will append there is no need to do that again.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 hw/s390x/s390-virtio-ccw.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index e340eab36b..dbf4f01165 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -339,7 +339,6 @@ static const TypeInfo ccw_machine_info = {
         HW_COMPAT_2_7
 
 #define CCW_COMPAT_2_6 \
-        CCW_COMPAT_2_7 \
         HW_COMPAT_2_6 \
         {\
             .driver   = TYPE_S390_IPL,\
@@ -352,7 +351,6 @@ static const TypeInfo ccw_machine_info = {
         },
 
 #define CCW_COMPAT_2_5 \
-        CCW_COMPAT_2_6 \
         HW_COMPAT_2_5
 
 #define CCW_COMPAT_2_4 \
-- 
2.11.0
