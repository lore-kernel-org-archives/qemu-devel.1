Received: from eggs.gnu.org ([2001:4830:134:3::10]:35408)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dGTcf-0001EY-BN
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 13:10:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dGTcd-0006I2-Mp
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 13:10:57 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37150)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1dGTcd-0006F8-8k
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 13:10:55 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1dGTcb-0007Vk-UI
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 18:10:53 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu,  1 Jun 2017 18:10:34 +0100
Message-Id: <1496337035-30213-27-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1496337035-30213-1-git-send-email-peter.maydell@linaro.org>
References: <1496337035-30213-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 26/27] hw/arm/virt-acpi-build: build SLIT when
 needed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Andrew Jones <drjones@redhat.com>

Cc: Shannon Zhao <zhaoshenglong@huawei.com>
Signed-off-by: Andrew Jones <drjones@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Shannon Zhao <shannon.zhao@linaro.org>
Message-id: 20170529173751.3443-2-drjones@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/virt-acpi-build.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index e585206..2079828 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -776,6 +776,10 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
     if (nb_numa_nodes > 0) {
         acpi_add_table(table_offsets, tables_blob);
         build_srat(tables_blob, tables->linker, vms);
+        if (have_numa_distance) {
+            acpi_add_table(table_offsets, tables_blob);
+            build_slit(tables_blob, tables->linker);
+        }
     }
 
     if (its_class_name() && !vmc->no_its) {
-- 
2.7.4
