Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4164C4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 19:04:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DFF823600
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 19:04:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="CWVe6wAD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DFF823600
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48058 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLWXo-0000dC-1b
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 15:04:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43902)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kLWOe-0001WZ-8y; Thu, 24 Sep 2020 14:55:12 -0400
Received: from mail-eopbgr130114.outbound.protection.outlook.com
 ([40.107.13.114]:8257 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kLWOZ-0002O2-1f; Thu, 24 Sep 2020 14:55:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QQB7RnjEBow6k4TDCgvha68UzjMxcCd0e2pKBYn6R6zsPALrxUaMX1CK6/7RDgjN5pBt5ENmpdysxTwMMulXLaw6C31cdvgy3cOKreYL82KA8edrAGqWcaoiG6lT0eaNsMvmaVWIY6PlSGSxpV/07emUJZLyrKURdodmFuumaET5JK8fa9OQN8FwTtzcUPwxs+cKLECoCM/ZNugG5VtFRye4FaDlM9sSLXeQFIwJK5GB/2ojGO5nVIexE+o/yIZNAm/jDkTS9JrkGtZC9+5PAKxNIL27m1A7P/Q2XJsnuaJRGbL+m2I9jAhMZ+Vp2RUoLCXgcx5ZkL70XGDXRkepQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hXQQGTzo02j8An8WJoIXxuJeMPbVrK5DY7DM23C0WiY=;
 b=cnYnM0GIFEtGCJZPmGrme0trYxLjlbnDcMF7sGUNWusijp3EZeiH9Lq/T1siTj2OR5rmM4/1xGSJbeP1g5dMfKQD8AvFW/tCuCyqKbOWB/uqLkLh+TTZpUqPzLlcaZRKCGtCEW6hmizeJwGMORoayOYmAt6uUZKi9hOFZzFDa5nJKsMH9uqiL/pljVWuMzAIJjMZiB4m3XqdtdvFdmxrVx0K5+Zmsss9+s6axlMiuRzDVzZIzEGgaCV5oI6apsD2+moTlcDv/h0AoHEKP62FAfyCJqbUUUMVpmERuSdDglwgv9NFIBu0REqOPT6K6D65ZdzpGk7C0hrY2zGeq4vddQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hXQQGTzo02j8An8WJoIXxuJeMPbVrK5DY7DM23C0WiY=;
 b=CWVe6wADJOWyhmMef+8bPzR8rMaF3v12M3dt5Jacvn6cMQbYADYAZ+Jgn0Sc5delfpyS1svwT8a85H0s6paKjyvUx9uhmcLmIiDl2LZJkNVoN+2+EcUy6i3vCO6Y3M+MmBx+j0Np72AnO/qKaeO31rl7NQaIiRNgwmvKOxKAc/I=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4341.eurprd08.prod.outlook.com (2603:10a6:20b:b9::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14; Thu, 24 Sep
 2020 18:54:38 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692%8]) with mapi id 15.20.3370.033; Thu, 24 Sep 2020
 18:54:38 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, crosa@redhat.com, ehabkost@redhat.com,
 fam@euphon.net, stefanha@redhat.com, mreitz@redhat.com, kwolf@redhat.com,
 den@openvz.org, vsementsov@virtuozzo.com, eblake@redhat.com
Subject: [PATCH v9 5/7] block: generate coroutine-wrapper code
Date: Thu, 24 Sep 2020 21:54:12 +0300
Message-Id: <20200924185414.28642-6-vsementsov@virtuozzo.com>
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
 Transport; Thu, 24 Sep 2020 18:54:37 +0000
