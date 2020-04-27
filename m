Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 161E9C54FD0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 08:36:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C05E52080C
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 08:36:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="mztsVVx0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C05E52080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59336 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jSzFr-0001VF-Ru
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 04:36:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49144)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jSz44-0003fN-KG
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 04:24:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jSz3z-0000jP-FL
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 04:24:31 -0400
Received: from mail-eopbgr70099.outbound.protection.outlook.com
 ([40.107.7.99]:65188 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jSz3j-0007mE-BW; Mon, 27 Apr 2020 04:24:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ju1bizHWOORv+Wb1udnUS9KIZ8aVXFb6R+uOtlKxJ0ZLCrZaKkLfzPmzhBrrG3BNHgjB+wkMfmD9omdmJCos6bpGWio0YgZoQtud5oqIk9FtgO7Wk+998HE2/I0Y2Lqf27f0tgxkutNWXWZuXKo7g4hDO35tWvC0C1X+SLg/s8ReS1vfcghDiU+aHyaGhXAWr2gavD3I7KAOOUafM9MEzDQrn6yKKxKmwyeOTIZOrjqjdES0iOr7KPMLq9ISpqFPhabFR/xRnP1t6OUMYNfAOWC0L9gW9JWmexkp4M5QodDnK60+enUsiFfWMAMS4FmSvJ7JpWSBLi6z5KPk63Mkmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VgpYD7TDX090L83FzIYghOviQ6mC5mBUndWmQH2xXVg=;
 b=BVCHcpEwmFRseOso7FPLTd7ncmg1ff1SKMVaZxPd+HXZyQfC3wfNribBKDinXE/Fxqw6ik3tij8xVUc3+BJW3xzXu/QfHCazlPWkqVCYSWBlloL0t42eiI+Dxl6/LiMF1hkyG0odFTnjOKZiA0WgTUuNoMidppxToHR+eO92RARyy2+haRqSK5SWuPozCXK122IE3C7ovQYlg+kdRMuaatxXOjM/YRAfp8Z2csVsuUV6sfYcXXTrKy5BWhjOf9AKz7x1WISDDs9xYZM5t0kFaIRJ/0N/nthTYPuWAIO4CVNozI0NPBhe0vrcDQs864LuMUCDb+faLBz/ae9xbX6ThQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VgpYD7TDX090L83FzIYghOviQ6mC5mBUndWmQH2xXVg=;
 b=mztsVVx0LkeJSOMxb+5ZeSxpN6293vzHsTTDNSqz0633AYeb0CeGzYpWgQyQFMapBNmxC6aeO3kR1cByrKH1YoKmwA2vtQriGrU27RED3vCGcEjPX6H0jWz1kqLUzbGwS1E6+hqwJEr25GCUANPSUsCAlEQlxBRdPhwa5HBQJ74=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5463.eurprd08.prod.outlook.com (2603:10a6:20b:106::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Mon, 27 Apr
 2020 08:24:08 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2937.020; Mon, 27 Apr 2020
 08:24:08 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 12/17] block/block-backend: convert blk io path to use
 int64_t parameters
Date: Mon, 27 Apr 2020 11:23:20 +0300
Message-Id: <20200427082325.10414-13-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200427082325.10414-1-vsementsov@virtuozzo.com>
References: <20200427082325.10414-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0004.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::14) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (185.215.60.182) by
 FR2P281CA0004.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:a::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2937.13 via Frontend Transport; Mon, 27 Apr 2020 08:24:07 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.182]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6f8e9be2-a63b-4d01-3a55-08d7ea845b26
