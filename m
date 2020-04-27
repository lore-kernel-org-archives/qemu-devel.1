Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93471C54FD0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 14:41:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 460EE206D4
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 14:41:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="iwZg8jsl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 460EE206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48626 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jT4xB-0002wo-3U
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 10:41:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56920)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jT4vA-0008JW-Sd
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 10:39:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jT4vA-0007nQ-0l
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 10:39:44 -0400
Received: from mail-eopbgr40124.outbound.protection.outlook.com
 ([40.107.4.124]:49833 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jT4v3-0007iT-Hr; Mon, 27 Apr 2020 10:39:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eF0WTSh5le4p4snOOvR039P4MEcwy/gQhIKx+2IeRovTjBh2Olro6sjLv83Yk6AqQhxF6T856Zk5kmY25X6g8Mk/F32wO5HL0udLT+SPKslnjlnPabZU1xibBGuj41Z/Tn5SEv6rxZGeudIOBN+H781YQZATzK/S0CU7zxUEWR0HJJP+bQaJs0KisrZ7hE3rT31ZugXuNXXZDcBBpgawFDcVJljHGqFMdOHrTyaNlXlg/OFVtmhoArxivKqak607499OQrqcaLIYNOr0DgGL1BGvVUm+ITaAwnXj9ZKeTQr4qOsXLMKGmngRsPIUfOIm6K/QpP6ufQlXtTdUr/DPAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pBsTKOfdeaYxD8YTy5iDd2s7PklFJjA0Pe3Rsu7nlJk=;
 b=Jf8nDalLazGFEx6LZMzltdZe2dpkWP1cQ59Ky7uOUwno52/LPVxnxvAmIIz2j0+ncYMNMo+dNjngafed3jXbFzPTXvlkTjIpOc8rMVrXknCIss9SOfrhsrcWwtbiHu/EdIQCMJZuLkAYrkmU4nkSN/1rFdeUzgTi2wKWH4dv1FO8JWk3AqFF8jnyvrKkzpy/TTmt5/EAihWQ+k54rOrrVNfYESAbyXtDnXZ/3oiyYSBGooWYlyPMCbFdses9zUXABYhBCw1Wib0u+P9e3QfTPvBuiGlURM2gqTx3hIc7eWB8bLwnNPg1HZe6lcy9WAvfeyOG1dZCy2p2C+KyjziFLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pBsTKOfdeaYxD8YTy5iDd2s7PklFJjA0Pe3Rsu7nlJk=;
 b=iwZg8jsl/JZxz9P6Znnu0bWasUiGbstZKZBlD2FFfPCHGiDE06loK7k9N4Z38KEscQp/JQiAs7/OsjzEGEcLZZ5W098T8hq/ld41XrdzsOCgKy4JnbNlD7DiERc9Vy50BRPk0WTesmKoBqbLdURWrx8t09f0GPWHXcW04IEo9lc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5336.eurprd08.prod.outlook.com (2603:10a6:20b:105::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Mon, 27 Apr
 2020 14:39:34 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2937.020; Mon, 27 Apr 2020
 14:39:34 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 5/9] block/io: expand in_flight inc/dec section: simple
 cases
Date: Mon, 27 Apr 2020 17:39:03 +0300
Message-Id: <20200427143907.5710-6-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200427143907.5710-1-vsementsov@virtuozzo.com>
References: <20200427143907.5710-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FRYP281CA0010.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::20)
 To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (185.215.60.182) by
 FRYP281CA0010.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2937.13 via Frontend Transport; Mon, 27 Apr 2020 14:39:33 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.182]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 311b4f26-27be-4f44-81b9-08d7eab8cdc8
