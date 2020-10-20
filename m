Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6688CC433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 13:18:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBA4522247
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 13:18:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="X9ioz+kF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBA4522247
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53176 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUrXE-0003an-N3
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 09:18:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47472)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kUrJ3-0001pn-An; Tue, 20 Oct 2020 09:04:01 -0400
Received: from mail-eopbgr70134.outbound.protection.outlook.com
 ([40.107.7.134]:56643 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kUrJ0-0005bG-3h; Tue, 20 Oct 2020 09:04:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I4pmPLYs2sIiLsVXXU5E3S9ELPs1/AzudWcZDoxlkOI2VE9Y9MzfoeSLPZchC95UUzE1fI3DsHl9qT05iswntIasQQ/kFzIiiAekPQSKmUokq34NbdmQBr9Hihjt9neiPoBtCxPh/JDmHxJTDvj1G0n5smAAZUOtzT+Oifnfj68NMBgsq19DjYWlY0ov3jjRgyR3Ef8NwLG+9Jy8EAa/wPwtE2ChSjrFKIOCOxsEayzfK42pf0L7d+aP2gv8VYM1z8DGpGV0f6L0bj7oBCFp7AI7D6FOvwDHpqM/KCPmYhrXWv2Dvx+Dva2/l3OtVDTVPbfQpKIBSRVCoqIGKMBPNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RdcAJywfqKOozzqSUAv5jUdiToU+YjSlDEysNsc8lHE=;
 b=lrR0dkgtW05kgOaev75qno6zspwC4aL4YfbeK+6lJWWpWzJYbulECs9+mqIsTy0fqGbUIrZJvtYJIECz5pE5Ny+4eA6vK+Hd0mR04CkUhX0G3NkDJcKuVWbTaFpOpJwNrzndpRN5+vA65+JAOh+xQ7xCE8Pf9x6V4cFLKKJEFAiGXa2w3AmNKj/H/MxwUsUI6VrLYP5Cp7veSyR/Vz8xVFPahy839bzuEyb3FTWSAqzdKj3pSZYxw1RdkLLggC3WnBmvwH6LdzPd/F/+Y01vS2qSTVouAnUGrpRUyVBRcB/V9Y46ledIbny1zo5n582h+sR6X4+ptIZlgH1aZFhPzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RdcAJywfqKOozzqSUAv5jUdiToU+YjSlDEysNsc8lHE=;
 b=X9ioz+kFUY6LxrVxZo5NYhNqrD7D8OCvhZKUUFBZ2oRWAY3Y3aSkptJWIEh0qB962pqtnHzojkCJazdQ0ne41ZnAdbJchshhLLYqDoWdS8WCFwfbLvb04/MusQYdH73vali6n0D/sq1Gmzql4dNa8nRkfOVBDjRTbxjaPxdx+Q0=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AS8PR08MB6168.eurprd08.prod.outlook.com (2603:10a6:20b:294::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Tue, 20 Oct
 2020 13:03:40 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3499.018; Tue, 20 Oct 2020
 13:03:40 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, armbru@redhat.com, berto@igalia.com,
 vsementsov@virtuozzo.com, eblake@redhat.com, jsnow@redhat.com,
 stefanha@redhat.com, pbonzini@redhat.com, pavel.dovgaluk@ispras.ru,
 ari@tuxera.com, mreitz@redhat.com, kwolf@redhat.com,
 Greg Kurz <groug@kaod.org>
Subject: [PATCH v4 13/14] block/qed: bdrv_qed_do_open: deal with errp
Date: Tue, 20 Oct 2020 16:03:10 +0300
Message-Id: <20201020130311.14311-14-vsementsov@virtuozzo.com>
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
 15.20.3499.9 via Frontend Transport; Tue, 20 Oct 2020 13:03:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aadda7c7-6d4b-473f-3229-08d874f8904e
X-MS-TrafficTypeDiagnostic: AS8PR08MB6168:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AS8PR08MB6168307BD0557C8C38C103CCC11F0@AS8PR08MB6168.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:826;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PCmdE2aHNkmCa5yRwu7Ka0CMlHcBZC8fB6xHOelvqTioItGEbO5fjqXKJie/CDZ80LVWeSGy31wnoWCZOvuI1qoeRIlbUJGE3wdG/M9GcmjoPK6THDquNESDgQhaVy0qNh+BRq+fST4EFkYiKbnzCNhBKm1Ft9kAxzjpV6d5oB40GFmVoi1DpSZVtkeRwQ18ZbdFDzUQn7Xy4GeTNSB3mWuWVXn95euxpZcrgMsAHSOgwpB8eCJyoQYBJeEfn0KV2iq3gts8jjWDB/lRtSIQwrd38uBUHFdfhn4GxseLfpA58f/RAzFWWAeLnIz9ZDsBnWTqUpYjvtN6haBdxjEq/A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39840400004)(366004)(136003)(376002)(346002)(396003)(8676002)(66946007)(16526019)(478600001)(8936002)(186003)(5660300002)(52116002)(6506007)(6486002)(2906002)(6916009)(316002)(83380400001)(36756003)(2616005)(26005)(7416002)(956004)(1076003)(86362001)(66556008)(4326008)(6512007)(6666004)(66476007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: elHJI6ZTh7vQCgCXo4fFVsceIVuoXmSYXT0AFQSaNbnQdTAq5m7TI/3WWU92idzvXJc+VodcHwAUM9iNDtk58+xQNam9JfV6wmk18ytR28z5MExwpdU98K81vQZ3h1AxK0CeHrRh6AvkJ6RVg45bAGjcqDqT89H5/kSq6K7NxZdYBpCyeO7ubhZz204j0PGrPiYve1A/tQy+rP+Df9o7gzxs3vMk8PlJBt7gJWQUd0SQadOqKPkiT1vNZO7MhHvY4PrjqfPqpQ6dbyA1xJKsfNpE9KWSHEpkEzNYlc77CWVqWv8j88KPyT+IX+QdzvIU0ieNwU0AxQWNKq9WHCyvGSsRynYpvgUoTtdgIaNwCpLRjkLBWJZ9ptyDRpYwmqLveWBWRdjjnkw9tXL8qt/6EIbm4HKS0wztAxnF1CEa9B70LGzgCGtholS+WUg55jO8Ri40Qx/FKC2X1N7WObrqvtUfo+7BcoYRU1i6yEZPThKYV+4e5j4jgPNMiJAR9fsHT70poF3254+ff0994wE4Q9kzWS/8MEhKKgGA6T23QcOzp6zWmpd9+/LmLa/51P4xFnQBpibEHlKZ5f5snh0lweplTUo5B62PoZM1VyNBp7880Rh1detxQZ2ULOzlzf+Y2cJQp91Nhgank8zDJjXcpA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aadda7c7-6d4b-473f-3229-08d874f8904e
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2020 13:03:39.6522 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8g2zLIIFcp9QpOEm+jcJUz5IxQ6kB3Lkr4HOn5EdLkF7PbsEBW3AQzJ5x8iktcZHnhs/EK3HRVRFdUpPPx3ZTzDUIAOfNwKCUU7l040Z6DM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6168
Received-SPF: pass client-ip=40.107.7.134;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 09:03:42
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

Set errp always on failure. Generic bdrv_open_driver supports driver
functions which can return negative value and forget to set errp.
That's a strange thing.. Let's improve bdrv_qed_do_open to not behave
this way. This allows to simplify code in
bdrv_qed_co_invalidate_cache().

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
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


