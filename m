Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B320CC54FD0
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 13:51:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82E2220663
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 13:51:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="QUt/XrgA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82E2220663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36672 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH6R8-0000KO-N4
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 09:51:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57318)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jH6NM-0002Nq-GV
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 09:47:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jH6NL-0005aL-2x
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 09:47:20 -0400
Received: from mail-eopbgr70094.outbound.protection.outlook.com
 ([40.107.7.94]:37990 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jH6NH-0005TM-Qz; Wed, 25 Mar 2020 09:47:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JHLc2SDRRwicjyvtJkK8FAtobYX0QEdBjZslvRdDIVTzQGDg6AC+oSh8EPGM730cdGgHgm7YpxcBpCOV6JAeZtNl0MJT1bsbFcaC0XJn7Nwm1MHgfTZPczP8MB+W4dppVCuXJtbl4MztgiCF1l34KokmskJoBTqnTrP4+SQ97co6Mgsm2ktotnb40DypAcW3Yf9/vP7DULR5q6D/UK4AhwOC5xPTYZtjWAhy2utLbLj7PXCSlWP7jZJ7yBOpDbrAdSLHPyerWvfj/Lpo1V4jvdAV0irNT6FH2NS5e+QvRdZL98aE8qvnXAWdH8fmtkjkwGO+Lv9zCeeIePmJmA97bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qMdXr6e9838+J6Z05RoJZAFf1S5+vkYnp50v3UaHW7Y=;
 b=L4Rr4LtBRbsyXiKBNU1LmMMFjE2Z4MucTiIHpUBhDDvCToDYkU57T+jQszwqkIRPUw/B2EaTO1e8TdvANlr9aYnNJkMMUv1d/qpH3UPDCas1AzSAyEqdsvmUcFRG+KvTxNgZ+oo4s6awrNicFwWQfOH08s+PQFLTTD683Qt4D2yPbd7KjJ8UvuefLa2Jdg7D42PeY+YUWbhbpdu01YyYwX/NnXUW6gA8Rp1Rtqj7Ef+ybGDxPHP+833XRGstc3iAeDJUIHXOUcJr0T0r/MPuiMtbDyeKShku9m64R2yja24LYMOf1Nh+t7EE9qqxsXLSIayNv3lIEJ/8GM62WRQUiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qMdXr6e9838+J6Z05RoJZAFf1S5+vkYnp50v3UaHW7Y=;
 b=QUt/XrgApJxEq4fc68Ux/IWOPkDsjgHYUf4zfiQc3fPP/rcveFyUNe26SqQ32M8rXu6DKmNqD/kOlRXL7ugbNPImYmHK8MuLxldK5MSIWMdjAJUdiLV8TkJPIcbnIQKX8nWuFImEyj0IdWV20IXRnwoLtycmZWRpqH+wSpH4ijo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (10.141.175.15) by
 AM7PR08MB5480.eurprd08.prod.outlook.com (10.141.175.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.23; Wed, 25 Mar 2020 13:47:12 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::9057:6f5a:378c:7533]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::9057:6f5a:378c:7533%6]) with mapi id 15.20.2835.023; Wed, 25 Mar 2020
 13:47:12 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 4/6] block/block-copy: move task size initial calculation
 to _task_create
Date: Wed, 25 Mar 2020 16:46:37 +0300
Message-ID: <20200325134639.16337-5-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200325134639.16337-1-vsementsov@virtuozzo.com>
References: <20200325134639.16337-1-vsementsov@virtuozzo.com>
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
 Transport; Wed, 25 Mar 2020 13:47:11 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.35]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 287e94a0-886f-4db3-6af6-08d7d0c3052d
