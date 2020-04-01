Return-Path: <SRS0=uFRu=5R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4CFDC2D0F3
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 15:08:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72C2E20776
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 15:08:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="OibTwkSh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72C2E20776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33410 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJeyP-0006pS-K4
	for qemu-devel@archiver.kernel.org; Wed, 01 Apr 2020 11:08:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38996)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jJesA-0006cq-2u
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 11:01:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jJes5-0004F3-0r
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 11:01:41 -0400
Received: from mail-eopbgr10093.outbound.protection.outlook.com
 ([40.107.1.93]:29790 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jJery-000494-4g; Wed, 01 Apr 2020 11:01:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mGAE9zky8WW1Qo2P63tw39Cukji+NqdNiJpLoJApfS43ON7gvgmtUmdYHc2m8nBVRrlDb3h6TZh9CBMyJuWXxqfoipXlugfBtSSepNa1UCO1trcti57e5u/4lUFMPAOeRn48A7FHPEQhAFEwPmTlahZ1oBjyDDhgeo4iozCOjj8a44l2FjI6tmgttOf7X4pcxT1lJE1VE4qVreAhORo04Ih45Fdx+gFx/LkRN2Cvg/bNdMBaGfMKk5lwXNjm/ztzJsj/YbRJecxaF39yHzKbb61pxdhc+odhFhzu69Tis45KBOUncGS436slwItXVu2LaPrnMa9j1gUgh1822tQ3DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z3WoCCv4H2YnJxqmhYPQHq97h5gTbEbEb+hVB6Wu7bo=;
 b=ISx7r//xWwSkJKMmL0BdOJW43Zi2LP/ZqeeBjymf1bz0FEeJV672KoAvIgPQQyc2PKT/toHUB29XD0JgJDhf1594IYBFQbmN20aPRaJ7ft6v9ehLnUqKrj6wmhCaWVlAPYSg2lYoTFhNL8PGqN8vzenfyzkoDChBvflCPdZzuJwwzwpYUE6xA0OosydcWTe01pV3VpQeHo2IEeitBhm464S4yHySQH6ZEdwSyxwFEEBLdY8GQZLKhOoFv9lWK0pwK9RwfHtDlyuYTyxB0QX+oTfNJLGQlipqqqvsSzkbBHLKFF2m5xep1/u+eTzM8P8B3EFrqSiThen9069yt3JvCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z3WoCCv4H2YnJxqmhYPQHq97h5gTbEbEb+hVB6Wu7bo=;
 b=OibTwkShr/7hQrmZlkTzxyFUzBHYqg0Wxc1kCd+9LJc2vVbDU+klOFi1JLd3+yvWA+Lcd+oenjR6/o3/RTu9VDAWnRZUBlRUmR4GWs9ii9e5UXJ4Pqj//MWD5/wuQ213XObmkR3ZnYGN+c6fdGR1sDQvqi7dC36OC7nNP7Ejayc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (10.141.175.15) by
 AM7PR08MB5494.eurprd08.prod.outlook.com (10.141.175.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2878.15; Wed, 1 Apr 2020 15:01:28 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::3944:477e:1562:cfcf]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::3944:477e:1562:cfcf%8]) with mapi id 15.20.2878.014; Wed, 1 Apr 2020
 15:01:28 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 3/6] block: add max_pwrite_zeroes_fast to BlockLimits
Date: Wed,  1 Apr 2020 18:01:09 +0300
Message-ID: <20200401150112.9557-4-vsementsov@virtuozzo.com>
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
 15.20.2856.20 via Frontend Transport; Wed, 1 Apr 2020 15:01:27 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.23]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d61ded40-b62f-4875-6076-08d7d64d8e2b
