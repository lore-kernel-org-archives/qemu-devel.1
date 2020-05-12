Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95004C47255
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 03:05:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DB13206D7
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 03:05:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="0EZfzm8N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DB13206D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYLES-0003ZS-E3
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 23:05:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52134)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jYLBY-00086D-Ej
 for qemu-devel@nongnu.org; Mon, 11 May 2020 23:02:24 -0400
Received: from mail-mw2nam10on2101.outbound.protection.outlook.com
 ([40.107.94.101]:41921 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jYLBX-0007sd-NR
 for qemu-devel@nongnu.org; Mon, 11 May 2020 23:02:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=diq/t5v+JcvsGQk5HTOvP8YgF4LNcyFBDEaQtwMQBa3qfe5YRPOA9IMD4Lb6NkPVcj7vTRiKQwlT7NV5fC5erIOkBTz91rhfFvKevHRq8fbVa3trBQ/S+HOEyj2oUKDXQT4bg898T/GBFjN9dsPhIfgTuHux8zjnMCI+GGTC/jYZCLN9vvjY4C7j17XTTlegLdRV6K5Eoiecf8+OdK47lfe4CaCwnpGPOUix/XZAeA8qLH/Ax1zt8judEdacpuBASyHn+NK5bxB5D/8HA/jQgX4jor09xPuI+1Dpg7EErYTGrrF5lhI/cnhiYgggzSoMsIdSGesAukbiDD5uLgVtRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CMs317ntwg0y1MNYW8mN1xSGrmiHmRDMLN4ZdpFQ8a8=;
 b=GBsaFYGFUoz80n4APEwjHet+TL292Kw93KX+1pVD0xnWRgTLD0b7AnBZRBHyjFksF45mLa32aBY02+iJpEYgF42fQzQwZ5W7CDIiSaRuhyQts8lWwe5k9LDYnzZC50qebc6VbPYw/IDGsoPEoMMfVoFwg8lsGq2HpVWvdPfn6mgLOELHhg6BfKesWE6e3k7yztBj+1dmtRGbbXWKDsfciQvruGDQKQGOFApn2eBraE50Baj4XG3SazuJ/iZwm2DjWUKh5TX1+Ij9lyo6HOr9Eu8dR/CTNm0icqxF+Mszkm2dbEkSq+4U7+6UQibZ17qeMKW+k7Jwn9PB2lzKpi7+mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CMs317ntwg0y1MNYW8mN1xSGrmiHmRDMLN4ZdpFQ8a8=;
 b=0EZfzm8N/QUDAflsVBdLO/qK35Ijr2xv1154bLUi84dN5dv9Rn4aKaMjhrfdhpH7gRIABD4q5hDkH6ww40tJq4jm7EiuyoU/ath+L08P26UH34m1xtbrsXpb/N4KA2zcLQc1ki2Hu/PCKc4D1WjUlt3rMpLKCDl/1OS1rY0lDNM=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bu.edu;
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SN6PR03MB3520.namprd03.prod.outlook.com (2603:10b6:805:4d::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.34; Tue, 12 May
 2020 03:01:48 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::640a:1123:37c1:42db]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::640a:1123:37c1:42db%3]) with mapi id 15.20.2979.033; Tue, 12 May 2020
 03:01:47 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/4] fuzz: fix typo in i440fx-qtest-reboot arguments
