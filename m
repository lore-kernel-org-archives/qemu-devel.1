Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77BDCC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 08:27:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EEAB2085B
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 08:27:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bt.com header.i=@bt.com header.b="EQ2VJsXn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EEAB2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bt.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52964 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlTQ4-0001du-Ev
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 04:27:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54470)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasper.lowell@bt.com>)
 id 1jlTNC-00054A-P4
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 04:24:43 -0400
Received: from smtpe1.intersmtp.com ([213.121.35.75]:50467)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasper.lowell@bt.com>)
 id 1jlTN9-0003w1-Lw
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 04:24:42 -0400
Received: from tpw09926dag05h.domain1.systemhost.net (10.9.202.32) by
 BWP09926080.bt.com (10.36.82.111) with Microsoft SMTP Server (version=TLS1_2, 
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.1.1713.5; Wed, 17
 Jun 2020 09:24:17 +0100
Received: from tpw09926dag12g.domain1.systemhost.net (10.9.212.28) by
 tpw09926dag05h.domain1.systemhost.net (10.9.202.32) with Microsoft SMTP
 Server (TLS) id 15.0.1395.4; Wed, 17 Jun 2020 09:24:36 +0100
Received: from RDW083A009ED65.bt.com (10.187.98.35) by
 tpw09926dag12g.domain1.systemhost.net (10.9.212.28) with Microsoft SMTP
 Server (TLS) id 15.0.1395.4 via Frontend Transport; Wed, 17 Jun 2020 09:24:36
 +0100
Received: from GBR01-CWL-obe.outbound.protection.outlook.com (104.47.20.57) by
 smtpe1.intersmtp.com (62.239.224.236) with Microsoft SMTP Server
 (TLS) id 14.3.439.0; Wed, 17 Jun 2020 09:17:12 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EhXtrU9p8EgR3vl4cwCtXh4znYeaXbvpk7C7ApVipOF9UF/y2cnV58STEvvrbWpzj6W62l7H5IOGUaHzuBLiaxeh9IrqvBgZAbAzjdJz73DUriZsCyKSESyIYzSl3hbPf5w6iO7celns9ceh61ST205say2Oe36fEaF4gzVSGM2gwocBIQFSfqYzDGqfUhmZ0CW/Iw44MmwWnYOlJ1eyAmmvKxIzstgaG8CzPb394sLaRth+zWNB22TG0EU1mQUSduZFPEP4mvqmCMknwrOlKVxFJzuCcrlwxka4sovjEkduZ/JSMD8xZNAo/IjdS0P7sqvb2GXiHJ1vsny34GGd1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=54eo+T7L13Qlsrynt9C1L9gHU9Mlb0ek8Y+XSbMCeqI=;
 b=iQQQBa480h+c8Tmqh3JRGYPl/7pU//sj8DeLiAvxVIiPlfwU1hGw6gJRyKxzZhFpL3rTYNC+IMz9rPISwCH3RXjLE+6kAsq301JvthNZLwrmpT7+jj6UsAyjwfyVdFD/oQLpqzmQuxuExEj4Jb09tnYVb+LohTdiInqc4E9Q7R6IcD90FiinXMKcoYcSBoQA3bwbdQXyBcRZifBX9MUSIiMCkvTohSM4KU+gsIDbcY2xprzysYHat09bpKF+jEBBUbcZAfkp39cbWB3hiyCUzkFdbnerH13nfNMMUUHFgMtv1Am4M6cGmfZvtHKLEXREHe4BwOeEUGZtpbM6r8Cdyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bt.com; dmarc=pass action=none header.from=bt.com; dkim=pass
 header.d=bt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bt.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=54eo+T7L13Qlsrynt9C1L9gHU9Mlb0ek8Y+XSbMCeqI=;
 b=EQ2VJsXneNf6L3uxTe12UXy7a+4qraB/AyTpfQDwWVBnxwElpP8x53cIuUFARWMVEIX3kqtVkZwdwPyJY9jD1pH+p/nMRyGTV27NPwBpMwkOF7Hsg59O51nPqAPaVmfLdaKtzoYQr8A/etf/mS3BsDx5IUvy1NceZD5uMJ1/0mI=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bt.com;
Received: from CWXP123MB1958.GBRP123.PROD.OUTLOOK.COM (2603:10a6:401:7b::18)
 by CWXP123MB3255.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:43::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Wed, 17 Jun
 2020 08:24:30 +0000
Received: from CWXP123MB1958.GBRP123.PROD.OUTLOOK.COM
 ([fe80::e098:8c50:5b1e:6a1b]) by CWXP123MB1958.GBRP123.PROD.OUTLOOK.COM
 ([fe80::e098:8c50:5b1e:6a1b%7]) with mapi id 15.20.3109.021; Wed, 17 Jun 2020
 08:24:30 +0000
From: Jasper Lowell <jasper.lowell@bt.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH 2/8] hw/char/escc2: Handle interrupt generation
Date: Wed, 17 Jun 2020 18:23:56 +1000
Message-ID: <20200617082402.242631-3-jasper.lowell@bt.com>
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
 15.20.3109.21 via Frontend Transport; Wed, 17 Jun 2020 08:24:27 +0000
