Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A30FBC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 08:25:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B80720679
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 08:25:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bt.com header.i=@bt.com header.b="U8onlo2q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B80720679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bt.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45496 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlTOJ-0006cx-G7
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 04:25:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54440)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasper.lowell@bt.com>)
 id 1jlTN9-000532-Sb
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 04:24:40 -0400
Received: from smtpe1.intersmtp.com ([213.121.35.79]:58732)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasper.lowell@bt.com>)
 id 1jlTN3-0003vg-TK
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 04:24:38 -0400
Received: from tpw09926dag06h.domain1.systemhost.net (10.9.202.33) by
 BWP09926084.bt.com (10.36.82.115) with Microsoft SMTP Server (version=TLS1_2, 
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.1.1713.5; Wed, 17
 Jun 2020 09:24:08 +0100
Received: from tpw09926dag12f.domain1.systemhost.net (10.9.212.20) by
 tpw09926dag06h.domain1.systemhost.net (10.9.202.33) with Microsoft SMTP
 Server (TLS) id 15.0.1395.4; Wed, 17 Jun 2020 09:24:31 +0100
Received: from RDW083A009ED65.bt.com (10.187.98.35) by
 tpw09926dag12f.domain1.systemhost.net (10.9.212.20) with Microsoft SMTP
 Server (TLS) id 15.0.1395.4 via Frontend Transport; Wed, 17 Jun 2020 09:24:31
 +0100
Received: from GBR01-CWL-obe.outbound.protection.outlook.com (104.47.20.57) by
 smtpe1.intersmtp.com (62.239.224.236) with Microsoft SMTP Server
 (TLS) id 14.3.439.0; Wed, 17 Jun 2020 09:17:09 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C5bVYfRrC611f8jUJhRrBo3xuyuzz2FXwKmo4Fu+SHrEJgRonpaeqiGPIe4zZI/oQNIIIeeVAd9i0KnIbK3VgrMhroO/LrTPnDH68IBUhIIa1pv0GehwSOVFzni+5FEhbzie/XHdl69Cx+xtIdLhwFFwZ0aYw4WPA64jRVGBg1GSFcgJLWjPgFh1baUmiLdoXh70KV6ROZ8c2Tqi/gF4VCccu+bUeUjkhHOem4E6tPTN31oGY1i/JOwpnO2V+WtTPVUxT5CrKh8/0cXIgPdMvLJ/MEadSagzpNo2jMK4UCBb3vI8gY0YkA/tcdJFk3bz4tBLR3a8G00JvXOymsx+nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LeW+K9iboX3K97CORoAVE7xEbqqFwU8R2GcWPxX2ElM=;
 b=oTw/fi4YDwGbAwcqk8FK782O9WtiYM6yQei3J7G24lEBmfSpSexHyYIBBJqkCcgGpVzVt1S4L3X322xH2KVy/Rgn5gi8lc4Y/IBaHrW10Q3LRpEdyEzTrRQ5OtSWSBqEUuSZz8Brv+ry9OJmLEnoIvT19j6DdPfXLoo+6lhoIMyztctvzB13PfyF3czzn0PNZyzH0R9hfzKELG6sdNKKJRXNIfnjY9C+L5bsscUOrUP4t2Y7ezCQ4Lg9ZxTnBAOk0mjr8em3298IHaFiQX9sRAse4d2iMLwnqdapVQiJ33AwAbRltYEGoXKK2HfJe9/Z5RGrWiNzB/srRgT8iBfyrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bt.com; dmarc=pass action=none header.from=bt.com; dkim=pass
 header.d=bt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bt.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LeW+K9iboX3K97CORoAVE7xEbqqFwU8R2GcWPxX2ElM=;
 b=U8onlo2qYawVOF8m/vpfLufgQyzmRzAAQm0hiUIS4NEHf/62L0yFmPa7WaQgLOvhvOB34ZDV+YpDVBlffSp6O53SAX5nzXFI67t8cHUOP9F2ryJRWI9HJ3ZfJIQwzyzlAb4FrJpwmk/zzDe94XXIEM1nZXt3S919K1H3sGr20mQ=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bt.com;
Received: from CWXP123MB1958.GBRP123.PROD.OUTLOOK.COM (2603:10a6:401:7b::18)
 by CWXP123MB3255.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:43::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Wed, 17 Jun
 2020 08:24:27 +0000
Received: from CWXP123MB1958.GBRP123.PROD.OUTLOOK.COM
 ([fe80::e098:8c50:5b1e:6a1b]) by CWXP123MB1958.GBRP123.PROD.OUTLOOK.COM
 ([fe80::e098:8c50:5b1e:6a1b%7]) with mapi id 15.20.3109.021; Wed, 17 Jun 2020
 08:24:27 +0000
From: Jasper Lowell <jasper.lowell@bt.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH 1/8] hw/char/escc2: Add device
Date: Wed, 17 Jun 2020 18:23:55 +1000
Message-ID: <20200617082402.242631-2-jasper.lowell@bt.com>
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
 15.20.3109.21 via Frontend Transport; Wed, 17 Jun 2020 08:24:23 +0000
