Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A532CC43464
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 20:08:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CF742065E
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 20:08:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="lisz2iqq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CF742065E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40152 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJ0Cs-0007NH-B5
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 16:08:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59514)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kJ00j-00030L-FF; Thu, 17 Sep 2020 15:56:05 -0400
Received: from mail-db8eur05on2124.outbound.protection.outlook.com
 ([40.107.20.124]:28615 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kJ00h-0005s0-7K; Thu, 17 Sep 2020 15:56:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V6lfj9GJ+CqwF1m9ZU7tFibBDCjzX2XWhYRlKXxaoNx+mJvVrlKaJtgDRUQ8sCRM0vevsy+3jUZhPLcWbfkspSduGjmAz51XvsRNRyvd3iIkrN+9MTbY+r5CZQipY1aoEBosgssqrBfi1kOPh1nAoVz9LV0LofPnUw1/jCzSdOvDBL9Bc1AqbGJ6HT7MqoJB85LDH1ArYqN2xU4HONJWq+GdhcDwpAjV9Sk/Txj7mJolWPAZn/9QMklGNeugtpmUYfuWKzvBh8nZL7FyKTiWB6Lk1oLaDi9Q1iUTPl7xGDewAVmwhI//VekwYM/HRjH4xUtYMrbyxjIZhpnLLOzXQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LrY30KWD7pbrTrx1vQz7vlejh492HeEEBSNVpW9Ky3U=;
 b=CtMd5jPtwv6ekwG0s7dy1WVyIGKN+gdxVqgaYtk7oX+YS4JPdN19hZeiNUh2GlMc9ppBxGD4USk34a3mxBy94LLy+LEp5vhgA2c9bAFkMNxhIMQDG762eNmXjXKY+LL6bEGJO17Is3EXbKEQwAcJzJOuPYzSBTiyfzzA3eells5w28WyZjO9TjoGXl7k49IJ+SvlgFoX2N9RWUKORPXoG/n7tI4RvFGMgmqYECVV+2V2PP3tXg+k24/qegMfRXJ8lDaEr5mFl90Z3D5rCm7zDtC21Sl4G3kHgOdYO3z28B1JglMrVdRqPFQp+F4xT57a33tKbJenamMiAYwIaBvOFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LrY30KWD7pbrTrx1vQz7vlejh492HeEEBSNVpW9Ky3U=;
 b=lisz2iqqWeH4s36ovb7sq0sNrx43Sc5n28ZQBAtbenaIqXaiPYlxLdnXlQ0Q+RCWemx3nb3AvHsUGkhPWJbn5wRLrfbst1Nc52L53jHgkRPAbD8tY7iBvDGm+lIOhD9UQkaX7cAalPMYbtScGgLDnxvxBN81XpKxa9Xj6lovCI8=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB3032.eurprd08.prod.outlook.com (2603:10a6:209:43::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11; Thu, 17 Sep
 2020 19:55:44 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692%8]) with mapi id 15.20.3370.019; Thu, 17 Sep 2020
 19:55:44 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, armbru@redhat.com, berto@igalia.com,
 vsementsov@virtuozzo.com, eblake@redhat.com, jsnow@redhat.com,
 stefanha@redhat.com, pbonzini@redhat.com, pavel.dovgaluk@ispras.ru,
 ari@tuxera.com, mreitz@redhat.com, kwolf@redhat.com, groug@kaod.org
Subject: [PATCH v2 09/13] block/qcow2-bitmap: improve
 qcow2_load_dirty_bitmaps() interface
Date: Thu, 17 Sep 2020 22:55:15 +0300
Message-Id: <20200917195519.19589-10-vsementsov@virtuozzo.com>
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
 15.20.3391.11 via Frontend Transport; Thu, 17 Sep 2020 19:55:43 +0000
