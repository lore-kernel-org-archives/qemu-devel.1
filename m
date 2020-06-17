Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC039C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 08:29:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A6AB2085B
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 08:29:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bt.com header.i=@bt.com header.b="CMwMwHEQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A6AB2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bt.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55306 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlTRV-0002cr-KV
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 04:29:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54568)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasper.lowell@bt.com>)
 id 1jlTNM-0005CQ-7W
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 04:24:52 -0400
Received: from smtpe1.intersmtp.com ([62.239.224.234]:29288)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasper.lowell@bt.com>)
 id 1jlTNJ-0003xH-Ul
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 04:24:51 -0400
Received: from tpw09926dag12h.domain1.systemhost.net (10.9.212.36) by
 RDW083A012ED68.bt.com (10.187.98.38) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Wed, 17 Jun 2020 09:21:24 +0100
Received: from tpw09926dag13h.domain1.systemhost.net (10.9.212.37) by
 tpw09926dag12h.domain1.systemhost.net (10.9.212.36) with Microsoft SMTP
 Server (TLS) id 15.0.1395.4; Wed, 17 Jun 2020 09:24:46 +0100
Received: from RDW083A009ED65.bt.com (10.187.98.35) by
 tpw09926dag13h.domain1.systemhost.net (10.9.212.37) with Microsoft SMTP
 Server (TLS) id 15.0.1395.4 via Frontend Transport; Wed, 17 Jun 2020 09:24:46
 +0100
Received: from GBR01-CWL-obe.outbound.protection.outlook.com (104.47.20.57) by
 smtpe1.intersmtp.com (62.239.224.236) with Microsoft SMTP Server
 (TLS) id 14.3.439.0; Wed, 17 Jun 2020 09:17:24 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QHggerDWWF9H15I81F+k9ybIzL1qyit29wxXb4qgsm97ah5sg2mpR1ziHEGHHInhnBIcYDOye7VSFUzX5hcQ3HHbdpzVqGDrckZU/syrzG7GtHTSvt7BAHOoGpv3IHv3xlc636zv0gYAsq6JzVdBZO9ND7o8OSnhGVr62cm3Xns6lmPBFaz2lo6JdxWlMaBtRh40M5M2Kwtff/hX8ljnC/2Puxw9+a+HFhyg0D1L+qNpwXIsoSSwtfE7V+TfJEfsf5Nx4gJsRqAOGNPSfWU/BiaG4xh0E1SahH6T+zqrpgY1oSGOFRuWhcLfL0Jo2yiOeEVkbdxz076WMPQghXvv0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U/Jyu022VZxox9d+ww4jvFaNKATa7tyUc1Lp3L6qTYw=;
 b=L3v0VmWBp2mVOpKSoWWuNoWVEz+Rl3PbZ3eG6MYcYVhG21rLOKckrNZgbb2avk7sAUHDOkRNFkIDG4NSpAOFKqwDf4GNzxO7J47M1hIpZjSgvcjop6dqhZe4X4uybc4/7zIj/BSlzC3mfhK9M23kqXwAmndWZ35MN+FNEQmDCwjztXVpEnJrirFKOVFf+SuNed+7ok7MAks69mpjHgInhpTEVJDHYEhG2ggFlQCibmCYKdaxcEMUKnNLzqGx+NP24N6T6ZKRVSJtaR9ImqHaSxJlaEuQOQZPhmhhV3RR4VBv8Of4ogNMrBs4/soyDO2FcC5IVUeO6jvwsqR7Cdm9UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bt.com; dmarc=pass action=none header.from=bt.com; dkim=pass
 header.d=bt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bt.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U/Jyu022VZxox9d+ww4jvFaNKATa7tyUc1Lp3L6qTYw=;
 b=CMwMwHEQJoIVvgVTebpc1JZ9C8cWPWVk+bjVBKu24kuV1Q3pfvekaS4W2ddHKiI6bkKZXVcvCM29vx/nPs6JD6+Mrj38v3d7oMCaZay8/dPeNTZBLzqKhZrt1SwM6uTMSQm3qa4qHGETci2GUeO+0+7Zr/dh9dKgMpxTRbg46FM=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bt.com;
