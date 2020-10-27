Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07094C4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 07:54:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 855992224E
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 07:54:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="xJRTy1FO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 855992224E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54988 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXJoY-0001Rm-IW
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 03:54:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60630)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1kXI4e-0003vm-Ii
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 02:03:12 -0400
Received: from mail-dm6nam10hn2223.outbound.protection.outlook.com
 ([52.100.156.223]:54432 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1kXI4c-0007fP-Fh
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 02:03:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i8D+qn97gsawmDf32OHzfj6ihMKnDrmGhrxPQaXHBAgbX+4ZO9hSWNcAgpiTPeBs5s4JNikknODWlNSYm5RpupRoDDGTLnud5NtlKujEBbeL9MhUqcesbR6FTcPrUtVYVC/Xmamv05TVD8++yvZ+Prw862bSqpYeEfHaeqrzRtLzhF9Yh8wMmVGZamgDj6fPkr6rL6VyzftmBvqb5uDLg+RnYZlJekx8QaiIVr3nFOJSfcSvR3yBSW7NkLpowgK/9/Oxfxi2VDD5Y9B819e1Ben7JyQBkeZ7zE5YOBks6s2znR9vVuiZ4mkHQyXaUmbfrxvrFejKuGL16VkDAbLBlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mr3A2oeV9jpnAU0VS4CeB5vagjxGSELLrwx5VmlheAA=;
 b=Sqi57u4ATXn98yml4DWilqvpsXqt3DK3JIEHWP3zUZnNS1+NxRu+PuJYvIyDarBNA1wl2EbHoM6AUXQFQ3xkZg9gpHYJTCXU1AIlXdh1RCcSzU8jkZTraltCIPgSSNJFU/oiOJrQSAU0Ddr7USbCBp0ku9ebPB0eEGfA24U5lJ/oAWGiKVHdeu11e7NPCV1f4P2T89jPy7qFz0rs61+ghgoAVFlBX7JoHrMEd6EMsy0WFo9FEdw5hHJatEM0gkS7owonlAXZuvbsWpC7WS+wfU7DDGVMtdSnkSqbf6xsxzMeO+qeouVn8d6/kWehRyg4werQNDd0VU1O7vydPT41bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mr3A2oeV9jpnAU0VS4CeB5vagjxGSELLrwx5VmlheAA=;
 b=xJRTy1FOEOYaTHy5Y3bZRbhBdCq0dCXR5deDKOAndQO3HqzXgm6QJRd4BCY1k6+G5qseW+n8WSUs5z4rJQiMiG/vjxMrMq2WzMorhV4NpxFx61tSV1Uspl7yz4TVzvv3xxsQ6/4bMIX1HJVCY1GBVRvTdmW5u0OpdjgkBcODyI0=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4133.namprd12.prod.outlook.com (2603:10b6:610:7a::13)
 by CH2PR12MB4165.namprd12.prod.outlook.com (2603:10b6:610:a4::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Tue, 27 Oct
 2020 06:03:08 +0000
Received: from CH2PR12MB4133.namprd12.prod.outlook.com
 ([fe80::f428:769b:3e9:8300]) by CH2PR12MB4133.namprd12.prod.outlook.com
 ([fe80::f428:769b:3e9:8300%5]) with mapi id 15.20.3499.018; Tue, 27 Oct 2020
 06:03:08 +0000
From: Michael Roth <michael.roth@amd.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] MAINTAINERS: update my email address
Date: Tue, 27 Oct 2020 01:02:53 -0500
Message-Id: <20201027060253.353054-1-michael.roth@amd.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [76.251.165.188]
X-ClientProxiedBy: DM3PR08CA0004.namprd08.prod.outlook.com
 (2603:10b6:0:52::14) To CH2PR12MB4133.namprd12.prod.outlook.com
 (2603:10b6:610:7a::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (76.251.165.188) by
 DM3PR08CA0004.namprd08.prod.outlook.com (2603:10b6:0:52::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18 via Frontend Transport; Tue, 27 Oct 2020 06:03:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 463d945a-507b-45a3-3311-08d87a3df9f4
X-MS-TrafficTypeDiagnostic: CH2PR12MB4165:
X-Microsoft-Antispam-PRVS: <CH2PR12MB4165A490C686E77A5D8D612095160@CH2PR12MB4165.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:669;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ivb/tsfng2DST4FX10G5xwc213YbANBYTGpK9jmgmSoQEndP9ToVTyM8NDEpToXTiSZObAdOSohVB8Eitjo3Gyy6enEyfWoPnibh5qa4QVbsSO+UBhiAdf8V140BGgCEmhDuMdOs5G5pnfvEiuCPxCqc3r3R0+KoGLvUYndN4a95/q81ZEY8TFhJ3o6ZJvRRSkiiPcVc+KtePkHwtkTRW6Pj+MtWP6jEXQh4YRjrAGzXAQFewhDF0BN4BxoCSHtgukQqsH5reNjW+93TeZJvuFYXlstsudisy7LNcOTJJE001ZVnpNnQg14Lzxpo7Rsr8lUklBkCRknpFlxBbBFtfXD5X7numcWOAWfjYg9neI6oj3s+cue81Os4fGJo8V+irkgL0GxDyB1D/nnerjbzv9hsncd7i8CbNc49Rs1IHJY04rR2lq0MflK1AY7PNc9RW+0vrvBCwTp9eZMAgF7JqEfL+kcXF4m2o1BD+O4/iPxMZ0vpNLEUu3RAZMPAifDbOqUVPbs9qsN/7U3m5fD/lbSWeVPatYwKimEn2WLs/4I61lOOVcyrmqi+F4++5WlS1ESXHOvurm+yADSn0rvki5nK3UwTogPYn0eeKS5Z+Iq+t1lxfQ+UfxMeTgFg3f3+pL1Wg8ZeYzUF8AOv6Zy0nGGvd0Jx7uc34FmjDiTnT/wIbaxw0DBBTZjma2VeHIFUNA2v4OpAjayyGNmFrz7IWpMcGZPqYmU1rVATOa6zFUfD3B/UjsIRZP4dntwcRt03/wFw78MV2gGjlR9cm/S4qA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:5; SRV:;
 IPV:NLI; SFV:SPM; H:CH2PR12MB4133.namprd12.prod.outlook.com; PTR:; CAT:OSPM;
 SFS:(4636009)(39860400002)(366004)(136003)(376002)(346002)(396003)(66946007)(16526019)(52116002)(186003)(86362001)(4744005)(6486002)(966005)(8936002)(6496006)(8676002)(316002)(478600001)(83380400001)(6916009)(1076003)(66476007)(66556008)(36756003)(44832011)(5660300002)(956004)(2906002)(2616005)(6666004)(26005)(23200700001);
 DIR:OUT; SFP:1501; 
X-MS-Exchange-AntiSpam-MessageData: 8T4Cdo42NnPIFnK8TE6mgvKaY6aekRq2yD2GIW5INtlp7JiAhssmIfe8jNI4MjNUYJs+pXPM4/mmVrFWHZ2IejYhSPChF2zUvYRvBeom7oF+3IoV6KbsltdXJ062aZuqegTEp5ixRifP3CCZZhqmhAQLT7KkQN6Bfxfzlzk+Zt3NGdpAuPhtKXBf8whYPSkafAs0L6NczlZXOVkl0UDlYjb17pk2kfueAyNpvsR0XQfzehUocl3/l/84FlcIHMtwDFXtJRr8L/RLqkSYpQsOxMNB1iAJ/nh4HSdx/0pDk7HL43/guGj6bw8dqCUVlZsV40PWv8Wb/zK1wbUa+BJpBtFfqwQNVcdb3ajjgS5SiQLo0XQN9pyjCR34GoP1giXSt4xBCGa3czD2gZ/kdrT7fRCAMpflBKVb+AGOv7GISlkcyILqSzGYjbBiLRHZkhq0Xbu5BAM4bcv9VwZYR28bULzdIndSRcb0kN4mkQqqYC2bllAOGwPrLnZSa1uAFyONFbbpjFv//2dUV2laGU7zal1YeE/YJHYoxdPHKGLwoxhzBJ/ueiMLKzogmxwQwA20sZcbVtPc8kwDdyFl4PVfa2PJuAq4Vptv8bkz7GkpQZvzRxAzUFe9+m02ED++MwjRjy6EjqryMsVJDXX6x5Xzjg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 463d945a-507b-45a3-3311-08d87a3df9f4
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4133.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2020 06:03:07.9941 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oG6+ySwU0t61lShZg5lL2tDkSrQYS+bbu7uNOqxXTL9x2ACs/66T9zLeexaFSw4EhAfBlzjBKplAvdLsqnmIzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4165
Received-SPF: none client-ip=52.100.156.223; envelope-from=Michael.Roth@amd.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 02:03:08
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, FORGED_SPF_HELO=1, MSGID_FROM_MTA_HEADER=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 27 Oct 2020 03:46:56 -0400
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I've recently switched employers and the current email address is out
of date.

Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index ef6f5c7399..c72af7c2f5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2395,7 +2395,7 @@ F: scripts/simplebench/
 
 QAPI
 M: Markus Armbruster <armbru@redhat.com>
-M: Michael Roth <mdroth@linux.vnet.ibm.com>
+M: Michael Roth <michael.roth@amd.com>
 S: Supported
 F: qapi/
 X: qapi/*.json
@@ -2439,7 +2439,7 @@ F: tests/data/qobject/qdict.txt
 T: git https://repo.or.cz/qemu/armbru.git qapi-next
 
 QEMU Guest Agent
-M: Michael Roth <mdroth@linux.vnet.ibm.com>
+M: Michael Roth <michael.roth@amd.com>
 S: Maintained
 F: qga/
 F: docs/interop/qemu-ga.rst
-- 
2.25.1