X-MS-TrafficTypeDiagnostic: AM7PR08MB5494:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5494B714EEA9B9D2FEA971A8C1C90@AM7PR08MB5494.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:538;
X-Forefront-PRVS: 03607C04F0
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(376002)(136003)(346002)(396003)(39840400004)(366004)(66946007)(66556008)(52116002)(6486002)(86362001)(186003)(107886003)(478600001)(6506007)(4326008)(2906002)(6916009)(16526019)(26005)(5660300002)(6666004)(316002)(66476007)(1076003)(81166006)(36756003)(2616005)(81156014)(8676002)(8936002)(956004)(6512007);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ntJp2fcjjRNfE4Qjs2yEDiCPQEPAJTxB7OfWcKfCogKAExZwriBuGvAMGIcJTGyZ4Xi50BcOc3FwRbJ2XdJRbj6ZqEwm1evZhzY0xjaw0P7N4eGRR6sHKddfiscd05FqRwyR1AwwC4S5mxX7up4Y/83PXALq83oVQdFVkpKq4VJKCc+RBO8KBiIjNxYKZwEulZ18ahSB2uLw1Pv9AdD415hzvkP3HGPoSx4H/01Cqw0DHoI33OdAfmEZRZbdMl1P/rjug6fhrKHERLe9Vc1qJsyCw71MSkSZu8gnfYw54StwtjYKckdzxqMx08r8Or1bDUPkMwjYy7vrPtGUJdLUVNI6k2DiRlzwB+dZ1rq+ceYZM6x13SVy7JqzaWtGUD1sA0vNjbVwHYerhuKo1bC1KphJ2AVFGnXo0/noCPiEP13qyGkUmmN+BbxUwEQBIkv0
X-MS-Exchange-AntiSpam-MessageData: RYRVOPXLnx6uvc7MNHSazu5dc1j+i7VzMYQ1CrBoHzSL9sbIp+5DLN+ORRrDdchUpSNBLvDFJPKzmHEIYylFSDHsSQvbElhPEGqssLlIJ8XrPXSRlbG7bRy42/lYcQkpzL9c1esgJbfN9nEV2SxCJw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d61ded40-b62f-4875-6076-08d7d64d8e2b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2020 15:01:28.3960 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BYLjYK0RpSF2tY5tKDSdE5sFfMTHgWCx6Npd/C8HVWZ258ML4YVQUQ9/2Ohs0kXA9oLCJvMQfwamGLSUHYQs9klGOVgCnMiQCvgCfET+uxA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5494
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.1.93
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

The NBD spec was recently updated to clarify that max_block doesn't
relate to NBD_CMD_WRITE_ZEROES with NBD_CMD_FLAG_FAST_ZERO (which
mirrors Qemu flag BDRV_REQ_NO_FALLBACK). To drop the restriction we
need new max_pwrite_zeroes_fast.

Default value of new max_pwrite_zeroes_fast is zero and it means
use max_pwrite_zeroes. So this commit semantically changes nothing.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 include/block/block_int.h |  8 ++++++++
 block/io.c                | 17 ++++++++++++-----
 2 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/include/block/block_int.h b/include/block/block_int.h
index 4c3587ea19..ea1018d598 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -624,6 +624,14 @@ typedef struct BlockLimits {
      * pwrite_zeroes_alignment. May be 0 if no inherent 32-bit limit */
     int32_t max_pwrite_zeroes;
=20
+    /*
+     * Maximum number of bytes that can zeroed at once if flag
+     * BDRV_REQ_NO_FALLBACK specified. Must be multiple of
+     * pwrite_zeroes_alignment.
+     * If 0, max_pwrite_zeroes is used for no-fallback case.
+     */
+    int64_t max_pwrite_zeroes_fast;
+
     /* Optimal alignment for write zeroes requests in bytes. A power
      * of 2 is best but not mandatory.  Must be a multiple of
      * bl.request_alignment, and must be less than max_pwrite_zeroes
diff --git a/block/io.c b/block/io.c
index aba67f66b9..07270524a9 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1751,12 +1751,13 @@ static int coroutine_fn bdrv_co_do_pwrite_zeroes(Bl=
ockDriverState *bs,
     bool need_flush =3D false;
     int head =3D 0;
     int tail =3D 0;
-
-    int max_write_zeroes =3D MIN_NON_ZERO(bs->bl.max_pwrite_zeroes, INT_MA=
X);
+    int max_write_zeroes;
     int alignment =3D MAX(bs->bl.pwrite_zeroes_alignment,
                         bs->bl.request_alignment);
     int max_transfer =3D MIN_NON_ZERO(bs->bl.max_transfer, MAX_BOUNCE_BUFF=
ER);
=20
+    assert(alignment % bs->bl.request_alignment =3D=3D 0);
+
     if (!drv) {
         return -ENOMEDIUM;
     }
@@ -1765,12 +1766,18 @@ static int coroutine_fn bdrv_co_do_pwrite_zeroes(Bl=
ockDriverState *bs,
         return -ENOTSUP;
     }
=20
-    assert(alignment % bs->bl.request_alignment =3D=3D 0);
-    head =3D offset % alignment;
-    tail =3D (offset + bytes) % alignment;
+    if ((flags & BDRV_REQ_NO_FALLBACK) && bs->bl.max_pwrite_zeroes_fast) {
+        max_write_zeroes =3D bs->bl.max_pwrite_zeroes_fast;
+    } else {
+        max_write_zeroes =3D bs->bl.max_pwrite_zeroes;
+    }
+    max_write_zeroes =3D MIN_NON_ZERO(max_write_zeroes, INT_MAX);
     max_write_zeroes =3D QEMU_ALIGN_DOWN(max_write_zeroes, alignment);
     assert(max_write_zeroes >=3D bs->bl.request_alignment);
=20
+    head =3D offset % alignment;
+    tail =3D (offset + bytes) % alignment;
+
     while (bytes > 0 && !ret) {
         int num =3D bytes;
=20
--=20
2.21.0


