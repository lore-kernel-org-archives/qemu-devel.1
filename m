Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B309CC4363A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 17:31:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F413220838
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 17:31:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="GEBoxEAh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F413220838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57344 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYBm5-0007ql-Ua
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 13:31:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39988)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kYBkL-0006Ph-9X
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 13:29:57 -0400
Received: from mail-mw2nam12on2122.outbound.protection.outlook.com
 ([40.107.244.122]:48737 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kYBkJ-00053E-SF
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 13:29:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EwRp/dTZMo0ff6vhVXiix3soPBkfBbI9dP/ffM/oEAt2g5ExXd5KS1hgz4HHAnimxFRVaDrTXZgwY+v+MqMBv6e+7yJQ1C+/q1XlNptqu+Db4PlMRkBEGMJSoiTelWv9ha1Op7cVT4IjbUcaHTAwNvWRFyKIhr+EhSUl6IV6hu9YUtMEj2HMZvj1kuogeCNFag4vMctTdMa0vf+eexGJc1u8lUY2PKZ8vOQTQzkO1yEZt3jcDb9hBTO18cH4bKGFW9N0dcRDiRYXyk7afO9a19eTBykVRyAb1mNjN1/QdYuPnHDeQmaiQijED3pgzd129cUyYYrr5pTvfLKuSuyT6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pzq57iY6F4yPBb3QHPsfz89t93OsfxxyJVMrVQZne7M=;
 b=XZBPc5eKwqnn0TaxO2uVffdJKWbypZMWCGn+iWCZEw4RNrIMD3Bz6pIOh3cMEF0vO0al+qZbuRqalFJveEZFcylTxfjHDz7x5k5oe8eOSx1IAkiRAjJR52l6a6CvzFsVezax4peU8y3Rh7AfriCTWM3rvUfWO8GZqnZqI6IwXcf54ClPGHgxex1D3WlyyclSLqZjVDS03lzjN1uYz2clAvkC/zO0kn3wQngNRv5KDgj9O1/Jeys3xAjvQlTzf+CSDgKV518GtBsG0u9as6gXMWNym0Ad5PakvGzp82ZF4kC65xak1L2iUDzFz/Rgp12o/M2hooVVaskvtCs2HqhPLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pzq57iY6F4yPBb3QHPsfz89t93OsfxxyJVMrVQZne7M=;
 b=GEBoxEAhoj4Kp2WyQsOJugp4IUlgou+XSxkm/E4zNnJLUJnqaiazEeYBFLNbryAN8sf29sk5x19vN5hI3OGHph3mSjsS4L+/CHGGEJW8iMHlDIph77WUiG/gg6kgcqQEY3I6VN0q62xGIdq2XYMyhY364XZDoHvHDCXiUpfdbjo=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bu.edu;
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SA0PR03MB5531.namprd03.prod.outlook.com (2603:10b6:806:bd::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21; Thu, 29 Oct
 2020 17:29:19 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::d520:4c19:8ce6:7db2]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::d520:4c19:8ce6:7db2%2]) with mapi id 15.20.3499.027; Thu, 29 Oct 2020
 17:29:19 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.2 3/3] fuzz: fuzz offsets within pio/mmio regions
Date: Thu, 29 Oct 2020 13:29:00 -0400
Message-Id: <20201029172901.534442-4-alxndr@bu.edu>
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
 15.20.3499.18 via Frontend Transport; Thu, 29 Oct 2020 17:29:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 250d21d6-e781-4d0b-ff53-08d87c302ab7
X-MS-TrafficTypeDiagnostic: SA0PR03MB5531:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR03MB5531BC0471CFF5FE182058BEBA140@SA0PR03MB5531.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2043;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DLGIGkXZEVEMvzIgtpJi1/dW6i7N2V2q7p8TiPiswrDrfb3bz0Tm4ZvrDY6GMk/hrYV+/Gop2S0eSMYLO55u3+0VphVS1q94uWf8idAHafpY6JX1pNCiKQ6UiajZdWoRcNQUt4WiDSbYQEHdyWFqbvnxi+33iaGIFYps3DA9SjY4rSdNoikkULaRtykAS7mfO+shSvcd/l8v8wOF/6jlBss1UYBh6n+fup71HWl9LOuj17gy5KofDTj3LRmXsl1mLC0h9yXaaJBy/32JNTVSzQIcT2ofgHEKoqu6JUgDP+sQF0xVMp3sNoOxht8axv/rfIourqXGyPL5o8Jxss7Y8g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3871.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(366004)(136003)(346002)(39860400002)(1076003)(2616005)(6916009)(956004)(86362001)(786003)(316002)(54906003)(6512007)(36756003)(8676002)(26005)(8936002)(2906002)(4326008)(6506007)(186003)(478600001)(16526019)(52116002)(6486002)(4744005)(66946007)(66476007)(66556008)(75432002)(6666004)(5660300002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: ed0jj2/H94dDJN8MzvKHfoNg7/TAC09NQC1N99msJakHIzVJcw/i/XF96K3bwffKWxVN8U+Ws8BiDjztVFn+izElkFSvC2KapBQ/hpw/0zuwcj6rjXAh93UmWGf+mzHUXMRhQGEcHxUzKIjHz68z3iBbq+UG+04SSKkubyvqGJu7v4FsQqU8rt2tZxL1vVcElBhoaDtqSVWYul/xBle2b+wvcLvHMwYo7n/EX+jogey9Nh0ivNKHzC4Pdr2ing+grQk0GYN8LKpUwH9A2QaIojKqSUPh9TLT4NMWQMBziJl4flBsuNTmMKuPEAkyZixI0jCvpO/bWXSuAvDdcGoxhXOTApuw6LUDygDP6qrwxljoY/182mx2x2WML4sPJmsai5v3pj6WStHGmz53SEq4htWtnFlPtMeMnZjJB8TsdgoaaBaIdhy3TqkZ5KLpUcfxgKJ7iYnb7kf0xWe+qtNrikFgL15Ktt40Rj2LshpTUwuCzi4UUiZPVDdy5vt1oCvnttWjJ+ie8taGeGY3VQM0ZwRoyBPVOsFZ9wzEiBqGnOqHMoet++qQZ5f0ZLX2smex967H7ELP1MkW9AsxTcUfXGRn79BNnjARag0Re03+KGSvYRMQXbIWp0SLuIM2o45xsfzH9/6GDjZV3OtRfVbyIA==
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 250d21d6-e781-4d0b-ff53-08d87c302ab7
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3871.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2020 17:29:19.3559 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JnOHGbj0WATN/5IBAqRs1jPjRQms+sZzhwrYyGfIr5KKBmqSF0mSl7PXLitAG2QL
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

The code did not add offsets to FlatRange bases, so we did not fuzz
offsets within device MemoryRegions.

Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
---
 tests/qtest/fuzz/generic_fuzz.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tests/qtest/fuzz/generic_fuzz.c b/tests/qtest/fuzz/generic_fuzz.c
index 31f24ad06f..5770f86be6 100644
--- a/tests/qtest/fuzz/generic_fuzz.c
+++ b/tests/qtest/fuzz/generic_fuzz.c
@@ -298,6 +298,11 @@ static bool get_io_address(address_range *result, AddressSpace *as,
     } while (cb_info.index != index && !cb_info.found);
 
     *result = cb_info.result;
+    if (result->size) {
+        offset = offset % result->size;
+        result->addr += offset;
+        result->size -= offset;
+    }
     return cb_info.found;
 }
 
-- 
2.28.0


