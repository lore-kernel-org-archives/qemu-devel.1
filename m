Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 936D3C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 20:41:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B6A3207BC
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 20:41:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="uxm8KK7M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B6A3207BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52268 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1je2s5-0002fu-Gn
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 16:41:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35252)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1je2oL-0004eL-A2; Wed, 27 May 2020 16:38:01 -0400
Received: from mail-am6eur05on2109.outbound.protection.outlook.com
 ([40.107.22.109]:23104 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1je2oK-00080U-EF; Wed, 27 May 2020 16:38:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QjnYhiXqWjqztP1BP+u53e5c6i/QF+k8wGy7KbXrrTXOdLqqFkEWFODMNW5EOc/2zpGp3yBrZPIPWszVFJ1+MjG5gSdrCWd8vowitAxjYnYVOZokObT7oAbbrQUWlhbEoTa2IK5uQlM2CMAHcu+MChjywXUYwcvNkNdPdgVBd+T5rMLb2wKbgybLDMwdAoUEjDtyN8jmfXU4kiGyBkOBJe6VA1McBTyg097accBRaMP20ZGL5XCsm4pytWzuJxukbincRbDUXo8G0aAQv7lT7E5hHsGcxXCaH3kfvfmVXv3YKQwSn+MYDrbnHyqOPwzw9E6mIyb68RCs8orQktiIkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kk7/nXOXuMkO+z4xRJpFixMZOBdXmAi/XfA0tdLd9ig=;
 b=UygcD6QvTSrnhXLIgxz7owK14Untnl025Q+grGJ22P9l03g+b8mepfAZdr5AKrCEoKzBti2h9ucU1aPoI+1VFq4Sdv8hCsbgHOdH+3MFtTxf+eLt7+PqTlBXK66iY5os19TpEmb9O2LH6QYYiPz3L3ZhYQBKeIAFFcJLEbTVBBhXyiLGUZeejO9Mo+PlfTzw8YjUtZmeEPWtT5r4iIJU685HWXVolbghpB6av61Aq6H6i6K3z6sSBNZj3wV0vTNXaj9tRy/DsZFSA5Ik/7HBgg/paUOPxnf7IJRIPGEzYT3PkHWIufqBwxPHvsS4Pmgq8nOOcV5DecLtrxyD6DRdug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kk7/nXOXuMkO+z4xRJpFixMZOBdXmAi/XfA0tdLd9ig=;
 b=uxm8KK7MUoi4bFNCEfNsMdlLh9PwKia1+9Ryw/GADjMom8o/UwLoKR1Bk7SLnvmSZnHGBErVBvS2xgf8ZqwstRi2Nt9368oGk/GkS2rfOE+McJ5rYalcZDnEeg0ptlVeyBCeJgzPsogO2jozjbFkCt2mMBtbdhCVDLXPBZjxX7U=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5336.eurprd08.prod.outlook.com (2603:10a6:20b:105::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.24; Wed, 27 May
 2020 20:37:54 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%4]) with mapi id 15.20.3045.018; Wed, 27 May 2020
 20:37:54 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v5 6/7] block: drop bdrv_prwv
Date: Wed, 27 May 2020 23:37:32 +0300
Message-Id: <20200527203733.16129-7-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200527203733.16129-1-vsementsov@virtuozzo.com>
References: <20200527203733.16129-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0101.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:e6::18) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.148) by
 AM0PR10CA0101.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:e6::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3045.17 via Frontend Transport; Wed, 27 May 2020 20:37:53 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.148]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3f4058f9-7010-411f-b893-08d8027dd536
