Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9D61C43463
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 20:10:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B3942064B
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 20:10:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="ObAHPK5l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B3942064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJ0Eq-0000MP-Ce
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 16:10:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59558)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kJ00n-00039R-3Q; Thu, 17 Sep 2020 15:56:09 -0400
Received: from mail-eopbgr30122.outbound.protection.outlook.com
 ([40.107.3.122]:56995 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kJ00l-0005tE-0O; Thu, 17 Sep 2020 15:56:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QqIWSxZtuRonSPn1viqCxq/tX14kLLY6LMVPaBUyqBbiArhgN0yipNJi2kyKYJ3qa0wSpu91VWDtHvfFi/0zbBRGirsc1eAWb2vMTfBVRddSbOysYpHjjw87HNtH77191498f92EW49sJ7gUoiJQ+68UJ603rGmID7ckrxX6hHYn2VNAjDLs2Amw+fPtJGRsdERQd2o8yvC05CwRpmvtMNynSAA6Bai8hhVjyYlLT+FI6BkG9GFHACcmCQv3eyhDgBuyelLiVsRclVvl5o4z54AYzGC05gk+06wS33QTvCWzUqt0gXhHeORCNuzkLG58Qs+Y70qrXhL4zQyCd21LyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H+Fls0lS3+gGSaFUfNMd3ddkHBrg0Lmqh3fozjASBjo=;
 b=R0NAUJGR0S8hr0s15sUyiUQaVPUXe4hCioBxfo6kiEhbYTItG4kA6gJxxg6ectF+gUDN2SuNKvvKaKO9dYG55H889s3qc/CpuphIB+JMqs7uv/rU5epaE/b5fypvf1sKNugsaZFmumbM2b1gLGluLdml4zXJjhKgdS6h+5syqehNnjEWFq12hjldfubEbHZ8/PSttE0x6U3RO8bOzg8l5gAfr8DxE7CHypL1gAh3J9Uaz2j+9nYEsYMJr04CpNgNMSJZFaE/dsbgq2yAuxrQmU/kQ5R/BfogTByYZbWNBk8MZ3OYaGbzlbwV0lTQBoTi4Fpqm0VWc19VZQB/7O2RzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H+Fls0lS3+gGSaFUfNMd3ddkHBrg0Lmqh3fozjASBjo=;
 b=ObAHPK5lZ/EGbk8HQowcGQeFitFRh87RGxmWmp1l5RTDA7osVQDmh14bZvrM879sIQFuxsIjDoJFSBWtwcVtjgeDslFgy3FFyrzgQueNycSoSLPSOAJmrEekd54Cz2BxZdg/rxGbK7infNBi58ktrvRHA2nobloqsyPDNaAeVlY=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB5254.eurprd08.prod.outlook.com (2603:10a6:20b:d6::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Thu, 17 Sep
 2020 19:55:48 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692%8]) with mapi id 15.20.3370.019; Thu, 17 Sep 2020
 19:55:48 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, armbru@redhat.com, berto@igalia.com,
 vsementsov@virtuozzo.com, eblake@redhat.com, jsnow@redhat.com,
 stefanha@redhat.com, pbonzini@redhat.com, pavel.dovgaluk@ispras.ru,
 ari@tuxera.com, mreitz@redhat.com, kwolf@redhat.com, groug@kaod.org
