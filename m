Return-Path: <SRS0=UEgn=BO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19F46C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 14:09:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E44BA2075F
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 14:09:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="YKRGPJsN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E44BA2075F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58038 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2xdO-0005uC-UF
	for qemu-devel@archiver.kernel.org; Tue, 04 Aug 2020 10:09:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40414)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1k2xV8-0000kR-LP
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 10:01:10 -0400
Received: from mout.gmx.net ([212.227.15.18]:53313)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1k2xV4-00037q-3k
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 10:01:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1596549658;
 bh=hyIzH7ivPq7ku2oSW5+xDDT45fhCNW0UoyQcYF08040=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=YKRGPJsNz7F6kl194vQ80oqEhwa51gKOL7evnLtqJHzb7eaxeGSeXbQ0ICs0xDNlY
 6YxPVv2ECKWVDyx7ylAvsKqRnDKitv7wyNdBrPZDXYDLLOiL/XZpBs1vWAlhmP0QiY
 Gro5YEGHdfVNoreOBrUJFNEMRy7MkHT4A6iQ+iME=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530.fritz.box ([92.116.144.148]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M7sHo-1k7vJ53KK2-004yBb; Tue, 04
 Aug 2020 16:00:57 +0200
From: Helge Deller <deller@gmx.de>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PATCH v3 1/8] hw/hppa: Sync hppa_hardware.h file with SeaBIOS sources
Date: Tue,  4 Aug 2020 16:00:49 +0200
Message-Id: <20200804140056.7690-2-deller@gmx.de>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200804140056.7690-1-deller@gmx.de>
References: <20200804140056.7690-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:atAj0WYmBLr6xhyjBc1PneZv7/PavjtHpVjjvSBq+g8P7a6WDv+
 7JR3txNNpBn0ZhoDMiYyyH+cNT3twRm/WeekWu8fK07VjsRc1+HIGrm0bpufb2xO8OWN6Ng
 iQrIC8Mi1ci7ohc2JFOARmafbJv6r3MbhbDQOXvsa6d56fzncqwqJFSkl8LW0d/MQRg5Rdz
 Yh4E4CqQYK+u9HkuC7W1Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:aWsjEKPgZnY=:7W5QeJyxIDboBVv3VuL9tc
 Y6wQKrZFBq+2jgjCzWlwLHa480437MFHuSF185ZzD5ASMbwmjwqXrjzfLTfZ0fZgNGIrRvW4Z
 oEME2Zkf9q89BHn/RhSorhr+TUXfr3wU7ySKQBulnSR3I+tGObkMK9NkGIZ9ziBHlYWOjMLl5
 GylaZo8oTkRSTI/2AussE/YMaIW1smaJ4TW5InGrIJXOpkbjtt1sHMET4sjtTAa4j+8+YMCRa
 oL5XoWFO2PZ/gBAmKWO/0WNXbFogMFTvtdrLCSuDztux+Z3EJgQvcYOyo2M6c7XpIVP7iHZob
 OfN5LJ5avyu+1I40TQL56/RjMGcGzZl6/tKZzysJxSp51krHKHfPKTEjcnC/DseWiyPU9qGq8
 ewaC4+5bQI7h61S1aYGE0dFPwyhFjz2we3FEc6brHQNHHHPpN68r2ZReM3dhs4wcKUyhoaCKT
 l5o+SW19uR2qhNU1xtgCy6a5luierEKCsnwZ4ukKspCXrWmBDbJ3wn3ANBC7L/jR/WUM9e/da
 0AEGxLzRrQANlgICqkNCB8bI25y2CkcxRNJqWzy6cfm+SrCZU8Qc8cnWz2hF0wyOE67vEvY6R
 s9NKOm/8vqy+PNqTQeDVpIW3nhAfL0I/xyA/O7Ms9t8YH9CURftpiuudvdEAqIrQ9yzSlkvkH
 2gM7xmRT8GzuLv2SfGf0xlpzoH/WvwZh/vJdMop2MsEBid0VaVRWiNck+yMLUyE22OkdIum4n
 t1LYyVamz27xnnmZJ5Af7oWbmZ9UpfdFzWBMfVbW0iwmGkEhQPr/g4nF+8UqqHZ0AQry8JLC3
 Fn50MorrTyrxOR0uL7QqwB/N30vFXMUExRuUj1j/ACSPy3Fl/eA3Od+QvsQjYPNdUkAzZLGX5
 FoJlmc0mC7pSfV3BnicpICEB+O1lsQZEtNA/NgLx3TzespGOfjzJfXqX7a7PKDyTe4P0jAqo3
 UE332STAtLXVHcjsDyEUgOhXbP7Q4iM0i9x06+rrn8LEPMsnoBLqm4/zuWt0T0iOzOQGMPS6R
 u2rW5RqCpoqnautp0FL52tN+N0l1VKI+oMkK1Dwg4/By6l8sD8g6oCHLYBTHcINLznXdY8lhi
 nTEUp/qWiquSP6IPmF3AaedgxmCWmFAk2iyg5Bzqt4ceYriJi/7pdaZj6/i9iG7hTDAbNFz48
 rZVX1NR9vTIJOIJwCfvTo67B89OHXISogMoB2DjplblRG+0ITwTo9Sz0GUc2PWFo7WxMKB+8F
 rGe3dDFoyCF+qoH5g
Received-SPF: pass client-ip=212.227.15.18; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/04 09:08:36
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


