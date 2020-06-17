Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D2BCC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 08:26:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA70B2085B
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 08:26:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bt.com header.i=@bt.com header.b="vS9ULolJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA70B2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bt.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47992 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlTOu-0007qR-3e
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 04:26:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54542)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasper.lowell@bt.com>)
 id 1jlTNK-000594-5i
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 04:24:50 -0400
Received: from smtpe1.intersmtp.com ([62.239.224.237]:4615)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasper.lowell@bt.com>)
 id 1jlTNH-0003wx-AP
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 04:24:49 -0400
Received: from tpw09926dag09h.domain1.systemhost.net (10.9.202.48) by
 RDW083A010ED66.bt.com (10.187.98.36) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Wed, 17 Jun 2020 09:23:10 +0100
Received: from tpw09926dag12g.domain1.systemhost.net (10.9.212.28) by
 tpw09926dag09h.domain1.systemhost.net (10.9.202.48) with Microsoft SMTP
 Server (TLS) id 15.0.1395.4; Wed, 17 Jun 2020 09:24:43 +0100
Received: from RDW083A009ED65.bt.com (10.187.98.35) by
 tpw09926dag12g.domain1.systemhost.net (10.9.212.28) with Microsoft SMTP
 Server (TLS) id 15.0.1395.4 via Frontend Transport; Wed, 17 Jun 2020 09:24:43
 +0100
Received: from GBR01-CWL-obe.outbound.protection.outlook.com (104.47.20.57) by
 smtpe1.intersmtp.com (62.239.224.236) with Microsoft SMTP Server
 (TLS) id 14.3.439.0; Wed, 17 Jun 2020 09:17:17 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LDILsuS4QW0q4XBEMpCkrtcRWLGEmZoKBjLfiTFYPgmDpqL3ZINCQ+eG7l12GemuUQ7NryI2qRUHlotV/txO/eEz3KmthZWQz5amt4g/zlvbs2DhFFFdkGXAkBE44LmdaSAcDwOBauOTT4pfPbSVzDbcySMFWK8clawOM/eS6AJGYqkDslETHvDgAWPby7PstmZ41FsJNNN00AOTp5ipIlsWJJVNZ0VXA2ia/Dym39Rgzf0VzOoLtD0HevEiS5eyLuoXPMTkIwNNZQAPUsjwqySqmK3gMG0+Rh65IvHYW7Y03hXgnyNGoeqEO3ukqKu1usLGmcY/vcE7tScbOegNrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F9X5dNrMjOPz/FVOwvphEHPAlRFPLy4Up+BuUxBM4LY=;
 b=YKO3yaR8eC3BKD/uiF9WcNtgHUZQcj2tfJXFWmrr5ZmvLUBSjSYzP6V/0CqIayUbeatSDNq3XzPJIERtQlNFwZfWoCt/f17VJ20SaHxDi0U18M0cbwfOIEPWBudfzJ0t1uSynbcqY5xJoFuc3WvtJTIPtAOXDil32ey5vFg59U3xGxxPq7PvcBdpX+bRxp/ILwDRbHPloalf/Md7q94cZ0RAi/ZVbtXcTrAifA52vrpi3rbK7ycGLLo8hmhamLXVcsf4E9zh2QG5RBMeiS+eRu9FzuhiyUKQQZezwHXF+ItaEXm5DXcjeHSSpHNCJrAcw0LPj9JRlI+erWFBuPu55w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bt.com; dmarc=pass action=none header.from=bt.com; dkim=pass
 header.d=bt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bt.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F9X5dNrMjOPz/FVOwvphEHPAlRFPLy4Up+BuUxBM4LY=;
 b=vS9ULolJV4W1WP99QiTqcRg9PdGDq4lwiPCALgeyMohKiad04/D/eywdfzUzg1gT1xxxbxwdMmPdP0/XN9IWcY3PMjZtA0B+qHOk+0Ni8CDFjKWg4ajiA9qe9fsm1ztSPFhg0Tm4bl0440Flh+ouXlp4zQ8hWqrT05MlNvTRB28=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bt.com;
Received: from CWXP123MB1958.GBRP123.PROD.OUTLOOK.COM (2603:10a6:401:7b::18)
 by CWXP123MB3255.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:43::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Wed, 17 Jun
 2020 08:24:34 +0000
Received: from CWXP123MB1958.GBRP123.PROD.OUTLOOK.COM
 ([fe80::e098:8c50:5b1e:6a1b]) by CWXP123MB1958.GBRP123.PROD.OUTLOOK.COM
 ([fe80::e098:8c50:5b1e:6a1b%7]) with mapi id 15.20.3109.021; Wed, 17 Jun 2020
 08:24:34 +0000
