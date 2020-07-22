Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C78EC433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 15:37:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDA0D2065D
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 15:37:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=syrmia.com header.i=@syrmia.com header.b="FfEfDyYZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDA0D2065D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=syrmia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyGo2-0004k2-48
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 11:37:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49842)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jyGlX-00024w-3v
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 11:34:43 -0400
Received: from mail-eopbgr00136.outbound.protection.outlook.com
 ([40.107.0.136]:51253 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jyGlV-0004dw-4K
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 11:34:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LwRn7twUO5JMYdZS5wklGc4Q9TIdgy3jgPvEhtBjk6AUJJGrRMR6+yARhsgb00mB3YrYnqcbzHrSwhEwiKoi4UYBJIhlxogdYfTSo3jCNbuk1jLWBQpZZvBMfN8T6xz8umcQVdTU0CDmJ3FfBM1/EcNIKRXSJ7bDoX2c1ana/tiviRBNzlYlkpFCnknptWIi40nwsbbHMHRya7hdcJhxHv4ynwrZThu6CetqP5fQSOJDL++Wo/JYZfhkkUycJE1eM/3USJK+YIMpBOfXVj1us9j56Mr0FfFY87VB3IbnKr4Y8sAdZ43URnw/O6sXlJl0EPJ+L8D6vTjY5Ez6CCxw5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iw2fGaNqIRQRyOEg05/I+IYMHGribVo2/3vHyDvN1zY=;
 b=lz0M99D9s7f6nOENmcS6zlmMuIaOvWN3No9LIXImnEAqK32APEE5n1SLIquCcODlPGUrZAUIIU+AIlmgpPFlbrf9czL1l/SBsVLLtOiUWkC5nZZndYHpGORd72tU1PO8oeGfbEi8VbxxcJCrJcG1VH/i7xxMCd2gu5k/fFCA6TJOnGQRv80eLy/eMcBbhUCmFBjJ1YS7OL/0e2arljMtgNWcSIIFdkZ/Fukh9eqjSjHLcKGzBNfqwv6LF0lQ5QyyVLHwsBv2FriB6lB0YLqmqaAMnV7ZNk3klZV6AJua/c6hiIpEpBYwSA9IUJkt4gSgZPM7Dg/RLBuVhlCUmpw08Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iw2fGaNqIRQRyOEg05/I+IYMHGribVo2/3vHyDvN1zY=;
 b=FfEfDyYZO6oQS8mWnzivwwK3POab1aywvdnG4w7hTgGiTJVTykVHX2+DNGbk07kQJXgccugtNUGaoLtql3MqsTPDXMIqjI5tEjXUCuDzn2WtNJQ+PaNuQmevpYNVZAFusuUCovPVe3NKaRgkZlyJA7HSb5Q9vuzG2smuVmzf7Ag=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=syrmia.com;
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com (2603:10a6:20b:d1::19)
 by AM6PR03MB6087.eurprd03.prod.outlook.com (2603:10a6:20b:e1::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.23; Wed, 22 Jul
 2020 15:34:37 +0000
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::98f0:b948:78a8:f618]) by AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::98f0:b948:78a8:f618%7]) with mapi id 15.20.3216.022; Wed, 22 Jul 2020
 15:34:37 +0000
From: Filip Bozuta <Filip.Bozuta@syrmia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/2] This two patch series introduces functionality for a
 group
