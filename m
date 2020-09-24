Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52006C4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 18:59:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A26B723600
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 18:59:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="gazbYyJG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A26B723600
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLWSh-0005N1-H6
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 14:59:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43810)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kLWOJ-0001Eo-0R; Thu, 24 Sep 2020 14:54:51 -0400
Received: from mail-eopbgr130114.outbound.protection.outlook.com
 ([40.107.13.114]:8257 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kLWOA-0002O2-4y; Thu, 24 Sep 2020 14:54:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I95F282aXrdP24mxXYKFPuUZvxZyJGNMtG8EqG1i+59DjwSfqnQv1rtJv1FYc4b3eIme2nw4XsibwoJd7ErDBBOJxRrnlMA8fIsIYtISSyeehXptvFBl0glxdnUjY7hHrED2yv8Q/OoYGnAvU24LSkpMDS3I4bJ2HWu38+BgR9KhROHYG0BhdCUoLmzdzhwIm2KBFaClS0k4YCGyfhuCklLh20QgtWL4LLjHLZnsEKVR9OP3P8nQFbQ3HARVT08jGWyC3IVIAtbQrXPhtpuFx4JRRySJkpq3U9eyoc7PoqNbkLWixsVyW650A8WoHBHnRsusVd24mtAMsOli9NZfGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vNj1Xx5ux0eVXqhoEZLTGQpTAmwFAjKTuBAOkZKF68U=;
 b=XtyH5KGhvhRBCw5WAslEzLiZo9vONBmSx2t18v2+WwHPMNkwUbn4T2CtILI4Amkk3gWHwYN8pXy1OK0v97VQJOFFMmm3By4tgPFF65BGPBzilWJ/WWAyUYyIMz9blUhhVELxTTfAltjC/WomMrs3yA9gGLXBy1SZyxeK90K0rqDr4ZQ/7Ais7HKHKYrAXi/j9aJTCDLKKOKhiCML03ckbXuVOCOT0HNfrV52CuTe5ujs7fwjTK8PIfcmI3Wm9RAbQaDeTM+k7q5VQsFfjX+7WNe48pcXuyaLmSSU5yu6LtfCCTnObY78og4kUQBRS4uy2OFY+v3UcFZi+mgwsokd9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vNj1Xx5ux0eVXqhoEZLTGQpTAmwFAjKTuBAOkZKF68U=;
 b=gazbYyJGLudJlYauZOHyPpAkGbx39mCMc4Ss8pjhqUE5KxwHir0oMcF7NBeFyEH10ZIAlVS8LH3TamYNM0UaRuV02WbtYPdlSzr0doyaJOuvo7d84aGrMfVOxJSu2jN1NHcgyDtmk+cRGmSZ/bCQ0JYY02/GfiIDTSSiinY5LK0=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4341.eurprd08.prod.outlook.com (2603:10a6:20b:b9::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14; Thu, 24 Sep
 2020 18:54:35 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692%8]) with mapi id 15.20.3370.033; Thu, 24 Sep 2020
 18:54:35 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, crosa@redhat.com, ehabkost@redhat.com,
 fam@euphon.net, stefanha@redhat.com, mreitz@redhat.com, kwolf@redhat.com,
 den@openvz.org, vsementsov@virtuozzo.com, eblake@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: [PATCH v9 2/7] block/io: refactor coroutine wrappers