Received: from CWXP123MB1958.GBRP123.PROD.OUTLOOK.COM (2603:10a6:401:7b::18)
 by CWXP123MB3255.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:43::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Wed, 17 Jun
 2020 08:24:38 +0000
Received: from CWXP123MB1958.GBRP123.PROD.OUTLOOK.COM
 ([fe80::e098:8c50:5b1e:6a1b]) by CWXP123MB1958.GBRP123.PROD.OUTLOOK.COM
 ([fe80::e098:8c50:5b1e:6a1b%7]) with mapi id 15.20.3109.021; Wed, 17 Jun 2020
 08:24:38 +0000
From: Jasper Lowell <jasper.lowell@bt.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH 4/8] hw/char/escc2: Add clock generation
Date: Wed, 17 Jun 2020 18:23:58 +1000
Message-ID: <20200617082402.242631-5-jasper.lowell@bt.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200617082402.242631-1-jasper.lowell@bt.com>
References: <20200617082402.242631-1-jasper.lowell@bt.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0051.apcprd02.prod.outlook.com
 (2603:1096:4:54::15) To CWXP123MB1958.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:401:7b::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (185.128.24.45) by
 SG2PR02CA0051.apcprd02.prod.outlook.com (2603:1096:4:54::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3109.21 via Frontend Transport; Wed, 17 Jun 2020 08:24:34 +0000
X-Mailer: git-send-email 2.26.2
X-Originating-IP: [185.128.24.45]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 726ebfd8-580f-49f8-ec69-08d81297dfda
X-MS-TrafficTypeDiagnostic: CWXP123MB3255:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CWXP123MB32558C761F19453124484A80839A0@CWXP123MB3255.GBRP123.PROD.OUTLOOK.COM>
X-Antispam-2: 1
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 04371797A5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3hWPG4eAFt0tamsvApu9ghhJrzFgn29hh46fXganKztKYFVlHajXjwBTH7c82sRWnOJM89LaYwC9YGT9mhRNzGXj/Sn+8AtalfAuRf5i/BgCt4ugTY1Hrz0GwS3E+vosJ1fHTTkNedWEssb2tXiU68LZiQClbB1j5A3Q6UE+K9kkMTWz/qD/qG0s70xFAacKiD76olqjkmAE9FoZuQBrw5Y91eThsIUr4AeojRxX62aJF+l1sTpKAxUCLhTYN1BEXiCxL+ApOmxXESVyXBVGtqAg5icWVUp+Gc29v11H2dBPlH5L4Uv0kFnajhefOaJfA1yjrwKNhaIXwbkuNPGF9e8jt1z8ICAoESIbNJeqXdX6kJAbmyAHOuxreRYq0+8GiE+CnziYejxaQZly5xdPV8+BPnsEyOJI37IGlCE4a9M=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CWXP123MB1958.GBRP123.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(136003)(366004)(346002)(376002)(39860400002)(44832011)(1076003)(8676002)(2616005)(316002)(8936002)(6666004)(6486002)(956004)(2906002)(5660300002)(83380400001)(6506007)(69590400007)(26005)(6512007)(36756003)(6916009)(186003)(16526019)(478600001)(52116002)(66556008)(66476007)(4326008)(66946007)(86362001)(21314003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 58e62VKd9xpmh9Q8qvYfdJzDyee4uJVCKA/qORnmrD77Q77x+pqREKLP+ns2xBh1sF27Obr0UffLmtVE638ncXgwUUYbmQCQP2j8YuCACfwTLkV+0d/BCTe8LqLucBA+EakrJLuTGfoxDfaS2N/YzpGst1S/xOzrjndEF95UgixnsXGFCLUGWjyaWUzoOdLsGutpzpSGUThgiYye/5EvOaQ3FH/tNB+L+kwewY6UrnCijDI01fTqwUpDtvVbKdu/j0VlKPWZQBa2gy9DLa5hmsMVIjmkl6RKdUE1kUK2efkJpJC6bWZRDiIDlfRZIoVwsTVyls0xRAP8BYgA7CeKFeUHMIIsdI7T4b9fr9d4LKrJoz9W0YJTitWnIwCacN448k91OM0ovxNUhmHq8XTY4bvyq+Os3ULMoctv6HsI5B1Lw8L0J2RCcYNm4TCCmwj0/lbKpkb4QPsUTqLplr+CYdcL9KdQVQ2wlYyYhThOfX8=
X-MS-Exchange-CrossTenant-Network-Message-Id: 726ebfd8-580f-49f8-ec69-08d81297dfda
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2020 08:24:38.1801 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a7f35688-9c00-4d5e-ba41-29f146377ab0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SEOnLawZdUP2BoNnHJGPuinI+EEMYngidOfBziGzWF7+NoeCxdrrmUW1wUGG0sAceMZPGil/M7jCVFkXJ95hJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP123MB3255
X-OriginatorOrg: bt.com
Received-SPF: pass client-ip=62.239.224.234; envelope-from=jasper.lowell@bt.com;
 helo=smtpe1.intersmtp.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/17 04:24:48
X-ACL-Warn: Detected OS   = ???
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: tony.nguyen@bt.com, mark.cave-ayland@ilande.co.uk, atar4qemu@gmail.com,
 Jasper Lowell <jasper.lowell@bt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Each channel on the controller has dedicated pins for providing receive
and transmit clock sources, a baud rate generator, and a DPLL.
Additionally, the controller has two pins, XTAL1 and XTAL2, that can be
used with a crystal and oscillator for providing a clock source.
Alternatively, XTAL1 can simply be used as a clock source. These
components are used individually or together according to register
configurations for generating the final receive and transmit clocks.

Signed-off-by: Jasper Lowell <jasper.lowell@bt.com>
---
 hw/char/escc2.c | 179 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 177 insertions(+), 2 deletions(-)

diff --git a/hw/char/escc2.c b/hw/char/escc2.c
index e16049ce4d..059e033089 100644
--- a/hw/char/escc2.c
+++ b/hw/char/escc2.c
@@ -106,9 +106,31 @@
 
 /* CCR1. */
 #define REGISTER_CCR1_OFFSET                    0x2d
+#define REGISTER_CCR1_ODS                       0x10
+#define REGISTER_CCR1_BCR                       0x8
+#define REGISTER_CCR1_CM2                       0x4
+#define REGISTER_CCR1_CM1                       0x2
+#define REGISTER_CCR1_CM0                       0x1
+
+#define REGISTER_CCR1_CM_MASK \
+    (REGISTER_CCR1_CM2 | REGISTER_CCR1_CM1 | REGISTER_CCR1_CM0)
 
 /* CCR2. */
 #define REGISTER_CCR2_OFFSET                    0x2e
+#define REGISTER_CCR2_SOC1                      0x80
+#define REGISTER_CCR2_BR9                       0x80
+#define REGISTER_CCR2_SOC0                      0x40
+#define REGISTER_CCR2_BR8                       0x40
+#define REGISTER_CCR2_BDF                       0x20
+#define REGISTER_CCR2_XCS0                      0x20
+#define REGISTER_CCR2_SSEL                      0x10
+#define REGISTER_CCR2_RCS0                      0x10
+#define REGISTER_CCR2_TOE                       0x8
+#define REGISTER_CCR2_RWX                       0x4
+#define REGISTER_CCR2_DIV                       0x1
+
+#define REGISTER_CCR2_BR_MASK \
+    (REGISTER_CCR2_BR8 | REGISTER_CCR2_BR9)
 
 /* CCR3. */
 #define REGISTER_CCR3_OFFSET                    0x2f
@@ -131,6 +153,9 @@
 /* BGR. */
 #define REGISTER_BGR_OFFSET                     0x34
 
+#define REGISTER_BGR_EN_MASK                    0x3f
+#define REGISTER_BGR_EM_MASK                    0xc0
+
 /* TIC. */
 #define REGISTER_TIC_OFFSET                     0x35
 
@@ -194,6 +219,10 @@
 
 /* CCR4. */
 #define REGISTER_CCR4_OFFSET                    0x3f
+#define REGISTER_CCR4_MCK4                      0x80
+#define REGISTER_CCR4_EBRG                      0x40
+#define REGISTER_CCR4_TST1                      0x20
+#define REGISTER_CCR4_ICD                       0x10
 
 enum {
     REGISTER_STAR = 0,
@@ -244,6 +273,14 @@ typedef struct ESCC2State ESCC2State;
 typedef struct ESCC2ChannelState {
     ESCC2State *controller;
 
+    /*
+     * Each channel has dedicated pins for providing receive and transmit clock
+     * sources. These dedicated pins are a subset of a larger set of selectable
+     * clock sources.
+     */
+    unsigned int rxclock;
+    unsigned int txclock;
+
     CharBackend chardev;
 
     /*
@@ -275,6 +312,14 @@ enum {
 struct ESCC2State {
     DeviceState parent;
 
+    /*
+     * The controller has two pins: XTAL1 and XTAL2. These pins can be used
+     * together with a crystal and oscillator to provide a clock source.
+     * Alternatively, XTAL1 can provide an externally generated clock source.
+     * These configurations are mutually exclusive.
+     */
+    unsigned int xtal;
+
     MemoryRegion io;
     qemu_irq irq;
     ESCC2ChannelState channel[CHANNEL_COUNT];
@@ -376,9 +421,130 @@ static void escc2_channel_irq_event(ESCC2ChannelState *channel,
     }
 }
 
+static float escc2_channel_baud_rate_generate(ESCC2ChannelState *channel,
+        unsigned int clock)
+{
+    /*
+     * Each channel has an independent baud rate generator. This baud rate
+     * generator can act as a clock source for receiving, transmitting, and/or
+     * for the DPLL.
+     */
+    int k, n, m;
+    uint8_t ccr2 = REGISTER_READ(channel, REGISTER_CCR2);
+    uint8_t bgr = REGISTER_READ(channel, REGISTER_BGR);
+
+    if (REGISTER_READ(channel, REGISTER_CCR2) & REGISTER_CCR2_BDF) {
+        /* The baud rate division factor k relies on BGR. */
+        if (REGISTER_READ(channel, REGISTER_CCR4) & REGISTER_CCR4_EBRG) {
+            /* Enhanced mode. */
+            n = bgr & REGISTER_BGR_EN_MASK;
+            m = ((ccr2 & REGISTER_CCR2_BR_MASK) >> 6)
+                | ((bgr & REGISTER_BGR_EM_MASK) >> 6);
+            k = (n + 1) * (2 * m);
+        } else {
+            /* Standard mode. */
+            n = ((ccr2 & REGISTER_CCR2_BR_MASK) << 2) | bgr;
+            k = (n + 1) * 2;
+        }
+    } else {
+        k = 1;
+    }
+
+    return (float) clock / (16 * k);
+}
+
+static void escc2_channel_io_speed(ESCC2ChannelState *channel, float *input,
+        float *output)
+{
+    /*
+     * The receive and transmit speed can be configured to leverage dedicated
+     * receive and transmit clock source pins, the channel independent baud rate
+     * generator, the DPLL for handling clock synchronisation, the onboard
+     * oscillator, and a designated master clock. Different combinations of
+     * these are selected by specifying the clock mode and submode.
+     *
+     * Note: The DPLL, to function correctly, requires a clock source with a
+     * frequency 16 times the nominal bit rate so that the DPLL can synchronise
+     * the clock with the input stream. When the DPLL is used, the frequency
+     * must be divided by 16.
+     */
+    unsigned int mode = REGISTER_READ(channel, REGISTER_CCR1)
+        & REGISTER_CCR1_CM_MASK;
+    unsigned int submode = REGISTER_READ(channel, REGISTER_CCR2)
+        & REGISTER_CCR2_SSEL;
+
+    /* Clock modes are numbered 0 through 7. */
+    switch (mode) {
+    case 0:
+        *input = channel->rxclock;
+        if (!submode) {
+            /* 0a. */
+            *output = channel->txclock;
+        } else {
+            /* 0b. */
+            *output = escc2_channel_baud_rate_generate(channel,
+                    channel->controller->xtal);
+        }
+        break;
+    case 1:
+        *input = channel->rxclock;
+        *output = *input;
+        break;
+    case 2:
+        *input = escc2_channel_baud_rate_generate(channel, channel->rxclock)
+            / 16;
+        if (!(REGISTER_READ(channel, REGISTER_CCR2)
+                    & REGISTER_CCR2_SSEL)) {
+            /* 2a. */
+            *output = channel->txclock;
+        } else {
+            /* 2b. */
+            *output = *input;
+        }
+        break;
+    case 3:
+        *input = escc2_channel_baud_rate_generate(channel, channel->rxclock);
+        if (!(REGISTER_READ(channel, REGISTER_CCR2) & REGISTER_CCR2_SSEL)) {
+            /* 3a. */
+            *input /= 16;
+        }
+        *output = *input;
+        break;
+    case 4:
+        *input = channel->controller->xtal;
+        *output = *input;
+    case 5:
+        *input = channel->rxclock;
+        *output = *input;
+    case 6:
+        *input = escc2_channel_baud_rate_generate(channel,
+                channel->controller->xtal) / 16;
+        if (!(REGISTER_READ(channel, REGISTER_CCR2) & REGISTER_CCR2_SSEL)) {
+            /* 6a. */
+            *output = channel->txclock;
+        } else {
+            /* 6b. */
+            *output = *input;
+        }
+        break;
+    case 7:
+        *input = escc2_channel_baud_rate_generate(channel,
+                channel->controller->xtal);
+        if (!(REGISTER_READ(channel, REGISTER_CCR2) & REGISTER_CCR2_SSEL)) {
+            /* 7a. */
+            *input /= 16;
+        }
+        *output = *input;
+        break;
+    default:
+        g_assert_not_reached();
+    }
+}
+
 static void escc2_channel_parameters_update(ESCC2ChannelState *channel)
 {
     uint8_t dafo;
+    float ispeed, ospeed;
     QEMUSerialSetParams ssp;
 
     if (!qemu_chr_fe_backend_connected(&channel->chardev)) {
@@ -434,8 +600,12 @@ static void escc2_channel_parameters_update(ESCC2ChannelState *channel)
         ssp.stop_bits = 1;
     }
 
-    /* XXX */
-    ssp.speed = 0;
+    /*
+     * XXX: QEMU doesn't support configurations with different input/output
+     * speeds yet so the input speed is used for both.
+     */
+    escc2_channel_io_speed(channel, &ispeed, &ospeed);
+    ssp.speed = ispeed;
 
     qemu_chr_fe_ioctl(&channel->chardev, CHR_IOCTL_SERIAL_SET_PARAMS, &ssp);
 }
@@ -852,6 +1022,11 @@ static void escc2_isa_instance_init(Object *o)
 static Property escc2_properties[] = {
     DEFINE_PROP_CHR("chardevA", ESCC2State, channel[CHANNEL_A].chardev),
     DEFINE_PROP_CHR("chardevB", ESCC2State, channel[CHANNEL_B].chardev),
+    DEFINE_PROP_UINT32("xtal", ESCC2State, xtal, 0),
+    DEFINE_PROP_UINT32("rxclockA", ESCC2State, channel[CHANNEL_A].rxclock, 0),
+    DEFINE_PROP_UINT32("txclockA", ESCC2State, channel[CHANNEL_A].txclock, 0),
+    DEFINE_PROP_UINT32("rxclockB", ESCC2State, channel[CHANNEL_B].rxclock, 0),
+    DEFINE_PROP_UINT32("txclockB", ESCC2State, channel[CHANNEL_B].txclock, 0),
     DEFINE_PROP_END_OF_LIST()
 };
 
-- 
2.26.2


