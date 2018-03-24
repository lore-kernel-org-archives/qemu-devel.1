Received: from eggs.gnu.org ([208.118.235.92]:44854)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdavidsaver@gmail.com>) id 1ezoyB-0003Jo-IP
	for qemu-devel@nongnu.org; Sat, 24 Mar 2018 15:37:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdavidsaver@gmail.com>) id 1ezon4-0005qC-3d
	for qemu-devel@nongnu.org; Sat, 24 Mar 2018 15:26:28 -0400
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:37364)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mdavidsaver@gmail.com>)
	id 1ezon3-0005pT-OM
	for qemu-devel@nongnu.org; Sat, 24 Mar 2018 15:25:22 -0400
Received: by mail-pf0-x242.google.com with SMTP id t16so1760666pfh.4
	for <qemu-devel@nongnu.org>; Sat, 24 Mar 2018 12:25:21 -0700 (PDT)
From: Michael Davidsaver <mdavidsaver@gmail.com>
Date: Sat, 24 Mar 2018 12:24:51 -0700
Message-Id: <20180324192455.12254-11-mdavidsaver@gmail.com>
In-Reply-To: <20180324192455.12254-1-mdavidsaver@gmail.com>
References: <20180324192455.12254-1-mdavidsaver@gmail.com>
Subject: [Qemu-devel] [PATCH 10/14] timer: rename file ds1338.c -> ds-rtc.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>
Cc: Antoine Mathys <barsamin@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, qemu-devel@nongnu.org, Michael Davidsaver <mdavidsaver@gmail.com>

Signed-off-by: Michael Davidsaver <mdavidsaver@gmail.com>
---
 default-configs/arm-softmmu.mak | 2 +-
 hw/timer/Makefile.objs          | 2 +-
 hw/timer/{ds1338.c => ds-rtc.c} | 0
 3 files changed, 2 insertions(+), 2 deletions(-)
 rename hw/timer/{ds1338.c => ds-rtc.c} (100%)

diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
index dd29e741c2..0afffa2a8a 100644
--- a/default-configs/arm-softmmu.mak
+++ b/default-configs/arm-softmmu.mak
@@ -33,7 +33,7 @@ CONFIG_SMC91C111=y
 CONFIG_ALLWINNER_EMAC=y
 CONFIG_IMX_FEC=y
 CONFIG_FTGMAC100=y
-CONFIG_DS1338=y
+CONFIG_DSRTC=y
 CONFIG_PFLASH_CFI01=y
 CONFIG_PFLASH_CFI02=y
 CONFIG_MICRODRIVE=y
diff --git a/hw/timer/Makefile.objs b/hw/timer/Makefile.objs
index 8b27a4b7ef..d4c59df1d1 100644
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
 common-obj-$(CONFIG_M48T59) += m48t59.o
diff --git a/hw/timer/ds1338.c b/hw/timer/ds-rtc.c
similarity index 100%
rename from hw/timer/ds1338.c
rename to hw/timer/ds-rtc.c
-- 
2.11.0
