Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ABD4C4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 19:01:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D80A623600
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 19:01:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="og8ZMLeG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D80A623600
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44134 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLWUz-0007Mc-PT
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 15:01:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43820)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kLWOL-0001GM-36; Thu, 24 Sep 2020 14:54:53 -0400
Received: from mail-eopbgr80115.outbound.protection.outlook.com
 ([40.107.8.115]:8199 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kLWOA-0002OV-IY; Thu, 24 Sep 2020 14:54:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XjnaKG99EMpdVUOnwEbDq7SmCDg3/tY86KdwbRNnkQFzXGzG/CH/lHluXlx8K6eOTF1pvyOLlFQR1+ndzS9SR//fjjDD8sTwzkRLzxNBLaNjF2Ax8i9x0qUjvmZ0og/Tqn760vltrMNqzDr9sv9iEpye8NU81Vm49ALBncHTtQD4Yl2hFdt5wu4FswLLkbLBFwybVXadEeAEAzmVBEX7INzBCf24JzrpWunzt7aFKKTIhzdeMAwmfMl46KMASa/hp7gJ3dAmSvTrZoqSYg8/mIVmeI+n6aL1UQ0pr6/C0+qzc9MAO51qWCZQU5gm31vxYKzfZK51uf9acVgsVlWtGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HiHebYqNrRrCRFM5FZXBKZhy6PdvbjnSnTkFrQlzjC4=;
 b=Sz3TJaUNFciJLpqvZAw/SNXTtSDNdR1YhMO82jLV38NObpC3UeJdwqxXvGBCJYY0QhSf1j2q0P/AUAebkCdRwtDzYyk7NZHkzyg6M0Ua4tZ1FQs4u6BWsISF4sgrDXW+Gu2dXeItzx8PRk43RNtmy6QUJSygvAHHgOtGqOaaIsCAW00qP265/aYu0RfuAgSOMjyfwF2LY7Pm8FhHrw/efWMbQ666W+6R+3AGDsVP9NN+s3mzLlTZAKpoEGVMoU7tzHGrksAGT2XYDdPBQtm8yV9deDbdQdm4AmT/q787OO8mMlzZuo415hUy9BZVsLs01jlMNzAjLhhW2f1QNJnv7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HiHebYqNrRrCRFM5FZXBKZhy6PdvbjnSnTkFrQlzjC4=;
 b=og8ZMLeGnPggnSOMGoewURM8+ir/PqjmOYOjQBsvF96b5Qsm9EgHU1IghzQf19gNWX2PPLEYhUhcwBueA+BVEe8sFNmiKArWQRuMYPu9pWMzsEu1CPc4DGUFqNwJdiWTvmjVsGMjAn5XQNXQXw549ngttQqBmqSTGh73HzXKB/E=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB3159.eurprd08.prod.outlook.com (2603:10a6:209:46::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20; Thu, 24 Sep
 2020 18:54:39 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692%8]) with mapi id 15.20.3370.033; Thu, 24 Sep 2020
 18:54:39 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, crosa@redhat.com, ehabkost@redhat.com,
 fam@euphon.net, stefanha@redhat.com, mreitz@redhat.com, kwolf@redhat.com,
 den@openvz.org, vsementsov@virtuozzo.com, eblake@redhat.com
