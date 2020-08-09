Return-Path: <SRS0=L55N=BT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3965C433E0
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Aug 2020 05:27:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92F0720709
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Aug 2020 05:27:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="LyeO4MJQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92F0720709
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47364 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k4drs-0007yX-N4
	for qemu-devel@archiver.kernel.org; Sun, 09 Aug 2020 01:27:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37828)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1k4dor-0006Dp-Bq
 for qemu-devel@nongnu.org; Sun, 09 Aug 2020 01:24:29 -0400
Received: from mout.gmx.net ([212.227.17.22]:60611)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1k4dok-0002ol-It
 for qemu-devel@nongnu.org; Sun, 09 Aug 2020 01:24:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1596950644;
 bh=hyIzH7ivPq7ku2oSW5+xDDT45fhCNW0UoyQcYF08040=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=LyeO4MJQJeB5j41SAicp2pwZ8CbZtZbGVygxu6pPvhXtt3jClp/A/jfQF67+Sy1Dx
 yug7Jo4DDFzE2zCaeOh1M9651HB2vrQYRUqc20Oo+gZqDbuN+6ncrJHWZjvotL3jsI
 xQhPBrzlEwsZtUx6O+r+0uB9X8a1S6uI9+7iCkAo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530.fritz.box ([92.116.185.161]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MbAci-1kbUey0Eoq-00bcRI; Sun, 09
 Aug 2020 07:24:04 +0200
From: Helge Deller <deller@gmx.de>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PATCH v4 01/12] hw/hppa: Sync hppa_hardware.h file with SeaBIOS
 sources
Date: Sun,  9 Aug 2020 07:23:51 +0200
Message-Id: <20200809052402.31641-2-deller@gmx.de>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200809052402.31641-1-deller@gmx.de>
References: <20200809052402.31641-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MXgh10Ep21qC8uA5B+ZZyuOHRfA20fwgd/Q6jvStV1rVV7mblOk
 Qd2wdDMdXQe1DrftiTj2YPKza+nMhZ1PJ5BarAzLX9GRe2TC7FP0xVyWYtFBERewEGPDhEk
 4DDtmIkNnEkyvrV0TcYs7tPAsaXBzO1Uhm9VAE8kqfEdMLP6DDNjrZ4dHfIhgnEfOm1BxOG
 JaotX48SbdVrEr05+TJgQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:c0PnbwAS/MM=:GiF1TfxPa5fIrlm0QXb1lK
 EqdcYGhk6eT6gxCTJMmSTXs8oDTdBg4qaOiZ56VzXW0mYlnUNHWDkbNH1HznJld5XdJrq9c5I
 smVR/zceGW+dD92fNXSd6D1EIoj28UvlSHyeOR3cuKYsL6KXrH8DwZNW7Kxb3x+7CFwgiLyP1
 k7N5mMzlj+j8Fnq4jDByHBf82OT+mDGtINhFeNCI/EA60HQ0gdHphFmtZElYiLfBSfrABJyGQ
 XV8RoNw96cq7ydklxXl1XY4vu/qK0P3L1B6P0z4h1GrGFNWerg2XfuEj0gkoAclXpmnObtpG5
 uzicHAhFhgfkDyc8o+vTweshwcTRkzttInpShK6i69gIfr44WU+NsMUpfFrtOmxiXXplPp1DD
 gSDr4gPA/QxZ41pvxQy9bH5UyuFiVYRljIp6HrkUlA6G1Q+u5AnkFQ8Tg2eSN08Hr5YcXIuUw
 mwIxsy+4PFcy77yWWqxUQGx2bmuvTm7OCFXo+jaeRd9xMSmqpsR2/YMhcovxK98xGCFBc461y
 8pkyN9DZpxSbWWZoheNVsz2QltktY1ioLyt/Pf1k6A+9YEnxXILxbmL0hPRPaTkMuKohlJ0qQ
 6o8fLorfgNz/o3Dua3Hzv95bVPmHwkOguCeqmo/ZXUImcFaGD450lH4rcksHamhCzHpIY6PQx
 YgZ2Zs881/KcxaFEpYje0ymO/z96u0mauOsKrHROVrRIn/xmneYkOW8ms7ugLqB1bee0z6K6W
 lYNd38S8oI2Qm+12dE2PNBYcvR7NUHQHqAFI0+QfLVRUjXAWW2q7C7LSt1gLvLXM2amg3L2KV
 OoHmmANh6sK74fZSYLvyXeRn4+PkXPfR9Hv2Yje7nJEWjYW8TgtKevw9ixwF+JtcPYttn0xiT
 FdolmOSbuevRhRRzUTvQ7o7NHLxo6lFqBBr/O/czuZvAew4OH9GCGnK4sjUOYeaN6cN+VSNzh
 krYr7eSx0ET6jQUvwfavBIRKsLHnVabZAV1WUPbra/DFR03rzDzgvdSPt0JK74MGsfu2sSjnq
 XuKnD+F5NDiZODKQowMSV84enIdlOb6oY+xZgFS3gA3Fqq4Scb/AZXBpT1XV4FFcFvXsDWRMW
 APK0DK1B18kdxGb5cs3u9APTq9hc2OJeg7IdMAeJrGf4K5F5yemzbRrf2UtpmA6o1QpyWMSt6
 /mf2S27t3ZsgZIKNHbqTTB0md62Mrtip1/l98hUPM1xzaOyoFLmZjhPfJExOC50cJh3l+zmWh
 /XhcMkpAQb0zqD76O
Received-SPF: pass client-ip=212.227.17.22; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/09 01:17:21
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
Cc: Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The hppa_hardware.h file is shared with SeaBIOS. Sync it.

Acked-by: Richard Henderson <richard.henderson@linaro.org>
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


