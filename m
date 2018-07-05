Received: from eggs.gnu.org ([2001:4830:134:3::10]:58082)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdavidsaver@gmail.com>) id 1fb8rn-0004SW-O2
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 14:20:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdavidsaver@gmail.com>) id 1fb8rm-0006Fy-77
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 14:20:31 -0400
Received: from mail-pf0-x22d.google.com ([2607:f8b0:400e:c00::22d]:35334)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mdavidsaver@gmail.com>)
	id 1fb8rm-0006FW-0b
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 14:20:30 -0400
Received: by mail-pf0-x22d.google.com with SMTP id q7-v6so5028706pff.2
	for <qemu-devel@nongnu.org>; Thu, 05 Jul 2018 11:20:29 -0700 (PDT)
From: Michael Davidsaver <mdavidsaver@gmail.com>
Date: Thu,  5 Jul 2018 11:19:56 -0700
Message-Id: <20180705182001.16537-10-mdavidsaver@gmail.com>
In-Reply-To: <20180705182001.16537-1-mdavidsaver@gmail.com>
References: <20180705182001.16537-1-mdavidsaver@gmail.com>
Subject: [Qemu-devel] [PATCH 09/14] timer: rename file ds1338.c -> ds-rtc.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, Antoine Mathys <barsamin@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, qemu-devel@nongnu.org, Michael Davidsaver <mdavidsaver@gmail.com>

Signed-off-by: Michael Davidsaver <mdavidsaver@gmail.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 default-configs/arm-softmmu.mak | 2 +-
 hw/timer/Makefile.objs          | 2 +-
 hw/timer/{ds1338.c => ds-rtc.c} | 0
 3 files changed, 2 insertions(+), 2 deletions(-)
 rename hw/timer/{ds1338.c => ds-rtc.c} (100%)

diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
index 834d45cfaf..84f42b821b 100644
--- a/default-configs/arm-softmmu.mak
+++ b/default-configs/arm-softmmu.mak
@@ -34,7 +34,7 @@ CONFIG_SMC91C111=y
 CONFIG_ALLWINNER_EMAC=y
 CONFIG_IMX_FEC=y
 CONFIG_FTGMAC100=y
-CONFIG_DS1338=y
+CONFIG_DSRTC=y
 CONFIG_PFLASH_CFI01=y
 CONFIG_PFLASH_CFI02=y
 CONFIG_MICRODRIVE=y
diff --git a/hw/timer/Makefile.objs b/hw/timer/Makefile.objs
index e16b2b913c..b3d3b80232 100644
--- a/hw/timer/Makefile.objs
+++ b/hw/timer/Makefile.objs
@@ -3,7 +3,7 @@ common-obj-$(CONFIG_ARM_MPTIMER) += arm_mptimer.o
 common-obj-$(CONFIG_ARM_V7M) += armv7m_systick.o
 common-obj-$(CONFIG_A9_GTIMER) += a9gtimer.o
 common-obj-$(CONFIG_CADENCE) += cadence_ttc.o
-common-obj-$(CONFIG_DS1338) += ds1338.o
+common-obj-$(CONFIG_DSRTC) += ds-rtc.o
 common-obj-$(CONFIG_HPET) += hpet.o
 common-obj-$(CONFIG_I8254) += i8254_common.o i8254.o
 common-obj-$(CONFIG_M41T80) += m41t80.o
diff --git a/hw/timer/ds1338.c b/hw/timer/ds-rtc.c
similarity index 100%
rename from hw/timer/ds1338.c
rename to hw/timer/ds-rtc.c
-- 
2.11.0
