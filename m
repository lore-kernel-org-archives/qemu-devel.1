Return-Path: <SRS0=thXK=BE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60B17C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jul 2020 22:20:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FDED206C1
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jul 2020 22:20:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=syrmia.com header.i=@syrmia.com header.b="a9rQ4xsC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FDED206C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=syrmia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38152 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jzSXJ-00074S-Bm
	for qemu-devel@archiver.kernel.org; Sat, 25 Jul 2020 18:20:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39258)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jzSWW-0006YB-1r
 for qemu-devel@nongnu.org; Sat, 25 Jul 2020 18:20:08 -0400
Received: from mail-db8eur05on2101.outbound.protection.outlook.com
 ([40.107.20.101]:16097 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jzSWU-000584-2i
 for qemu-devel@nongnu.org; Sat, 25 Jul 2020 18:20:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UJghFPKPofSpBOLn0N36I/sOsgK95rO9gz7PQ2LLLAY3pSv9Q4NtJVYQvy8+Ha0TUOcHJ3bILJaKtOBhCRFbxpzGxHlmM/pEoWY533wvogp2FrmPhidBW5u7bt0J2tleAHIAcjgkvpnWws6QLTH8YBYutcc6nqR5VRlVKWfrDdD5s0H35pdqHXnp5QieORD4R0/SuJBi+a4CKEJZDFPj5cdqcKKIjstrKn6Mtagz/uvhFCZU4IY+Nf6OwayVSca/o2AlyqLCbP66qjMcdyaO7GJFjF/7RDHbhPZN6vN8bzeXEGL6r0qSKdYjPZr2iSG+0At3KvefSrTyGmbjIo1uAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hpazYsP34FoSYqoffyV0AlNZx4yFs9q3GEGdqPlg+GQ=;
 b=Hh0rqtMsm8J8KtL2ENJ4RE9XjvpsFhwSUuNwKPWdw9SaH4FmEf33KBMsN1OhcHt+8sbrxvXJ72m9l6OUTvL2vIZP+w/LzyhOsAOr7e0XQrMXQqINFqfuMNd+efmslV0xh0rp2xghmrDHgtIH0J0pQlZ9+ZZ8WE3y7SBYrmRaf/TmtVmnbgHN//3SgHYUoqHKBCDLRhcIQu95mFiqQ5RQFw8cVQczUbkMhx58P1SZWvmClifKhlBbpCkTvdseuZRcVbYrtQ78Gzf5AlWn1K9DUWCghQnDtgiJsVSm0aUJ5ZsLGftpvs/hxJY1vogcp6v0dJ4N2+5B3DHSw27dR1YAcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hpazYsP34FoSYqoffyV0AlNZx4yFs9q3GEGdqPlg+GQ=;
 b=a9rQ4xsCXz0psMANWPDq2rtdyoUJQ4WQzNcmTKAyDFQPt0UBH1OAPiMxfI/2sJEQXgMTfHzsq0zEaHCm2n9c15HK2QPKwJdhuA3kU9pmyLTrovlR1VL2+51HADEnpAiwfov7RwHTQG/Lq2tXq+n8Y0TDzKjRsdTjJd79vbCnIXw=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=syrmia.com;
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com (2603:10a6:20b:d1::19)
 by AM6PR03MB4519.eurprd03.prod.outlook.com (2603:10a6:20b:11::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.23; Sat, 25 Jul
 2020 22:04:59 +0000
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::98f0:b948:78a8:f618]) by AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::98f0:b948:78a8:f618%7]) with mapi id 15.20.3216.028; Sat, 25 Jul 2020
 22:04:59 +0000
From: Filip Bozuta <Filip.Bozuta@syrmia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/2] linux-user: Introducing functionality for a group of 4
 time64 syscalls