X-MS-TrafficTypeDiagnostic: AM7PR08MB5463:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB54639B742C6524CAC6C5C6E6C1AF0@AM7PR08MB5463.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:205;
X-Forefront-PRVS: 0386B406AA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(136003)(396003)(376002)(346002)(39840400004)(2906002)(81156014)(6486002)(26005)(8676002)(8936002)(4326008)(6916009)(478600001)(66556008)(7416002)(66946007)(66476007)(6666004)(16526019)(316002)(2616005)(1076003)(186003)(5660300002)(52116002)(6506007)(30864003)(956004)(36756003)(107886003)(6512007)(69590400007)(86362001);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9Ys4TshWFtsIQEZL2dZFMHJShQxDDP8hKfo1ik0ajXmgZw2CBRg+KaNVu7zAgc9d32Kc/5jPtj9HUK6kTt9J/GRWpbq+PWBQSWWFiSwtrcM2eyGVC5KN9SCW83LW5bq2GsvPsYmOhybcH5ccgt7gnB0hgf64HeetJ2lB9TcquO/hP8Wr8wlv7JJQBejvXKo/pJyaIqaaEaN8YDkyYyxtl7vqgcXE/DpnLPB4mA8JfQKbEnE9lDjcjtN5FXtnKCjz1gIG3W+vfT9o4RiUeO0OJekXidO6S31eZ3vLLqd9KKylzgPI/iBKAujnLWRjDNrH2oEdbgCfHnvUGUhByPy81uvoeg3pifTSecFJK//V5WSNI21UhYD3iGo5CrQSSmvYmCBxwsZPfJj8CK01CeaJwG+Y/+FDbOTOxYVqLGXe5JA4KwKXBAEeZEJ4n2wea9TRUS0DA64jK6Jl/YQzpNlnYoD9yjVi4vFTDEgEVF3I2cKwB/5mabXH/2zRXPxmXZ6P
X-MS-Exchange-AntiSpam-MessageData: uSPaWaGGg/ePvykvCo18c7pRLXniT7nwA9QD0zKR+YxgjHIO5Oom/Rbh5PMCFnt74BvAB95VH8fNQRetyrVlWSbUEqXrxUiyEFLgYpwELjViaeKGn8GHAHpcyWnqL+aAxvwpfEweX+xWcrRGyDhq5axLDBuKmGNGXrDYtA0OI+XnPzdqzkmM30GN947KL+PRwdzVKQlNPyFO/9irDSNRsVbaQDGHrKNWt7EyseCeXiBEdDT680KFX9M/+k6CxJQUqA6hgfS8WpDMNk0QmixiDJART0x3OTT1LquKmZXo2+TbHDikwo1E1Rh4T//6+rztMeG4daBigjGZ8usBt5qaA6b8872B1csXyTiSjrW2GiVEI+F46GkXyOeFJp02a+MJqmRZBtGaOjrkVo024ncSMg3nFADVvmmNba00kXBHuOq08lXCi1J9TmQTt67A/8ybl1EjT1Tb5xh6HFB7iNfULlPf3AkB1cl8ICFR/XDOvBkdjzO2qKvOZbDCHOjz5ZaARFY29hOs12h9jIoaQw0+6Wrg+ig8y5ff0oC9kb1LbS3BccpeTyWjc68SEuec6NiWhbPlcuDSfcG2z3lzEf9bclP5M5vRsGQ+UUg+eSMhzvKUpMMmiNMosYw6D0LTLlvYM5cKZUe3j53Amsq4qMv6AeiZSY9hjUW4OnL3KGfkwHG5t0yJGFoPXY8HiWD24vn7v6Dh2Qmvx9cmV4EZABRJxyGeb+qowR5vRmxCgFJSPfj5z7vqVR+yyY0+mnFbQHDurOxnnIN5yZBaytkOce34o/9DgdWW8biEd0QF1zMUP2I=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f8e9be2-a63b-4d01-3a55-08d7ea845b26
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2020 08:24:08.4299 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CZPh8h7LA69PzIlvhRfWA2lLAruhXCkcIO0fqrpqw4339t+666cisSW8qJ++PBJbY04bl4HDiw9AGY11NWAehPAQ8GDTLsrYEgk9IvMCqwI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5463
Received-SPF: pass client-ip=40.107.7.99;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/27 04:24:06
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Received-From: 40.107.7.99
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
Cc: kwolf@redhat.com, fam@euphon.net, integration@gluster.org, berto@igalia.com,
 pavel.dovgaluk@ispras.ru, dillaman@redhat.com, qemu-devel@nongnu.org,
 pl@kamp.de, ronniesahlberg@gmail.com, mreitz@redhat.com, den@openvz.org,
 sheepdog@lists.wpkg.org, vsementsov@virtuozzo.com, stefanha@redhat.com,
 namei.unix@gmail.com, pbonzini@redhat.com, sw@weilnetz.de, jsnow@redhat.com,
 ari@tuxera.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We are generally moving to int64_t for both offset and bytes parameters
