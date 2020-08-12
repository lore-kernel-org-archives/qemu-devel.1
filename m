Return-Path: <SRS0=vd3Y=BW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E23C6C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 14:13:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE948204FD
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 14:13:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=syrmia.com header.i=@syrmia.com header.b="Vi5rlheu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE948204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=syrmia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5rV7-0000hZ-U0
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 10:13:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32904)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1k5rUU-0000G8-Gf
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 10:12:30 -0400
Received: from mail-eopbgr20090.outbound.protection.outlook.com
 ([40.107.2.90]:24835 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1k5rUS-0001Cb-Aa
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 10:12:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iNbWBWrEFS22rC/hXiEJsYcfKgzP0wFX1Bdg53cNCP4z5uDVusyvLI7AlLp40OmRl4pG+34TPwrJ7Ccm0muqFi1k0ZSdFZd+THigIDyrh+Y7PEHXGKFdr8SibFkafZnkNLRzUVxLsMyBfe45nTAN5H2hR7AKhL6XNzXHAS6w4l0PVVF9Xw+XwiQcQhOzxiBVw0uh1mkxnsir7uL49+6zNEspWcn589zCgvKW1OWuJAnXjH3nriA0oivlXdrBICiybez4bTLZTbaEdWc25mclfE7dSNiy/QDLSLWxKkwi+W4YZa1rQjsjhMp17kAbJZpwxgclU3SC0YxNId+UB0kRSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RngxX8mi41zanpB2BOVSh+K/coC3O3sZ5vXHBkU3h7c=;
 b=ULaCwZSN4IMyXpluLFRUHkmsWqugBbKBZEla8vFIFvRw5vMcb1eYxRiBLx+CupTLuD3B6ik43AECYM1bhLZRdefH05K4Q2ufIee2I6A1nue/JA9DUELPGdLHB3N1bvrnmALQIwfSll12x+6zJsZzSY+xEXZpo4DVMUOyjkQzC29dFLcuZ4cBu+oEkRxV+iNctxMhmQcJMvfQhibwxEuceehhOTmnIcm1UT9psdxs1LSgiJn0iwz1zRir19F6iRjLFE1ZCvZlIMhcPUdU9045RjIsfBWWsROzEE1UEtgsFH3NAX3ZJKA+F0HMPV4IHCfWaxf1remZuRxoXv+ECaQPFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RngxX8mi41zanpB2BOVSh+K/coC3O3sZ5vXHBkU3h7c=;
 b=Vi5rlheulT1elw8rj8NS51A3zld1M3KR2lX+KUYa+q/l0m/mh7uQgqPNVCAr8CCurytcoVc9YRpOv80wafD+Lw/2tzS1iAKZtcQgEde+zR2zuOl3raQTJ0GvFldFCGkXWd1VmifwtOIdjSR4jzdnBrWYYi/Ivyx+D/HYP75NPNM=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=syrmia.com;
Received: from VE1PR03MB5246.eurprd03.prod.outlook.com (2603:10a6:802:a1::22)
 by VI1PR03MB4928.eurprd03.prod.outlook.com (2603:10a6:803:b6::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.20; Wed, 12 Aug
 2020 13:57:18 +0000
Received: from VE1PR03MB5246.eurprd03.prod.outlook.com
 ([fe80::3568:5b4f:ab6b:e362]) by VE1PR03MB5246.eurprd03.prod.outlook.com
 ([fe80::3568:5b4f:ab6b:e362%6]) with mapi id 15.20.3261.024; Wed, 12 Aug 2020
 13:57:17 +0000
From: Filip Bozuta <Filip.Bozuta@syrmia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/2] linux-user: Adding support for a group of 4 time64
 syscalls
Date: Wed, 12 Aug 2020 15:57:01 +0200
Message-Id: <20200812135703.39404-1-Filip.Bozuta@syrmia.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVAP278CA0011.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:20::21) To VE1PR03MB5246.eurprd03.prod.outlook.com
 (2603:10a6:802:a1::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (147.91.217.238) by
 GVAP278CA0011.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:20::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.15 via Frontend Transport; Wed, 12 Aug 2020 13:57:17 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [147.91.217.238]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c2c71c47-35dc-4a9b-6a08-08d83ec7a001
X-MS-TrafficTypeDiagnostic: VI1PR03MB4928:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR03MB49281B1EC22E5735333857B5EB420@VI1PR03MB4928.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z7//Y8jMYPxXn3dP761S7Q6IJNQeIitsn+dNF8URznA3Z/6wGqB2f2/pu2UnYIQD9kPjSXi1efZAI280DpJKy1GwRcGYfMCZ67gJq32tEv60zhVgf6jhSmclv2uPKGhUzreJMdfaCTI4pezIBwPavgmuZ6SxAIybK9rbOR1UVxl/0euQVqPMcDGU4PJSCv5sF35wt8C7zMkiBfbxnViEKwWW1w6bF4UpzqR26js5fKdwuUK+s707VyJdfCd+pohnI+kX8PTRIOrNJE5tm+EXIT/WuukscClbCtgMxnbEnX3Ue2hpjLJOMwXEVvcGRTHE699sPjBVlCwQ08rUGQJ4p/RiGL7+Jzt3l+ElIUlu/l8mVSoC2IPwUJ+MWfWE3yeS
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VE1PR03MB5246.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(396003)(376002)(136003)(39830400003)(346002)(366004)(107886003)(36756003)(1076003)(6506007)(4744005)(5660300002)(956004)(6486002)(6666004)(6512007)(6916009)(54906003)(86362001)(66476007)(26005)(52116002)(8676002)(66556008)(66946007)(2906002)(508600001)(316002)(8936002)(16526019)(186003)(69590400007)(4326008)(2616005)(83380400001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 7R5Oo5UUJj6+0YAG0RUBf9GHMU+9UgfXQDYMZW2dZXgRaWOIJjTg7ITrJgm35H91bHKweePnwZd47jCe94BIGLNKC+M0brTUqgzYcjXCb00zZP6vnueBiRTPD1Zfrb92e5DWJle3t/+po4R08I0GU3yB8AtKcS5Z/HA3gK1RN7ZVx237HUS3biXueP4VNuPAj0x6yY5R49J/h9F8jNWN4Lh1P/RlM4edEiX3JP7LaLKZ4Wyl+HuUszlKB8Z6B18aC+lHnbDQAcbmH8mQrAVDeWfyttwtVK29SgHPiHyF3bTZU5oyvH2cmD4SSxJyq+Ied0kb64WTHscKFb0SfmbUkZcvYO+JLy2nAWiTb8M2vI8RFLnMKpiQRzjwmldGPgYW6uBmPy7pOcVMERyCRQiWGFhxXyWZdZZQFUmnf6OSxaHvhNNQA7Y7buyR0B7ygUkKMN63QdB3i0JKNjGae3JWvVz7lWyhpXHuuaXq8F6AkPvSdqxs0LXJkKGzruVPuK31T2jHhSJBROddTfn4HF+i9upcZsfT80vh3JqkCaRnW2T2YiBJgMLgtP44KAMPqnoUYP3bnk8wAmguHVH1yf0wF1tMeF1I98NFcYbWTSW2p6eezEkPIN7Xoq/u68C/PjB8abRPkhRWOI5YkdgWW/LnXA==
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2c71c47-35dc-4a9b-6a08-08d83ec7a001
X-MS-Exchange-CrossTenant-AuthSource: VE1PR03MB5246.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2020 13:57:17.8595 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tupfqh0InUi76MNYXikfkwfCPG1tKOg63+GSxVt1gNzPK5EDFG6Dfadg2AvxrhMfaONDRkuXdp62WQ7ACHyfuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR03MB4928
Received-SPF: pass client-ip=40.107.2.90; envelope-from=Filip.Bozuta@syrmia.com;
 helo=EUR02-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/12 10:12:26
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: 17
X-Spam_score: 1.7
X-Spam_bar: +
X-Spam_report: (1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, MSGID_FROM_MTA_HEADER=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, RCVD_IN_SBL_CSS=3.335,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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
Cc: Laurent Vivier <laurent@vivier.eu>, Filip Bozuta <Filip.Bozuta@syrmia.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This two patch series introduces functionality for following
Year 2038 safe syscalls:

--Introduced in first patch--
*ppoll_time64()
*pselect6_time64()

--Introduced in second patch--
*utimensat_time64()
*semtimedop_time64()

Testing notes:

   The implementations of these time64 syscalls was tested
   using tests from the LTP test suite which was built inside
   a chroot.

Filip Bozuta (2):
  linux-user: Add support for ppoll_time64() and pselect6_time64()
  linux-user: Add support for utimensat_time64() and semtimedop_time64()

 linux-user/syscall.c | 154 ++++++++++++++++++++++++++++++++++++-------
 1 file changed, 131 insertions(+), 23 deletions(-)

-- 
2.25.1


