Return-Path: <SRS0=a3Gm=5D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3415C10DCE
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 14:24:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D09A2076D
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 14:24:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="qP+DXKy3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D09A2076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51312 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEZcD-0008R4-KD
	for qemu-devel@archiver.kernel.org; Wed, 18 Mar 2020 10:24:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53006)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jEZbW-0007wi-Hy
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 10:23:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jEZbV-0007UP-CW
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 10:23:30 -0400
Received: from mail-db8eur05on2127.outbound.protection.outlook.com
 ([40.107.20.127]:7521 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jEZbR-00074m-JH; Wed, 18 Mar 2020 10:23:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hc9IVgXSHXDW2XcRgRJMdI89tB2sJbSI6DM8gPd3R4bnPbVky+47vra07Vh3SQyFnOzo+Yl+58dqJbOaRy5jShKWEwhtlxAGUjFW5y10N9UF46sCiJBYop9KlXEYbZhWL7rLjNNbSIUAz2DIc/3sQn/0WHlTb4Kb02JcAv1n9ibdoyS4VJH78hUjDo0wUNSiFQv2TMZkoipVOCUGuCNciPHG0kTGkmrkKR766HYOB7hiH8TR1bCjYsfXPlrR5WHf0tpMj0YGlnnImDRlGgD0nmbWqKDZvsZr/HfcQe0GOkS032f7zsWp9+s1QR7hEc6A7mIZQi/8rDFehNUxO7LgGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ADb3mAmFUlSsOVW4F501cHELcm62rIcYJYSlSPIvC18=;
 b=mZnl5ffEqqnkIKw4uzhHe//+4r/b8KomkWkN/kye/zPziLrP9wQKfJ6lRThDnY62B711sGfixbuW/KW3qpydTQOYIYYp/tM7S42SGo+YrEUGT3yX+A4tm/DKQ1SMrKrFclHAabztcDzczQfe4AxCxbvPzITEObaByO7RDQ/t0vYF3nnzcIZizneiTJBJWDive6quEmpYd/5MfP1ZDowRkgBmZcW2hHSDpXfT4Xhr3ZaGlaxz/niCkqrHQtK8QOMY0yzq3OU6nCKFD99t23DPvb6c86GbuVGSDpVS2CH59nltz+t4uZojF0c0ihoTpdgp6VBHG1RYEt0AvMbmg6XYew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ADb3mAmFUlSsOVW4F501cHELcm62rIcYJYSlSPIvC18=;
 b=qP+DXKy3+HdBPn0x2Zw0EDFUkZesmaYSLcJJVW+XN73pSU+PLpD9oPEbgQ8BcsHfestsSspzKnVID9TrwzGQ8bGX4i77sZCDAei9umibXhk4BuNRk1hfvrngmtPnmhF8kI3mhwZ5XsCPa9EKIMeihnVH3aUrmel7sapRwu9HLRc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from HE1PR0802MB2507.eurprd08.prod.outlook.com (10.175.35.136) by
 HE1PR0802MB2508.eurprd08.prod.outlook.com (10.175.32.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.18; Wed, 18 Mar 2020 14:23:22 +0000
Received: from HE1PR0802MB2507.eurprd08.prod.outlook.com
 ([fe80::4d32:e4e1:5b9f:240f]) by HE1PR0802MB2507.eurprd08.prod.outlook.com
 ([fe80::4d32:e4e1:5b9f:240f%12]) with mapi id 15.20.2835.017; Wed, 18 Mar
 2020 14:23:22 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [RFC (fix for 5.0?)] block/io: do not do pointer arithmetic on void *
Date: Wed, 18 Mar 2020 17:22:53 +0300
Message-ID: <20200318142253.2809-1-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HE1P190CA0051.EURP190.PROD.OUTLOOK.COM (2603:10a6:7:52::40)
 To HE1PR0802MB2507.eurprd08.prod.outlook.com
 (2603:10a6:3:e1::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.249) by
 HE1P190CA0051.EURP190.PROD.OUTLOOK.COM (2603:10a6:7:52::40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.19 via Frontend Transport; Wed, 18 Mar 2020 14:23:21 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.249]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 64217f54-aef5-4b3b-2d3c-08d7cb47e9ad
X-MS-TrafficTypeDiagnostic: HE1PR0802MB2508:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0802MB25087835403FEEFC8DDAC180C1F70@HE1PR0802MB2508.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:849;
X-Forefront-PRVS: 03468CBA43
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(4636009)(346002)(39850400004)(366004)(376002)(396003)(136003)(199004)(2616005)(1076003)(956004)(52116002)(81156014)(4326008)(8676002)(86362001)(81166006)(6916009)(6486002)(966005)(4744005)(66946007)(2906002)(107886003)(6506007)(36756003)(6512007)(5660300002)(316002)(66476007)(66556008)(26005)(478600001)(8936002)(16526019)(186003)(6666004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:HE1PR0802MB2508;
 H:HE1PR0802MB2507.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TM4HbNIi6JMfeWaLS0fRo/LPRZzVeQGt5NN2UMk0Y6kZtxtDMuU/i4Smc6NqPMjUdxnlzv2DGEy3C633Su3p74XmB6GGOzXUqOHblXArPT6rVO8aZ0l3e+dCVmxEzGsrqUW+RfxV8cx81N98sMeyYKTV+esy0qU7bCfZmNL5bTVvwSvvKd/lLxywNQlIpKz94gnKRws71GLivFAIJJ6007cTbp92/bPJh95yRC5ZhAxz69zgpwM6vFx7W+Av8bHkMIEOtbOjfhM042UQwWp1S7pFU9S51+oBvGYCGvG76xh+RYIlKWHSJrFyVfjQiHwaNK3IdbD4WEET4A/AK3YV49jH/+A3scFTf0FFcup34S/CCtitPynUgZ1qrR8cOx/sUNjSwnbpbJqYmBzq2D76X14xjVWR1UWDQ0ijVhRCSGpCviGWzCrdyuVomEN2jTcKl/zwux6d3JlngDrGA6PBhedd9+PeXpLA+zykCocVc1b4fTcfUg5YQd5tgdewkWsQPyYijZ2Q02JLzRLwn9UDkg==
X-MS-Exchange-AntiSpam-MessageData: sJJUGkrPhYALsgP6mfHnW1sy67O0ybVbq2Phd3/rl7lEEjBpcBQvoQ59bdd2Fln+IYp3Oi8DaqReQhMFJdYHf3Mn980dY9ZAsGa5Du3SPH8Nrmonh83eAJeBoOfq9RDVtPEVH2Sj9T5/2ewJMi67NQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64217f54-aef5-4b3b-2d3c-08d7cb47e9ad
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2020 14:23:22.6108 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KEtpCosKTxxYkYjS0YpTPMJZC92QyjL5pUlWiTVwML5/2+zSTmcLvVVEOlay8zfKBFap4+HSR2VaHMi/o529epSptJGeJNy0FxOEKUvCY9M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0802MB2508
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.20.127
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
Cc: kwolf@redhat.com, fam@euphon.net, vsementsov@virtuozzo.com,
 qemu-devel@nongnu.org, mreitz@redhat.com, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---

Hi all!

C standard doesn't allow pointer arithmetic on void *.
Still, gcc allows it as an extension:
 https://gcc.gnu.org/onlinedocs/gcc-4.8.0/gcc/Pointer-Arith.html

I can create a series of patches like this. Do we need it?

Also, where is documented which compilers are supported by Qemu?

 block/io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/io.c b/block/io.c
index aba67f66b9..539178aed5 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1277,7 +1277,7 @@ static int coroutine_fn bdrv_co_do_copy_on_readv(Bdrv=
Child *child,
      * modifying the image file.  This is critical for zero-copy guest I/O
      * where anything might happen inside guest memory.
      */
-    void *bounce_buffer =3D NULL;
+    char *bounce_buffer =3D NULL;
=20
     BlockDriver *drv =3D bs->drv;
     int64_t cluster_offset;
--=20
2.21.0