on all io paths. Now bdrv layer is converted, convert blk layer too.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 include/sysemu/block-backend.h | 26 +++++++--------
 block/block-backend.c          | 60 ++++++++++++++++++----------------
 2 files changed, 44 insertions(+), 42 deletions(-)

diff --git a/include/sysemu/block-backend.h b/include/sysemu/block-backend.h
index 9bbdbd63d7..0c1eee1778 100644
--- a/include/sysemu/block-backend.h
+++ b/include/sysemu/block-backend.h
@@ -119,14 +119,14 @@ BlockBackend *blk_by_dev(void *dev);
 BlockBackend *blk_by_qdev_id(const char *id, Error **errp);
 void blk_set_dev_ops(BlockBackend *blk, const BlockDevOps *ops, void *opaque);
 int coroutine_fn blk_co_preadv(BlockBackend *blk, int64_t offset,
-                               unsigned int bytes, QEMUIOVector *qiov,
+                               int64_t bytes, QEMUIOVector *qiov,
                                BdrvRequestFlags flags);
 int coroutine_fn blk_co_pwritev_part(BlockBackend *blk, int64_t offset,
-                                     unsigned int bytes,
+                                     int64_t bytes,
                                      QEMUIOVector *qiov, size_t qiov_offset,
                                      BdrvRequestFlags flags);
 int coroutine_fn blk_co_pwritev(BlockBackend *blk, int64_t offset,
-                               unsigned int bytes, QEMUIOVector *qiov,
+                               int64_t bytes, QEMUIOVector *qiov,
                                BdrvRequestFlags flags);
 
 static inline int coroutine_fn blk_co_pread(BlockBackend *blk, int64_t offset,
@@ -148,13 +148,13 @@ static inline int coroutine_fn blk_co_pwrite(BlockBackend *blk, int64_t offset,
 }
 
 int blk_pwrite_zeroes(BlockBackend *blk, int64_t offset,
-                      int bytes, BdrvRequestFlags flags);
+                      int64_t bytes, BdrvRequestFlags flags);
 BlockAIOCB *blk_aio_pwrite_zeroes(BlockBackend *blk, int64_t offset,
-                                  int bytes, BdrvRequestFlags flags,
+                                  int64_t bytes, BdrvRequestFlags flags,
                                   BlockCompletionFunc *cb, void *opaque);
 int blk_make_zero(BlockBackend *blk, BdrvRequestFlags flags);
