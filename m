Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99405C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 20:44:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6102920825
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 20:44:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="LDy5JzOv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6102920825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54354 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBOlR-0004Ox-EY
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 16:44:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50676)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1kBOcU-0007o4-4X
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 16:35:38 -0400
Received: from mout.gmx.net ([212.227.15.19]:43437)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1kBOcM-0001VI-Lg
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 16:35:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1598560521;
 bh=3jEXDEPVrlMf+yryMh7E9PXSMoaXapVGrOE9AK5e98c=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=LDy5JzOvucGwrjRtNR4HvZnSX5ESi0xbUn8kujAkKWWukMjyKXjf/oO1CSiaW2WB4
 xabUa2T6YSfEJ++CX3UyHEyExVablyvQ/Bz4q5Ukpw0+gCSi2SqUTKfpWxbRlrAY2e
 7avnED4Oalb/6TWPulwARbHiqPemRlSqGvkNpHZw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530.fritz.box ([92.116.181.35]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MkYXs-1kt0uF1Sog-00m0wI; Thu, 27
 Aug 2020 22:35:21 +0200
From: Helge Deller <deller@gmx.de>
To: qemu-devel@nongnu.org
Subject: [PATCH 5/5] hw/hppa: Add power button emulation
Date: Thu, 27 Aug 2020 22:35:17 +0200
Message-Id: <20200827203517.29404-6-deller@gmx.de>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200827203517.29404-1-deller@gmx.de>
References: <20200827203517.29404-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WriKgPfklKF5QoJ9Zc8gXLoq5DW9+kd++dNGDqspK7CC5aJogHH
 donpicNar1M/thaeKIQmG2Hzpsz17vVE89vUGDIcWOGqLZJ0GdKu8QDy7Zq74+oWPuxK6/q
 qRTII+GtCYiJMNdHu+8uoCEJfShJadZYO1V5igwaGgPOanfov+rS/jC/CuY0Z2+J+VOfbA3
 CxeyZn+wS4Ex9ZAokTePg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mDsiPNS/bU0=:03mcl/g0AdkKBBe6GZRQ79
 PZN8omf1XW4DIPv09/8s+yXGXGcAYr79+qDkU287ZulLGqfPdiPxFWYn+ul/5UYClInii7KNR
 uLbcyToQDH9CfsnoqIbKmhVQ2R4paxRN4tbS3cjJp42h7DLaFcjYpoDSkM6RJp6zxXGg92U9V
 G+fW6yAoAVPLxvgJnygKXNTVioPAK3iXchh1eMN47p/A71/ada02aqmcalWKMsKoon1XJHSWn
 GyQoXF4M879/D9oEY5M2f38nThoHpz8sleGqnB9MHZRdm1ZDwIbJhvnzYIG81xs+m9xWJMCzC
 W9JvU2/2by2R64OpmCN+X6mKNIb5whVWah8UrEwu/kZ2SuQ4q/ZAbcOPrspo0gUlBMKzHzJdQ
 hGw68netaDp0AqU7Wk+UuKIOobU9w8Vjnk+Na9TLXM5tkeGVBlaIGnVPsdL8lr6WnOPo1vD12
 w1SjyKCfqP67THSbVGLBXH3l8Tat2Eoz+DeFVz6y6DCoTAA6GEI10i4kk3fY5Lmj/ArqqqPhS
 6dk72rwKVYrvy24B9tIf067gsZLITUvB2zTdAGMRO7G3ST00xYSjNB0qcuyf5gxFKIvSur2rX
 mjRMd2hyJh0za7jJ7KaBq4cot4Qtskjx2Fh6mHAmFXwVMCNruXOlb0etUjJW2AaneBP58Qm0I
 lcHNU7l3H8vPmBcRtxlacDYcUdMxgSBzubUpJFas/Yx8q+hNXTh43di28/FPP90jk8fxlORRk
 9hU6mwZbFWeudfGlYCyjeJTsXvJ/My6Dcs7UmTvFigkNVqsiNSieYDxDgGeZxn5/GzJlkAIK8
 +NB65KeB2RFhUZkkQGhjwKSjOMv/iQguZh1E2aajj6mZTEUHw8dQvG9AU7vMnLJ2vPAyrDw+Q
 UHLzTaXB34ALm8VfYcK5AN+RhsFX4n++YdeeSqBk4MqdRGNjVQgPKyPG+Ceaj6r7tsRlshVS3
 eh8zInR1iPyz/mTHfUP7dk9SDH9Mtxvf5qOGFHpohlrLuJvYpnpfQjlUHZ0YStgofEgg93r1R
 sDTAHSZRnw56ttzv1u51H+JOlazYG29tXFKQXI7Xqwit7D0PmeHiy6TjXs98njYfmAzn4Dg/w
 /2bkbsiyzZt8eoYs0HH62M9ZChTAE3whzSBhmilR2vKW4d+iOUIKsRMpr0kJUDZiKhRLuOTiy
 ak11Z9ILJZFyNdvc+Co3Xh+OrsuOfd8xrqlh9GwglefUgYOKNz4pnv/PqXuw/GYnfNnCKm8XW
 FtJmDwlymPbmNvKSt
Received-SPF: pass client-ip=212.227.15.19; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/27 16:35:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Emulate a power button switch, tell SeaBIOS the address via fw_cfg and
bind the power button to the qemu UI.

Signed-off-by: Helge Deller <deller@gmx.de>
=2D--
 hw/hppa/machine.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index 2bed49807b..d5164457ee 100644
=2D-- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -12,6 +12,7 @@
 #include "qemu/error-report.h"
 #include "sysemu/reset.h"
 #include "sysemu/sysemu.h"
+#include "sysemu/runstate.h"
 #include "hw/rtc/mc146818rtc.h"
 #include "hw/timer/i8254.h"
 #include "hw/char/serial.h"
@@ -27,6 +28,30 @@

 #define MIN_SEABIOS_HPPA_VERSION 1 /* require at least this fw version */

+#define HPA_POWER_BUTTON (FIRMWARE_END - 0x10)
+
+static void hppa_powerdown_req(Notifier *n, void *opaque)
+{
+    hwaddr soft_power_reg =3D HPA_POWER_BUTTON;
+    uint32_t val;
+
+    val =3D ldl_be_phys(&address_space_memory, soft_power_reg);
+    if ((val >> 8) =3D=3D 0) {
+        /* immediately shut down when under hardware control */
+        qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
+        return;
+    }
+
+    /* clear bit 31 to indicate that the power switch was pressed. */
+    val &=3D ~1;
+    stl_be_phys(&address_space_memory, soft_power_reg, val);
+}
+
+static Notifier hppa_system_powerdown_notifier =3D {
+    .notify =3D hppa_powerdown_req
+};
+
+
 static ISABus *hppa_isa_bus(void)
 {
     ISABus *isa_bus;
@@ -86,6 +111,10 @@ static FWCfgState *create_fw_cfg(MachineState *ms)
     fw_cfg_add_file(fw_cfg, "/etc/cpu/btlb_entries",
                     g_memdup(&val, sizeof(val)), sizeof(val));

+    val =3D cpu_to_le64(HPA_POWER_BUTTON);
+    fw_cfg_add_file(fw_cfg, "/etc/power-button-addr",
+                    g_memdup(&val, sizeof(val)), sizeof(val));
+
     fw_cfg_add_i16(fw_cfg, FW_CFG_BOOT_DEVICE, ms->boot_order[0]);
     qemu_register_boot_set(fw_cfg_boot_set, fw_cfg);

@@ -177,6 +206,9 @@ static void machine_hppa_init(MachineState *machine)
         }
     }

+    /* register power switch emulation */
+    qemu_register_powerdown_notifier(&hppa_system_powerdown_notifier);
+
     /* Load firmware.  Given that this is not "real" firmware,
        but one explicitly written for the emulation, we might as
        well load it directly from an ELF image.  */
=2D-
2.21.3