X-Mailer: git-send-email 2.21.3
X-Originating-IP: [185.215.60.75]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2d91d5be-d556-4db1-3ea8-08d85b43a9a0
X-MS-TrafficTypeDiagnostic: AM6PR08MB3032:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB3032AB8A5BD295B858F7DF98C13E0@AM6PR08MB3032.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:949;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MtIWG7bMnYPtsljd4XZc9NHLt1wBDGFPPfG4m9EYtgIMIJyfq9dkOsisUvBxlI8Fy6bWlfWagFcf/P/Uvu9vhsevaX4UF5z+o2dMHb2vpcRY5fRRGifiSh3d2qcc2Fj1tqNn+fMRp6UDk3ll1JIU97X8z7zJk4cVh80OK3JuP2SoNM31XRSmJ/mj4wf9/T8edo/lUKjioXiyjYDRsM9xJY6wonYAFqntjyeZMRnw3SQVb24n2teJtC8lzHxXl4WYEL5Dv6ixUHDYGWiz5/0QItsJBniNspQ+jzAWqJPfJeA6Umji39cJbFVjU7D+v8rtW0T3M5v/rVb9hSfhGCUSpN2qCrqsHwmZh3xnDClHfe9EYkPKfXr1BdJ/AdkNPW63
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(376002)(39840400004)(396003)(136003)(26005)(186003)(316002)(6486002)(4326008)(86362001)(478600001)(6666004)(16526019)(8936002)(956004)(6512007)(2616005)(6916009)(6506007)(2906002)(7416002)(36756003)(5660300002)(83380400001)(66476007)(19627235002)(66946007)(1076003)(8676002)(52116002)(66556008)(14143004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: F1o8XVrBjWoA+EXteLceCHNk5Onjcf21UIyCq/Q70cigEz5hpVdRY8nNhmNH1AY8sG9D+1eRGeuxh52IXAYHpROqNE6dV8/eU0rPJ3AkXMovUmxv5lANC8yoapa3DSfiMBhGhoitp44jYFB9+hgew+nBNwOeEuR5vWQrdBoaZyvw2gTgfPh7Vim8RREJk8MLJ9zramOF/mdPlmYUcA9fKrWC9Bm04Em4HqAjv/7oqrXVzHZtGHUVjOxcvqD0BxBPLs8C+U2uXv6EmEQNRcop7xJ1xM3X1WNl18PksQqZluOhgwt5CFX6JVl1+/QL9GNwHVE2er6Q13Acng9bQFdc3hwYOKLZBlveKcIZzlpSAbJ64Csq3Pf1IX8MYxgTxzEJf080vx2JAR04v09U5acFQn9qfl76DBucwb5rF5k18bQegn9IyWQvC2+aJkCijREv/XNh789dfJv7aVC1CzkNanl7HfWyXNAp1J+OXbrCqhj/uxqUl8+KnSgwp2knxqOkpDGh1BAuEaS3PN2S25owtuFAG71g0taSUMbLnY4wrqpp1hrLlp5eiurs0Mdf6+66hf5UYaSmmosPCCq8vltmjdHSpAQJCe86qiZbo9ns+qAFj2kCXj8oxsmxYSPghTUYTfc+5BkgUnsmw+FeLokDZQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d91d5be-d556-4db1-3ea8-08d85b43a9a0
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2020 19:55:44.1315 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m8y4DNJxw7W5GQdU3p3hsSDG2kCdx7waLNLH43AVg3kRycnNvz/BHIcMxT3L2iqFCM6LMbjBC7lWwTMWwoGIs4df/AA9588Loe3AZL5Io1s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3032
Received-SPF: pass client-ip=40.107.20.124;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/17 15:55:36
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
---
 block/qcow2.h        |  3 ++-
 block/qcow2-bitmap.c | 25 ++++++++++++++-----------
 block/qcow2.c        |  6 ++----
 3 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/block/qcow2.h b/block/qcow2.h
index 6eac088f1c..3c64dcda33 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -972,7 +972,8 @@ void qcow2_cache_discard(Qcow2Cache *c, void *table);
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
index 4f6138f544..500175f4e8 100644
--- a/block/qcow2-bitmap.c
+++ b/block/qcow2-bitmap.c
@@ -962,25 +962,26 @@ static void set_readonly_helper(gpointer bitmap, gpointer value)
     bdrv_dirty_bitmap_set_readonly(bitmap, (bool)value);
 }
 
-/* qcow2_load_dirty_bitmaps()
- * Return value is a hint for caller: true means that the Qcow2 header was
- * updated. (false doesn't mean that the header should be updated by the
- * caller, it just means that updating was not needed or the image cannot be
- * written to).
- * On failure the function returns false.
+/*
+ * Return true on success, false on failure. Anyway, if header_updated
+ * provided set it appropriately.
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
@@ -1036,7 +1037,9 @@ bool qcow2_load_dirty_bitmaps(BlockDriverState *bs, Error **errp)
             error_setg_errno(errp, -ret, "Can't update bitmap directory");
             goto fail;
         }
-        header_updated = true;
+        if (header_updated) {
+            *header_updated = true;
+        }
     }
 
     if (!can_write(bs)) {
@@ -1047,7 +1050,7 @@ bool qcow2_load_dirty_bitmaps(BlockDriverState *bs, Error **errp)
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


