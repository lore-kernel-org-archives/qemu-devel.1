Return-Path: <SRS0=uFRu=5R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4373C43331
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 15:06:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99F322078C
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 15:06:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="nrxs55oc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99F322078C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJex6-0004WJ-Pe
	for qemu-devel@archiver.kernel.org; Wed, 01 Apr 2020 11:06:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38992)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jJes9-0006ca-VN
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 11:01:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jJes4-0004Em-Pu
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 11:01:41 -0400
Received: from mail-eopbgr70115.outbound.protection.outlook.com
 ([40.107.7.115]:27679 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jJes1-0004BA-Kz; Wed, 01 Apr 2020 11:01:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nyiyzipJ6xQdl2Fha6DZ2lPVoLYeP1mO5uU7rUbN+U2Ef6/zKBnH1Wo9cu40yRNl6cvT38w4AukikX7PtiyWkybCBy5jEDjqj91wb/LlAhHAaeP+3A0RxJmHb5pDi03u3vKcwI97auNJyGE8usCE22Ywi6vtEbfJgJfQujvF37Lmnid1W3yrH/NrMFoCg6tpaHdw28c5Po7jOkO8ntmJ02geovz1U1EeUa9GGaJhxcwtReitVh1jvgqPg3cwpOebhQQQc+3Ekm73klT7opB5w6/F2pVDZyUTpzrsf+i/bbAKnh4IzXyWlzFz2MMMXdVlbB0pJnm/ySEqjpOXEJJwUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E4vPecfMUyhEoG30258jqBVf60UprGH5VzrhO5ZBM64=;
 b=bEdLYBBLcazrJePsCQ+0a37xVtMvOERE35niwALnEfDunOWkIEtmONDaONzG+QKSeJpDgPjqFZRIVpePNcnWzz2TyUD7BrtTwmvq+8B08a6Yx5X/p0ZBh4iGHodQ5VIWahKUPx7t6XsMKzO/SCPnORQNL/1/C0gQS6wJeL3YaWqVdkZKFllvtaxcsbGMLo44SLIF+UV+xUYnDFxNZtZ+u2UNeciK+skRol88HeDgnT7LpQAHCDxM7jhf2Qr+2k3LECp8IFoAbplps5kRQSVDe5jq0ePTdnloI3cugv4knT9WA4Ezs8/wVv7QHseBR8Q6McxqZpXOVh7mljicG5flMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E4vPecfMUyhEoG30258jqBVf60UprGH5VzrhO5ZBM64=;
 b=nrxs55ocefnhIZccTrfue1sH80aGwuUcPJlIr0VCYBXtmimqD764BA+AJqNqiw9aQPKOeWP5wV+d9Hsfcx1n9xNqgAaT6r50Y9jPtp/wBpSLFlYXaXlyDEbfMVUyqOqr+1+qq0CBbMCAl/SZozZ/43qLCih1G99QcKGYhdN3W70=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (10.141.175.15) by
 AM7PR08MB5397.eurprd08.prod.outlook.com (10.141.175.81) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.18; Wed, 1 Apr 2020 15:01:30 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::3944:477e:1562:cfcf]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::3944:477e:1562:cfcf%8]) with mapi id 15.20.2878.014; Wed, 1 Apr 2020
 15:01:30 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 6/6] block/io: auto-no-fallback for write-zeroes
Date: Wed,  1 Apr 2020 18:01:12 +0300
Message-ID: <20200401150112.9557-7-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200401150112.9557-1-vsementsov@virtuozzo.com>
References: <20200401150112.9557-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: AM4P190CA0012.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:200:56::22) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.23) by
 AM4P190CA0012.EURP190.PROD.OUTLOOK.COM (2603:10a6:200:56::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.20 via Frontend Transport; Wed, 1 Apr 2020 15:01:30 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.23]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8ffa17d9-234d-44d4-a261-08d7d64d8f94
