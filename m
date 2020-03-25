Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05314C43331
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 13:48:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C200720663
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 13:48:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Ur8tYYwj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C200720663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36622 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH6Oh-0004SO-SV
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 09:48:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57255)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jH6NJ-0002Jq-Ts
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 09:47:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jH6NI-0005YO-Tk
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 09:47:17 -0400
Received: from mail-eopbgr70094.outbound.protection.outlook.com
 ([40.107.7.94]:37990 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jH6NF-0005TM-65; Wed, 25 Mar 2020 09:47:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J3lrj4fYrE1h9ja+LPk/plZEj60ei/4VTTX9ANGgzdt7e24O1z77yfhfFNW4/VvopNoWaJ2UZFNT1O2y05SECkDO5zmc9NyUGhs/6aVSZjG+ZegOFQ881roOhF5p2w0+sF0Egqm6gN0HXDA47BJdrkP7KbB/tBXOv6JTVk0iFQ/cTZ2acx3X44zMvGTTi2wKFH9o7enrampMnMU6PDxCmrhjtJWk4Y1PCxwfP5mzsg+4VvzCDHN/q3bzKpuiBsmC4RF2TTYypGMLxyfzeOFGyUxuHuTumWezdCYjX10NyHkJx+R/UMBOcT5S6+Q3cjJ/mvboRcKl0jf2n06BNeG4zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P1HwMVzFRLbBoBh6we35vJHLuhePQpES/7LKQatcGJ4=;
 b=Ph7EbWdI2vxgBEr73zd3ar+VzPOMzziRcwP5V9Z4T8MC4hKxFqMSPst4QvcuMdA4aIoV34HNKUDnmJM4Ld/DSRyPab8/uM1xBYMDvzTgC4PeJ8sz7hgDm7Ln+7UJC4kBUJICUliCy4qVTcEdGS2Wap0kGP84bA8DRYMlrI+HCFwD2evQgAXufR8kEWl0q4ym35X4m1wcwfbwTpS+cbDXan30c40YkkG0gyVfRCClGxNbKxIlKW9wqOJkc09vmVUVWpE4fHSuhI4yuuIXyeXDMoRbSU7HrRbrn4gPBOqBMOcjFzhjIj3ES5rAB/mZflkNRlUhm2lpNceUDgGVL0oHvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P1HwMVzFRLbBoBh6we35vJHLuhePQpES/7LKQatcGJ4=;
 b=Ur8tYYwj/MwfWld3BvpLkFd0SfYQSlBvLkRG76v6FwGaJeub1Q+b8CTtXx7/FiHlmrLaKNLOcMvQDfHXevZ35lLdni1w7YZoIyPXSW+92oU5jT2GL0pKTPZAun543Sl6VDoZulbEGEzCpmedAhLU2hQqcnQTRLHpXLcshzeykaw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (10.141.175.15) by
 AM7PR08MB5480.eurprd08.prod.outlook.com (10.141.175.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.23; Wed, 25 Mar 2020 13:47:09 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::9057:6f5a:378c:7533]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::9057:6f5a:378c:7533%6]) with mapi id 15.20.2835.023; Wed, 25 Mar 2020
 13:47:09 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 0/6] block-copy: use aio-task-pool
Date: Wed, 25 Mar 2020 16:46:33 +0300
Message-ID: <20200325134639.16337-1-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0085.eurprd02.prod.outlook.com
 (2603:10a6:208:154::26) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (185.215.60.35) by
 AM0PR02CA0085.eurprd02.prod.outlook.com (2603:10a6:208:154::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.18 via Frontend
 Transport; Wed, 25 Mar 2020 13:47:09 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.35]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5e37525b-5ccf-4607-e234-08d7d0c303ae
X-MS-TrafficTypeDiagnostic: AM7PR08MB5480:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5480076D3D20EDE724EEE8A0C1CE0@AM7PR08MB5480.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-Forefront-PRVS: 0353563E2B
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(4636009)(39850400004)(396003)(346002)(366004)(136003)(376002)(6512007)(478600001)(1076003)(69590400007)(6666004)(36756003)(2906002)(4744005)(4326008)(6486002)(16526019)(81166006)(66556008)(6916009)(107886003)(66476007)(66946007)(26005)(86362001)(316002)(52116002)(186003)(956004)(2616005)(6506007)(8936002)(8676002)(81156014)(5660300002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM7PR08MB5480;
 H:AM7PR08MB5494.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yZ9D5q4lYk7lZy1veMGtEMV8oouk5fOnLa3LBtne0LBaLvHnQ5+NJ4MeADwJHm9GKSTI4/YnNfa60nl3N29sWkjPAUKXG4UI1airDKzKxNudYOnm68tVbfC8u8jtGQebsVrUHYur8vSdC0Xy40TfwHFJVC95I0zD1dMd0+35Uwb4yUdvp6bRQTCwVvD85+BqWCM/x9S8SH1fGWXYvfN96Sk2gF2TSnq3ff4wUkC0OcYR6Z9Qzm9gvjv9KdkGVOOdZIktRRMKwq2/u+SaEKuyGnUpNUKEGNf5HBv/JlcN097d5Xiv8E9aaYLGV/qbj2yl9+EiKfl30A4gURyKrbVtyrtZBWIvvzZHuTszW8idUA24TKXLUd3oEqIGdf5WLkGtcCf5BvpuIQ3CMLcuP2vbsY8SaLcpm5Pfijn7JuerdHstE9wuKmpPq96rbB/vupbGb30Zchv8vrhVBOJJdKvP1XE6ErD/bTWpke5mD11tiaEBXdlXt8Nq8bcbKLC3YphQ
X-MS-Exchange-AntiSpam-MessageData: AI3WMZ6KjowtjhLlIHCDF+v3aoWN87nw4Gfb2REoCsnzuo7BdnFEqXxkbk89zcuJk2rM8AJFBXBiUD2miiuftEggC0b7IxzHbIgmPqjgLKkFRXPEQy1Mt3RJ4Zq3fFqeLLNblNUTXXE3glxbpiNQbg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e37525b-5ccf-4607-e234-08d7d0c303ae
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2020 13:47:09.6402 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ieGMRFw80k4mwQWfNH9+fp8Jyd0jU+yDFWVNBPZTEmrKQc2IPqma+Bk65izD3jdUuvcVWe8iMWwDpphuTEnRCEBgyYM4zTFQ0QNFB7ymwgc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5480
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.7.94
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
Cc: kwolf@redhat.com, den@openvz.org, vsementsov@virtuozzo.com,
 qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi all!

This is the next step of improving block-copy: use aio task pool.

Async copying loop has better performance than linear, which is shown
in original series (was
"[RFC 00/24] backup performance: block_status + async", so this is
called v2)

Vladimir Sementsov-Ogievskiy (6):
  block/block-copy: rename in-flight requests to tasks
  block/block-copy: alloc task on each iteration
  block/block-copy: add state pointer to BlockCopyTask
  block/block-copy: move task size initial calculation to _task_create
  block/block-copy: move block_copy_task_create down
  block/block-copy: use aio-task-pool API

 block/block-copy.c | 250 ++++++++++++++++++++++++++++++---------------
 1 file changed, 168 insertions(+), 82 deletions(-)

--=20
2.21.0