Date: Wed, 22 Jul 2020 17:34:19 +0200
Message-Id: <20200722153421.295411-1-Filip.Bozuta@syrmia.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0008.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:16::18) To AM6PR03MB5233.eurprd03.prod.outlook.com
 (2603:10a6:20b:d1::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (147.91.217.235) by
 ZR0P278CA0008.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:16::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3216.21 via Frontend Transport; Wed, 22 Jul 2020 15:34:36 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [147.91.217.235]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e1bc47ba-394a-4d1c-e3d9-08d82e54bdbc
X-MS-TrafficTypeDiagnostic: AM6PR03MB6087:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR03MB60873D8CFE64673CD52CA413EB790@AM6PR03MB6087.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lok/sBiC3KNzSPlFCZYyd4jiXv+h+GfbFd743vEPkORueipYIxl8KEeLVS5vLrYGpYH4OPfUuGAsPd/cMW7yI35WJf63+zkKSqGXO7Emtez3ApZYWWpBKvYJ2OhHYnTpr5hpjfWm01WSWgY33mJ7ja+kRZYjrjJpbF1eSHRNrfzo8eLMAEvZfnEHitFigGynMqJ3Ij6X+hsg1RZ4v4nm6n9SOAS9RFTmbZOjgPFM/Y1ycacVEhXGScjq6CUTV6XU5WE4lD5XEDjV0L+emWsN937zfnpRQ+Dha6Tm9xup33lMyxCFZfGtzBu4fEl28za1jzIfZphiVrATx0mMrj90wATYO8oEzm3O3II9T7fEboxlDsC3QqvgFeTu8yFkH3IY
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR03MB5233.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(366004)(39830400003)(396003)(136003)(376002)(346002)(508600001)(6512007)(4326008)(54906003)(316002)(6916009)(1076003)(26005)(83380400001)(107886003)(86362001)(8936002)(69590400007)(2906002)(186003)(6506007)(5660300002)(6486002)(66476007)(6666004)(66556008)(66946007)(8676002)(16526019)(956004)(2616005)(36756003)(52116002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: djB28R1vf75g09tuy9/MeIhmtqH4t39o014tZTLcCQEoWqrml2S8TVLyqdQ+ZGyg2uziNFuFLLpGDBe4KHeTak6/zet+BNVDiJAmr1J45bWI1zY+DgicBqof7mz2fhWf9ZsnRqG5Sxxo21gLAIXbICT949BGjMQZJMflpFdZpVimyuaKdXK2RI+7KHE51nq6QB72bDKfqD66niJ/+p6+sVysrVbjXRKhrPKW0lcMp+JTXKu1QPlbPvUBvzSa3fUQhZOqZwfgBvyv5d/c/o/VWsujxjwS9wsJ5Y/lKnqZ+Ooe+EHE20zVwU7VkU6dcl3OmTFmOpSrw3bLFXWp89oc7zZ7GWFqUdnVp8QRC93LDuvbGJWUtm53AiPhiA9QARbEM05AE81cBYaUbz5teNzdrI16GQRaU0zoXyFSNdYAiHw+P489XtSa9dE4gVTu18U/ecRX1aMVJIWQ4axiqEADd8XTNYRPLZlgSvMl+sAU5qA=
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1bc47ba-394a-4d1c-e3d9-08d82e54bdbc
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5233.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2020 15:34:37.1097 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JUJmcP99/5KXLedhnnWAoNeQIm802bIepfHJyjg1x47CDoiyvDnz4jTQUhlMRYRw4BNPyhAhAeNX3lz/EFn6RQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR03MB6087
Received-SPF: pass client-ip=40.107.0.136;
 envelope-from=Filip.Bozuta@syrmia.com;
 helo=EUR02-AM5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/22 11:34:39
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, MSGID_FROM_MTA_HEADER=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1, RCVD_IN_SBL_CSS=3.335,
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

v2:

   *changed 'target_to_host/host_to_target_itimerspec/64()'
    to use 'offsetof()' to determine converting adress for
    'timespec' instead of 'sizeof()'

Filip Bozuta (2):
  linux-user: Modify 'target_to_host/host_to_target_itimerspec()'
  linux-user: Add support for a group of 2038 safe syscalls

 linux-user/syscall.c      | 181 ++++++++++++++++++++++++++++++++------
 linux-user/syscall_defs.h |   5 ++
 2 files changed, 160 insertions(+), 26 deletions(-)

-- 
2.25.1


