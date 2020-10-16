Return-Path: <SRS0=JoQ+=DX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54B6BC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 17:26:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB62B20E65
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 17:26:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="U7RD13te"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB62B20E65
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTTUx-0000nV-Ov
	for qemu-devel@archiver.kernel.org; Fri, 16 Oct 2020 13:26:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35840)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kTTGW-0003SD-2v; Fri, 16 Oct 2020 13:11:40 -0400
Received: from mail-eopbgr130103.outbound.protection.outlook.com
 ([40.107.13.103]:44775 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kTTGP-0007Ot-4d; Fri, 16 Oct 2020 13:11:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jldnCmhiEtrY8XaxRGVVFqwoISYwNTjGxtNd890qHiGGzXwvJ4FGd5U9FhQ51VTZLYW0jxJ5mw5WkKYTBgiyyKuafcc5mZIhmSXLSWuVIbfsBjrfPab6UMhRPpbZHc05n6ZLIDgTLH7jPQ41xmkIq5Np7Hjk51TuOuJ7XCQm7TqwbCL9o8vBwPDQCF7fbzRItF1FG+FdKm9oJ5Z5yFp9KQUB3nwLQqdwZggoR1pyQt7O4ewt1ProcQH9YbjMSMCh6+SKpn8Mlak69M07f3PkB8/lJj4lQ0bd94LgR6fi2aM/LXDOLzz+uXRt1Wf1sajIxbr3cNPNDSv4hp9Z3bA6Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qoZ78oMawYwqBs2eidXZRkEWJUl2hEL5Lo8LiyfOy4c=;
 b=bQ8j53RAFuXSB7qxyE/e8LpHJUEoxqWLmT/63JDYF6r81yT/hHIhKrXf0RhwBrxIGhDobhFD67OryXPAKG/kfgl1jaNerHrcu63xF3sgKM+9HK80Bi5Ubt8uXe8hEb8uPR0uVzayjdQGCN6i2VPdSp8+QdvHx5vAzGrApRyoBFkwpnTBDvL6qf89XzGc7/61Nr+ElqGOJJFOkeQGSU7rKf0c+vb78WRupcwF+ml8pkXb9iCFNDilRMEbCiudpksoLWBHR48Dio9Qx7zSqEORd/7wVv+EYVS5RouI5kmxk7kR1EpO/XPZ9kG0zge1LDiOxiikN0Uzic2Uj541q0eLFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qoZ78oMawYwqBs2eidXZRkEWJUl2hEL5Lo8LiyfOy4c=;
 b=U7RD13te+Sa+Qa77RfMwNRAF8uDnkq6SdVKcGYIcX89iWqwyrMN8VgPk2bfkQUOqu5OP2R/7ItZoOf+USqYfs6DT74gJDXNPY3EiZRY9gv7Mw6x727ITuLZ20lp5AsvlAdKtg2j1lUd+zEWN1lyv6KUAn0n9W5znMGJapnKMl2c=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5495.eurprd08.prod.outlook.com (2603:10a6:20b:104::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.24; Fri, 16 Oct
 2020 17:11:21 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3455.031; Fri, 16 Oct 2020
 17:11:21 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, armbru@redhat.com, berto@igalia.com,
 vsementsov@virtuozzo.com, eblake@redhat.com, jsnow@redhat.com,
 stefanha@redhat.com, pbonzini@redhat.com, pavel.dovgaluk@ispras.ru,
 ari@tuxera.com, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org,
 Greg Kurz <groug@kaod.org>
Subject: [PATCH v3 09/13] block/qcow2-bitmap: improve
 qcow2_load_dirty_bitmaps() interface
Date: Fri, 16 Oct 2020 20:10:53 +0300
Message-Id: <20201016171057.6182-10-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201016171057.6182-1-vsementsov@virtuozzo.com>
References: <20201016171057.6182-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [185.215.60.69]
X-ClientProxiedBy: FR2P281CA0003.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::13) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.69) by
 FR2P281CA0003.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:a::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.9 via Frontend Transport; Fri, 16 Oct 2020 17:11:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4638d5b3-ff05-406c-5f82-08d871f680dc
