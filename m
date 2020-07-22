Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A513FC433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 11:27:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A0AC20787
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 11:27:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=syrmia.com header.i=@syrmia.com header.b="V5p//Q0s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A0AC20787
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=syrmia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49056 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyCu5-0005IA-Nh
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 07:27:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33270)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jyCse-0003tz-Ne
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 07:25:48 -0400
Received: from mail-vi1eur05on2137.outbound.protection.outlook.com
 ([40.107.21.137]:20408 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jyCsc-0008MN-SP
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 07:25:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZYqYGvjNZ13mo3ImHadn1YaKl0BazEPGerOXFOWY8vn7lQ+Yvkv9kJsXa3oFGJnSnWCh3hDQxopWqwdpMqofTqBbVzfp1qyLn8Fbrj/c5is47C6uTkcnYA9bEMnsPgXRQGkwS56J1DiZFdybWYY0hSmFD4SVP4/vK5tu4AbE31U0cZNfi+TapLfWynA/yFWfrMaM7N0H3l74BayJxVRuwSpvNGvrF+zGagnyoU5vXOks4rKQisrZiJjbcpadgklTvqCy88+qBo5oP+e7wU10Mg0nvDJgN93ku2t1S4BPEeAZcc8Nrz1xRYOMWO6nAh2qmZism0AJAwUEworDsOJo+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uLNeOPLef+yoEaQi+z23UxRR8rMJgY0rDAUgiXIs56o=;
 b=OH6xHUDSzFrhHyCpPlLazOCYHUnNFUG8gORwqNPV8wpbh9CJiDbUizf+0Hurre7/I0ZGrvqFYlUzxoW2KvZTQDs/UjMXhpZ10u1DM1afR28icjRgMutHNAVDGIcSz663kNgHl7AXAoh4TtbXNE8dtn0yhdcA5IrWxrGJGHSDQo1SpOEpl/FtRGjpV7zrGbNEYo9Grz9eTJDOfEzKyJd93+TQVDBGaFNeMCqevk97vYeHJ7LzkqABDpLpbqeAYcEIaeIyNeRMWZeTOYNXiMZ2jclpttowmSiEKfP8XLqZxCCF46KJhYTWdUZ6vwjrodqmvrDiCWxDcJba8xjgPREl1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uLNeOPLef+yoEaQi+z23UxRR8rMJgY0rDAUgiXIs56o=;
 b=V5p//Q0s7pvEDr/FcJtStmu4wqfQ/8kVpRbsNuKgSoJQsHRUabf4QZPjhnvJJ+wLKlpumfx0lJ4pJwd1/HNuiuXSMtRFvhZHd8Pgb7b1mk1zWHWxnHAXcuhE9BfkV99sGL8hCb801kE/8oXglZTWA/xsNbE/RcpO0QCLztzz80k=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=syrmia.com;
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com (2603:10a6:20b:d1::19)
 by AM6PR03MB4838.eurprd03.prod.outlook.com (2603:10a6:20b:81::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.22; Wed, 22 Jul
 2020 11:10:39 +0000
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::98f0:b948:78a8:f618]) by AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::98f0:b948:78a8:f618%7]) with mapi id 15.20.3216.022; Wed, 22 Jul 2020
 11:10:39 +0000