X-MS-TrafficTypeDiagnostic: AM7PR08MB5336:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB53364888811680277B12840BC1AF0@AM7PR08MB5336.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0386B406AA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(376002)(136003)(346002)(366004)(39840400004)(478600001)(52116002)(6916009)(2616005)(956004)(4326008)(8676002)(36756003)(107886003)(6666004)(5660300002)(2906002)(316002)(30864003)(66476007)(6486002)(66946007)(6512007)(8936002)(69590400007)(186003)(6506007)(66556008)(16526019)(26005)(86362001)(1076003)(81156014);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JjaVV/SafuzwFn2gtupZj/LT4+DtMT4iiBSn6R19hoFbUG27wO5cfqyoa5xcoMZrjkX2K/J1ZmPbfcCUdwPavwzBi/UVJ/h21EoMcYSyUBzF2rZzNgM5bYGXqJh18nOA2AW0WrBGev4r1paIRUGEYJpZDq2AFohFjSuAJxJHZ0U1h8i9RiRKjbxBo2nhjGdqybJDUPi4ip9JYwkBLQPV4nA4JN3kVnDW5n68gnI+bGuuj84u6BojqTbUMqbXBfHgfEP3DqlHxr/3ljLwu98SVE5KrV9BzBvRP78u2891GTPl53q1+pIsPf6qiGWV9L5j8qqzjbcbXdbO0lW9sLXje/6AMHR81VcgzbcIGuNok6ZZTe4jOrZm7Oei/lLk83Tv9G58qiYcnBtDKhI3kE0ktUmLXj8F9E00pZOKpXKOdu3xr9psU/2VglMk2j6tKWXf3E/TwD1XoKEpQlLyPFDvdMZURgVPz6inQC4t+d4Y+Xisou+TN+cVhsGICgZ10LzG
X-MS-Exchange-AntiSpam-MessageData: gqdDZolIetGbHUpXdWKugFEWJRNn3uVFkowRC6FUmMiyrAC7swyuE0dxKnN7zdFTuzEZcv1xW/ZmKO5pC4aGvP8b3lkaOK4mc3UJWjhjMWd/SYiMaVSpEJMz3CPwV/yzu/w+/8q1CHorRe8P0xkS/Dumz0u1/xC8N/gCX0PxTK5nD1KQIjSUcM26Mzn/wLbs6EURPvPJVPpKsJaq0K58rgxTgrX2AanHEUSMTQ36BYPtp0816HtJ7GJFWSR/GU9iGORUwstGwGZJrra4x7AaGodROLPOjTC2D+YqNNNjaLSZQ18rh3a1YfsKhDRjZLONZy6IAtuUGQbfLk9wuAiz9fJLDCZ+Cn2UExclqNur3XTXdgarWOoMEhZk0aaXN39fs00wY55THHis3efGGC/oquarH27LOF7OvBps/fk8TsZ89cO1yOROnXiQsxlPww2NP94aOexsiuTy/58rC3tntq6hJmx51lIqauTocPD+2YvjThgCSJrZel6NKZDXUIC9RhCzVUXgjWc6tpPHe9cPWg+Nnqc9TNk++/duLEitD0ydFu8b2xOC+3CmG3oNIBhMFhpkMmb8wQptrQNukQD3phHIRHHJF5CcdNMkqXKHQejS+Tork+uKE/+ylzVBjDpMLENUtandSIUiv6F0OwvQ3dPsJ7teQupQExXY54z5Jco2+OdqKIdRy+OIJkxvrF87rzjeroDaQ+/Hsd84nA44Rp484QuzLjAtxgZn+0A73t1gyiYapIAM9nrTdWFavvLSpVwDdyd+JCl9I5MVFS7JjrsuDLSZfs24xTOhBgqetWw=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 311b4f26-27be-4f44-81b9-08d7eab8cdc8
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2020 14:39:34.5448 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nuLgl6vuN0VdaDA0Xqx10JSOktALFDyaFvHR/3OC8pF6SjuE3rjY7uG0KJyoAopcX+JazrrJ+FDnHt/KhjqXrj3xI79x8ZAA6ic+dyalB80=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5336
Received-SPF: pass client-ip=40.107.4.124;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR03-DB5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/27 10:39:33
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Received-From: 40.107.4.124
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

It's safer to expand in_flight request to start before enter to
coroutine in synchronous wrappers, due to the following (theoretical)
problem:

Consider write.
It's possible, that qemu_coroutine_enter only schedules execution,
assume such case.

Then we may possibly have the following:

1. Somehow check that we are not in drained section in outer code.

2. Call bdrv_pwritev(), assuming that it will increase in_flight, which
will protect us from starting drained section.

3. It calls bdrv_prwv_co() -> bdrv_coroutine_enter() (not yet increased
in_flight).

4. Assume coroutine not yet actually entered, only scheduled, and we go
to some code, which starts drained section (as in_flight is zero).

5. Scheduled coroutine starts, and blindly increases in_flight, and we
are in drained section with in_flight request.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/io.c | 161 +++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 124 insertions(+), 37 deletions(-)

