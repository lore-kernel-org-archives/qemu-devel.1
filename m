Received: from eggs.gnu.org ([2001:4830:134:3::10]:42168)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1elZI2-0004fd-9X
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 07:02:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1elZHx-0007sH-Eu
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 07:02:26 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:40356)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1elZHx-0007s2-7v
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 07:02:21 -0500
Received: by mail-wm0-x241.google.com with SMTP id v123so15591780wmd.5
	for <qemu-devel@nongnu.org>; Tue, 13 Feb 2018 04:02:21 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 13 Feb 2018 13:00:47 +0100
Message-Id: <1518523252-49106-44-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1518523252-49106-1-git-send-email-pbonzini@redhat.com>
References: <1518523252-49106-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 43/48] sdhci: add Spec v4.2 register definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20180208164818.7961-31-f4bug@amsat.org>
---
 hw/sd/sdhci-internal.h |  9 +++++++++
 hw/sd/sdhci.c          | 16 +++++++++++++++-
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/hw/sd/sdhci-internal.h b/hw/sd/sdhci-internal.h
index 33e8768..756ef3f 100644
--- a/hw/sd/sdhci-internal.h
+++ b/hw/sd/sdhci-internal.h
@@ -197,6 +197,10 @@ FIELD(SDHC_HOSTCTL2, V18_ENA,          3, 1); /* UHS-I only */
 FIELD(SDHC_HOSTCTL2, DRIVER_STRENGTH,  4, 2); /* UHS-I only */
 FIELD(SDHC_HOSTCTL2, EXECUTE_TUNING,   6, 1); /* UHS-I only */
 FIELD(SDHC_HOSTCTL2, SAMPLING_CLKSEL,  7, 1); /* UHS-I only */
+FIELD(SDHC_HOSTCTL2, UHS_II_ENA,       8, 1); /* since v4 */
+FIELD(SDHC_HOSTCTL2, ADMA2_LENGTH,    10, 1); /* since v4 */
+FIELD(SDHC_HOSTCTL2, CMD23_ENA,       11, 1); /* since v4 */
+FIELD(SDHC_HOSTCTL2, VERSION4,        12, 1); /* since v4 */
 FIELD(SDHC_HOSTCTL2, ASYNC_INT,       14, 1);
 FIELD(SDHC_HOSTCTL2, PRESET_ENA,      15, 1);
 
@@ -215,10 +219,12 @@ FIELD(SDHC_CAPAB, SUSPRESUME,         23, 1);
 FIELD(SDHC_CAPAB, V33,                24, 1);
 FIELD(SDHC_CAPAB, V30,                25, 1);
 FIELD(SDHC_CAPAB, V18,                26, 1);
+FIELD(SDHC_CAPAB, BUS64BIT_V4,        27, 1); /* since v4.10 */
 FIELD(SDHC_CAPAB, BUS64BIT,           28, 1); /* since v2 */
 FIELD(SDHC_CAPAB, ASYNC_INT,          29, 1); /* since v3 */
 FIELD(SDHC_CAPAB, SLOT_TYPE,          30, 2); /* since v3 */
 FIELD(SDHC_CAPAB, BUS_SPEED,          32, 3); /* since v3 */
+FIELD(SDHC_CAPAB, UHS_II,             35, 8); /* since v4.20 */
 FIELD(SDHC_CAPAB, DRIVER_STRENGTH,    36, 3); /* since v3 */
 FIELD(SDHC_CAPAB, DRIVER_TYPE_A,      36, 1); /* since v3 */
 FIELD(SDHC_CAPAB, DRIVER_TYPE_C,      37, 1); /* since v3 */
@@ -227,12 +233,15 @@ FIELD(SDHC_CAPAB, TIMER_RETUNING,     40, 4); /* since v3 */
 FIELD(SDHC_CAPAB, SDR50_TUNING,       45, 1); /* since v3 */
 FIELD(SDHC_CAPAB, RETUNING_MODE,      46, 2); /* since v3 */
 FIELD(SDHC_CAPAB, CLOCK_MULT,         48, 8); /* since v3 */
+FIELD(SDHC_CAPAB, ADMA3,              59, 1); /* since v4.20 */
+FIELD(SDHC_CAPAB, V18_VDD2,           60, 1); /* since v4.20 */
 
 /* HWInit Maximum Current Capabilities Register 0x0 */
 #define SDHC_MAXCURR                   0x48
 FIELD(SDHC_MAXCURR, V33_VDD1,          0, 8);
 FIELD(SDHC_MAXCURR, V30_VDD1,          8, 8);
 FIELD(SDHC_MAXCURR, V18_VDD1,         16, 8);
+FIELD(SDHC_MAXCURR, V18_VDD2,         32, 8); /* since v4.20 */
 
 /* W Force Event Auto CMD12 Error Interrupt Register 0x0000 */
 #define SDHC_FEAER                     0x50
diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 1a6771b..97b4a47 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -91,6 +91,20 @@ static void sdhci_check_capareg(SDHCIState *s, Error **errp)
     bool y;
 
     switch (s->sd_spec_version) {
+    case 4:
+        val = FIELD_EX64(s->capareg, SDHC_CAPAB, BUS64BIT_V4);
+        trace_sdhci_capareg("64-bit system bus (v4)", val);
+        msk = FIELD_DP64(msk, SDHC_CAPAB, BUS64BIT_V4, 0);
+
+        val = FIELD_EX64(s->capareg, SDHC_CAPAB, UHS_II);
+        trace_sdhci_capareg("UHS-II", val);
+        msk = FIELD_DP64(msk, SDHC_CAPAB, UHS_II, 0);
+
+        val = FIELD_EX64(s->capareg, SDHC_CAPAB, ADMA3);
+        trace_sdhci_capareg("ADMA3", val);
+        msk = FIELD_DP64(msk, SDHC_CAPAB, ADMA3, 0);
+
+    /* fallthrough */
     case 3:
         val = FIELD_EX64(s->capareg, SDHC_CAPAB, ASYNC_INT);
         trace_sdhci_capareg("async interrupt", val);
@@ -145,7 +159,7 @@ static void sdhci_check_capareg(SDHCIState *s, Error **errp)
         msk = FIELD_DP64(msk, SDHC_CAPAB, ADMA1, 0);
 
         val = FIELD_EX64(s->capareg, SDHC_CAPAB, BUS64BIT);
-        trace_sdhci_capareg("64-bit system bus", val);
+        trace_sdhci_capareg("64-bit system bus (v3)", val);
         msk = FIELD_DP64(msk, SDHC_CAPAB, BUS64BIT, 0);
 
     /* fallthrough */
-- 
1.8.3.1