X-MS-TrafficTypeDiagnostic: AM7PR08MB5397:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5397C144D1B63300C966F92DC1C90@AM7PR08MB5397.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:381;
X-Forefront-PRVS: 03607C04F0
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(396003)(366004)(136003)(39840400004)(346002)(376002)(956004)(2616005)(81156014)(6916009)(6666004)(478600001)(5660300002)(86362001)(66946007)(186003)(4326008)(6512007)(16526019)(6486002)(66556008)(6506007)(81166006)(26005)(36756003)(52116002)(66476007)(2906002)(8676002)(8936002)(1076003)(107886003)(316002);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gmUaylRB7TfZOJA+aMStz5/0fFrB7vkLLpPC5uB6ED8t9JJr/qAKpoSfVFKIwY/bve9mTv8fbtufvzCD2fTI1Jfbzo1bCGQjQ4/FB/1hrPaBJy51FHQFUgM9GsxCuy9vDXC7jlnkJ1MWttZWMAoYof5J9EyX7Dmy1cvNB1msD8PC9Yb4YulldGFsNWN3nC6LNbdPTSCY6YpITpOzun3/umWoGJr+o8sefdtuf8qEFZKvihqyfoQ5wuBltVRhoogavPu6YZTusG4XTcVL8Zceu0V98pN7pxr2TAxi/+BleEYdjFWRRIfgFtHCuyb0bovHo4TP7nCA8GhmCn2tnPt52yikrZN4Iwexd6NeRLbyD6gDlv4Q5v4uUj+KynnN+KeRNA1ZASpjVuXVWWSGkaep2Ig2CKT02Ihdp5YteQ1wKCPwlVdC59Bw+uGc5H+4NbeZ
X-MS-Exchange-AntiSpam-MessageData: LZ21QJlFsIP9P1g6lrnn4TqZBpIpAOjVp2dD5ZxtStAqpBR6ZNnxUFUNBm0sqCH4GkunwADhJg2/ysKeEOJ51wBT/0DStaCDuSARo50q4QIlcS/O58955H94Rn1+hTsRK2J1Xl4+alOFSvsDSa/vMA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ffa17d9-234d-44d4-a261-08d7d64d8f94
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2020 15:01:30.7545 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 78T60hqTfjadlbM5dxY6uGPxNBmFgrMkKA+6xA5UPbakAoxeo3lmqauHUCNstch1B1SxuDhOZiMMmJ4yp4uC/8xvF7zD0xR5mXS0GxBvvMo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5397
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.7.115
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

When BDRV_REQ_NO_FALLBACK is supported, the NBD driver supports a
larger request size.  Add code to try large zero requests with a
NO_FALLBACK request prior to having to split a request into chunks
according to max_pwrite_zeroes.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/io.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/block/io.c b/block/io.c
index f8335e7212..425314a221 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1755,6 +1755,7 @@ static int coroutine_fn bdrv_co_do_pwrite_zeroes(Bloc=
kDriverState *bs,
     int alignment =3D MAX(bs->bl.pwrite_zeroes_alignment,
                         bs->bl.request_alignment);
     int max_transfer =3D MIN_NON_ZERO(bs->bl.max_transfer, MAX_BOUNCE_BUFF=
ER);
+    bool auto_no_fallback;
=20
     assert(alignment % bs->bl.request_alignment =3D=3D 0);
=20
@@ -1762,6 +1763,16 @@ static int coroutine_fn bdrv_co_do_pwrite_zeroes(Blo=
ckDriverState *bs,
         return -ENOMEDIUM;
     }
=20
+    if (!(flags & BDRV_REQ_NO_FALLBACK) &&
+        (bs->supported_zero_flags & BDRV_REQ_NO_FALLBACK) &&
+        bs->bl.max_pwrite_zeroes && bs->bl.max_pwrite_zeroes < bytes &&
+        bs->bl.max_pwrite_zeroes < bs->bl.max_pwrite_zeroes_fast)
+    {
+        assert(drv->bdrv_co_pwrite_zeroes);
+        flags |=3D BDRV_REQ_NO_FALLBACK;
+        auto_no_fallback =3D true;
+    }
+
     if ((flags & ~bs->supported_zero_flags) & BDRV_REQ_NO_FALLBACK) {
         return -ENOTSUP;
     }
@@ -1806,6 +1817,13 @@ static int coroutine_fn bdrv_co_do_pwrite_zeroes(Blo=
ckDriverState *bs,
         if (drv->bdrv_co_pwrite_zeroes) {
             ret =3D drv->bdrv_co_pwrite_zeroes(bs, offset, num,
                                              flags & bs->supported_zero_fl=
ags);
+            if (ret =3D=3D -ENOTSUP && auto_no_fallback) {
+                flags &=3D ~BDRV_REQ_NO_FALLBACK;
+                max_write_zeroes =3D
+                    QEMU_ALIGN_DOWN(MIN_NON_ZERO(bs->bl.max_pwrite_zeroes,
+                                                 INT_MAX), alignment);
+                continue;
+            }
             if (ret !=3D -ENOTSUP && (flags & BDRV_REQ_FUA) &&
                 !(bs->supported_zero_flags & BDRV_REQ_FUA)) {
                 need_flush =3D true;
--=20
2.21.0


