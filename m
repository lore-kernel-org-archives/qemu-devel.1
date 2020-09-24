Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6F79C4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 19:01:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F13223600
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 19:01:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="McD+WCQj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F13223600
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43426 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLWUp-0006yy-7c
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 15:01:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43922)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kLWOh-0001da-CB; Thu, 24 Sep 2020 14:55:15 -0400
Received: from mail-eopbgr130114.outbound.protection.outlook.com
 ([40.107.13.114]:8257 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kLWOf-0002O2-2q; Thu, 24 Sep 2020 14:55:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jU7OHaVTl4h89G8SKtixHOIUbTF7tumtD6rMZa4t1uZ1pZPdCiqC1BSkFDJJrodNYrKmeBjTrwZtModRlyQ2B5ePCIqRC/wdaQs/pQtGHlXbIa2cAUVVEo0xZU1rbm6qerntUibMB7a5AZwTDdC+dLkwnYXKwPHE8dgj42Z0Gwo3Jq4mV98UVgNtm/SubCdpXMgwHy38dsvHSA3vuk65+N9WhcfXIFxdJSoZx3bE1DlTogYV+NmitP6GZirsb+FQVTCo3LfbHxhAHIWCj3XDCRycvDKIiYokNNAXKybU4DmF4KLt4pBeOQZhx60DdlpVrTfoOdmJpmSoM76SJlNabg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5fVBxh3jYMtrTLoaq1T3U6Sg9xkddLgahe7TZ5lrX40=;
 b=PKfo32JljYQ/7U3nbMMN+GZBDNCEp0tjBRRpTxNsrWfIlSBnyEsZzD/HFsMPKjPNDpl2eub6Z03c8gKSqhSlDmoV3v7twJMFHCePQh9/NvFOxf9zjb5N7fKpOaGUQzFclMzNqoTCWK9lO5LAqAELr+Jp84lSOS8HSLpFFdrNWi+mYZemmqC5T7uFQTyZ+OPzB2FzvoS71W06n2uiCRHZ2IhzvjGvZuJtPF+5tf861vdaKRlQwUYTnjXRrgJjYQy8txNQtCOUuQKQtRrTCF6ShzVcAFmT/0j0bk3LB8WUF206vJAYbpB09YX1+RDHu7WZaxMRRymfOwIeN/EDVR0IKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5fVBxh3jYMtrTLoaq1T3U6Sg9xkddLgahe7TZ5lrX40=;
 b=McD+WCQjKDDEa1tbIXyJNmqzG8CfuGsCApAWXORRGRzMeMxnLwxY6F0TvgYITVl76wJawSvqOC7CdIcq4Ht+FGjGPH80zE0DKIA4BKq58n71jhsjmjgIQLnzvBtj/eOW3tqsb/b2FTNSYv+eUfiozbR7hZzNqwgjpZAnYWj/P2E=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4341.eurprd08.prod.outlook.com (2603:10a6:20b:b9::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14; Thu, 24 Sep
 2020 18:54:39 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692%8]) with mapi id 15.20.3370.033; Thu, 24 Sep 2020
 18:54:39 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, crosa@redhat.com, ehabkost@redhat.com,
 fam@euphon.net, stefanha@redhat.com, mreitz@redhat.com, kwolf@redhat.com,
 den@openvz.org, vsementsov@virtuozzo.com, eblake@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: [PATCH v9 6/7] block: drop bdrv_prwv
Date: Thu, 24 Sep 2020 21:54:13 +0300
Message-Id: <20200924185414.28642-7-vsementsov@virtuozzo.com>
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
 Transport; Thu, 24 Sep 2020 18:54:38 +0000