X-Mailer: git-send-email 2.26.2
X-Originating-IP: [185.128.24.45]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 66f3ef93-017a-40cc-bc86-08d81297d8e5
X-MS-TrafficTypeDiagnostic: CWXP123MB3255:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CWXP123MB3255BC608445B6278AF9A20C839A0@CWXP123MB3255.GBRP123.PROD.OUTLOOK.COM>
X-Antispam-2: 1
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-Forefront-PRVS: 04371797A5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: erQ5F5WdtW5u9Z+LIacYp7XWrc7o+7ZrvHdpKIhgc1p3mbLcuDoVaacblwW1pBlPAPiQbJ4yDwFR4QiZesVMbrAs16fq9L19q7L/7+q2YcYiJcHNpq1AgT9icxRUdWBxnHnfQI/JntlqtVgfzROol2MDe9oLF6zqE8Q+Lhcy86OJW7zX5tftWL2n3eJ+tDjBj1wK/HCWlEtun5nAmBWgLXN80TMGarNyr5foOpa9K5rHVuPS0fKLQ0wrVQL9esQIKorGB69bCfg4T0o4VHefidGoLv3ysr3yEQmoadXBk4Yw0BGmONCc3C2f9+kk8K7L50A+XZZ5b7zSHZYIXWj13/9OD3t4HSU3v3JtzrjTNLsAwC+1oSFQjWqZAq0/vNeK
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CWXP123MB1958.GBRP123.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(136003)(366004)(346002)(376002)(39860400002)(44832011)(1076003)(8676002)(2616005)(316002)(8936002)(6666004)(6486002)(956004)(2906002)(5660300002)(83380400001)(6506007)(69590400007)(26005)(6512007)(36756003)(6916009)(186003)(16526019)(478600001)(52116002)(66556008)(66476007)(4326008)(66946007)(30864003)(86362001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: ndODFv3llosAooUDnuxPH5gewvqfvgcCaBd/P/1gnMJ6T+a0M7tR1ESfGrQ0/q9LTSWVNZzxbS9+U0FUXt+3JQnq2I06CMWrXst1JErr91Zqp+akMnr4a5q1TJ46Y4JMBkIGfwfgp0GBI4H1xHjcelkyGrshaNm4xoA65oQazLabWjnoZHbTG9vULY3xZbB+lZTwKKjgSQnbTYgUm4t3c4Z7ID1KiSXL78MgmrReo5l/YOuBwfNmcNL0tppvWH6X2rh0hDmXBWWp+BCg8lXBLbFwYfTmFIJvUNAjy5DCEDZfQbPzRMLw8WLUVi5LU4e6UqaGMEvXOAb+3UZo4xpxtQnM7dkmo04L0ICmYI5QdnRjLJ4/vFutyEoCc24HPrLnmmMdrlEjpvqvXU2XrnNkhKpB1vQI5r3TUY2pjyxSKEbfzjbyaokLXQZ0ThRXehkEcGNO1qwZPQAWX7ojEALz7Yex30POk7b72BN7onxWTpI=
X-MS-Exchange-CrossTenant-Network-Message-Id: 66f3ef93-017a-40cc-bc86-08d81297d8e5
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2020 08:24:27.0426 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a7f35688-9c00-4d5e-ba41-29f146377ab0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 610y78Rc8SMxVJS8QEz+WNFZRAAajxuc0czSQKAChP3G9XWLtMfA3S70Oe5c372KjFdUuaBNKclLdzhNIKbKEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP123MB3255
X-OriginatorOrg: bt.com
Received-SPF: pass client-ip=213.121.35.79; envelope-from=jasper.lowell@bt.com;
 helo=smtpe1.intersmtp.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/17 04:24:32
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

The Ultra 5 (Darwin) machine that is emulated for the Sun4u architecture
ships with a SAB 82532 ESCC2 device that is used for providing the
default ttya/ttyb serial consoles. This device is introduced to
increment Sun4u emulation towards being hardware faithful. ISA support
is included so that the device can be attached to the Sun ebus.

Due to the complexity of the chip, the SAB 82532 ESCC2 is assumed to be
configured and used in the ASYNC serial mode. This is the case for
typical operating system drivers like those in Linux and OpenBSD.

While ASYNC serial mode is assumed, the implementation is designed with
the assumption that the full set of serial modes may be added at a later
date. Registers can not be represented as uint8_t when more than a
single serial mode is correctly implemented and so, the design avoids
assuming the data structure used for registers. Avoiding this assumption
leads to loops, rather than memset, along with a verbose switch case.
The verbose switch case also has the benefit of preemptively detangling
the jungle of features that the device supports.

Signed-off-by: Jasper Lowell <jasper.lowell@bt.com>
---
 hw/char/Kconfig         |   8 +
 hw/char/Makefile.objs   |   1 +
 hw/char/escc2.c         | 581 ++++++++++++++++++++++++++++++++++++++++
 hw/char/trace-events    |   4 +
 include/hw/char/escc2.h |  17 ++
 5 files changed, 611 insertions(+)
 create mode 100644 hw/char/escc2.c
 create mode 100644 include/hw/char/escc2.h

diff --git a/hw/char/Kconfig b/hw/char/Kconfig
index 40e7a8b8bb..87352a75d8 100644
--- a/hw/char/Kconfig
+++ b/hw/char/Kconfig
@@ -1,6 +1,14 @@
 config ESCC
     bool
 
+config ESCC2
+    bool
+
+config ESCC2_ISA
+    bool
+    depends on ISA_BUS
+    select ESCC2
+
 config PARALLEL
     bool
     default y
diff --git a/hw/char/Makefile.objs b/hw/char/Makefile.objs
index 9e9a6c1aff..fd4766fd36 100644
--- a/hw/char/Makefile.objs
+++ b/hw/char/Makefile.objs
@@ -1,5 +1,6 @@
 common-obj-$(CONFIG_IPACK) += ipoctal232.o
 common-obj-$(CONFIG_ESCC) += escc.o
+common-obj-$(CONFIG_ESCC2) += escc2.o
 common-obj-$(CONFIG_NRF51_SOC) += nrf51_uart.o
 common-obj-$(CONFIG_PARALLEL) += parallel.o
 common-obj-$(CONFIG_ISA_BUS) += parallel-isa.o
diff --git a/hw/char/escc2.c b/hw/char/escc2.c
new file mode 100644
index 0000000000..94528b8a4c
--- /dev/null
+++ b/hw/char/escc2.c
@@ -0,0 +1,581 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * QEMU Enhanced Serial Communication Controller (ESCC2 v3.2).
+ * Modelled according to the user manual (version 07.96).
+ *
+ * Copyright (C) 2020 Jasper Lowell
+ */
+
+#include "qemu/osdep.h"
+#include "hw/char/escc2.h"
+#include "hw/isa/isa.h"
+#include "hw/qdev-properties.h"
+#include "qapi/error.h"
+#include "sysemu/reset.h"
+#include "trace.h"
+
+/* STAR. */
+#define REGISTER_STAR_OFFSET                    0x20
+
+/* CMDR. */
+#define REGISTER_CMDR_OFFSET                    0x20
+
+/* MODE. */
+#define REGISTER_MODE_OFFSET                    0x22
+
+/* TIMR. */
+#define REGISTER_TIMR_OFFSET                    0x23
+
+/* XON. */
+#define REGISTER_XON_OFFSET                     0x24
+
+/* XOFF. */
+#define REGISTER_XOFF_OFFSET                    0x25
+
+/* TCR. */
+#define REGISTER_TCR_OFFSET                     0x26
+
+/* DAFO. */
+#define REGISTER_DAFO_OFFSET                    0x27
+
+/* RFC. */
+#define REGISTER_RFC_OFFSET                     0x28
+
+/* RBCL. */
+#define REGISTER_RBCL_OFFSET                    0x2a
+
+/* XBCL. */
+#define REGISTER_XBCL_OFFSET                    0x2a
+
+/* RBCH. */
+#define REGISTER_RBCH_OFFSET                    0x2b
+
+/* XBCH. */
+#define REGISTER_XBCH_OFFSET                    0x2b
+
+/* CCR0. */
+#define REGISTER_CCR0_OFFSET                    0x2c
+
+/* CCR1. */
+#define REGISTER_CCR1_OFFSET                    0x2d
+
+/* CCR2. */
+#define REGISTER_CCR2_OFFSET                    0x2e
+
+/* CCR3. */
+#define REGISTER_CCR3_OFFSET                    0x2f
+
+/* TSAX. */
+#define REGISTER_TSAX_OFFSET                    0x30
+
+/* TSAR. */
+#define REGISTER_TSAR_OFFSET                    0x31
+
+/* XCCR. */
+#define REGISTER_XCCR_OFFSET                    0x32
+
+/* RCCR. */
+#define REGISTER_RCCR_OFFSET                    0x33
+
+/* VSTR. */
+#define REGISTER_VSTR_OFFSET                    0x34
+
+/* BGR. */
+#define REGISTER_BGR_OFFSET                     0x34
+
+/* TIC. */
+#define REGISTER_TIC_OFFSET                     0x35
+
+/* MXN. */
+#define REGISTER_MXN_OFFSET                     0x36
+
+/* MXF. */
+#define REGISTER_MXF_OFFSET                     0x37
+
+/* GIS. */
+#define REGISTER_GIS_OFFSET                     0x38
+
+/* IVA. */
+#define REGISTER_IVA_OFFSET                     0x38
+
+/* IPC. */
+#define REGISTER_IPC_OFFSET                     0x39
+
+/* ISR0. */
+#define REGISTER_ISR0_OFFSET                    0x3a
+
+/* IMR0. */
+#define REGISTER_IMR0_OFFSET                    0x3a
+
+/* ISR1. */
+#define REGISTER_ISR1_OFFSET                    0x3b
+
+/* IMR1. */
+#define REGISTER_IMR1_OFFSET                    0x3b
+
+/* PVR. */
+#define REGISTER_PVR_OFFSET                     0x3c
+
+/* PIS. */
+#define REGISTER_PIS_OFFSET                     0x3d
+
+/* PIM. */
+#define REGISTER_PIM_OFFSET                     0x3d
+
+/* PCR. */
+#define REGISTER_PCR_OFFSET                     0x3e
+
+/* CCR4. */
+#define REGISTER_CCR4_OFFSET                    0x3f
+
+enum {
+    REGISTER_STAR = 0,
+    REGISTER_CMDR,
+    REGISTER_MODE,
+    REGISTER_TIMR,
+    REGISTER_XON,
+    REGISTER_XOFF,
+    REGISTER_TCR,
+    REGISTER_DAFO,
+    REGISTER_RFC,
+    REGISTER_RBCL,
+    REGISTER_XBCL,
+    REGISTER_RBCH,
+    REGISTER_XBCH,
+    REGISTER_CCR0,
+    REGISTER_CCR1,
+    REGISTER_CCR2,
+    REGISTER_CCR3,
+    REGISTER_TSAX,
+    REGISTER_TSAR,
+    REGISTER_XCCR,
+    REGISTER_RCCR,
+    REGISTER_VSTR,
+    REGISTER_BGR,
+    REGISTER_TIC,
+    REGISTER_MXN,
+    REGISTER_MXF,
+    REGISTER_GIS,
+    REGISTER_IVA,
+    REGISTER_IPC,
+    REGISTER_ISR0,
+    REGISTER_IMR0,
+    REGISTER_ISR1,
+    REGISTER_IMR1,
+    REGISTER_PVR,
+    REGISTER_PIS,
+    REGISTER_PIM,
+    REGISTER_PCR,
+    REGISTER_CCR4,
+    /* End. */
+    REGISTER_COUNT
+};
+
+typedef struct ESCC2State ESCC2State;
+
+#define CHANNEL_FIFO_LENGTH                     0x20
+typedef struct ESCC2ChannelState {
+    ESCC2State *controller;
+
+    /*
+     * The SAB 82532 ships with 64 byte FIFO queues for transmitting and
+     * receiving but only 32 bytes are addressable.
+     */
+    uint8_t fifo_receive[CHANNEL_FIFO_LENGTH];
+    uint8_t fifo_transmit[CHANNEL_FIFO_LENGTH];
+
+    uint8_t register_set[REGISTER_COUNT];
+} ESCC2ChannelState;
+
+#define CHANNEL_A_OFFSET                        0x0
+#define CHANNEL_B_OFFSET                        0x40
+#define CHANNEL_LENGTH                          0x40
+
+#define REGISTER_READ(channel, idx) \
+    ((channel)->register_set[(idx)])
+#define REGISTER_WRITE(channel, idx, value) \
+    ((channel)->register_set[(idx)] = (value))
+
+enum {
+    CHANNEL_A = 0,
+    CHANNEL_B,
+    /* End. */
+    CHANNEL_COUNT
+};
+
+struct ESCC2State {
+    DeviceState parent;
+
+    MemoryRegion io;
+    ESCC2ChannelState channel[CHANNEL_COUNT];
+};
+
+#define CONTROLLER_CHANNEL_A(controller) (&(controller)->channel[CHANNEL_A])
+#define CONTROLLER_CHANNEL_B(controller) (&(controller)->channel[CHANNEL_B])
+#define CHANNEL_CHAR(channel) \
+    ((channel) == CONTROLLER_CHANNEL_A((channel)->controller) ? 'A' : 'B')
+
+typedef struct ESCC2ISAState {
+    ISADevice parent;
+    uint32_t iobase;
+    struct ESCC2State controller;
+} ESCC2ISAState;
+
+static void escc2_channel_reset(ESCC2ChannelState *channel)
+{
+    unsigned int i;
+
+    memset(channel->fifo_receive, 0, sizeof(channel->fifo_receive));
+    memset(channel->fifo_transmit, 0, sizeof(channel->fifo_transmit));
+    for (i = 0; i < REGISTER_COUNT; i++) {
+        channel->register_set[i] = 0;
+    }
+
+    channel->register_set[REGISTER_STAR] = 0x40;
+    channel->register_set[REGISTER_VSTR] = 0x2;
+}
+
+static void escc2_reset(void *opaque)
+{
+    unsigned int i;
+    ESCC2State *controller = opaque;
+
+    for (i = 0; i < CHANNEL_COUNT; i++) {
+        escc2_channel_reset(&controller->channel[i]);
+    }
+}
+
+static uint64_t escc2_mem_read(void *opaque, hwaddr addr, unsigned size)
+{
+    uint8_t value, offset;
+    ESCC2State *controller;
+    ESCC2ChannelState *channel;
+
+    assert(addr < (CHANNEL_COUNT * CHANNEL_LENGTH));
+    assert(size == sizeof(uint8_t));
+
+    controller = opaque;
+    if (addr < CHANNEL_LENGTH) {
+        channel = CONTROLLER_CHANNEL_A(controller);
+        offset = addr;
+    } else {
+        channel = CONTROLLER_CHANNEL_B(controller);
+        offset = addr - CHANNEL_LENGTH;
+    }
+
+    switch (offset) {
+    case 0 ... (CHANNEL_FIFO_LENGTH - 1):
+        value = channel->fifo_receive[offset];
+        break;
+    case REGISTER_STAR_OFFSET:
+        value = REGISTER_READ(channel, REGISTER_STAR);
+        break;
+    case REGISTER_MODE_OFFSET:
+        value = REGISTER_READ(channel, REGISTER_MODE);
+        break;
+    case REGISTER_TIMR_OFFSET:
+        value = REGISTER_READ(channel, REGISTER_TIMR);
+        break;
+    case REGISTER_XON_OFFSET:
+        value = REGISTER_READ(channel, REGISTER_XON);
+        break;
+    case REGISTER_XOFF_OFFSET:
+        value = REGISTER_READ(channel, REGISTER_XOFF);
+        break;
+    case REGISTER_TCR_OFFSET:
+        value = REGISTER_READ(channel, REGISTER_TCR);
+        break;
+    case REGISTER_DAFO_OFFSET:
+        value = REGISTER_READ(channel, REGISTER_DAFO);
+        break;
+    case REGISTER_RFC_OFFSET:
+        value = REGISTER_READ(channel, REGISTER_RFC);
+        break;
+    case REGISTER_RBCL_OFFSET:
+        value = REGISTER_READ(channel, REGISTER_RBCL);
+        break;
+    case REGISTER_RBCH_OFFSET:
+        value = REGISTER_READ(channel, REGISTER_RBCH);
+        break;
+    case REGISTER_CCR0_OFFSET:
+        value = REGISTER_READ(channel, REGISTER_CCR0);
+        break;
+    case REGISTER_CCR1_OFFSET:
+        value = REGISTER_READ(channel, REGISTER_CCR1);
+        break;
+    case REGISTER_CCR2_OFFSET:
+        value = REGISTER_READ(channel, REGISTER_CCR2);
+        break;
+    case REGISTER_CCR3_OFFSET:
+        value = REGISTER_READ(channel, REGISTER_CCR3);
+        break;
+    case REGISTER_VSTR_OFFSET:
+        value = REGISTER_READ(channel, REGISTER_VSTR);
+        break;
+    case REGISTER_GIS_OFFSET:
+        value = REGISTER_READ(channel, REGISTER_GIS);
+        break;
+    case REGISTER_IPC_OFFSET:
+        value = REGISTER_READ(channel, REGISTER_IPC);
+        break;
+    case REGISTER_ISR0_OFFSET:
+        value = REGISTER_READ(channel, REGISTER_ISR0);
+        break;
+    case REGISTER_ISR1_OFFSET:
+        value = REGISTER_READ(channel, REGISTER_ISR1);
+        break;
+    case REGISTER_PVR_OFFSET:
+        value = REGISTER_READ(channel, REGISTER_PVR);
+        break;
+    case REGISTER_PIS_OFFSET:
+        value = REGISTER_READ(channel, REGISTER_PIS);
+        break;
+    case REGISTER_PCR_OFFSET:
+        value = REGISTER_READ(channel, REGISTER_PCR);
+        break;
+    case REGISTER_CCR4_OFFSET:
+        value = REGISTER_READ(channel, REGISTER_CCR4);
+        break;
+    default:
+        value = 0;
+        break;
+    }
+
+    trace_escc2_mem_read(CHANNEL_CHAR(channel), offset, value);
+    return value;
+}
+
+static void escc2_mem_write(void *opaque, hwaddr addr, uint64_t value,
+        unsigned size)
+{
+    uint8_t offset;
+    ESCC2State *controller;
+    ESCC2ChannelState *channel;
+
+    assert(addr < (CHANNEL_COUNT * CHANNEL_LENGTH));
+    assert(size == sizeof(uint8_t));
+    assert(value <= 0xff);
+
+    controller = opaque;
+    if (addr < CHANNEL_LENGTH) {
+        channel = CONTROLLER_CHANNEL_A(controller);
+        offset = addr;
+    } else {
+        channel = CONTROLLER_CHANNEL_B(controller);
+        offset = addr - CHANNEL_LENGTH;
+    }
+
+    switch (offset) {
+    case 0 ... (CHANNEL_FIFO_LENGTH - 1):
+        channel->fifo_transmit[offset] = value;
+        break;
+    case REGISTER_CMDR_OFFSET:
+        REGISTER_WRITE(channel, REGISTER_CMDR, value);
+        break;
+    case REGISTER_MODE_OFFSET:
+        REGISTER_WRITE(channel, REGISTER_MODE, value);
+        break;
+    case REGISTER_TIMR_OFFSET:
+        REGISTER_WRITE(channel, REGISTER_TIMR, value);
+        break;
+    case REGISTER_XON_OFFSET:
+        REGISTER_WRITE(channel, REGISTER_XON, value);
+        break;
+    case REGISTER_XOFF_OFFSET:
+        REGISTER_WRITE(channel, REGISTER_XOFF, value);
+        break;
+    case REGISTER_TCR_OFFSET:
+        REGISTER_WRITE(channel, REGISTER_TCR, value);
+        break;
+    case REGISTER_DAFO_OFFSET:
+        REGISTER_WRITE(channel, REGISTER_DAFO, value);
+        break;
+    case REGISTER_RFC_OFFSET:
+        REGISTER_WRITE(channel, REGISTER_RFC, value);
+        break;
+    case REGISTER_XBCL_OFFSET:
+        REGISTER_WRITE(channel, REGISTER_XBCL, value);
+        break;
+    case REGISTER_XBCH_OFFSET:
+        REGISTER_WRITE(channel, REGISTER_XBCH, value);
+        break;
+    case REGISTER_CCR0_OFFSET:
+        REGISTER_WRITE(channel, REGISTER_CCR0, value);
+        break;
+    case REGISTER_CCR1_OFFSET:
+        REGISTER_WRITE(channel, REGISTER_CCR1, value);
+        break;
+    case REGISTER_CCR2_OFFSET:
+        REGISTER_WRITE(channel, REGISTER_CCR2, value);
+        break;
+    case REGISTER_CCR3_OFFSET:
+        REGISTER_WRITE(channel, REGISTER_CCR3, value);
+        break;
+    case REGISTER_TSAX_OFFSET:
+        REGISTER_WRITE(channel, REGISTER_TSAX, value);
+        break;
+    case REGISTER_TSAR_OFFSET:
+        REGISTER_WRITE(channel, REGISTER_TSAR, value);
+        break;
+    case REGISTER_XCCR_OFFSET:
+        REGISTER_WRITE(channel, REGISTER_XCCR, value);
+        break;
+    case REGISTER_RCCR_OFFSET:
+        REGISTER_WRITE(channel, REGISTER_RCCR, value);
+        break;
+    case REGISTER_BGR_OFFSET:
+        REGISTER_WRITE(channel, REGISTER_BGR, value);
+        break;
+    case REGISTER_TIC_OFFSET:
+        REGISTER_WRITE(channel, REGISTER_TIC, value);
+        break;
+    case REGISTER_MXN_OFFSET:
+        REGISTER_WRITE(channel, REGISTER_MXN, value);
+        break;
+    case REGISTER_MXF_OFFSET:
+        REGISTER_WRITE(channel, REGISTER_MXF, value);
+        break;
+    case REGISTER_IVA_OFFSET:
+        REGISTER_WRITE(CONTROLLER_CHANNEL_A(controller), REGISTER_IVA, value);
+        REGISTER_WRITE(CONTROLLER_CHANNEL_B(controller), REGISTER_IVA, value);
+        break;
+    case REGISTER_IPC_OFFSET:
+        REGISTER_WRITE(CONTROLLER_CHANNEL_A(controller), REGISTER_IPC, value);
+        REGISTER_WRITE(CONTROLLER_CHANNEL_B(controller), REGISTER_IPC, value);
+        break;
+    case REGISTER_IMR0_OFFSET:
+        REGISTER_WRITE(channel, REGISTER_IMR0, value);
+        break;
+    case REGISTER_IMR1_OFFSET:
+        REGISTER_WRITE(channel, REGISTER_IMR1, value);
+        break;
+    case REGISTER_PVR_OFFSET:
+        REGISTER_WRITE(channel, REGISTER_PVR, value);
+        break;
+    case REGISTER_PIM_OFFSET:
+        REGISTER_WRITE(CONTROLLER_CHANNEL_A(controller), REGISTER_PIM, value);
+        REGISTER_WRITE(CONTROLLER_CHANNEL_B(controller), REGISTER_PIM, value);
+        break;
+    case REGISTER_PCR_OFFSET:
+        REGISTER_WRITE(CONTROLLER_CHANNEL_A(controller), REGISTER_PCR, value);
+        REGISTER_WRITE(CONTROLLER_CHANNEL_B(controller), REGISTER_PCR, value);
+        break;
+    case REGISTER_CCR4_OFFSET:
+        REGISTER_WRITE(channel, REGISTER_CCR4, value);
+        break;
+    default:
+        /* Registers do not exhaustively cover the addressable region. */
+        break;
+    }
+
+    trace_escc2_mem_write(CHANNEL_CHAR(channel), offset, value);
+}
+
+static void escc2_realize(DeviceState *dev, Error **errp)
+{
+    unsigned int i;
+    ESCC2ChannelState *channel;
+    ESCC2State *controller = ESCC2(dev);
+
+    for (i = 0; i < CHANNEL_COUNT; i++) {
+        channel = &controller->channel[i];
+        channel->controller = controller;
+    }
+
+    qemu_register_reset(escc2_reset, controller);
+    escc2_reset(controller);
+}
+
+const MemoryRegionOps escc2_mem_ops = {
+    .read = escc2_mem_read,
+    .write = escc2_mem_write,
+    .impl = {
+        .min_access_size = 1,
+        .max_access_size = 1
+    },
+    .endianness = DEVICE_LITTLE_ENDIAN,
+};
+
+static void escc2_isa_realize(DeviceState *dev, Error **errp)
+{
+    ESCC2ISAState *isa = ESCC2_ISA(dev);
+    ESCC2State *controller = &isa->controller;
+
+    if (isa->iobase == -1) {
+        error_setg(errp, "Base address must be provided.");
+        return;
+    }
+
+    object_property_set_bool(OBJECT(controller), true, "realized", errp);
+    if (*errp) {
+        return;
+    }
+
+    memory_region_init_io(&controller->io, OBJECT(dev), &escc2_mem_ops,
+            controller, "escc2", CHANNEL_COUNT * CHANNEL_LENGTH);
+    isa_register_ioport(ISA_DEVICE(dev), &controller->io, isa->iobase);
+}
+
+static void escc2_unrealize(DeviceState *dev)
+{
+    ESCC2State *controller = ESCC2(dev);
+    qemu_unregister_reset(escc2_reset, controller);
+}
+
+static void escc2_isa_instance_init(Object *o)
+{
+    ESCC2ISAState *self = ESCC2_ISA(o);
+    object_initialize_child(o, "escc2", &self->controller,
+            sizeof(self->controller), TYPE_ESCC2, &error_abort, NULL);
+    qdev_alias_all_properties(DEVICE(&self->controller), o);
+}
+
+static Property escc2_properties[] = {
+    DEFINE_PROP_END_OF_LIST()
+};
+
+static Property escc2_isa_properties[] = {
+    DEFINE_PROP_UINT32("iobase", ESCC2ISAState, iobase, -1),
+    DEFINE_PROP_END_OF_LIST()
+};
+
+static void escc2_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->user_creatable = false;
+    dc->realize = escc2_realize;
+    dc->unrealize = escc2_unrealize;
+    device_class_set_props(dc, escc2_properties);
+}
+
+static void escc2_isa_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    device_class_set_props(dc, escc2_isa_properties);
+    dc->realize = escc2_isa_realize;
+}
+
+static const TypeInfo escc2_info = {
+    .name = TYPE_ESCC2,
+    .parent = TYPE_DEVICE,
+    .instance_size = sizeof(ESCC2State),
+    .class_init = escc2_class_init
+};
+
+static const TypeInfo escc2_isa_info = {
+    .name = TYPE_ESCC2_ISA,
+    .parent = TYPE_ISA_DEVICE,
+    .instance_size = sizeof(ESCC2ISAState),
+    .instance_init = escc2_isa_instance_init,
+    .class_init = escc2_isa_class_init
+};
+
+static void escc2_types(void)
+{
+    type_register_static(&escc2_info);
+    type_register_static(&escc2_isa_info);
+}
+
+type_init(escc2_types);
diff --git a/hw/char/trace-events b/hw/char/trace-events
index d20eafd56f..65c176f582 100644
--- a/hw/char/trace-events
+++ b/hw/char/trace-events
@@ -56,6 +56,10 @@ escc_sunkbd_event_out(int ch) "Translated keycode 0x%2.2x"
 escc_kbd_command(int val) "Command %d"
 escc_sunmouse_event(int dx, int dy, int buttons_state) "dx=%d dy=%d buttons=0x%01x"
 
