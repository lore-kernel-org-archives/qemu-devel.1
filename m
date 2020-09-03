Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C6C4C43461
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 16:31:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA2AC20578
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 16:31:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="lUNNj04T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA2AC20578
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52746 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDs8k-0001Ba-Op
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 12:31:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35830)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1kDrmh-00082G-Nv
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 12:08:23 -0400
Received: from mout.gmx.net ([212.227.17.21]:39775)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1kDrmf-0007nc-Me
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 12:08:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1599149271;
 bh=mOynSjSqYyzJxCx99uGO5MW62kihSdmX1L+nIliezEc=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=lUNNj04TUF6l2XbdbwfF4FiGkZb+XNak7clVXhAu73W8Fgsr877p6KhD05WFpjtQe
 93FVkhhcvFQ/DU1cvJdLAYpMEU35R+Acm8cQ0YTNcp5YARlfmWh6K1aD0iRnRUbSsM
 4ZiTb1gs3LzUHsF4tanbdu2zEmAHfc4oDL8JNS/g=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530.fritz.box ([92.116.138.28]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MtOKc-1kZWjB1PpO-00uttQ; Thu, 03
 Sep 2020 18:07:51 +0200
From: Helge Deller <deller@gmx.de>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Subject: [PULL 06/10] hw/hppa: Add power button emulation
Date: Thu,  3 Sep 2020 18:07:42 +0200
Message-Id: <20200903160746.27491-7-deller@gmx.de>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200903160746.27491-1-deller@gmx.de>
References: <20200903160746.27491-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nv5iLjs3KY9lZUPNGpBU3c0F8Rg69miZthjT/MzBem7bQh7/X5x
 HDTjwQ83kpuSVpc14mGTg04okSPmNEbqI4JIk3pFpPB0Cn5ET84muTqh223HiX9If3OVPoW
 vJOj/r/XSJHhXMhO7eZNhGI9OZVnB9o/TAA932Gu2Hv3FJHXcZE6T+dJVMJg2PGJYUOYvgV
 AgwrAxb+gTKPI7PipqK6A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:B1kdA+Tdid4=:yGa4B1Hmwh+J+xdnFSuJCQ
 dD9tl9U5YZ4TLKxNFmJ4017u3xYO9Vlb7i2njJkmCU19Q0AsjItDCmpR4bLZ9BZS6exFxaZ9M
 y9t8xW+SpG4gWo20A6LT9zqJaJ+eISbYyX6qpjCZA3u0W836BLMUnlDXMj2Ip8U8iQUKfW9AG
 b3I9rlxCUntUJ2JOCBTqzv2ALX6zWEh61oHBYSGUfFPX1NXoRjmCOR5aDkVvmuglUUR43I41g
 PfjyWtNPYI5kOyJzK1sOGZBHvUSqdSbxaRo4HaLsymO+TAAVPlEYRgjr8PFu2IezGdUoFaHln
 sq/N/QZiQU9OU8R1ozG8ecsohqeeklr82IFspkHgd/rdx62CKv9Snci0hxSvfsQcDbABmwrh4
 6eZSeaB9gfJ3ENzax2bOUAYETd7uANOhGv6VMWwZDCRJ+A4qwWllwHraG7emZorpV7NJWMXYV
 +Bt9guV4GPriLwuXWznZ9Waa9kSKptgXu9dSvqrITptgVP6OgS7YlPgTcoah9U8uBzSMRuY7y
 vLajjXivh4+fEmKLKwWXa9gOlO+X25spQDUCYcKAr898cOQVS7wlxd5LUFIh9AmDNKyDoKSmd
 pxq9ulLJLcf47m/h7ZyYaHXDblSixA/2J0NSPGgpCapGEGeoQQ6j991PoUSIReK8F78dr90+b
 NvhujiqGbPHKXaWErukfhMi08Xc5XqGBt9eYOeZpIDx0zmJ8hVUr1+inr6FO7v9NQ9XFnmVRV
 t928Wex4XsJ78NviEtwTFi5Qg2P9nxgMS6JfW8FxZISBnCEmoLEtNYWNB+BRE8ha3H+p/WTmW
 VaWJcohqNydgortlPrsayiNcGdWCGopBMx36YLoLBr1gKOocWm+0wADRfPcs+Uj0+1+sHeFzG
 pNnx5tJgVgEsVwjEJLHcm21KggtkNoUWAo3P34wkDqrcxuW/DIoptrI4HcU0dKS0ReWA2b22K
 dNfFzOzJLY1wFUi8gL+UY/mbxYKiK+PGwcm+5dD82UIBobYQQvtUp+OEQLgh88nDp0HiOoO9t
 LVtgG4RRISfzpePp/5lZ2SMbQADRe3+LMBQm8qctTf4t4JnbNU8VrCSrOX0EDvLoBLUCb12gu
 E9c3if1bhDrLOgipsm91or4jwedH3rn9WfMbcm7s74WS9ITWMnbI3HUElBamKD/xGQHx4mrx2
 DPgRkJ5jBj3lrWSCnTr2mcGLRqEzFpLkpAkS3PerKB4LjDkNXutzQLzXLcFGP4HKskn47AoK/
 6kZbVsk2CBeqevVTK
Received-SPF: pass client-ip=212.227.17.21; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 12:08:05
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
 Richard Henderson <richard.henderson@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Emulate a power button switch, tell SeaBIOS the address via fw_cfg and
bind the power button to the qemu UI.

Signed-off-by: Helge Deller <deller@gmx.de>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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


