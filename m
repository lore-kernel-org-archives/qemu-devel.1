Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BE60C4363A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 17:32:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 436AA20663
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 17:32:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="Lc9txfaE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 436AA20663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59550 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYBn8-0000M5-KE
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 13:32:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39974)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kYBkJ-0006MM-He
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 13:29:55 -0400
Received: from mail-mw2nam12on2122.outbound.protection.outlook.com
 ([40.107.244.122]:48737 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kYBkI-00053E-43
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 13:29:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FwjZGJVjvWmE27ffK99Cqk2rGKMKvHAySY1Oj5LIEqZiqKw4Vy7U3gl2UJtJAHYZA2SQP0ds5F1uJBpV+ejyJfcGZlnodl42Mj+zebL/grgNyaURvKsFsuVqT+Ux4OTXhIZgJwN+E8oNS523QPB1rh058CSQ2wM92ONQK73Pnr9MlRcIWouxq2pBPh+nMHdPhToxQXIwgi+w3R5sJySLUFqLx3d5xuiUcNtXFJXt0KxGo94IUcxQNm2zfuwI/ZhkeXarihoZNI8LPFcf5ar9R4rP82BpO7FhJ7NTf6zUPyHTj3x8hpxw8HtmPlItXdjc12tfKjRr3OQbJI+CMzsQzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9voDsl/wX3BDjEUQwe4C2jvIyxKGmVVyH5HHyo1XYNA=;
 b=bHNGlMk8N5S+Ao0nHUIeLHN/TeMGshNTf4qtnyWAlR/gx3QYelnCWS8hP53uFC1ynYxwt2gw5Pl4OXPl8BoX9bCJ0INJizpGzxIk0FJQhUrfrkkfTGJfhIttfs3MJdrA3Hi0GAcci1j1kITXv/CoaAfNlWh2NALd0EdfWoNUbQfHT9DhrlPGPGi0HlxD4xqrHU8DzxojIJTHv7fa0gPRmbtNcJBjRARUf/9Lw+8ZlT/mAfLarmB0w5WDlM2tEBOZbsRweZcJ+xFhkxGyDD60euJ0N3AkmOsFLUB7mRruY5CePbh74lyhhnikUxEb9sUzIdQPvqq2qJ8jdb14rCcsUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9voDsl/wX3BDjEUQwe4C2jvIyxKGmVVyH5HHyo1XYNA=;
 b=Lc9txfaEvHSCzgHsoT0JXr80lP4O8ty7dDc8FxZsl13hl7i9uP0KjaA9toKaLcgZE9nCol3NV5JIlSmhuYBoM0UitvPYTz+HrrVO2P9IsY3FKZmfADD57W4w9JaIVqmJRdoG25KnmrLyIud2o2fD2q4tR1fHwnc8qbt42L+A9lY=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bu.edu;
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SA0PR03MB5531.namprd03.prod.outlook.com (2603:10b6:806:bd::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21; Thu, 29 Oct
 2020 17:29:17 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::d520:4c19:8ce6:7db2]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::d520:4c19:8ce6:7db2%2]) with mapi id 15.20.3499.027; Thu, 29 Oct 2020
 17:29:17 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.2 2/3] fuzz: check the MR in the DMA callback
