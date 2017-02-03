Received: from eggs.gnu.org ([2001:4830:134:3::10]:42171)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cZhyp-0006HO-EZ
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 12:49:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cZhyo-0003j9-NE
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 12:49:03 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  3 Feb 2017 17:48:53 +0000
Message-Id: <1486144135-4894-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH v2 0/2] target/arm: Support EL1 AArch32 guest
 under AArch64 EL2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>

Add support for generating the ISS (Instruction Specific Syndrome)
for Data Abort exceptions taken from AArch32. These syndromes are
used by hypervisors for example to trap and emulate memory accesses.

This is a respin of patch 1/3 from the previous series.
Changes v1->v2:
 * other 2 patches are now in QEMU master
 * split out the "use pbit/wbit variables" change into its own patch
 * dropped a few stray blank line changes

Otherwise unchanged.

thanks
-- PMM


Peter Maydell (2):
  target/arm: Abstract out pbit/wbit tests in ARM ldr/str decode
  target/arm: A32, T32: Create Instruction Syndromes for Data Aborts

 target/arm/translate.c | 207 ++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 155 insertions(+), 52 deletions(-)

-- 
2.7.4
