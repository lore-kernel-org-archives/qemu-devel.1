Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A6FFC8300B
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 11:15:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 035CE2076D
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 11:15:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="ivrDDutF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 035CE2076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49726 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU7AX-0000rq-3o
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 07:15:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57720)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jU78Q-0006uk-Hi
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 07:14:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jU76v-0005F1-4v
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 07:13:42 -0400
Received: from mail-eopbgr70099.outbound.protection.outlook.com
 ([40.107.7.99]:12710 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jU75l-0003SE-4k; Thu, 30 Apr 2020 07:10:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EhM3xYOs1IzWL5EpG8dhPX715NkfScXXYqo2VM+oap3xzFx4ywzQZp5T7rwO2PrD/IW1PIrsoDC5kXI0F8f97GP4P9mMOHYy6ZeC+iI/SbHkOXWFGSe4ktdIBW2gobMEqQxNQWY8KtxaEgxo1cRQ4wW7ruMzUsYSbs8CmUMxRF7exPlutWSjvdg9bbquW0t6+n8Dz5AWUGdJhaQzZIFUoLtCJTkaBuxIefqE5anpqpPVu+/JfyU7BOZClKL0GkvZrClGGKfSenWgzrsjwLzzq8n+n18waf+0OddwdeYVmvxwojGmnheFmvguWrADR4H0pHDEpx3EyeBEJvbj07YAMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m/X8z63edrEOxxhzoG1B/7J3UygWJU5Ku2Fj98P+Nq0=;
 b=Z9FRr0ngtu6q3nhqOvn/kT7qO0i1u4rl9hIl3HaLBumNkNvLXx90sxQW7LkGXikTZYb7XC7jeKyFv668H7JLb82UeANuottaLQgs9DYAgUId8djHFBDRZPT4fdD8wKzsXUcMkagX0jX0JCFOkuT5yn2oytUZidEWrb5lLawrLCofQSnyDaOSQ2Q3UCBsolzeRbeXR/FzxG/+HMDdA+HORPk2iIUeGBjV6JkQ/2bzNSfVdRdmaCpn53qRILoRRH9jKfEBwB0MdDphL5beDfpQ3UyABon060+ArSPpQyJxCwfGJSdf3cy/FaXPRuJ4Hp7JAi/HODlgTVPSEDze2KT8ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m/X8z63edrEOxxhzoG1B/7J3UygWJU5Ku2Fj98P+Nq0=;
 b=ivrDDutFaQGlYDF3J4kk85S+MIPIfrr6Pbx5BP0rt9v6vcexWVlAdyMMMJPyJ4qZBRu+xS3xE7K2zeyrra0+pOFuArWkF2lJ7EmSKGlRAInMZLit2nKs3K+46sGo9Fvc14KGsSCrAmE0gjj57jp5y2/jUJvo3IP7l/t5mzAttKI=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5399.eurprd08.prod.outlook.com (2603:10a6:20b:104::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20; Thu, 30 Apr
 2020 11:10:53 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2958.020; Thu, 30 Apr 2020
 11:10:53 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v3 04/17] block/io: use int64_t bytes in driver wrappers
Date: Thu, 30 Apr 2020 14:10:20 +0300
Message-Id: <20200430111033.29980-5-vsementsov@virtuozzo.com>
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
 15.20.2958.19 via Frontend Transport; Thu, 30 Apr 2020 11:10:52 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.138]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5659ffc7-e5df-4479-7485-08d7ecf72626