X-Mailer: git-send-email 2.21.3
X-Originating-IP: [185.215.60.94]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ab29f865-26fe-4b5d-c9f0-08d860bb49ef
X-MS-TrafficTypeDiagnostic: AM6PR08MB4341:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB4341E8C933EE7BE2242C880BC1390@AM6PR08MB4341.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1051;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7PLCcdZsrpjSdtBn/sGXtTgTk6TSjwYxLc6ZS7Mlh3cptCAsF3fVuOfjXQc9zEEObViz+hvhYGGdPGKacSSPxVQqbF9RSunBppOGo7fWGgA29ymE+42L5F7WbiRDkBRTe7H6dv58QPkQTrXw3aufLqJMi5sdSAIbHJvXurMXq+2VuQhTAQGz+lqPbhzH1QIPtNgEeuHGxerlhUQ3lW8uSGEMh8RwZANWrkwkWH2T9dmDd0VYEdzaTPQa2NLHkTH7Ssm7m8y2teuHbJE0i/9hx61IvJtDTJJIaVJJPVlZ/sibGvqWU2oYi9/LvFVUWNfHvdEzonbLtpwP8pRYaELQ1E8v9KqKH03MM81FrYneLxI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(396003)(346002)(366004)(39840400004)(316002)(83380400001)(66476007)(6506007)(186003)(16526019)(5660300002)(2906002)(36756003)(6666004)(8936002)(8676002)(66946007)(2616005)(956004)(52116002)(6512007)(66556008)(86362001)(26005)(4326008)(478600001)(6916009)(1076003)(7416002)(6486002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: OT8VVpublzpWtT5eXRQOMIsrwzWkxGs3nXfUueVGIriWIjsU486VoIAKf1BanWKa0CJ+WHSMGH74D6Mdrn7NXUJfVp9ediUrruv8lhD0NUE3R4yP/063BMKXsxAdaTASEB3qqAnjjA7XB+kSNzvRIQpUyFy/3k0YGHeE7G7IYYQGofaoA4AVfRfZbGcmz7u8599JMJYVKujHP3rpeKuXTyClUjUlNpnJLFOymmH/gGAf7+oLcljCa8SEwmJouUHHRe4PHmKE2MPv76hgry9Ay83DZ69zOLDkfq/4VMPkLOhsKRhmvkLal/YJj430HWdh9Adf97QXt69eeQx/BYMNJilrVxanfehggMAqJMZk5WgI80bIS0v8dEQVKVRS1E2AluDH8eVHQGHEAapisbvjflMn3f+b3jXGdCkBasBsOh0MxAdRvPe29Bq396LolYe9+5wxN2dDEPVIXcHrlYqIoKHfwjxnIEFmUQloSwQ96k42RRwI033PB9t/cw6srJKUSM1wqs4x6YPyOYpA/xkgopDoBZ0W510g4gCEyDOA5pipE7OQaMtG45a53yKo9kan/5xGTEvOixldAgCVoIv083R0t42v43gFcB64Zy0jCiJn0RNAiGXmq4Pht3JPostWiSBy3l0L0V0NTL3Gxotw9Q==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab29f865-26fe-4b5d-c9f0-08d860bb49ef
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2020 18:54:39.0031 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ni1e7p71tdCUmoRf7a5bcs7iXYOF2dc9MVeK0P0lKflR+hCs4vf8R4jnsTVDLNOeaq4lzh01d9ESZPSw4NVlC+YwTtBMVfNYX9UprE1SLOg=
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

Now that we are not maintaining boilerplate code for coroutine
wrappers, there is no more sense in keeping the extra indirection layer
of bdrv_prwv().  Let's drop it and instead generate pure bdrv_preadv()
and bdrv_pwritev().

Currently, bdrv_pwritev() and bdrv_preadv() are returning bytes on
success, auto generated functions will instead return zero, as their
_co_ prototype. Still, it's simple to make the conversion safe: the
only external user of bdrv_pwritev() is test-bdrv-drain, and it is
comfortable enough with bdrv_co_pwritev() instead. So prototypes are
moved to local block/coroutines.h. Next, the only internal use is
bdrv_pread() and bdrv_pwrite(), which are modified to return bytes on
success.

Of course, it would be great to convert bdrv_pread() and bdrv_pwrite()
to return 0 on success. But this requires audit (and probably
conversion) of all their users, let's leave it for another day
refactoring.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/coroutines.h      | 10 ++++-----
 include/block/block.h   |  2 --
 block/io.c              | 49 ++++++++---------------------------------
 tests/test-bdrv-drain.c |  2 +-
 4 files changed, 15 insertions(+), 48 deletions(-)

diff --git a/block/coroutines.h b/block/coroutines.h
index c62b3a2697..6c63a819c9 100644
--- a/block/coroutines.h
+++ b/block/coroutines.h
@@ -31,12 +31,12 @@ int coroutine_fn bdrv_co_check(BlockDriverState *bs,
                                BdrvCheckResult *res, BdrvCheckMode fix);
 int coroutine_fn bdrv_co_invalidate_cache(BlockDriverState *bs, Error **errp);
 
-int coroutine_fn
-bdrv_co_prwv(BdrvChild *child, int64_t offset, QEMUIOVector *qiov,
-             bool is_write, BdrvRequestFlags flags);
 int generated_co_wrapper
-bdrv_prwv(BdrvChild *child, int64_t offset, QEMUIOVector *qiov,
-          bool is_write, BdrvRequestFlags flags);
+bdrv_preadv(BdrvChild *child, int64_t offset, unsigned int bytes,
+            QEMUIOVector *qiov, BdrvRequestFlags flags);
+int generated_co_wrapper
+bdrv_pwritev(BdrvChild *child, int64_t offset, unsigned int bytes,
+             QEMUIOVector *qiov, BdrvRequestFlags flags);
 
 int coroutine_fn
 bdrv_co_common_block_status_above(BlockDriverState *bs,
diff --git a/include/block/block.h b/include/block/block.h
index f2d85f2cf1..eef4cceaf0 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -383,9 +383,7 @@ int bdrv_pwrite_zeroes(BdrvChild *child, int64_t offset,
                        int bytes, BdrvRequestFlags flags);
 int bdrv_make_zero(BdrvChild *child, BdrvRequestFlags flags);
 int bdrv_pread(BdrvChild *child, int64_t offset, void *buf, int bytes);
-int bdrv_preadv(BdrvChild *child, int64_t offset, QEMUIOVector *qiov);
 int bdrv_pwrite(BdrvChild *child, int64_t offset, const void *buf, int bytes);
-int bdrv_pwritev(BdrvChild *child, int64_t offset, QEMUIOVector *qiov);
 int bdrv_pwrite_sync(BdrvChild *child, int64_t offset,
                      const void *buf, int count);
 /*
diff --git a/block/io.c b/block/io.c
index c1360ba57d..cd5b689473 100644
--- a/block/io.c
+++ b/block/io.c
@@ -890,23 +890,11 @@ static int bdrv_check_byte_request(BlockDriverState *bs, int64_t offset,
     return 0;
 }
 
-int coroutine_fn bdrv_co_prwv(BdrvChild *child, int64_t offset,
-                              QEMUIOVector *qiov, bool is_write,
-                              BdrvRequestFlags flags)
-{
-    if (is_write) {
-        return bdrv_co_pwritev(child, offset, qiov->size, qiov, flags);
-    } else {
-        return bdrv_co_preadv(child, offset, qiov->size, qiov, flags);
-    }
-}
-
 int bdrv_pwrite_zeroes(BdrvChild *child, int64_t offset,
                        int bytes, BdrvRequestFlags flags)
 {
-    QEMUIOVector qiov = QEMU_IOVEC_INIT_BUF(qiov, NULL, bytes);
-
-    return bdrv_prwv(child, offset, &qiov, true, BDRV_REQ_ZERO_WRITE | flags);
+    return bdrv_pwritev(child, offset, bytes, NULL,
+                        BDRV_REQ_ZERO_WRITE | flags);
 }
 
 /*
@@ -950,41 +938,19 @@ int bdrv_make_zero(BdrvChild *child, BdrvRequestFlags flags)
     }
 }
 
-/* return < 0 if error. See bdrv_pwrite() for the return codes */
-int bdrv_preadv(BdrvChild *child, int64_t offset, QEMUIOVector *qiov)
-{
-    int ret;
-
-    ret = bdrv_prwv(child, offset, qiov, false, 0);
-    if (ret < 0) {
-        return ret;
-    }
-
-    return qiov->size;
-}
-
 /* See bdrv_pwrite() for the return codes */
 int bdrv_pread(BdrvChild *child, int64_t offset, void *buf, int bytes)
 {
+    int ret;
     QEMUIOVector qiov = QEMU_IOVEC_INIT_BUF(qiov, buf, bytes);
 
     if (bytes < 0) {
         return -EINVAL;
     }
 
-    return bdrv_preadv(child, offset, &qiov);
-}
-
-int bdrv_pwritev(BdrvChild *child, int64_t offset, QEMUIOVector *qiov)
-{
-    int ret;
+    ret = bdrv_preadv(child, offset, bytes, &qiov,  0);
 
-    ret = bdrv_prwv(child, offset, qiov, true, 0);
-    if (ret < 0) {
-        return ret;
-    }
-
-    return qiov->size;
+    return ret < 0 ? ret : bytes;
 }
 
 /* Return no. of bytes on success or < 0 on error. Important errors are:
@@ -995,13 +961,16 @@ int bdrv_pwritev(BdrvChild *child, int64_t offset, QEMUIOVector *qiov)
 */
 int bdrv_pwrite(BdrvChild *child, int64_t offset, const void *buf, int bytes)
 {
+    int ret;
     QEMUIOVector qiov = QEMU_IOVEC_INIT_BUF(qiov, buf, bytes);
 
     if (bytes < 0) {
         return -EINVAL;
     }
 
-    return bdrv_pwritev(child, offset, &qiov);
+    ret = bdrv_pwritev(child, offset, bytes, &qiov, 0);
+
+    return ret < 0 ? ret : bytes;
 }
 
 /*
diff --git a/tests/test-bdrv-drain.c b/tests/test-bdrv-drain.c
index 1107271840..1595bbc92e 100644
--- a/tests/test-bdrv-drain.c
+++ b/tests/test-bdrv-drain.c
@@ -1872,7 +1872,7 @@ static int coroutine_fn bdrv_replace_test_co_preadv(BlockDriverState *bs,
         }
         s->io_co = NULL;
 
-        ret = bdrv_preadv(bs->backing, offset, qiov);
+        ret = bdrv_co_preadv(bs->backing, offset, bytes, qiov, 0);
         s->has_read = true;
 
         /* Wake up drain_co if it runs */
-- 
2.21.3