-int blk_pread(BlockBackend *blk, int64_t offset, void *buf, int bytes);
-int blk_pwrite(BlockBackend *blk, int64_t offset, const void *buf, int bytes,
+int blk_pread(BlockBackend *blk, int64_t offset, void *buf, int64_t bytes);
+int blk_pwrite(BlockBackend *blk, int64_t offset, const void *buf, int64_t bytes,
                BdrvRequestFlags flags);
 int64_t blk_getlength(BlockBackend *blk);
 void blk_get_geometry(BlockBackend *blk, uint64_t *nb_sectors_ptr);
@@ -167,14 +167,14 @@ BlockAIOCB *blk_aio_pwritev(BlockBackend *blk, int64_t offset,
                             BlockCompletionFunc *cb, void *opaque);
 BlockAIOCB *blk_aio_flush(BlockBackend *blk,
                           BlockCompletionFunc *cb, void *opaque);
-BlockAIOCB *blk_aio_pdiscard(BlockBackend *blk, int64_t offset, int bytes,
+BlockAIOCB *blk_aio_pdiscard(BlockBackend *blk, int64_t offset, int64_t bytes,
                              BlockCompletionFunc *cb, void *opaque);
 void blk_aio_cancel(BlockAIOCB *acb);
 void blk_aio_cancel_async(BlockAIOCB *acb);
 int blk_ioctl(BlockBackend *blk, unsigned long int req, void *buf);
 BlockAIOCB *blk_aio_ioctl(BlockBackend *blk, unsigned long int req, void *buf,
                           BlockCompletionFunc *cb, void *opaque);
-int blk_co_pdiscard(BlockBackend *blk, int64_t offset, int bytes);
+int blk_co_pdiscard(BlockBackend *blk, int64_t offset, int64_t bytes);
 int blk_co_flush(BlockBackend *blk);
 int blk_flush(BlockBackend *blk);
 int blk_commit_all(void);
@@ -233,12 +233,12 @@ int blk_get_open_flags_from_root_state(BlockBackend *blk);
 void *blk_aio_get(const AIOCBInfo *aiocb_info, BlockBackend *blk,
                   BlockCompletionFunc *cb, void *opaque);
 int coroutine_fn blk_co_pwrite_zeroes(BlockBackend *blk, int64_t offset,
-                                      int bytes, BdrvRequestFlags flags);
+                                      int64_t bytes, BdrvRequestFlags flags);
 int blk_pwrite_compressed(BlockBackend *blk, int64_t offset, const void *buf,
-                          int bytes);
+                          int64_t bytes);
 int blk_truncate(BlockBackend *blk, int64_t offset, bool exact,
                  PreallocMode prealloc, Error **errp);
-int blk_pdiscard(BlockBackend *blk, int64_t offset, int bytes);
+int blk_pdiscard(BlockBackend *blk, int64_t offset, int64_t bytes);
 int blk_save_vmstate(BlockBackend *blk, const uint8_t *buf,
                      int64_t pos, int size);
 int blk_load_vmstate(BlockBackend *blk, uint8_t *buf, int64_t pos, int size);
@@ -259,7 +259,7 @@ void blk_unregister_buf(BlockBackend *blk, void *host);
 
 int coroutine_fn blk_co_copy_range(BlockBackend *blk_in, int64_t off_in,
                                    BlockBackend *blk_out, int64_t off_out,
-                                   int bytes, BdrvRequestFlags read_flags,
+                                   int64_t bytes, BdrvRequestFlags read_flags,
                                    BdrvRequestFlags write_flags);
 
 const BdrvChild *blk_root(BlockBackend *blk);