From: Filip Bozuta <Filip.Bozuta@syrmia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/2] Adding support for a group of year 2038 safe syscalls
Date: Wed, 22 Jul 2020 13:10:22 +0200
Message-Id: <20200722111024.272553-1-Filip.Bozuta@syrmia.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV0P278CA0036.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:28::23) To AM6PR03MB5233.eurprd03.prod.outlook.com
 (2603:10a6:20b:d1::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (147.91.217.239) by
 GV0P278CA0036.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:28::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3216.21 via Frontend Transport; Wed, 22 Jul 2020 11:10:38 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [147.91.217.239]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fd4b05ac-ded8-4084-9aa0-08d82e2fddd7
X-MS-TrafficTypeDiagnostic: AM6PR03MB4838:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR03MB4838C2E4D2540B31F89AB83DEB790@AM6PR03MB4838.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SmGrUXFjYqYWyAuZFsZ4d3uT6upEtk2Ax6bVvvZxfxoks+ynPuOqJT1DPKoCb/gZq1UejR50lVACY7dSAgxGTRLGOmLsKuvD/Sk85jGsaRsZTvYzR1MoXl/LdwsBEQWl8aJqCMEw6BjV9hXXhl356ic0wKciPP8NUTyRsaP2ylJFaUyqpaduh0WHslGumo4ROkESN6qNwBxlpVYEcOovSxEXig9t/S241w7M3ZHM+zQ2+OXaPWD/zHStpuKo8tRhFlD5h0i7i86LT55aGHrbhPxal9kqNk+qKbYhEPPpo5Ev3k9vilmF6cQL2d3x4NSGLU6ptDELVappSMiEPIJPo7GY334I52rBKE5rWnE/y355+Dm/zNww0KSW4jx9oeoc
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR03MB5233.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(39830400003)(376002)(136003)(346002)(396003)(366004)(107886003)(956004)(2616005)(6512007)(66476007)(66556008)(66946007)(1076003)(186003)(26005)(69590400007)(16526019)(4744005)(52116002)(5660300002)(6666004)(54906003)(86362001)(508600001)(6506007)(83380400001)(316002)(6916009)(36756003)(6486002)(8676002)(4326008)(8936002)(2906002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: +sSzH3OvknMFuW8iTg6kWTJF61peFxA8GjLxkQ2JRkgUGaFySAOvxTU48URrNbtUP2Fiv7x51TgFwwVeNNMM6lwiO19df8lwAnXb4zBnMkGgt200jjYVljKzrde9dHCIZYazqW/rzccERMPckDFEoCp3eh+QYOhS2Kp7Zi9BZomXsNE8mGzJAPKES+OShiDgzqsTdsFv/2pZ+bU2Kid6ohQTmXviRRP5zk+te2n69RVwo916oSTC7mCTeteS2WZ6l3bHkS/i4obNMnNpr8QdVsamQmCP1sNw5NG0td5ca4tO+DPJ5U6YkAFlirFVcIVm4W1a0kXIsvQFQ5mPKBWG6C7B001wLI2oVS0w1xS/woByIG4oGpxprT5aVgJBGD9vzS2yzbR8zPQFMYTJAFn1cdM8j6jkREdlWktNPOtmE5sSeCCag2WCbyehwKtd7pKyixl/NWOxefn81pbE1GW4Gl4QU5llIn7Sw2kBHiR6nv4=
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd4b05ac-ded8-4084-9aa0-08d82e2fddd7
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5233.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2020 11:10:39.5788 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oTxgpAnJtB+ofItvRJl7x8YU2LNk8O2M7GGXV3CgMhRzixRA3G3iXRt7caMVfyStuTDF+LtP8VXj9WACY1IywA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR03MB4838
Received-SPF: pass client-ip=40.107.21.137;
 envelope-from=Filip.Bozuta@syrmia.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/22 07:25:45
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

This two patch series introduces functionality for a group
of time64 syscalls.
The list of implemented syscalls and implementation details
can be found in the second patch of the series which introduces
the implementation.
The first patch introduces a little modification to already existing
converting functions that convert values of 'struct itimerspec'
between target and host and vice versa. This modification was also
used in the second patch in similar converting functions which
convert type 'struct itimerspec64' between target and host.

Testing method:

    The implementation of the implemented syscalls was tested
    using already existing tests from LTP test suite which
    was built inside chroot.

Filip Bozuta (2):
  linux-user: Modify 'target_to_host/host_to_target_itimerspec()'
  linux-user: Add support for a group of 2038 safe syscalls

 linux-user/syscall.c | 166 ++++++++++++++++++++++++++++++++++++-------
 1 file changed, 141 insertions(+), 25 deletions(-)

-- 
2.25.1


