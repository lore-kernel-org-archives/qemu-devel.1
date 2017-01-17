Received: from eggs.gnu.org ([2001:4830:134:3::10]:48882)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cTPZc-00026r-DX
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 03:57:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cTPZZ-00083A-BY
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 03:57:00 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57508)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1cTPZZ-00082e-1f
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 03:56:57 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v0H8rV1G024237
	for <qemu-devel@nongnu.org>; Tue, 17 Jan 2017 03:56:55 -0500
Received: from e06smtp06.uk.ibm.com (e06smtp06.uk.ibm.com [195.75.94.102])
	by mx0a-001b2d01.pphosted.com with ESMTP id 281880yyw9-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 17 Jan 2017 03:56:55 -0500
Received: from localhost
	by e06smtp06.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Tue, 17 Jan 2017 08:56:53 -0000
From: Cornelia Huck <cornelia.huck@de.ibm.com>
Date: Tue, 17 Jan 2017 09:56:35 +0100
In-Reply-To: <20170117085645.4267-1-cornelia.huck@de.ibm.com>
References: <20170117085645.4267-1-cornelia.huck@de.ibm.com>
Message-Id: <20170117085645.4267-3-cornelia.huck@de.ibm.com>
Subject: [Qemu-devel] [PULL 02/12] s390x: add compat machine for 2.9
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

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 hw/s390x/s390-virtio-ccw.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index dbf4f01165..e9a676797a 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -335,6 +335,9 @@ static const TypeInfo ccw_machine_info = {
     }                                                                         \
     type_init(ccw_machine_register_##suffix)
 
+#define CCW_COMPAT_2_8 \
+        HW_COMPAT_2_8
+
 #define CCW_COMPAT_2_7 \
         HW_COMPAT_2_7
 
@@ -393,14 +396,26 @@ static const TypeInfo ccw_machine_info = {
             .value    = "0",\
         },
 
+static void ccw_machine_2_9_instance_options(MachineState *machine)
+{
+}
+
+static void ccw_machine_2_9_class_options(MachineClass *mc)
+{
+}
+DEFINE_CCW_MACHINE(2_9, "2.9", true);
+
 static void ccw_machine_2_8_instance_options(MachineState *machine)
 {
+    ccw_machine_2_9_instance_options(machine);
 }
 
 static void ccw_machine_2_8_class_options(MachineClass *mc)
 {
+    ccw_machine_2_9_class_options(mc);
+    SET_MACHINE_COMPAT(mc, CCW_COMPAT_2_8);
 }
-DEFINE_CCW_MACHINE(2_8, "2.8", true);
+DEFINE_CCW_MACHINE(2_8, "2.8", false);
 
 static void ccw_machine_2_7_instance_options(MachineState *machine)
 {
-- 
2.11.0
