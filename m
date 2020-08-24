Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE46AC433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 19:22:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B313420578
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 19:22:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=syrmia.com header.i=@syrmia.com header.b="G5l4cLZf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B313420578
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=syrmia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36982 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAI3J-00070I-P9
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 15:22:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43838)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1kAI2M-0005rZ-CQ
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 15:21:46 -0400
Received: from mail-eopbgr70128.outbound.protection.outlook.com
 ([40.107.7.128]:6919 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1kAI2K-0006qi-Ei
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 15:21:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QPxx+EFR7Y1eOqh1rrBStbsmMzAxEyzpiO8+SUTkFzknFLG3TO1FG/0NcrUkFGf1wVDcMtP8l62F8ZhevNVNgt7KThdJZvxU+hxVJbsNmQsWyH2tAbxI7ZstAe8qUxd11v+/q4I4oF0mCCn/40+M1XVSTRf7lE/fMVJx5Q3WymNeD2oR9BaU4DUXy4pO+RkAI6NMFDFg1RRkiYhPZD1DxwnG8ltnflEC134Wq9gCsVQYN6/ChBUsc5CRoFQ8Yt7XwFGzsDdQujaE6QWPmun1yRH7i+ALVjMJ40myEh7Z7B8kx/GCVpoJH/zPA5ljQDVorhtGT51uWt9tdq6EqKvUFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BPLwJ7bCd02hg80rAj+kyo4cvpzI1iaR0vBo0hq3fxs=;
 b=RAH24GInodDb5rwJ34LxY4kCBJOqmpTfVRxt/ACpPJbay98BIyJj5LjZ/TrB5zw1AMLviRxlA1p0Mvz6xD+C9NACUySFSUEL5y7G/u/Zo28IgtGP7NcNlAxSdxEnBD9esBofiXr4q7iEaUT++Xpl7hb1StCbhH8WmEAU8s97sSP1HllUH1/4GMj28l/okzp2o+6q8OUNcn66gv/dD5osLdukhwLNzJvX2o8MqiWL77Uis97OpB1RWIJIfsEJGYDbhCD5hAOAwdQrRkk+8Ldb6UqJRRMGLNXgOaIwqlUn/zMyljyRZyr1CWkBRRd4Z/7Wy4emhVB0Uw0HhMmW5BTZnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BPLwJ7bCd02hg80rAj+kyo4cvpzI1iaR0vBo0hq3fxs=;
 b=G5l4cLZfAybSsu2XE7/ElMhXI5cEx8csbn4f2a2JtrJSSqTDHyzXlBK+yOQbCW6xxGuHGk4cBdO+dvC06NAqVGgx3qGzkxPuPsZYESZ4zjKddl/Xoa69E/KN9pC+nUxHeVq9OuuxD4EViTtMgTUiTLE5la/9EXr44YWZv7ow1Nc=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=syrmia.com;
Received: from VE1PR03MB5246.eurprd03.prod.outlook.com (2603:10a6:802:a1::22)
 by VI1PR0301MB2254.eurprd03.prod.outlook.com (2603:10a6:800:29::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.26; Mon, 24 Aug
 2020 19:21:30 +0000
Received: from VE1PR03MB5246.eurprd03.prod.outlook.com
 ([fe80::3568:5b4f:ab6b:e362]) by VE1PR03MB5246.eurprd03.prod.outlook.com
 ([fe80::3568:5b4f:ab6b:e362%6]) with mapi id 15.20.3261.026; Mon, 24 Aug 2020
 19:21:30 +0000
From: Filip Bozuta <Filip.Bozuta@syrmia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 0/2] Introducing functionality for a group of 4 time64
 syscalls
Date: Mon, 24 Aug 2020 21:21:14 +0200
Message-Id: <20200824192116.65562-1-Filip.Bozuta@syrmia.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0017.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:16::27) To VE1PR03MB5246.eurprd03.prod.outlook.com
 (2603:10a6:802:a1::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (147.91.217.238) by
 ZR0P278CA0017.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:16::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.24 via Frontend Transport; Mon, 24 Aug 2020 19:21:29 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [147.91.217.238]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b3ab4386-7d58-4c64-11c4-08d84862e764
X-MS-TrafficTypeDiagnostic: VI1PR0301MB2254:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0301MB225484E36E04D770D87EF583EB560@VI1PR0301MB2254.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1775;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YP7pGlc/EAdUigrM+vptMY/C+ZT8vb+cyqdLLayWF4eZUy02T5NTaZQAZdunDOfSv2fmcHfiMv/+7iUXpdfLzxYypq+bgdrHnjQNiYT2sLcAzmwRSaiF/utdDc6bAWqn0HMT2E8SbB2iodJWB74gHU/ONAF4jinbHp809BEDANjD5qLgu81xu4XbQL8qvNinddjNKPtUBXaYPtSx1ixc2cy+LYhgIblmQDsnPjHu9fXBHgSUa/FSIdoV9HIeLq0K+cTPAa5FpB4T+VTk7iheY0x5VfqDpOCDjMKU6XY5tGIfAod5CtTOn3tqM2JN30j+LYtaK5cJ3iofC/yTOBW7ivNgn63AmIvD3DB4xjpCEs9FX7tk2Yve+BKsfjez8nqU
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VE1PR03MB5246.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(346002)(376002)(39830400003)(136003)(396003)(366004)(6666004)(4744005)(956004)(2616005)(5660300002)(66556008)(66476007)(66946007)(2906002)(1076003)(478600001)(4326008)(107886003)(83380400001)(6916009)(6512007)(8936002)(6486002)(186003)(6506007)(69590400007)(16526019)(86362001)(316002)(52116002)(8676002)(36756003)(54906003)(26005);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: PQG8R2Zx9MhzV9cDmI6o/vcFaO+LcLjKP0i2j/hPqcHVLVKS6YwkcrjEgL825QWzBQketd5+hayQ9muY5IeJObIAstSQSRYONUJUhD76OETZ61iZm4T+dOelWTgN400ftZaVDGiim0dytQow49RHHCKZxO64uP6vs4mtOKYdYCwTJi5e4QLm+5VuPg8ImEkCdzcLAcRqMfDCVksNXboob8ecxuWyspCJ/sMPsNzwAkbAG6sap0i1yq1j3SQNWPJR+pTRRvoS02MmacheSiAwxpyIcHNdorbCQs3ptn1MUma/Pup9MNXIUPkca2LpVXTX5tEmqKHEgCBAE7lnoCa+inma00dqo8duiMxXHxYR3bluFJQc78BL1lRqK7HMSGV8OxjqxZb7PBbd96HV958CzCLH5eNUIrKm8yAe8RUiETLsFsSECpGkjGnXCDh14aKNRMsrX8XvkyBjKuH+Z0fFz00r5ypFizh/iYIXdP1O9UBbGjCy9F0ngcNHU6BEhbyxStkxfsNxASBIXC8QAwoncYbLSFLIk6bR3vALqKuOyFTNFisXJzbXCZLeTu1DptwBUf1/d4ZLkemHL/MtCTeMBdFwmJ/zLxGVPmcEZk3Tp5zluuvIAGSX3iD41i6HazR2Z+xA3HmiBEy73ITsRv+wtg==
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3ab4386-7d58-4c64-11c4-08d84862e764
X-MS-Exchange-CrossTenant-AuthSource: VE1PR03MB5246.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2020 19:21:30.2053 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lwEDFzdRWZVfR5oHNPDWePMnngjwjR03WnHwrpSmtpTt2H3HK3vw0dMEt5a4/TOtrP04SXTE1ZP2QB6rnw6gMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0301MB2254
Received-SPF: pass client-ip=40.107.7.128;
 envelope-from=Filip.Bozuta@syrmia.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/24 15:21:42
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_SORBS_WEB=1.5, SPF_HELO_PASS=-0.001,
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
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 Filip Bozuta <Filip.Bozuta@syrmia.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This two patch series introduces functionality for a group
of 4 2038 safe syscalls.

The list of implemented syscalls and implementation details
can be found in the patch commit messages.

Testing method:

    The implementation of the implemented syscalls was tested
    using already existing tests from LTP test suite which
    was built inside chroot.

*v2:
    -Added check for 'clock_nanosleep_time64()' which returns
     '-TARGET_EFAULT' if conversion of 'struct timespec64'
     between host and target

    -Removed unnecesary special errno handling for 'PPC'

*v3:
    -Removed unnecesary pointer to timex structure 'phtx'

Filip Bozuta (2):
  linux-user: Add support for 'clock_nanosleep_time64()' and
    'clock_adjtime64()'
  linux-user: Add support for 'rt_sigtimedwait_time64()' and
    'sched_rr_get_interval_time64()'

 linux-user/syscall.c      | 190 +++++++++++++++++++++++++++++++++++++-
 linux-user/syscall_defs.h |  31 +++++++
 2 files changed, 219 insertions(+), 2 deletions(-)

-- 
2.25.1


