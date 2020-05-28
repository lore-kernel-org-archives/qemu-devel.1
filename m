Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 460C7C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 10:16:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F181B20776
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 10:16:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="FCAl+9ZH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F181B20776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39566 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeFaO-0008JR-1j
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 06:16:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43858)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jeFZJ-0006OL-GR; Thu, 28 May 2020 06:15:21 -0400
Received: from mail-eopbgr140105.outbound.protection.outlook.com
 ([40.107.14.105]:20613 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jeFZG-0005Iy-Ax; Thu, 28 May 2020 06:15:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xsesurl1Ud0x60X/168fXOmPw2LpBdIe6aGqs8Ql17qq2f4peoxDLmgO0eGCdEZrnKj0vR+lCfb/fg32ovPCOMtGTihtSpZeAm7DfYz8NXDWvWh1zYmYeI2gUy7SHC3J97VMmTiYRjDnVa1zJ8WSS8ZZfw5mlQx2+Tz/psMsus3PgkX/LkmDOvPcJUb8OOa09PBMD/O2U4pGQtKQHKj3RZHorQbgk9gIVFWpu5lo54Hw0VRr6D7Su6G5Sg0LZp3mftt8U1fQeYf/DBEhumy4Tj0KPxTpvfZLWYZszMlShhzQ5W+qItR5i8JbcwZwhTBTRezHi65MVIeW/082BPTZbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mfobrG8o5y2BR64unD6GAknc7EAwCa3RuuyuVAXXeM8=;
 b=VIdUKwKlKs4tL0cGJXxHZQePUL1dEJWie4507FfmYOGKArwzmJgPr2+qod6P/n062ZfmXSOY0p7Kaajd098RnBl9bJE2GfhvKO+I/CLXeydV6+oY/zWy9laPl30t9yBd6XFk2d0xCinyXU/ZqHgPhH/xIvku94frN4/U4pGWHMDSlzUQvEPait91tWC/Ya/jR5KhZc05jpC2X0mgdnQ/Ujr6hcs/jVFMM5fOohKcWQVpFFE5uS+t0p7MZgW6AwHvPswcJ4krRfNmmVQcuOkkAWyu+j0LXqpERx5xuk+MQZQdY3iFk6wqG16v0cImOvS/STkxE+zQjN9MWUZothv+ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mfobrG8o5y2BR64unD6GAknc7EAwCa3RuuyuVAXXeM8=;
 b=FCAl+9ZHfHJHqbfqiVHDQOAz7DeVzCrpWt529nNabiWrZYmjdV6fWUJFL9f3YsPdlUhgKLhLwEyv7Iwf7keZvk5/T13xg/o7pzbLCHXm2+cmEgs8fBakwYe+ZWIsV9KGrkrd55VqsestFhVaT8H7Or/srVACtf+vVH2S0nyyTKY=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5317.eurprd08.prod.outlook.com (2603:10a6:20b:101::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.19; Thu, 28 May
 2020 10:15:14 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%4]) with mapi id 15.20.3045.018; Thu, 28 May 2020
 10:15:14 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v4 0/5] fix & merge block_status_above and is_allocated_above
