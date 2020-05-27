Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08D3DC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 20:44:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C64FF20835
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 20:44:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="DLJ9rCI2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C64FF20835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58434 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1je2uh-00065a-RK
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 16:44:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35256)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1je2oM-0004hW-Fx; Wed, 27 May 2020 16:38:02 -0400
Received: from mail-am6eur05on2112.outbound.protection.outlook.com
 ([40.107.22.112]:57342 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1je2oL-0007uz-JK; Wed, 27 May 2020 16:38:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=buc6J1SAiJowE9/OxwdoNgrkUK9EYikD4oHdwJHjUrdXikCc3JLajux/EgrgJ4IOFjSbgurdjlM9T9A4u/8lsrfDAOS07PUAiVg1Qg+wpO3iPtlzI+cSUDhElg1H854MJFMQc14MxOVjpe0IGz4IkjltGco1PP4PeVhfiM+998QUS6ZOxLRgOp/vS1p4EyoUIAtZCflEKMKrzJC9S1uu4ruIeDTFeOhwljDVoezg18K89r8XdHB/eN3ntJYkDe0q0RtuwGp/B6cNYPnuXz1h22dVTtw+0Dj8AjtNjurww17hMjDEK5stgGg1wUr91NL5UtiUgoOqGhWQiYML9qYzHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pr+GJNdchyYPHs5RK2uBet6LwgwPvfZ+Xutgzg2P2MA=;
 b=nlZ/KQ/iGzjLWbuRNcyLIbsmgCNOcfpVQ6wAfklgE9TgIUveaIZHMUtr8zbHQ88sx9YaIPcoU5kh3rGpfw2S3zQGMXj9LeaoxYvBZ+xNxTcsWKO5pPJbXAYV51EWsnhbKvXbtmBHCS3MivCoXbSefOwFkHVadkC94v/qEIssWZvGDrKgzOVcUpBt1/uNUUDaS/EpcCBasS/Po/A3L3T0zAxlN4gGP/xuUTczQX0/JifPsS9O1c3rhVxnWbfHHmhhJTQCIBRfJeLcHn9CUkis3JSP1SIqI8oASyc7jpWc4ApZGwrYQLMX15U7hraOoVIq4xT9K2apwUrxKNkn9BzLrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pr+GJNdchyYPHs5RK2uBet6LwgwPvfZ+Xutgzg2P2MA=;
 b=DLJ9rCI2oKrIryWjRfuLDVr4m4rTGb1T11ZLDUfElVbsnPN144JfvMo+6BBaFM12KyIKmjmwlyWWUuUyFGP9PggwwufP3fVovONpHgAt9VdkIPuLF62LswwDEYuFRKWW0W7+DUEexF4nPtdH0+NTlPGRcEuIkj65orW5Rs2n37k=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5336.eurprd08.prod.outlook.com (2603:10a6:20b:105::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.24; Wed, 27 May
 2020 20:37:55 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%4]) with mapi id 15.20.3045.018; Wed, 27 May 2020
 20:37:55 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v5 7/7] block/io: refactor save/load vmstate
Date: Wed, 27 May 2020 23:37:33 +0300
Message-Id: <20200527203733.16129-8-vsementsov@virtuozzo.com>
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
 15.20.3045.17 via Frontend Transport; Wed, 27 May 2020 20:37:54 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.148]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3f17480e-e023-46a1-9af2-08d8027dd5bf
X-MS-TrafficTypeDiagnostic: AM7PR08MB5336:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB53366C378F311AF53971B068C1B10@AM7PR08MB5336.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:153;
X-Forefront-PRVS: 04163EF38A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pKYWbF68LmdTIdGCV4aqpumMWSvcEnkWfw47nzPCspQuAK0e5BBQl/uJUZ4JupbtBbXPP7QmraNVYV7Hf4Mqf/Vfs+yr7CQFkWqeC5qcbFw/ws/gHw0Gmo7M71n+xkRMvG4XEjaus0/QxLGC/7Mr9mJDGwULKIW5rFTrOWTB1NQTI0425bLx1T+6Tt+oQFZAf2uAFS9wsZ3Rc70rth0RrGVuAt/1UVDojTtGXtSpSViySUIAbyczP1mnIqImx2BB8W36EEGDOon6rvzeD8SfO+QCqs7acVJe7qd1L+1WGh2eq8pSt2GG2cTK1wfXTRpYNpqDkDjvRmtbN2ZLa+cjLg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(366004)(396003)(39850400004)(376002)(136003)(956004)(66556008)(66946007)(66476007)(8676002)(6486002)(6512007)(1076003)(478600001)(186003)(316002)(5660300002)(6916009)(2616005)(6506007)(8936002)(16526019)(26005)(2906002)(6666004)(83380400001)(36756003)(4326008)(52116002)(86362001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 5ca44NcNtDHYtFScqJVyCNAtjfwZw/TUdQZEiaM8GCAjfg5B62yt51luPogJlfxQDguW9Gya1GJp4VpVDINtbfeTWvvvdodIWW19Wk851nbOW7eYedvfh9Opb91bxUnMAGsNCHEyTTHZXqPNjp0YLA7tp8sW7tfie2K4ib0+Xf2Iw6pMTj6Nu07HHdh5Eo2eVM6XzoV7pp3gVPOJl9kJesO68dH0E1fuHYhGyTNmDvSMOBedEZpMaRj+KHipRQ4tgwkPxnfKAXGlaq/FIN9kO9mBoldQ3JYo8exhwPUm0BzIf56kQlg6O2LIK0RAXclHaJR9lzKfeEn4HD+UDXUsxQLOWDfb/sw1t9FBKzuK8U8feF+VnMziYomFo+jW05NuDwqCMb/PXhvcvpJNu1h4KwbFV4PJ7f1D+SgaGOCoa7mhwgwSwZRPjJnFgBw/Y3X9SVmUEkHwUhhbIQG/eGKGthfsnzrw6QYo6RBdSveq8nQ=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f17480e-e023-46a1-9af2-08d8027dd5bf
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2020 20:37:55.4804 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BaPlm/vXdv9N5xPN6+uuttNs2BmUS4pIcYz46W+8Vj2NBKLbpe4Eu8cZn35aVrJlBXGtRO1CEhi4Dg90kzjZ0qKcrJOXTJAfc4s5mbxyafA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5336
Received-SPF: pass client-ip=40.107.22.112;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/27 16:37:50
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

Like for read/write in a previous commit, drop extra indirection layer,
generate directly bdrv_readv_vmstate() and bdrv_writev_vmstate().

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 block/coroutines.h    | 10 +++----
 include/block/block.h |  6 ++--
 block/io.c            | 67 ++++++++++++++++++++++---------------------
 3 files changed, 42 insertions(+), 41 deletions(-)

diff --git a/block/coroutines.h b/block/coroutines.h
index 56c0be6f8f..7e14fdeccf 100644
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
index dadb6e796f..cc2edbeb65 100644
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


