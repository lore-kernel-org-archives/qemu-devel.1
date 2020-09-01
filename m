Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 671E6C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 18:38:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32F422078B
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 18:38:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="I96HxaCK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32F422078B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42008 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDBBH-0003Xu-5c
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 14:38:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47944)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1kDB7c-0001Xl-TZ
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 14:35:09 -0400
Received: from mout.gmx.net ([212.227.15.15]:49701)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1kDB7a-0008C9-0h
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 14:35:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1598985296;
 bh=3jEXDEPVrlMf+yryMh7E9PXSMoaXapVGrOE9AK5e98c=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=I96HxaCKmkGYMvwrZdbb/wYlBok/BFddpzdUQX97KDRM3ukZzjv64b0lhIE/EEHXq
 4AP4VJPJepKxe2Glv9Jtiujc8X3ws8rZvlzpcENeiTHyRuax2UHBuIlbUSdtjfxsTT
 nMrBT9lZ/SacvH9LbLiZHADF2ickrRKaH9mdYOus=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530.fritz.box ([92.116.187.2]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MqJqD-1kzBSN2qzj-00nMie; Tue, 01
 Sep 2020 20:34:56 +0200
From: Helge Deller <deller@gmx.de>
To: qemu-devel@nongnu.org
Subject: [PATCH 5/7] hw/hppa: Add power button emulation
Date: Tue,  1 Sep 2020 20:34:50 +0200
Message-Id: <20200901183452.24967-6-deller@gmx.de>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200901183452.24967-1-deller@gmx.de>
References: <20200901183452.24967-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:B5y9XQ8mjbD1s0cilvULrDjQJx6YMga2/Tfi7LRGGguFYlxari6
 3JNLt2BANEGPluKu1z35DrKWCiz6AdVH1lzb1NAEYhTuiCpQ7fRPYKGGyvgEy9jNQvFo9aV
 zy2PaJ/LVDZdO/GBf90bvaaVf+Ep8W8OJUA6/Sa7OaLDs55mEB9qwciV/YZ4Nt+klMaq6nE
 UAdpkYHLov+HZwQwsxjxA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:yBtqde0XGU4=:mYFRx8YK++NdON9mLron2l
 C0nJWd9M3IvYAKZuwzJR+afv6Xf3D6EFaCNhaqK/KsVwyWEhmiWrGq9dvkowGeMDl6faEj/GJ
 IfJEurDMis2UcQes0Pwp13ZR9jvj4p3DvwKAanfLh0eBve9CQ3snHmnuQR0j1OabHogbHPyvu
 P84EY9vrhwGc4RYFfxO9sPTQx36n30/58mbEam52zJAslSoiw4duWDGkN71zl4/7WPcld1WbO
 yi3evhkGvcJajR4Ve+STg+RfsqF6I2UrbWx0WY83duPGLtZAr34QqZvQxsG1BNsvUtErJ6MoS
 GG/WUqn/OoeVE/Y5Fxa3LrsLrUw5IHj+fHn4HSV7N5v8Igt2hZ4VZevOr3b2ACLESBGEHqcD6
 cwjqlD1cm1MsznTqft39pMuz4eEM2+9I9Iveq4s9a+9E/0U9yvN3mxn67K7x4oP2UlDMbYqBq
 ER/ZKUv2WTqtgF2u7uNkDRcebYsoFrYvL3dyPzs73XxCMwU4anAkIPbvtD/pgyJMHkCD+q7Gp
 iuq2/lm1bVctGrwnd7nk6zijd/ZpvO1zOKhif3wsn+lh8FFzHal8Z9Mxb1I90Uqh3OiRtO96w
 T/U4YFIYMTCfIcuPzH0RrUjdcdyw6wfqASaApl0A/79bAXCVTE3BeLeiPwUL5jt8U+Kvaln+I
 Zz8ydddzsmUlDeVRYhno8HuW2qckQAkStQbiOOcF14PLObc4kdiSrBBZOl+4ChX+mdGsNCcNn
 kwRlYpwoUqHV2dqW89gMirySzCUyAPol8v6409SXhaeiVlOZbRad1e9SgEwYCPtJlERQIJpPR
 GeKjf9tCXIt9IYzg1oT77QAV7OxDUlSg3dd5Aeu3V3UwS3sy7tqNziGqyajwfVKREgyXd1ZXl
 BJQq8409kdT1LMn0L6lBwwkK8QzNGqfubZ1KbSmN7eRQaPg1RoLzFwpj/WdsAJW7bx/NXLeUN
 oePReg2JW6zOpMzH+70V9p/Gno0tpUBKaaHmWVAGyOLUGL1mvVsyhlNWjiBZUJUU4VM7AvQGh
 QuTa1DVygmFuQAQ4ircfwwg0JBX/q3cdBGoWucMzaP4z4sanp3Jin0x2xcerP6v+D3+QkxKcd
 jfU+StwSgnpEn/IvwfR8NcPq1rbHgsMnYawttyLp/eQNW4kjCs/5HdEOs+3Zlkqj6gFTaYoX7
 4Rhyvt7phG2lIdPPQdrxHu24Qk+4tDYfYbUFf6gEmm+AcT6r9iuqzNidv9wNiGxDp465CSKJZ
 xd/bxVbbvYhC97pPT
Received-SPF: pass client-ip=212.227.15.15; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 14:35:04
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


