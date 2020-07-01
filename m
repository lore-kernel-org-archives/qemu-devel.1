Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E19BBC433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 10:54:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B30DD20747
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 10:54:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="gxqZjies"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B30DD20747
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33606 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqaO3-0003Uv-M1
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 06:54:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44670)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jqaN6-0001x5-Vi; Wed, 01 Jul 2020 06:53:44 -0400
Received: from mail-eopbgr10133.outbound.protection.outlook.com
 ([40.107.1.133]:2638 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jqaN3-0002JK-Pr; Wed, 01 Jul 2020 06:53:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=njJvstTH23u+nd8WEFK3BwCjwkuu2/6zv1jiVOKNTZ+UIJRP38Mk5QfVioPkwKL9dsMzlxhbZdcvnd+xJnFP4pdt7A9nu5Oxi0L04ScANhwxnHw1aUDfzLYkHdIqBbywzzNJsbB6c8MkpZIQ1NVDCwMR8M1MINEMb2Q1pYj+EUvADEtqApMmYcrOa2u0jdipwRagpxWg9SAhbmIxT6ebl6sHpdra2mJ0GoMI7VoWW9MTStJ6prO3BvlCqm1c1Sp+0uiCCU5/ZE+e9T7L9GM6VIr40DUXVeVfckt4LxpkWHZSu5u/pM6Ga8sUBjZhv6at3RsjmS/pXSzgW2ONit5PgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lmx+C4JP5BH+Fjs6iw+DM/L1aZkkWlPCMvT87d14boE=;
 b=kHFHO9+hM5yhDQsbs6IIjzP2JBWmVKaU8dUxDwAPXz+PqwqQ62O6Qj4LPEWXKa9MkbNfFpTGrx0sKavnQ2ko0tTqBLPclPRIeK0Frr5dp9iQjxD5qXLZAkYLwPlfVk74gsxxYNDFLXkvbt4PDvNqE25kpYNQkt6JLhWny1B4Wd/5YncXkLkYePGgz9DWknY+Yh6hpcDsRxDo65z2vwQdxlvWWdvExNKwOxX4gpcx3exnZwwXWVHkC2khdn9WAjq/1DhrLWV3aH971C9Zsma65cm5vobzbdphX0KI8K0kbU2QINVOGJW0snGsVfEJYYZJvX1zZY735juwBfau47AJ2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lmx+C4JP5BH+Fjs6iw+DM/L1aZkkWlPCMvT87d14boE=;
 b=gxqZjies90KFONL+PzvjWQw16BejKcQ+x6i1mhd63LQon6IBPwu1D1pMFId44iR97T2LsqpPVhhRiikmHmvrOn2mRkC4zjufiqEI63voqY1sjfr3y8ZOaV3GXWPDXLrzvkiC+lCRyjUElybXpXwnX2e7gssc4j3m7A3LXpxTv8M=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4850.eurprd08.prod.outlook.com (2603:10a6:20b:d2::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.26; Wed, 1 Jul
 2020 10:53:38 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%4]) with mapi id 15.20.3131.028; Wed, 1 Jul 2020
 10:53:38 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 0/5] Fix crash due to NBD export leak