Subject: [PATCH v2 13/13] block/qed: bdrv_qed_do_open: deal with errp
Date: Thu, 17 Sep 2020 22:55:19 +0300
Message-Id: <20200917195519.19589-14-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200917195519.19589-1-vsementsov@virtuozzo.com>
References: <20200917195519.19589-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM4PR05CA0011.eurprd05.prod.outlook.com (2603:10a6:205::24)
 To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.75) by
 AM4PR05CA0011.eurprd05.prod.outlook.com (2603:10a6:205::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.11 via Frontend Transport; Thu, 17 Sep 2020 19:55:47 +0000
X-Mailer: git-send-email 2.21.3
X-Originating-IP: [185.215.60.75]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 837cf95c-e4f5-4e43-f52c-08d85b43ac21
X-MS-TrafficTypeDiagnostic: AM6PR08MB5254:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB5254E1FED2C42812E3D90CFBC13E0@AM6PR08MB5254.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:826;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mQ1X36frrKbMb7pM2eCh/EHywhJHwehpEKAnWT1c26MwlyuYyZ+ZrDo8Or3DkPBZNhAjeCJYriZ7Azavq5rYf2uXFaCmsJJ/4Srjp+RPHoDZ7eZmH7YjNRaAo6A/XVCjanpkbJ0TYKmbpliH5LqA+c0qwpDapREyt6t4pdtDjATSSZ3sybd+T5qPKJosGz7407Rf/ppZaTp96/FycfiRveSVdJv8bmZ5UTLGO58jy0WrbFh1U4lJCXF+xMsB6gzv+34ZS2eKgY3u2k6Z5DWoq91Xa4ZN++UnVm3Zft2o7emUiQpVyTPxBDEBjLnDevZSkIL8tpSj7CtPzg5Vc29h8w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39850400004)(346002)(376002)(366004)(396003)(136003)(6486002)(316002)(6666004)(16526019)(186003)(6916009)(8936002)(8676002)(26005)(2906002)(7416002)(52116002)(6506007)(478600001)(6512007)(4326008)(86362001)(66556008)(66476007)(36756003)(66946007)(956004)(2616005)(83380400001)(1076003)(5660300002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 2L377VIRzNNQMviCXSZdTttvlgCgzqNCIxpem8Pl8Uz1auT2MTW/Bvm2EWXDUp3EZleYJx5e6ZrMEl6fknUe49MCTWnj6tHjE5m+3hf1KdjszDYerW6+SBxyyVHo9xIlQc69P//3YNqzTrSSYicAKByF0BX6ut5KexFgJcR+Nh8JtJfFOig9oMnciUf9VniCqjaVKZbb0arDtZZLGLNta7JwCHmWqoLUJv51k6GQcqChNCD1ZOrJjWsuJe7Zt4xpbvHDbHeC/tOTJUNMbvXn9mrzaV47IhnUeAsTN3gAbe2PZdTpkcONrQGF6o8aZ+oylEI15bWiVQvKwbYm5IISOadLa9E32GsdEwAnhHjAcKbQTvgAOVQkClqO5IxfsKjxdRE/bizQqdIrkvmQbgVKx5cowWqVtUwf1x0Z7igJWi/SxxFokkATRHoLFl/GbsLhXYpcKXP/wqY6mAPAOBh/XkhXyJfudBKz5JvyHWSX8SkTA1M8pT6aj82xnTiYWfmTKmQR0hp/hyceBcc402AGk0Jh49A6N9kE2T1EhQG6EomJqksFM3t4s7pbqFK1SmfJunXUD/naExWtCseFl376dgFU9nHX8Q+4TCaPL3OeQ0b7asx1rRhu/SpwTzFrjEqK03MofHTZLqhEekCw2Hd7hA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 837cf95c-e4f5-4e43-f52c-08d85b43ac21
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2020 19:55:48.3221 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iHe4pjninx10irMSEKlha7XXWrrlPLdqpTaYQJTpxqSS4a5L2nQWwqMpH19ZT81wipntTWBP+kTdBj/7f3qmpoOwpabh+rj3hbO7lVojpNI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB5254
Received-SPF: pass client-ip=40.107.3.122;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR03-AM5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/17 15:55:46
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Set errp always on failure. Generic bdrv_open_driver supports driver
functions which can return negative value and forget to set errp.
That's a strange thing.. Let's improve bdrv_qed_do_open to not behave
this way. This allows to simplify code in
bdrv_qed_co_invalidate_cache().

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
---
 block/qed.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/block/qed.c b/block/qed.c
index b27e7546ca..f45c640513 100644
--- a/block/qed.c
+++ b/block/qed.c
@@ -393,6 +393,7 @@ static int coroutine_fn bdrv_qed_do_open(BlockDriverState *bs, QDict *options,
 
     ret = bdrv_pread(bs->file, 0, &le_header, sizeof(le_header));
     if (ret < 0) {
+        error_setg(errp, "Failed to read QED header");
         return ret;
     }
     qed_header_le_to_cpu(&le_header, &s->header);
@@ -408,25 +409,30 @@ static int coroutine_fn bdrv_qed_do_open(BlockDriverState *bs, QDict *options,
         return -ENOTSUP;
     }
     if (!qed_is_cluster_size_valid(s->header.cluster_size)) {
+        error_setg(errp, "QED cluster size is invalid");
         return -EINVAL;
     }
 
     /* Round down file size to the last cluster */
     file_size = bdrv_getlength(bs->file->bs);
     if (file_size < 0) {
+        error_setg(errp, "Failed to get file length");
         return file_size;
     }
     s->file_size = qed_start_of_cluster(s, file_size);
 
     if (!qed_is_table_size_valid(s->header.table_size)) {
+        error_setg(errp, "QED table size is invalid");
         return -EINVAL;
     }
     if (!qed_is_image_size_valid(s->header.image_size,
                                  s->header.cluster_size,
                                  s->header.table_size)) {
+        error_setg(errp, "QED image size is invalid");
         return -EINVAL;
     }
     if (!qed_check_table_offset(s, s->header.l1_table_offset)) {
+        error_setg(errp, "QED table offset is invalid");
         return -EINVAL;
     }
 
@@ -438,6 +444,7 @@ static int coroutine_fn bdrv_qed_do_open(BlockDriverState *bs, QDict *options,
 
     /* Header size calculation must not overflow uint32_t */
     if (s->header.header_size > UINT32_MAX / s->header.cluster_size) {
+        error_setg(errp, "QED header size is too large");
         return -EINVAL;
     }
 
@@ -445,6 +452,7 @@ static int coroutine_fn bdrv_qed_do_open(BlockDriverState *bs, QDict *options,
         if ((uint64_t)s->header.backing_filename_offset +
             s->header.backing_filename_size >
             s->header.cluster_size * s->header.header_size) {
+            error_setg(errp, "QED backing filename offset is invalid");
             return -EINVAL;
         }
 
@@ -453,6 +461,7 @@ static int coroutine_fn bdrv_qed_do_open(BlockDriverState *bs, QDict *options,
                               bs->auto_backing_file,
                               sizeof(bs->auto_backing_file));
         if (ret < 0) {
+            error_setg(errp, "Failed to read backing filename");
             return ret;
         }
         pstrcpy(bs->backing_file, sizeof(bs->backing_file),
@@ -475,6 +484,7 @@ static int coroutine_fn bdrv_qed_do_open(BlockDriverState *bs, QDict *options,
 
         ret = qed_write_header_sync(s);
         if (ret) {
+            error_setg(errp, "Failed to update header");
             return ret;
         }
 
@@ -487,6 +497,7 @@ static int coroutine_fn bdrv_qed_do_open(BlockDriverState *bs, QDict *options,
 
     ret = qed_read_l1_table_sync(s);
     if (ret) {
+        error_setg(errp, "Failed to read L1 table");
         goto out;
     }
 
@@ -503,6 +514,7 @@ static int coroutine_fn bdrv_qed_do_open(BlockDriverState *bs, QDict *options,
 
             ret = qed_check(s, &result, true);
             if (ret) {
+                error_setg(errp, "Image corrupted");
                 goto out;
             }
         }
@@ -1537,22 +1549,16 @@ static void coroutine_fn bdrv_qed_co_invalidate_cache(BlockDriverState *bs,
                                                       Error **errp)
 {
     BDRVQEDState *s = bs->opaque;
-    Error *local_err = NULL;
     int ret;
 
     bdrv_qed_close(bs);
 
     bdrv_qed_init_state(bs);
     qemu_co_mutex_lock(&s->table_lock);
-    ret = bdrv_qed_do_open(bs, NULL, bs->open_flags, &local_err);
+    ret = bdrv_qed_do_open(bs, NULL, bs->open_flags, errp);
     qemu_co_mutex_unlock(&s->table_lock);
-    if (local_err) {
-        error_propagate_prepend(errp, local_err,
-                                "Could not reopen qed layer: ");
-        return;
-    } else if (ret < 0) {
-        error_setg_errno(errp, -ret, "Could not reopen qed layer");
-        return;
+    if (ret < 0) {
+        error_prepend(errp, "Could not reopen qed layer: ");
     }
 }
 
-- 
2.21.3