X-MS-TrafficTypeDiagnostic: AM7PR08MB5336:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5336710B8E869A0344446596C1B10@AM7PR08MB5336.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1051;
X-Forefront-PRVS: 04163EF38A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2RMQx5+Y4RRai6x38TadlyC/5Gv7EH7JF6ofiOpfDf05lQZe24NzSavwhByy8oyqLOHtUgQVKXxrWQMrpREfRmwo+HKGCbyBba50scDi61Th1bA2a3EK2AewnBoGpkSo19yB52jotjQSV0OHqKuoxxJg8uIGuPjd2vw+r49bRHbdYfj1EU0oYgBok81/5OMKm8EpmT/+AM0260rqzB1JHIrEIi/QKejCwM6K3/UsC1/14oFbTIWty9s6dmj9Lhv2SCjsU4rS9faQs6cKWwYYDEJW5vUYBrTWQRUcK1OpxuRCPOhMX7BblymtJT1zyZ4C
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(366004)(396003)(39850400004)(376002)(136003)(956004)(66556008)(66946007)(66476007)(8676002)(6486002)(6512007)(1076003)(478600001)(186003)(316002)(5660300002)(6916009)(2616005)(6506007)(8936002)(16526019)(26005)(2906002)(6666004)(83380400001)(36756003)(4326008)(52116002)(86362001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: tKYIWf0/n9nz4Yw/F1BMfodeENkB7/Pxp2DiWHFn/TWZF4SsJVNWwbWsda/Zxj/yn+jeGxAXGjBnyIsbIoSUbUvJ88SWfnU3bcVZD+OE+GYRNdSrc4rzzbbaOxaw0vmxkIYZdD0DB6q2X3pGntviMfsF2pfo081IUKsEamlMlWyCLrGIFURHFdL7byKuWpFaU7fsxYOkB/aY5TsOJKqNoEhyoJaH50FkJX0uCQKXCKyUzmvJTtFncmeoyoQ2CdQUcwOtfsjZYeJBXI9UtZB/XDQih/9EEvhRqxwu4tlO1Wfh9Zc2RFY7rfr2Q/oF3qlOVhrAXxMwUKoqPlTX4H6nc/Zm+n2CAk7d+vL5+TouRO6FHJ0uL5nsFTcshi+iEazsxT9uzpYSxXxs84ByCtHVWdyOYx96r6xwo1TmforFvjet54/1D69SOKhxt4NoBgVmI+0Ku5VEKisB2nUZvAMbN7ADZVw8Ulx+SAaR9MakxTc=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f4058f9-7010-411f-b893-08d8027dd536
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2020 20:37:54.5933 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BllbVv/l8FqL5rRxW3ZlPrNMfdYaoyOqV5KCpu/SlS/oRG1WGeSXA78xDHMIPAIOF7aA9/0BAz1en+aH3/si+GIs/sAahCDRAA5NgYw8oDU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5336
Received-SPF: pass client-ip=40.107.22.109;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/27 16:37:56
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, MSGID_FROM_MTA_HEADER=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_SBL_CSS=3.335,
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
 ehabkost@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com,
 stefanha@redhat.com, crosa@redhat.com, den@openvz.org
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
---
 block/coroutines.h      | 10 ++++-----
 include/block/block.h   |  2 --
 block/io.c              | 49 ++++++++---------------------------------
 tests/test-bdrv-drain.c |  2 +-
 4 files changed, 15 insertions(+), 48 deletions(-)

diff --git a/block/coroutines.h b/block/coroutines.h
index 145a2d2645..56c0be6f8f 100644
--- a/block/coroutines.h
+++ b/block/coroutines.h
@@ -32,12 +32,12 @@ int coroutine_fn bdrv_co_check(BlockDriverState *bs,
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
index 46c8b7816e..dadb6e796f 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -379,9 +379,7 @@ int bdrv_pwrite_zeroes(BdrvChild *child, int64_t offset,
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
index f9700cc897..305ee7219a 100644
--- a/block/io.c
+++ b/block/io.c
@@ -892,23 +892,11 @@ static int bdrv_check_byte_request(BlockDriverState *bs, int64_t offset,
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
@@ -952,41 +940,19 @@ int bdrv_make_zero(BdrvChild *child, BdrvRequestFlags flags)
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
@@ -997,13 +963,16 @@ int bdrv_pwritev(BdrvChild *child, int64_t offset, QEMUIOVector *qiov)
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
2.21.0


