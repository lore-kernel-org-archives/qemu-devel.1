Received: from eggs.gnu.org ([2001:4830:134:3::10]:40154)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1dYNos-0003xW-9e
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 22:37:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1dYNor-0007Zx-An
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 22:37:34 -0400
Received: from mailapp01.imgtec.com ([195.59.15.196]:33411)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1dYNor-0007Zk-5B
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 22:37:33 -0400
From: Yongbok Kim <yongbok.kim@imgtec.com>
Date: Fri, 21 Jul 2017 03:37:15 +0100
Message-ID: <1500604635-15027-15-git-send-email-yongbok.kim@imgtec.com>
In-Reply-To: <1500604635-15027-1-git-send-email-yongbok.kim@imgtec.com>
References: <1500604635-15027-1-git-send-email-yongbok.kim@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PULL 14/14] target/mips: Enable CP0_EBase.WG on
 MIPS64 CPUs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, James Hogan <james.hogan@imgtec.com>, Aurelien Jarno <aurelien@aurel32.net>

From: James Hogan <james.hogan@imgtec.com>

Enable the CP0_EBase.WG (write gate) on the I6400 and MIPS64R2-generic
CPUs. This allows 64-bit guests to run KVM itself, which uses
CP0_EBase.WG to point CP0_EBase at XKPhys.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Yongbok Kim <yongbok.kim@imgtec.com>
Cc: Aurelien Jarno <aurelien@aurel32.net>
Reviewed-by: Yongbok Kim <yongbok.kim@imgtec.com>
Signed-off-by: Yongbok Kim <yongbok.kim@imgtec.com>
---
 target/mips/translate_init.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/mips/translate_init.c b/target/mips/translate_init.c
index 741b390..255d25b 100644
--- a/target/mips/translate_init.c
+++ b/target/mips/translate_init.c
@@ -640,6 +640,7 @@ static const mips_def_t mips_defs[] =
         .SYNCI_Step = 32,
         .CCRes = 2,
         .CP0_Status_rw_bitmask = 0x36FBFFFF,
+        .CP0_EBaseWG_rw_bitmask = (1 << CP0EBase_WG),
         .CP1_fcr0 = (1 << FCR0_F64) | (1 << FCR0_3D) | (1 << FCR0_PS) |
                     (1 << FCR0_L) | (1 << FCR0_W) | (1 << FCR0_D) |
                     (1 << FCR0_S) | (0x00 << FCR0_PRID) | (0x0 << FCR0_REV),
@@ -723,6 +724,7 @@ static const mips_def_t mips_defs[] =
         .CP0_PageGrain = (1 << CP0PG_IEC) | (1 << CP0PG_XIE) |
                          (1U << CP0PG_RIE),
         .CP0_PageGrain_rw_bitmask = (1 << CP0PG_ELPA),
+        .CP0_EBaseWG_rw_bitmask = (1 << CP0EBase_WG),
         .CP1_fcr0 = (1 << FCR0_FREP) | (1 << FCR0_HAS2008) | (1 << FCR0_F64) |
                     (1 << FCR0_L) | (1 << FCR0_W) | (1 << FCR0_D) |
                     (1 << FCR0_S) | (0x03 << FCR0_PRID) | (0x0 << FCR0_REV),
-- 
2.7.4
