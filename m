Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97321C8300B
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 11:18:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64B262070B
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 11:18:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="n5T1qA2O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64B262070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58290 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU7DR-00052V-H3
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 07:18:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57734)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jU78S-0006xr-G4
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 07:14:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jU76x-0005Fl-27
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 07:13:44 -0400
Received: from mail-eopbgr70099.outbound.protection.outlook.com
 ([40.107.7.99]:12710 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jU75m-0003SE-5o; Thu, 30 Apr 2020 07:10:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bv2M4cIiGg8N1Ty6a+UrITXGgzL6JhH9UdcjkBfnB4I8a5MDuUTXawMxhKawcwE4IriQ5OmBI+P/+ozjhNC5u//763NGVwXyjhdkPyZ6FSeOwa47BLIk2Qh+xH53GZWEk7MSrk6ofLpvovy5Lhhnq9W23i9Votj0mihYpwEXcugridtqEfspfZ1kfHpsveZq1+ICLT/dA5r2gVuX7eyiCvEYy5DgREdML2jetfEpFcxEl7J5ylTf59+7ygp+B9hVHyWveBTEEjiv8bH2mlQIdk8jByQHhTzdKqHKqRuWqQ9PvbfYsk3q5b7YSb60alFf9Sm0dLaNEM15zTcYoo4XTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dtPlf/oE8vAuiNTry/E6NoEu5Rrio9+5gDt1YkLZynw=;
 b=CKQTwst876NI4/hyvzbdNZAisiZiGLNjaiDd/lqe8HN7JavYaKYzsMmiLoVdIPsPCNuSxFL6upJFZ8pVde1PTEUpm+16/NjrwPbep8ho/Zi/A4Z/CZOsvwrG6VBl9cN2Pv5/oxhy0kwI9dfU9G3HAVT0otWPYFCQ7MsS0hag2fOOxCpDzmrexM6QIsNvN184uAELCYMTfaYnELdebhqIBxvGPh4aaGtzlXrUFxBxvaw1+hSXqI+86fVxaSc+N9+/mU8d6Xmju0FWPIMesOAEI01wE149Grap0B/XSly3XJQ4kQ1Woatr9ixd65vJdeG5dKT3ETCLBKlgtjjf53lc8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dtPlf/oE8vAuiNTry/E6NoEu5Rrio9+5gDt1YkLZynw=;
 b=n5T1qA2OKKlGndD8ORJlnzETl/k70pPOAHx+KXYTgKVxSaBTjXMnl1cJLIIsN5HPK6qTUXlKfpNSpJq8xg3nYvKiY3Fgi7Xjvtktyn+MgYwY4c0SDgW0knAXE8WJ5OITPVOPBpvalqbbI62QCBpspWpoMkFU6j/50/Z6NbH1gwE=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5399.eurprd08.prod.outlook.com (2603:10a6:20b:104::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20; Thu, 30 Apr
 2020 11:10:55 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2958.020; Thu, 30 Apr 2020
 11:10:55 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v3 05/17] block/io: support int64_t bytes in
 bdrv_co_do_pwrite_zeroes()
Date: Thu, 30 Apr 2020 14:10:21 +0300
Message-Id: <20200430111033.29980-6-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200430111033.29980-1-vsementsov@virtuozzo.com>
References: <20200430111033.29980-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0P190CA0021.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::31) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.138) by
 AM0P190CA0021.EURP190.PROD.OUTLOOK.COM (2603:10a6:208:190::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2958.19 via Frontend Transport; Thu, 30 Apr 2020 11:10:54 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.138]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2e37d5a7-1092-4a3e-0fb0-08d7ecf72708