+# escc2.c
+escc2_mem_read(char channel, uint32_t addr, uint8_t value) "channel %c addr 0x%x value 0x%x"
+escc2_mem_write(char channel, uint32_t addr, uint8_t value) "channel %c addr 0x%x value 0x%x"
+
 # pl011.c
 pl011_irq_state(int level) "irq state %d"
 pl011_read(uint32_t addr, uint32_t value) "addr 0x%08x value 0x%08x"
diff --git a/include/hw/char/escc2.h b/include/hw/char/escc2.h
new file mode 100644
index 0000000000..ca2e34da3f
--- /dev/null
+++ b/include/hw/char/escc2.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * QEMU Enhanced Serial Communication Controller (ESCC2 v3.2).
+ * Modelled according to the user manual (version 07.96).
+ *
+ * Copyright (C) 2020 Jasper Lowell
+ */
+#ifndef HW_ESCC2_H
+#define HW_ESCC2_H
+
+#define TYPE_ESCC2      "ESCC2"
+#define ESCC2(obj)      OBJECT_CHECK(ESCC2State, (obj), TYPE_ESCC2)
+
+#define TYPE_ESCC2_ISA  "ESCC2_ISA"
+#define ESCC2_ISA(obj)  OBJECT_CHECK(ESCC2ISAState, (obj), TYPE_ESCC2_ISA)
+
+#endif /* HW_ESCC2_H */
-- 
2.26.2


