Received: from eggs.gnu.org ([2001:4830:134:3::10]:39717)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fBeR0-0002l6-I5
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 06:47:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fBeQx-0001YE-P9
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 06:47:28 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:41154)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fBeQx-0001XB-IE
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 06:47:27 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fBeQw-00034x-HM
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 11:47:26 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 26 Apr 2018 11:47:10 +0100
Message-Id: <20180426104715.21702-15-peter.maydell@linaro.org>
In-Reply-To: <20180426104715.21702-1-peter.maydell@linaro.org>
References: <20180426104715.21702-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 14/19] hw/arm/raspi: Don't bother setting
 default_cpu_type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

In commit 210f47840dd62, we changed the bcm2836 SoC object to
always create a CPU of the correct type for that SoC model. This
makes the default_cpu_type settings in the MachineClass structs
for the raspi2 and raspi3 boards redundant. We didn't change
those at the time because it would have meant a temporary
regression in a corner case of error handling if the user
requested a non-existing CPU type. The -cpu parse handling
changes in 2278b93941d42c3 mean that it no longer implicitly
depends on default_cpu_type for this to work, so we can now
delete the redundant default_cpu_type fields.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 20180420155547.9497-1-peter.maydell@linaro.org
---
 hw/arm/raspi.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index 955a7c4e80..66899c28dc 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -226,7 +226,6 @@ static void raspi2_machine_init(MachineClass *mc)
     mc->no_parallel = 1;
     mc->no_floppy = 1;
     mc->no_cdrom = 1;
-    mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-a7");
     mc->max_cpus = BCM283X_NCPUS;
     mc->min_cpus = BCM283X_NCPUS;
     mc->default_cpus = BCM283X_NCPUS;
@@ -249,7 +248,6 @@ static void raspi3_machine_init(MachineClass *mc)
     mc->no_parallel = 1;
     mc->no_floppy = 1;
     mc->no_cdrom = 1;
-    mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-a53");
     mc->max_cpus = BCM283X_NCPUS;
     mc->min_cpus = BCM283X_NCPUS;
     mc->default_cpus = BCM283X_NCPUS;
-- 
2.17.0