X-MS-TrafficTypeDiagnostic: AM7PR08MB5399:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5399235852912B9965D8F167C1AA0@AM7PR08MB5399.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0389EDA07F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x+q+cuLlhqgVr/Jy2quVvDq1v5uP+vAO53VGBwskyecX14+EymWa6f3tADI6ZD3twElHwOGnBuESeKDQAmWBn32MBXepcyv0B1ybh5o1z8wiRmMoFLcUucex5NyI12FHYbdI9fU5CqPtuRWCfxDpXj6adzoz2dv+wceK3a9xR5xG7PLaEsp/2vfxeTJwzCygCSvHgl3N+TMHQII9kLdjOxv2crxJekbiiaoKrV/fr9Efav3/VjipZY/QmG0k2mcqwQ2k6SWvByCH3qmxlQbu2mNoJQgldud4YdneLnRWh8AqZKf8PLhgRw/+/GKUVGoE4EfFERP4Gc/CSmmsSf9nRuWgjYcK4ZAxSmgRpqBDxcyKzjVx2beX0ikobuGCY0PDpAk1oyQ+WOZAtNzwdQaFic5YnWeiTW/KM7LI5yOWWhatOybHCtmO5f0vHTWOQ5PF
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(366004)(39840400004)(346002)(136003)(376002)(1076003)(36756003)(478600001)(8936002)(26005)(6512007)(7416002)(5660300002)(107886003)(6486002)(66476007)(66556008)(86362001)(6916009)(6506007)(6666004)(8676002)(316002)(2906002)(186003)(66946007)(16526019)(2616005)(956004)(4326008)(52116002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: E+uAGRMVDCiPqeMgPfFcb4pbhSTqeqGbTwpILswnksqC7YaoPPeMEWj8zs692Xk4gipmIr9xntcgYDc+aCB9Bt5BB5YJ20fjBI4t9V5nAkFkaYPcsdNXl9Sdn2NN0IR+nXNLxhLyZwEto33TzOyGnPZyewDt3q+/3K5DMxYdwwe1zdzZ5tt4LqfxQJWKqgtgv5ZlePFCAOC/WOcu14+nwtJehhmRyp30ZFy9JPJjfWyQ0mvcyIaIpfrg7Fc4bVGAT0HRD7E+HsqCEnNnW2zLx3eMM0RCfGSu1+x5oQOVF5yYr0kVnSplcmvylIHEHVX/yogOCUTEXXFQC+MKZWErh6/Hiv/Br4n1GtwlFE9IyCkayufy76ZRmEA04vWvINS1PYopAFyhVA5RoiQG+zv07jyes06DAQYcuXcsdoKDAKbe8hLuPUeiC/xQrqn2iqMYgBlmD9sH7yMMv9zUWvElTN+JGfifTiMthq1cKnhYHZByCoeiE7VN6PoWJQvrIfvlaCxc2Tweo52QXrlWfbEJKnUoNWvj+HCU9qHfmYTYuWFP0eqP9HiAsbu3PYxBJzrxRv0Va2M9omtO2MSMWPtkOfydF4t1GBmWc2I7/oLF53Z8/cu6Qv1uybGg/NvKJcu/I1blnsC/vQstgB2YJtWWbCBKuIF60Tx5sdYCrxFmFa/kcnpZXJD5FMafo0WSk9EmxVjMgSsxx0D5ZOwLqqR8lrberzGaKhcliQjF85IvUu+9rVCD23oL7YWfMBySz4BysgCD5lBfmhd5T+fERgxsc2KoJEI2ydnTY6tBN3eBbNY=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5659ffc7-e5df-4479-7485-08d7ecf72626
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2020 11:10:53.9158 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xdwIrKAfKepTtkOJQvwUhbU7ybxKO5YkUu32GvV8tr0H7XY9v3zJEl96akfj3ePRPSae1sd9lA40KM53iZasaXmyeghMtQTwKAOKaKWNOcU=
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

So, convert driver wrappers parameters which are already 64bit to
signed type.

Patch-correctness audit by Eric Blake:

  bdrv_driver_preadv

    Remains 64 bits, the question is whether any caller could pass in
    something larger than 63 bits.  Callers are:

    bdrv_co_do_copy_on_readv() - passes 'int64_t pnum', but sets pnum
      in a fragmenting loop, MAX_BOUNCE_BUFFER when copy-on-read is
      needed, or max_transfer bounded by BDRV_REQUEST_MAX_BYTES
      otherwise
    bdrv_aligned_preadv() - passes 'unsigned int bytes' further limited
      by fragmenting loop on max_transfer <= INT_MAX

    Input is bounded to < 2G, internal use of 'bytes' is:

    drv->bdrv_co_preadv_part(uint64_t) - safe
    qemu_iovec_init_slice(size_t) - potential truncation on 32-bit
      platform [*]
    drv->bdrv_co_preadv(uint64_t) - safe
    drv->bdrv_aio_preadv(uint64_t) - safe
    drv->bdrv_co_readv(int) after assertion of <2G - safe

  bdrv_driver_pwritev

    Remains 64 bits, the question is whether any caller could pass in
    something larger than 63.  Callers are:

    bdrv_co_do_copy_on_readv() - passes 'int64_t pnum', but set in a
      fragmenting loop bounded by MAX_BOUNCE_BUFFER
    bdrv_co_do_pwrite_zeroes() - passes 'int num'
    bdrv_aligned_pwritev() - passes 'unsigned int bytes' further
      limited by fragmenting loop on max_transfer <= INT_MAX

    Input is bounded to < 2G, internal use of 'bytes' is:

    drv->bdrv_co_pwritev_part(uint64_t) - safe
    qemu_iovec_init_slice(size_t) - potential truncation on 32-bit
      platform [*]
    drv->bdrv_co_pwritev(uint64_t) - safe
    drv->bdrv_aio_pwritev(uint64_t) - safe
    drv->bdrv_co_writev(int) after assertion of <2G - safe

  bdrv_driver_pwritev_compressed

    bdrv_aligned_pwritev() - passes 'unsigned int bytes'

    Input is bounded to < 4G, internal use of 'bytes' is:

    drv->bdrv_co_pwritev_compressed_part(uint64_t) - safe
    drv->bdrv_co_pwritev_compressed(uint64_t) - safe
    qemu_iovec_init_slice(size_t) - potential truncation on 32-bit
      platform [*]

[*]: QEMUIOVector is in-RAM data, so size_t seems a valid type for
it's operation. To avoid truncations we should require max_transfer to
be not greater than SIZE_MAX, limiting RAM-occupying operations and
QEMUIOVector usage. Still, 64bit discard and write_zeroes (which
doesn't use QEMUIOVector) should work even on 32bit machines, not being
limited by max_transfer.

For now, we safe anyway, as all input goes through
bdrv_aligned_pwritev() and bdrv_aligned_preadv(), which are limiting
max_transfer to INT_MAX.

Series: 64bit-block-status
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 block/io.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/block/io.c b/block/io.c
index 7a7d4e578d..eeba3b828c 100644
--- a/block/io.c
+++ b/block/io.c
@@ -906,7 +906,7 @@ static void bdrv_co_io_em_complete(void *opaque, int ret)
 }
 
 static int coroutine_fn bdrv_driver_preadv(BlockDriverState *bs,
-                                           uint64_t offset, uint64_t bytes,
+                                           int64_t offset, int64_t bytes,
                                            QEMUIOVector *qiov,
                                            size_t qiov_offset, int flags)
 {
@@ -975,7 +975,7 @@ out:
 }
 
 static int coroutine_fn bdrv_driver_pwritev(BlockDriverState *bs,
-                                            uint64_t offset, uint64_t bytes,
+                                            int64_t offset, int64_t bytes,
                                             QEMUIOVector *qiov,
                                             size_t qiov_offset, int flags)
 {
@@ -1055,8 +1055,8 @@ emulate_flags:
 }
 
 static int coroutine_fn
-bdrv_driver_pwritev_compressed(BlockDriverState *bs, uint64_t offset,
-                               uint64_t bytes, QEMUIOVector *qiov,
+bdrv_driver_pwritev_compressed(BlockDriverState *bs, int64_t offset,
+                               int64_t bytes, QEMUIOVector *qiov,
                                size_t qiov_offset)
 {
     BlockDriver *drv = bs->drv;
-- 
2.21.0