X-Mailer: git-send-email 2.21.3
X-Originating-IP: [185.215.60.94]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8492b96d-7434-4483-3555-08d860bb495b
X-MS-TrafficTypeDiagnostic: AM6PR08MB4341:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB4341AD0C39BCB616A4688E62C1390@AM6PR08MB4341.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:196;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +AiuPFahtr5jzf2vVlHEtFnFmkkR7+O/CUqGwI8cdEqPRCiBOra6eXzKnljOcSxmemM1mH/les9LBvViTSMRdO9PWc5xrDdmP3HjfnlSDrhbIwOiCwpzpqcBg4tAjBTVOZ9Wf33FMoZldFynmpyyrqvxASAEyleGa89SZFQIQBgAO7MsLSQCYqgRMRmO3jEFLHKBOFxT6lJkocYyi0IOJ9nrcDTZ/nRLMIf0pEnJyhv+48957yEMYxsRhM0eP2zB0zIxGVB9JtAolcpXbIJKzy/3TgzUgrIVuLmGb78YL2FMdVbo4PzHcoWSKyrect/scyKXtSPuYcwyky9cgH8ARmM7mJpSai1NRFf4tOePV4s23+JmYUGh0yK+fD9sTmD8
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(396003)(346002)(366004)(39840400004)(316002)(83380400001)(66476007)(6506007)(186003)(16526019)(5660300002)(2906002)(36756003)(6666004)(8936002)(8676002)(66946007)(2616005)(956004)(52116002)(6512007)(66556008)(86362001)(26005)(4326008)(478600001)(6916009)(1076003)(6486002)(30864003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: nE+8LNc2oc3Ol4VNCR53yROFh8q9T+xSpV1LITlz/AOTZqebpOPJwAX+xdJtOH15H/4TpvZkVVFCgJaFeOvbK55gVQXe/cbdPOpkJo8BjvvF3rHMMipfly4JukLoJJux+mKuqRb906mWR9ec68MgUCRn2h5PzzZ4ETDuX/E8anXvnER+ffkmUqBAus4bC2QBru+PgFOl0eqH8OcVFxMQKz+0g4UomAdLQUaYSHIuem2PzHkNZrImfYMiQQ+idvd1EnEOaReol74NXEl/7P5+LiyviDzn+TgJDDbplhOyv2aCDYTKHbS8uqYspDk7LjUKUqELfCdFPWvRxZKqGw3CL0BbNfu+jD0jzToqSOs4nog2B6Qpl7XpxOeYbj/Gz65nFzqa6eJ3Cc2ny+mg7frP4OzS65+Kr7Txv441gV6QwyXPihMUQd0fGQB4R4b2WNq+fLeBCNV9jlHnTVW+GpiXtyKYXe40sQEtRGqJkOIuEypa7jFDYn81h/UiE5UaW8sqnHM2C0cFv6kEMRwN8mkRuqmwhwh53mAwzUN7G3QJvaKi8HqIAwGUD/s3cA2EELScq+H04P0O8b/qTCiS63YUTwQAYt0CLSw3gMwnouXIyaydU71B0mOl/vJKTRkl9GrKQTXh99yNP+61tbv2Y+/fpQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8492b96d-7434-4483-3555-08d860bb495b
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2020 18:54:38.0602 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7cFRqWCQXLDEjAdgBHGVoLf9LM0k+EvYflyI8z+edssoKfPAkLW881ds856tISXxaySAPLuuJGideeLH7iXIJIZKID0NtMsTrdtHf1HmFMI=
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

Use code generation implemented in previous commit to generated
coroutine wrappers in block.c and block/io.c

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/coroutines.h    |   6 +-
 include/block/block.h |  16 ++--
 block.c               |  73 ---------------
 block/io.c            | 212 ------------------------------------------
 4 files changed, 13 insertions(+), 294 deletions(-)

diff --git a/block/coroutines.h b/block/coroutines.h
index 9ce1730a09..c62b3a2697 100644
--- a/block/coroutines.h
+++ b/block/coroutines.h
@@ -34,7 +34,7 @@ int coroutine_fn bdrv_co_invalidate_cache(BlockDriverState *bs, Error **errp);
 int coroutine_fn
 bdrv_co_prwv(BdrvChild *child, int64_t offset, QEMUIOVector *qiov,
              bool is_write, BdrvRequestFlags flags);
-int
+int generated_co_wrapper
 bdrv_prwv(BdrvChild *child, int64_t offset, QEMUIOVector *qiov,
           bool is_write, BdrvRequestFlags flags);
 
@@ -47,7 +47,7 @@ bdrv_co_common_block_status_above(BlockDriverState *bs,
                                   int64_t *pnum,
                                   int64_t *map,
                                   BlockDriverState **file);
-int
+int generated_co_wrapper
 bdrv_common_block_status_above(BlockDriverState *bs,
                                BlockDriverState *base,
                                bool want_zero,
@@ -60,7 +60,7 @@ bdrv_common_block_status_above(BlockDriverState *bs,
 int coroutine_fn
 bdrv_co_rw_vmstate(BlockDriverState *bs, QEMUIOVector *qiov, int64_t pos,
                    bool is_read);
-int
+int generated_co_wrapper
 bdrv_rw_vmstate(BlockDriverState *bs, QEMUIOVector *qiov, int64_t pos,
                 bool is_read);
 
diff --git a/include/block/block.h b/include/block/block.h
index 0f0ddc51b4..f2d85f2cf1 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -403,8 +403,9 @@ void bdrv_refresh_filename(BlockDriverState *bs);
 int coroutine_fn bdrv_co_truncate(BdrvChild *child, int64_t offset, bool exact,
                                   PreallocMode prealloc, BdrvRequestFlags flags,
                                   Error **errp);
-int bdrv_truncate(BdrvChild *child, int64_t offset, bool exact,
-                  PreallocMode prealloc, BdrvRequestFlags flags, Error **errp);
+int generated_co_wrapper
+bdrv_truncate(BdrvChild *child, int64_t offset, bool exact,
+              PreallocMode prealloc, BdrvRequestFlags flags, Error **errp);
 
 int64_t bdrv_nb_sectors(BlockDriverState *bs);
 int64_t bdrv_getlength(BlockDriverState *bs);
@@ -446,7 +447,8 @@ typedef enum {
     BDRV_FIX_ERRORS   = 2,
 } BdrvCheckMode;
 
-int bdrv_check(BlockDriverState *bs, BdrvCheckResult *res, BdrvCheckMode fix);
+int generated_co_wrapper bdrv_check(BlockDriverState *bs, BdrvCheckResult *res,
+                                    BdrvCheckMode fix);
 
 /* The units of offset and total_work_size may be chosen arbitrarily by the
  * block driver; total_work_size may change during the course of the amendment
@@ -470,12 +472,13 @@ void bdrv_aio_cancel_async(BlockAIOCB *acb);
 int bdrv_co_ioctl(BlockDriverState *bs, int req, void *buf);
 
 /* Invalidate any cached metadata used by image formats */
-int bdrv_invalidate_cache(BlockDriverState *bs, Error **errp);
+int generated_co_wrapper bdrv_invalidate_cache(BlockDriverState *bs,
+                                               Error **errp);
 void bdrv_invalidate_cache_all(Error **errp);
 int bdrv_inactivate_all(void);
 
 /* Ensure contents are flushed to disk.  */
-int bdrv_flush(BlockDriverState *bs);
+int generated_co_wrapper bdrv_flush(BlockDriverState *bs);
 int coroutine_fn bdrv_co_flush(BlockDriverState *bs);
 int bdrv_flush_all(void);
 void bdrv_close_all(void);
@@ -490,7 +493,8 @@ void bdrv_drain_all(void);
     AIO_WAIT_WHILE(bdrv_get_aio_context(bs_),              \
                    cond); })
 
-int bdrv_pdiscard(BdrvChild *child, int64_t offset, int64_t bytes);
+int generated_co_wrapper bdrv_pdiscard(BdrvChild *child, int64_t offset,
+                                       int64_t bytes);
 int bdrv_co_pdiscard(BdrvChild *child, int64_t offset, int64_t bytes);
 int bdrv_has_zero_init_1(BlockDriverState *bs);
 int bdrv_has_zero_init(BlockDriverState *bs);
diff --git a/block.c b/block.c
index 6e2bfb93d8..de056c695a 100644
--- a/block.c
+++ b/block.c
@@ -4691,43 +4691,6 @@ int coroutine_fn bdrv_co_check(BlockDriverState *bs,
     return bs->drv->bdrv_co_check(bs, res, fix);
 }
 
-typedef struct CheckCo {
-    BlockDriverState *bs;
-    BdrvCheckResult *res;
-    BdrvCheckMode fix;
-    int ret;
-} CheckCo;
-
-static void coroutine_fn bdrv_check_co_entry(void *opaque)
-{
-    CheckCo *cco = opaque;
-    cco->ret = bdrv_co_check(cco->bs, cco->res, cco->fix);
-    aio_wait_kick();
-}
-
-int bdrv_check(BlockDriverState *bs,
-               BdrvCheckResult *res, BdrvCheckMode fix)
-{
-    Coroutine *co;
-    CheckCo cco = {
-        .bs = bs,
-        .res = res,
-        .ret = -EINPROGRESS,
-        .fix = fix,
-    };
-
-    if (qemu_in_coroutine()) {
-        /* Fast-path if already in coroutine context */
-        bdrv_check_co_entry(&cco);
-    } else {
-        co = qemu_coroutine_create(bdrv_check_co_entry, &cco);
-        bdrv_coroutine_enter(bs, co);
-        BDRV_POLL_WHILE(bs, cco.ret == -EINPROGRESS);
-    }
-
-    return cco.ret;
-}
-
 /*
  * Return values:
  * 0        - success
@@ -5860,42 +5823,6 @@ int coroutine_fn bdrv_co_invalidate_cache(BlockDriverState *bs, Error **errp)
     return 0;
 }
 
-typedef struct InvalidateCacheCo {
-    BlockDriverState *bs;
-    Error **errp;
-    bool done;
-    int ret;
-} InvalidateCacheCo;
-
-static void coroutine_fn bdrv_invalidate_cache_co_entry(void *opaque)
-{
-    InvalidateCacheCo *ico = opaque;
-    ico->ret = bdrv_co_invalidate_cache(ico->bs, ico->errp);
-    ico->done = true;
-    aio_wait_kick();
-}
-
-int bdrv_invalidate_cache(BlockDriverState *bs, Error **errp)
-{
-    Coroutine *co;
-    InvalidateCacheCo ico = {
-        .bs = bs,
-        .done = false,
-        .errp = errp
-    };
-
-    if (qemu_in_coroutine()) {
-        /* Fast-path if already in coroutine context */
-        bdrv_invalidate_cache_co_entry(&ico);
-    } else {
-        co = qemu_coroutine_create(bdrv_invalidate_cache_co_entry, &ico);
-        bdrv_coroutine_enter(bs, co);
-        BDRV_POLL_WHILE(bs, !ico.done);
-    }
-
-    return ico.ret;
-}
-
 void bdrv_invalidate_cache_all(Error **errp)
 {
     BlockDriverState *bs;
diff --git a/block/io.c b/block/io.c
index 897139a8b2..c1360ba57d 100644
--- a/block/io.c
+++ b/block/io.c
@@ -890,50 +890,6 @@ static int bdrv_check_byte_request(BlockDriverState *bs, int64_t offset,
     return 0;
 }
 
-typedef int coroutine_fn BdrvRequestEntry(void *opaque);
-typedef struct BdrvRunCo {
-    BdrvRequestEntry *entry;
-    void *opaque;
-    int ret;
-    bool done;
-    Coroutine *co; /* Coroutine, running bdrv_run_co_entry, for debugging */
-} BdrvRunCo;
-
-static void coroutine_fn bdrv_run_co_entry(void *opaque)
-{
-    BdrvRunCo *arg = opaque;
-
-    arg->ret = arg->entry(arg->opaque);
-    arg->done = true;
-    aio_wait_kick();
-}
-
-static int bdrv_run_co(BlockDriverState *bs, BdrvRequestEntry *entry,
-                       void *opaque)
-{
-    if (qemu_in_coroutine()) {
-        /* Fast-path if already in coroutine context */
-        return entry(opaque);
-    } else {
-        BdrvRunCo s = { .entry = entry, .opaque = opaque };
-
-        s.co = qemu_coroutine_create(bdrv_run_co_entry, &s);
-        bdrv_coroutine_enter(bs, s.co);
-
-        BDRV_POLL_WHILE(bs, !s.done);
-
-        return s.ret;
-    }
-}
-
-typedef struct RwCo {
-    BdrvChild *child;
-    int64_t offset;
-    QEMUIOVector *qiov;
-    bool is_write;
-    BdrvRequestFlags flags;
-} RwCo;
-
 int coroutine_fn bdrv_co_prwv(BdrvChild *child, int64_t offset,
                               QEMUIOVector *qiov, bool is_write,
                               BdrvRequestFlags flags)
@@ -945,32 +901,6 @@ int coroutine_fn bdrv_co_prwv(BdrvChild *child, int64_t offset,
     }
 }
 
