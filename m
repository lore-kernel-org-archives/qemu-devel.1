Return-Path: <SRS0=UjLb=7L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 095ECC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 22:16:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2F6F208B8
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 22:16:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="Zhptw4j/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2F6F208B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54222 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jenIW-0002Pb-VO
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 18:16:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59112)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jenHT-0000yP-3t
 for qemu-devel@nongnu.org; Fri, 29 May 2020 18:15:11 -0400
Received: from mail-eopbgr760094.outbound.protection.outlook.com
 ([40.107.76.94]:12454 helo=NAM02-CY1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jenHS-0000fW-ER
 for qemu-devel@nongnu.org; Fri, 29 May 2020 18:15:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tp1+uHuCq2sIfsqM/weMjNpe0zA6xMq3n2WA9VCuI2KwsLafLVMyQN+B9LJhaw8Oa3SXN9P4iWzWc+Vs+Cthl4kJuoTG1kNAzE0vSIw8UodJEPvi1zOIdSWsBov7uz0T3jG5XnjWqPv7KksZU15T9th0WXVN7PFxDksnKFkdh/xzKS/GYHGA8VLlTnwUMBnKZHzTe9m6Mmw1nkYJ7OooesLgi7TQ14/mw5njQStXdDc3F4k8xGmM+ZlaF5Qdju/9AOqqnGomm3rppNc6hg2pPOfdf6/kVYcr2HSHC+M9Dvkr2NZYTDY1hZ9kRk0vyZ8O93ueXxppQV9KMMJw/sG0Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LkYmuz8kDA7F2Kn8uptN2fW/fXl5fFurvL1F+hSxfkg=;
 b=Sobk6A1F4QpVq1iGkGIWqv12OSKVb82tAPFGKxaolvavNbFR1vwnZtRNsYmSGucQ1k9kwH0EaP+4fMNZ5YdjF3lkG31IiVDR+bo8LUO0eXD7LF6HON0ZiPNpUbq12JmYOuYHrC97BGKISL2W+/tJ29FpZjE2j1YsoDgJ1Qwi3QA7wJVI5T1vkBBWIzu1GU8uzt7VWK5j31og4SgMumih8AhQN0i7lqkPtRkDYl5Ed/Brd5lNqOdYdI46A8XZkddwQUG6gotUo8iKiaxP2ifCWLBw12jfInCoOVlFn1twCA6IvV6hpupLT0IXYxOyD4cAnQC5iWnC7jruxGEKViH2kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LkYmuz8kDA7F2Kn8uptN2fW/fXl5fFurvL1F+hSxfkg=;
 b=Zhptw4j/QTKuep7DS2ybMPoIC3WkElicOpcNFsNVPBXYZX5yi+6MnIZYJRiGD4BfE6PNpIZneT9N5tjDbPhQduvCYesIr7gWSddL3jvQqERAFIABKCyEXs5p6/ckd3EeAyEoCSubEGGBSebC46zox6f8C97rKpSZ7IPw1CK6BSM=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bu.edu;
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SN6PR03MB3455.namprd03.prod.outlook.com (2603:10b6:805:3f::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.19; Fri, 29 May
 2020 22:15:06 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::640a:1123:37c1:42db]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::640a:1123:37c1:42db%3]) with mapi id 15.20.3045.018; Fri, 29 May 2020
 22:15:06 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 2/2] fuzz: Add support for logging QTest commands
Date: Fri, 29 May 2020 18:14:50 -0400
Message-Id: <20200529221450.26673-3-alxndr@bu.edu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200529221450.26673-1-alxndr@bu.edu>
References: <20200529221450.26673-1-alxndr@bu.edu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR19CA0031.namprd19.prod.outlook.com
 (2603:10b6:208:178::44) To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mozz.bu.edu (128.197.127.33) by
 MN2PR19CA0031.namprd19.prod.outlook.com (2603:10b6:208:178::44) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.21 via Frontend
 Transport; Fri, 29 May 2020 22:15:05 +0000
