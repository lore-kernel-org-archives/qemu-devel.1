Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCD5EC5519A
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 08:27:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3CFB20661
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 08:27:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="qf/dXi42"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3CFB20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58480 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jSz7H-000204-Fy
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 04:27:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48834)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jSz3a-0002Lk-9h
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 04:24:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jSz3Z-0007c8-Sd
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 04:24:02 -0400
Received: from mail-eopbgr70114.outbound.protection.outlook.com
 ([40.107.7.114]:29366 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jSz3Y-0007Ta-AL; Mon, 27 Apr 2020 04:24:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NulXxudmuznZ1PXaOA2nqVV8IEEDLO8qbK5fwXKsxv8x/QdiaUe+7+uQrFfYkAjwKbgdpg/JwYUofj5+oeTFIX+ouTNBLpWLpYxg57vK7UJZGeeS+PupmTYwyGPsKB3P3QvcKReaBeniG/BUUlglfdvKZo7TuKMo5mIFUvhqn+/Hlmw3dMoQx2lb8vcGxhYM83jlj6Op4mBCjvcANYREPDBvlk9QsDJec/T2Ze8KSwGHlk5VvW+IOZ/eKEY4zIXaZZfbtSChPp/mQMLgg90oYEtg//K7yb3mw7m/gfQK4l2VFnxb98e47l9TFUqkAnoZ/UiRkp6q9sEvNK5T9YLbdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AHVe5q0aGJGJfuUaocbrIbtM4T0kS9ZgXQhC/F+MQMI=;
 b=fxZV1bD1OLpusck5DC+CpI+uiNM9/pN7cS7uwZlKy1Alo3LVoA7pDHG81SkCKel1cvNXFX3N6QBEWsoBUEuys5wyM5dE5Hs8piiudJkGkao9VzbbEHKTfcpPNdRMZysbHBF7d98atD0FkoW6dkcjvdYEDYB12PfzMWZ8vQrw/e3DZjfIHvPd0Vnl1Laz2oeGCirtDymb+BHvDBwvCrJrPUZb9lPzx79nDlTVdFYs6rB9nuPtrYS4sGDnSHKNaz98EFyRdd5FoQlN3TTvsVmK21GPsSKXM7IUb8ndB5lSXafoV2lGrWrrAX3GvCWFqr16ANXWJ039q3JZI+IHJ3+uow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AHVe5q0aGJGJfuUaocbrIbtM4T0kS9ZgXQhC/F+MQMI=;
 b=qf/dXi42x4dHUwAMA8Ex+obSk7c8SNPZ/im6gGz9UEimRDfCJ7uNR45AwGjX4c4U6+gXkI7svJySQ6+YAWekwDmWN8m7r/MFXXaChau/SX2EUg6L1QbAGc25v5YBJ/UWHfbpQwWFY2kZHjqUuBcWvLzaXlRMeDshJIyLJ7jw+p4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5463.eurprd08.prod.outlook.com (2603:10a6:20b:106::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Mon, 27 Apr
 2020 08:23:58 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2937.020; Mon, 27 Apr 2020
 08:23:58 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 05/17] block/io: support int64_t bytes in
 bdrv_co_do_pwrite_zeroes()
Date: Mon, 27 Apr 2020 11:23:13 +0300
Message-Id: <20200427082325.10414-6-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200427082325.10414-1-vsementsov@virtuozzo.com>
References: <20200427082325.10414-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0004.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::14) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (185.215.60.182) by
 FR2P281CA0004.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:a::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2937.13 via Frontend Transport; Mon, 27 Apr 2020 08:23:57 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.182]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 79763d41-7f40-4e60-1ae6-08d7ea845568
