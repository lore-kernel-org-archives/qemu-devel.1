Received: from eggs.gnu.org ([2001:4830:134:3::10]:52488)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fDU6P-0005at-LT
	for qemu-devel@nongnu.org; Tue, 01 May 2018 08:09:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fDU6O-0003T7-RO
	for qemu-devel@nongnu.org; Tue, 01 May 2018 08:09:49 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Tue,  1 May 2018 14:08:41 +0200
Message-Id: <1525176522-200354-5-git-send-email-imammedo@redhat.com>
In-Reply-To: <1525176522-200354-1-git-send-email-imammedo@redhat.com>
References: <1525176522-200354-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH v3 4/5] arm: boot: set boot_info starting from
 first_cpu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, eric.auger@redhat.com

even though nothing is currently broken, make sure that boot_info
is set on all CPUs.

Ref:
"Message-ID: <CAFEAcA_NMWuA8WSs3cNeY6xX1kerO_uAcN_3=fK02BEhHJW86g@mail.gmail.com>"

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 hw/arm/boot.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index ad71dd4..144abbd 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -1139,7 +1139,7 @@ void arm_load_kernel(ARMCPU *cpu, struct arm_boot_info *info)
     }
     info->is_linux = is_linux;
 
-    for (cs = CPU(cpu); cs; cs = CPU_NEXT(cs)) {
+    for (cs = first_cpu; cs; cs = CPU_NEXT(cs)) {
         ARM_CPU(cs)->env.boot_info = info;
     }
 
-- 
2.7.4
