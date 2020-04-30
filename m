Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 800EFC8300A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 11:21:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A6E72076D
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 11:21:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="oAk4ViQ+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A6E72076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38958 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU7G1-00015p-DX
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 07:21:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57748)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jU78U-00071J-Mu
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 07:14:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jU76y-0005GU-Kb
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 07:13:46 -0400
Received: from mail-eopbgr70099.outbound.protection.outlook.com
 ([40.107.7.99]:12710 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jU75o-0003SE-9u; Thu, 30 Apr 2020 07:11:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZwhntE58zyV9lSDa2PVtkRdh6jn/ph5uIpixJwKn4lZV3V1DsYXDIgSzci8KNfINzUfIhuaKA3dLrIgpcvnZ1NQDjrUd4uL2gADQ48Ak/Vyy7mTW1q+bYgGDmdUyCJN6rv8phHwJ9fg2Ptrbl7UAoBOH3Rptd2I9eofG3z3QlZdVHSJBpg86JZiPBK1auvUz5XgzOAU6wfaatt8twMxTQyuW0VDAnIpDPOgzBKB/ujrfzCw1yOJfioVbnCdG54RtLT8/KIX8ofhjYBAKQtJrGxGJuR4KXKwRul18s4b2BK4+09zjbZ5oVF0WwsgwNednZZHKeQVc0CnpN05XFc1JHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=757f6Z3WKwiTY+zFjH1qq38WS6NgsNyUR3fW613bfWw=;
 b=AbfwsSK3/OGIw8n57tMG48CX5v67JmTTg8I0T0M3YKjbCTMMMtwFoqP/TuZJj9PCpO8SIb711xlx9E49SNZWrFZdeH5tkaGjt+bttunMNUee834mzqEb149HMHDhcjLXTFek6PO4IkwpaL1M3Ajf6BJjKIGwfNUA+9yLhxwjhykZV79z0mRWtGRRB14Ion+ukTX/ey9ki6ZTuN7G3e6Sp8JL4lVVXn5H+Iw3dm0vwQS9vftQz4C6jsl7trOhT2XGqIT14tMdUT+C6BR6gfDhMgzQS53mz26KZlz89MCHFd9FOFTKRyKMRTW/1isIPSO+1MQNg26L7IOYro/4w82JLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=757f6Z3WKwiTY+zFjH1qq38WS6NgsNyUR3fW613bfWw=;
 b=oAk4ViQ+kx/7OCS3g/2xN8elDnq448EyePo6PwhPxGIiqE1uBkMBqAI1KwqdtYVRQy3+6xSEVWjXQ/gC++0K4mPreyqkg/PrreivKK4HuUyz5suWK2WUvuqm4H6+pTHLnO4YmwAodqAp4DQzzXCjAs4NOaWz1JL2te4TYXDNHd8=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5399.eurprd08.prod.outlook.com (2603:10a6:20b:104::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20; Thu, 30 Apr
 2020 11:10:58 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2958.020; Thu, 30 Apr 2020
 11:10:58 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v3 07/17] block/io: support int64_t bytes in
 bdrv_co_do_copy_on_readv()
Date: Thu, 30 Apr 2020 14:10:23 +0300
Message-Id: <20200430111033.29980-8-vsementsov@virtuozzo.com>
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
 15.20.2958.19 via Frontend Transport; Thu, 30 Apr 2020 11:10:57 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.138]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8642500c-2b08-44bf-6389-08d7ecf728d4
