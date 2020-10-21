Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49867C4363D
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 01:19:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99E7F22253
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 01:19:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="OhDWJN39"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99E7F22253
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33258 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kV2mj-0001t9-Il
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 21:19:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44508)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kV2cY-0001nM-2s
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 21:08:55 -0400
Received: from mail-co1nam11on2130.outbound.protection.outlook.com
 ([40.107.220.130]:28640 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kV2cW-0004s9-KA
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 21:08:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jkZbakZUJfv9wL0lJ0d0YfOUFBobLNtCAoL551wT2JxpSLL7RtE4yDq50PH7R+a1ovCMb3+KZgYYxVEYpfW6c5ewTWM9VYTSYODkOvL24Ssxiz1SsSx4vsHBALPYz5rStPoCMpm/dSUq0BBQZ85UnCaTxT1Nbl59Qe2DAUcnlurw5onFMFS68ZgLT2HPY54U3pSsm//+ztDlUT5zHkpMtYZHklT7avTH/+35z4+n5KLVktfdpBxHwZFIXbnmfwpdLmQ56hdLo8mnHUTFKwSRdMplAhnVEFpwBBqgXlTQEGSvloAHQ8eKbopVOP/PJMyjkRdnXrunXji/BIK5hXjrqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ofhel/Y+zk6nPpUJhwyqcyc0WQlzkNTfewTkfViO8DY=;
 b=IPvgxOcIviYiYjIWAaao8wfrVp3fzZRe+Mglx6oUdjl2urD3755L8GsFWG6eKjNj7gbmBQ14XW13FVt/J4fc3GpF2Z8ckNc1ncWPeWjUk2eyb0aCsnJDcksQhxQ/hA8/j3mRlmGeCj5gANwtLgxBeD5CBnjvqtJ3xkXIJNTRXChhjbqwH6hrKSlt4g8XKhGjEPu3rDvy+dXujjzlaFXkUvJKbm3MRe4+NSql7SVo6H1dbjfS+i4Ex/jXNnZFdtm8ZLhFQSjYTBbGDLlGAsPYPKi+Ix4/VVB1ts8eBK495dTsD5IixwEfp8X1/69dcBc/w2BmQp4YkpaSteRqvLd7pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ofhel/Y+zk6nPpUJhwyqcyc0WQlzkNTfewTkfViO8DY=;
 b=OhDWJN394ayD7fFKOPOz9PrLg+1vk74kAFjvxSiwBTYRuTb/ELi03VIlPSdlZu6TsKe1ofcXuI693lKlEUICSG4Q2nE//KW+mjOFIIepqVQvrQLOIQPfTxEA6TZVs9WVsgh71BCjYyLYF4naa2nCQfc9cD5RdZsvAhQR2u04cMY=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bu.edu;
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SN2PR03MB2333.namprd03.prod.outlook.com (2603:10b6:804:c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.22; Wed, 21 Oct
 2020 01:08:24 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::d520:4c19:8ce6:7db2]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::d520:4c19:8ce6:7db2%2]) with mapi id 15.20.3477.028; Wed, 21 Oct 2020
 01:08:24 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 13/16] fuzz: add an "opaque" to the FuzzTarget struct
Date: Tue, 20 Oct 2020 21:07:49 -0400
Message-Id: <20201021010752.973230-14-alxndr@bu.edu>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201021010752.973230-1-alxndr@bu.edu>
References: <20201021010752.973230-1-alxndr@bu.edu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [72.93.72.163]
X-ClientProxiedBy: BL1PR13CA0119.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::34) To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from stormtrooper.vrmnet (72.93.72.163) by
 BL1PR13CA0119.namprd13.prod.outlook.com (2603:10b6:208:2b9::34) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.8 via Frontend
 Transport; Wed, 21 Oct 2020 01:08:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a53ba55e-8e96-455d-4169-08d8755dcee5
