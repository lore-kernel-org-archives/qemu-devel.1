Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0421C433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 13:13:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3118A22265
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 13:13:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="U+PoDnH7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3118A22265
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37914 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUrRp-0005Pp-8M
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 09:13:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47352)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kUrIt-0001av-5Z; Tue, 20 Oct 2020 09:03:51 -0400
Received: from mail-vi1eur05on2136.outbound.protection.outlook.com
 ([40.107.21.136]:23328 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kUrIn-0005aC-B2; Tue, 20 Oct 2020 09:03:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aSaxAGFpnjYChqKq5NayGwQNOGknk6NmF/ETozJyO8BUCS2vT6z26rYrL8j0zA8AAQeeLfW89Wi10bskg3e2yY8JRNr/7wwMKqOzUqZ6BuniOSmUslNwN5ls10gnqFSZzS/VLiQlujswzuztNCeDMf3cw+o/6LPYd1UpBln7YGS9IVXfGovABU+MnNMd9+KTg1ZVckZUfJ97uzLHQgmuf5nn5mml50U1BI3hPT+fckr5Pu0R4PztwrSrJAb2Wo0gWvnftWRe4kRf8kHdz9cpe1MZWdH6GZzPk7gnboKxk+LPhOvdBzTPwnG9IVTfB9wQxU6J90hGQrphRvEGa/4g4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qoZ78oMawYwqBs2eidXZRkEWJUl2hEL5Lo8LiyfOy4c=;
 b=gj8siXY6TjVSkDcT/71vOK7PJW1HVUmvcqdgekhGwmc/LAd21evmoNhLf8o+Zr5zgDYyNPfiUJEbgUzxE9+T7I9pLYNrgo+BqnVlf4uTscnGeFTZKhkgiXG+MsOyuJfRTvVDyT6vfiR2+7uLHs5926MUidxdv5JE/CeQQ8UqC41uS2z+ybwwwF40kbTbybr6ygZtodK6JowK+tFjgV92bzXvZAWvHL6P6fpoTuqLHo67tb2duwvARXPl8+KmRIycO5GBTQRmj8w+vYga5HFiPH0BvmJahhGQOTpMKZsS68cPIBFLC9gJwz7m3vk8oR2lHlQ+FqObNsQqo2JWIhTvsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qoZ78oMawYwqBs2eidXZRkEWJUl2hEL5Lo8LiyfOy4c=;
 b=U+PoDnH7TIQwHPGNyoZyXOeke0E36bZrHs/iqzCjpQQAKm0rIS3H8k+EDrpXrrHKIVtZarxAE7LVtd3skXSxhLQMptGXd7Funn9Qo4rY4yZjT7hI3/6W2OBftX04cocML4qzrFYTQt0Q/SZj+o1Ong6xyPzPfGoPdo87E0dyh6o=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AS8PR08MB6168.eurprd08.prod.outlook.com (2603:10a6:20b:294::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Tue, 20 Oct
 2020 13:03:38 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3499.018; Tue, 20 Oct 2020
 13:03:38 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, armbru@redhat.com, berto@igalia.com,
 vsementsov@virtuozzo.com, eblake@redhat.com, jsnow@redhat.com,
 stefanha@redhat.com, pbonzini@redhat.com, pavel.dovgaluk@ispras.ru,
 ari@tuxera.com, mreitz@redhat.com, kwolf@redhat.com,
 Greg Kurz <groug@kaod.org>
Subject: [PATCH v4 09/14] block/qcow2-bitmap: improve
 qcow2_load_dirty_bitmaps() interface
Date: Tue, 20 Oct 2020 16:03:06 +0300
Message-Id: <20201020130311.14311-10-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201020130311.14311-1-vsementsov@virtuozzo.com>
References: <20201020130311.14311-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [185.215.60.66]
X-ClientProxiedBy: FR2P281CA0023.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::10) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.66) by
 FR2P281CA0023.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:14::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.9 via Frontend Transport; Tue, 20 Oct 2020 13:03:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b707118a-648f-40fe-701c-08d874f88db1
