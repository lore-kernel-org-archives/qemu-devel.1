Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 458B2C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 21:49:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1262820729
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 21:49:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="RHkPcQvj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1262820729
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41400 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0B0O-00026D-6A
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 17:49:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45334)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1k0Awt-0000RL-DZ
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 17:46:19 -0400
Received: from mout.gmx.net ([212.227.15.18]:53125)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1k0Awr-0002n9-Nn
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 17:46:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1595886372;
 bh=z/QXmt5sYC3nu5t+U0TkgIU+Re5QzTPu4ajnWt9P04Y=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=RHkPcQvjODWQ2cuQciRWJcucv7o4m+MT4JBbmoLuLo6jHBEsM+pJEuLWCm1ijS23P
 8o0lGfpPKCrvlav5lcbQ8rIkOepkr6wtWhhuhhXYuw6Jw8gRL5LjHPV+OeoZJ3kSHA
 DAzBrWZowTgQ83kjEHNJgrKNfLssAy4WKfNXSFd0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530.fritz.box ([92.116.179.161]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mof9P-1kbTha3io5-00p94y; Mon, 27
 Jul 2020 23:46:11 +0200
From: Helge Deller <deller@gmx.de>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/4] hw/hppa: Implement proper SeaBIOS version check
Date: Mon, 27 Jul 2020 23:46:07 +0200
Message-Id: <20200727214608.32710-4-deller@gmx.de>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200727214608.32710-1-deller@gmx.de>
References: <20200727214608.32710-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:O7spXiDwdqgmeBPJbJcI3Vh+xMHeUdPff0YFZ4pMbAIgL7/Vvw7
 eFov5FByuSbj+RbKG0hTaw6Z61Pns5CS2gGgDcztfsllBlSwB+gVRCfEjjSf2tqLZ9XZYF0
 mKPlEdboXChRRvM+qEHjUOSsoiqtNI/Lk3vC1LFH9PeqTw+n8Dwm1xfWAUJ0/hCcjRfR3Xa
 764Nq8oseZ7ahwjXILtdQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:rgnGuZuWpDQ=:rBsluiheM7iFuO97qZBYkM
 WPkfcvjbHW51v/0A+zy56Z6v0xleUjjjfzHorLfmGdNUP9+tFdf2XVaip4OqD47Wth+vZ6fz2
 mQQ4EoZstKLugY2By47Sy7k7gCh2oc0g1CAExOFeUlw3pZswn+7DdgJXVF5gkPD1iJ5jURPHV
 P2NAQkep8CODvSE4WudIL7PZF4PJ0PtDtuLEtnh++QPAgTXnEicjrWN32Fz3a6gYTq/17S0T0
 SljmHXTTC7Um+LeIdnKjlY/JtRYluEYcn6sRaWaoENgrFtLVd1DAzAoxupte9egO34q5vlS1I
 qoKpWd8Nv3Rls3yh9Rs78v3QNaiHteNygKoIgoBg2tastXdkADiTTFcooh6ojkRzvHog2hvuj
 PDh7wiIHhM3yAlfmJ2JFiKLo+8Ph4WIar74Yx/fSDQQDO72STrXtK0QT9bgQZ+AuNGFX/wRXa
 efkt0cOC8PeOaj1WnMN90EzWhmgetfI8kW50F75EAaiDxgGfnYUHJnkoTHlM3rpc+QvYMKL1A
 TUYO8CAiUsu/ieawY0v/YwhFFT0/U1y63jHP6oib69x2CcW5F8VCDm8X1Ai4/RgRDd72UHZr/
 /XKCbqaVIPIGgJ0u2uDflJJ995h5xbiSuh5c7NStVxWKqrVcnIGK4Z+HkY2PNo1hIybDXlJGT
 MYl+xxGROrongfW86eYNKXZ7vmWMOJeFKyC+rOKC+YXcyAawaRy3uj7QiGXq8OiV7JwZ629Au
 J58ki8kvEJA59tFvGNnuSRJJOE9qU8/KayT1Yh0FkpPOqMXGpHsrbumpKktiU4vRgT6crXREw
 heHv/Gm9ak6ZmzuXc3sLV1YnG7Wgi61g6DXjNnMUybm8ikrJOeB4mVEFAlxwb2tzyho1IILdj
 /Wp0jNh8GLy756i2Y9PkOqmGe0Ko6isRUHRaBBkrsjRiwVF/BEX7+yntT/i5M2lqa64CjZLbJ
 iByn+NGlVSRQ2AuHE7dLJC5ktisDdbHgeTyXiBEMr8OSiuH/CaYXGleTnUB2fvesVK+UVaJ5Y
 ysPLbZEPMeVV3h63GjTIiKw/AunHIII7+vFcQqxBbmQvoRx4wCae9ml3Ub1vQVdczuhVtICmi
 8UHoQU61xzsz5GDluvWiOl4QEJkUT8jfpr9RH0/L+Anth/NFcjKyTB1xZHIlkq07PeSuAtipI
 ScDaWv/PivRhBPP4O/FjHtfzitWfeAsFJp75TL5u3Fjgi6Y2TErdnBYPE7jLYGd/gGjaMHTDy
 pJ5rtAjHWCcsP/1HO
