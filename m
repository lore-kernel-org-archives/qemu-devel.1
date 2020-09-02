Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B0F2C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 19:44:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 091D72083B
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 19:44:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="AdSgpqQN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 091D72083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDYfn-0003HJ-G2
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 15:43:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52054)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1kDYXW-00063P-KP
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 15:35:26 -0400
Received: from mout.gmx.net ([212.227.15.19]:35401)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1kDYXG-0002mi-BO
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 15:35:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1599075301;
 bh=3jEXDEPVrlMf+yryMh7E9PXSMoaXapVGrOE9AK5e98c=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=AdSgpqQN2O2mlGP0SD+V+5KnLp5u8tFHqoKLldzq56MvoQZ7Ru8WB2ZK37MJUD3Nn
 khCm5BkYcm6znF1AO3Jk7rQqApZTefcPrcuYJckZTV8VlXFRCpd0q1vwnBD1/q66Mv
 59MyCU6AxLqcX+x9/AxdPRfIIQKeiiDkx9x67LII=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530.fritz.box ([92.116.155.63]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mzhj9-1kZ3Qq0wC1-00vfEp; Wed, 02
 Sep 2020 21:35:01 +0200
From: Helge Deller <deller@gmx.de>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 6/8] hw/hppa: Add power button emulation
Date: Wed,  2 Sep 2020 21:34:54 +0200
Message-Id: <20200902193456.29844-7-deller@gmx.de>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200902193456.29844-1-deller@gmx.de>
References: <20200902193456.29844-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:eSBC7BE1uOPycPNte5Go1YEXxj9kylGHPVy60O8IYgfyYjjAZdN
 xwl/jx4B28Qv4+u1azESx1OsvtkjXLKvpNXqDNRJk7t4CSdeczHbcH3V3vQsYGCNf0K72/K
 jtAf8XcNSzrlszzQDR+E+lEKv7Y1++dvx62etAygeKInIBPkzjNf8fJ97Y6CaRWiGiPiI1k
 Ycz7UHc/Xfuor4ybxqoFg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:iiJSehEN6vI=:JYXyATntJVzTXhXQ2M/AOh
 9udaotF2buggRT6kO744DF+Ivx+Ak+f7nFXDATCZxTJXumd3d5Wt6eSDGN+KF77WHpFAKXMHl
 V02YQaCyhj6LH5S96nPAlaa+vIIWq47e+2qUE2tCtdHO3Jf5BMwtMuOkoSz2RGF+G5UfBlgXx
 hoharEixCXdFpPXVr2fZUYoAhn/4Q0vS9VlHrdWfN4rh9/xWSXdOG0o2LQdJ4W+ul4mqu+cKz
 kSAczIK3qn7zDXtD4VvdsN5e4op6hFG55pCDC4JOmn2qXY5F8e6W2AyPqB8BldjQhC/f4zoqr
 NaMNDfibdzuHfo4MU/vspC2yO/F+YIu3tBk7AnHxOXD/+QXp33SeUnRvP9y4W3GA5rpBncT68
 bn0PT6zdRA3SaI0+HRlgdIyT6Fun6g6OM4qEVhdeJ4hapNxnGC7F4SliTZ8CeVLPbwdW7OH1w
 1VUrwfOkYFkDaousLKDWwwE29KB52F7+B9WjmH51H/Hsowys3iWAPowbvGWGSomi1DG+tzLuf
 kp9tKP7Fbi5XQShpTIg6qbGVpvLTorzwyeA8npKNT/3x/FKwtSqenSrEzeSN6OAC/GfqPmtbi
 gb/5ETG3q+B4rSoQEbRdbPI0wtrI9YIwnkZHm8uFzc02QaCKso83YBKelCmAj4Svw5fJLsdLn
 BbjQADQGbB9RG8+QgpDvr/vQWcLcxL9n7snimtIhLTJqF/UfVQg9Pna/iaYAaxONpCBw98GM4
 nmHkHA22K130XHV7rday9jKfo6chXTpfw540NSTvvUnkrV5UxWhPzUSohfrp8RmOHXrFB4DXO
 IZdXAiURQBy/jgk+WGk3bIovrn+brmyUxjzfBqCyFlQoxl4JaYobX9e3d7sBRHQEd1Jx92d6b
 chdKE7X/iQ0oB9QiZo9l8GPHpdYO5cV1CVxT5o8wfdLo+K1Gn8T3G+KmoDFqoxA+W6YoJU/p2
 pwm0YtuTR9azhVj+LuJgKrZparQuY/sMbtfAHtMfOif5ESGrGYJZhXYAm7RWEAEuoCwXT2rlI
 eUs1yA2oVISgvy/F+On0svP5s2knRp1e93a7r/CsIF7WCYwGHSyyMqfY/vR8XmZS4OP8d7cRI
 PRWRDL09DD4FN4ccxdB2L6iF2rTbJtPQYE9GT67tYfhklue2r0/DSFAqFHmWO5GFUhNYuCoOl
 KAQoMk5k+2TXdQKOpm8xrgAggkWSndZ3jGecERwFGeiXIVAI1bcXexvVr60aop4YtGIyv0HRh
 NWS3qMWyHLypaTlP/
Received-SPF: pass client-ip=212.227.15.19; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 15:35:08
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
Cc: Helge Deller <deller@gmx.de>, Richard Henderson <rth@twiddle.net>
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


