Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,RCVD_DOTEDU_SUSP,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 287B4C2D0A3
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 18:08:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C71A206FA
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 18:08:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="l9eRZjUW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C71A206FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39008 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kb6A4-0006Cm-De
	for qemu-devel@archiver.kernel.org; Fri, 06 Nov 2020 13:08:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50256)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kb67v-0004Hi-3X
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 13:06:19 -0500
Received: from mail-dm6nam08on2113.outbound.protection.outlook.com
 ([40.107.102.113]:7896 helo=NAM04-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kb67t-0002XB-2J
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 13:06:18 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mK1hnd2YAuGMrMFsNq5JwIjpF3UdOQ8g335E6pGIuGqTJ07jn+78gOKgLbbnjD33yb+efO+OYUwl2MB/K48evI2pFeteDr6mghv5oCUwltN1zUjoYJr3dqWQJUvLz6KpQcmGCBpFENiitwtPj82ycYsdQ08JwA/TzDtYNc8zuGq1a4ZomEJRlEh+VL5bXuNlF/7DJY/QLMcBgN3Re//xAv4gBAd1jw5fFC25LOe4EFKyptZbBw6iL+UWdWOO48o3WbqJCwfJT92WVctRkZ6KFRDA7ZWYDo0I3+SqrPMHRxrkKBWsC5952mD6z9+3S5G4TZjAdqWK7Nhs9FM0WnSafA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3r3BgWn85+zSzMGQk2SogxF4oS9rOr9ZOBv1xfN00qY=;
 b=ZYhIPWmkBwT9UlMwLmFaoTHLrXEnryzEcJI1MpEmktPDIk5wjzTcsE3DUouWopJ63rrMZkTZPHQSpAklxdyBWnP3PNWeDQc/bJcgHK10smb7BPvXUBAQcxaxDYasi3NyfhEIulxbXpkMYDSWTXaQD8lOcnh+wyOHpvScJSho8nUwQ4UlXzqQZ1QlMb7SNEbNktiNqg2Z3D+n9puvpUZJTthWI97CvV6w/xY+hWHJLYDNz4EQJlfGiyMpX7FZ9EayI4Mt1xXpj3K0ZYUZsnZNyCQGVQWS5k2p8jG4C5xskfLQXWN2iWh0Lbg27Hbbdegg3uxrwttnmSYl0z9wYLuzLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3r3BgWn85+zSzMGQk2SogxF4oS9rOr9ZOBv1xfN00qY=;
 b=l9eRZjUW3KYgj6rhEd8ysF6hNhvPKqokkoWnZ9rHtxkjkBX/VWIAzW70D/gNXVixnyrK7/+4GGaMa9pTPqMlpW6Ecdbv/fQkOopTiwqT2iECZtHt6OB/esLBHvVkLH/faek8xU4LYaSuxURwqoaawLwpFVUOnw6Svzska+Y24Ps=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bu.edu;
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SN2PR03MB2207.namprd03.prod.outlook.com (2603:10b6:804:e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Fri, 6 Nov
 2020 18:06:13 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::d520:4c19:8ce6:7db2]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::d520:4c19:8ce6:7db2%2]) with mapi id 15.20.3499.032; Fri, 6 Nov 2020
 18:06:13 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/2] Fuzzing Documentation Updates
