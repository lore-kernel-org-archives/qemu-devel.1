Return-Path: <SRS0=UjLb=7L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 976FDC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 17:13:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 604B420723
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 17:13:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="tyV4V4u+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 604B420723
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46362 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeiZN-0007LF-Hc
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 13:13:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41112)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jeiYg-0006rp-DR
 for qemu-devel@nongnu.org; Fri, 29 May 2020 13:12:38 -0400
Received: from mail-bn8nam11on2095.outbound.protection.outlook.com
 ([40.107.236.95]:55649 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jeiYe-0008IF-Nr
 for qemu-devel@nongnu.org; Fri, 29 May 2020 13:12:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lpXakFwWQMtSTWvHbe9tVRFirT3SOvqK1FIqXMLheg18Hi65CxE2/m54ap/dzhvPHHT0/2vkcCOhccF7p92MNxqDYKEdETkamp+9tnifuo+nSLYTj9Rn+OL4OaGcRSv4HTKJvWc5LtUFTI2//RM92zMULERcI93YjVvD2FX5KFqM76fxS4NH79aI4tmKKDD+mBwdZpW0oK2Z8ZmXWCG6Y5rz2u7QtLIREBxEW3/Qxowz35DOAhsYD80lmvHVbnvcx2laxBF0datuOUkvmzdRP50+T9OXTNRw0fO8FUzvIOWiD5rS4LH450RMsPONJUVdyJFj9079lTosSEA5/Nvcmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yrDNM7gv/HvmbAKArBx6YgRWd8wldDcX9lx7V4O3S+s=;
 b=kvpe+um7+3dubte5LaMUxrrtOL9CfoTlbOICMQU/PzUsNNdgyX99On2Kc+5PeUkyZ5JlBt4dYpOq44gdBTilxA9yZMERdjk65FheiW8553wIcGbkRef1/FD42YFqVdpofRBgsEBfzIbQUHvd8wCzVdXia05y3pT7CGrwPU3lt21yzU4rGFrQLUihUHncAepIRSWmwB4twtAyAz36J9arRzRSSDf27STUSONKX+wDU3jHYqOiaGURAYHBUJnsF5epliW4EwCU4tYEtrw5ENWI6n5OzWAk4XYy2dX9c0+QJffPc95SPuLbG2s2+maf3ohd7/CShJevrhKctMDRcw61WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yrDNM7gv/HvmbAKArBx6YgRWd8wldDcX9lx7V4O3S+s=;
 b=tyV4V4u+GNjqaIZKTwIanewQJaOs7L+cQDkY5qzb9f0oDDKOJQLVFWMs3fCFELETScyMButICUabenYjfQniyfQa/z/wtkJe+meYJir30HLaglgmxTAnBenB8wbPEyrnl8aFWbHgZUYkSmpaWWkSNILg8XcMu62zFmbm1T4aixc=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=bu.edu;
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SN6PR03MB3504.namprd03.prod.outlook.com (2603:10b6:805:4e::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.21; Fri, 29 May
 2020 16:57:33 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::640a:1123:37c1:42db]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::640a:1123:37c1:42db%3]) with mapi id 15.20.3045.018; Fri, 29 May 2020
 16:57:33 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/2] fuzz: Skip QTest serialization
