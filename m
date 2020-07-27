Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83089C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 21:55:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BD2E206D7
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 21:55:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="TrjPv0/W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BD2E206D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48364 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0B5W-0005Sw-DZ
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 17:55:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45366)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1k0Awy-0000UW-TP
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 17:46:24 -0400
Received: from mout.gmx.net ([212.227.15.18]:51963)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1k0Awx-0002o1-3H
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 17:46:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1595886370;
 bh=ICqOAwvmzBTR55lazeld9xGff0M2fFlPachgThOMd2M=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=TrjPv0/W6ADf7nXEGR3ciCjWVX8C2elGZpwBd6hctLwVPWQ3YtSDbddeBEHu0qx0c
 hW3RtjfpnLou0YMjvnOH89E7HkAMoJv9pfY/ZrDGo/0hTUWpnmcJlVcUNU9CPWFg1T
 Gmk0MaOVPl11Th5zBeViGvVO/76Tuope/9N9QGXU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530.fritz.box ([92.116.179.161]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M1HZo-1jxPnE1zTO-002pZz; Mon, 27
 Jul 2020 23:46:10 +0200
From: Helge Deller <deller@gmx.de>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/4] hw/hppa: Sync hppa_hardware.h file with SeaBIOS sources
Date: Mon, 27 Jul 2020 23:46:05 +0200
Message-Id: <20200727214608.32710-2-deller@gmx.de>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200727214608.32710-1-deller@gmx.de>
References: <20200727214608.32710-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:EXnzO/XO43p3t7jNT089H2EH3CQ4+5GG35M5ztbf6kV5CtPbGzq
 xAi+nw/MYDxKkkDboawUVR5jESvDqQMJiaGyCn75QaHuQrTwz8ngUmKPPdXaJJz8Ktf4426
 ZbnG3n2/IygDUMUHM/2cXahZEyI/D8WbToPUhCUDuponidbUUAsgTydhIevTK3Tv2Byt8FE
 0ijLqB0kVUzx/kBn8etWg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:uI3MTDGJc64=:HsWGklhY0On1QAyDh8QEKx
 PulLn7eq6rPxc14SVJru/gvrkzHQTxnaD385CtfMqiNvkgtL4tuhodlhu7TS9fbbELoQ8jRpU
 lJUMEgRN15OcLWXkMW4A1Lsriw2NzCNlMsSjwWtV6djP62iz1ELXL78wdT/Tw6SQhJ42ee4Ol
 gqJkMBnLtKztzf5ZxyNZ8DpVvrgO4B7uUjv4fjm/izGWmkdfpBHXjEGPn6CN45UPCsn80Rc+A
 wXxFm5qJXgEyZYWBqbjzsmxYm570cSxkLoIK5fIPHu45yL7nGAwJG0aoCfIOPRV6EZO+26eqZ
 T4KlWFlyrXgwMTOGTCVQeGMeb+kHCX2/61iRrpcqOB32k8DqaGnwU18D2lTkP4AndGoNQOVjD
 X8XCJieVzIP5/FhMeYdzYF0+xeUr1tADF2j1HpAb7nParKycGXplIZZFd8YD9hQcLcZspv9a8
 NcqsYbP+5nfbd7J5G/uF9TMbbVaN5LX45aTb42tzsr+2PlqqQQEuCtmife6PaRkCkV3UlKhBe
 XzRl7hU9IWChs6JiIOM4TCS2WXW68KTo3EFB474zf6tP4qxvevkuq5pXxAk+k12e6M+hR9Jer
 bobLLVVPkwg+d/KL2hpM9dw0hT+7cZ3LarZzKHeIj9CbfZJGD8PHU79UtWQVqTo+2l9xJkefw
 A9gsofAWEI+x9X6yODL4DjBLW+8q/7lbhSes4wTGufZV7CtiREe5lMbTdXomjOGsKncD5XvUm
 5i+iwQu+eLSupdbaOK8Z1nDQDWc6k8j/QxdH1ytZ2ULzVYAUMGm1iy/wbPAsi32iRtu3SO6+i
 v5BvcX/ye1guRjfcalubUEZPDVNFEJwkM9QN6ABdH2RuJYvNYoo0nsQOiMdttIU4OrokNsLAH
 mTu27XKXtGeoNpxvMODdF5XlbSJFfYDhMPrdtFQbnl1VL0STnSGffjZG+Y1xnWbut1mUJGw+Z
 nVGAfLagzhw1LunDtKkCpK4bXNRttAykPEyvvGcYWfGu5RWAhsEFXyYlvPidfLI7C3CN+q+nA
 rTiwfqu+aIVeoZqbgKZoZ0tCiIUueSebEmFz4kyt90XgiLjKrrR7UXxFnlgRyNZlDRDaFTZBZ
 CP8s1T1ybIZaspFCOLMrpIhILwApB9TI2ZDw0In1u7P+H4EmW+J8OBq25p2mlpuSbRmTfUS6q
 exikyN23HA/XONxW/a33A+4AZVYRapPteA1n9+663CWrxyznxpdpXPoaugQvhmtWlzzIpVWrN
 SYhbMzXBdTKElteJQ
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

The hppa_hardware.h file is shared with SeaBIOS. Sync it.

Signed-off-by: Helge Deller <deller@gmx.de>
=2D--
 hw/hppa/hppa_hardware.h | 6 ++++++
 hw/hppa/lasi.c          | 2 --
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/hw/hppa/hppa_hardware.h b/hw/hppa/hppa_hardware.h
index 4a2fe2df60..cdb7fa6240 100644
=2D-- a/hw/hppa/hppa_hardware.h
+++ b/hw/hppa/hppa_hardware.h
@@ -17,6 +17,7 @@
 #define LASI_UART_HPA   0xffd05000
 #define LASI_SCSI_HPA   0xffd06000
 #define LASI_LAN_HPA    0xffd07000
+#define LASI_RTC_HPA    0xffd09000
 #define LASI_LPT_HPA    0xffd02000
 #define LASI_AUDIO_HPA  0xffd04000
 #define LASI_PS2KBD_HPA 0xffd08000
@@ -37,10 +38,15 @@
 #define PORT_PCI_CMD    (PCI_HPA + DINO_PCI_ADDR)
 #define PORT_PCI_DATA   (PCI_HPA + DINO_CONFIG_DATA)

+/* QEMU fw_cfg interface port */
+#define QEMU_FW_CFG_IO_BASE     (MEMORY_HPA + 0x80)
+
 #define PORT_SERIAL1    (DINO_UART_HPA + 0x800)
 #define PORT_SERIAL2    (LASI_UART_HPA + 0x800)

 #define HPPA_MAX_CPUS   8       /* max. number of SMP CPUs */
 #define CPU_CLOCK_MHZ   250     /* emulate a 250 MHz CPU */

+#define CPU_HPA_CR_REG  7       /* store CPU HPA in cr7 (SeaBIOS internal=
) */
+
 #endif
diff --git a/hw/hppa/lasi.c b/hw/hppa/lasi.c
index 19974034f3..ffcbb988b8 100644
=2D-- a/hw/hppa/lasi.c
+++ b/hw/hppa/lasi.c
@@ -54,8 +54,6 @@
 #define LASI_CHIP(obj) \
     OBJECT_CHECK(LasiState, (obj), TYPE_LASI_CHIP)

-#define LASI_RTC_HPA    (LASI_HPA + 0x9000)
-
 typedef struct LasiState {
     PCIHostState parent_obj;

=2D-
2.21.3


