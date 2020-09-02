Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,RCVD_ILLEGAL_IP,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAFE7C43461
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 14:39:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D5DC20767
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 14:39:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="FGrIsm+v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D5DC20767
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52276 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDTuj-0002hZ-OW
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 10:39:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34548)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kDTtx-0001VD-33
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 10:38:17 -0400
Received: from mail-bn8nam12on2125.outbound.protection.outlook.com
 ([40.107.237.125]:4768 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kDTtu-0002nB-Ra
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 10:38:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iHJJR7g+C3TJq+RLLIdEWcBjI3LbZffcXCN614lV9ela3Bz5T+pxT95JsJAcbcwAQBr+LjI4BUe9iI1EMCnkJnune6RSUATJo/0NsXoypSh+/s7sWbQ4e2n6Y6h2exDuQw8SNVa6mBBpuWjfb8bw8O6L0Pt+cEaBPkt6/g439nTVg8xnZ8n1AyHhFUHaX6BKo5Jz/ayskkMAFWbXdtwdKMa7un7VRJWo4MgtSlSTKjQnin6sQKjhHeIUR4E5yD8+BWuNl3dypn/eS5NshMVOIjhRQKUn+QUisuO6s9Yi+sxnpznO9EnF/m4apL6woFuJhC1bXP4+gXzRL8+uyooJoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c9ZdX83ZmE7c1v4vwSlAPIR1vVIpz5BRg01W08AOci4=;
 b=lbH14j64IXlJm0Nr99Fn/XUS1kVDZrJYT0y1JGlY+SP95wfL+tzHV8FHtcGOahEza2kjeibalmW5iU67jNJth9cc24aADMMxmxTWisj77XvoQnv4eHMya4NhLB9JlbAiNxUvqwVFRcH5CnWswEOOF8qrV65Q1ygGRYmbL3BBUZtwksXGDk+zdIdv0QYLI4xhfeG/3XM/DYE6jnRgXW7oN3NaxnZtXBkXSeOO/zNGkDzjH7DPUj1wAgxQsACNaAYzuEbz1i6oFG5iKxbnSE9uXftLuUZL3a426kWRk0LnXEXxeVq44MJeL7f+pGlGAxKV1hp4pd5I7T0OZKEjE1u4iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c9ZdX83ZmE7c1v4vwSlAPIR1vVIpz5BRg01W08AOci4=;
 b=FGrIsm+vUXPTm4LklwBiADQeUvvfLNeuhd7oW0UwbJyFBjN/xg24cRRVrz5iymseLaRG3h4wNxUCZ4knXeVED78nuH1EQhjLF2MMmMMoTQuVNRTkykmZ4VQaqfqJQNMYx42h/F24U3/ytNpPd6nmQ8aNMwxxvIJpp4dK4CVqZUY=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bu.edu;
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SA0PR03MB5561.namprd03.prod.outlook.com (2603:10b6:806:bc::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Wed, 2 Sep
 2020 14:38:12 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::61ae:93a8:b26c:77b8]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::61ae:93a8:b26c:77b8%4]) with mapi id 15.20.3326.025; Wed, 2 Sep 2020
 14:38:12 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/3] Fix oss-fuzz builds post-meson integration
Date: Wed,  2 Sep 2020 10:37:57 -0400
Message-Id: <20200902143800.124073-1-alxndr@bu.edu>
X-Mailer: git-send-email 2.28.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR20CA0065.namprd20.prod.outlook.com
 (2603:10b6:208:235::34) To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 MN2PR20CA0065.namprd20.prod.outlook.com (2603:10b6:208:235::34) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15 via Frontend
 Transport; Wed, 2 Sep 2020 14:38:11 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [72.93.72.163]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a800336a-d559-4e1b-c90c-08d84f4dd1b0
