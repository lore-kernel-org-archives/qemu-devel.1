Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFF02C38A24
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 06:40:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8DE020753
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 06:40:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="t6Kq7ERc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8DE020753
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35550 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWaD9-00057U-KV
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 02:40:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52380)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jWaCR-0004Kd-8j
 for qemu-devel@nongnu.org; Thu, 07 May 2020 02:40:03 -0400
Received: from mail-bn7nam10on2095.outbound.protection.outlook.com
 ([40.107.92.95]:34657 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jWaCP-0007Wt-E2
 for qemu-devel@nongnu.org; Thu, 07 May 2020 02:40:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rox2YqH4LZFBK++dqZJfiTn7bE6186UksfURB8JyRQIXXTCV3eSTDROS/UTBV+l8IAMZ1dwSPjGU7OuOSt+P5hvfdN6BJ50JBHi3x3HKBPu6OsE4mHzCA32kUSneNwQvpc308FaBT92bj1dS1c52rXAUY/hJ9LVPWXiGXwD9FufEhEoNGEeigf2PTJth463HPHI2wPm7o8sJu26nxzS3cq+QqVAv+9QixBlEvkU9hdF/2IeOr7zJhvsO1KFUZniSHBb5kwJLMiPzvvVJkJ8wvrJitJD3qev6UmZNPxFGcB0RARLCeqCcpEyWB+n0xV8y7CUUXphDyxNMylBfXG85pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HlmB/tUFGrlc+jYZe11MTuCqAW0ufk0yZfbjnUJCpM0=;
 b=NJ2MHtuSNulOerzXjRM2J42eCTQLWYmI4msoLD3t/7AfVAGTIr38LJqRKsQf0vEApbLzuzhzIv/mBfcMehMlkLw1pyb4AxcV37neOwENu0Gd8We6G6M3bzQZdaojpvnIp4MZNJ979eOjLS1B5i+iDXbBOX1ktIzApTcb+cYBDaUjYMS3ELRPPQ/qP4ioD3IbffytHkRB/wf86yRUa1MXEHQeG+SbkTDSA4SaLoW+VKz3yDLCJl4SMyltNhIb8LdQ1zqQ0zMH1a+hNmxLxjfJyPSwG9N5+U+oqeihVSfC0j+nRwc4RuqO5cnMx/GryT73E3kgpANBPs1YDD36aAjuOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HlmB/tUFGrlc+jYZe11MTuCqAW0ufk0yZfbjnUJCpM0=;
 b=t6Kq7ERc9l9p7LMTqInHYzk6QLu4uwrYS2qERTU63rK62jC7zCiZxbylchi7SjkWX+w8DTzKr0TAuG9JXjL2IVvGqGh6663351RpZ0Ngq2pkZ3ZITNLH3j6UvDilDA6eKXRvtv6zZT/bC3z1WWtZXKmQ6BjmZrhTsGgcYFyrpFg=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bu.edu;
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SN6PR03MB4591.namprd03.prod.outlook.com (2603:10b6:805:f6::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.26; Thu, 7 May
 2020 06:24:56 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::640a:1123:37c1:42db]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::640a:1123:37c1:42db%3]) with mapi id 15.20.2979.028; Thu, 7 May 2020
 06:24:56 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/2] Add pathin option to -chardev file