Date: Sun, 26 Jul 2020 00:04:40 +0200
Message-Id: <20200725220442.301408-1-Filip.Bozuta@syrmia.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVAP278CA0010.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:20::20) To AM6PR03MB5233.eurprd03.prod.outlook.com
 (2603:10a6:20b:d1::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (147.91.217.235) by
 GVAP278CA0010.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:20::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3216.23 via Frontend Transport; Sat, 25 Jul 2020 22:04:58 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [147.91.217.235]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e39601a2-a058-45fc-c84f-08d830e6c5b8
X-MS-TrafficTypeDiagnostic: AM6PR03MB4519:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR03MB4519E8326EA287B3AD099A93EB740@AM6PR03MB4519.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:983;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bpZZ0E4teCcRta/mOdUKBIxU66pV+wFrBvAfkc3xNbcuHwAvJ/aRbRogtM2o6vQO1xcn8Y9LKp8Q4gNGaZAvaMheM9vPFUgf4PMmnM9oS6pGQXjv1b7hktWcECMFe5RKG5zZMMV2bwhK5cul9p2Th9k+ndTV29VUxTN0PpD3MwHS7G9ctuQtY+En62BUHh2xmMKJxeVP64hrLrEJ93nJ0ZXiJi+kwyKZM7SdmolYVgt7oZQYLj/ALSXf2rUIzUyck8RBjWmpuDC+nnVu8f4Omedm0Hux2Q7VL9s/8uVXXeOGCMOCJAadgYxwB1ZsVH5D9uFrbr3U8VvrfPSER4ckgaJCxCELQ40rWogSlFh6AJ9Q8kvnR222PfGxyZR2uAvq
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR03MB5233.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(376002)(366004)(346002)(396003)(39830400003)(136003)(107886003)(54906003)(186003)(316002)(16526019)(26005)(6506007)(52116002)(956004)(2616005)(86362001)(6916009)(508600001)(4326008)(66476007)(6512007)(1076003)(6486002)(36756003)(66946007)(6666004)(4744005)(2906002)(83380400001)(8676002)(5660300002)(8936002)(66556008)(69590400007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: cqzVz9SvUnIXaAUMWtUnP6MeRSO3u4y6TYa9zS9FZ9CCnR7GAFIWoE8MLdQCapTV9zzz3fvLJI+NUp7XSMD2lSFYokGE1BnR3epvSisHJ4M07+eM5PgVb4z2PsfiUjFEAJLB1KbCPPwEkdUm4sJ5FSlzxkRCbcLMiau9ACq2rwPgqHhTun6EehhVfhkICjBNlC3tJzAIf5aMPJRInOE6EObicbHtYeF0EggWAbiWlXxlGKecjYCNsP/tW2sCdnbBzHG9yfFw616Kefb4Dhql/QaAJurDeRwKlueafBk3DMo2sxjKkIZX3hEUBcmdU7mstSJOfpQqXsoNwTH44Q/BIawk1zTwjOd/lkYON8qU2sfAMF9qLQPtF2HT0I3WZx6zR6g2EtQm8vu+Kwy5IK5rkWze86l8gN0o9Gut1ARS931sJDpKHYqP8m+IgyG5kdiHiWYSMHRISBNcsBhYPsAb9bSszt11ILiR78IJGSM+9u8=
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e39601a2-a058-45fc-c84f-08d830e6c5b8
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5233.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2020 22:04:59.4215 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6YDIO38iYmz8Qht9wWy020pLulIgmrPxaXsAY2DNvcK1S26z6hzyb8ANuTWM09sIOVj4y7hEm/03Y3v1cOcJ7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR03MB4519
Received-SPF: pass client-ip=40.107.20.101;
 envelope-from=Filip.Bozuta@syrmia.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/25 18:20:04
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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

Filip Bozuta (2):
  linux-user: Add support for two 'clock_nanosleep_time64()' and
    'clock_adjtime64()'
  linux-user: Add support for 'rt_sigtimedwait_time64()' and
    'sched_rr_get_interval_time64()'

 linux-user/syscall.c      | 197 +++++++++++++++++++++++++++++++++++++-
 linux-user/syscall_defs.h |  31 ++++++
 2 files changed, 226 insertions(+), 2 deletions(-)

-- 
2.25.1