X-MS-TrafficTypeDiagnostic: AM7PR08MB5399:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB53998EE6AD8BE7944B2B9790C1AA0@AM7PR08MB5399.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:590;
X-Forefront-PRVS: 0389EDA07F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yOPr7ViXI0QrfW4YXIoWRevjcKasVIAyhvE93201K8IhTaJwwCnSisavaZRv8bTrO44C0PpbfWYJVamu9TyK/1zxmiz/QQfG6cG8aKBi7DA/9mEwW94PapFd4rKX2txlDCqSTPDHc0jOCCO6+X7bdhdmgdKDH2lTFbrj4TFBkzcg3Ozr5Kdf93W4PXh9D4vSBJYxpk5cYFCEiyW2f1o4FM17tkn1/KJGsl2SrA+pOZY3xNalxvk5olynOa2lLlFXBWQMJeZlfUTkKAKVotXqlzwNZZTuzXJt6A38UDwE1ScGAwn5w40mZTCUZvs/gnJx8mD+SuBa09OBoFPFpBdFd+NoU0w+CDG/qzgp/lg3Z/AMasECd7Q50qdpgwDQHmp8lr2vnjL7FYGI2jBEG0uYQEVVXfwyQYfSvNsbbmdJ+kfd4rBtrf9H2bohRc0Ckm3A
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39850400004)(396003)(366004)(346002)(136003)(376002)(1076003)(36756003)(478600001)(8936002)(26005)(6512007)(7416002)(5660300002)(107886003)(6486002)(66476007)(66556008)(86362001)(6916009)(6506007)(6666004)(8676002)(316002)(2906002)(186003)(66946007)(16526019)(2616005)(956004)(4326008)(52116002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: rUIMgvGlMWpbSRt0vsojJqEhOUolOZBdvyFBPc3aalOYM2PqQdSokXJsmuzBKjizcosumKi7gP6Klrvic+8BLD927VIoIu1nldvdICN6a/19NMIsq+8cy/7GFj6RFEQRW/1zLt641FKvf2wIhMNisEK0G/ROx7r6qaAzgu6cwLJjK6K9Go8DT9219A0yLXPF5aUXRPth6WXZxS3jS8W0n7WMqVr5hUsQwOT9qAK/jVl3dEFda+9lBppQN0IS8xte/3bk8ZYnwt5MMVpkpH2dIHx8MUQ6oTqWEn+OfXQhW5WhW51g8Qbl+S6NByh+RDDFT60Oh4tdI1BaiZx2c0wThs4q7K33QjQ1+7IfUfFgVlk0bjgO4vjn/zz7gJSSucrr5Z+gx9WFcGQZ5xA8GhJWVtGYllXLu5cfwnFcxvuoKhGjNRvVWDY804ChC0/MVKVoWxmm6dblS9zymFdWq/ywyuIKIZ9Q3M8KvSMwRXeJ/HOexu1YTR5OJA6zqF7phbdl8IzQdrYcx+fhwjTRRl8OR7mVJToznh2IQGtC3QEZgqj4tS5H49lzLqcvWQ5EplYOyKo0n57w2nzjiBT257ZO+WtjaAt52GNSlOzsxeC2fLVxjBzR+E6K6kFzirZSxSZ0fZ0fYZW62i5Yle4wln8qbqfXc/RvtMGzVj2h8sKh5ahW6jbKhnms5TTqqOle7iEOCPEeL5bqt8rdJHsCfQuJN0nwklUUB6NDwu3hOyHB86wFgOI7pNBKOvBQERhqxuQ33bYK0uG7jBCxnEUV2wnrWoEAtl1d4MZkKCQNdlOy2pA=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8642500c-2b08-44bf-6389-08d7ecf728d4
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2020 11:10:58.3952 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fvw2LldEefjkBFJyGC22ROXeCkn/Dg1mlk3zl/aM5LohIkbfXBwoqzDyPvjHC3KIctW+8b/HoYnql/SHVBt4bbRsZLn++YzZ1eX/MYziVDw=
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

So, prepare bdrv_co_do_copy_on_readv() now.

Series: 64bit-block-status
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/io.c         | 6 +++---
 block/trace-events | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/block/io.c b/block/io.c
index 8bb4ea6285..6990d8cabe 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1088,7 +1088,7 @@ bdrv_driver_pwritev_compressed(BlockDriverState *bs, int64_t offset,
 }
 
 static int coroutine_fn bdrv_co_do_copy_on_readv(BdrvChild *child,
-        int64_t offset, unsigned int bytes, QEMUIOVector *qiov,
+        int64_t offset, int64_t bytes, QEMUIOVector *qiov,
         size_t qiov_offset, int flags)
 {
     BlockDriverState *bs = child->bs;
@@ -1103,11 +1103,11 @@ static int coroutine_fn bdrv_co_do_copy_on_readv(BdrvChild *child,
     BlockDriver *drv = bs->drv;
     int64_t cluster_offset;
     int64_t cluster_bytes;
-    size_t skip_bytes;
+    int64_t skip_bytes;
     int ret;
     int max_transfer = MIN_NON_ZERO(bs->bl.max_transfer,
                                     BDRV_REQUEST_MAX_BYTES);
-    unsigned int progress = 0;
+    int64_t progress = 0;
     bool skip_write;
 
     if (!drv) {
diff --git a/block/trace-events b/block/trace-events
index 29dff8881c..179b47bf63 100644
--- a/block/trace-events
+++ b/block/trace-events
@@ -14,7 +14,7 @@ blk_root_detach(void *child, void *blk, void *bs) "child %p blk %p bs %p"
 bdrv_co_preadv(void *bs, int64_t offset, int64_t nbytes, unsigned int flags) "bs %p offset %"PRId64" nbytes %"PRId64" flags 0x%x"
 bdrv_co_pwritev(void *bs, int64_t offset, int64_t nbytes, unsigned int flags) "bs %p offset %"PRId64" nbytes %"PRId64" flags 0x%x"
 bdrv_co_pwrite_zeroes(void *bs, int64_t offset, int count, int flags) "bs %p offset %"PRId64" count %d flags 0x%x"
-bdrv_co_do_copy_on_readv(void *bs, int64_t offset, unsigned int bytes, int64_t cluster_offset, int64_t cluster_bytes) "bs %p offset %"PRId64" bytes %u cluster_offset %"PRId64" cluster_bytes %"PRId64
+bdrv_co_do_copy_on_readv(void *bs, int64_t offset, int64_t bytes, int64_t cluster_offset, int64_t cluster_bytes) "bs %p offset %" PRId64 " bytes %" PRId64 " cluster_offset %" PRId64 " cluster_bytes %" PRId64
 bdrv_co_copy_range_from(void *src, uint64_t src_offset, void *dst, uint64_t dst_offset, uint64_t bytes, int read_flags, int write_flags) "src %p offset %"PRIu64" dst %p offset %"PRIu64" bytes %"PRIu64" rw flags 0x%x 0x%x"
 bdrv_co_copy_range_to(void *src, uint64_t src_offset, void *dst, uint64_t dst_offset, uint64_t bytes, int read_flags, int write_flags) "src %p offset %"PRIu64" dst %p offset %"PRIu64" bytes %"PRIu64" rw flags 0x%x 0x%x"
 
-- 
2.21.0


