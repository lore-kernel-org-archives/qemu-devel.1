Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 563DCC8300A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 11:21:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2298C2076D
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 11:21:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="mpQZC1I/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2298C2076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38304 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU7Ft-0000pc-7m
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 07:21:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57752)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jU78V-000722-5D
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 07:14:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jU76z-0005Gc-Eb
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 07:13:46 -0400
Received: from mail-eopbgr70099.outbound.protection.outlook.com
 ([40.107.7.99]:12710 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jU75p-0003SE-Dr; Thu, 30 Apr 2020 07:11:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JGFmKQ3qpPkTsuZpo5ti5Akc5DwQmm2qiAHMikZt8Dd4ER/BwcWEKq4IYgvzTCULKEfd897YzlURoPiz3tt/3PgTGPYLYnXAChaTPeu/BXKElLGpAXS+pDZ0BvQrRlPAS9oEhRuAvv3ljCJfqHYzW+4hp40rOPLFu7fCU2RTUHxI1OhHIe9bWSVEZDN4xgpuC0BJ+Le8I3t8mCdXp9ekDJeSbDIA70K9wnA+NBIBfDM8mQXxbWV5t5HkjK+pMvtIZF6Xj8HoMfSE4r73KPMWZQ3yVNxRGqCX0GtR2BExoijn3KbBlUjRoBQBqwEse3zruFNxWE0sRd/8q5j2VENlIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7gjOK5UxtXkqcOWzEXiwz6TmFN33jXxQX9IKNw+i2bE=;
 b=BoPfSVpQgy6xUZ4RZOxWsrDbc05qGnxO02b8kmoFtGs2heAUUy3QWK98jt2bxvfxur7ZurBu/FxxG+3W5IxuMOgUB2E3XvibuGkDa9PN4jhhD/dG/XwzQBrgP6MAVWmkppVjjFvqssVHFBUOjM6n932mDeVPdBFztxoLqYItWE4PR/a7e848mrPalUsj9p3BhhBGvkI5L9p0VrND7NVha66S/LL+4bTuC8fCTOb2m3/DCwaqlq1HYjQh5tipz4TlYtII/1eotNN8IkVwEzV5otnMmdkhTb31BNxEp+MaTZCdwbTcaYugRZM6zr5G8O/bflF8C+xOAp2HjbGrVS5hCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7gjOK5UxtXkqcOWzEXiwz6TmFN33jXxQX9IKNw+i2bE=;
 b=mpQZC1I/sZ4Yi8SBY6GZiKk3As7pSdPN0wiWMa2pJ5rJ0mQXGwf4HUwbk2y6lC0vCyFayToGq3DQoayaue4P6iLrVU7B6xk6dxRrofbIATZJZCoifkanlaa7MU0MnnMPyNyvWsnAegMOnQDa7lKV3NJdyCAEqgd05ONZyxg/9SE=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5399.eurprd08.prod.outlook.com (2603:10a6:20b:104::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20; Thu, 30 Apr
 2020 11:10:59 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2958.020; Thu, 30 Apr 2020
 11:10:59 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v3 08/17] block/io: support int64_t bytes in
 bdrv_aligned_preadv()
Date: Thu, 30 Apr 2020 14:10:24 +0300
Message-Id: <20200430111033.29980-9-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200430111033.29980-1-vsementsov@virtuozzo.com>
References: <20200430111033.29980-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0P190CA0021.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::31) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.138) by
 AM0P190CA0021.EURP190.PROD.OUTLOOK.COM (2603:10a6:208:190::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2958.19 via Frontend Transport; Thu, 30 Apr 2020 11:10:58 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.138]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3cadcf58-0e35-4516-1bb6-08d7ecf729b3
