Return-Path: <SRS0=JoQ+=DX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AE1AC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 15:07:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEE5F20829
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 15:07:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=emdalo.onmicrosoft.com header.i=@emdalo.onmicrosoft.com header.b="ByGpHuxS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEE5F20829
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=emdalo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43964 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTRJy-0001nW-M1
	for qemu-devel@archiver.kernel.org; Fri, 16 Oct 2020 11:07:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44850)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ivan.griffin@emdalo.com>)
 id 1kTOzp-0008TR-79; Fri, 16 Oct 2020 08:38:09 -0400
Received: from mail-eopbgr70082.outbound.protection.outlook.com
 ([40.107.7.82]:1766 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ivan.griffin@emdalo.com>)
 id 1kTOzh-00014u-7G; Fri, 16 Oct 2020 08:38:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dv9x+ADiBufKG/8zlUfXXp9dP6bSe4VXPuGuDCTWJD3zFvu3lkix07laRbdC0RT8PJFMkqI0IDNfl/jEN0UH3+pmf7rQbr29qhI4RXWv8gtLYSVMmahEL4vTjHeG5bp7rIc2cstN1tFiJrZb7wyVW/7pmFII1euwHjzlWuTkniOcpBEyYkbdDCZAkG2pMoea7zdeajJLVicpnW10tbqtsBMLwIfDYl/JFcLMPLL8Ct/uGStRKbJ+8LoQ28WyXIGgI+X6owssb25xqHhKTJGFPW3/+IMtE452jHeN0qOo90rCo5f0v2LgTf4whjhRTkQfbsU9ljU3cEuyujYnndRErg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XfOYkqxZ7soirJo/8S5nX54XGbmfW78N9DrtyaTF5v4=;
 b=mAewWRBwYVaq8J/VeT+Aat6QcZqmcyLqLF/TwCG+9nrL84e04fTYSLIEbjMCFiZSdDOcr/WLCyRzRJQacJ5zcsn/lY7ipBAoQ3PxLY9w2YyoDA+DUfYKXPFhWOzd2ayrFF+1RUvIehhSQjz45Oc8Z3vtgcoSqvd6mawUqus8OJboDP3ByV35d8IhtI9mU7hdE38G5OHPNUR+Fn/rAxnnGj9KMs9FDQ8tMcb9S55tagFcZZ5nQARWECOcVTsTTE/7s2ReAxoJHJCSmQfIsIo2ifhg85piNjRtuEJ+cZiP861jK3zY3bpTxNQfvnCyjCH92AsAwuC+eQTePyIZ2IzMNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=emdalo.com; dmarc=pass action=none header.from=emdalo.com;
 dkim=pass header.d=emdalo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=emdalo.onmicrosoft.com; s=selector2-emdalo-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XfOYkqxZ7soirJo/8S5nX54XGbmfW78N9DrtyaTF5v4=;
 b=ByGpHuxS/xaq/Ms1jscMopvVGXS/XJyE+5vx2aK5Qr9EPmM/0sC9TvHiy0M8rgp1TJI+Wmo8hfj3HGSKAmJVfPcBtsyzyXVcOuhS6cBzAfYEtNlg5IfD2/R2j27Eg4/qrjIrFXBpVUKg7dgLYQSEATazV8D9I5NIU9zO0iqgH9U=
Authentication-Results: windriver.com; dkim=none (message not signed)
 header.d=none;windriver.com; dmarc=none action=none header.from=emdalo.com;
Received: from DB7PR10MB1915.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:5:e::24) by
 DBAPR10MB4297.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:1cf::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.25; Fri, 16 Oct 2020 12:37:49 +0000
Received: from DB7PR10MB1915.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2cbe:c29d:d77f:e65f]) by DB7PR10MB1915.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2cbe:c29d:d77f:e65f%7]) with mapi id 15.20.3477.021; Fri, 16 Oct 2020
 12:37:49 +0000
From: Ivan Griffin <ivan.griffin@emdalo.com>
To: Bin Meng <bin.meng@windriver.com>
Subject: [PATCH] hw/riscv: microchip_pfsoc: IOSCBCTRL memmap entry
Date: Fri, 16 Oct 2020 13:37:37 +0100
Message-Id: <20201016123737.8118-1-ivan.griffin@emdalo.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-Originating-IP: [86.45.25.24]
X-ClientProxiedBy: LO2P265CA0134.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9f::26) To DB7PR10MB1915.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:5:e::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from igriffin-HP-EliteBook-840-G3.emdalo.com (86.45.25.24) by
 LO2P265CA0134.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:9f::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.21 via Frontend Transport; Fri, 16 Oct 2020 12:37:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 314000d7-d37b-4fa2-69db-08d871d04ad9
