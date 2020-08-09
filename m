Return-Path: <SRS0=L55N=BT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96842C433DF
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Aug 2020 05:27:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6616120709
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Aug 2020 05:27:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="eiDW1yWr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6616120709
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47282 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k4drr-0007vq-GH
	for qemu-devel@archiver.kernel.org; Sun, 09 Aug 2020 01:27:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37812)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1k4doq-0006DQ-DC
 for qemu-devel@nongnu.org; Sun, 09 Aug 2020 01:24:28 -0400
Received: from mout.gmx.net ([212.227.17.20]:35623)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1k4dol-0002on-7u
 for qemu-devel@nongnu.org; Sun, 09 Aug 2020 01:24:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1596950645;
 bh=z/QXmt5sYC3nu5t+U0TkgIU+Re5QzTPu4ajnWt9P04Y=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=eiDW1yWrFMK8mrGo9Stx5xY+TpUxq7uvINKxOAMNQ26w23JQygQ8npOK71OGHpgSm
 wjWhi0spfGrkSlNoWi2HOlS2a/vehSyMRBQNVEcvEGLXMQoxmZJuXK4NpZ62saTe+7
 hiD26qArytBV46h/byHQh0QOgTKE4GJ4DbMITNL4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530.fritz.box ([92.116.185.161]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MdvmY-1kc3gh2IcQ-00b3PG; Sun, 09
 Aug 2020 07:24:05 +0200
From: Helge Deller <deller@gmx.de>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PATCH v4 03/12] hw/hppa: Implement proper SeaBIOS version check
Date: Sun,  9 Aug 2020 07:23:53 +0200
Message-Id: <20200809052402.31641-4-deller@gmx.de>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200809052402.31641-1-deller@gmx.de>
References: <20200809052402.31641-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:inmzKodvaSSyFXUTrViAjZaJJw5e+rR5/aiqtsmbQgZpw6dJWVn
 K7hIDzMh/A/qsQGkE/SfyFZKuHzkockiF4yQe0VaW06+/tI+EofsBLE6I38u2/vLqX1crlP
 fICiKxxM0ix+uJ91AHDAdaewCzjOyTtyvnc09Ej54nGmHvxlfSkzDiiWPbANpXDR1t1ga1r
 Bi6//3JTnxZgD6j/ARh0g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Z+E9xGFEAp0=:oSAz9PW5R5c4rQYxpHVMrl
 CjISY1i2UnMZUWZTWebRts8B3xmnguoDe7EpJtPdhs8OiG3J24byQSPaIMtj+N57hdy45k6rU
 KEHtI15eIRwRtzRcP8aEr9H+9m/YlfoMTNiz13Y/1KBHuY/EtZIVgrgDUxwBrisXGRdTDqGhH
 DFlYrN1RJQOIVNFNqMJ2M9UUnTHKQLs7W1a/Ig0+5L/h3gep3k6wmoTibnHYtTEbxCrbVbm7Z
 wtuFXY12JbKPLfA2+QG5FI8oPsD8nrZs16IVn1AbQM1XdmvAJ59XeVxDE4qrTGVnPFwIWIUGB
 pCjGjVswpZihH2qqfKK/uWizWgudPwgOY7X7TWUUvhQDLvXkQuaDKRxvLTd78Bgol+4Pb3/zQ
 j2UDd8h6d9mwC2GVooxJG1mzNaBwMHtqXTJQWDIOodakdbCqdy40Lv/bSEw5fpNm3Zh875Tr+
 wS8Mi12cjLQX36zI1NFYqW9JnLv8Bgq0J/y8pWl0TZGTEzf4TD2Whc/x5NsbPCZJJgQcG/e/v
 u+r0CgW3ZXLwhkEIQ8GQLbNIYMtvRKMay+Hd02IkXYJmkBr4OxD1KaBznbzOkEIAS+7ANdOM/
 0Whda43IS7XHdjNE6yXBXnMDNf+9IDGAOU0R/HujwhqH0vDs2elao66GNRUYjZX16FjQbmSsy
 /P984pMtDq/PDUUe12xqQurhZ0BT53+x9nQNIK9BSXW84TURs2O2qLyL+XxtnZf5zU5fsSXO8
 cW41Z91pIB4pzGpqRkjfWPyoNXZKdJ0lW8f1+5xurEix4A5TbTTymK/LlLPsPYel+8+0fDyDr
 vDoS2DlAdNGz8sotwWm8fJmlngMNLX2QGYGjZBpRIJk3jAvXdB+aH7PWUSM4HSmlWyDjXbEqC
 1NOgMLshPF06LSdFYUzze/mdOvl3mo34DDU5VTXIpZ+lBzQhEs1KzQS2NxmFeUVnLcXPtdDB2
 EvWzGEBa/GIqQ9NhjN5Sdr2CY9d49qflr1eeoXvQjLIaHa4bRTUUeCj6uPWZ+S5k7L+XkD+l7
 c715yKBr4lkXe+clpEoqEl0FIFLJM0juG2LteVTxSKiZ7krSK6a17XFzXXhUFZvMYRg12Ub4V
 anjtqkCbWX+QQrzYr3MzHEAarie8tkI1cot/L2vBXZwoH9yI0Oi5/T2BmbUB1u+DxM63q8EYB
 NW159XM3+AZzt8CkCd5l27129MQxh5BbECftIm1hmmn1QHLhm+V8JSDr9BtuUWmFGbsZntlX9
 l5Axs3JS5VMl4EPV2
Received-SPF: pass client-ip=212.227.17.20; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/09 01:24:22
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
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


