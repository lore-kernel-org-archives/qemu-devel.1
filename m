Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C39EC433E4
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 19:39:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C49B2065C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 19:39:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="dtVcYTL7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C49B2065C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39080 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0VRP-0002mz-9N
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 15:39:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35404)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1k0VOL-0001BF-AI
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 15:36:01 -0400
Received: from mout.gmx.net ([212.227.15.15]:38005)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1k0VOJ-0005hf-Js
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 15:36:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1595964953;
 bh=ICqOAwvmzBTR55lazeld9xGff0M2fFlPachgThOMd2M=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=dtVcYTL7e21Z+ITZZq/dVcJWOoxuLBs2K4SMOZx0HQGM3SUoHwE5kVApIOEFCLZ7q
 UBVjzcWNp/tJcJQ7sh5PMOyZUYKFEso/rpv07Har/yAowUt2ZA+htiv9QWGPgCYzgd
 j8S+V27q3HX7Rb3rXTEGo6kBa5yxrOE8B7DR/gsQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530.fritz.box ([92.116.138.108]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N5mKP-1kpw3P3vPX-017DT0; Tue, 28
 Jul 2020 21:35:52 +0200
From: Helge Deller <deller@gmx.de>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 1/4] hw/hppa: Sync hppa_hardware.h file with SeaBIOS sources
Date: Tue, 28 Jul 2020 21:35:47 +0200
Message-Id: <20200728193550.3578-2-deller@gmx.de>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200728193550.3578-1-deller@gmx.de>
References: <20200728193550.3578-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tfpUg9D50i7xiUD1xUY+JoQ4U6kXiPytBwExu8TVNzQu/TJw10y
 eqqY/kayl3NfGyRIfBUZkQZG4FAYlJYb44tMYDMnDWeWiQXfVHU0EFSqBryOX00PSu42ZDb
 1MFBqcYMb8i+b04fGtHrAQXChTxH9ylvRLz3gSRRaMx3v47wRS1XR3g/l1GJmNeRwi6+Pq0
 ZAs6Qcqkaek+TzBwhpOCg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5F4D+TkDXI4=:uxfMLwlPcMv+JPemdiHyGq
 yTOmLSFUY5bdfw95cH3+pf6cyI2F8VsIGIgBtula+hhA5YSBu0Ku9ue+tkFMrzgOt0+q6HyNQ
 6mwqlRfHqdZ5PR/QA5LWAciVUQ2Q+JgvRTGWnyCOmFBrxN8LCCTCtkiYwbimnPeZv6e6u7HPd
 N7he8H3vhX8hu9qpZGNV5tqy1eG/DrlAdh3MjU203GJsM7hXK4wGzjhHKUDELazwFHWmpZzPt
 Sf3njNHWXzTe+C5WVdUbLnIWLsrJkDDC1yMWnkXso0Ts7s+NlkogIUmWkRX6b7ywsul3CYYSC
 NbW7N/oPZpMZC2V2UIMM/1B2F2BRDy2u0m2Ft0DMvU4zqgJKCWrHW3sj/9rOunvJLucG4Gwsc
 ABs3DFN8C8i+D3qOcGlpLZavUaOYJxa/T12MSchVtxAf42cHwn3OtR4DphoAVyoJ5acJQTGEp
 olCBlHifdRA8ANClyN+U1WsXImMXSpaA/FOCBXTczwlhN+sqGpx6ZwfFUV5VuMYO1PWgduDB0
 Caeng4x+jl+v1jOtJO/5B/O7qNVO2xmNIfd7uwAGvefUiemVVdXDF2TgyiY3ChhTPtHjVvyoK
 /B7uplMNU4p/i1Sw57oIg4dHXHMxQLjr1A50PhEekftaFk8G/3LJslKq3kJ1m1RZaHyBQWxt0
 X5XkIFR7KdQGEHL2jZHqkSkmp8T7ZyXM1eG/G0ej16XEmHTE+A+IitW0zDUQSJab5MbjMvWlD
 KiW/yBIDoCg4H7fr/GWHx2xqWbqCkhfuv1lYJ6hZEfqUy/5UU9A3Rz1bbMiYjUuTYm6Dsc3kD
 A235SQAJHC580vHzW4eMzi00oHFFjMnuB/KeY3zOHhOaBHX7kBSqgyQoRl3UEGfo93vMI+4lj
 lSt5me3x3ZJbY+PzJPaKD/6YjFtr5KalkrpKTNMqlMK1sXRnx2ueyqY9yhNFumpxTmC2WRqf0
 jT1/RKlBUymdxYkoN7ZKmdXRiJNmt3l3fVVQhW90PRfYybgZ+xwwSdVR//8wN0Dy1bij/XdcP
 LyvtzbQTLuR61T9fKR/PvrkyWmmkXpX3m3XMgazbiSsiEQIBkJUbNOf6TJLkTUCo/QA8aKQri
 vErvSNM5zevugsFskVzJ4V2o6/uWbNfLMVG8FXGhSijJA6KQ7I0mQIRBRoWOTbtwdsqniM/uu
 v1U+OagUnOKJVU7hPKBkjwK96T3ge9V+uoHG87X1+Ksigf/LBVMcctXa1Jdy4mMEuMMXMn7AD
 lEjFuMp466rhHBzSs
Received-SPF: pass client-ip=212.227.15.15; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/28 15:35:58
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