Date: Thu, 28 May 2020 13:15:02 +0300
Message-Id: <20200528101507.151161-1-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.18.0
Content-Type: text/plain
X-ClientProxiedBy: AM0PR07CA0018.eurprd07.prod.outlook.com
 (2603:10a6:208:ac::31) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.178) by
 AM0PR07CA0018.eurprd07.prod.outlook.com (2603:10a6:208:ac::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3066.7 via Frontend Transport; Thu, 28 May 2020 10:15:14 +0000
X-Mailer: git-send-email 2.18.0
X-Originating-IP: [185.215.60.178]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 007a6981-1fdc-4fa8-2242-08d802f0037c
X-MS-TrafficTypeDiagnostic: AM7PR08MB5317:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB531766B27081516F8DED7CFCC18E0@AM7PR08MB5317.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-Forefront-PRVS: 0417A3FFD2
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IkvBiaD71IJjgOADEoEj0jJsweBbdTopyReVoDVXYM66wBwaP7E2nUVZ1uCfMKSU/wlu8aCQpJoEnpXa7AUo2KiO9jqlgkVKegZc+7As/hY+9alRkM/ScX1REdFC5A0TzYVjaJkMVDhXqhGOM782q9F/H1XvdKERKTMrK4Avul0gutamMmUpZIV7xoz7ITw5AM8PJ1w2KKlKNCuECPQTYcQtttZk1uG97c7BNG+BWv+WJdyyEBQTXrQYrjxrhZsiSdiGfcXynfuKEWUNhuLH4NinQTtg+igHjBF8F92FFrdLrTBfIS+hrHvVtBoEkB1xqtg1SVv4yH8GKy/97MP+aW34jcAUNyfnNKJwAiMLVarHN+GhHr/zBVNgZJ/3iW3oXfUa/lxKjGcszFQzjaUc8w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39840400004)(396003)(366004)(376002)(136003)(346002)(1076003)(26005)(6486002)(5660300002)(8936002)(6916009)(52116002)(6506007)(478600001)(83380400001)(16526019)(966005)(186003)(4326008)(2616005)(6666004)(66946007)(36756003)(107886003)(6512007)(8676002)(66476007)(956004)(316002)(66556008)(2906002)(86362001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 0dKvRjzUCrufjtiKRDxcrjKdURXZpL2nBnNlN85V3ZWztzSilTsKhcrR+CyzcrNYV5sJ7gEgZGmVwDmfsVSE2pXU4tQcQEe3u/DdQ3aInErkAmoEtEctOPpCxP2t/7iZHdq4OTqbiO32qJMzs4iC7kmJA6T5F9JRsJCFKRHyzB16kWc36ZpgkdyvEaMvngHBpqszojgGCj5alyT3LiwhtCiBVKwGOFDIgiIDa+XjThd3HeKdv66xLADHVpOHT4YnO+8liL6Xf6wHBcwNhQqhmiMJlmi/4xs9XAYuK4wHgDozi2J2s2rMwpymO+XA33eh3R32Rxyrz19vcQmzW+bxWFUqBBrymkx0Bpq6i6ezd8WUdfE6LenN3F9dPBjilzxEe0E1clyAONMbDNV2F+V9rR5x/xLOc3/Uxl6FNtqE4NBY9v/61LJj3mLS3igqedGhZkhbBM6vWCowKqLFGZLyYaDrLd+7ogdsKc3DVAala/M=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 007a6981-1fdc-4fa8-2242-08d802f0037c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2020 10:15:14.8471 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qemHSWcJinbVW9eXPmw7YXtc7lQiTrQqMo3qiv2PAOomR/MK7ui4EYqAoKpbVaSKah4naVI/nGglQF8yNd86IDZ/5dBMzC/MLz5GRo9Ch4w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5317
Received-SPF: pass client-ip=40.107.14.105;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR01-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 06:15:15
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: kwolf@redhat.com, fam@euphon.net, vsementsov@virtuozzo.com,
 qemu-devel@nongnu.org, mreitz@redhat.com, stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Thanks to Eric, the whole series is reviewed now!

v4:
01: fix grammar in comment, add Eric's r-b
02-05: add Eric's r-b

Hi all!

These series are here to address the following problem:
block-status-above functions may consider space after EOF of
intermediate backing files as unallocated, which is wrong, as these
backing files are the reason of producing zeroes, we never go further by
backing chain after a short backing file. So, if such short-backing file
is _inside_ requested sub-chain of the backing chain, we should never
report space after its EOF as unallocated.

See patches 01,04,05 for details.

Note, that this series leaves for another day the general problem
around block-status: misuse of BDRV_BLOCK_ALLOCATED as is-fs-allocated
vs go-to-backing.
Audit for this problem is done here:
"backing chain & block status & filters"
https://lists.gnu.org/archive/html/qemu-devel/2020-04/msg04706.html
And I'm going to prepare series to address this problem.

Also, get_block_status func have same disease, but remains unfixed here:
I want to make separate series for it, as it need some more refactoring,
which should be based on series
"[PATCH v5 0/7] coroutines: generate wrapper code"

Vladimir Sementsov-Ogievskiy (5):
  block/io: fix bdrv_co_block_status_above
  block/io: bdrv_common_block_status_above: support include_base
  block/io: bdrv_common_block_status_above: support bs == base
  block/io: fix bdrv_is_allocated_above
  iotests: add commit top->base cases to 274

 block/io.c                 | 105 +++++++++++++++++++------------------
 block/qcow2.c              |  16 +++++-
 tests/qemu-iotests/274     |  20 +++++++
 tests/qemu-iotests/274.out |  65 +++++++++++++++++++++++
 4 files changed, 152 insertions(+), 54 deletions(-)

-- 
2.18.0


