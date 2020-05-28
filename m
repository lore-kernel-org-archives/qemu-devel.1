Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 484C2C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 09:50:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C242B207BC
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 09:50:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="sxJpWk7i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C242B207BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59262 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeFB2-0003AM-GC
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 05:50:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37726)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jeF5h-00006Z-4C; Thu, 28 May 2020 05:44:45 -0400
Received: from mail-eopbgr80134.outbound.protection.outlook.com
 ([40.107.8.134]:2978 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jeF5b-0002k0-Ho; Thu, 28 May 2020 05:44:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HeR7UTkYyWqWZ3Gmnl3TFMto+r1gRYnhp5vFmaUksVWsYHIH8G9bMd1fGbh375d/jkZRvoJyh1vBtdodmquG4yRF/B74M8vE9zOu1dpEiVruAtSi3eEB5QhOQ952POwOvR9flioQwmSX1nuDuhGZxWBrY45gyAg6lCK/elIaaFrhg/rHKORvNl2wnXctdbKHsp5960NawfHREnexvT1+EHRIYSJMPSY9yVZ9yYIvj4NkQ/cjLuTzLPt6Yb68KDxU+26Kt9koX8WaYbGQ4Cz6W42tz47GKvjMT9CpIvS2+LzbkaJRz8S3TIUF32r93+5HNzA5qr2gljykoeOTHkT/pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+aE2yYUwYV4BpjdOm1rjPDIEmnj2o3YLrx3WA1dK4PE=;
 b=YrqujVMVlAasfIMzgk1+wQKC/B2DXRFpvvCwzZnApNb0QrVqDL3ozQLzwT00EkDx6UpdfBaDY+N9TDft7/3UM1acK13JIDaS1Ua6sCqD0P7I8NkZYbjrgL/hgdMIL9/yeYy887ZYvONiJxxOtwzIrOp+uQsZ3/mW5etfUvxU0RfTOPN1+N0gE7wiWgsSHh29VYtgY5A4DVsJh7bG0p9UaDzZXyhA5+1qQROiC+tcs4Z0Nc1RgeVZPKGMjuIcgckt6g03QQMQLpw0Hp88fhu4EOK/Ru2xuJiIquu7unR9wPXjjYwmmvD76OqyPcfWQNsP9gg/mrC4q2YQOms5jFr74A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+aE2yYUwYV4BpjdOm1rjPDIEmnj2o3YLrx3WA1dK4PE=;
 b=sxJpWk7iROFvDBkDenal8Sgq6ELSOP/kIOPFd3DozHe7dX8h8FNl4I0F7uB36jUO+HuR+Sp15keKfOkHgWqlZntzppRzigSl7OjUKG7IhVUTPaA9K5xEy0BILK8Y0Z/sz5mflSwe6jlk2GfkwrcCyPJ6jr2TA2kCxfchCmq8RAw=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5366.eurprd08.prod.outlook.com (2603:10a6:20b:10b::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.17; Thu, 28 May
 2020 09:44:30 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%4]) with mapi id 15.20.3045.018; Thu, 28 May 2020
 09:44:30 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v3 10/10] qed: Simplify backing reads