Date: Mon, 11 May 2020 23:01:31 -0400
Message-Id: <20200512030133.29896-3-alxndr@bu.edu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200512030133.29896-1-alxndr@bu.edu>
References: <20200512030133.29896-1-alxndr@bu.edu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR12CA0025.namprd12.prod.outlook.com
 (2603:10b6:208:a8::38) To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mozz.bu.edu (128.197.127.33) by
 MN2PR12CA0025.namprd12.prod.outlook.com (2603:10b6:208:a8::38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2979.26 via Frontend Transport; Tue, 12 May 2020 03:01:47 +0000
X-Mailer: git-send-email 2.26.2
X-Originating-IP: [128.197.127.33]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4d150d3f-c8ce-4765-8dc7-08d7f620cf61
X-MS-TrafficTypeDiagnostic: SN6PR03MB3520:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR03MB35207D1662BC8F6BE3121152BABE0@SN6PR03MB3520.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-Forefront-PRVS: 0401647B7F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5RTUBy8aXyJ41IBCDcxb7bvY83CYXu8zdDTtCc1LCDDAAcRu9FaV0y6b56rAt37vuEAayXBf8wfXTkIlcNyAYmVF6XtrcFzrtuichtpVe1QQis+YAiSkB2HnSETeWflqvHL9V6xo0Plt5ld7j+fe3+n8K71rlAx1gzcJmHIiC9/MqiaI6dsFpJaZ1mrCY1/oea0JG7BGnnvUBW6TuHGXdjCX9mjLVPVGGweOfCMQ58lHRZXPpY3aHYKQtASw37k0jAogN0mO3kI17/Mpc+i+y/YtMNu554M4lVvoEh7RJM+DmyZ5/CyBlmKrBOy1GImZ5SyBib471ki30rh0RYyCHD+RqnqLUCx6yL3u2mXERCRor72zbalXTrS4NYLoQmKwwWaddvT1yTkdSu2FeAtURGPmH7nmZZthl+F8DGapJBc4C1jtzKzeWokFjw9WTK2q8ezmZeUjy5FrQnrPy9dgDFZp/vwHpizttO/8SFff1o7KKaCDF81TkknYWbOIzqjdWwDl4PvYPqkBtoq+86Ik2w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3871.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(366004)(396003)(376002)(136003)(39860400002)(33430700001)(956004)(4326008)(6666004)(2616005)(8936002)(5660300002)(7696005)(316002)(786003)(66476007)(66946007)(52116002)(54906003)(66556008)(6916009)(26005)(75432002)(186003)(86362001)(16526019)(6486002)(4744005)(2906002)(33440700001)(478600001)(1076003)(36756003)(8676002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: tN1mghld81LX8exY+yUXTYiEMxLUfOMFy2F4PAZUbcRipBsxKXWVZbALebbJIKD4SvG/u/nt+XIqblfWUaT7sy/7hceVgmEims7t7d4JAkgsxyHERV9jdMFoOmajlIfBvIuvqoDT8yFgbq5a40E26mn2PYpd0DSxM4YRT0UfUsvcWA+FK00Cmn6UY8x1wVp7rrtjulU9858b01KRsnzj0cci/i4iFTuRXnMu8XJJESioiFdH2f9ZkpnzgJEkS41OHG1eF6yaQVm2mgXtg7pv1fcMNWtsb5gyOqVrHx5ukILDhFtqfCyRG6urHHsw8flWI11bbb/OOWqbpwldarebo2hBum48FbPZAFfwQhPGz8XcNeEsY/LTcCxgANypbzS16lBsUpocipFLFhLrAO9x5SYZurwP6SPl2Ql0BaHa4lYUvK6gECSW2xWWd4ciq85gIgvNcfTxE6/HyynUkEHyojIfJd1t4x753KEEBKeRfzo=
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d150d3f-c8ce-4765-8dc7-08d7f620cf61
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2020 03:01:47.7876 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iAzOavYIK1A9D1gMiz8IqDk3ASKdpMokV7+cUkkPHXd/XLJhmS63sJfWj3BWVKJR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB3520
Received-SPF: pass client-ip=40.107.94.101; envelope-from=alxndr@bu.edu;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/11 23:02:21
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
 Alexander Bulekov <alxndr@bu.edu>, darren.kenny@oracle.com, bsd@redhat.com,
 stefanha@redhat.com, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
---
 tests/qtest/fuzz/i440fx_fuzz.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qtest/fuzz/i440fx_fuzz.c b/tests/qtest/fuzz/i440fx_fuzz.c
index ab5f112584..90e75ffaea 100644
--- a/tests/qtest/fuzz/i440fx_fuzz.c
+++ b/tests/qtest/fuzz/i440fx_fuzz.c
@@ -143,7 +143,7 @@ static void i440fx_fuzz_qos_fork(QTestState *s,
 }
 
 static const char *i440fx_qtest_argv = TARGET_NAME " -machine accel=qtest"
-                                       "-m 0 -display none";
+                                       " -m 0 -display none";
 static const char *i440fx_argv(FuzzTarget *t)
 {
     return i440fx_qtest_argv;
-- 
2.26.2


