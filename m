Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6814FC433E5
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 19:39:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3639E2065C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 19:39:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="LRphN3K0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3639E2065C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39094 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0VRR-0002nF-B0
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 15:39:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35414)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1k0VOM-0001CX-PL
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 15:36:02 -0400
Received: from mout.gmx.net ([212.227.15.18]:53785)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1k0VOL-0005hr-1K
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 15:36:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1595964954;
 bh=z/QXmt5sYC3nu5t+U0TkgIU+Re5QzTPu4ajnWt9P04Y=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=LRphN3K0VFPG63AxTiWJr+nBFUpZ/BBH4EjZzRbU43SiSivLegxIy4kEb7CI31x+I
 S3ywa+/g5b00RUgG2e6r+4N1YjPTIeCyrVZYa2yMcPUJzmhHNOZiEgRxgl9yVq++qB
 etbAhUSUN+g7u/zqBVxjXLka7rU1rXiQ4D5P++hc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530.fritz.box ([92.116.138.108]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MPGW7-1kPytD1fW1-00Paj6; Tue, 28
 Jul 2020 21:35:54 +0200
From: Helge Deller <deller@gmx.de>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 3/4] hw/hppa: Implement proper SeaBIOS version check
Date: Tue, 28 Jul 2020 21:35:49 +0200
Message-Id: <20200728193550.3578-4-deller@gmx.de>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200728193550.3578-1-deller@gmx.de>
References: <20200728193550.3578-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cN6OCwUI/+CozJUtkCi4RULQX6yV80W8Wdxvg8LHlRKU1gOtdUR
 l8Hfxd09HQQn2Z7iDMFvr7sstRW0PxWwdxmYA05FHuTKZyOj6TzG9v//HZImCXSChbjhjpN
 7ZwhxvJxA40vdue7zCQIgOkFBjh/8O/xMLgMVmIAsJj9zDMkICUEL2SPXwoJfZbrAdHkgyT
 ZljQxoAR8Ua2RErVzZszQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:us4EnQVX0dg=:CuMDfwHYR3yhnJG0kSEaZ6
 /8f0i0Gi5XpKshxfoMOmn/XjL92Ggosh0oOk1xJ3bDBztmnWSmTg/tOKqh9LqUn9nbqGax6LP
 HoC2c7RAhZIKYaFuIr6KCUyvzhSUuQpBT/12SiV8cBCByJ4IMjlnboAhBm+6qb0f8xedGuEKc
 BnF+nEklB+w817LflQ5PFixmDvb3NJSks4Z/3NfUrLWP74yXbkJ4bUOaPCXhYmwTFXalzjQgF
 5INnL1cQkVe1A2Ns1QY36oT+/94oZFuc4dgkboWBV8GRbeoqdm/2S1UlbyRMsosPSd1V3pIeD
 ybMVdszdJvqyjS+0OQWleX9lFlpfig4MjoUpNbF/48d71X33NPNoGDcRGLwS7ldPqMZDptdUj
 0PQgHzz4MQkjthJHSA7jnWPpSOTTUPUkFz2ssmchPZI+ZXxmlFT2JOul18i/5myQBMi9kaCg0
 E0Cv9Fk5fkmVICnvpdBHI0uadGVVrsnLBmhd6Bh9WKxpYwYo501xl03/ucxJ/UhpRHK1P4H9W
 ZHtz5uk5tBhFWvDtjHPtwtgGkBYslOTlFR8nxCMlHGtzn4C9/Htht9HwAcsZDHVMU9mk2O8ZP
 HSTezEpt38LSRdWbvTb9r7F4pN4/kC3rGz7o9UF8B5FdYNLAezkV/+ey7hZFyOtjLUHwUpW4F
 Rkx1wWmLgOLCOGyJnsK/G3n8xPMkaWkCNHGsO4qQEau5BNJYvh9OOgAPX33F2q3y3uF9Cqs/7
 1fYHd0tU0+S1NewlQDpbROp9e1wBebxLg+e+yFhDU4P47przD4Afo+g0evmHqLL+2xyJsXMx2
 uKVnDecdrKQewa7HCGPkEKkV6ICnYXMyA1bFVyrNmFvDKKPeU7jw5g33LBjzbzc3QhU0v5g7b
 nBdvwlsfT9lLwvSNk4Wd/jbS/vGp4pm5YmjKDfj5PmhaIx2/OT+TkzpPH+P8x6HFK4FMZHslB
 IBzU3EN6u8YgXr+d1v2kdNOY15TkDanJY9vRs8CsyuEKFDuWuM/e6njfGGnkiIbYCpkaYHtL1
 EVAquhDYibl9XU1xlrBSfsZyFRNQkj12A14NL2z4+nKgjbpnzq3Gr1yUfuh3lX1ukarhgMwdc
 fM5zzsn84atwDtkQPItzBsyTGUYxkZ71N5cDJ6lCyTbq6/MfrPPF29g4TQK9PIomPYuPE+nYO
 xLPF2qijlqOObFjA5823lipox3k1qHq3aoR96T8aR5tOVSq+TyzNwulmg0jiuzRddKB7IDZpr
 fD+GyIqUCNp65tI6D
Received-SPF: pass client-ip=212.227.15.18; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/28 15:35:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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


