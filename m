Return-Path: <SRS0=xT3E=BL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 336BDC433E0
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Aug 2020 13:17:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA6382087C
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Aug 2020 13:17:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="H8gNSY8S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA6382087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45742 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1rO6-00081A-WF
	for qemu-devel@archiver.kernel.org; Sat, 01 Aug 2020 09:17:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38452)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1k1rKv-00068k-0m
 for qemu-devel@nongnu.org; Sat, 01 Aug 2020 09:14:05 -0400
Received: from mout.gmx.net ([212.227.15.18]:54107)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1k1rKs-0003tm-St
 for qemu-devel@nongnu.org; Sat, 01 Aug 2020 09:14:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1596287638;
 bh=hyIzH7ivPq7ku2oSW5+xDDT45fhCNW0UoyQcYF08040=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=H8gNSY8S61+ZvedpViG4CfgHiwzq5hzuAKYIqV7URGyU4adOy7V555Z/TPQy9b5zr
 VaWyUypFYxPAlbvY4n5eg8Oo2WyYVJUEiMzK3hS4DkqZpuYdgXc6LWehSYa05zGoDA
 gKB9mmQMIGsv20KF67KWOJwgWYIcpfc7gAb3rGXQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530.fritz.box ([92.116.162.176]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MWAOW-1kHiCS27cw-00Xfzk; Sat, 01
 Aug 2020 15:13:58 +0200
From: Helge Deller <deller@gmx.de>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v2 1/4] hw/hppa: Sync hppa_hardware.h file with SeaBIOS sources
Date: Sat,  1 Aug 2020 15:13:54 +0200
Message-Id: <20200801131357.17379-2-deller@gmx.de>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200801131357.17379-1-deller@gmx.de>
References: <20200801131357.17379-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Xetd4WByPRWDI+CrZL0QK05ky5+RL/FaH1bRt71YjGOzFC1p6KZ
 ZN1XLSPOQK+qlNDAicgMFPtSgH9cHnbg3kgY/J1c1QcQY42nE6l41bgzd77bZM3l++Kt8Sf
 YmJi0tTT6yqGpOipbTYi0Zxx+GsqozpyEZRr/AYBlQvzQ4fACkN/tzqduZ3+MReN+2shAgp
 Sbvx951E7D673fMA0X9bg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:akXdquDJD+0=:P2TXstXZYat3YaGJ9BxnOg
 kDCT5w6bzLKHF9X4MTALOnQOUlKbbJ1zG+y3VTe8ujh0+0VkHgQh9xLYARZcUX6Ms+9CbW0Tk
 9jHiHpPQEifWEW2cwEEEa8wX3CkCaQyo3L2SMjJEVG2/wC42sz83GwT5AGZk8Dc8NYvVlVE3h
 9rNu2JuGcLXhIKkvNls+qLO4LeeDpFkmUkuFXuGsPkODk4/VqiLeXu9Rq7E2OyhLBxt5yLOkp
 k/OhqdbBULDY1QULlRR1KbzGTrCSP1otZfZuqjHtX1ktO0u2c5yBNawB5Q4YtHHprybo6Ev1L
 HHCDysDhHzEFP/SjvD/m+98VkAaFnRXQlGFucaFIkKgCpB0ewnLQ2ciFAf/GGP1JcALHYQFm3
 sGXuEnesz1NTIgZahk4EpZFq0ge3+RkFyxRxgoQJAFDOqJGUF3qvp1vy4HSBp9f0jqAe/bJQO
 Tlrdxp6g76iivuyiuoIwEctJlTIFKgruJF95VA8GGf+3o6lN4NFFmqxgD/AMosEu5yQb/3MFb
 pZdncP2BYmBQjpLoa2vJgFR/AUoutx76rzea3/1PVm7T0sx8gLEGBKOsWkA6TH+ahu+r2D6bq
 v/xIzc9dDZKD/y2zhUZNNqt33m9SnPkgoT9S4Z3cEFzbFs6raBedhF3FZgbdXGWqHuLol+A7X
 zsWQH7N7+B5F6p7DotKEvDTmBfc78egzzEkJCfZ7W2dFJdNcgu70CcRkrRunUIDK7S1C5TMe/
 OvsiZUII5SMrDUI4bIyqx+m+w29lMFNIjHRxuwyjnkxxLeD1gn7qhZr6geGIGAgqsXlXKk9Hk
 KcSqqR9ifBBtrmi4Qs1zruIPY5AYM3mJD+UgwydoO4Z1iP+faRNTyo4y4N4CGvcG8erD0m0sz
 4djPBCGtqBlNI0Qr8WJW1537Htw8dP4CCkXLSAncOkLLrgEVyZEyL9nj8VyPNCsCJM6R89+tY
 KspT5dX0gfe8YOYV/0+dn4unFM3KLZS7iDybDLyF3DoUKfs14cyuh39Dq7K5wNkioDXsz6adV
 vbBuahvfsNfNDcfRDms4ODJHEKNNcD16Cs7RllHvneYtUdChzR6lVI5tXczEAplhyQG2l4UUE
 GkzvgBiWsDp+0w5Tv2Rscxo1mlzgKRcF1deGDryAdM85TveksGn0ST1gpuE0t8pDFUBS/Ahm0
 rpkE3aOTJPB5iRbMr5YAnt2gyUc6Qz7ZgXvrXDFeW8phUH2FZdUovkVMqtRcnL6u6csuVZw0Z
 TCJPJ7KsllSmY8F2o
Received-SPF: pass client-ip=212.227.15.18; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/01 09:10:23
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