Date: Thu, 28 May 2020 12:44:05 +0300
Message-Id: <20200528094405.145708-11-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200528094405.145708-1-vsementsov@virtuozzo.com>
References: <20200528094405.145708-1-vsementsov@virtuozzo.com>
Content-Type: text/plain
X-ClientProxiedBy: AM3PR05CA0089.eurprd05.prod.outlook.com
 (2603:10a6:207:1::15) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.localdomain (185.215.60.178) by
 AM3PR05CA0089.eurprd05.prod.outlook.com (2603:10a6:207:1::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3045.19 via Frontend Transport; Thu, 28 May 2020 09:44:29 +0000
X-Mailer: git-send-email 2.18.0
X-Originating-IP: [185.215.60.178]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 892a2302-1733-48fc-1df0-08d802ebb800
X-MS-TrafficTypeDiagnostic: AM7PR08MB5366:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB53660E73E7AC04DE298EC95FC18E0@AM7PR08MB5366.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2150;
X-Forefront-PRVS: 0417A3FFD2
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I+P5QLGL4jdEFRvEPUZWI7xbkXaI7X2XlR5BqQ7VCY2OOjdLhFK4sPEmTKfx+VJ6S/gVHILv/Qyk+3bQLwlDn5pvf8ISK2gHETb6hzFkJoxRtxbNXYhZ2sUTkIvRlk09oD/w2OZDEKOMcf+EumydWjA0H25tkgPeGpzbwbBg5qFg48NjmQ/2hTglsTiT19SukBWqWBbVKTD8x81kgHmmJMxtoPi5t+RLBsN5lQTDr35mVH0rrPUq2BQnQfzuKPPZt3wdHrItjVcb5seYVzoTCfpjWrEP5lYU9eAXLhQbAuFt3xldJx7FMB/2qaqMtzdOd2J4uWmnFWUSd+Vp7/G9Lw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39850400004)(366004)(136003)(346002)(376002)(396003)(2616005)(86362001)(316002)(5660300002)(7416002)(956004)(1076003)(6916009)(66946007)(83380400001)(6666004)(66476007)(66556008)(8936002)(4326008)(6512007)(36756003)(478600001)(8676002)(26005)(186003)(16526019)(2906002)(52116002)(6486002)(6506007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: eInFMrdpYytw5fJ+ODj9Woun7XulAFQuJjL0PIlh4QiJbxJTL64SwK39scoUqF0HO8ywLiEWxa8+03ERSesYVK6h2WWwzDUtkjudLg7PWf5gAQlkYCLtN7xTvd4B5u/kDAYHE0S5X7cRY72mvz00rApJswGCK3SlTIEN9szYl+aBLo7FRn6Vwt1POiJMH7B6/ylguqf9ckcMT6Tw2ioVW97niA4oJSpol0UxN/9JyB4N2ZH9DHPAiA1dMUDxe1193tnwKEOM2ymkG7fCySydgDIfzKKt7+JbyWujX9ad+C02ED/vi9eCormAG/2rgyTH8SvAtWwNiFSSrlPiboKqXsDGDGbxg+putB1WKcR5O6d4zkHqWMY5D9GnHQOBhEEA2pUUI5wng4xiR8qYtFsnWvOobUeZZpiwDSmi41K39X+YSmVm32ET3gs91CQEspfTx+79Zo0PBUdsN1achZVE6GVWwqi8/jurH4Mi0xTj+Tk=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 892a2302-1733-48fc-1df0-08d802ebb800
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2020 09:44:30.2800 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K8mattUKXvaxPiLuPhG0zbNcVy6A5YTov8tV3y3s/1k93c/NN1qgOf2a0j3xBGQ4YY8xtosL6HSyD9GAidxc0JRzI6piYRw0iQh9YvLmeVg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5366
Received-SPF: pass client-ip=40.107.8.134;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 05:44:18
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
 ronniesahlberg@gmail.com, codyprime@gmail.com, sw@weilnetz.de, pl@kamp.de,
 qemu-devel@nongnu.org, mreitz@redhat.com, stefanha@redhat.com,
 pbonzini@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Eric Blake <eblake@redhat.com>

The other four drivers that support backing files (qcow, qcow2,
parallels, vmdk) all rely on the block layer to populate zeroes when
reading beyond EOF of a short backing file.  We can simplify the qed
code by doing likewise.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/qed.h |  1 -
 block/qed.c | 64 +++++------------------------------------------------
 2 files changed, 6 insertions(+), 59 deletions(-)

diff --git a/block/qed.h b/block/qed.h
index 42c115d822..3d12bf78d4 100644
--- a/block/qed.h
+++ b/block/qed.h
@@ -140,7 +140,6 @@ typedef struct QEDAIOCB {
 
     /* Current cluster scatter-gather list */
     QEMUIOVector cur_qiov;
-    QEMUIOVector *backing_qiov;
     uint64_t cur_pos;               /* position on block device, in bytes */
     uint64_t cur_cluster;           /* cluster offset in image file */
     unsigned int cur_nclusters;     /* number of clusters being accessed */
diff --git a/block/qed.c b/block/qed.c
index a2dd952699..ece8b9bb60 100644
--- a/block/qed.c
+++ b/block/qed.c
@@ -849,56 +849,18 @@ static BDRVQEDState *acb_to_s(QEDAIOCB *acb)
  * @s:              QED state
  * @pos:            Byte position in device
  * @qiov:           Destination I/O vector
- * @backing_qiov:   Possibly shortened copy of qiov, to be allocated here
- * @cb:             Completion function
- * @opaque:         User data for completion function
  *
  * This function reads qiov->size bytes starting at pos from the backing file.
  * If there is no backing file then zeroes are read.
  */
 static int coroutine_fn qed_read_backing_file(BDRVQEDState *s, uint64_t pos,
-                                              QEMUIOVector *qiov,
-                                              QEMUIOVector **backing_qiov)
+                                              QEMUIOVector *qiov)
 {
-    uint64_t backing_length = 0;
-    size_t size;
-    int ret;
-
-    /* If there is a backing file, get its length.  Treat the absence of a
-     * backing file like a zero length backing file.
-     */
     if (s->bs->backing) {
-        int64_t l = bdrv_getlength(s->bs->backing->bs);
-        if (l < 0) {
-            return l;
-        }
-        backing_length = l;
-    }
-
-    /* Zero all sectors if reading beyond the end of the backing file */
-    if (pos >= backing_length ||
-        pos + qiov->size > backing_length) {
-        qemu_iovec_memset(qiov, 0, 0, qiov->size);
-    }
-
-    /* Complete now if there are no backing file sectors to read */
-    if (pos >= backing_length) {
-        return 0;
-    }
-
-    /* If the read straddles the end of the backing file, shorten it */
-    size = MIN((uint64_t)backing_length - pos, qiov->size);
-
-    assert(*backing_qiov == NULL);
-    *backing_qiov = g_new(QEMUIOVector, 1);
-    qemu_iovec_init(*backing_qiov, qiov->niov);
-    qemu_iovec_concat(*backing_qiov, qiov, 0, size);
-
-    BLKDBG_EVENT(s->bs->file, BLKDBG_READ_BACKING_AIO);
-    ret = bdrv_co_preadv(s->bs->backing, pos, size, *backing_qiov, 0);
-    if (ret < 0) {
-        return ret;
+        BLKDBG_EVENT(s->bs->file, BLKDBG_READ_BACKING_AIO);
+        return bdrv_co_preadv(s->bs->backing, pos, qiov->size, qiov, 0);
     }
+    qemu_iovec_memset(qiov, 0, 0, qiov->size);
     return 0;
 }
 
@@ -915,7 +877,6 @@ static int coroutine_fn qed_copy_from_backing_file(BDRVQEDState *s,
                                                    uint64_t offset)
 {
     QEMUIOVector qiov;
-    QEMUIOVector *backing_qiov = NULL;
     int ret;
 
     /* Skip copy entirely if there is no work to do */
@@ -925,13 +886,7 @@ static int coroutine_fn qed_copy_from_backing_file(BDRVQEDState *s,
 
     qemu_iovec_init_buf(&qiov, qemu_blockalign(s->bs, len), len);
 
-    ret = qed_read_backing_file(s, pos, &qiov, &backing_qiov);
-
-    if (backing_qiov) {
-        qemu_iovec_destroy(backing_qiov);
-        g_free(backing_qiov);
-        backing_qiov = NULL;
-    }
+    ret = qed_read_backing_file(s, pos, &qiov);
 
     if (ret) {
         goto out;
@@ -1339,8 +1294,7 @@ static int coroutine_fn qed_aio_read_data(void *opaque, int ret,
         qemu_iovec_memset(&acb->cur_qiov, 0, 0, acb->cur_qiov.size);
         r = 0;
     } else if (ret != QED_CLUSTER_FOUND) {
-        r = qed_read_backing_file(s, acb->cur_pos, &acb->cur_qiov,
-                                  &acb->backing_qiov);
+        r = qed_read_backing_file(s, acb->cur_pos, &acb->cur_qiov);
     } else {
         BLKDBG_EVENT(bs->file, BLKDBG_READ_AIO);
         r = bdrv_co_preadv(bs->file, offset, acb->cur_qiov.size,
@@ -1365,12 +1319,6 @@ static int coroutine_fn qed_aio_next_io(QEDAIOCB *acb)
     while (1) {
         trace_qed_aio_next_io(s, acb, 0, acb->cur_pos + acb->cur_qiov.size);
 
-        if (acb->backing_qiov) {
-            qemu_iovec_destroy(acb->backing_qiov);
-            g_free(acb->backing_qiov);
-            acb->backing_qiov = NULL;
-        }
-
         acb->qiov_offset += acb->cur_qiov.size;
         acb->cur_pos += acb->cur_qiov.size;
         qemu_iovec_reset(&acb->cur_qiov);
-- 
2.18.0