Date: Fri, 29 May 2020 12:57:17 -0400
Message-Id: <20200529165719.19262-1-alxndr@bu.edu>
X-Mailer: git-send-email 2.26.2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL0PR02CA0077.namprd02.prod.outlook.com
 (2603:10b6:208:51::18) To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mozz.bu.edu (128.197.127.33) by
 BL0PR02CA0077.namprd02.prod.outlook.com (2603:10b6:208:51::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3045.17 via Frontend Transport; Fri, 29 May 2020 16:57:32 +0000
X-Mailer: git-send-email 2.26.2
X-Originating-IP: [128.197.127.33]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b4fc6038-a110-4d12-8195-08d803f16194
X-MS-TrafficTypeDiagnostic: SN6PR03MB3504:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR03MB3504CB56C366015AB49F381ABA8F0@SN6PR03MB3504.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 04180B6720
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u3JUIiWhmCdseMip1LeDuY7Canm+HfkhXT2OaNo5S10gtgXD8Ol+UyXMtJKfqMPuQ6REcBKJq8wLuAuaPTUiKEhwn4zkEiwzIdx6LnSVYk4jdFm+iSD4/ThCJ+y6cXdWV/zuWf5vcA/VUVRGVKvyPHg1czg2wwRlvajEbFxn5xdQ5rxvzzQHrmZ7KxgL5oGznqf9SDIKlWZczlIRSuMzk1Wk/BIpdLmcCdjODZW67EnUgjcDlhNDtkl15u8/yabFYs90anwLO3Gmzayu+OwNWbBzCbIplpKaz9ag/i/zp2pXX6SkcCkfTRNh9NI1EDS/haNcVmZF5/t8F8VIfO0kdFwLs10X712XKE5tZJ1Uoye3T4kmXpAPmjzO6xLQoQuxxR2U3ak/ViTvwuYiP3fJ3A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3871.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(376002)(346002)(39860400002)(396003)(366004)(478600001)(5660300002)(6486002)(26005)(966005)(4326008)(6666004)(36756003)(75432002)(2906002)(86362001)(16526019)(786003)(316002)(8676002)(8936002)(66556008)(66946007)(4744005)(1076003)(2616005)(66476007)(83380400001)(956004)(52116002)(6916009)(186003)(7696005);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: sOLoXAqKrrByi76/W9q67iujnAL275tUm9Xm30Ms9jlGHCJI1kgBX1MxEpS98V4mkj17LfBYauzxE9sRM3oVurpx5Q1/uvU65EpgfoSaAqkGBvRzJpt74yU19rv9pzJJJiM9ZS7kpx8MdVUhBVeTqXIrK0z4J3O0f2JC9sTZS71YI12+dTq+0p5QFEiA2v/fBNcimpyeDKHMmY8krGO/S0+Xo9xAHD6be4tLMVPVBxt3JyppR817v1N5VuGUGNGnSBQteLsQ2Z16s26CgWk4eC6yGAh0VOixMbfrgJI8Bf0eiMLPGDLgzT5qZw0aDHP63VoY6NE4bfyubs1W82xxCfgxBJTFOat+Nq8QgrEZ+sn/MW1aiZRCwaVUgaXNQb1tuHkA4mTZZGM5GQMRuuYaacn7nA0tgCNZ7m6u2iixHfL8PDL/IaBQq/vhw0JInfYt18r3OPNMysmnDlYUfPW8sI81IzSgJ9CC/YgP5jqr00M=
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: b4fc6038-a110-4d12-8195-08d803f16194
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2020 16:57:33.4377 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kq8dFK5XbvFObkvyNZeWWFOxqi0OJ9CF7Pqd9UIVsPLRl+IbFgQaztn6cTjjXcw9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB3504
Received-SPF: pass client-ip=40.107.236.95; envelope-from=alxndr@bu.edu;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/29 13:12:35
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
Cc: darren.kenny@oracle.com, bsd@redhat.com, f4bug@amsat.org,
 stefanha@redhat.com, Alexander Bulekov <alxndr@bu.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In the same vein as Philippe's patch:

https://patchew.org/QEMU/20200528165303.1877-1-f4bug@amsat.org/

This uses linker trickery to wrap calls to libqtest functions and
directly call the corresponding read/write functions, rather than
relying on the ASCII-serialized QTest protocol.


Alexander Bulekov (2):
  fuzz: skip QTest serialization
  fuzz: Add support for logging QTest commands

 tests/qtest/fuzz/Makefile.include |  21 +++
 tests/qtest/fuzz/fuzz.c           |  20 ++-
 tests/qtest/fuzz/fuzz.h           |   3 +
 tests/qtest/fuzz/qtest_wrappers.c | 252 ++++++++++++++++++++++++++++++
 4 files changed, 295 insertions(+), 1 deletion(-)
 create mode 100644 tests/qtest/fuzz/qtest_wrappers.c

-- 
2.26.2