diff --git a/block/io.c b/block/io.c
index 061f3f2590..a91d8c1e21 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1511,7 +1511,8 @@ int coroutine_fn bdrv_co_preadv(BdrvChild *child,
     return bdrv_co_preadv_part(child, offset, bytes, qiov, 0, flags);
 }
 
-int coroutine_fn bdrv_co_preadv_part(BdrvChild *child,
+/* To be called between exactly one pair of bdrv_inc/dec_in_flight() */
+static int coroutine_fn bdrv_do_preadv_part(BdrvChild *child,
     int64_t offset, unsigned int bytes,
     QEMUIOVector *qiov, size_t qiov_offset,
     BdrvRequestFlags flags)
@@ -1540,8 +1541,6 @@ int coroutine_fn bdrv_co_preadv_part(BdrvChild *child,
         return 0;
     }
 
-    bdrv_inc_in_flight(bs);
-
     /* Don't do copy-on-read if we read data before write operation */
     if (atomic_read(&bs->copy_on_read)) {
         flags |= BDRV_REQ_COPY_ON_READ;
@@ -1554,13 +1553,26 @@ int coroutine_fn bdrv_co_preadv_part(BdrvChild *child,
                               bs->bl.request_alignment,
                               qiov, qiov_offset, flags);
     tracked_request_end(&req);
-    bdrv_dec_in_flight(bs);
 
     bdrv_padding_destroy(&pad);
 
     return ret;
 }
 
+int coroutine_fn bdrv_co_preadv_part(BdrvChild *child,
+    int64_t offset, unsigned int bytes,
+    QEMUIOVector *qiov, size_t qiov_offset,
+    BdrvRequestFlags flags)
+{
+    int ret;
+
+    bdrv_inc_in_flight(child->bs);
+    ret = bdrv_do_preadv_part(child, offset, bytes, qiov, qiov_offset, flags);
+    bdrv_dec_in_flight(child->bs);
+
+    return ret;
+}
+
 static int coroutine_fn bdrv_co_do_pwrite_zeroes(BlockDriverState *bs,
     int64_t offset, int bytes, BdrvRequestFlags flags)
 {
@@ -1922,7 +1934,8 @@ int coroutine_fn bdrv_co_pwritev(BdrvChild *child,
     return bdrv_co_pwritev_part(child, offset, bytes, qiov, 0, flags);
 }
 
-int coroutine_fn bdrv_co_pwritev_part(BdrvChild *child,
+/* To be called between exactly one pair of bdrv_inc/dec_in_flight() */
+static int coroutine_fn bdrv_do_pwritev_part(BdrvChild *child,
     int64_t offset, unsigned int bytes, QEMUIOVector *qiov, size_t qiov_offset,
     BdrvRequestFlags flags)
 {
@@ -1962,7 +1975,6 @@ int coroutine_fn bdrv_co_pwritev_part(BdrvChild *child,
         return 0;
     }
 
-    bdrv_inc_in_flight(bs);
     /*
      * Align write if necessary by performing a read-modify-write cycle.
      * Pad qiov with the read parts and be sure to have a tracked request not
@@ -1987,7 +1999,19 @@ int coroutine_fn bdrv_co_pwritev_part(BdrvChild *child,
 
 out:
     tracked_request_end(&req);
-    bdrv_dec_in_flight(bs);
+
+    return ret;
+}
+
+int coroutine_fn bdrv_co_pwritev_part(BdrvChild *child,
+    int64_t offset, unsigned int bytes, QEMUIOVector *qiov, size_t qiov_offset,
+    BdrvRequestFlags flags)
+{
+    int ret;
+
+    bdrv_inc_in_flight(child->bs);
+    ret = bdrv_do_pwritev_part(child, offset, bytes, qiov, qiov_offset, flags);
+    bdrv_dec_in_flight(child->bs);
 
     return ret;
 }
@@ -2014,17 +2038,18 @@ typedef struct RwCo {
     BdrvRequestFlags flags;
 } RwCo;
 
+/* To be called between exactly one pair of bdrv_inc/dec_in_flight() */
 static void coroutine_fn bdrv_rw_co_entry(void *opaque)
 {
     RwCo *rwco = opaque;
 
     if (!rwco->is_write) {
-        rwco->ret = bdrv_co_preadv(rwco->child, rwco->offset,
-                                   rwco->qiov->size, rwco->qiov,
+        rwco->ret = bdrv_do_preadv_part(rwco->child, rwco->offset,
+                                   rwco->qiov->size, rwco->qiov, 0,
                                    rwco->flags);
     } else {
-        rwco->ret = bdrv_co_pwritev(rwco->child, rwco->offset,
-                                    rwco->qiov->size, rwco->qiov,
+        rwco->ret = bdrv_do_pwritev_part(rwco->child, rwco->offset,
+                                    rwco->qiov->size, rwco->qiov, 0,
                                     rwco->flags);
     }
     aio_wait_kick();
@@ -2047,6 +2072,8 @@ static int bdrv_prwv_co(BdrvChild *child, int64_t offset,
         .flags = flags,
     };
 
+    bdrv_inc_in_flight(child->bs);
+
     if (qemu_in_coroutine()) {
         /* Fast-path if already in coroutine context */
         bdrv_rw_co_entry(&rwco);
@@ -2055,6 +2082,9 @@ static int bdrv_prwv_co(BdrvChild *child, int64_t offset,
         bdrv_coroutine_enter(child->bs, co);
         BDRV_POLL_WHILE(child->bs, rwco.ret == NOT_DONE);
     }
+
+    bdrv_dec_in_flight(child->bs);
+
     return rwco.ret;
 }
 
@@ -2699,15 +2729,14 @@ typedef struct BdrvVmstateCo {
     int                 ret;
 } BdrvVmstateCo;
 
+/* To be called between exactly one pair of bdrv_inc/dec_in_flight() */
 static int coroutine_fn
-bdrv_co_rw_vmstate(BlockDriverState *bs, QEMUIOVector *qiov, int64_t pos,
+bdrv_do_rw_vmstate(BlockDriverState *bs, QEMUIOVector *qiov, int64_t pos,
                    bool is_read)
 {
     BlockDriver *drv = bs->drv;
     int ret = -ENOTSUP;
 
-    bdrv_inc_in_flight(bs);
-
     if (!drv) {
         ret = -ENOMEDIUM;
     } else if (drv->bdrv_load_vmstate) {
@@ -2717,17 +2746,19 @@ bdrv_co_rw_vmstate(BlockDriverState *bs, QEMUIOVector *qiov, int64_t pos,
             ret = drv->bdrv_save_vmstate(bs, qiov, pos);
         }
     } else if (bs->file) {
-        ret = bdrv_co_rw_vmstate(bs->file->bs, qiov, pos, is_read);
+        bdrv_inc_in_flight(bs->file->bs);
+        ret = bdrv_do_rw_vmstate(bs->file->bs, qiov, pos, is_read);
+        bdrv_dec_in_flight(bs->file->bs);
     }
 
-    bdrv_dec_in_flight(bs);
     return ret;
 }
 
+/* To be called between exactly one pair of bdrv_inc/dec_in_flight() */
 static void coroutine_fn bdrv_co_rw_vmstate_entry(void *opaque)
 {
     BdrvVmstateCo *co = opaque;
-    co->ret = bdrv_co_rw_vmstate(co->bs, co->qiov, co->pos, co->is_read);
+    co->ret = bdrv_do_rw_vmstate(co->bs, co->qiov, co->pos, co->is_read);
     aio_wait_kick();
 }
 
@@ -2735,8 +2766,12 @@ static inline int
 bdrv_rw_vmstate(BlockDriverState *bs, QEMUIOVector *qiov, int64_t pos,
                 bool is_read)
 {
+    int ret;
+
+    bdrv_inc_in_flight(bs);
+
     if (qemu_in_coroutine()) {
-        return bdrv_co_rw_vmstate(bs, qiov, pos, is_read);
+        ret = bdrv_do_rw_vmstate(bs, qiov, pos, is_read);
     } else {
         BdrvVmstateCo data = {
             .bs         = bs,
@@ -2749,8 +2784,12 @@ bdrv_rw_vmstate(BlockDriverState *bs, QEMUIOVector *qiov, int64_t pos,
 
         bdrv_coroutine_enter(bs, co);
         BDRV_POLL_WHILE(bs, data.ret == -EINPROGRESS);
-        return data.ret;
+        ret = data.ret;
     }
+
+    bdrv_dec_in_flight(bs);
+
+    return ret;
 }
 
 int bdrv_save_vmstate(BlockDriverState *bs, const uint8_t *buf,
@@ -2828,16 +2867,14 @@ void bdrv_aio_cancel_async(BlockAIOCB *acb)
 /**************************************************************/
 /* Coroutine block device emulation */
 
-int coroutine_fn bdrv_co_flush(BlockDriverState *bs)
+/* To be called between exactly one pair of bdrv_inc/dec_in_flight() */
+static int coroutine_fn bdrv_do_flush(BlockDriverState *bs)
 {
     int current_gen;
-    int ret = 0;
-
-    bdrv_inc_in_flight(bs);
+    int ret;
 
-    if (!bdrv_is_inserted(bs) || bdrv_is_read_only(bs) ||
-        bdrv_is_sg(bs)) {
-        goto early_exit;
+    if (!bdrv_is_inserted(bs) || bdrv_is_read_only(bs) || bdrv_is_sg(bs)) {
+        return 0;
     }
 
     qemu_co_mutex_lock(&bs->reqs_lock);
@@ -2935,8 +2972,17 @@ out:
     qemu_co_queue_next(&bs->flush_queue);
     qemu_co_mutex_unlock(&bs->reqs_lock);
 
-early_exit:
+    return ret;
+}
+
+int coroutine_fn bdrv_co_flush(BlockDriverState *bs)
+{
+    int ret;
+
+    bdrv_inc_in_flight(bs);
+    ret = bdrv_do_flush(bs);
     bdrv_dec_in_flight(bs);
+
     return ret;
 }
 
@@ -2945,11 +2991,12 @@ typedef struct FlushCo {
     int ret;
 } FlushCo;
 
+/* To be called between exactly one pair of bdrv_inc/dec_in_flight() */
 static void coroutine_fn bdrv_flush_co_entry(void *opaque)
 {
     FlushCo *rwco = opaque;
 
-    rwco->ret = bdrv_co_flush(rwco->bs);
+    rwco->ret = bdrv_do_flush(rwco->bs);
     aio_wait_kick();
 }
 
@@ -2961,6 +3008,8 @@ int bdrv_flush(BlockDriverState *bs)
         .ret = NOT_DONE,
     };
 
+    bdrv_inc_in_flight(bs);
+
     if (qemu_in_coroutine()) {
         /* Fast-path if already in coroutine context */
         bdrv_flush_co_entry(&flush_co);
@@ -2970,11 +3019,14 @@ int bdrv_flush(BlockDriverState *bs)
         BDRV_POLL_WHILE(bs, flush_co.ret == NOT_DONE);
     }
 
+    bdrv_dec_in_flight(bs);
+
     return flush_co.ret;
 }
 
-int coroutine_fn bdrv_co_pdiscard(BdrvChild *child, int64_t offset,
-                                  int64_t bytes)
+/* To be called between exactly one pair of bdrv_inc/dec_in_flight() */
+static int coroutine_fn bdrv_do_pdiscard(BdrvChild *child, int64_t offset,
+                                         int64_t bytes)
 {
     BdrvTrackedRequest req;
     int max_pdiscard, ret;
@@ -3012,7 +3064,6 @@ int coroutine_fn bdrv_co_pdiscard(BdrvChild *child, int64_t offset,
     head = offset % align;
     tail = (offset + bytes) % align;
 
-    bdrv_inc_in_flight(bs);
     tracked_request_begin(&req, bs, offset, bytes, BDRV_TRACKED_DISCARD);
 
     ret = bdrv_co_write_req_prepare(child, offset, bytes, &req, 0);
@@ -3083,7 +3134,18 @@ int coroutine_fn bdrv_co_pdiscard(BdrvChild *child, int64_t offset,
 out:
     bdrv_co_write_req_finish(child, req.offset, req.bytes, &req, ret);
     tracked_request_end(&req);
-    bdrv_dec_in_flight(bs);
+    return ret;
+}
+
+int coroutine_fn bdrv_co_pdiscard(BdrvChild *child,
+                                  int64_t offset, int64_t bytes)
+{
+    int ret;
+
+    bdrv_inc_in_flight(child->bs);
+    ret = bdrv_do_pdiscard(child, offset, bytes);
+    bdrv_dec_in_flight(child->bs);
+
     return ret;
 }
 
@@ -3094,11 +3156,12 @@ typedef struct DiscardCo {
     int ret;
 } DiscardCo;
 
+/* To be called between exactly one pair of bdrv_inc/dec_in_flight() */
 static void coroutine_fn bdrv_pdiscard_co_entry(void *opaque)
 {
     DiscardCo *rwco = opaque;
 
-    rwco->ret = bdrv_co_pdiscard(rwco->child, rwco->offset, rwco->bytes);
+    rwco->ret = bdrv_do_pdiscard(rwco->child, rwco->offset, rwco->bytes);
     aio_wait_kick();
 }
 
@@ -3112,6 +3175,8 @@ int bdrv_pdiscard(BdrvChild *child, int64_t offset, int64_t bytes)
         .ret = NOT_DONE,
     };
 
+    bdrv_inc_in_flight(child->bs);
+
     if (qemu_in_coroutine()) {
         /* Fast-path if already in coroutine context */
         bdrv_pdiscard_co_entry(&rwco);
@@ -3121,6 +3186,8 @@ int bdrv_pdiscard(BdrvChild *child, int64_t offset, int64_t bytes)
         BDRV_POLL_WHILE(child->bs, rwco.ret == NOT_DONE);
     }
 
+    bdrv_dec_in_flight(child->bs);
+
     return rwco.ret;
 }
 
@@ -3411,9 +3478,12 @@ static void bdrv_parent_cb_resize(BlockDriverState *bs)
  * If 'exact' is true, the file must be resized to exactly the given
  * 'offset'.  Otherwise, it is sufficient for the node to be at least
  * 'offset' bytes in length.
+ *
+ * To be called between exactly one pair of bdrv_inc/dec_in_flight()
  */
-int coroutine_fn bdrv_co_truncate(BdrvChild *child, int64_t offset, bool exact,
-                                  PreallocMode prealloc, Error **errp)
+static int coroutine_fn bdrv_do_truncate(BdrvChild *child,
+                                         int64_t offset, bool exact,
+                                         PreallocMode prealloc, Error **errp)
 {
     BlockDriverState *bs = child->bs;
     BlockDriver *drv = bs->drv;
@@ -3444,7 +3514,6 @@ int coroutine_fn bdrv_co_truncate(BdrvChild *child, int64_t offset, bool exact,
         new_bytes = 0;
     }
 
-    bdrv_inc_in_flight(bs);
     tracked_request_begin(&req, bs, offset - new_bytes, new_bytes,
                           BDRV_TRACKED_TRUNCATE);
 
@@ -3493,6 +3562,19 @@ int coroutine_fn bdrv_co_truncate(BdrvChild *child, int64_t offset, bool exact,
 
 out:
     tracked_request_end(&req);
+
+    return ret;
+}
+
+int coroutine_fn bdrv_co_truncate(BdrvChild *child,
+                                  int64_t offset, bool exact,
+                                  PreallocMode prealloc, Error **errp)
+{
+    int ret;
+    BlockDriverState *bs = child->bs;
+
+    bdrv_inc_in_flight(bs);
+    ret = bdrv_do_truncate(child, offset, exact, prealloc, errp);
     bdrv_dec_in_flight(bs);
 
     return ret;
@@ -3507,10 +3589,11 @@ typedef struct TruncateCo {
     int ret;
 } TruncateCo;
 
+/* To be called between exactly one pair of bdrv_inc/dec_in_flight() */
 static void coroutine_fn bdrv_truncate_co_entry(void *opaque)
 {
     TruncateCo *tco = opaque;
-    tco->ret = bdrv_co_truncate(tco->child, tco->offset, tco->exact,
+    tco->ret = bdrv_do_truncate(tco->child, tco->offset, tco->exact,
                                 tco->prealloc, tco->errp);
     aio_wait_kick();
 }
@@ -3528,6 +3611,8 @@ int bdrv_truncate(BdrvChild *child, int64_t offset, bool exact,
         .ret        = NOT_DONE,
     };
 
+    bdrv_inc_in_flight(child->bs);
+
     if (qemu_in_coroutine()) {
         /* Fast-path if already in coroutine context */
         bdrv_truncate_co_entry(&tco);
@@ -3537,5 +3622,7 @@ int bdrv_truncate(BdrvChild *child, int64_t offset, bool exact,
         BDRV_POLL_WHILE(child->bs, tco.ret == NOT_DONE);
     }
 
+    bdrv_dec_in_flight(child->bs);
+
     return tco.ret;
 }
-- 
2.21.0