X-MS-TrafficTypeDiagnostic: SA0PR03MB5561:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR03MB5561032DB4970695017983D1BA2F0@SA0PR03MB5561.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BrrZCBvzraiaXn/N/+CNFUeOjNY62zhMO+k4QJwZ346AcmaK/CGr362gEmk0mSw7Ecu1p0EkykdTksOvr1i0IK2Vc2XbWFEsWrJv/ARbjxNNRGlkvU/9nn62d6vCS7FY9vohVem5n7cfgHgOVuFHeHkM9p7cUpP2YzpMvnBFyQbVpHF/J8PyHkyquSs/UuBgiAk2prLr7+fou+5pUUBYtwTghp5mo8+M0CwGlH0Dp8bZpsKpt2Jnm/2Tc9XRXWVJzfgJEdl6P52+yKaFisRzdX6FCwPO8p1WFQ+pLi5rUN9FzcCXppRXyBBabEVKJ2H4i6b9gdfY62Chc88+mnp2fk2TS+KgSvYNTREtgXdUE8jxwu5jGLo9cwO35J/vocFzzEWzC4w3TQIHD/AeZuvkHw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3871.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(39860400002)(136003)(346002)(376002)(75432002)(83380400001)(8936002)(966005)(4326008)(86362001)(478600001)(16576012)(26005)(2616005)(956004)(8676002)(2906002)(36756003)(83080400001)(6486002)(6916009)(66556008)(786003)(186003)(66476007)(5660300002)(66946007)(6666004)(1076003)(52116002)(316002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: AWnXz3Ynq0ZMRWfved/97gqJa3ZWBhSbRiORVUcfDrYVUyWaCepT8NRzmYgnCgqnx3O9uKLPk6bJuaNin+gt5tWzWcsskvGJCIOwiHTb1Uif5w1xjt4N7VcfFU+T3dyyv2rRw3ch6yIhvrOh6DZHdWI/5rRtxHiRuwHqPskDFkK74rQs5pXSOw0AX7lgO0OhuNK+r1ltn6EzwFPm4YlpOduOBQLtZPIW2h0A24FHxX61G/uTtTFeXfg4YSe6neeEUdUYJZuooWAVFUd3cFXv3zuKdD3/fa8ZcTPI+UBZvwsZWfrLGOCrUo4qfiFNeMIrExUbieDMT5wvyESKUeF+wx2hGWxX1UmeG4mFQ9nFXCV+5EQF+qCB/hpjmiElykQ61aVzqxV4Mnkli9DT9Na+/m+U0mueyKnD1fnXK+IcuA6e2BkpAwbT+ZrEVyB2/pCSQSNROdiCAlShXAPLMxKM5CvO4kXtuuPxhn0L+MC48GkJ83Yt6GTPpuA7DDDRui8BmCOCW7NpWsMzDOH8iXWfg7JnoquApdz1u6oCHNfq3V42J6VbKC//RYFVwYKsTGKWIEANwsWum0avCz+4D3nj/vUBd8HdljikIcIVH2gsurJDbDNBFu5//YvV2y+zV9bV3hQgWNh1hRptbUXXNAp9Wg==
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: a800336a-d559-4e1b-c90c-08d84f4dd1b0
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3871.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2020 14:38:12.4573 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hCN6zb+HRXHCR+WvQa490V6xZJE+KjJLDnGX2GfOVSyC+CDqLEQjR77SUhmcTwe/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR03MB5561
Received-SPF: pass client-ip=40.107.237.125; envelope-from=alxndr@bu.edu;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 10:38:13
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, MSGID_FROM_MTA_HEADER=0.001,
 RCVD_ILLEGAL_IP=1.3, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Alexander Bulekov <alxndr@bu.edu>, pbonzini@redhat.com, bsd@redhat.com,
 stefanha@redhat.com, darren.kenny@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

QEMU stopped building on oss-fuzz, after the meson integration, due to
some linking issues:

https://oss-fuzz-build-logs.storage.googleapis.com/log-3eaddfbd-7e05-4ddd-9d86-ee4b16c0fac6.txt

Those problems should be partially fixed by:

Depends-on: meson: fix libqos linking
(https://lists.gnu.org/archive/html/qemu-devel/2020-09/msg00802.html)

These patches:
1. Build on the above patch to fix the way we specify the linker script,
   to ensure that it is not specified within start-group/end-group linker
   pairs
2. Add support for running --enable-fuzzing with a custom LIB_FUZZING_ENGINE
3. Fix a problem with how we specify custom rpath in the oss-fuzz
   build-script

Alexander Bulekov (3):
  meson: specify fuzz linker script as a project arg
  fuzz: Add support for custom fuzzing library
  scripts/oss-fuzz/build.sh: fix rpath

 configure                    | 12 ++++++++++--
 meson.build                  |  9 ++++++++-
 scripts/oss-fuzz/build.sh    |  2 +-
 tests/qtest/fuzz/meson.build |  5 ++---
 4 files changed, 21 insertions(+), 7 deletions(-)

-- 
2.28.0