Date: Thu, 24 Sep 2020 21:54:09 +0300
Message-Id: <20200924185414.28642-3-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200924185414.28642-1-vsementsov@virtuozzo.com>
References: <20200924185414.28642-1-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR05CA0082.eurprd05.prod.outlook.com
 (2603:10a6:208:136::22) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.94) by
 AM0PR05CA0082.eurprd05.prod.outlook.com (2603:10a6:208:136::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20 via Frontend
 Transport; Thu, 24 Sep 2020 18:54:34 +0000
X-Mailer: git-send-email 2.21.3
X-Originating-IP: [185.215.60.94]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 95961a05-4348-494d-fff7-08d860bb47a3
X-MS-TrafficTypeDiagnostic: AM6PR08MB4341:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB4341A6FB1BF34A07E8429D01C1390@AM6PR08MB4341.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:189;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jhQ3zUwUlQqd5zQUqvYVRl4IcGbazzdmTrRo5n4rW2qfXtSXmE+Kuh8yXToUJKeWKpTEARmR7r5Iz2W7ZmC3gCqyFXf6DZenjrpsVUTiqzVFG0mTLT+8mnMj0iHMOU+dzIOxiOwJV4EGcZm/tmm5DLrmJOF0cmw7w+1Kk0ZYSnn1Nc04Bgr1Y9Ev9wUHYWcDfdw1VFWSHi7Q7rgIZpMbI8bx3fEP7jHfXmc2WDHOh8PO0VnVOJRgJRr92SFMNhi6y7Fu6Zfhm31ILY7oMiq2tvzS7mTuA51XmeyD5zEyECuY/VX2kjJYJZwThYwtK3fK15ESz2s820a57Cu8QtBqfFCiwJPB286BPsDTBmgBD+RQk3ARR+vdUtevyTbPWgdc
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(396003)(346002)(366004)(39840400004)(316002)(83380400001)(66476007)(6506007)(186003)(16526019)(5660300002)(2906002)(36756003)(6666004)(8936002)(8676002)(66946007)(2616005)(956004)(52116002)(6512007)(66556008)(86362001)(26005)(4326008)(478600001)(6916009)(1076003)(7416002)(6486002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 72w+KlUTUCAAuAIN6Hg9XNdPpeRiFbHmjVYn1uVFpKZ2AMUQnQaW5ZIpwALTEPBSPG+hAmwCnpnBK/SK0Hk6LmbjiJ2klO02B2t8DoOYSMxWPl/zjRo2xsbr7zGyK6vT4/Q1mpXmK0rUErXWJm2aDjCnH6hDUpB3WJ+P4KMri4NPC6QUGi7jtMZ3Jjct6sVNlOQK9hdrJxmXiVbij92vOjKUPWBktTrTgffeEQA9TDjGEWgr4xRADY46XzXV1dOECkqJ31zCtv4ggexzHWzL9Niv9AKKg0oKcmWflEA8siUTp9Qe/GxrU++k/s5ErY07D59lhNbiXxaxmKYqCgZyvTr/cnYO7Pmd/mv+QtAFKsZy9spdGD3NMKJqYVybs8sbg7Z1/iYUUhmy9sC+R+93BofTTWfqR/pzj+59rwxryz+gnkYtYaN3L4mbfwWCsg/7+wNHh9kmeZ9mSEn6OpriZIoAYByNSUEV4+SKnihEk9LuJws9Y7gLlQeF+ZLNzHFfarenXWgFpFLgk/JvV5cQ0RnU9910SqGYxQchA13GMeMoAc7nc54HYPXycmzfRTbwPoCep7eQQ+Xb8+53ZBsRbs2p/LPkpMmFw+eVO0vO3AeraHY4rN5VxpKPiK+xObGDmrdKWWin9e8Fm7Tlb3Lm/w==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95961a05-4348-494d-fff7-08d860bb47a3
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2020 18:54:35.1519 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ucev8Wd1tF92+bfglHCqShSgBCFTXBjO+GlskATAm70jWE2s++htpI8A6L9Mz7toS3ji7f093OsyTrvDNWY7kB2gyJZtyRcxnOlNzVAUXKU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4341
Received-SPF: pass client-ip=40.107.13.114;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR01-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/24 14:54:34
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

Most of our coroutine wrappers already follow this convention:

We have 'coroutine_fn bdrv_co_<something>(<normal argument list>)' as
the core function, and a wrapper 'bdrv_<something>(<same argument
list>)' which does parameter packing and calls bdrv_run_co().

The only outsiders are the bdrv_prwv_co and
bdrv_common_block_status_above wrappers. Let's refactor them to behave
as the others, it simplifies further conversion of coroutine wrappers.

This patch adds an indirection layer, but it will be compensated by
a further commit, which will drop bdrv_co_prwv together with the
is_write logic, to keep the read and write paths separate.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/io.c | 60 +++++++++++++++++++++++++++++-------------------------
 1 file changed, 32 insertions(+), 28 deletions(-)

diff --git a/block/io.c b/block/io.c
index a2389bb38c..24a7de3463 100644
--- a/block/io.c
+++ b/block/io.c
@@ -933,27 +933,31 @@ typedef struct RwCo {
     BdrvRequestFlags flags;
 } RwCo;
 
+static int coroutine_fn bdrv_co_prwv(BdrvChild *child, int64_t offset,
+                                     QEMUIOVector *qiov, bool is_write,
+                                     BdrvRequestFlags flags)
+{
+    if (is_write) {
+        return bdrv_co_pwritev(child, offset, qiov->size, qiov, flags);
+    } else {
+        return bdrv_co_preadv(child, offset, qiov->size, qiov, flags);
+    }
+}
+
 static int coroutine_fn bdrv_rw_co_entry(void *opaque)
 {
     RwCo *rwco = opaque;
 
-    if (!rwco->is_write) {
-        return bdrv_co_preadv(rwco->child, rwco->offset,
-                              rwco->qiov->size, rwco->qiov,
-                              rwco->flags);
-    } else {
-        return bdrv_co_pwritev(rwco->child, rwco->offset,
-                               rwco->qiov->size, rwco->qiov,
-                               rwco->flags);
-    }
+    return bdrv_co_prwv(rwco->child, rwco->offset, rwco->qiov,
+                        rwco->is_write, rwco->flags);
 }
 
 /*
  * Process a vectored synchronous request using coroutines
  */
-static int bdrv_prwv_co(BdrvChild *child, int64_t offset,
-                        QEMUIOVector *qiov, bool is_write,
-                        BdrvRequestFlags flags)
+static int bdrv_prwv(BdrvChild *child, int64_t offset,
+                     QEMUIOVector *qiov, bool is_write,
+                     BdrvRequestFlags flags)
 {
     RwCo rwco = {
         .child = child,
@@ -971,8 +975,7 @@ int bdrv_pwrite_zeroes(BdrvChild *child, int64_t offset,
 {
     QEMUIOVector qiov = QEMU_IOVEC_INIT_BUF(qiov, NULL, bytes);
 
-    return bdrv_prwv_co(child, offset, &qiov, true,
-                        BDRV_REQ_ZERO_WRITE | flags);
+    return bdrv_prwv(child, offset, &qiov, true, BDRV_REQ_ZERO_WRITE | flags);
 }
 
 /*
@@ -1021,7 +1024,7 @@ int bdrv_preadv(BdrvChild *child, int64_t offset, QEMUIOVector *qiov)
 {
     int ret;
 
-    ret = bdrv_prwv_co(child, offset, qiov, false, 0);
+    ret = bdrv_prwv(child, offset, qiov, false, 0);
     if (ret < 0) {
         return ret;
     }
@@ -1045,7 +1048,7 @@ int bdrv_pwritev(BdrvChild *child, int64_t offset, QEMUIOVector *qiov)
 {
     int ret;
 
-    ret = bdrv_prwv_co(child, offset, qiov, true, 0);
+    ret = bdrv_prwv(child, offset, qiov, true, 0);
     if (ret < 0) {
         return ret;
     }
@@ -2449,14 +2452,15 @@ early_out:
     return ret;
 }
 
-static int coroutine_fn bdrv_co_block_status_above(BlockDriverState *bs,
-                                                   BlockDriverState *base,
-                                                   bool want_zero,
-                                                   int64_t offset,
-                                                   int64_t bytes,
-                                                   int64_t *pnum,
-                                                   int64_t *map,
-                                                   BlockDriverState **file)
+static int coroutine_fn
+bdrv_co_common_block_status_above(BlockDriverState *bs,
+                                  BlockDriverState *base,
+                                  bool want_zero,
+                                  int64_t offset,
+                                  int64_t bytes,
+                                  int64_t *pnum,
+                                  int64_t *map,
+                                  BlockDriverState **file)
 {
     BlockDriverState *p;
     int ret = 0;
@@ -2494,10 +2498,10 @@ static int coroutine_fn bdrv_block_status_above_co_entry(void *opaque)
 {
     BdrvCoBlockStatusData *data = opaque;
 
-    return bdrv_co_block_status_above(data->bs, data->base,
-                                      data->want_zero,
-                                      data->offset, data->bytes,
-                                      data->pnum, data->map, data->file);
+    return bdrv_co_common_block_status_above(data->bs, data->base,
+                                             data->want_zero,
+                                             data->offset, data->bytes,
+                                             data->pnum, data->map, data->file);
 }
 
 /*
-- 
2.21.3


