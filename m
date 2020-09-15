Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40814C433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 16:51:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2C3720829
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 16:51:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="I1+cFFpa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2C3720829
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45168 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIEAw-0000uB-TV
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 12:51:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38404)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kIE4U-0000LS-VT; Tue, 15 Sep 2020 12:44:47 -0400
Received: from mail-eopbgr00099.outbound.protection.outlook.com
 ([40.107.0.99]:58470 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kIE4T-0007hn-2v; Tue, 15 Sep 2020 12:44:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H1brkcUFG2JLKglFrOWPHos0R+V8T0KGmIgeG+vqM4Ok5Jsa1L1YK7Kx/3CLcFraboumVR1/YUcU6PSbjjjCG9WA37rhWxC1wy5ZFsLWZm4tMOQfLu18/F61QOdw5bSKeqmfuqsh6hchoM0GgmmqiLKFxjn+STq55aAMZY2+zGyYqD6/yuksSLPXvMMtp77FVxKdzfcVOacuFyjCUuroJ5S2/Bw5Nev6hde0FSlGX8ey+CP5dE9MlgJgPA7p/EUK01ZxP0bM+DtUShVTQVOT0C6hN0EheZUeJ/+THIVKhyREd/aQcA6HY8vu8IUgL/SA08niLSw5TAQrmPX3iU4JAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OSnVLhzq5WN5xeH2xNaNt7J24Fm2sh2hE7kfHigSJVA=;
 b=PgAOj17+MDZ/W8bXX4vcmTDlKRzJR2RtHRJAdxvDzEUBpw4v6VAToIQmDfv/xzXUgTLCRaK7L3iAE22smZG3gPCp1Qug79rjdH6eEo99jnh0PZGbaV0ZY18wM6Zst/xpQ5w8pWqqpv08zMbFBmCC6VQ4imybDo5YPP14Xa9E9TAnSAU92a5fg4RDakgUjcfgDkQNkFtWpqlZRnsYbnJtSe0dzaGNTNNhPi7XI07w7iRRpI711JI43u8G605l3AcEDI1u/ppp97SXFC43Y6RMZA/PpmDmAbE5o6nQ+N+oVQb8pZd7sKwu9VypiIQJQdpB19uxsM5wUnH77Is/t+5XQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OSnVLhzq5WN5xeH2xNaNt7J24Fm2sh2hE7kfHigSJVA=;
 b=I1+cFFpaZ0V3S0s0DGcBhaHh+Y0teSr+BjJ9OYl7NlxQv5ErFWVY9X0oMxoGZAqf0wcpUfrzGctkMMIs5ekzpEd35vEQDBwk3p/2wXkiXto/us8fB5S9NiptXPVFTqWVO0EaPLdzYNrjd19hpe/pHR6YTX/nyqg/tijdnDHhESM=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM5PR0801MB1652.eurprd08.prod.outlook.com (2603:10a6:203:3c::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.17; Tue, 15 Sep
 2020 16:44:30 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692%8]) with mapi id 15.20.3370.019; Tue, 15 Sep 2020
 16:44:30 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, crosa@redhat.com, ehabkost@redhat.com,
 fam@euphon.net, stefanha@redhat.com, mreitz@redhat.com, kwolf@redhat.com,
 vsementsov@virtuozzo.com, den@openvz.org, eblake@redhat.com