X-MS-TrafficTypeDiagnostic: AM7PR08MB5399:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB539957BA9D96AE11E1FDA52AC1AA0@AM7PR08MB5399.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0389EDA07F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ch8V5DhwuZ0ExWWzahVIYZfsVsxqsNaGGdHRP8r7VDA8QBc7Gs6XnegGdbPwTqWVI2Z2G40tIxYEKwOr8A4lExj2Kubfi6gs+XRhDoQ1QZxct7Ep6xBMFsQG2hCXhZkLq59hDpb2XVE2q4kIRKeTSHIR8S4UQy1i6oX2ClOLzynkEzbyaTCaK63+AfJ036kth+EMx9Te265ZVNTXCTtOojGsw+hMDlNsxphS370CkBMtzh71dPSQ1s6TfryYdE4FAWCUaUQi7xVWhqdXw3vldT+4J9x9+jA/BMqCYdNV+Tw6xrTYKYuCZiNDIQIFEbBj6OOq+qVPLd1nD/Usrg7UaaZB8q2ASZWoIZma93OiRvbt2La+0wWankBllHU172p0ZYjG+qnODREaaEyfKhNDx0hvbcdwDW6Yjq12YGxV0mzw2zMTU2Zr9ADVupEOrGw5
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(366004)(39840400004)(346002)(136003)(376002)(1076003)(36756003)(478600001)(8936002)(26005)(6512007)(7416002)(5660300002)(107886003)(6486002)(66476007)(66556008)(86362001)(6916009)(6506007)(6666004)(8676002)(316002)(2906002)(186003)(66946007)(16526019)(2616005)(956004)(4326008)(52116002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: RHbI61pESYS/PMhbC/A8voABlCrAkTBqpx0UwzXCgU5QvnBizaJSSvmYFd4fdj5ssZBxjHi1E/jXNqRoPgecl+/NEhG8QIQS/fBC801S5UmYPrjO1xKvTLKni4IVfzHEMERszgY08RNxpkFrr2DJ1WXmvjWEkgIue9yui2yySjlEcRgc53+sNtd4GuQdnAvMRTECgmCi2Fmm+QXmT2rdwRyNMxv3sZ1pTKS2GrU7btvRfy7hzmTpZZ/HIZEm+K917gZSRVryCddBzUOK6CTDZ4uWwNAV/5JtPoAVXew/W7TgjMPCG3NPW07a8Tyo9wKjoRiToL7iExN3b52xRroxoXkVyAjv0ilY2adKS4PE/1xjM9Uby3Y3UMa4urVj1gdmIjGXmDCnGfzDrLKhHD6J/W2MvC767GHof12biW2T91iRAXcsomiotcfCMprcB3DmZY4ZJ4B6b7pAY6PbhSMrmuQylqj3SVRdyYPGTAGcXEreKC953N8rI+idIn20XYuIeT0x7mfsse3MjHsUuoOT+YaXYbkXfVB9lyyvOO1ul2URoI/m+aHKGAREzsKWGxS8CGWwweOULpwH2sm2AtNkbQrNDSCWDZwhHJP0J4oqx1PHt5sAN2npZnnzTj2LwGHaS1+017GAVfLhTJPNkydmTM11tNsaDlqFVNwAPhUco5yV06A0ZuoOZLi/bb/t46mTdWxHdgGRZr5F5xAr2RZbeLC3eiwfkawIRdfCW5h9RFZMzuPPuOCFvf08Onbap+xAgBWxvnMtxepXS2bF1QLo4VeTxyKgS9x6Aq01u2Vy9xE=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e37d5a7-1092-4a3e-0fb0-08d7ecf72708
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2020 11:10:55.3814 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +LtnyMTN6VFx+frHwCa7hGvFnl7vqghGLCHtPj8CdHdwvfVwkssusoi4A1zzE3Ji2lB30rYrNCtxjRJ6Nn8Q82StY9z5Rt6GLDUZRYHsVyc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5399
Received-SPF: pass client-ip=40.107.7.99;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/30 07:10:48
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
 sw@weilnetz.de, pl@kamp.de, ronniesahlberg@gmail.com, mreitz@redhat.com,
 den@openvz.org, sheepdog@lists.wpkg.org, vsementsov@virtuozzo.com,
 stefanha@redhat.com, namei.unix@gmail.com, pbonzini@redhat.com,
 jsnow@redhat.com, ari@tuxera.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We are generally moving to int64_t for both offset and bytes parameters
on all io paths.

Main motivation is realization of 64-bit write_zeroes operation for
fast zeroing large disk chunks, up to the whole disk.

We chose signed type, to be consistent with off_t (which is signed) and
with possibility for signed return type (where negative value means
error).

So, prepare bdrv_co_do_pwrite_zeroes() now.

Patch-correctness audit by Eric Blake:

  Widens from 32- to 64-bit.  Callers:

    bdrv_co_do_copy_on_readv() - passes 'int64_t pnum' bounded by
      fragmenting loop limited to MAX_BOUNCE_BUFFER
    bdrv_aligned_pwritev() - passes 'unsigned int bytes' - latent bug
      fix for sizes between 2G and 4G, if any

    to see if that bug could be tickled, look at callers of
    bdrv_aligned_pwritev:

    bdrv_co_do_zero_pwritev() - splits 'unsigned int bytes' into
      head|body|tail; head and tail are safe but body could be > 2G
    bdrv_co_pwritev_part() - gates with bdrv_check_byte_request()

    continuing the audit, callers of bdrv_co_do_zero_pwritev:

    bdrv_co_pwritev_part() - gates with bdrv_check_byte_request()

    okay, all callers pass < 2G per our current code in
    bdrv_check_byte_request(), so there is no actual bug.

  Use of 'bytes' within the function:

    compute 'int tail' via % 'int alignment' - safe
    fragmentation loop 'int num' - still fragments with a cap on
      max_transfer

    use of 'num' within the loop
    compute 'int head' via % 'int alignment' - safe
    clamp size by 'int max_write_zeroes' - safe
    drv->bdrv_co_pwrite_zeroes(int) - safe because of clamping
    clamp size by 'int max_transfer' - safe
    qemu_iovec_init_buf(size_t) - safe because of clamping
    bdrv_driver_pwritev(uint64_t) [well, int64_t after 4/17] - safe

    So even with the wider type, we aren't exceeding the contract of
    anything we pass it on to.  Later patches may improve
    drv->bdrv_co_pwrite_zeroes and qemu_iovec_init_buf to be 64-bit
    clean, at which point we would want to revisit this function to use
    64-bit clamping rather than 32-bit clamping, but it does not have
    to happen here.

Series: 64bit-block-status
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 block/io.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/block/io.c b/block/io.c
index eeba3b828c..b83749cc50 100644
--- a/block/io.c
+++ b/block/io.c
@@ -42,7 +42,7 @@
 
 static void bdrv_parent_cb_resize(BlockDriverState *bs);
 static int coroutine_fn bdrv_co_do_pwrite_zeroes(BlockDriverState *bs,
-    int64_t offset, int bytes, BdrvRequestFlags flags);
+    int64_t offset, int64_t bytes, BdrvRequestFlags flags);
 
 static void bdrv_parent_drained_begin(BlockDriverState *bs, BdrvChild *ignore,
                                       bool ignore_bds_parents)
@@ -1575,7 +1575,7 @@ int coroutine_fn bdrv_co_preadv_part(BdrvChild *child,
 }
 
 static int coroutine_fn bdrv_co_do_pwrite_zeroes(BlockDriverState *bs,
-    int64_t offset, int bytes, BdrvRequestFlags flags)
+    int64_t offset, int64_t bytes, BdrvRequestFlags flags)
 {
     BlockDriver *drv = bs->drv;
     QEMUIOVector qiov;
@@ -1605,7 +1605,7 @@ static int coroutine_fn bdrv_co_do_pwrite_zeroes(BlockDriverState *bs,
     assert(max_write_zeroes >= bs->bl.request_alignment);
 
     while (bytes > 0 && !ret) {
-        int num = bytes;
+        int64_t num = bytes;
 
         /* Align request.  Block drivers can expect the "bulk" of the request
          * to be aligned, and that unaligned requests do not cross cluster
-- 
2.21.0