X-Mailer: git-send-email 2.26.2
X-Originating-IP: [128.197.127.33]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 16e46e3b-fd8a-4087-f75b-08d8041dbdb2
X-MS-TrafficTypeDiagnostic: SN6PR03MB3455:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR03MB3455B04D74AB5C2EAA4F91F2BA8F0@SN6PR03MB3455.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:747;
X-Forefront-PRVS: 04180B6720
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JJ/cH55hrUvoeh/jTqb154hRecwnffw57m5/AacVkKEWXXm4jt8P5Ua0ZZfyKGSTVrTGd74OipWStjIrltANAZYlhNRrRTxlgwA23ouITcOkLzR7NDHWs4Qt8Qa6Es2VmVuT5XM8LcIXYPjQ6vp/igDOKhAeaMFyzWyNMi973CqzO4Lo2MlVGE1KVg2yaUBzLojT03Yj8fKV0mNI2YSO496duWuFbrjUqSCG1f3ZjrTbcny2GY/31SIUX0bDhQHs5ov31wsSR0Hsn+whYXVIB8WvXVQvLKZLz231+lgZOfa9EPdagEbQ6nofcRXKb7l2dbp3cezJd5yLtRPZ8OVLFw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3871.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(346002)(376002)(396003)(366004)(39860400002)(86362001)(6666004)(6916009)(478600001)(956004)(36756003)(26005)(75432002)(16526019)(186003)(7696005)(5660300002)(66556008)(54906003)(1076003)(8936002)(8676002)(2906002)(316002)(2616005)(4326008)(6486002)(83380400001)(66946007)(52116002)(786003)(66476007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: vPdyHKJGF7xN9LDZIeK/DDDXXiI3ptckT2UGnv/DcO4rNZ0QXa4jZJy+Cacibuqb4ZqHV/biWPQXkXzLp2TEGX6RQIEMotxm0av6iyv5YmNB3e5E5H3qDrQp75025TQwkuwHE8ikVUON/UAV5xo1AoVm7U8TqTGgEVpcx9CVkKJuVrEQMKVgz7kRqaZdbrZdtDat8JTA8++CQW8PeFe69b6EshoZVUqTnA5F1K9y3Au1D85oK1gHqYGx1Fbrixn2KrCnAjGeBryvYv6x9+o5a88qNcDwXOgDQ4t4UIZ799W7ik3rjDkDqESJ5Ei/gKGAMWFjwVW+GNsxgAOfLYBPP7JdO4OH303WlGZOlZbv5SkGVDGzACCQy6Kw/6QMxcmSZ8sFVpZaq1B5cysNYTOB9Qtz8286xtwji3N/DNZietN/ASw8+WT+y/+Du1Wfgqs6CGnmGu/xsH99EIOtf2hHaBeu+206ECoVZf1A2k8KCtw=
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 16e46e3b-fd8a-4087-f75b-08d8041dbdb2
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2020 22:15:05.8728 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +aUZBriaIdJFbF5+3AhMkZGPtWo39cwDsbwj2Nkl2hG+E13/QYzWZV2iueXULfep
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB3455
Received-SPF: pass client-ip=40.107.76.94; envelope-from=alxndr@bu.edu;
 helo=NAM02-CY1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/29 18:15:05
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, HK_RANDOM_ENVFROM=0.001,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Alexander Bulekov <alxndr@bu.edu>, f4bug@amsat.org, darren.kenny@oracle.com,
 bsd@redhat.com, stefanha@redhat.com, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
---
 tests/qtest/fuzz/fuzz.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tests/qtest/fuzz/fuzz.c b/tests/qtest/fuzz/fuzz.c
index 88ac88bca9..21cdee53db 100644
--- a/tests/qtest/fuzz/fuzz.c
+++ b/tests/qtest/fuzz/fuzz.c
@@ -94,7 +94,9 @@ static void usage(char *path)
     printf("Alternatively, add -target-FUZZ_TARGET to the executable name\n\n"
            "Set the environment variable FUZZ_SERIALIZE_QTEST=1 to serialize\n"
            "QTest commands into an ASCII protocol. Useful for building crash\n"
-           "reproducers, but slows down execution.\n");
+           "reproducers, but slows down execution.\n\n"
+           "Set the environment variable QTEST_LOG=1 to log all qtest commands"
+           "\n");
     exit(0);
 }
 
@@ -182,6 +184,11 @@ int LLVMFuzzerInitialize(int *argc, char ***argv, char ***envp)
 
     /* Run QEMU's softmmu main with the fuzz-target dependent arguments */
     const char *init_cmdline = fuzz_target->get_init_cmdline(fuzz_target);
+    init_cmdline = g_strdup_printf("%s -qtest /dev/null -qtest-log %s",
+                                   init_cmdline,
+                                   getenv("QTEST_LOG") ? "/dev/fd/2"
+                                                       : "/dev/null");
+
 
     /* Split the runcmd into an argv and argc */
     wordexp_t result;
-- 
2.26.2


