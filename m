Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB4EDC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 08:36:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96E0B207D3
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 08:36:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="QKwVZnq2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96E0B207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45872 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbKDS-0002bW-NI
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 04:36:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43286)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jbKCZ-0000gd-SW; Wed, 20 May 2020 04:35:47 -0400
Received: from mail-eopbgr80090.outbound.protection.outlook.com
 ([40.107.8.90]:21573 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jbKCX-0005RQ-DK; Wed, 20 May 2020 04:35:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lFDm21IaQwRkt3Z9oV2Lu3CZ2JuY0k/KfTe+jy7zKiRPznWQKBkm+Lt38DNEexvvVGLVQ70xJmxA9XPyYru0njNgq2z5Dl0PiOPNN2/dfjRQ88lGB2Ir5okFITgKrZ0Dyw1CE9U6Ih2fMVNfeMb7KiMkZPIM3uNEGCUezKtD2LvbhPTf+R3jDCh2SZfdpT3jZAL79I6Nhws42uWZ+BwKhQ0Q38n01j10bX2229Pkgt/RCb58GXy3R8SrA5FBvZmPxslH7yJuZYVP1qaZ17efIcPtUWB5+jqhCIeoNlU60kTt2pJoA6wJLsrk3IV8LPKsYGfJe4j9y4UknDBN8zOcoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zPY2S/PF0RrzlsbbKGyjqbBIhgYChMCf7r1mf77/+Uk=;
 b=XtmcQaDroDNd9xDPidePmoGzuaiYOo2Dowgv3sWpX8ywjSIzcFTR5GnhpJGDa1CYQ3jdqcurzUAoaj2jZTSWrBJ21tv6HShpQRQnVKvsPgq41EPtE+rasXIh+6LQuuLzNEEYruq+pAdlchnHYkKiJikH2dFEyAOtX5gKk0WYiJS7++DaiPAaAmMH6g5g3WXVQwyaIRyUe+dMiMFvzabgzhQFJP6X0zPjq+hb+zv8uSya9L+jUGB/92RPsATbHUE/xyz4OzUVzI82RSj8IJIck7puFj9OQ0THgnkGH8bMp6uRYzK9dD2URtTg0I73ACwpZ/u9UtuxIjFEcSufM2f2Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zPY2S/PF0RrzlsbbKGyjqbBIhgYChMCf7r1mf77/+Uk=;
 b=QKwVZnq28uUsMowvGl8qgnqQd9oCgpFwUFBfRFK0QLhRwhpAAzFj/rdymoNrmIxb923xwo7a0MX+lqMumgENjtZz9MkwQfgkdrvJ48hxTkbmt3+40wO3NuLEdXeAjTbmgVqKMQrvxKJw8k7G4qcSfLeKyNvYZdcEMOgiv6aZH6s=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5448.eurprd08.prod.outlook.com (2603:10a6:20b:106::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.26; Wed, 20 May
 2020 08:35:39 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3021.020; Wed, 20 May 2020
 08:35:39 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v3 0/5] fix & merge block_status_above and is_allocated_above
Date: Wed, 20 May 2020 11:35:15 +0300
Message-Id: <20200520083520.25793-1-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0092.eurprd02.prod.outlook.com
 (2603:10a6:208:154::33) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (185.215.60.147) by
 AM0PR02CA0092.eurprd02.prod.outlook.com (2603:10a6:208:154::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23 via Frontend
 Transport; Wed, 20 May 2020 08:35:38 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.147]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ca4941b1-49aa-4551-38d9-08d7fc98c6af
X-MS-TrafficTypeDiagnostic: AM7PR08MB5448:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5448FBE4A48A9105FCE9A82CC1B60@AM7PR08MB5448.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-Forefront-PRVS: 04097B7F7F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KfARmIyObhV2bOm2RPwb+mwCgPyfl6GUck7z14Pa7VWGJyTQOjOp6tFmvU2yF3DK4NWS39roSbBM9VuA2zVkOuos+zfkxx8VKX2z/v/GjrjLj9R1y3kC+acS8kB+QkTdJUWJrPdlJG6cvRsdKwNAFDVScQP+Ud+lscRGKjeHUIY9y0qzHR8kcQml/GlSblBwg8LeFCtdKxzIElPX936FM1/44B9+tl2nMuA/pG5NsBg1JkendNj5F0HR0eQXcVDsfZ1VSW7mHaFVEqKKX3grOtu4i7R1UciJIYKBeKdIlNLQvb1N7h+DguESbi80phDPR2AZhwGVFU307jxN7hPL1vfiRMXkEkESDiYzFGcA71GD6728LxZpmQXJ/PzW0xTc0e4laSVuXarzpkSCnX4tYizgYleLE6PwCi2HX0g98H9yi6VAvfnCdkvbnYWLm+KhzarxoVIIAgDg/d68wzEayyIBtCHDH49aCMSh1uIFV7blsCLnMEJb0CQ3XsjRayYejYbSgxD4f5Yd9b+fhqP229rUgrePg232Yqnicv7+4iC49PWL05wiQTDp2MRpjG92L5YOo4hoU+SlZBjnP3xdAw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(346002)(136003)(396003)(366004)(39840400004)(6506007)(26005)(8676002)(6486002)(52116002)(186003)(16526019)(966005)(1076003)(2906002)(86362001)(5660300002)(8936002)(36756003)(66556008)(4326008)(316002)(107886003)(478600001)(2616005)(69590400007)(956004)(6666004)(6512007)(66476007)(6916009)(66946007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: vGJbZLOA79QalhgVafOAdCj6ukMfudCjPZYV3tKO7VVpayIRKM6zgEgct8oEUj35wKXxCAK8jL7cDTD10krwkUl30BHoXM2dN49QnaTmUoFR/MsEEyLT8E/arXfHLeJP3BJBIqYUDVnPi+Ig5lEaygKHfUWNtHpdY43txQ51y3zdinkPVH8dR1j3MaUEFN6Z9vBayoCRhfg24bFI0b+0sZmb/xNaIB9eCWGRFJGbqCkt0l8/qn/cFB9onVmTu35M8HVyb8u31XEy+P2JhS6vPu0sts/x1s51GpklpFBYV8fAdCKu77ww9ZibgnlKThva/9mUvsADQRwjihYgV4qf0Acsh3K+qBxlAta/01Gb6iX7Hr0eVuOh1Cfrjh4JHica/E5lCc86dGrPeseg6sKA/HqWEkTpZLNSfyuu+yk5LjIpCHKD//5vQkzuGxfJa0TbYbXLeBMhJN9MoG+UBs4juAgDLMq//FpEjRrJECIrkYQjQdcalItJzSOq4eA8XVDw
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca4941b1-49aa-4551-38d9-08d7fc98c6af
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2020 08:35:39.6059 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jXTfxK8ggC5PUjDRPRhwKrKH9tBNVUinLQB+M6Al+FyeYdKI2RCgqgno4nXliVZF81OLjGis2Kfxkyhmu+5xuxpxiiBg4+Vp5c2mTunqT48=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5448
Received-SPF: pass client-ip=40.107.8.90;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/20 04:35:42
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

Hi all!

v3: fix regression in 01 [Eric]

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
which should be based on patch
"[PATCH v2] block: Factor out bdrv_run_co()"

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
2.21.0