X-MS-TrafficTypeDiagnostic: AM7PR08MB5495:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB54958F52FFD3CBD0C7B157A2C1030@AM7PR08MB5495.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1051;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sAicf/323G+Gu7QJ5TXtPv45dyLE6kzlBnCvsHBOm+Dx3staARNLs9lKi2j/KRB9rtcmcFx9aTWak+yAVixWxSVdpBoFlz7WtvzFfMtXJM1TNHsCJjfMNvdiDx5Y/U7NKps89/1k/nt/EwHXTkLOV18xAnfxP5qRDukX3EqmT+n+291U9tW5d1BkT0uxU0xsF4q+fKSMw/k1/RdwmH+od52xIPktqHVpj3zvktuO40cTh5/ywVX+ll/MLsAPgrk2bdUdGiD2n4q2Z04elZJlJKACVoM/udOQy4S539VUa9kvhUXKbR6hTrsD9lW2jMHrhySmGRg3o/3GC482MnyrmViLP8TZb7phlGkZjYm8Ktok9JryAt6DqcaIRGc7QiiGBhUKZRT1TLgXUYlehR0FBg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(39840400004)(376002)(346002)(136003)(66556008)(316002)(8936002)(36756003)(26005)(5660300002)(2616005)(6506007)(19627235002)(66946007)(86362001)(16526019)(7416002)(6916009)(66476007)(478600001)(34490700002)(6666004)(186003)(6486002)(2906002)(52116002)(956004)(83380400001)(1076003)(4326008)(8676002)(6512007)(14143004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 6YvG1ZmgVDl+BAm7HS9d6YJV9+TfN2rerv5svti2akjnVJJfF5/i3aaT/3ckM7ED6BJS4ngxjKq1oUp4MpIkqT5n6xxLbVemrm8LxyEIfLF59GRDyJUkzPqbn2W0qDoPgXTVh83qQAatM+QAsHoP1K0qcGAKwJIy2S3m23GM1JaZyQngKMpj0FQLNDmOnJBae8Q2a2iVmeOxBduWPYoRnQdjlbOWEkmHKmGVK8V9STniB6hgjMwZkfCLK9GeM3hHkNo/6Devlern7jW4zKS+ZxY8tWlf5u1PSgv0055FK88TJ6O0SiOmehB/ngQ+w+9IsAVG7KD0r2bYDcxp0NBXLOhH5Nc87UP7qH9OzMtwrfcVWyCBYZqj32GjvxGxSD5Pb8OZhhoSIZMrCOsjAUX5M/B4KyY/t7uUIZFDuZYgra5OyvAELoC1KCnxzYIvEmHGClHaQ5/e3+/EHPJyGWCUjQ3RG0R949RF0r7jazYbaIHbYwnURqPEiM9eAoR5eNtTrUFZAesaAJcCAUoySfgFX2uU/jiR1pj1YOPCG7yqbhYa/oz5jdaH4UmjpDAyrinyc0Fx8qi3L3gih7n65kZWEtK/yYjCysyJZA8ojWQruTdV3eSlpLrmExEWo0mM8tAM5AXbQdv9NEim4uPWdWS4Tw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4638d5b3-ff05-406c-5f82-08d871f680dc
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2020 17:11:21.2297 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A0ejV0aVCoOolh59UXlnIGQlhya2+yiqQcivxnpa4oMx/t+MGU6SPHUuI6KH3YSjFq4r6TZHK6NTOxuhoh4q/rZc9XA9qs/2qJiOAqKH8xk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5495
Received-SPF: pass client-ip=40.107.13.103;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR01-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/16 13:11:27
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