X-MS-TrafficTypeDiagnostic: AM7PR08MB5480:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5480DEC035E9413AD084D382C1CE0@AM7PR08MB5480.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:28;
X-Forefront-PRVS: 0353563E2B
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(4636009)(39850400004)(396003)(346002)(366004)(136003)(376002)(6512007)(478600001)(1076003)(69590400007)(6666004)(36756003)(2906002)(4326008)(6486002)(16526019)(81166006)(66556008)(6916009)(107886003)(66476007)(66946007)(26005)(86362001)(316002)(52116002)(186003)(956004)(2616005)(6506007)(8936002)(8676002)(81156014)(5660300002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM7PR08MB5480;
 H:AM7PR08MB5494.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hDGxTXCvpkfUYYucI4VjEUhqUkv/3ks1UMyOaOL74SNyYjm4NYOjCibfpRcH8UBFDzE2EJQxn+9BrKfKz6xozGTJ4ZsC7IYdciKFRG/zJTVO9goru0JNwljTUaMw6EipWM6SnOOgRUgLVKI5o2FUfAW0r+R91EgHRS68nox8d0caOsAFUnltFvgBWQPQ7vjOJAnwvMQRTADl8YVGJ8TG0r2xsMauYbqNIrK3OIcKOk1rVhXzS3Tt8+BVag7DCDsd9nK3zQaake+6OtBPyrZNgvp3gW0zqIHMbfNj431zSBWNDHAE9MgSs8F68Np3/dJnc7+VxWlVYt8S5tijvLybIaaKR1DGliHTFjb5HcUY8s8RkAF6sp4YbiZXRd3boq1iNHQUX7+Xe+ugpPqP0yLr0K2dusoxQRAyvkH8RtW2a2DLi5wYSlT43pDtKpYQ6vLDWuG9zKxGQ65f8+DBhBg7rgl4bkGbtmgvmIHsuGkEr5OoXSJbD8/7Bsw4iisCLCsP
X-MS-Exchange-AntiSpam-MessageData: lU0jLUh34mRk05iWacael//vrOJUx08v6rd6kV+/oZYkLuFC6XAWN4Xxa7myHqVTzvyrbA8CFJN2gChrzRGp6FGuX6UeQa4U2Q0okyDvMcLgd4CoNykNcvJVqS5F0wVaLtmoYRFC14pKb4MBNxQNBA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 287e94a0-886f-4db3-6af6-08d7d0c3052d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2020 13:47:12.1830 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rRJ2TiCUk00CRgPRFVJDKpbTDJR4ixr7T/qZ3szWPn86m55a9K37f2UPbLsc6bJ/aWn6zeYYjTX2C5vRnHG6HcQjV4jt6dGWKEeGyiuCtu8=
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

Comment "Called only on full-dirty region" without corresponding
assertion is a very unsafe thing. Adding assertion means call
bdrv_dirty_bitmap_next_zero twice. Instead, let's move
bdrv_dirty_bitmap_next_zero call to block_copy_task_create. It also
allows to drop cur_bytes variable which partly duplicate task->bytes.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/block-copy.c | 47 ++++++++++++++++++++++++----------------------
 1 file changed, 25 insertions(+), 22 deletions(-)

diff --git a/block/block-copy.c b/block/block-copy.c
index 63d8468b27..dd406eb4bb 100644
--- a/block/block-copy.c
+++ b/block/block-copy.c
@@ -106,12 +106,23 @@ static bool coroutine_fn block_copy_wait_one(BlockCop=
yState *s, int64_t offset,
     return true;
 }
=20
-/* Called only on full-dirty region */
 static BlockCopyTask *block_copy_task_create(BlockCopyState *s,
                                              int64_t offset, int64_t bytes=
)
 {
+    int64_t next_zero;
     BlockCopyTask *task =3D g_new(BlockCopyTask, 1);
=20
+    assert(bdrv_dirty_bitmap_get(s->copy_bitmap, offset));
+
+    bytes =3D MIN(bytes, s->copy_size);
+    next_zero =3D bdrv_dirty_bitmap_next_zero(s->copy_bitmap, offset, byte=
s);
+    if (next_zero >=3D 0) {
+        assert(next_zero > offset); /* offset is dirty */
+        assert(next_zero < offset + bytes); /* no need to do MIN() */
+        bytes =3D next_zero - offset;
+    }
+
+    /* region is dirty, so no existent tasks possible in it */
     assert(!find_conflicting_task(s, offset, bytes));
=20
     bdrv_reset_dirty_bitmap(s->copy_bitmap, offset, bytes);
@@ -480,7 +491,7 @@ static int coroutine_fn block_copy_dirty_clusters(Block=
CopyState *s,
=20
     while (bytes) {
         g_autofree BlockCopyTask *task =3D NULL;
-        int64_t next_zero, cur_bytes, status_bytes;
+        int64_t status_bytes;
=20
         if (!bdrv_dirty_bitmap_get(s->copy_bitmap, offset)) {
             trace_block_copy_skip(s, offset);
@@ -491,21 +502,13 @@ static int coroutine_fn block_copy_dirty_clusters(Blo=
ckCopyState *s,
=20
         found_dirty =3D true;
=20
-        cur_bytes =3D MIN(bytes, s->copy_size);
+        task =3D block_copy_task_create(s, offset, bytes);
=20
-        next_zero =3D bdrv_dirty_bitmap_next_zero(s->copy_bitmap, offset,
-                                                cur_bytes);
-        if (next_zero >=3D 0) {
-            assert(next_zero > offset); /* offset is dirty */
-            assert(next_zero < offset + cur_bytes); /* no need to do MIN()=
 */
-            cur_bytes =3D next_zero - offset;
-        }
-        task =3D block_copy_task_create(s, offset, cur_bytes);
-
-        ret =3D block_copy_block_status(s, offset, cur_bytes, &status_byte=
s);
+        ret =3D block_copy_block_status(s, offset, task->bytes, &status_by=
tes);
         assert(ret >=3D 0); /* never fail */
-        cur_bytes =3D MIN(cur_bytes, status_bytes);
-        block_copy_task_shrink(task, cur_bytes);
+        if (status_bytes < task->bytes) {
+            block_copy_task_shrink(task, status_bytes);
+        }
         if (s->skip_unallocated && !(ret & BDRV_BLOCK_ALLOCATED)) {
             block_copy_task_end(task, 0);
             progress_set_remaining(s->progress,
@@ -519,19 +522,19 @@ static int coroutine_fn block_copy_dirty_clusters(Blo=
ckCopyState *s,
=20
         trace_block_copy_process(s, offset);
=20
-        co_get_from_shres(s->mem, cur_bytes);
-        ret =3D block_copy_do_copy(s, offset, cur_bytes, ret & BDRV_BLOCK_=
ZERO,
+        co_get_from_shres(s->mem, task->bytes);
+        ret =3D block_copy_do_copy(s, offset, task->bytes, ret & BDRV_BLOC=
K_ZERO,
                                  error_is_read);
-        co_put_to_shres(s->mem, cur_bytes);
+        co_put_to_shres(s->mem, task->bytes);
         block_copy_task_end(task, ret);
         if (ret < 0) {
             return ret;
         }
=20
-        progress_work_done(s->progress, cur_bytes);
-        s->progress_bytes_callback(cur_bytes, s->progress_opaque);
-        offset +=3D cur_bytes;
-        bytes -=3D cur_bytes;
+        progress_work_done(s->progress, task->bytes);
+        s->progress_bytes_callback(task->bytes, s->progress_opaque);
+        offset +=3D task->bytes;
+        bytes -=3D task->bytes;
     }
=20
     return found_dirty;
--=20
2.21.0


