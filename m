Return-Path: <SRS0=XKWp=7H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55530C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 10:10:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2241C2078B
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 10:10:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="nI3FThld"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2241C2078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42630 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdA41-0003VS-A2
	for qemu-devel@archiver.kernel.org; Mon, 25 May 2020 06:10:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49592)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jdA2o-0001is-8q; Mon, 25 May 2020 06:09:18 -0400
Received: from mail-vi1eur05on2099.outbound.protection.outlook.com
 ([40.107.21.99]:63329 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jdA2n-0003zE-CT; Mon, 25 May 2020 06:09:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iUxcRLHY5xdmwm4JeojFXRv2acgYGy+fyjwugOhSx0OFW7nrhYIkAgoMSSur/1Iige7vpKWLXVuPskir4rvxB0kFG6zTcoCGsOGr9EayOLjw5XEOSaGuD1cXbyFt1puGRj3WTswVo8hx4attXBYIj85/9UUSNgrMkCxcGUF4NhjB9khHJSRs1BM2IgUOxNX8CF9OCcZue6T7BZtDxom3ne0Ag87lNVkiyXZkOg6zZQiEWfzhU8X9USV831SPgB2vgkCgWkkrSNsMnpjPplwTLDLymD8KjWy2ENrhUA/gs7nyvQl8ixo7LRYGvBB5pRJD18tZRbPBQAa/la1m69owtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ft2bnljl6qaPO1d7df0oPlVI+hNCPWKxsLlPln/hrQA=;
 b=gv/r+hD6WC4CBN/W5YnVflf6w73BRAKlcIpPDSZk7ivJL3bqr5BO0ONFOfp2XBAsdmhjLOSZS80jFJZEEBipBzfL32eWeOqFiI3WbeDB2uUBmGK7wGzm3I3fBwhoaZdPjnbC5Lbv4uIRhsiTEYivfmmQF5q+8DagJ83SsXfUoFo6klJJm86tis6ONbJ3KkoMHExbSaReieRdmUfDbqcXZJMWjYRKs6kLHBlHKzgc9aKoTf6dyFtcLYkn2dSiv2QOt9M00l9zisjfqAGeZAFwLeAfVOJOISYIjgNsw0Jy94ACO+A8yto+wPjxP5lTXy9wawvrwI6ThTubdz5H2O8fhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ft2bnljl6qaPO1d7df0oPlVI+hNCPWKxsLlPln/hrQA=;
 b=nI3FThldO5GCtleJ2m6ogSJCMSl+G2B+oq3xLx6quc+zWcAe9r7ybe3sD0RuFE5Yd1or0wBDoaFQ3kO7SQw28czGZcfpLy3flXLUqc6G6m/eaYo5TRzWUdXbtvlxtOiRTlA7PGajU4NR577axXJVLH1BDSDw9uJOtB1bd/cezl4=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5447.eurprd08.prod.outlook.com (2603:10a6:20b:10b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.27; Mon, 25 May
 2020 10:09:15 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3021.029; Mon, 25 May 2020
 10:09:15 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v4 5/5] block/io: refactor save/load vmstate
Date: Mon, 25 May 2020 13:08:01 +0300
Message-Id: <20200525100801.13859-6-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200525100801.13859-1-vsementsov@virtuozzo.com>
References: <20200525100801.13859-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM3PR04CA0143.eurprd04.prod.outlook.com (2603:10a6:207::27)
 To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (185.215.60.147) by
 AM3PR04CA0143.eurprd04.prod.outlook.com (2603:10a6:207::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3021.23 via Frontend Transport; Mon, 25 May 2020 10:09:14 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.147]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e38bac9d-353f-4754-7c43-08d80093adca
X-MS-TrafficTypeDiagnostic: AM7PR08MB5447:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB54478ACBB891A577CE2F0D7FC1B30@AM7PR08MB5447.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:153;
X-Forefront-PRVS: 0414DF926F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B6+dKYmvDT9RL0hjCSMI9cLojNitA/e5r0jxp9GmV7dCJQexEgcmZRQ3FzcC536MkFlSzN+LCJcXsnUh8E5Y3NyGppDGGQJ/FtEkNp9z0DXseN4+MZ9V6DyYexyZg3lnY7XQTWKFQhIZi77SPq0z7dpH9zJiNEsUFExi4sSw/3X+fkXkUVS5mxYXDFbYawa58sBy0KAJdNP3qZyMNcAV8pNC6yjRAk0FBaJ+sljHqf8zO+8mihlzaKYHvz0pngIjQ4jWq1FfXwQYSuoTWht6YLdKVZWhYV4ExmJLCo58FjN7t/YFmht3nIpGG7P0Y1KSXV5aHZioDU2/IRKOyOY7nTyc4DtcZWeeEGwIe+KYvNNspJB907R1A4kPx2WcbkBk
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(39840400004)(376002)(136003)(346002)(366004)(69590400007)(26005)(16526019)(186003)(107886003)(6506007)(66946007)(66556008)(66476007)(956004)(2906002)(2616005)(52116002)(478600001)(6916009)(5660300002)(316002)(6512007)(6486002)(1076003)(6666004)(8936002)(36756003)(86362001)(4326008)(8676002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: i3wOzbIBLTGWp9fDSX9xdmD+U1Pw3ZTt1SClchG2jntQVuY/I9bTN0N3m1c2zuvU6SNyqIeDKLJKhXyKlTBFMcAuz1Gsf1+kzxd7UuaJ6HqZj86lbA1H1qPLdC9dr9z5FmgAr2/8myeMgP/xkAskl/3GSPJH86OKq4crfEKPc0+aMfzR94q8L5upopuZ88jmQCYqhyg5piu19CZb7DAI3XUSprPr1z9Ul2Uhbu4bioemkjmMJx/jg8Fyv9Ib3+LDN5z+VvJesaw5cqNGdx6rM3cigrOxBoyzrD4s9Q2A+GZOhPCyhdX3MW0WEvPb4AJIlrdESBe37G7lbCokbVipY67xcfcEB3BPQuDi0Pu8J1u2yvwbkahdmY5b4Xrn+XDTa226M+8c0qba9lN2giietRVL2tjzISFbJf9jrn6ufz+41rLLxgAbnMWbQqqSqJgEsLPTM4GKLsD0z3HkX8M6y3PsUW3v6nA/+JG8O/PfNpk=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e38bac9d-353f-4754-7c43-08d80093adca
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2020 10:09:15.0598 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XJV7YwVnAmPyIgqQIp+lWm8ziYAp+BTJDxe4vdwy4MuF38UVR4rMgEKtZ/Yb8VihtnWV5yg4tQEiOG1cmU1sDRdHrFKtdxWwYWE2VPBAX84=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5447
Received-SPF: pass client-ip=40.107.21.99;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/25 06:09:15
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
 ehabkost@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com,
 stefanha@redhat.com, crosa@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Like for read/write in a previous commit, drop extra indirection layer,
generate directly bdrv_readv_vmstate() and bdrv_writev_vmstate().

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/coroutines.h    | 10 +++----
 include/block/block.h |  6 ++--
 block/io.c            | 67 ++++++++++++++++++++++---------------------
 3 files changed, 42 insertions(+), 41 deletions(-)

diff --git a/block/coroutines.h b/block/coroutines.h
index 233b8b3694..fd0dd6a5e6 100644
--- a/block/coroutines.h
+++ b/block/coroutines.h
@@ -58,11 +58,9 @@ bdrv_common_block_status_above(BlockDriverState *bs,
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
index dce99f8453..618c0b76b5 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -568,8 +568,10 @@ int path_has_protocol(const char *path);
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
index 305ee7219a..8c1da3c335 100644
--- a/block/io.c
+++ b/block/io.c
@@ -2491,66 +2491,67 @@ int bdrv_is_allocated_above(BlockDriverState *top,
 }
 
 int coroutine_fn
-bdrv_co_rw_vmstate(BlockDriverState *bs, QEMUIOVector *qiov, int64_t pos,
-                   bool is_read)
+bdrv_co_readv_vmstate(BlockDriverState *bs, QEMUIOVector *qiov, int64_t pos)
 {
     BlockDriver *drv = bs->drv;
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
     } else if (bs->file) {
-        ret = bdrv_co_rw_vmstate(bs->file->bs, qiov, pos, is_read);
+        ret = bdrv_co_readv_vmstate(bs->file->bs, qiov, pos);
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
+    if (drv->bdrv_load_vmstate) {
+        ret = drv->bdrv_save_vmstate(bs, qiov, pos);
+    } else if (bs->file) {
+        ret = bdrv_co_writev_vmstate(bs->file->bs, qiov, pos);
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
2.21.0


