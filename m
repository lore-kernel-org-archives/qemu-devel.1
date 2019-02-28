Received: from eggs.gnu.org ([209.51.188.92]:36345)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gzJYo-0001Ev-G9
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 06:09:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gzJYn-0003dc-CW
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 06:09:06 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:47076)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gzJYn-0003TO-1j
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 06:09:05 -0500
Received: by mail-wr1-x443.google.com with SMTP id i16so21421314wrs.13
	for <qemu-devel@nongnu.org>; Thu, 28 Feb 2019 03:09:00 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	c17sm13153241wrs.17.2019.02.28.03.08.57 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 28 Feb 2019 03:08:58 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 Feb 2019 11:08:24 +0000
Message-Id: <20190228110835.16159-6-peter.maydell@linaro.org>
In-Reply-To: <20190228110835.16159-1-peter.maydell@linaro.org>
References: <20190228110835.16159-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 05/16] hw/misc/iotkit-sysctl: Correct typo in
 INITSVTOR0 register name
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The iotkit-sysctl device has a register it names INITSVRTOR0.
This is actually a typo present in the IoTKit documentation
and also in part of the SSE-200 documentation:  it should be
INITSVTOR0 because it is specifying the initial value of the
Secure VTOR register in the CPU. Correct the typo.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20190219125808.25174-6-peter.maydell@linaro.org
---
 include/hw/misc/iotkit-sysctl.h |  2 +-
 hw/misc/iotkit-sysctl.c         | 16 ++++++++--------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/hw/misc/iotkit-sysctl.h b/include/hw/misc/iotkit-sysctl.h
index e36613cb5ee..17a145517a4 100644
--- a/include/hw/misc/iotkit-sysctl.h
+++ b/include/hw/misc/iotkit-sysctl.h
@@ -41,7 +41,7 @@ typedef struct IoTKitSysCtl {
     uint32_t reset_syndrome;
     uint32_t reset_mask;
     uint32_t gretreg;
-    uint32_t initsvrtor0;
+    uint32_t initsvtor0;
     uint32_t cpuwait;
     uint32_t wicctrl;
 } IoTKitSysCtl;
diff --git a/hw/misc/iotkit-sysctl.c b/hw/misc/iotkit-sysctl.c
index a21d8bd6789..8c85aea9309 100644
--- a/hw/misc/iotkit-sysctl.c
+++ b/hw/misc/iotkit-sysctl.c
@@ -33,7 +33,7 @@ REG32(RESET_MASK, 0x104)
 REG32(SWRESET, 0x108)
     FIELD(SWRESET, SWRESETREQ, 9, 1)
 REG32(GRETREG, 0x10c)
-REG32(INITSVRTOR0, 0x110)
+REG32(INITSVTOR0, 0x110)
 REG32(CPUWAIT, 0x118)
 REG32(BUSWAIT, 0x11c)
 REG32(WICCTRL, 0x120)
@@ -76,8 +76,8 @@ static uint64_t iotkit_sysctl_read(void *opaque, hwaddr offset,
     case A_GRETREG:
         r = s->gretreg;
         break;
-    case A_INITSVRTOR0:
-        r = s->initsvrtor0;
+    case A_INITSVTOR0:
+        r = s->initsvtor0;
         break;
     case A_CPUWAIT:
         r = s->cpuwait;
@@ -145,9 +145,9 @@ static void iotkit_sysctl_write(void *opaque, hwaddr offset,
          */
         s->gretreg = value;
         break;
-    case A_INITSVRTOR0:
-        qemu_log_mask(LOG_UNIMP, "IoTKit SysCtl INITSVRTOR0 unimplemented\n");
-        s->initsvrtor0 = value;
+    case A_INITSVTOR0:
+        qemu_log_mask(LOG_UNIMP, "IoTKit SysCtl INITSVTOR0 unimplemented\n");
+        s->initsvtor0 = value;
         break;
     case A_CPUWAIT:
         qemu_log_mask(LOG_UNIMP, "IoTKit SysCtl CPUWAIT unimplemented\n");
@@ -206,7 +206,7 @@ static void iotkit_sysctl_reset(DeviceState *dev)
     s->reset_syndrome = 1;
     s->reset_mask = 0;
     s->gretreg = 0;
-    s->initsvrtor0 = 0x10000000;
+    s->initsvtor0 = 0x10000000;
     s->cpuwait = 0;
     s->wicctrl = 0;
 }
@@ -230,7 +230,7 @@ static const VMStateDescription iotkit_sysctl_vmstate = {
         VMSTATE_UINT32(reset_syndrome, IoTKitSysCtl),
         VMSTATE_UINT32(reset_mask, IoTKitSysCtl),
         VMSTATE_UINT32(gretreg, IoTKitSysCtl),
-        VMSTATE_UINT32(initsvrtor0, IoTKitSysCtl),
+        VMSTATE_UINT32(initsvtor0, IoTKitSysCtl),
         VMSTATE_UINT32(cpuwait, IoTKitSysCtl),
         VMSTATE_UINT32(wicctrl, IoTKitSysCtl),
         VMSTATE_END_OF_LIST()
-- 
2.20.1