Subject: [PATCH v8 7/7] block/io: refactor save/load vmstate
Date: Tue, 15 Sep 2020 19:44:11 +0300
Message-Id: <20200915164411.20590-8-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200915164411.20590-1-vsementsov@virtuozzo.com>
References: <20200915164411.20590-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR07CA0025.eurprd07.prod.outlook.com
 (2603:10a6:208:ac::38) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.75) by
 AM0PR07CA0025.eurprd07.prod.outlook.com (2603:10a6:208:ac::38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.5 via Frontend Transport; Tue, 15 Sep 2020 16:44:29 +0000
X-Mailer: git-send-email 2.21.3
X-Originating-IP: [185.215.60.75]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 08bfc6d1-271e-49da-77d8-08d859969dba
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1652:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM5PR0801MB165201A74049396ECE9A4CB7C1200@AM5PR0801MB1652.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:153;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ECLOZ5IOthkpuErqzL/g/K+srYCm490p7iOBF87O0denR31IMypD3TvYcxWon5OpOhzEdS8PcZ+/GwiBhijDN4RmNSR7IYZrYEtuKl/EeT6rv/26zqjWpqvi9O8/AhySTOL+jwgBl9OPthoLAcRFXA9H9Nf4WRlWMZGufwtpsMnd8NzF0/mlbzCuGQ4SunlHQ4k+NVOziyrWPtoTYYtSvTpkUb8rm25MGOutAya15JhycEPQZ/91D3rc5y+2Hix7GsxcbUDuCDxf0FWS8dwNR/TVJ+pcRrw37nRK7gL7vkyUBd6stGchLo2aGCf6IG/v3jAqP+XPfOvA0orV+kSzwymdpKc6NMpEdgxtzbEciGaxI0LlAloByMBUhwEJlusn
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(366004)(396003)(136003)(39840400004)(6916009)(6512007)(2906002)(83380400001)(36756003)(478600001)(1076003)(6486002)(86362001)(2616005)(956004)(8676002)(316002)(186003)(16526019)(5660300002)(66946007)(6666004)(52116002)(66476007)(8936002)(26005)(66556008)(6506007)(4326008);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: WGsrgVZETWIxV0Xk1i//7fnONp7lQJwHmtPS0NAjyVDKQmDOx7Tlv6DlqJP4EamWx0cdsKr766vu+YB6qSF2AvGrKtBqZEpqzLn4WshU8xfvDXu75xLRqnqH/zHu5UOBYcUTVAc/yjA65QiaXQXBZmA3FDLuPVwXFak0ZHasNDmBR0sAgiQiV+WGsXfRpP7XAyNFLRizhWEMuFeph+FyPegzNk3/XOjWsvVimDkr/fqKUJmOLodVI6sPImXbhARMMfv6c14lmBtTYGhYry5CwBjKg1dzgYo6RBMxLy6VJrL+loSoHMNOvo/CvD+0XwKQenp6AoVUxLZ6Fry0TpjJr0UaPdQkQEkjFrlgafGt1KVGRzHLlzs0fJe9WEkX8YkUi2zemtJFMQJtDLxqv1Rh3lSjjpCfUkdyu+KWKi46+Zgp9XgRZ5riIxOy4M6PT7eEE6vlz9D0wjpdPgi3zH2VsDUzD98r5AguCaXkhm+VNHwNLRCR12KnR+TZ+g4G6fsgyiewoy7A5/YD4NzrriwZAzf4AHYdUhhOtukIF32C62zm+e2fJmZuLzY3NxAuPRcwoog95miV/3lngg0+KwxDhGMicoONtMoGOhMxTj9wizAtTpi9PgDhKMR3m2GL7eGDoa/f6MCHcIkDDE5pyETHIA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08bfc6d1-271e-49da-77d8-08d859969dba
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2020 16:44:30.2161 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aMROoGa5OJFLlH7Yk/gpjJHSIquUGeVUq9CzubilXsONGtcK4gseoxbOivIWk3KpLZjc3OyJW4qcAD1vvel/GWv5FkckOTWuX9b1PdeCxdw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1652
Received-SPF: pass client-ip=40.107.0.99;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR02-AM5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/15 12:44:37
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
---
 block/coroutines.h    | 10 +++----
 include/block/block.h |  6 ++--
 block/io.c            | 67 ++++++++++++++++++++++---------------------
 3 files changed, 42 insertions(+), 41 deletions(-)

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
index b8b4c177de..6cd789724b 100644
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
index 68d7d9cf80..84f82bc069 100644
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
2.21.3