Subject: [PATCH v9 7/7] block/io: refactor save/load vmstate
Date: Thu, 24 Sep 2020 21:54:14 +0300
Message-Id: <20200924185414.28642-8-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200924185414.28642-1-vsementsov@virtuozzo.com>
References: <20200924185414.28642-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR05CA0082.eurprd05.prod.outlook.com
 (2603:10a6:208:136::22) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.94) by
 AM0PR05CA0082.eurprd05.prod.outlook.com (2603:10a6:208:136::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20 via Frontend
 Transport; Thu, 24 Sep 2020 18:54:39 +0000
X-Mailer: git-send-email 2.21.3
X-Originating-IP: [185.215.60.94]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2e114505-b03f-402c-c271-08d860bb4a77
X-MS-TrafficTypeDiagnostic: AM6PR08MB3159:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB31590386EBFDF9F3F63C7BECC1390@AM6PR08MB3159.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:153;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lhMMUmRQObUsY79OaP/4s98N5toVOPOwX5kpCBOUvRO75kkyYC9g7MueJWXAXs5l3nh59sZ9twCm+TUt88AZ+5RDs3Q8peRrBusFKi6zf2QSDgOHhbH/Tz0nXpztk4Y7Qdktp2qPz0F2BxP9xW1PQJ7VdZX56VwDui+rvM0ynhpYlbp2l6/eGNENujisQpcBKPmmhWoznGdxKiHCGw6lvU+wyCbVBlgmadt5nR4BZOS9TDlwnEZf2WnLmrinH+sbsQ28/VwPwmW3UHoHUiCSj5d4ZpQpPX/txvLWzI/C88l3WKeo7P/IV6jbOl9wESe7oBEIMzZXQlT21ijOKmuDxAbAdSn0DRsoEaceIapceAiqvNpROfRt+w4z/3s3CkFa
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(396003)(39850400004)(346002)(376002)(8676002)(186003)(86362001)(6916009)(66556008)(8936002)(478600001)(36756003)(83380400001)(956004)(6512007)(4326008)(16526019)(66476007)(5660300002)(66946007)(2906002)(6486002)(6666004)(6506007)(52116002)(26005)(1076003)(2616005)(316002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: IL28E+BINdBW8pXf5CGkXicf/5x3VFOCmTkdUcEuJjMupCXJwFMVPpFCcsV4TOx7abXDcVSm7rXnHQ5GUZG1l8qxdXxMA68LHL6UAAu69nT+EJrhTZ9h7WFh3HrsNltEiMVwnOJskxqBeXFReHr/eBtgaFScRQXPYn2CQTGfXAfveE0QVU5bScebOeXcLxwUivj9wP7FpbjtfM5HEuptw/weA1YS2xrqRTFCWrNxs50jw45wnRUTYVKgNqLitsjL70+tIl8hnJoDJlUTWYDB4Ea/RZNKwiravxpb4E+ih0w1ehuHmAj5u+HuW3UgE2KtRAIMgKU3abUxLV5F6N9ojpWJAL8RhLulnJuavmJ6YnwNXbRuAawyjgGkeXFbqv5N0e//DH08lupB0pOBrG99rzA4mWWXWd6Fc5O8BScmt+SA/FtHihudV26euNpVzMsuYpLFees6fPuJoNgijrKXPi+XsYNNkI/zBYfWcl4u5cyRiPMc5rHIsBokwvuhu3tpOEU9UgUB9U6l3Mq/B9WFwAD8XbpGfLCjaama1CV6z2Upr+yj8P7yPpiUOgKf769l18nxSFyTDrYViHzx5SDiJsT0JBC5yL2mrf0ORw5pgddCpXe0e3MklSc1xDWBETC/CXRfGywVBqgZPe9bC7hRsQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e114505-b03f-402c-c271-08d860bb4a77
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2020 18:54:39.8573 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q4T3pjo66Y0AjvsUwUTwrwATiWqVdSNQsI4Wfj/bp79fmczF4GILKbWAjodnHmLcYBc4Mac7VbHvHWIvU8vlyr+ZrhrSzyEhcmv4JW7SE10=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3159
Received-SPF: pass client-ip=40.107.8.115;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/24 14:54:40
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

Like for read/write in a previous commit, drop extra indirection layer,
generate directly bdrv_readv_vmstate() and bdrv_writev_vmstate().

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/coroutines.h    | 10 +++----
 include/block/block.h |  6 ++--
 block/io.c            | 68 ++++++++++++++++++++++---------------------
 3 files changed, 43 insertions(+), 41 deletions(-)

diff --git a/block/coroutines.h b/block/coroutines.h
index 6c63a819c9..f69179f5ef 100644
--- a/block/coroutines.h
+++ b/block/coroutines.h
@@ -57,11 +57,9 @@ bdrv_common_block_status_above(BlockDriverState *bs,
                                int64_t *map,
                                BlockDriverState **file);
 
-int coroutine_fn
-bdrv_co_rw_vmstate(BlockDriverState *bs, QEMUIOVector *qiov, int64_t pos,
-                   bool is_read);
-int generated_co_wrapper
-bdrv_rw_vmstate(BlockDriverState *bs, QEMUIOVector *qiov, int64_t pos,
-                bool is_read);
+int coroutine_fn bdrv_co_readv_vmstate(BlockDriverState *bs,
+                                       QEMUIOVector *qiov, int64_t pos);
+int coroutine_fn bdrv_co_writev_vmstate(BlockDriverState *bs,
+                                        QEMUIOVector *qiov, int64_t pos);
 
 #endif /* BLOCK_COROUTINES_INT_H */
diff --git a/include/block/block.h b/include/block/block.h
index eef4cceaf0..8b87df69a1 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -572,8 +572,10 @@ int path_has_protocol(const char *path);
 int path_is_absolute(const char *path);
 char *path_combine(const char *base_path, const char *filename);
 
-int bdrv_readv_vmstate(BlockDriverState *bs, QEMUIOVector *qiov, int64_t pos);
-int bdrv_writev_vmstate(BlockDriverState *bs, QEMUIOVector *qiov, int64_t pos);
+int generated_co_wrapper
+bdrv_readv_vmstate(BlockDriverState *bs, QEMUIOVector *qiov, int64_t pos);
+int generated_co_wrapper
+bdrv_writev_vmstate(BlockDriverState *bs, QEMUIOVector *qiov, int64_t pos);
 int bdrv_save_vmstate(BlockDriverState *bs, const uint8_t *buf,
                       int64_t pos, int size);
 
diff --git a/block/io.c b/block/io.c
index cd5b689473..449b99b92c 100644
--- a/block/io.c
+++ b/block/io.c
@@ -2475,67 +2475,69 @@ int bdrv_is_allocated_above(BlockDriverState *top,
 }
 
 int coroutine_fn
-bdrv_co_rw_vmstate(BlockDriverState *bs, QEMUIOVector *qiov, int64_t pos,
-                   bool is_read)
+bdrv_co_readv_vmstate(BlockDriverState *bs, QEMUIOVector *qiov, int64_t pos)
 {
     BlockDriver *drv = bs->drv;
     BlockDriverState *child_bs = bdrv_primary_bs(bs);
     int ret = -ENOTSUP;
 
+    if (!drv) {
+        return -ENOMEDIUM;
+    }
+
     bdrv_inc_in_flight(bs);
 
-    if (!drv) {
-        ret = -ENOMEDIUM;
-    } else if (drv->bdrv_load_vmstate) {
-        if (is_read) {
-            ret = drv->bdrv_load_vmstate(bs, qiov, pos);
-        } else {
-            ret = drv->bdrv_save_vmstate(bs, qiov, pos);
-        }
+    if (drv->bdrv_load_vmstate) {
+        ret = drv->bdrv_load_vmstate(bs, qiov, pos);
     } else if (child_bs) {
-        ret = bdrv_co_rw_vmstate(child_bs, qiov, pos, is_read);
+        ret = bdrv_co_readv_vmstate(child_bs, qiov, pos);
     }
 
     bdrv_dec_in_flight(bs);
+
     return ret;
 }
 
-int bdrv_save_vmstate(BlockDriverState *bs, const uint8_t *buf,
-                      int64_t pos, int size)
+int coroutine_fn
+bdrv_co_writev_vmstate(BlockDriverState *bs, QEMUIOVector *qiov, int64_t pos)
 {
-    QEMUIOVector qiov = QEMU_IOVEC_INIT_BUF(qiov, buf, size);
-    int ret;
+    BlockDriver *drv = bs->drv;
+    BlockDriverState *child_bs = bdrv_primary_bs(bs);
+    int ret = -ENOTSUP;
 
-    ret = bdrv_writev_vmstate(bs, &qiov, pos);
-    if (ret < 0) {
-        return ret;
+    if (!drv) {
+        return -ENOMEDIUM;
     }
 
-    return size;
-}
+    bdrv_inc_in_flight(bs);
 
-int bdrv_writev_vmstate(BlockDriverState *bs, QEMUIOVector *qiov, int64_t pos)
-{
-    return bdrv_rw_vmstate(bs, qiov, pos, false);
+    if (drv->bdrv_save_vmstate) {
+        ret = drv->bdrv_save_vmstate(bs, qiov, pos);
+    } else if (child_bs) {
+        ret = bdrv_co_writev_vmstate(child_bs, qiov, pos);
+    }
+
+    bdrv_dec_in_flight(bs);
+
+    return ret;
 }
 
-int bdrv_load_vmstate(BlockDriverState *bs, uint8_t *buf,
+int bdrv_save_vmstate(BlockDriverState *bs, const uint8_t *buf,
                       int64_t pos, int size)
 {
     QEMUIOVector qiov = QEMU_IOVEC_INIT_BUF(qiov, buf, size);
-    int ret;
-
-    ret = bdrv_readv_vmstate(bs, &qiov, pos);
-    if (ret < 0) {
-        return ret;
-    }
+    int ret = bdrv_writev_vmstate(bs, &qiov, pos);
 
-    return size;
+    return ret < 0 ? ret : size;
 }
 
-int bdrv_readv_vmstate(BlockDriverState *bs, QEMUIOVector *qiov, int64_t pos)
+int bdrv_load_vmstate(BlockDriverState *bs, uint8_t *buf,
+                      int64_t pos, int size)
 {
-    return bdrv_rw_vmstate(bs, qiov, pos, true);
+    QEMUIOVector qiov = QEMU_IOVEC_INIT_BUF(qiov, buf, size);
+    int ret = bdrv_readv_vmstate(bs, &qiov, pos);
+
+    return ret < 0 ? ret : size;
 }
 
 /**************************************************************/
-- 
2.21.3