X-MS-TrafficTypeDiagnostic: AM7PR08MB5463:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB54637CE9FFD5A3AE69A945D9C1AF0@AM7PR08MB5463.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-Forefront-PRVS: 0386B406AA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(136003)(396003)(376002)(346002)(39840400004)(2906002)(81156014)(6486002)(26005)(8676002)(8936002)(4326008)(6916009)(478600001)(66556008)(7416002)(66946007)(66476007)(6666004)(16526019)(316002)(2616005)(1076003)(186003)(5660300002)(52116002)(6506007)(956004)(36756003)(107886003)(6512007)(69590400007)(86362001);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wWPN3bEWDGohtZn7lGwOJ7q8I886SkFe0t+yIWNQSKO7roVaqhKeP33DVTSd4mnOysvEIZV5fOXy6sFECwB+ZZurkxzo8dEUjMeFILyatz3DSHAWzqNoq5FzFa26blUScy4XmI7SOvFs/a6bz91ulZSZyO2D0NEar0BRKeNG0jOQ9XIMR+QnIpMvQkYCkhBa52CAyDJRRQ0HIwttmSwiyxOXFjiq9DlfM0Eu24/9ffXzUrsGA8e0wrKOmjPMJxj5U+9R8aTcYXpnOlhDagq9RsBszAqL+LUi22csJVi+Xj26gOTgtidEWN2JvWJB9Xiobc07uavdeae9jcmvAlXZwXpETAWQQx40JSX8EIPnv1k0tSvdo8fxswCpgmd8S4TKCb7rFuw8uVrGytfLFYCGyfu453me3/oNo5E605yQImETA7oGw7po88PsRNSbs9UrsxbUnvuVXGT7kygq2NBYJZ1LopQH0scXEEz1YWVg1s4ELpAd+IvJ2lm2eJnxgGUo
X-MS-Exchange-AntiSpam-MessageData: WpiRm/8UoEzJhweIXb2EczVw94CdtrGVeVyg1UEjTkKM9kUHbfIS7cWLKWkChuCbrbCdMA9irQLbjSO3XunqvVftUQtY+6tGV6bAxo5ia1QGXl4CZjolgSQ6EZda/FgEyGjP7SVif+M+mAyLPFIWk2UMV5fOaqlYlKWVNTiFRv3Xo4IGyFn9vdN7eufZuuuy4fYL0iAUT9c925lpOsndKDFGjexnoUIEng5aED4K8+aqUZ8cKmRynkn6MypUvK/R0RyX6BKIHzXvjpbQc4e9HWEuvSnm0QPQppRWoLlTuqe/R5IUYz3yue8u4akFlWw4REz4T9KTxDnMeeRc5ZmMAkbL9c/I6+5vt2P3KMqmQLzGKmJ3vPNKuyAzmUGxHtbn9lDqds5ScDiDvAEEOB0ReoGiutx7MDWeujFOaobJuVBUgIQ/RzOcw7X3Bb4DGhIeOfQvOU8TROnNuZ6ohv+ZkWPRy6sCjv8TgWa5KBZ3mJYkmN9bP2AkBCY4QFC+NF1bQ9uic/YTuoKNT0CgkI4/vBZQkdJqc2vl3GEbTmB/G86idZ0ZLdwU/SBKhAhbkBe6ZY/PrgSaFukdjadt+loBXU9cSE7ApOucMM0ChD09coAQIWXe3Iu0DHrfXHuZz5oO1ZF3cgGlqbEpmdR2OcyeK6bjSMdMj4XGEnuEcwrMVNmI+XIpvbnRYdusn9PUVEiSg2c0LXHTiMvNst2RiokEF2y80GpSdhdPftXgqAOuuz8wT45HMQn0bdxaENQgwcQxlaSImrw/mF1PDotz1WKMCwXu+hTbNfRuUYtpw8T1CeU=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79763d41-7f40-4e60-1ae6-08d7ea845568
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2020 08:23:58.7465 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /+ab1dOd2VqxgOxM8xDMwlQModz7TxYunA4oQ+XShhvPyE2yBaCQ/qtitSxnz6VE5rc1jcNeRG9q7btS3l9fEy02pP2gJyDQivjGaYZxtIk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5463
Received-SPF: pass client-ip=40.107.7.114;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/27 04:23:52
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Received-From: 40.107.7.114
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
Cc: kwolf@redhat.com, fam@euphon.net, integration@gluster.org, berto@igalia.com,
 pavel.dovgaluk@ispras.ru, dillaman@redhat.com, qemu-devel@nongnu.org,
 pl@kamp.de, ronniesahlberg@gmail.com, mreitz@redhat.com, den@openvz.org,
 sheepdog@lists.wpkg.org, vsementsov@virtuozzo.com, stefanha@redhat.com,
 namei.unix@gmail.com, pbonzini@redhat.com, sw@weilnetz.de, jsnow@redhat.com,
 ari@tuxera.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We are generally moving to int64_t for both offset and bytes parameters
on all io paths. Prepare bdrv_co_do_pwrite_zeroes() now.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/io.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/block/io.c b/block/io.c
index 4796476835..c8c30e3699 100644
--- a/block/io.c
+++ b/block/io.c
@@ -42,7 +42,7 @@
 
 static void bdrv_parent_cb_resize(BlockDriverState *bs);
 static int coroutine_fn bdrv_co_do_pwrite_zeroes(BlockDriverState *bs,
-    int64_t offset, int bytes, BdrvRequestFlags flags);
+    int64_t offset, int64_t bytes, BdrvRequestFlags flags);
 
 static void bdrv_parent_drained_begin(BlockDriverState *bs, BdrvChild *ignore,
                                       bool ignore_bds_parents)
@@ -1743,7 +1743,7 @@ int coroutine_fn bdrv_co_preadv_part(BdrvChild *child,
 }
 
 static int coroutine_fn bdrv_co_do_pwrite_zeroes(BlockDriverState *bs,
-    int64_t offset, int bytes, BdrvRequestFlags flags)
+    int64_t offset, int64_t bytes, BdrvRequestFlags flags)
 {
     BlockDriver *drv = bs->drv;
     QEMUIOVector qiov;
@@ -1773,7 +1773,7 @@ static int coroutine_fn bdrv_co_do_pwrite_zeroes(BlockDriverState *bs,
     assert(max_write_zeroes >= bs->bl.request_alignment);
 
     while (bytes > 0 && !ret) {
-        int num = bytes;
+        int64_t num = bytes;
 
         /* Align request.  Block drivers can expect the "bulk" of the request
          * to be aligned, and that unaligned requests do not cross cluster
-- 
2.21.0


