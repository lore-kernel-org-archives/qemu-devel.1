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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D4D7C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 13:34:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2A7A206E9
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 13:34:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="OnbmACw7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2A7A206E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51780 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k57wL-0006JT-24
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 09:34:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46170)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1k57nO-0000wM-Gd
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 09:24:58 -0400
Received: from mout.gmx.net ([212.227.15.15]:59549)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1k57nL-0008F6-Mg
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 09:24:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1597065884;
 bh=hyIzH7ivPq7ku2oSW5+xDDT45fhCNW0UoyQcYF08040=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=OnbmACw7qt/FENGMnRshge/ij1uTAUw/wut7pnXlmmkrwmOVIvYY12TZA6uSORcGq
 zPK1+iipYCIk5nvBqMhMNYjvacR5S5jU5KlaWFCGiPznmFQOundr1xdYnrqAOrgfHC
 Et8CulxfOy4c3Q5dKwdFXxEraTGk3KeW8cvZlkGA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530.fritz.box ([92.116.174.37]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MZCfD-1k9EY11s6j-00VCJN; Mon, 10
 Aug 2020 15:24:44 +0200
From: Helge Deller <deller@gmx.de>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL v2 01/12] hw/hppa: Sync hppa_hardware.h file with SeaBIOS
 sources
Date: Mon, 10 Aug 2020 15:24:30 +0200
Message-Id: <20200810132441.16551-2-deller@gmx.de>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200810132441.16551-1-deller@gmx.de>
References: <20200810132441.16551-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HhdYLRzg54XjeLVqbgrQuwHimMv7qHlYwoTC+bdxewuaZUafPlq
 oA6HmDKy4kTRMwHuN8drwWZfP97mHZzrXOGZKepip6uM9btFzVAV/CT7Twe9YokkQZK9eE+
 UdDl9mWykvpBtfSifWz3D3lXWy7L0ULBrUjxxkJEv9VTFNDcfIWnhhBT3cBWpfwxrz0eZVf
 W+EmYPtod8/OCjadtM9TA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:OHRPozBqstM=:mScvOnqvgF/l2T2NlMYQU0
 gSmpnKIGB27N/nnbz1sbhKoXLzy12nyxPw2H0tuc5yJIH6ADlZ55GsqCMtiLQjhf5/Rk+0JT/
 mE7v9YyRtchE8Y0WRBlfy+8SoR/hecjgDoAsIQKgao3e77NL8DHGjDJbGCPu9Wma7XdZf0lE1
 wF+6lGo11IMAwJaFz+ZeuwDWgo7p/TCQmttTj/+kJSpoI+UcSwY5HVT7ujqMONwjwzD8VCooN
 VGtHR0ZzETX2rEy8605nHVjEjdRa+q0UvJkLRU9+6j7c/3JiGrGzRkLqr8kqYusAEyqeyYpzv
 CsMO6mdMnZhmGsscWMMfn5FeTtCCSmRVdSIpjaMRIWzFIsFLkcw2MlvzxmbS2h4+eCXfKpdG3
 fuaO5f4D0F3EJLUK1J2aUtedAYAnbW1ayyZ2kKUB8p24NIjWleqE6MQdWrB7BtORYFcKlwrY2
 wEqT4qn2w6Dw3/N6SKm5mDHXYMuM4qQO9B2vkptRKA+mNRymPqLimet3/Ddl1mvuaxTYjlQr4
 UNMpqSl7WMingu0meN3MTSPoABThHt/VOiZV7LZHpbozyy/l08QyNAofeKExiAOEb0mLeMo7i
 tA8R+kFZ3XOygnDnVl8DTLxoi0WiXeFku+PRKjrrOpze2lIRdc/LuTLpbasfHBdWmXNOIP6Ro
 31RNK25XtRAr5qXpLeNS1VBp/KSZ5cMBbJEtpwjXwZPr5VjKaNgrHXybQM1uLId/BZQrmXYXl
 aFDKxlvH+rvLfxMTTOSMOGkhuX8dx+iw1PbJMoU/aSRzybdOggXfhay5TZZMx5QjpcHdFTbYT
 F4sYHejlTEbt2fsQyhZbMYNTxcdCpbT0nEKtapzOw21pVZXL05+xldQuR1KpM2tYhJFLOiK/q
 qEOfG1DcSevS3pi29MwNUpw7NGjbbUsyQCDZjww1gL/ajMkk2oHAq1fENIzEU88jN8+/umRjO
 JeGofTik/Ti6YlmNDeZoH0TWD4mlXzTGknNFgPUeqdVOh2m96uGy9nhyg83kejxR118HnmyoF
 mXO29Y+nfoo+XdALN9B94ZCng9d3ot22bUPDUiaxlDoz666pb6w027hP3C69wi3T3yzlmssyj
 kzl8/lkq5kLqAtE2umxOMD/IB3aBUrpQeAlEZUlgYaPJohhfQ1E0/tbMuFQTCAKtNA69R07DQ
 lZuybr3v/fH41qeD4e+ZRFJLRdlwgcgIVwMLBl16NjgQ1C7vI44x66UgsgQxGzPGU6egR1WZP
 2hpi9cEvrWLu53EJD
Received-SPF: pass client-ip=212.227.15.15; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/10 09:24:50
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