diff --git a/block/block-backend.c b/block/block-backend.c
index 38ae413826..b3f6edfc70 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -1110,11 +1110,11 @@ void blk_set_disable_request_queuing(BlockBackend *blk, bool disable)
 }
 
 static int blk_check_byte_request(BlockBackend *blk, int64_t offset,
-                                  size_t size)
+                                  int64_t bytes)
 {
     int64_t len;
 
-    if (size > INT_MAX) {
+    if (bytes > INT_MAX) {
         return -EIO;
     }
 
@@ -1122,7 +1122,7 @@ static int blk_check_byte_request(BlockBackend *blk, int64_t offset,
         return -ENOMEDIUM;
     }
 
-    if (offset < 0) {
+    if (offset < 0 || bytes < 0) {
         return -EIO;
     }
 
@@ -1132,7 +1132,7 @@ static int blk_check_byte_request(BlockBackend *blk, int64_t offset,
             return len;
         }
 
-        if (offset > len || len - offset < size) {
+        if (offset > len || len - offset < bytes) {
             return -EIO;
         }
     }
@@ -1154,7 +1154,7 @@ static void coroutine_fn blk_wait_while_drained(BlockBackend *blk)
 
 /* To be called between exactly one pair of blk_inc/dec_in_flight() */
 static int coroutine_fn
-blk_do_preadv(BlockBackend *blk, int64_t offset, unsigned int bytes,
+blk_do_preadv(BlockBackend *blk, int64_t offset, int64_t bytes,
               QEMUIOVector *qiov, BdrvRequestFlags flags)
 {
     int ret;
@@ -1185,7 +1185,7 @@ blk_do_preadv(BlockBackend *blk, int64_t offset, unsigned int bytes,
 }
 
 int coroutine_fn blk_co_preadv(BlockBackend *blk, int64_t offset,
-                               unsigned int bytes, QEMUIOVector *qiov,
+                               int64_t bytes, QEMUIOVector *qiov,
                                BdrvRequestFlags flags)
 {
     int ret;
@@ -1199,7 +1199,7 @@ int coroutine_fn blk_co_preadv(BlockBackend *blk, int64_t offset,
 
 /* To be called between exactly one pair of blk_inc/dec_in_flight() */
 static int coroutine_fn
-blk_do_pwritev_part(BlockBackend *blk, int64_t offset, unsigned int bytes,
+blk_do_pwritev_part(BlockBackend *blk, int64_t offset, int64_t bytes,
                     QEMUIOVector *qiov, size_t qiov_offset,
                     BdrvRequestFlags flags)
 {
@@ -1235,7 +1235,7 @@ blk_do_pwritev_part(BlockBackend *blk, int64_t offset, unsigned int bytes,
 }
 
 int coroutine_fn blk_co_pwritev_part(BlockBackend *blk, int64_t offset,
-                                     unsigned int bytes,
+                                     int64_t bytes,
                                      QEMUIOVector *qiov, size_t qiov_offset,
                                      BdrvRequestFlags flags)
 {
@@ -1249,7 +1249,7 @@ int coroutine_fn blk_co_pwritev_part(BlockBackend *blk, int64_t offset,
 }
 
 int coroutine_fn blk_co_pwritev(BlockBackend *blk, int64_t offset,
-                                unsigned int bytes, QEMUIOVector *qiov,
+                                int64_t bytes, QEMUIOVector *qiov,
                                 BdrvRequestFlags flags)
 {
     return blk_co_pwritev_part(blk, offset, bytes, qiov, 0, flags);
@@ -1311,7 +1311,7 @@ static int blk_prw(BlockBackend *blk, int64_t offset, uint8_t *buf,
 }
 
 int blk_pwrite_zeroes(BlockBackend *blk, int64_t offset,
-                      int bytes, BdrvRequestFlags flags)
+                      int64_t bytes, BdrvRequestFlags flags)
 {
     return blk_prw(blk, offset, NULL, bytes, blk_write_entry,
                    flags | BDRV_REQ_ZERO_WRITE);
@@ -1361,7 +1361,7 @@ BlockAIOCB *blk_abort_aio_request(BlockBackend *blk,
 typedef struct BlkAioEmAIOCB {
     BlockAIOCB common;
     BlkRwCo rwco;
-    int bytes;
+    int64_t bytes;
     bool has_returned;
 } BlkAioEmAIOCB;
 
@@ -1385,7 +1385,8 @@ static void blk_aio_complete_bh(void *opaque)
     blk_aio_complete(acb);
 }
 
-static BlockAIOCB *blk_aio_prwv(BlockBackend *blk, int64_t offset, int bytes,
+static BlockAIOCB *blk_aio_prwv(BlockBackend *blk,
+                                int64_t offset, int64_t bytes,
                                 void *iobuf, CoroutineEntry co_entry,
                                 BdrvRequestFlags flags,
                                 BlockCompletionFunc *cb, void *opaque)
@@ -1442,31 +1443,31 @@ static void blk_aio_write_entry(void *opaque)
 }
 
 BlockAIOCB *blk_aio_pwrite_zeroes(BlockBackend *blk, int64_t offset,
-                                  int count, BdrvRequestFlags flags,
+                                  int64_t bytes, BdrvRequestFlags flags,
                                   BlockCompletionFunc *cb, void *opaque)
 {
-    return blk_aio_prwv(blk, offset, count, NULL, blk_aio_write_entry,
+    return blk_aio_prwv(blk, offset, bytes, NULL, blk_aio_write_entry,
                         flags | BDRV_REQ_ZERO_WRITE, cb, opaque);
 }
 
-int blk_pread(BlockBackend *blk, int64_t offset, void *buf, int count)
+int blk_pread(BlockBackend *blk, int64_t offset, void *buf, int64_t bytes)
 {
-    int ret = blk_prw(blk, offset, buf, count, blk_read_entry, 0);
+    int ret = blk_prw(blk, offset, buf, bytes, blk_read_entry, 0);
     if (ret < 0) {
         return ret;
     }
-    return count;
+    return bytes;
 }
 
-int blk_pwrite(BlockBackend *blk, int64_t offset, const void *buf, int count,
-               BdrvRequestFlags flags)
+int blk_pwrite(BlockBackend *blk, int64_t offset, const void *buf,
+               int64_t bytes, BdrvRequestFlags flags)
 {
-    int ret = blk_prw(blk, offset, (void *) buf, count, blk_write_entry,
+    int ret = blk_prw(blk, offset, (void *) buf, bytes, blk_write_entry,
                       flags);
     if (ret < 0) {
         return ret;
     }
-    return count;
+    return bytes;
 }
 
 int64_t blk_getlength(BlockBackend *blk)
@@ -1567,7 +1568,7 @@ BlockAIOCB *blk_aio_ioctl(BlockBackend *blk, unsigned long int req, void *buf,
 
 /* To be called between exactly one pair of blk_inc/dec_in_flight() */
 static int coroutine_fn
-blk_do_pdiscard(BlockBackend *blk, int64_t offset, int bytes)
+blk_do_pdiscard(BlockBackend *blk, int64_t offset, int64_t bytes)
 {
     int ret;
 
@@ -1591,14 +1592,15 @@ static void blk_aio_pdiscard_entry(void *opaque)
 }
 
 BlockAIOCB *blk_aio_pdiscard(BlockBackend *blk,
-                             int64_t offset, int bytes,
+                             int64_t offset, int64_t bytes,
                              BlockCompletionFunc *cb, void *opaque)
 {
     return blk_aio_prwv(blk, offset, bytes, NULL, blk_aio_pdiscard_entry, 0,
                         cb, opaque);
 }
 
-int coroutine_fn blk_co_pdiscard(BlockBackend *blk, int64_t offset, int bytes)
+int coroutine_fn blk_co_pdiscard(BlockBackend *blk, int64_t offset,
+                                 int64_t bytes)
 {
     int ret;
 
@@ -1618,7 +1620,7 @@ static void blk_pdiscard_entry(void *opaque)
     aio_wait_kick();
 }
 
-int blk_pdiscard(BlockBackend *blk, int64_t offset, int bytes)
+int blk_pdiscard(BlockBackend *blk, int64_t offset, int64_t bytes)
 {
     return blk_prw(blk, offset, NULL, bytes, blk_pdiscard_entry, 0);
 }
@@ -2123,16 +2125,16 @@ void *blk_aio_get(const AIOCBInfo *aiocb_info, BlockBackend *blk,
 }
 
 int coroutine_fn blk_co_pwrite_zeroes(BlockBackend *blk, int64_t offset,
-                                      int bytes, BdrvRequestFlags flags)
+                                      int64_t bytes, BdrvRequestFlags flags)
 {
     return blk_co_pwritev(blk, offset, bytes, NULL,
                           flags | BDRV_REQ_ZERO_WRITE);
 }
 
 int blk_pwrite_compressed(BlockBackend *blk, int64_t offset, const void *buf,
-                          int count)
+                          int64_t bytes)
 {
-    return blk_prw(blk, offset, (void *) buf, count, blk_write_entry,
+    return blk_prw(blk, offset, (void *) buf, bytes, blk_write_entry,
                    BDRV_REQ_WRITE_COMPRESSED);
 }
 
@@ -2358,7 +2360,7 @@ void blk_unregister_buf(BlockBackend *blk, void *host)
 
 int coroutine_fn blk_co_copy_range(BlockBackend *blk_in, int64_t off_in,
                                    BlockBackend *blk_out, int64_t off_out,
-                                   int bytes, BdrvRequestFlags read_flags,
+                                   int64_t bytes, BdrvRequestFlags read_flags,
                                    BdrvRequestFlags write_flags)
 {
     int r;
-- 
2.21.0


