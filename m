Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAE03C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 13:44:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA1A720729
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 13:44:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="N4oQLZt/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA1A720729
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k586P-0004jo-PC
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 09:44:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46376)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1k57ng-00011u-UF
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 09:25:16 -0400
Received: from mout.gmx.net ([212.227.15.19]:44715)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1k57nc-0008Gb-4W
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 09:25:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1597065886;
 bh=z/QXmt5sYC3nu5t+U0TkgIU+Re5QzTPu4ajnWt9P04Y=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=N4oQLZt/vhoyhMwpMVWGnqmRF3ZwJQtChBwdYDYCxVEjaaMgGBEs02xEMs64BMGAd
 G0hxY1U+0WvWe1+8ypKBGv1ShybvS6GqC0+G76Ix3JFZQIZLiHTsvSQAIPDbPPQSGS
 YwTFLo541TVLtab7/nKxh1+cFanAe4K3PDfMb5F0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530.fritz.box ([92.116.174.37]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M5wPh-1k3CuU3opH-007SLr; Mon, 10
 Aug 2020 15:24:45 +0200
From: Helge Deller <deller@gmx.de>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL v2 03/12] hw/hppa: Implement proper SeaBIOS version check
Date: Mon, 10 Aug 2020 15:24:32 +0200
Message-Id: <20200810132441.16551-4-deller@gmx.de>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200810132441.16551-1-deller@gmx.de>
References: <20200810132441.16551-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VlvzUa3IMIF/cSKfilsp9ttjqAOM2m+Q1nHw74Zis6aTeo7LCWb
 YKeONY+pw5x7GGadfwjjiklC8BYOdtPUwKj3I5pdxYpZMmX+5CRjuwKJU95lxKDhSteRA4E
 SqpEK0hWT+Ua57NcDKRzroVd/NqtFgFzYfSH0C5G7gEGSmteUzEYdEAiKg/8L/HKihpTH8q
 K0872EZZfkTK0g7/F1GVQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:bJe8eSS0ZUQ=:9soqTuD8RBSZNv+ETZiP9O
 vuuwjyEGLCd4ag2tvNBc0daHjHdwz0hnyC2SoFrXP3873YvrTSu+pxWyTpcTAVidB+OYL2ruo
 GDkj+//QzSnV4XfHYPvCeYCw0oeJA20GQ9XycD6pmsOF3rxPQmph0JjLMb8aTFnd/vJ1aNF4N
 v92L85VzbV/UTRvycOG/ACKwuRsY+wmJrEJbB65U+dVd0QUZIr8ViB6pJmxcQOA+kZsYfKzWU
 5LvqDAFQ1Nxpp9Kess+zekrDhuiW23DsucEeq3DSjyyMx4TIXTHMXobyeq8LJUxWvTSMf4gQw
 Oapa3jj8BTKNqeR8GRZhhmRd/sV53CfF7u6IEeQVeOOJBh/Hs5B6VQDKa4MXm9LI5/+a+avXT
 R9fZphcmJ6lpSvgO9voJ6FjNZAzSAU4EMKV+z3YpLsapFpg8nVqHdsv2QvbdaOeicAAzrj9rQ
 LsgtRHuYwh51njTxap5w5a4WnnKH4rQNtJct9AG0vJrhnGspkA1yPV2DBolxhX/MX5jTRReFA
 SnTxx9RaCQFT5UG9OXKH7GnurzFBwc/uUh8Fjd1x9DIq2r/9dG8V4+ha57vypIbZ752r8Biwz
 wlD4yHmo4QWFJLTA294kIHoOTvdpGVM7vzwZX5KtqykQtcG4Nhj7CtoeUAxr12T5cid57H961
 5aaNVVKqYKK+qKbhYOKF84taHvTBZ96FdSYpXcUHFR4e2clxhyjJAiryImPH7/FOCDS2d1CIf
 WQN79dA3UqDgAa+Bb33eG60ga76FpQsVTzGrATc+tWf5AnauXVTZJRcyBy7g0vnQ7pOd6x2FS
 s9d2TdfAnLd24NTXXNJH+zt5Ib5Qmi3HvYrYzoH2TZZpXVLRH+HLMYLL+9V6aTWIAIOXGis/0
 WtK6GjfSFvG713FRpmwP+XTZkWwiOlENjoQYLNKH+BqMPPYKA2Bk73hs4k4ju2wgVB/qcOPVP
 QGjeo4Cw2D9HSO+s67V9rZwtIoB8DSVQrlxRfUaJEawxg5MmO+bxbC4wgnjT8KfUmps15vnXY
 vx1g2LuQlXyQzYe5WDIkOH0YIyEWZmoz9526eh4U31xIe4Bb6pEQP/LR3EGmwjOuHOodmDLA+
 MazxLmZ3vtDlg9XVW9q2Ropan8rO/LQphbRc29cwmtRCoDsS3z9sNJQv1EAZ4fIZ7dplO4sq5
 tCC7XhKpEAJV6k1jQDsWdWtf2Wy0nA6d7NmuY7UysEtxbhOEWM4FNWvtw/bsjVIoMeZC/E9xN
 M3OBc/wDXFT1h11DN
Received-SPF: pass client-ip=212.227.15.19; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/10 09:25:05
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


