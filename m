Received: from eggs.gnu.org ([2001:4830:134:3::10]:35890)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1cfucE-00084f-Ab
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 15:31:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1cfucB-0004bF-RG
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 15:31:22 -0500
Received: from mailapp01.imgtec.com ([195.59.15.196]:41431)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1cfucB-0004aL-M9
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 15:31:19 -0500
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
	by Forcepoint Email with ESMTPS id 325C5FC8ED46C
	for <qemu-devel@nongnu.org>; Mon, 20 Feb 2017 20:31:12 +0000 (GMT)
From: Yongbok Kim <yongbok.kim@imgtec.com>
Date: Mon, 20 Feb 2017 20:30:56 +0000
Message-ID: <1487622662-62984-3-git-send-email-yongbok.kim@imgtec.com>
In-Reply-To: <1487622662-62984-1-git-send-email-yongbok.kim@imgtec.com>
References: <1487622662-62984-1-git-send-email-yongbok.kim@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 2/8] hw/mips_gictimer: provide API for
 retrieving frequency
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Paul Burton <paul.burton@imgtec.com>

Provide a new function mips_gictimer_get_freq() which returns the
frequency at which a GIC timer will count. This will be useful for
boards which perform setup based upon this frequency.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Reviewed-by: Leon Alrae <leon.alrae@imgtec.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Yongbok Kim <yongbok.kim@imgtec.com>
---
 hw/timer/mips_gictimer.c         | 5 +++++
 include/hw/timer/mips_gictimer.h | 1 +
 2 files changed, 6 insertions(+)

diff --git a/hw/timer/mips_gictimer.c b/hw/timer/mips_gictimer.c
index 3698889..f5c5806 100644
--- a/hw/timer/mips_gictimer.c
+++ b/hw/timer/mips_gictimer.c
@@ -14,6 +14,11 @@
=20
 #define TIMER_PERIOD 10 /* 10 ns period for 100 Mhz frequency */
=20
+uint32_t mips_gictimer_get_freq(MIPSGICTimerState *gic)
+{
+    return NANOSECONDS_PER_SECOND / TIMER_PERIOD;
+}
+
 static void gic_vptimer_update(MIPSGICTimerState *gictimer,
                                    uint32_t vp_index, uint64_t now)
 {
diff --git a/include/hw/timer/mips_gictimer.h b/include/hw/timer/mips_gic=
timer.h
index c8bc5d2..c7ca6c8 100644
--- a/include/hw/timer/mips_gictimer.h
+++ b/include/hw/timer/mips_gictimer.h
@@ -31,6 +31,7 @@ struct MIPSGICTimerState {
     MIPSGICTimerCB *cb;
 };
=20
+uint32_t mips_gictimer_get_freq(MIPSGICTimerState *gic);
 uint32_t mips_gictimer_get_sh_count(MIPSGICTimerState *gic);
 void mips_gictimer_store_sh_count(MIPSGICTimerState *gic, uint64_t count=
);
 uint32_t mips_gictimer_get_vp_compare(MIPSGICTimerState *gictimer,
--=20
2.7.4
