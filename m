Return-Path: <SRS0=JoQ+=DX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D63F3C433E7
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 17:13:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D24292084C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 17:13:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=emdalo.onmicrosoft.com header.i=@emdalo.onmicrosoft.com header.b="AxiRf0TM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D24292084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=emdalo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41386 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTTHo-00044q-AA
	for qemu-devel@archiver.kernel.org; Fri, 16 Oct 2020 13:13:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34928)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ivan.griffin@emdalo.com>)
 id 1kTTFH-000244-M1; Fri, 16 Oct 2020 13:10:23 -0400
Received: from mail-eopbgr10041.outbound.protection.outlook.com
 ([40.107.1.41]:44923 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ivan.griffin@emdalo.com>)
 id 1kTTFC-00075n-4Q; Fri, 16 Oct 2020 13:10:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nJGTBS3I4ARvwOVzy5wRxI9PtcwFXJPa4ZYDz8LVyfHmY1OF3slpr3Zq0ncR1ERVFOHG31QXl4FKWpuY/0dTEipkGa/3vtX9eTBn5S9Q1OU2aPgZjFICYjbPTz+4zGOF2zSfTJy/b6nW2gFHGkXSiVwTUd/BPwnMJ1wE9S0JOzAz3HXH930RltWvKJbZnfQN4jJ0F1ydHWZnZIGrdFSqiFCL6b9xts+ldOjUYRKUTu49PQ8B+zAkSauWZGx3SkdepitfLENjjPtYtIDiJe8yjFA9c8kwdrAp6PZJNp78ZbNBGJSOS5Pq7B7jI02UxVZ0os3x3L086ncNfQM0CB73iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pGertfte/FSkq0JSXR2swaiNwp7//1TX1TrcmKo2c30=;
 b=ArI32pJiIM2iHWR6Rzj83kSzOqusIliEQjRiLgE8Qrw2xdo8qqDVSQdLeWvhJ2HWmT9pVTOsyK8sBv78rRUSDiCWo+9BoMzOPRc/oMA0aJSHrywVHsCxt49/3s5RxykRYOVaZ0zAWc5vj+VtPyakQKzfWk2F1nJVsGieLGKr13wVy+NptoZAT8K9VthLXd6sfVLfhZqMS9JamGoASnneJSTl8rXu5gWsCiCllXIE9KT4wdeNJvzqSWZ9QcZ33V8LHVptHOfYkdROITCaEPWYPEt/YCp9VtmK2OvOCkLVRxFsxFJlsgtntboj31rhBObGNRkJvJZR539U5yssXDdiyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=emdalo.com; dmarc=pass action=none header.from=emdalo.com;
 dkim=pass header.d=emdalo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=emdalo.onmicrosoft.com; s=selector2-emdalo-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pGertfte/FSkq0JSXR2swaiNwp7//1TX1TrcmKo2c30=;
 b=AxiRf0TMpFrIaXFqCfQAKduS1ZmuII8iuA7Qm3CuIWG17A388Cnt9vAT5vGtgQ25On49UJRoCQita3pu5be7lZ5CyActaG6alGZN4vVRUPPUJVunrQUPhS3yTRW8aetT6GmucFx8U1I5yAskWIepQMl9T9DPwMcVZ53t8sYOmp0=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=emdalo.com;
Received: from DB7PR10MB1915.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:5:e::24) by
 DB6PR1001MB1384.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:4:b4::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.22; Fri, 16 Oct 2020 17:10:12 +0000
Received: from DB7PR10MB1915.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2cbe:c29d:d77f:e65f]) by DB7PR10MB1915.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2cbe:c29d:d77f:e65f%7]) with mapi id 15.20.3477.021; Fri, 16 Oct 2020
 17:10:12 +0000