-static int coroutine_fn bdrv_rw_co_entry(void *opaque)
-{
-    RwCo *rwco = opaque;
-
-    return bdrv_co_prwv(rwco->child, rwco->offset, rwco->qiov,
-                        rwco->is_write, rwco->flags);
-}
-
-/*
- * Process a vectored synchronous request using coroutines
- */
-int bdrv_prwv(BdrvChild *child, int64_t offset,
-              QEMUIOVector *qiov, bool is_write,
-              BdrvRequestFlags flags)
-{
-    RwCo rwco = {
-        .child = child,
-        .offset = offset,
-        .qiov = qiov,
-        .is_write = is_write,
-        .flags = flags,
-    };
-
-    return bdrv_run_co(child->bs, bdrv_rw_co_entry, &rwco);
-}
-
 int bdrv_pwrite_zeroes(BdrvChild *child, int64_t offset,
                        int bytes, BdrvRequestFlags flags)
 {
@@ -2247,18 +2177,6 @@ int bdrv_flush_all(void)
     return result;
 }
 
-
-typedef struct BdrvCoBlockStatusData {
-    BlockDriverState *bs;
-    BlockDriverState *base;
-    bool want_zero;
-    int64_t offset;
-    int64_t bytes;
-    int64_t *pnum;
-    int64_t *map;
-    BlockDriverState **file;
-} BdrvCoBlockStatusData;
-
 /*
  * Returns the allocation status of the specified sectors.
  * Drivers not implementing the functionality are assumed to not support
@@ -2494,43 +2412,6 @@ bdrv_co_common_block_status_above(BlockDriverState *bs,
     return ret;
 }
 
-/* Coroutine wrapper for bdrv_block_status_above() */
-static int coroutine_fn bdrv_block_status_above_co_entry(void *opaque)
-{
-    BdrvCoBlockStatusData *data = opaque;
-
-    return bdrv_co_common_block_status_above(data->bs, data->base,
-                                             data->want_zero,
-                                             data->offset, data->bytes,
-                                             data->pnum, data->map, data->file);
-}
-
-/*
- * Synchronous wrapper around bdrv_co_block_status_above().
- *
- * See bdrv_co_block_status_above() for details.
- */
-int bdrv_common_block_status_above(BlockDriverState *bs,
-                                   BlockDriverState *base,
-                                   bool want_zero, int64_t offset,
-                                   int64_t bytes, int64_t *pnum,
-                                   int64_t *map,
-                                   BlockDriverState **file)
-{
-    BdrvCoBlockStatusData data = {
-        .bs = bs,
-        .base = base,
-        .want_zero = want_zero,
-        .offset = offset,
-        .bytes = bytes,
-        .pnum = pnum,
-        .map = map,
-        .file = file,
-    };
-
-    return bdrv_run_co(bs, bdrv_block_status_above_co_entry, &data);
-}
-
 int bdrv_block_status_above(BlockDriverState *bs, BlockDriverState *base,
                             int64_t offset, int64_t bytes, int64_t *pnum,
                             int64_t *map, BlockDriverState **file)