Date: Thu,  7 May 2020 02:24:40 -0400
Message-Id: <20200507062442.15215-1-alxndr@bu.edu>
X-Mailer: git-send-email 2.26.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR02CA0125.namprd02.prod.outlook.com
 (2603:10b6:208:35::30) To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mozz.bu.edu (128.197.127.33) by
 BL0PR02CA0125.namprd02.prod.outlook.com (2603:10b6:208:35::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2979.28 via Frontend Transport; Thu, 7 May 2020 06:24:55 +0000
X-Mailer: git-send-email 2.26.2
X-Originating-IP: [128.197.127.33]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2f2b0741-4764-4897-ad33-08d7f24f5c42
X-MS-TrafficTypeDiagnostic: SN6PR03MB4591:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR03MB4591EA5BD02B4DBD5DDDB472BAA50@SN6PR03MB4591.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-Forefront-PRVS: 03965EFC76
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oNvlghmfohUd+XoJEt2F0M3ED6rBJBLzDRKnXeFn/tjc8G+rTWSPCH/96yOmfDvBEKbAhqsY8uXRBl1dVWF6EHtBFqmXbenjQX/ft65mnEa1u6xAsUfsjS1w1cQD1Tr08PUxE4W5n5orJ/yZThPZM7W0mc+Juf4OT4pAts7hOWxuB7L3XDZFlAut6wVkjA0qYkOSCD1Byu80tVPXXZ/vGBrN+AngCGExZfqS5TT78YaIkCBC2SppqSrqdEMcnXHdx2GcFwbP+3d3PbhXuxa/sdpxTbv9xsXCVtQDr53H3C+CF3k9utSfB6GOa6flbfTYqXJtWUdNB3zZOuzrKc3Zv68SVUPtuSssaYFAoXTI3gIacn1k+7Rkqx8i/5MLrmIolr4I7Ox8E2yBCyQMLHTZ8+B7uRosR0iRaGnoyLIKPcY5Op9uQEz7Q3DoW/vRRbQz6FpHi4Clhi6ZYrgeP3K6q4B3yfbRfvPhJ9MEuBTMXEP0J7VCetNC63Gpt2uP+9es1mwL3jWX0boBhF30xYrz6g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3871.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(376002)(366004)(346002)(136003)(39860400002)(33430700001)(33440700001)(5660300002)(2616005)(478600001)(4744005)(66946007)(1076003)(83280400001)(8936002)(83300400001)(83310400001)(83290400001)(83320400001)(186003)(4326008)(956004)(6486002)(26005)(16526019)(66476007)(66556008)(36756003)(8676002)(6666004)(86362001)(6916009)(75432002)(7696005)(316002)(2906002)(786003)(52116002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 7PCb/ApI7tFAd4xmAWwDcjgESL+LRANNM4q02M65jDDOD/C7F3vOG1Dzvei3r56TYl91IlXDPlXdWAxOsTqdokfjjog2gaMvNhuLBLkFz9xmdDittepA9Nkcm5lkUIM3LQc7atYsPwOnEmQ07lD3i2+Q6BXf2TE19KFVRIzHYtQqinOxUI0wg77f73Jhrb4HhSGl5KPKOElYje5MFWufF+eKJ3HPQYUl5Z6v387DcZvSJevH6Wf3cRsDnOjOLIrVTMLIvc8ym9TlhRU5vLawXsv+qkVd0ovY4tpK6R+77WlsDNG41/5KeotteuGpezsxsFtk6n/sYAKpoPuRDr3yeE8qpe/X757U1D2d/tSi4gP61yuEhlKjH8mkw6A9A9El1YXvoe8WthrO2tqW4PzXQGxhdaZZ2K3zM9EeKbNdDxZg9sRzFjaZSQJfBnJlm2BwgB17rIHr+SLDG4tnY4y4XiEBTvnp4rk1FR35+oJUB2M1hI1KQ0nJTMANi2Av2EzXt5jtKBwSz9D57Api92fJdrOvV4vzVrtSjJ51GfRHZdphCKRRc58sPsBX5bLOwF8GkpSPDZwXM72DOG6r/1B28EBTo77AXv3reVktr2uPpF0cbgoPg48An6wyYon+I+H5ii7/m56bDSB69yHba1c75Eu8YdRBot9CijifDSLDkHPBfiJBaIWR52RV/4x+gZYuKiaA1clz1c9CEsiStDhLA1rUxnpnKnhTwTNQM0QbxS1K75YzZuQxHTEAEpH+PwTxBIR28NusJiT+tvDiOyp/NtLVtueVNdLzwbWS51TLW7I=
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f2b0741-4764-4897-ad33-08d7f24f5c42
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2020 06:24:56.5073 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yOBjbpHFk4ZocKhRwqr2+4LVwLMUCHweXAH/83oVvqSjENgEdHmlLSTNcuKmFpML
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB4591
Received-SPF: pass client-ip=40.107.92.95; envelope-from=alxndr@bu.edu;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/07 02:39:59
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
Cc: marcandre.lureau@gmail.com, berrange@redhat.com, stefanha@redhat.com,
 Alexander Bulekov <alxndr@bu.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This adds a pathin= option to -chardev file, which allows specifying
distinct input and output paths for the chardev. This functionaliy was
already available through QMP.

Alexander Bulekov (2):
  chardev: enable distinct input for -chardev file
  char-file: add test for distinct path= and pathin=

 chardev/char-file.c |  5 +++
 chardev/char.c      |  3 ++
 qemu-options.hx     |  7 ++--
 tests/test-char.c   | 83 +++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 96 insertions(+), 2 deletions(-)

-- 
2.26.2


