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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EFB1C43461
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 16:20:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA33D20775
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 16:20:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="asvRhaC4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA33D20775
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57488 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDryi-0007pW-RR
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 12:20:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35782)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1kDrmb-0007xK-BH
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 12:08:17 -0400
Received: from mout.gmx.net ([212.227.17.20]:45641)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1kDrmZ-0007ll-B8
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 12:08:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1599149271;
 bh=nf0r8cvtLe/7MCSBITjraeCAspAdIM54EcNA2Dpw6j8=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=asvRhaC4dfb8IP+NpBjzf+zXghpD+vfivG7C9QyOS2N5oE7JVyQssUgftOwr0MXU0
 dhlQLiwq+RXS6KBG4gqD2woIfwIyqBO7xVk8hWmXhDiWeXUFnnMC/h3xjrC1a25rVr
 X8r3Msw/9WGYlHRX2I4FMDa4uedF37hJAftNXYOY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530.fritz.box ([92.116.138.28]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M5QFB-1kEgio0dl7-001Pn9; Thu, 03
 Sep 2020 18:07:51 +0200
From: Helge Deller <deller@gmx.de>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Subject: [PULL 05/10] hw/hppa: Tell SeaBIOS port address of fw_cfg
Date: Thu,  3 Sep 2020 18:07:41 +0200
Message-Id: <20200903160746.27491-6-deller@gmx.de>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200903160746.27491-1-deller@gmx.de>
References: <20200903160746.27491-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:O08fKGpw0anhC6Y26cFP6I5rc67mPqFyu2uqc1RRt36I6EuT8lM
 Uvi5xfVlMcDuF8aDMsfw/t18P6ZKugecDik9tEctPT4cdJ3NeFQPRJTn4uqpe69IGbT+big
 yA+VdFNgUblGPiTZDz50IXyRhnTHTRjxMEBhW2ktcZaKhx14NkgdDZgLaieyszxzhELKDNN
 AlEDje4epcwJBethnDJPQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:CJrCbTkKGUs=:PxPI2eV1aBbLqhkdYGnlDw
 zM1NfLdYQKSmmNLDeE6YVkekT+pClKrG8nLB0g6O7O4YoNUJ9uEqHF8QVLelXgta0iajaZgAw
 DLJOOBFO3B7dHui6Ky3+MV+/015BKbeoyyd54gzGe1rvRAbKLZpX4jpBvDTlfnyqmzvq2P2NT
 SbsjvwKtBd1VczFdbi0E1kzuTLNjBro5SDctpDfJA2buWxlzDGAv/I+2tqMz2DPcC1wPKX9lw
 S/RVJ8BYvrt2qK8Jgmn/FBJ1IdBA9m4bwdP4KcPdIzPnvyG/4P8PV4HYt3VEhkk3DPXEI1Xyq
 OboV+qUJsPDVuBsNtc2ZjOv7Kx3vPkJRsvYiKVId/QPwb5clnMbOMyPCfdcdmty7FKfvBkgBQ
 A8z//CaHsQ8zcXzItxLYlH+ajpIzYZ7UYkptnzV8eKUFFgJ2EcRNgbeyA5n8MZs5uK1F/Q+Tw
 OsFK7nHa0U7XORj28Bk/STj1eHkYk5IQly3ZTvStTwtbmbPkOb0OL0N0W+pFK0Bg+eWqlz0yD
 TncPPVD3+TT7+VbWDmTZ0x4iFue4QtCjly+jxwLw9TuwY4R6xoIibVseQZyXeRLAYFWJBt+or
 SeSVIrwv53dJc7BY6kuZ5w9sB7ELKiHaJqrv+NJ6w6ib590trTkSbKCglL7X4W8VmwCs2KCKj
 iGkHhePiJk+kG8a5e4yv/4HiBXmSukYtS+/vnt3Cy33UNVc0ePfHPBXxNyjFSDGJwPhnTpwBL
 NsLCICugqtygLpiR79n7kAK0+Q+xu/2/D7ljuWl4PMRELNVMuP45HFPu0RX+OlV63LMjsY9fz
 iv0XGnzV+DeK494aFfFTP63kmqNZY7Y/54lOGLbipKKIHhJV0jros0m3bbCT3G616nUG+cXyZ
 uPXJn85Y8HLNGFdo6FuYjOJF2nVGArEsHZIhLPx9n/XWJhzmq42CIPlhJ/stgFxMcYi41hhBa
 PDESKvCRE1ilc+le7V4+tp4261Sqooe1EuOxhW7VB43j/OJ7WgMOfsR2KYnNwbXGN3QmcwefR
 8SY1I+UpVPRoxIgNyd55QuaTw+sEfFaZA6wZO6nhxa+j9mJ5uO2waiXb3AVrYz/eP5zSOXug7
 lpmqMSiBoOXxtahNdyEOaTFSN5QbGe+TcqyL3JT8yN1czdzkyJlV2Azo9uotBPUq+8XwJabmG
 SRa4agf7r9EGAxxgBSu0HrKelgrBaDlIlAike/PUrV8sRuoEv0rkN+MjXKj2YahNAHLoTyQNY
 +Venl+Idn5vpLC3cz
Received-SPF: pass client-ip=212.227.17.20; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 12:08:01
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
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

Change QEMU_FW_CFG_IO_BASE to shorter variant FW_CFG_IO_BASE and hand
over the actual port address in %r19 to SeaBIOS.

Signed-off-by: Helge Deller <deller@gmx.de>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
=2D--
 hw/hppa/hppa_hardware.h | 2 +-
 hw/hppa/machine.c       | 7 ++++++-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/hw/hppa/hppa_hardware.h b/hw/hppa/hppa_hardware.h
index b2fbbc2eec..bc258895c9 100644
=2D-- a/hw/hppa/hppa_hardware.h
+++ b/hw/hppa/hppa_hardware.h
@@ -38,7 +38,7 @@
 #define PORT_PCI_CMD    (PCI_HPA + DINO_PCI_ADDR)
 #define PORT_PCI_DATA   (PCI_HPA + DINO_CONFIG_DATA)

-#define QEMU_FW_CFG_IO_BASE     0xfffa0000
+#define FW_CFG_IO_BASE  0xfffa0000

 #define PORT_SERIAL1    (DINO_UART_HPA + 0x800)
 #define PORT_SERIAL2    (LASI_UART_HPA + 0x800)
diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index 4b35afc9d5..2bed49807b 100644
=2D-- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -69,7 +69,7 @@ static FWCfgState *create_fw_cfg(MachineState *ms)
     FWCfgState *fw_cfg;
     uint64_t val;

-    fw_cfg =3D fw_cfg_init_mem(QEMU_FW_CFG_IO_BASE, QEMU_FW_CFG_IO_BASE +=
 4);
+    fw_cfg =3D fw_cfg_init_mem(FW_CFG_IO_BASE, FW_CFG_IO_BASE + 4);
     fw_cfg_add_i16(fw_cfg, FW_CFG_NB_CPUS, ms->smp.cpus);
     fw_cfg_add_i16(fw_cfg, FW_CFG_MAX_CPUS, HPPA_MAX_CPUS);
     fw_cfg_add_i64(fw_cfg, FW_CFG_RAM_SIZE, ram_size);
@@ -290,6 +290,9 @@ static void machine_hppa_init(MachineState *machine)

     /* tell firmware how many SMP CPUs to present in inventory table */
     cpu[0]->env.gr[21] =3D smp_cpus;
+
+    /* tell firmware fw_cfg port */
+    cpu[0]->env.gr[19] =3D FW_CFG_IO_BASE;
 }

 static void hppa_machine_reset(MachineState *ms)
@@ -317,6 +320,8 @@ static void hppa_machine_reset(MachineState *ms)
     cpu[0]->env.gr[24] =3D 'c';
     /* gr22/gr23 unused, no initrd while reboot. */
     cpu[0]->env.gr[21] =3D smp_cpus;
+    /* tell firmware fw_cfg port */
+    cpu[0]->env.gr[19] =3D FW_CFG_IO_BASE;
 }


=2D-
2.21.3


