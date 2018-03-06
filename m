Received: from eggs.gnu.org ([2001:4830:134:3::10]:41405)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1etC89-0008Sv-Ha
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 07:55:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1etC88-0004wS-Px
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 07:55:45 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue,  6 Mar 2018 12:55:25 +0000
Message-Id: <20180306125526.27838-6-peter.maydell@linaro.org>
In-Reply-To: <20180306125526.27838-1-peter.maydell@linaro.org>
References: <20180306125526.27838-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH v2 5/6] hw/arm/virt: Add "max" to the list of
 CPU types "virt" supports
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, Igor Mammedov <imammedo@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

Allow the virt board to support '-cpu max' in the same way
it already handles '-cpu host'.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/virt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index dbb3c8036a..cda4b83586 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -169,6 +169,7 @@ static const char *valid_cpus[] = {
     ARM_CPU_TYPE_NAME("cortex-a53"),
     ARM_CPU_TYPE_NAME("cortex-a57"),
     ARM_CPU_TYPE_NAME("host"),
+    ARM_CPU_TYPE_NAME("max"),
 };
 
 static bool cpu_type_valid(const char *cpu)
-- 
2.16.2