Date: Thu, 29 Oct 2020 13:28:59 -0400
Message-Id: <20201029172901.534442-3-alxndr@bu.edu>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201029172901.534442-1-alxndr@bu.edu>
References: <20201029172901.534442-1-alxndr@bu.edu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [72.93.72.163]
X-ClientProxiedBy: BL0PR01CA0005.prod.exchangelabs.com (2603:10b6:208:71::18)
 To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from stormtrooper.vrmnet (72.93.72.163) by
 BL0PR01CA0005.prod.exchangelabs.com (2603:10b6:208:71::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18 via Frontend Transport; Thu, 29 Oct 2020 17:29:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2957fd58-50d6-4f0e-e3f2-08d87c30294c
X-MS-TrafficTypeDiagnostic: SA0PR03MB5531:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR03MB553190D5A2B2AEBEF1DF6415BA140@SA0PR03MB5531.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4av53vgce0n0S7cUPc3sjvddI7GI+SUgTAtQSE6ZVfOP0MwPs40ftH+DmqiqQc04pNumyxwb2+WppjVSKfJ4hnCYosQstRMPrscnzJpbfj4cKgXVpA+oZ3GsWyNSgPTZWnVedmsXe1Ldkn2A6ZhQkvcxFDX+TIobsJC/aH6Lnquax4vEPMHQ+RSzw3qitSLPWfD5AHNAiG/E3u/z9Muh0dgwDliLY1zfYdkySYXZ7HqPrZkIPP+521Zbqb2plS7Rk7c5KHLGADJunlZ5lhKCi8F58sGpfOmb5R3gFhSD/5+y8bcgA6WnxdpTjQ5PyjbvavksvQuDlfiD0FVgGiCBUw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3871.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(366004)(136003)(346002)(39860400002)(1076003)(2616005)(6916009)(956004)(86362001)(786003)(316002)(54906003)(83380400001)(6512007)(36756003)(8676002)(26005)(8936002)(2906002)(4326008)(6506007)(186003)(478600001)(16526019)(52116002)(6486002)(4744005)(66946007)(66476007)(66556008)(75432002)(6666004)(5660300002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: SVV8pfV7Wb40fIbwOk8TcwDyldcMu3fXIAAzk7LvnW8BAWsXwukvnXitcSJSZqsnydFdpVFtUSY59e0uQLV9egfpVdbRAwCGajEUV0H1WPRW4gvpkgz4gXDP+Wm9fwRTEfyOR8WN0VYTLaxOpV0dHHrWOEMFW9YH1QND83d0BCZkS8LxIKTAXLPyPTo93b9nqtb0YdyNuCoAv4SSkyaGBvRT+srbtGBtHZ5NyepbJ67lTlz4UK833QkkuiBfjMa17ljNxiOkDwe2rPSXS4J5gQTQaZkrIlDe1oQwcrsqnkkIbCmzuBHhJ7+oRt+RMF3tIjBXz1NRuZnZZS9d+Oa0PnIFyaXD9gelXwj/ucwAnvBL0XiXHwranF/ide4V+tbHBMZsuEnmhPFQU2+GbzoGzrxzjisPW8fuQJ1E0TxGXgSQKUgtD6LrPF6yZR3TWefjl7scsGcFfobaJMRqMKyFb1WWonpUWfYBCNyR4SPCVVPqrZbjS8lyf1+TyNzMJbCIR5hOsDlt9fuLxRQwKohArZPkePTwLUUp6tTPRNHkikVjwfB5Opk5LRco5LNsDxXumCqD1LECGfo3BYISk0GxGYk/9BIIg29aw4NsgJPCl3VyrA20UPN+1G7otbATuiKDFyQXzaBjK1lWe+Lz8chmEg==
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 2957fd58-50d6-4f0e-e3f2-08d87c30294c
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3871.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2020 17:29:17.1871 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s6S2wmG4tZsTSADEDcerK/KVQcH/8j70QWwL91vXT0o1iZFAOySIwejYdat4g5W0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR03MB5531
Received-SPF: pass client-ip=40.107.244.122; envelope-from=alxndr@bu.edu;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/29 13:29:50
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.021,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Laurent Vivier <lvivier@redhat.com>, thuth@redhat.com,
 Alexander Bulekov <alxndr@bu.edu>, f4bug@amsat.org, darren.kenny@oracle.com,
 bsd@redhat.com, stefanha@redhat.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We should be checking that the device is trying to read from RAM, before
filling the region with data. Otherwise, we will try to populate
nonsensical addresses in RAM for callbacks on PIO/MMIO reads. We did
this originally, however the final version I sent had the line commented
out..

Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
---
 tests/qtest/fuzz/generic_fuzz.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qtest/fuzz/generic_fuzz.c b/tests/qtest/fuzz/generic_fuzz.c
index 3e2d50feaa..31f24ad06f 100644
--- a/tests/qtest/fuzz/generic_fuzz.c
+++ b/tests/qtest/fuzz/generic_fuzz.c
@@ -192,7 +192,7 @@ void fuzz_dma_read_cb(size_t addr, size_t len, MemoryRegion *mr, bool is_write)
      */
     if (dma_patterns->len == 0
         || len == 0
-        /* || mr != MACHINE(qdev_get_machine())->ram */
+        || mr != MACHINE(qdev_get_machine())->ram
         || is_write
         || addr > current_machine->ram_size) {
         return;
-- 
2.28.0