Received-SPF: pass client-ip=212.227.15.18; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 17:46:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

It's important that the SeaBIOS hppa firmware is at least at a minimal
level to ensure proper interaction between qemu and firmware.

Implement a proper firmware version check by telling SeaBIOS via the
fw_cfg interface which minimal SeaBIOS version is required by this
running qemu instance. If the firmware detects that it's too old, it
will stop.

Signed-off-by: Helge Deller <deller@gmx.de>
=2D--
 hw/hppa/machine.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index 49155537cd..90aeefe2a4 100644
=2D-- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -25,6 +25,8 @@

 #define MAX_IDE_BUS 2

+#define MIN_SEABIOS_HPPA_VERSION 1 /* require at least this fw version */
+
 static ISABus *hppa_isa_bus(void)
 {
     ISABus *isa_bus;
@@ -56,6 +58,23 @@ static uint64_t cpu_hppa_to_phys(void *opaque, uint64_t=
 addr)
 static HPPACPU *cpu[HPPA_MAX_CPUS];
 static uint64_t firmware_entry;

+static FWCfgState *create_fw_cfg(MachineState *ms)
+{
+    FWCfgState *fw_cfg;
+    uint64_t val;
+
+    fw_cfg =3D fw_cfg_init_mem(QEMU_FW_CFG_IO_BASE, QEMU_FW_CFG_IO_BASE +=
 4);
+    fw_cfg_add_i16(fw_cfg, FW_CFG_NB_CPUS, ms->smp.cpus);
+    fw_cfg_add_i16(fw_cfg, FW_CFG_MAX_CPUS, HPPA_MAX_CPUS);
+    fw_cfg_add_i64(fw_cfg, FW_CFG_RAM_SIZE, ram_size);
+
+    val =3D cpu_to_le64(MIN_SEABIOS_HPPA_VERSION);
+    fw_cfg_add_file(fw_cfg, "/etc/firmware-min-version",
+                    g_memdup(&val, sizeof(val)), sizeof(val));
+
+    return fw_cfg;
+}
+
 static void machine_hppa_init(MachineState *machine)
 {
     const char *kernel_filename =3D machine->kernel_filename;
@@ -118,6 +137,9 @@ static void machine_hppa_init(MachineState *machine)
                        115200, serial_hd(0), DEVICE_BIG_ENDIAN);
     }

+    /* fw_cfg configuration interface */
+    create_fw_cfg(machine);
+
     /* SCSI disk setup. */
     dev =3D DEVICE(pci_create_simple(pci_bus, -1, "lsi53c895a"));
     lsi53c8xx_handle_legacy_cmdline(dev);
=2D-
2.21.3