From: Ivan Griffin <ivan.griffin@emdalo.com>
To: Alistair Francis <alistair23@gmail.com>
Subject: [PATCH v2] hw/riscv: microchip_pfsoc: IOSCBCTRL memmap entry
Date: Fri, 16 Oct 2020 18:10:00 +0100
Message-Id: <20201016171000.21240-1-ivan.griffin@emdalo.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CAKmqyKODEgnkw4zBbsNK1zQ7qaiKWEAZBpwhnHzEetjgWpxtzQ@mail.gmail.com>
References: <CAKmqyKODEgnkw4zBbsNK1zQ7qaiKWEAZBpwhnHzEetjgWpxtzQ@mail.gmail.com>
Content-Type: text/plain
X-Originating-IP: [86.45.25.24]
X-ClientProxiedBy: LO2P265CA0070.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:60::34) To DB7PR10MB1915.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:5:e::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from igriffin-HP-EliteBook-840-G3.emdalo.com (86.45.25.24) by
 LO2P265CA0070.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:60::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.21 via Frontend Transport; Fri, 16 Oct 2020 17:10:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e853ed02-f2e0-449e-f467-08d871f65789
X-MS-TrafficTypeDiagnostic: DB6PR1001MB1384:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB6PR1001MB13842A9BEEDDCBF01168C773FE030@DB6PR1001MB1384.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qTgIsv2YM74BbqiYHFAC0weLfmtOmyuDenzEuzKx+/6Qt4mWfcl8UdW1h3k60eOOhX9D7i7+vMYdyhe75I2+ZM2ScY8KTHare8Q9SMzlFkbi/c9nSfX0vu6t5tRjnVcsLb1ooBx2KavcSc7UKPIpL5PEcH8MbaPAdalcIco5gZZGK1oeX/tfErQ/G53h2aWgccPT4IPH/zRYxF7je6lW9iSGDk4PVCrwLm63LkA04EouYFYDv1nBBvbt6nClqLmThwNvWODtmuP/yQKelYKu5XpZrFMCSdtndJlcNLyghro4lgmAWw5TOrvO0iETAemwCnLnU3ZudGkvMrSJIXuYdA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB7PR10MB1915.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(346002)(136003)(39830400003)(396003)(376002)(366004)(36756003)(83380400001)(8936002)(26005)(5660300002)(16526019)(44832011)(478600001)(86362001)(186003)(6486002)(316002)(2616005)(6666004)(956004)(2906002)(107886003)(1076003)(66476007)(52116002)(66946007)(6916009)(8676002)(7696005)(66556008)(4326008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: XLrF2lhFHH55m/U6hZBmMcwdNZHVaAP02GEaicCcXna56KTK9hxvC/SfIyIgOft5F9QN37PjocNDSXZK0I/3pJUkYheBAVEVgo+LyDf+o66FWTR7UqRZAdj13Ar9H4Cj7mMlvT5hhhwAY/lqsuY9IfHlRZb3HOhkOnsIirHLVQyrsM17BUlKXPRsPJcv9K7QOVuNYyzxSjkQs1fkgWMMM7w8nNRpE5GU4+pBz13M/o1PpVIlO49H/MpIKCNwL6d2zaWGCYhHjQsZbSPN2uJAiXB4uxY3Y15VEvMHwf+z+1AYB34YkUgEms7FjnTlM+kDop5No1Wk51DueIFF9mV9rWTTlDJG9Y2uuwiQgq4cjKoY5S8SUCn9UKyLpUikgG01t0PdRWzPnTIjdWP5864E5FEhVYySslugGBbPRcIPHmgASMFWpLJgpH+a/Uj0B0slf8kxRm7CJDuahoR1ADM+OP/k6rOHMLEnS67M/pQmv4o8rdapnPxXfx8/88jaiAGSUQ6+51L8bikwG0Ew7jPZs2c5CP7nvIwt5Dgcb3r52yCzFwGo35RAlpSJ5+k7UJcEtJb1GmmnBu4YvrJpOZ+XTXqkPEDUPgLPCfm2jCbw308P0Mb8mXa778OQaqjgjGTmhDxF5gNDC10uWs58NF72WA==
X-OriginatorOrg: emdalo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e853ed02-f2e0-449e-f467-08d871f65789
X-MS-Exchange-CrossTenant-AuthSource: DB7PR10MB1915.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2020 17:10:11.9646 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 12485e48-c3f6-4e74-8f2d-9058be9b6951
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: duvAZCYtaMZ6MiDcvA5nvziaJpYvmuzLnRwg2JjjR6R1uc47+aVHmqsIenelQGbVs4xup3Ohi7UCu5y1IDuffA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR1001MB1384
Received-SPF: pass client-ip=40.107.1.41; envelope-from=ivan.griffin@emdalo.com;
 helo=EUR02-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/16 13:10:13
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
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
Cc: qemu-trivial@nongnu.org, qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 ivan.griffin@emdalo.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Adding the PolarFire SoC IOSCBCTRL memory region to prevent QEMU
reporting a STORE/AMO Access Fault.

This region is used by the PolarFire SoC port of U-Boot to
interact with the FPGA system controller.

Signed-off-by: Ivan Griffin <ivan.griffin@emdalo.com>
---
 hw/riscv/microchip_pfsoc.c         | 10 ++++++++++
 include/hw/riscv/microchip_pfsoc.h |  1 +
 2 files changed, 11 insertions(+)

diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
index 4627179cd3..9aaa276ee2 100644
--- a/hw/riscv/microchip_pfsoc.c
+++ b/hw/riscv/microchip_pfsoc.c
@@ -97,6 +97,7 @@ static const struct MemmapEntry {
     [MICROCHIP_PFSOC_GPIO2] =           { 0x20122000,     0x1000 },
     [MICROCHIP_PFSOC_ENVM_CFG] =        { 0x20200000,     0x1000 },
     [MICROCHIP_PFSOC_ENVM_DATA] =       { 0x20220000,    0x20000 },
+    [MICROCHIP_PFSOC_IOSCB_CTRL] =      { 0x37020000,     0x1000 },
     [MICROCHIP_PFSOC_IOSCB_CFG] =       { 0x37080000,     0x1000 },
     [MICROCHIP_PFSOC_DRAM] =            { 0x80000000,        0x0 },
 };
@@ -341,6 +342,15 @@ static void microchip_pfsoc_soc_realize(DeviceState *dev, Error **errp)
     create_unimplemented_device("microchip.pfsoc.ioscb.cfg",
         memmap[MICROCHIP_PFSOC_IOSCB_CFG].base,
         memmap[MICROCHIP_PFSOC_IOSCB_CFG].size);
+
+    /* IOSCBCTRL
+     *
+     * These registers are not documented in the official documentation
+     * but used by the polarfire-soc-bare-meta-library code
+     */
+    create_unimplemented_device("microchip.pfsoc.ioscb.ctrl",
+        memmap[MICROCHIP_PFSOC_IOSCB_CTRL].base,
+        memmap[MICROCHIP_PFSOC_IOSCB_CTRL].size);
 }
 
 static void microchip_pfsoc_soc_class_init(ObjectClass *oc, void *data)
diff --git a/include/hw/riscv/microchip_pfsoc.h b/include/hw/riscv/microchip_pfsoc.h
index 8bfc7e1a85..3f1874b162 100644
--- a/include/hw/riscv/microchip_pfsoc.h
+++ b/include/hw/riscv/microchip_pfsoc.h
@@ -95,6 +95,7 @@ enum {
     MICROCHIP_PFSOC_ENVM_CFG,
     MICROCHIP_PFSOC_ENVM_DATA,
     MICROCHIP_PFSOC_IOSCB_CFG,
+    MICROCHIP_PFSOC_IOSCB_CTRL,
     MICROCHIP_PFSOC_DRAM,
 };
 
-- 
2.17.1