Date: Wed,  1 Jul 2020 13:53:26 +0300
Message-Id: <20200701105331.121670-1-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.18.0
Content-Type: text/plain
X-ClientProxiedBy: AM0P190CA0004.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::14) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.28) by
 AM0P190CA0004.EURP190.PROD.OUTLOOK.COM (2603:10a6:208:190::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3153.20 via Frontend Transport; Wed, 1 Jul 2020 10:53:37 +0000
X-Mailer: git-send-email 2.18.0
X-Originating-IP: [185.215.60.28]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ae362955-112c-4835-5055-08d81dad0263
X-MS-TrafficTypeDiagnostic: AM6PR08MB4850:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB4850EE72029524C0FB4234EAC16C0@AM6PR08MB4850.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:312;
X-Forefront-PRVS: 04519BA941
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qNsSBJYrLk0yU6+qo+AebIdg9VmkbO62chFVaLEUkBBApIryGdqTxtytD/5fF0v8YJBjEPvfQHmnHUyIWBEuLXgWwonSdCVT1Yh8rjds7+cMkq4MfSvlvQNrWgwxdJPO3NVmYUOZaPq3F1YTNNJuoEG594VYh3Wuz2oEYOzPX7zqz+wUK3b5EO0bfZQhH/jxN+xvke0ETsBvz8XAB+9zmD/izeZlJkIawhaA/eN+2PiK6AoM5AqqnzEghm4MIgWoXLzcrWBaCHib0vUODROGVh/Flh3c7K4ZKRxNNzXRT+K1nUvBoJPg2qVMgshJKhU7sJjC50F34OUVBSPEabNclw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(366004)(39840400004)(376002)(346002)(396003)(2906002)(83380400001)(956004)(316002)(2616005)(6512007)(6916009)(107886003)(6666004)(66946007)(66556008)(4326008)(5660300002)(66476007)(86362001)(4744005)(1076003)(478600001)(186003)(6506007)(36756003)(52116002)(8936002)(26005)(16526019)(6486002)(8676002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: vyAhQnsztysRHuBEdj78WrOHfpQuToXNyHINMPtNVWdHg/YGoYG0l63nR2uh4bhdlKiYtBpbxG3dRujbKU71gt92mWH66aS64kztRVqz8/xglBUgTdKAN0py1Aw4eadb9kH2VGyvx6lWBX8TIH/ga9LVt6yCEnPrgsYVgwxldI7y2F1cPE4qIWHdV6PJHSWqf/9IV+Qsmapc0m5W9eY0ZEcntA2jqILznP1fjoOjDo3LKwNGA0498xSRQ4W7CyQ9Ef+3iMMqQbK7YMArXa1j1ajc+ywloBIcYiSMjHG2nm7kCI3RWKRKS+txv/CFj7mx3ZsZTLkPQ9EM8CAzv+NZslQQPxpHir2Sz/UlFBnoUfKTLsUGW3g2jHsG7WSGU8+UiPnLuAcJIxi+bizQAXM0CoB7T/0ZtGv0CJEfQwdfDL5QSJu34yOEBjqTVT82DlW5a6EjXSRTwlya3CswS0boEzVGkcH8uPlCOm5samSE0e4=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae362955-112c-4835-5055-08d81dad0263
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2020 10:53:38.1009 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mDHJJY4BqYuXWcbn/lf2Mie924pGNBBNDhDt8qNkRpveUwXATGfSd+MM3bIMHGwFbwwRDuj8gkVKoY1b4GVWBBDjXNGDtKzdzMuCQ1QBGUk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4850
Received-SPF: pass client-ip=40.107.1.133;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR02-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/01 06:53:39
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, qemu-devel@nongnu.org,
 mreitz@redhat.com, stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi all!

We've faced crash bug, which is reproducing on master branch as well.
The case is described in 03, where fix is suggested.
New iotest in 05 crashes without that fix.

v2:
01: reword commit msg, add Eric's r-b
02: fix type in commit msg, add Eric's r-b
03: rewrite
v1:04 split into 04 (iotests.py improvement) and 05(new test)


Vladimir Sementsov-Ogievskiy (5):
  iotests: QemuIoInteractive: use qemu_io_args_no_fmt
  iotests.py: QemuIoInteractive: print output on failure
  nbd: make nbd_export_close_all() synchronous
  iotests.py: filter_testfiles(): filter SOCK_DIR too
  iotests: test shutdown when bitmap is exported through NBD

 nbd/server.c                  |  8 +++++
 tests/qemu-iotests/299        | 65 +++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/299.out    | 10 ++++++
 tests/qemu-iotests/group      |  1 +
 tests/qemu-iotests/iotests.py | 15 +++++---
 5 files changed, 95 insertions(+), 4 deletions(-)
 create mode 100644 tests/qemu-iotests/299
 create mode 100644 tests/qemu-iotests/299.out

-- 
2.18.0