Date: Fri,  6 Nov 2020 13:05:58 -0500
Message-Id: <20201106180600.360110-1-alxndr@bu.edu>
X-Mailer: git-send-email 2.28.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [72.93.72.163]
X-ClientProxiedBy: MN2PR06CA0004.namprd06.prod.outlook.com
 (2603:10b6:208:23d::9) To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from stormtrooper.vrmnet (72.93.72.163) by
 MN2PR06CA0004.namprd06.prod.outlook.com (2603:10b6:208:23d::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3541.21 via Frontend Transport; Fri, 6 Nov 2020 18:06:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 642417e1-4049-4a32-37d5-08d8827ea59a
X-MS-TrafficTypeDiagnostic: SN2PR03MB2207:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN2PR03MB22079B8C743107C8220EEA13BAED0@SN2PR03MB2207.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WQy67aYuEfVTMMy3yRsV8kg7V0yEuBJdCAW8iw3BsR7orY7PLcxys5xWoiXnIy2K3IQJBwnrvzgOKTCCUOy9D/Vnw37TF1YF2Lj+rFG8/GUOpxie696PgLrgcC+zYP8L+r6hhuIRxjOkTyTsck7+znzg7Jt5VysdEXbrLlRUqQQWYimNGTHKSdCvWNIiFNrKip8xW/ixRJufMycqP1ren+mqqN1FTHNYGF8u+RnMhCBjThgFc5LZTVKrEKclS5oAyS3MOOVlX+0RvqE3ffnFsEIAAE0nQgAoyWYA4TcU+ETW8sI/4WygUJDyJJl/K8Rot9lr6VDlh5Vi0Hbfz2GuGA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3871.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(39860400002)(346002)(376002)(366004)(478600001)(83380400001)(956004)(786003)(316002)(8676002)(4326008)(66476007)(2906002)(6486002)(186003)(66946007)(36756003)(66556008)(1076003)(52116002)(6916009)(86362001)(16526019)(26005)(5660300002)(6506007)(15650500001)(8936002)(75432002)(6512007)(6666004)(4744005)(2616005);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 3D9w4tNZ0DJnhqK9gxdxEHT9C52t2luGe9KayL84CytduJE6KTkLzPYrDaByUobz0RDgkkTm/s09eDTcmVHY1vPepyCT5U59/BUh9pHuBYvaK700adwhqbQgeSpsN/h+TxMOdbGmYcrj9pKWTv73xBi8v4uDX3dG4QCPod4Eg2za7wlhkwN6Uz3xRQxH9OoGA2RwJ2afuF07DxqrdCKTMIQksOcVgiGmZeVKva31eRwh7T6pd5JeBvhs0UldAvvUEaili6PSgitbeiApbMXLHwWXrTsXXtj55gqQ2nkLvgvyqZbqg42yyqjsQPQizVsbwaZUbrlXQtE2PFZrwsI/TmJJ/Anc9jK8bFT+bXWCEuqUXWbpF3r35TxZ6HJCfp4fiQcbd/e6nO2zgfN5nt7lejTzmq+dKVSiCYlbrQ05h6d1i+g58kuAKQDxsPQO/HVkDK4BR6imXUBSw1TJmPUT7KMzlk9n8lePQtEdhopdpyZqUHxNfYIihE4jkHKmzwTXcte0pdqmqtER1XYUGjf/w+gErtrjGUbTlgmtJpxLL9YGz5MiqBxbHBXxvrxFXjEVyczKapnzpP+sEZEiwzGT24/MQpFkUSFrb4VqlyHKbsGrwR0S1MYcywJHnJ3HD7yGQK0g73TZ18P0/cPhPM1vaw==
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 642417e1-4049-4a32-37d5-08d8827ea59a
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3871.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2020 18:06:13.1811 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m9aq5SQS24BlqQ+sHzggK/as8+Ko02ZkHAheZ6jQkZGeYRQd50/X6fOfG7fc/zee
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR03MB2207
Received-SPF: pass client-ip=40.107.102.113; envelope-from=alxndr@bu.edu;
 helo=NAM04-DM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/06 13:06:14
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: Alexander Bulekov <alxndr@bu.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I converted the docuemntation to markdown and updated build instructions
that changed after meson.

Alexander Bulekov (2):
  docs/fuzz: rST-ify the fuzzing documentation
  docs/fuzz: update fuzzing documentation post-meson

 MAINTAINERS            |   2 +-
 docs/devel/fuzzing.rst | 236 +++++++++++++++++++++++++++++++++++++++++
 docs/devel/fuzzing.txt | 214 -------------------------------------
 docs/devel/index.rst   |   1 +
 4 files changed, 238 insertions(+), 215 deletions(-)
 create mode 100644 docs/devel/fuzzing.rst
 delete mode 100644 docs/devel/fuzzing.txt

-- 
2.28.0