X-MS-TrafficTypeDiagnostic: DBAPR10MB4297:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DBAPR10MB4297D06CD4FDFAE9A19D04A7FE030@DBAPR10MB4297.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:541;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UO0B9F7TRNewCNdVtuf8w0nK43ONEG60dNKNSSIP1XSAYHh+slRaeBr+xwoFn7g/gWAlc4XhAVKd5qa1nrn1DNvEAd8+IUyE6QAWpup/+24aGxHq/fTLrCGZNMckrLcoKijoo2/eLSl/ypmGoHVDIn5n42POSFkEhrDC21AvANa+BHNdVxwoECCT4uc3YUhRMUQjumSgEIKUTfYy3yB6km/k/0XaJdxDeCEZEM60OYh+b1lyKHw4Q52mobQvYL9boe+uE2Pi4AxN0E2cxb4104iq8P8+GO728Gk57JdmH+ayu/fiIi3c+zU6/SPgWULupFoMBkMuV29GHIT3fZd4zQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB7PR10MB1915.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(366004)(39830400003)(376002)(396003)(136003)(346002)(66476007)(1076003)(66556008)(8936002)(6666004)(2906002)(4326008)(66946007)(186003)(86362001)(16526019)(478600001)(2616005)(36756003)(6486002)(8676002)(956004)(316002)(5660300002)(44832011)(107886003)(26005)(52116002)(83380400001)(7696005)(6916009);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: AHxqO59OyfpIREL/79OFV3wWPwMiUYIunpHul8OVb9/pIZwqBkTL/3CWmniZOA+Vzd2YwBCjQ+PmJgp8SmTYn9+dwPX62bP7tTCqneROS5kSPXnjKYw3JbhqEUJaqhqNRsHw9HhjPVHd4iSaFucYrgpmqQtvnv55qozS5mNrgpomWByWe2cbPN/rJb95gfJrah9vXjrtcgQyjjI2RAmjcNyLCMCE73mWGnzoka56OK6+54PtF2ek0mUpu4eL1Xd3BL0E8JduOIumNPFs30zjc8ygG3huNjr3eo8YQWbLkyfjhodhjnmBbT59wx6pOBWRiuEB6OOTpPIa1/eic9sYqqk+kGNGun0BudTQ7/AmgTEMVZ80NP9Q1KnONxvrvz8ylzcs6cfmCNjY+nJ8NNS1AzJ3+hBj7D7z1XtyXOWOyh+Fjrm0pUARRYhlJcrG3l4gKk4NhIXDhP0B9Z4e7wnWS77XvOLkO6ZMgO+Z+TAHCoKhuoFQX6NSUdSHre2J5a0Rcu6H2WpkUGq6oA46l9qOOuH+5gUihj9E5J18jVulcjzMCPYnANAL8ryqH3PuitbIfnKrlamRBgVNzB5hM6DpMAMtTZ3VloUwgRSLtjK/umlmBApY25ozfZOKWo3B2J9p
X-OriginatorOrg: emdalo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 314000d7-d37b-4fa2-69db-08d871d04ad9
X-MS-Exchange-CrossTenant-AuthSource: DB7PR10MB1915.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2020 12:37:49.7372 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 12485e48-c3f6-4e74-8f2d-9058be9b6951
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W9ufdQ85wClp5jrvSSLhBEWtnrCcgKV0qa6yRMyy9zkW1+0Ts0ZVFX4r566HgLd8fbHf+ExmKnC6bU2jp+60gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR10MB4297
Received-SPF: pass client-ip=40.107.7.82; envelope-from=ivan.griffin@emdalo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/16 08:37:56
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 16 Oct 2020 10:59:30 -0400
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
 hw/riscv/microchip_pfsoc.c         | 6 ++++++
 include/hw/riscv/microchip_pfsoc.h | 1 +
 2 files changed, 7 insertions(+)

diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
index 4627179cd3..20e1496e3e 100644
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
@@ -341,6 +342,11 @@ static void microchip_pfsoc_soc_realize(DeviceState *dev, Error **errp)
     create_unimplemented_device("microchip.pfsoc.ioscb.cfg",
         memmap[MICROCHIP_PFSOC_IOSCB_CFG].base,
         memmap[MICROCHIP_PFSOC_IOSCB_CFG].size);
+
+    /* IOSCBCTRL */
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