@@ -2624,13 +2505,6 @@ int bdrv_is_allocated_above(BlockDriverState *top,
     return 0;
 }
 
-typedef struct BdrvVmstateCo {
-    BlockDriverState    *bs;
-    QEMUIOVector        *qiov;
-    int64_t             pos;
-    bool                is_read;
-} BdrvVmstateCo;
-
 int coroutine_fn
 bdrv_co_rw_vmstate(BlockDriverState *bs, QEMUIOVector *qiov, int64_t pos,
                    bool is_read)
@@ -2657,26 +2531,6 @@ bdrv_co_rw_vmstate(BlockDriverState *bs, QEMUIOVector *qiov, int64_t pos,
     return ret;
 }
 
-static int coroutine_fn bdrv_co_rw_vmstate_entry(void *opaque)
-{
-    BdrvVmstateCo *co = opaque;
-
-    return bdrv_co_rw_vmstate(co->bs, co->qiov, co->pos, co->is_read);
-}
-
-int bdrv_rw_vmstate(BlockDriverState *bs, QEMUIOVector *qiov, int64_t pos,
-                    bool is_read)
-{
-    BdrvVmstateCo data = {
-        .bs         = bs,
-        .qiov       = qiov,
-        .pos        = pos,
-        .is_read    = is_read,
-    };
-
-    return bdrv_run_co(bs, bdrv_co_rw_vmstate_entry, &data);
-}
-
 int bdrv_save_vmstate(BlockDriverState *bs, const uint8_t *buf,
                       int64_t pos, int size)
 {
@@ -2752,11 +2606,6 @@ void bdrv_aio_cancel_async(BlockAIOCB *acb)
 /**************************************************************/
 /* Coroutine block device emulation */
 
-static int coroutine_fn bdrv_flush_co_entry(void *opaque)
-{
-    return bdrv_co_flush(opaque);
-}
-
 int coroutine_fn bdrv_co_flush(BlockDriverState *bs)
 {
     BdrvChild *primary_child = bdrv_primary_child(bs);
@@ -2880,24 +2729,6 @@ early_exit:
     return ret;
 }
 
-int bdrv_flush(BlockDriverState *bs)
-{
-    return bdrv_run_co(bs, bdrv_flush_co_entry, bs);
-}
-
-typedef struct DiscardCo {
-    BdrvChild *child;
-    int64_t offset;
-    int64_t bytes;
-} DiscardCo;
-
-static int coroutine_fn bdrv_pdiscard_co_entry(void *opaque)
-{
-    DiscardCo *rwco = opaque;
-
-    return bdrv_co_pdiscard(rwco->child, rwco->offset, rwco->bytes);
-}
-
 int coroutine_fn bdrv_co_pdiscard(BdrvChild *child, int64_t offset,
                                   int64_t bytes)
 {
@@ -3012,17 +2843,6 @@ out:
     return ret;
 }
 
-int bdrv_pdiscard(BdrvChild *child, int64_t offset, int64_t bytes)
-{
-    DiscardCo rwco = {
-        .child = child,
-        .offset = offset,
-        .bytes = bytes,
-    };
-
-    return bdrv_run_co(child->bs, bdrv_pdiscard_co_entry, &rwco);
-}
-
 int bdrv_co_ioctl(BlockDriverState *bs, int req, void *buf)
 {
     BlockDriver *drv = bs->drv;
@@ -3424,35 +3244,3 @@ out:
 
     return ret;
 }
-
-typedef struct TruncateCo {
-    BdrvChild *child;
-    int64_t offset;
-    bool exact;
-    PreallocMode prealloc;
-    BdrvRequestFlags flags;
-    Error **errp;
-} TruncateCo;
-
-static int coroutine_fn bdrv_truncate_co_entry(void *opaque)
-{
-    TruncateCo *tco = opaque;
-
-    return bdrv_co_truncate(tco->child, tco->offset, tco->exact,
-                            tco->prealloc, tco->flags, tco->errp);
-}
-
-int bdrv_truncate(BdrvChild *child, int64_t offset, bool exact,
-                  PreallocMode prealloc, BdrvRequestFlags flags, Error **errp)
-{
-    TruncateCo tco = {
-        .child      = child,
-        .offset     = offset,
-        .exact      = exact,
-        .prealloc   = prealloc,
-        .flags      = flags,
-        .errp       = errp,
-    };
-
-    return bdrv_run_co(child->bs, bdrv_truncate_co_entry, &tco);
-}
-- 
2.21.3