X-MS-TrafficTypeDiagnostic: AS8PR08MB6168:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AS8PR08MB61684EB53D7229E21FDB2D56C11F0@AS8PR08MB6168.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1051;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5ZJ1XvrRa8CpfYEauRWSYcJJktK7F3pcXhJKsaMZHo5GIW8zQerqtNa9Mp5U/gUQ3mvAbIu4ItPL5lIataziHinmPkX90bOk+wGLxRe8dISzp5fScdT2Ug31FjKRyB4rzP7t4h4mzqBA0ZLPwPUA9W/5ZkDtOErFB2sV903uOngP7rwIu7v+yjgHVOUwoQiDCTtAsoMwgbXeTB293QGeCGQ9A/WJSJHUXrEGRPVQ/AjuUiMG92L1nlyRGrW24cUc7oVvsp4LzYBa/aOFfyOV59QiW5SLOjtwk3BW67c96Jd45uQUY4b7drNVRhHUom7QEQzHOm9XVBfKxg93gjSK/3hVWOsn5kvlvtWfB5OpiL8/Z86vegR3Bs07xrZD0N7k
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39840400004)(366004)(136003)(376002)(346002)(396003)(8676002)(66946007)(16526019)(478600001)(8936002)(186003)(5660300002)(52116002)(6506007)(6486002)(19627235002)(2906002)(6916009)(316002)(83380400001)(36756003)(2616005)(26005)(7416002)(956004)(1076003)(86362001)(66556008)(4326008)(6512007)(6666004)(66476007)(14143004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: hJa22VoNFsDKVT7FE2dJu4Jsjd5Y/9V+fbIni8Vz28HhpIzpLgVG66BmmOwxbe36JG6YBlSSLcx92ILlgaBTAYdR5g2YsP0FBP77dZZytasBvK3ChFFswR/AL9JYQEri7wak3vFLbKF6XJE4mVBIi2d0P2NTOxT4wk97gQCX9/Brcf6dXZY/3rxQiTLtGaKt3Jv91xxgrXuNNyMZZsd0Ivq2SWffXueTsDIlzXFDc+V0IV3e4aSGc2ys73IHbmpc8Nj5DK6TWAqxw7kQScCqarPw1sK+FE0dtDllWmGgMlO9b6MWFebslSbjLTGwpEQZQO/GF96ZH7i3u9BU8Awhx9nvkVXetFkruWOkGkxcNqeIO57zQKs3tG5XumOh+k7aMVHsrIJMP2FqRxogt3F09JhEzlid1WYiPFgtCcsev8FuFuaqWLhXq1jEIbczRvF7YhYh9xoMjOC5ZggISiBzHWCNKUJ1Wl4wxCrE0mLYvaRJkUfCw3JAlIQOvtWE99NW8SMfP5R0AgocpkOxelAjmm6NVKORBdTYDVFQyILmFzqsikdrK6U/MFKMzKmVXH6NyDFz/ehhIlsOADo3ISLqNF12RKfDrMJYfK1IbOr0S06wrmICmsakeRTlJWUAukRVLYfYnUtvGWYt8UEzKWBUfg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b707118a-648f-40fe-701c-08d874f88db1
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2020 13:03:35.2296 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SGWrUtV8V4R7MC9jwKz9agqiRVmFGDw9kRpehW2jPEUSAivLTY0GSjtPsTnT3iJ9m/VlRxZr2IaFuxTSRgJnxMIpzal/vP1AqMCC3EIM/zQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6168
Received-SPF: pass client-ip=40.107.21.136;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 09:03:34
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

It's recommended for bool functions with errp to return true on success
and false on failure. Non-standard interfaces don't help to understand
the code. The change is also needed to reduce error propagation.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
---
 block/qcow2.h        |  3 ++-
 block/qcow2-bitmap.c | 26 +++++++++++++++-----------
 block/qcow2.c        |  6 ++----
 3 files changed, 19 insertions(+), 16 deletions(-)

diff --git a/block/qcow2.h b/block/qcow2.h
index 024901a6ca..4c994739ed 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -975,7 +975,8 @@ void qcow2_cache_discard(Qcow2Cache *c, void *table);
 int qcow2_check_bitmaps_refcounts(BlockDriverState *bs, BdrvCheckResult *res,
                                   void **refcount_table,
                                   int64_t *refcount_table_size);
-bool qcow2_load_dirty_bitmaps(BlockDriverState *bs, Error **errp);
+bool qcow2_load_dirty_bitmaps(BlockDriverState *bs, bool *header_updated,
+                              Error **errp);
 bool qcow2_get_bitmap_info_list(BlockDriverState *bs,
                                 Qcow2BitmapInfoList **info_list, Error **errp);
 int qcow2_reopen_bitmaps_rw(BlockDriverState *bs, Error **errp);
diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
index 55cd52ab96..ca01f08bac 100644
--- a/block/qcow2-bitmap.c
+++ b/block/qcow2-bitmap.c
@@ -962,25 +962,27 @@ static void set_readonly_helper(gpointer bitmap, gpointer value)
     bdrv_dirty_bitmap_set_readonly(bitmap, (bool)value);
 }
 