X-MS-TrafficTypeDiagnostic: AM7PR08MB5399:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB53996680D02B38B553E168B4C1AA0@AM7PR08MB5399.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1388;
X-Forefront-PRVS: 0389EDA07F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kiZYm1zDkvmiU7Sf7SwoslBAbQIO8ZshrTuWZiwKZzMtw8UCJfpRuzB96Fisw4I4TCQow02G5ogXAZDtsx1dYREfzlJgNQskwpRlLF0/yhaEkfcWUqKMMRhnGbXA54IcZatuUDVqAhiscpa6VK7hlNmfqAk2WQlnb7wdo/pSSKDXOREBWgHI66f3vUPH4O/MaPnIhb3ByB+2mDZvoBhQd5+qLUkc7/34Ilg6YqYad+KMbjtgFW5kvqoSFS826LifrYjTqllNokI9RPJm5jsabwpNbNfIlbF5HjGIXHpvNnHBnO1pUmGaGQGnFc9Q84PYn07xg0jHdBCYMw9a2B47i1lSdohjWXnvo2g6OjW6i2H3hZ/QcKVvIVsjMITEtYr7dUIZHjts1wSHP3wFjvOdg8gtkrJG/6iSEGl+yuoCMTGc8oDd026X9PAuEiAw2e0r
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39850400004)(396003)(366004)(346002)(136003)(376002)(1076003)(36756003)(478600001)(8936002)(26005)(6512007)(7416002)(5660300002)(107886003)(6486002)(66476007)(66556008)(86362001)(6916009)(6506007)(6666004)(8676002)(316002)(2906002)(186003)(66946007)(16526019)(2616005)(956004)(4326008)(52116002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: T+NqZq7MuR6q9zqz6YTylLaTp8jnfBct2Q3XzlquL04EVrEkk2hL2gjswZ624u9yEzSz4c8HjGp2Oc/+YfFwlKLK+zc9dG9aWTM8phP/1BAquu/r3zDHKA4U2i761zhvylKXD3fYDf0BSP9rgJtf+5aC+Ld0aDR/uOkGAHK2yMcw83MQLglE9C8kcB+5P76Ac+QwLMabR4ZprnAFsqBqpqE9qqMWHm2sYJZ0PvcuNMuG9QGfwd8gWJ2tJwJ7V78+0BHcLkW4BUrct/RaZcGrmOysvEMvEgywinSIj4dCMhrbiY6/QwbcttVGSZ5maVZDCdGrP37YnX9P+YwvYVbrzMXyI7lFogFFS3FpwfDNkMoyFoBAQfTMpEA2oCzLXxT0UkYz9JDKC1TCLYR5VXEcW6tp2MbnuyZOAQJe9CmYLXMGPnuxZkLUdVl+dDVMc3bKq7qmZRBHOk0A9OAsmaI4eZ5Ufz93tRtyJmnAUMZyQIfOLGDWeNqArSpPjWgMkdo2dHpdwTRIRqwSmggGM9V1Cix9h+VS2+ma9ulrxLK5/QhBiB16Ffpro2lNPCJ/SCQqHwsp1gdiSSwuMUsdJGmVzixtz4Zp8ZUQSdQEkj3O3k4McGnBLQSeehN1lxOmgHgCi7xzxUQwH5YDsNGvQ7Xi8cgeRWMsUob0RUGpRkT5Rrl64abNz6zulv2hG5f617HRRbg2o1Scob2Is0zJmvISqPAUltzMEs7xc0sR3+LbhTOq/SrfHXw0aGAnpt1jJBTqYz3a5OuVgJ+vOUcJybBaOyKNlkCzhBb1IDbMnvNCRuQ=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cadcf58-0e35-4516-1bb6-08d7ecf729b3
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2020 11:10:59.8618 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: als/fOD1IDGfPHLfOz8/91jUOvDa9FevX7DC0o8slwQgKiGcIwNHCfU7u23lJRcsSU+Q1jaAhnUM0tRjcmln4qU1+mrRGpYQVDOtu+GGZjE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5399
Received-SPF: pass client-ip=40.107.7.99;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/30 07:10:48
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Received-From: 40.107.7.99
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
 sw@weilnetz.de, pl@kamp.de, ronniesahlberg@gmail.com, mreitz@redhat.com,
 den@openvz.org, sheepdog@lists.wpkg.org, vsementsov@virtuozzo.com,
 stefanha@redhat.com, namei.unix@gmail.com, pbonzini@redhat.com,
 jsnow@redhat.com, ari@tuxera.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We are generally moving to int64_t for both offset and bytes parameters
on all io paths.

Main motivation is realization of 64-bit write_zeroes operation for
fast zeroing large disk chunks, up to the whole disk.

We chose signed type, to be consistent with off_t (which is signed) and
with possibility for signed return type (where negative value means
error).

So, prepare bdrv_aligned_preadv() now.

Make byte variable in bdrv_padding_rmw_read() int64_t, as it defined
only to be passed to bdrv_aligned_preadv().

Series: 64bit-block-status
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/io.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/block/io.c b/block/io.c
index 6990d8cabe..d336e4e691 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1250,16 +1250,17 @@ err:
  * reads; any other features must be implemented by the caller.
  */
 static int coroutine_fn bdrv_aligned_preadv(BdrvChild *child,
-    BdrvTrackedRequest *req, int64_t offset, unsigned int bytes,
+    BdrvTrackedRequest *req, int64_t offset, int64_t bytes,
     int64_t align, QEMUIOVector *qiov, size_t qiov_offset, int flags)
 {
     BlockDriverState *bs = child->bs;
     int64_t total_bytes, max_bytes;
     int ret = 0;
-    uint64_t bytes_remaining = bytes;
+    int64_t bytes_remaining = bytes;
     int max_transfer;
 
     assert(is_power_of_2(align));
+    assert(offset >= 0 && bytes >= 0);
     assert((offset & (align - 1)) == 0);
     assert((bytes & (align - 1)) == 0);
     assert((bs->open_flags & BDRV_O_NO_IO) == 0);
@@ -1315,7 +1316,7 @@ static int coroutine_fn bdrv_aligned_preadv(BdrvChild *child,
     }
 
     while (bytes_remaining) {
-        int num;
+        int64_t num;
 
         if (max_bytes) {
             num = MIN(bytes_remaining, MIN(max_bytes, max_transfer));
@@ -1416,7 +1417,7 @@ static int bdrv_padding_rmw_read(BdrvChild *child,
     assert(req->serialising && pad->buf);
 
     if (pad->head || pad->merge_reads) {
-        uint64_t bytes = pad->merge_reads ? pad->buf_len : align;
+        int64_t bytes = pad->merge_reads ? pad->buf_len : align;
 
         qemu_iovec_init_buf(&local_qiov, pad->buf, bytes);
 
-- 
2.21.0