X-MS-TrafficTypeDiagnostic: SN2PR03MB2333:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN2PR03MB2333E960543A9B3D9CF971DABA1C0@SN2PR03MB2333.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8/SJNNb5+H+ogSp7nCI314+BzyJ3BvghWWrYLfU4A+nVA2jOJLMXSYIWpSSaqe7la73GgQs6c7BmGOeqX6H+HCoVjPUCMXdgi2ScgPVR0uM59i0LpYICEEc8lSgvvlD7F5z4oPpQqFLII/rghaBElVM9S9tAVI+UXXq1jhBkFSIpgVu/GdeKu8yP100KG+LEhdkTPH9fBbKxhuXasWlS78aVvkub4oG8wD3dJWDp07FHeddNR8tQNuDYoIZCqznq3f7Ant4s54jycEBl7bZBLZAJDIZxWsL24PqMABqFqGbAjjD8jlEjWrZCXIcX7EDoP5H34qMFm0M4miMiUwJodw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3871.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(376002)(346002)(366004)(136003)(52116002)(2616005)(8676002)(6512007)(6916009)(6506007)(36756003)(786003)(316002)(956004)(478600001)(1076003)(4326008)(6486002)(75432002)(4744005)(8936002)(54906003)(86362001)(5660300002)(26005)(16526019)(186003)(6666004)(66946007)(2906002)(66476007)(66556008);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: bFFyIRFZNicodLeGjwX+gOzF3Ua00i0MybxqlcnqeMEEtrZgMwFRfWAL1m/YOEbXASbmLNgW/PTAtVber6Z51kMu2Faa61BdavZalXt1Tbvnk7zdJrKcY4jCtJPnhXBAqLOTZSL49NRE8xu6quUJbQrOP2dPp7+HrF07GLoo392+ilGkHt0Gsgp/WxS1LdWrNFIzHgYAbvYPvvx7kMYXTOidn8poKLmsz80gf2Q6kgbEGp/X6TkNYTX1M1JXqI4CMEJQIfVet3JOV4BIrdddo2t+hBVNhLMMeCkC1rknIq8J5BknwVmyj0DRfABhy4hTt54iwXfElGQVWzKdFRgVilqpYwJBrU8/I1QXD4IZJfAj3bXQ1sNWwRgDzM2lBNo83A3NB71FWc8xiYfpKNJJWbsFoS3zZkyP5o04gNvngWYRLTi91ihzPe5OWLmi8TjnKuDIrVbcj24PPAg+4Fgh/vQx6m0s0ayLQn3g9mERs24GRDUfGDLCF7+rOdnAIk9qZ4XiSFPnc3zkl+Z4fKyKq3vtfVhZfW/Q6gbG/0uMjDywreUifTzbSmElV6ecZ5l+YW0teZBQ1xdjxTSIXIufa5uacpM/eaZ+WpYBM4SDDh+V32p0B9ffjgBUMNamT7iLcE/gKxH3vthxAizCh5FoBA==
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: a53ba55e-8e96-455d-4169-08d8755dcee5
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3871.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2020 01:08:23.9472 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XIfMyBRAJGSfTYJZTQDatxILhZJ05I55H2gb1QPSGoShVnW8VBq1EZzCpJXnOVfS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR03MB2333
Received-SPF: pass client-ip=40.107.220.130; envelope-from=alxndr@bu.edu;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 21:08:14
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.441,
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Alexander Bulekov <alxndr@bu.edu>, f4bug@amsat.org, darren.kenny@oracle.com,
 bsd@redhat.com, stefanha@redhat.com, pbonzini@redhat.com,
 dimastep@yandex-team.ru
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It can be useful to register FuzzTargets that have nearly-identical
initialization handlers (e.g. for using the same fuzzing code, with
different configuration options). Add an opaque pointer to the
FuzzTarget struct, so that FuzzTargets can hold some data, useful for
storing target-specific configuration options, that can be read by the
get_init_cmdline function.

Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
---
 tests/qtest/fuzz/fuzz.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/qtest/fuzz/fuzz.h b/tests/qtest/fuzz/fuzz.h
index ed9ce17154..08e9560a79 100644
--- a/tests/qtest/fuzz/fuzz.h
+++ b/tests/qtest/fuzz/fuzz.h
@@ -100,6 +100,7 @@ typedef struct FuzzTarget {
                        uint8_t *out, size_t max_out_size,
                        unsigned int seed);
 
+    void *opaque;
 } FuzzTarget;
 
 void flush_events(QTestState *);
-- 
2.28.0