-/* qcow2_load_dirty_bitmaps()
- * Return value is a hint for caller: true means that the Qcow2 header was
- * updated. (false doesn't mean that the header should be updated by the
- * caller, it just means that updating was not needed or the image cannot be
- * written to).
- * On failure the function returns false.
+/*
+ * Return true on success, false on failure.
+ * If header_updated is not NULL then it is set appropriately regardless of
+ * the return value.
  */
-bool qcow2_load_dirty_bitmaps(BlockDriverState *bs, Error **errp)
+bool qcow2_load_dirty_bitmaps(BlockDriverState *bs, bool *header_updated,
+                              Error **errp)
 {
     BDRVQcow2State *s = bs->opaque;
     Qcow2BitmapList *bm_list;
     Qcow2Bitmap *bm;
     GSList *created_dirty_bitmaps = NULL;
-    bool header_updated = false;
     bool needs_update = false;
 
+    if (header_updated) {
+        *header_updated = false;
+    }
+
     if (s->nb_bitmaps == 0) {
         /* No bitmaps - nothing to do */
-        return false;
+        return true;
     }
 
     bm_list = bitmap_list_load(bs, s->bitmap_directory_offset,
@@ -1036,7 +1038,9 @@ bool qcow2_load_dirty_bitmaps(BlockDriverState *bs, Error **errp)
             error_setg_errno(errp, -ret, "Can't update bitmap directory");
             goto fail;
         }
-        header_updated = true;
+        if (header_updated) {
+            *header_updated = true;
+        }
     }
 
     if (!can_write(bs)) {
@@ -1047,7 +1051,7 @@ bool qcow2_load_dirty_bitmaps(BlockDriverState *bs, Error **errp)
     g_slist_free(created_dirty_bitmaps);
     bitmap_list_free(bm_list);
 
-    return header_updated;
+    return true;
 
 fail:
     g_slist_foreach(created_dirty_bitmaps, release_dirty_bitmap_helper, bs);
diff --git a/block/qcow2.c b/block/qcow2.c
index 8c89c98978..c4b86df7c0 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -1297,7 +1297,6 @@ static int coroutine_fn qcow2_do_open(BlockDriverState *bs, QDict *options,
     unsigned int len, i;
     int ret = 0;
     QCowHeader header;
-    Error *local_err = NULL;
     uint64_t ext_end;
     uint64_t l1_vm_state_index;
     bool update_header = false;
@@ -1785,9 +1784,8 @@ static int coroutine_fn qcow2_do_open(BlockDriverState *bs, QDict *options,
 
     if (!(bdrv_get_flags(bs) & BDRV_O_INACTIVE)) {
         /* It's case 1, 2 or 3.2. Or 3.1 which is BUG in management layer. */
-        bool header_updated = qcow2_load_dirty_bitmaps(bs, &local_err);
-        if (local_err != NULL) {
-            error_propagate(errp, local_err);
+        bool header_updated;
+        if (!qcow2_load_dirty_bitmaps(bs, &header_updated, errp)) {
             ret = -EINVAL;
             goto fail;
         }
-- 
2.21.3