From: Jasper Lowell <jasper.lowell@bt.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH 3/8] hw/char/escc2: Add character device backend
Date: Wed, 17 Jun 2020 18:23:57 +1000
Message-ID: <20200617082402.242631-4-jasper.lowell@bt.com>
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
 15.20.3109.21 via Frontend Transport; Wed, 17 Jun 2020 08:24:31 +0000
X-Mailer: git-send-email 2.26.2
X-Originating-IP: [185.128.24.45]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 14455925-06ce-47c5-ccd7-08d81297dd98
X-MS-TrafficTypeDiagnostic: CWXP123MB3255:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CWXP123MB325504A9A459BA27DEE5CF40839A0@CWXP123MB3255.GBRP123.PROD.OUTLOOK.COM>
X-Antispam-2: 1
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-Forefront-PRVS: 04371797A5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OeTx9us+7I8I0dOYF0l1fAGam4Xl10gcs5zaoSg1CoGRQ12qtv38lRnD1CByUkfps+HLphNohyTzFI7Y9dwPFE3YllA2CwL7J0b4gXNgQyAnHZUdm/Drdtj++g7F9AZmufGOcRbfnHabw0q4dLkAqC9C/WYqVJLeiPXQh8/gxJdBZEN5iuoDIURf1WQxv6fs7sGPaMOajsiHY9dzkcUZ/thXDLN2j7nuQkztHmbhmMTMElgROLgMAqv1wpOKs+lJ9ZrYzMTZcG+FG9ERLIdVCH3HV0ASbO+u3vK044BSN5IpeV0HnECIUlBa2PVg8/ddk5uGTftNECELq79oBfQCLzrGiA9WPHTFUQg1ghj0cHw11VgBeneZYg2yI6kOzDsorOhYs4uzcOw/+fdHMiiEAbD2v7AnGnKjeqP18eCbPVo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CWXP123MB1958.GBRP123.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(136003)(366004)(346002)(376002)(39860400002)(44832011)(1076003)(8676002)(2616005)(316002)(8936002)(6666004)(6486002)(956004)(2906002)(5660300002)(83380400001)(6506007)(69590400007)(26005)(6512007)(36756003)(6916009)(186003)(16526019)(478600001)(52116002)(66556008)(66476007)(4326008)(66946007)(86362001)(21314003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: UfEFAbOkW2yVeDYsdoyOMJRoa46cZor2uzAB+x30kQrtOndiz+tnIIHqH3Ypl0k+vi13jjYhJAs+FDtLq7mJ9e02A+JWHD0VT1YTwP2x3QM5DaKsrxMChKvHFTclpi9HzcT/Qb57nH/5Bi2H/BvkbWZQwdO02h9o6e9qCmtJ6O0bdOugKPYQSBGj/1zGXuhNxxZiZYC7S3pubcwLRHvYByE9TsE5uOlmgi6x3bvxBx2dwkiasT4PYdMdOWSv3GqxS/uTPDWY4bPoinEO30U86SED6mND2B4BXYB2c5feGw7TM19L23eJrJ0HjJOPScF96qxsxoUEtG44oZ6IIaqmhhnbxYivys6MelhPvrciQc0Vm0LWrrQmzGDEsekTLUlJr4WWP0XrOhG1rRhSB61PfU3f7PVLadmnMSssUibkTpEFGWzTSWz/hafijvM9133WmtKqfyoT/OGG3DDL5uRvG/VTA1/9VfrrOFLZmSms47c=
X-MS-Exchange-CrossTenant-Network-Message-Id: 14455925-06ce-47c5-ccd7-08d81297dd98
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2020 08:24:34.3583 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a7f35688-9c00-4d5e-ba41-29f146377ab0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JG2vXWoabi+K3IvHx4wAJwEnIwdL+Xl/StdLg92ejtljQInHjHSEY08mXOY9sjJIGN0kPO9aJAWqJzQ73hAXhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP123MB3255
X-OriginatorOrg: bt.com
Received-SPF: pass client-ip=62.239.224.237; envelope-from=jasper.lowell@bt.com;
 helo=smtpe1.intersmtp.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/17 04:24:45
X-ACL-Warn: Detected OS   = ???
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=-0.01,
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

Signed-off-by: Jasper Lowell <jasper.lowell@bt.com>
---
 hw/char/escc2.c | 234 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 234 insertions(+)

diff --git a/hw/char/escc2.c b/hw/char/escc2.c
index 926346482f..e16049ce4d 100644
--- a/hw/char/escc2.c
+++ b/hw/char/escc2.c
@@ -7,6 +7,8 @@
  */
 
 #include "qemu/osdep.h"
+#include "chardev/char-fe.h"
+#include "chardev/char-serial.h"
 #include "hw/char/escc2.h"
 #include "hw/irq.h"
 #include "hw/isa/isa.h"
@@ -17,6 +19,13 @@
 
 /* STAR. */
 #define REGISTER_STAR_OFFSET                    0x20
+#define REGISTER_STAR_XDOV                      0x80
+#define REGISTER_STAR_XFW                       0x40
+#define REGISTER_STAR_RFNE                      0x20
+#define REGISTER_STAR_FCS                       0x10
+#define REGISTER_STAR_TEC                       0x8
+#define REGISTER_STAR_CEC                       0x4
+#define REGISTER_STAR_CTS                       0x2
 
 /* CMDR. */
 #define REGISTER_CMDR_OFFSET                    0x20
@@ -38,9 +47,40 @@
 
 /* DAFO. */
 #define REGISTER_DAFO_OFFSET                    0x27
+#define REGISTER_DAFO_XBRK                      0x40
+#define REGISTER_DAFO_STOP                      0x20
+#define REGISTER_DAFO_PAR1                      0x10
+#define REGISTER_DAFO_PAR0                      0x8
+#define REGISTER_DAFO_PARE                      0x4
+#define REGISTER_DAFO_CHL1                      0x2
+#define REGISTER_DAFO_CHL0                      0x1
+
+#define REGISTER_DAFO_PAR_MASK \
+    (REGISTER_DAFO_PAR1 | REGISTER_DAFO_PAR0)
+#define REGISTER_DAFO_PAR_SPACE                 0x0
+#define REGISTER_DAFO_PAR_ODD                   (REGISTER_DAFO_PAR0)
+#define REGISTER_DAFO_PAR_EVEN                  (REGISTER_DAFO_PAR1)
+#define REGISTER_DAFO_PAR_MARK \
+    (REGISTER_DAFO_PAR1 | REGISTER_DAFO_PAR0)
+#define REGISTER_DAFO_CHL_MASK \
+    (REGISTER_DAFO_CHL1 | REGISTER_DAFO_CHL0)
+#define REGISTER_DAFO_CHL_CS8                   0x0
+#define REGISTER_DAFO_CHL_CS7                   (REGISTER_DAFO_CHL0)
+#define REGISTER_DAFO_CHL_CS6                   (REGISTER_DAFO_CHL1)
+#define REGISTER_DAFO_CHL_CS5 \
+    (REGISTER_DAFO_CHL1 | REGISTER_DAFO_CHL0)
 
 /* RFC. */
 #define REGISTER_RFC_OFFSET                     0x28
+#define REGISTER_RFC_DPS                        0x40
+#define REGISTER_RFC_DXS                        0x20
+#define REGISTER_RFC_RFDF                       0x10
+#define REGISTER_RFC_RFTH1                      0x8
+#define REGISTER_RFC_RFTH0                      0x4
+#define REGISTER_RFC_TCDE                       0x1
+
+#define REGISTER_RFC_RFTH_MASK \
+    (REGISTER_RFC_RFTH1 | REGISTER_RFC_RFTH0)
 
 /* RBCL. */
 #define REGISTER_RBCL_OFFSET                    0x2a
@@ -122,6 +162,14 @@
 
 /* ISR0. */
 #define REGISTER_ISR0_OFFSET                    0x3a
+#define REGISTER_ISR0_TCD                       0x80
+#define REGISTER_ISR0_TIME                      0x40
+#define REGISTER_ISR0_PERR                      0x20
+#define REGISTER_ISR0_FERR                      0x10
+#define REGISTER_ISR0_PLLA                      0x8
+#define REGISTER_ISR0_CDSC                      0x4
+#define REGISTER_ISR0_RFO                       0x2
+#define REGISTER_ISR0_RPF                       0x1
 
 /* IMR0. */
 #define REGISTER_IMR0_OFFSET                    0x3a
@@ -196,6 +244,8 @@ typedef struct ESCC2State ESCC2State;
 typedef struct ESCC2ChannelState {
     ESCC2State *controller;
 
+    CharBackend chardev;
+
     /*
      * The SAB 82532 ships with 64 byte FIFO queues for transmitting and
      * receiving but only 32 bytes are addressable.
@@ -294,6 +344,102 @@ static void escc2_irq_update(ESCC2State *controller)
     trace_escc2_irq_update(gis);
 }
 
+static void escc2_channel_irq_event(ESCC2ChannelState *channel,
+        uint8_t status_register, uint8_t event)
+{
+    /*
+     * Ensure that event does not have more than one bit set when calling this
+     * function.
+     */
+    uint8_t mask, tmp;
+
+    switch (status_register) {
+    case REGISTER_ISR0:
+        mask = REGISTER_READ(channel, REGISTER_IMR0);
+        break;
+    case REGISTER_ISR1:
+        mask = REGISTER_READ(channel, REGISTER_IMR1);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+    if ((event & ~(mask))
+            || (REGISTER_READ(channel, REGISTER_IPC) & REGISTER_IPC_VIS)) {
+        tmp = REGISTER_READ(channel, status_register);
+        tmp |= event;
+        REGISTER_WRITE(channel, status_register, tmp);
+    }
+
+    if (event & ~(mask)) {
+        escc2_irq_update(channel->controller);
+    }
+}
+
+static void escc2_channel_parameters_update(ESCC2ChannelState *channel)
+{
+    uint8_t dafo;
+    QEMUSerialSetParams ssp;
+
+    if (!qemu_chr_fe_backend_connected(&channel->chardev)) {
+        return;
+    }
+
+    /* Check if parity is enabled. */
+    dafo = REGISTER_READ(channel, REGISTER_DAFO);
+    if (dafo & REGISTER_DAFO_PARE) {
+        /* Determine the parity. */
+        switch (dafo & REGISTER_DAFO_PAR_MASK) {
+        case REGISTER_DAFO_PAR_SPACE:
+        case REGISTER_DAFO_PAR_MARK:
+            /*
+             * XXX: QEMU doesn't support stick parity yet. Silently fail and
+             * fall to the next case.
+             */
+        case REGISTER_DAFO_PAR_ODD:
+            ssp.parity = 'O';
+            break;
+        case REGISTER_DAFO_PAR_EVEN:
+            ssp.parity = 'E';
+            break;
+        default:
+            g_assert_not_reached();
+        }
+    } else {
+        ssp.parity = 'N';
+    }
+
+    /* Determine the number of data bits. */
+    switch (dafo & REGISTER_DAFO_CHL_MASK) {
+    case REGISTER_DAFO_CHL_CS8:
+        ssp.data_bits = 8;
+        break;
+    case REGISTER_DAFO_CHL_CS7:
+        ssp.data_bits = 7;
+        break;
+    case REGISTER_DAFO_CHL_CS6:
+        ssp.data_bits = 6;
+        break;
+    case REGISTER_DAFO_CHL_CS5:
+        ssp.data_bits = 5;
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+    /* Determine the number of stop bits. */
+    if (dafo & REGISTER_DAFO_STOP) {
+        ssp.stop_bits = 2;
+    } else {
+        ssp.stop_bits = 1;
+    }
+
+    /* XXX */
+    ssp.speed = 0;
+
+    qemu_chr_fe_ioctl(&channel->chardev, CHR_IOCTL_SERIAL_SET_PARAMS, &ssp);
+}
+
 static void escc2_channel_reset(ESCC2ChannelState *channel)
 {
     unsigned int i;
@@ -469,6 +615,7 @@ static void escc2_mem_write(void *opaque, hwaddr addr, uint64_t value,
         break;
     case REGISTER_DAFO_OFFSET:
         REGISTER_WRITE(channel, REGISTER_DAFO, value);
+        escc2_channel_parameters_update(channel);
         break;
     case REGISTER_RFC_OFFSET:
         REGISTER_WRITE(channel, REGISTER_RFC, value);
@@ -484,6 +631,7 @@ static void escc2_mem_write(void *opaque, hwaddr addr, uint64_t value,
         break;
     case REGISTER_CCR1_OFFSET:
         REGISTER_WRITE(channel, REGISTER_CCR1, value);
+        escc2_channel_parameters_update(channel);
         break;
     case REGISTER_CCR2_OFFSET:
         REGISTER_WRITE(channel, REGISTER_CCR2, value);
@@ -505,9 +653,11 @@ static void escc2_mem_write(void *opaque, hwaddr addr, uint64_t value,
         break;
     case REGISTER_BGR_OFFSET:
         REGISTER_WRITE(channel, REGISTER_BGR, value);
+        escc2_channel_parameters_update(channel);
         break;
     case REGISTER_TIC_OFFSET:
         REGISTER_WRITE(channel, REGISTER_TIC, value);
+        qemu_chr_fe_write_all(&channel->chardev, (uint8_t *)&value, 1);
         break;
     case REGISTER_MXN_OFFSET:
         REGISTER_WRITE(channel, REGISTER_MXN, value);
@@ -542,6 +692,7 @@ static void escc2_mem_write(void *opaque, hwaddr addr, uint64_t value,
         break;
     case REGISTER_CCR4_OFFSET:
         REGISTER_WRITE(channel, REGISTER_CCR4, value);
+        escc2_channel_parameters_update(channel);
         break;
     default:
         /* Registers do not exhaustively cover the addressable region. */
@@ -551,6 +702,74 @@ static void escc2_mem_write(void *opaque, hwaddr addr, uint64_t value,
     trace_escc2_mem_write(CHANNEL_CHAR(channel), offset, value);
 }
 
+static unsigned int escc2_channel_rfifo_threshold(ESCC2ChannelState *channel)
+{
+    unsigned int threshold;
+
+    switch (REGISTER_READ(channel, REGISTER_RFC) & REGISTER_RFC_RFTH_MASK) {
+    case 0:
+        threshold = 1;
+        break;
+    case 1:
+        threshold = 4;
+        break;
+    case 2:
+        threshold = 16;
+        break;
+    case 3:
+        threshold = 32;
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+    return threshold;
+}
+
+static int escc2_channel_chardev_can_receive(void *opaque)
+{
+    uint8_t tmp;
+    ESCC2ChannelState *channel = opaque;
+    unsigned int threshold = escc2_channel_rfifo_threshold(channel);
+
+    tmp = REGISTER_READ(channel, REGISTER_RBCL);
+    if (threshold > tmp) {
+        return threshold - tmp;
+    } else {
+        return 0;
+    }
+}
+
+static void escc2_channel_chardev_receive(void *opaque, const uint8_t *buf,
+        int size)
+{
+    uint8_t tmp, rbcl;
+    unsigned int i, nbytes;
+    ESCC2ChannelState *channel = opaque;
+
+    /* Determine the number of characters that can be safely consumed. */
+    rbcl = REGISTER_READ(channel, REGISTER_RBCL);
+    if (rbcl + size > CHANNEL_FIFO_LENGTH) {
+        nbytes = CHANNEL_FIFO_LENGTH - rbcl;
+    } else {
+        nbytes = size;
+    }
+
+    /* Consume characters. */
+    for (i = 0; i < nbytes; i++) {
+        channel->fifo_receive[rbcl + i] = buf[i];
+    }
+    REGISTER_WRITE(channel, REGISTER_RBCL, rbcl + nbytes);
+
+    tmp = REGISTER_READ(channel, REGISTER_STAR);
+    tmp |= REGISTER_STAR_RFNE;
+    REGISTER_WRITE(channel, REGISTER_STAR, tmp);
+
+    if (escc2_channel_chardev_can_receive(channel) == 0) {
+        escc2_channel_irq_event(channel, REGISTER_ISR0, REGISTER_ISR0_RPF);
+    }
+}
+
 static void escc2_realize(DeviceState *dev, Error **errp)
 {
     unsigned int i;
@@ -560,6 +779,13 @@ static void escc2_realize(DeviceState *dev, Error **errp)
     for (i = 0; i < CHANNEL_COUNT; i++) {
         channel = &controller->channel[i];
         channel->controller = controller;
+
+        if (qemu_chr_fe_backend_connected(&channel->chardev)) {
+            qemu_chr_fe_set_handlers(&channel->chardev,
+                    escc2_channel_chardev_can_receive,
+                    escc2_channel_chardev_receive, NULL, NULL, channel, NULL,
+                    true);
+        }
     }
 
     qemu_register_reset(escc2_reset, controller);
@@ -605,7 +831,13 @@ static void escc2_isa_realize(DeviceState *dev, Error **errp)
 
 static void escc2_unrealize(DeviceState *dev)
 {
+    unsigned int i;
     ESCC2State *controller = ESCC2(dev);
+
+    for (i = 0; i < CHANNEL_COUNT; i++) {
+        qemu_chr_fe_deinit(&controller->channel[i].chardev, false);
+    }
+
     qemu_unregister_reset(escc2_reset, controller);
 }
 
@@ -618,6 +850,8 @@ static void escc2_isa_instance_init(Object *o)
 }
 
 static Property escc2_properties[] = {
+    DEFINE_PROP_CHR("chardevA", ESCC2State, channel[CHANNEL_A].chardev),
+    DEFINE_PROP_CHR("chardevB", ESCC2State, channel[CHANNEL_B].chardev),
     DEFINE_PROP_END_OF_LIST()
 };
 
-- 
2.26.2