X-Mailer: git-send-email 2.26.2
X-Originating-IP: [185.128.24.45]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3ecfa6c9-08b3-4706-44f2-08d81297db59
X-MS-TrafficTypeDiagnostic: CWXP123MB3255:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CWXP123MB3255D320CA879F7144DBD724839A0@CWXP123MB3255.GBRP123.PROD.OUTLOOK.COM>
X-Antispam-2: 1
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-Forefront-PRVS: 04371797A5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w0sOn0wXBCrhoR1S+fgeVHSOHRDUhFVph8SP5fcAraTnCbc/UiU+9EZGZgScjZ0h8bm33h+59rWEqI302rgJjfz0cWMNhQXFVPCeRR8HCKqYrPPu97kwIQOXfw1u58uwR5+iZQs4j9P7R1bozk8Vw04F4/qTcNBL4MkzQQxvfizz8HVCtuuZXX9yH5FxUtSt91tQeWBTexS9KogfFVDj2kNzTAC+/7YKTIWa90IpCtEke0MLhqexIEfHRjNk9K2HNCz2To/OPFIWwlU9oeAbwQYyBwvu3bAZpVZGTEsVEtxmk59c3H0F5M+T0iedR2QtelppPNfXVupFbM01d7CA+fua+eBWhhLz7ikbhYvWHU8xaJPq/aNgq2TBsuYDLQuh
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CWXP123MB1958.GBRP123.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(136003)(366004)(346002)(376002)(39860400002)(44832011)(1076003)(8676002)(2616005)(316002)(8936002)(6666004)(6486002)(956004)(2906002)(5660300002)(83380400001)(6506007)(69590400007)(26005)(6512007)(36756003)(6916009)(186003)(16526019)(478600001)(52116002)(66556008)(66476007)(4326008)(66946007)(86362001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 0Z7sW5Mzp/G2aDTk9uq8Xod6fKOrohwhDLl+qDIuJsLAvIs9Wb2b76Pa+yFdAzdSQQTxKthSCZz5uiS2nLXJsS/+UibZ0XLw+WABmlsq8UidAinA3RItZZoc/BYqWsbJaefxKFDbSWQ8IftY/WCAZfWickSp0/1ISjFpDgf57tcuCe8ShsDEhTxgwW/s3vULdiE+FiaMxXSgfdeO5ANCECFIs1wG+VUqYnr4ZggAjDgmMEL7UCxlv5jPzRuRubJsV5b57FpQsWLqWUqI/YCC5SQReZPjCio+k0ZPsMd1E0HLsXUBmQDRptrP40oGk/OlolKnu85fLicmHfEtKAxGCfMHLJdadqKjBfDEhruZ8OJ1bnoHk9e1CIkRlecj/GcmvpYhnBtdS3Twtz1egmN8Ve7TDTfTwDNCo42c6aK+GS0AhLuhd+8K7fXPGIY3yyRV8Bl2XmzpHxnX+ZGF9h2hZ9kNfWhOS4Iqgmw3HRMmF1k=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ecfa6c9-08b3-4706-44f2-08d81297db59
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2020 08:24:30.5655 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a7f35688-9c00-4d5e-ba41-29f146377ab0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SNw/dj7WkJhjhDS+3VmtvmBmrSrwYbFuJhPMjzb4CHtNZ23Pg533AYW7dLCyckIcdlVn+AeXW/89KSva9jDiHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP123MB3255
X-OriginatorOrg: bt.com
Received-SPF: pass client-ip=213.121.35.75; envelope-from=jasper.lowell@bt.com;
 helo=smtpe1.intersmtp.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/17 04:24:37
X-ACL-Warn: Detected OS   = Windows 7 or 8 [fuzzy]
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
 hw/char/escc2.c      | 88 ++++++++++++++++++++++++++++++++++++++++++++
 hw/char/trace-events |  1 +
 2 files changed, 89 insertions(+)

diff --git a/hw/char/escc2.c b/hw/char/escc2.c
index 94528b8a4c..926346482f 100644
--- a/hw/char/escc2.c
+++ b/hw/char/escc2.c
@@ -8,6 +8,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/char/escc2.h"
+#include "hw/irq.h"
 #include "hw/isa/isa.h"
 #include "hw/qdev-properties.h"
 #include "qapi/error.h"
@@ -55,6 +56,13 @@
 
 /* CCR0. */
 #define REGISTER_CCR0_OFFSET                    0x2c
+#define REGISTER_CCR0_PU                        0x80
+#define REGISTER_CCR0_MCE                       0x40
+#define REGISTER_CCR0_SC2                       0x10
+#define REGISTER_CCR0_SC1                       0x8
+#define REGISTER_CCR0_SC0                       0x4
+#define REGISTER_CCR0_SM1                       0x2
+#define REGISTER_CCR0_SM0                       0x1
 
 /* CCR1. */
 #define REGISTER_CCR1_OFFSET                    0x2d
@@ -94,12 +102,23 @@
 
 /* GIS. */
 #define REGISTER_GIS_OFFSET                     0x38
+#define REGISTER_GIS_PI                         0x80
+#define REGISTER_GIS_ISA1                       0x8
+#define REGISTER_GIS_ISA0                       0x4
+#define REGISTER_GIS_ISB1                       0x2
+#define REGISTER_GIS_ISB0                       0x1
 
 /* IVA. */
 #define REGISTER_IVA_OFFSET                     0x38
 
 /* IPC. */
 #define REGISTER_IPC_OFFSET                     0x39
+#define REGISTER_IPC_VIS                        0x80
+#define REGISTER_IPC_SLA1                       0x10
+#define REGISTER_IPC_SLA0                       0x8
+#define REGISTER_IPC_CASM                       0x4
+#define REGISTER_IPC_IC1                        0x2
+#define REGISTER_IPC_IC0                        0x1
 
 /* ISR0. */
 #define REGISTER_ISR0_OFFSET                    0x3a
@@ -207,6 +226,7 @@ struct ESCC2State {
     DeviceState parent;
 
     MemoryRegion io;
+    qemu_irq irq;
     ESCC2ChannelState channel[CHANNEL_COUNT];
 };
 
@@ -218,9 +238,62 @@ struct ESCC2State {
 typedef struct ESCC2ISAState {
     ISADevice parent;
     uint32_t iobase;
+    uint32_t irq;
     struct ESCC2State controller;
 } ESCC2ISAState;
 
+static void escc2_irq_update(ESCC2State *controller)
+{
+    bool power;
+    uint8_t gis;
+    ESCC2ChannelState *a, *b;
+
+    gis = 0;
+    a = CONTROLLER_CHANNEL_A(controller);
+    b = CONTROLLER_CHANNEL_B(controller);
+
+    /*
+     * Interrupts are not propagated to the CPU when in power-down mode. There
+     * is an exception for interrupts from the universal port.
+     */
+    power = REGISTER_READ(a, REGISTER_CCR0) & REGISTER_CCR0_PU;
+
+    if (REGISTER_READ(a, REGISTER_ISR0) & ~(REGISTER_READ(a, REGISTER_IMR0))) {
+        gis |= REGISTER_GIS_ISA0;
+    }
+    if (REGISTER_READ(a, REGISTER_ISR1) & ~(REGISTER_READ(a, REGISTER_IMR1))) {
+        gis |= REGISTER_GIS_ISA1;
+    }
+
+    if (REGISTER_READ(b, REGISTER_ISR0) & ~(REGISTER_READ(b, REGISTER_IMR0))) {
+        gis |= REGISTER_GIS_ISB0;
+    }
+    if (REGISTER_READ(b, REGISTER_ISR1) & ~(REGISTER_READ(b, REGISTER_IMR1))) {
+        gis |= REGISTER_GIS_ISB1;
+    }
+
+    if (REGISTER_READ(a, REGISTER_PIS) & ~(REGISTER_READ(a, REGISTER_PIM))) {
+        gis |= REGISTER_GIS_PI;
+        /*
+         * Ensure that interrupts are propagated even if the controller is in
+         * power-down mode.
+         */
+        power = true;
+    }
+
+    /* GIS is accessible from either channel and must be synchronised. */
+    REGISTER_WRITE(a, REGISTER_GIS, gis);
+    REGISTER_WRITE(b, REGISTER_GIS, gis);
+
+    if (gis && power) {
+        qemu_irq_raise(controller->irq);
+    } else {
+        qemu_irq_lower(controller->irq);
+    }
+
+    trace_escc2_irq_update(gis);
+}
+
 static void escc2_channel_reset(ESCC2ChannelState *channel)
 {
     unsigned int i;
@@ -320,15 +393,22 @@ static uint64_t escc2_mem_read(void *opaque, hwaddr addr, unsigned size)
         break;
     case REGISTER_ISR0_OFFSET:
         value = REGISTER_READ(channel, REGISTER_ISR0);
+        REGISTER_WRITE(channel, REGISTER_ISR0, 0);
+        escc2_irq_update(controller);
         break;
     case REGISTER_ISR1_OFFSET:
         value = REGISTER_READ(channel, REGISTER_ISR1);
+        REGISTER_WRITE(channel, REGISTER_ISR1, 0);
+        escc2_irq_update(controller);
         break;
     case REGISTER_PVR_OFFSET:
         value = REGISTER_READ(channel, REGISTER_PVR);
         break;
     case REGISTER_PIS_OFFSET:
         value = REGISTER_READ(channel, REGISTER_PIS);
+        REGISTER_WRITE(CONTROLLER_CHANNEL_A(controller), REGISTER_PIS, 0);
+        REGISTER_WRITE(CONTROLLER_CHANNEL_B(controller), REGISTER_PIS, 0);
+        escc2_irq_update(controller);
         break;
     case REGISTER_PCR_OFFSET:
         value = REGISTER_READ(channel, REGISTER_PCR);
@@ -506,6 +586,13 @@ static void escc2_isa_realize(DeviceState *dev, Error **errp)
         return;
     }
 
+    if (isa->irq == -1) {
+        error_setg(errp, "IRQ must be provided.");
+        return;
+    }
+
+    isa_init_irq(ISA_DEVICE(dev), &controller->irq, isa->irq);
+
     object_property_set_bool(OBJECT(controller), true, "realized", errp);
     if (*errp) {
         return;
@@ -536,6 +623,7 @@ static Property escc2_properties[] = {
 
 static Property escc2_isa_properties[] = {
     DEFINE_PROP_UINT32("iobase", ESCC2ISAState, iobase, -1),
+    DEFINE_PROP_UINT32("irq", ESCC2ISAState, irq, -1),
     DEFINE_PROP_END_OF_LIST()
 };
 
diff --git a/hw/char/trace-events b/hw/char/trace-events
index 65c176f582..b4f4f30815 100644
--- a/hw/char/trace-events
+++ b/hw/char/trace-events
@@ -57,6 +57,7 @@ escc_kbd_command(int val) "Command %d"
 escc_sunmouse_event(int dx, int dy, int buttons_state) "dx=%d dy=%d buttons=0x%01x"
 
 # escc2.c
+escc2_irq_update(uint8_t gis) "value 0x%x"
 escc2_mem_read(char channel, uint32_t addr, uint8_t value) "channel %c addr 0x%x value 0x%x"
 escc2_mem_write(char channel, uint32_t addr, uint8_t value) "channel %c addr 0x%x value 0x%x"
 
-- 
2.26.2


