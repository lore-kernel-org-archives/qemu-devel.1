Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3227AC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 21:23:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB71D20737
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 21:23:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="XV5XpKWh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB71D20737
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37018 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kB2tf-0005Xv-VV
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 17:23:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35228)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1kB2k5-0008Ni-Gi
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 17:14:01 -0400
Received: from mout.gmx.net ([212.227.17.21]:45629)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1kB2k1-0002Uu-Ib
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 17:14:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1598476427;
 bh=hyIzH7ivPq7ku2oSW5+xDDT45fhCNW0UoyQcYF08040=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=XV5XpKWhU/DtxL3Fejif6eGr1wE+3fbGw2aEGQYYZRe0HRhPhGO513YELVx5pLitk
 Rxmlu/5X0K2zo8tAiuxROc+99P/rWbt+yz9C209ct9CUbdPlRDzEmC/JHBZHcFvR8S
 o2PAy7mAXeRNDbDuHdQODtKJUSI+wRBUI+/G0/ac=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530.fritz.box ([92.116.186.77]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MBDnC-1kKRTJ0Wdy-00Cf6z; Wed, 26
 Aug 2020 23:13:47 +0200
From: Helge Deller <deller@gmx.de>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL v5 01/12] hw/hppa: Sync hppa_hardware.h file with SeaBIOS
 sources
Date: Wed, 26 Aug 2020 23:13:34 +0200
Message-Id: <20200826211345.14295-2-deller@gmx.de>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200826211345.14295-1-deller@gmx.de>
References: <20200826211345.14295-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:EfP6hbvfVAfqY96KCr0XW5Q2/l1BKDSX9qicixA+RWYKwv2n+M5
 9AIVUOwSK8IUPqPjSpzMrmtQ3nSuoQuV532XM+YX9XPCoSGNG7paLsDdCXPd5m/TRZCXR6F
 8zDm2acAlrcDorD84dsnuqQjLjckU9T/sv7dFU3xARrzU/CUm3GxUiXZmaa02+ncrHqa6of
 F0HVwkPnGhNhria/0GcGg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:FFjgijAQ3Fk=:WLubzhTfzQb+KAp0FzroE+
 6c4/v3paYdfYfIQqqPFvRuy36DVRt9Jn9Cs8qNprU2adRksf8cowLpjpfd64cQC60TCz3MEdo
 RcD+95tLkDt8x+t8YrHAFsjAmCEl8p0akiwQJL/RoXamyDt5obZiRINlOB80sJrnVO7cY6YQm
 ME74jUQSm8FrNrvaMmfC+ULZZOMiNLxMLPg+TwVa0Xk32gSdiQSBmJysSr8xqGQIxiVPdvMxi
 ReCR1xCfFZSDWlPqZOELjycNl/yl29E/tD32tndTgMrIyw3dE9uJ2D5E1PWExMRSb7o8IqVCl
 FJxDJhwbDF/HGKveQK6ppPLKRqmXkTZ+eeC2OxBhVhZSLdHYLKJNRECHoCWvSwlUH5If3QiZL
 av7Ah2Sxgxt58pyEOt7KYNgQpfueuI3KiSUQNv3eaZTdUQEfcOkHucwQPJYdbUtEf3AMZA/1u
 rj6O9uSYtUu7p54ZdOHQFYRHMIQ0W1+LYZU7T09JdGKYTPnSBjFWpO0rlx88xn0G7WY0AZIYe
 KiIUazRKEKB3e67iWAxnG4LcYLzNAh68qQs6u/xzb7r9bFiNqX9832WxCIlqQEKTHVSVi96G5
 BBaupQQGDcs5TPilyWBVl819MSW/hSGnqBFDP+6yyPEsIOlTyBBzzrHHuFPQwS0lBPEw5X9a8
 /1AnEDp8SACztWBZrStKQLSzEOiQhTGowf8HNY5mKrxPAUjda9ReQRTHuYuV2IAPqyWmKtUmd
 cYA1HeYm3KXs7ALMSxmV1Wh7SXHeHCQWgNxJ9+Waa64xfIchefwPgarHtCngIlgAV3M56AV5w
 bAFIZg4ojW0vaIBhfqfkYfdjKkzYlUP4oi/dEl6VBKcfaJFV9GdiObS+KLYFb8K56NXgq0gju
 u7t1OlhJsneU/YQ1jeVI3ke3CGOKi9x+F1KYCBbfylLdh5wzfnfqi8KeTdt+9LbKUbxCyCqxT
 Pa0ftujaM1WgdNcGfZL7cwAdlwaopsRG6R459uqE6CGAL2dCxC9MvXYBsZAHsgiEcGUcuTa+o
 FNc9rO+U86m/c7cT2H2MUVEv1rXfsbz/Q5v1UKn3XjvJMMZqInzt3KZaBsznXWgS+fS7smHm3
 cWZnlUR/QQyCUX1xRpx2+BKP67wNmvaeCVsRtNRmFbNZs5N+C1bNfVljZe++thfSeky26K259
 c01iyco+MGFk9tV/64/Y1u32ni0Qr7tzTyzeFvT6N2UrBoDa2cUpLFiyBaA05ONix36JqidPW
 Ysw1tJd9vaggQ3D1u
Received-SPF: pass client-ip=212.227.17.21; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/26 17:13:54
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


