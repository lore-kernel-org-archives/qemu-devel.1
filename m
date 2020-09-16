Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B751AC433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 12:22:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F19342223C
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 12:22:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="cGrbRidv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F19342223C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43312 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIWRw-0006I9-VI
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 08:22:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34776)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kIWQT-0004aZ-TH; Wed, 16 Sep 2020 08:20:41 -0400
Received: from mail-eopbgr40130.outbound.protection.outlook.com
 ([40.107.4.130]:3150 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kIWQM-0004Gb-Ho; Wed, 16 Sep 2020 08:20:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OpD8qcr7wUTpk9fKz1XvMSJ/pV7PkFFcMvqmvnv9USa7XUHiYgiQ1iIRLsTUFBq6aH9hXxKTzXAhViLJakujBpOHB0J9uCNhjI6NVJFBkO7tryFbCoGm5fSNPz1hyVjHhCLKdf8R/zMNgNW6w4yT1/8lVovO5UgI9EqX53FtQ2jitsglOHfNchYuYSh7/FF51HAcpKtwbopop42B/P4ZTPoBizhG17WhCWvPsOVc4vZc4lMl9e4Rg6bCB4M134lf4dE0GbPixBC9fO6vJTqs78Kz1fOPsSYEOnHyZZfPHu1rKcoxwD8VAnf+tJp8QeBGeZz8BzaaDXs+9VjTTU/H2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eutP0bt/A5kci9FdvkvwyiCx3/9AREBbZGbhPj/Zu+U=;
 b=F9jCxsL2S/B8WYhl9npv034lKiX3RJvzWanLR+aELL9qfS0XA33LfHcrx8HTsW1bJTtmKTpCdC76NV85Hj0sN1w4QUk7Ski8fF+XaYPPsWJwZd2n7r9ssPPL1PArBkZGdsScQ+6NpwynbE9HPvepNrFPz21wYohNL/JI6dMIAhlHcQqcPXgN1JEMxLyGKG0FRiwAKJedZHj2tScAM1q9nsZdFYVhREFmOVamJO4PEFL6zMSSgjjDEVPTzLSYm1yirm+6GesJk1ws5+9YF9LvYaL7Ml6ZJyKyIirI2B1DWDXSMpg9ev378l43R0yaX7FkHbKgY5NqA3iErKOKWKxcVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eutP0bt/A5kci9FdvkvwyiCx3/9AREBbZGbhPj/Zu+U=;
 b=cGrbRidvKgS3FPlXkU4thq1P8v68hPYFtzznj6XuL/6M4kRpnmr2eDCeGc7vApIXncQUnpn9UuclBYdbQ/WOw7KwHC8R9huEwmLK3dz0lo0thNZfEWQKttSJlYFzGVpLeZ+jMGsPP0z/N0Sdr/e+xdCWruHfeOsS/it8gmTEhEE=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB5077.eurprd08.prod.outlook.com (2603:10a6:20b:e6::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14; Wed, 16 Sep
 2020 12:20:24 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692%8]) with mapi id 15.20.3370.019; Wed, 16 Sep 2020
 12:20:23 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, fam@euphon.net, stefanha@redhat.com,
 mreitz@redhat.com, kwolf@redhat.com, eblake@redhat.com, den@openvz.org,
 vsementsov@virtuozzo.com
Subject: [PATCH v6 1/5] block/io: fix bdrv_co_block_status_above
Date: Wed, 16 Sep 2020 15:20:04 +0300
Message-Id: <20200916122008.20303-2-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200916122008.20303-1-vsementsov@virtuozzo.com>
References: <20200916122008.20303-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR04CA0018.eurprd04.prod.outlook.com
 (2603:10a6:208:122::31) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.75) by
 AM0PR04CA0018.eurprd04.prod.outlook.com (2603:10a6:208:122::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11 via Frontend
 Transport; Wed, 16 Sep 2020 12:20:23 +0000
X-Mailer: git-send-email 2.21.3
X-Originating-IP: [185.215.60.75]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e94728be-5d67-44fa-b390-08d85a3ae314
X-MS-TrafficTypeDiagnostic: AM6PR08MB5077:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB50773E87CA213374F90C160AC1210@AM6PR08MB5077.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TtDvsHP3Qs0CtS+ciU4/PH3gQL/FyvC5gSn9R/GRtky7Es80SJKcy6s60AY0E/7QE6XZeTQfY75V6sT7kT8NiK6bNFj5NtOfR6PT4CdspSMXsB7dyn2F1FEI7VqC52OXl75FC0oD3WKoeVMYfARGFdX+rVD9VW85HRNg8mty/U/xZ/ZtLIYU87aYzP4jibsjfKbDnK/MXCGJAka57DR5d8c6zJ+YmCd8RLC6kDCbbkq82TAygm87rRsTSLvyRiWIXfvNuCI5pTkswJLCnP/h6EH8iT8oz+VcHNxmDKRDhrpX29XmrgmSxanyvj/yjyuGdS2exCukzTjEz+qs8XUk1g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(136003)(39830400003)(366004)(396003)(26005)(16526019)(6486002)(316002)(478600001)(6506007)(186003)(5660300002)(6512007)(2616005)(956004)(1076003)(36756003)(6916009)(2906002)(8676002)(66556008)(66476007)(86362001)(52116002)(107886003)(4326008)(66946007)(83380400001)(6666004)(8936002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: WT4/ZOUWldF/KaHzbpNDQAXjYBaXXYZ5o6Fnamr+BjirEzYMGloaHRZs7Ev7f0j+tvN+OC0estUhkFfzi1OvElFxUIgSIB4GnZEa1MTmLLEhEsvNA+f7d+DpYYk0xo7xAF1FaNQabLgAaF3DkA64Kiz+x2GsOtaRqvimMV99ZTIdqQ+XcfrrqKNVZWFXgo+dUu5q1FtddaHmj5N4jgHTotyv5YJIYTZjF1CdJwTqHVgZ+Iy2W3wJBfOhLMG1zUX0FZKYYYjwWONTt2piTY4r5wZ4IvCnicPw58vVmemk+RSGk1OBcScT/ubYaOG/ikFk89rU6CclnwkwPecfn8yLz0QKTZO5PWQzS4VFapLRb9dlwLOikYGdDjy3E1JbBZcFz/7gUC8RATg/zzlMJ534vdT/qQ7vvS2Zx3ci2jfTmmwh8enQmP1sntbdCpkKxw6sTugoSsy9qZ9K5xKafg6xO4gQGE9kpWogzzFCxa7T+VxEN74zrFFuQk//ngxw4ek+dgMP5dMR86UBI2ibQVUAYuJ4GGAzto74EzE23B64+7xvPYA/2H8+4pESqYFav2x6znW3/FRq1HhepU6Udv6pTU8xRtmr95+PP2T4Latv9WwuE9FGFnxz6tjJX9jwvj1K0+cEDVBvTJ9OnhA98UpUpA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e94728be-5d67-44fa-b390-08d85a3ae314
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2020 12:20:23.8726 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7tevzm2bftraB4wHQlkQ2vr2kmxEvhgIc8Ebpdged1RUlLcDuF3XZ4e1s02hSB/rqUv8czn19xERve6yaDe0tFWorMsfygx84Rdu3IvGlC8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB5077
Received-SPF: pass client-ip=40.107.4.130;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR03-DB5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 08:20:24
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

bdrv_co_block_status_above has several design problems with handling
short backing files:

1. With want_zeros=true, it may return ret with BDRV_BLOCK_ZERO but
without BDRV_BLOCK_ALLOCATED flag, when actually short backing file
which produces these after-EOF zeros is inside requested backing
sequence.

2. With want_zero=false, it may return pnum=0 prior to actual EOF,
because of EOF of short backing file.

Fix these things, making logic about short backing files clearer.

With fixed bdrv_block_status_above we also have to improve is_zero in
qcow2 code, otherwise iotest 154 will fail, because with this patch we
stop to merge zeros of different types (produced by fully unallocated
in the whole backing chain regions vs produced by short backing files).

Note also, that this patch leaves for another day the general problem
around block-status: misuse of BDRV_BLOCK_ALLOCATED as is-fs-allocated
vs go-to-backing.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/io.c    | 66 ++++++++++++++++++++++++++++++++++++++++-----------
 block/qcow2.c | 16 +++++++++++--
 2 files changed, 66 insertions(+), 16 deletions(-)

diff --git a/block/io.c b/block/io.c
index 84f82bc069..e381d2da35 100644
--- a/block/io.c
+++ b/block/io.c
@@ -2366,34 +2366,72 @@ bdrv_co_common_block_status_above(BlockDriverState *bs,
                                   int64_t *map,
                                   BlockDriverState **file)
 {
+    int ret;
     BlockDriverState *p;
-    int ret = 0;
-    bool first = true;
+    int64_t eof = 0;
 
     assert(bs != base);
-    for (p = bs; p != base; p = backing_bs(p)) {
+
+    ret = bdrv_co_block_status(bs, want_zero, offset, bytes, pnum, map, file);
+    if (ret < 0 || *pnum == 0 || ret & BDRV_BLOCK_ALLOCATED) {
+        return ret;
+    }
+
+    if (ret & BDRV_BLOCK_EOF) {
+        eof = offset + *pnum;
+    }
+
+    assert(*pnum <= bytes);
+    bytes = *pnum;
+
+    for (p = backing_bs(bs); p != base; p = backing_bs(p)) {
         ret = bdrv_co_block_status(p, want_zero, offset, bytes, pnum, map,
                                    file);
         if (ret < 0) {
-            break;
+            return ret;
         }
-        if (ret & BDRV_BLOCK_ZERO && ret & BDRV_BLOCK_EOF && !first) {
+        if (*pnum == 0) {
             /*
-             * Reading beyond the end of the file continues to read
-             * zeroes, but we can only widen the result to the
-             * unallocated length we learned from an earlier
-             * iteration.
+             * The top layer deferred to this layer, and because this layer is
+             * short, any zeroes that we synthesize beyond EOF behave as if they
+             * were allocated at this layer.
+             *
+             * We don't include BDRV_BLOCK_EOF into ret, as upper layer may be
+             * larger. We'll add BDRV_BLOCK_EOF if needed at function end, see
+             * below.
              */
+            assert(ret & BDRV_BLOCK_EOF);
             *pnum = bytes;
+            if (file) {
+                *file = p;
+            }
+            ret = BDRV_BLOCK_ZERO | BDRV_BLOCK_ALLOCATED;
+            break;
         }
-        if (ret & (BDRV_BLOCK_ZERO | BDRV_BLOCK_DATA)) {
+        if (ret & BDRV_BLOCK_ALLOCATED) {
+            /*
+             * We've found the node and the status, we must break.
+             *
+             * Drop BDRV_BLOCK_EOF, as it's not for upper layer, which may be
+             * larger. We'll add BDRV_BLOCK_EOF if needed at function end, see
+             * below.
+             */
+            ret &= ~BDRV_BLOCK_EOF;
             break;
         }
-        /* [offset, pnum] unallocated on this layer, which could be only
-         * the first part of [offset, bytes].  */
-        bytes = MIN(bytes, *pnum);
-        first = false;
+
+        /*
+         * OK, [offset, offset + *pnum) region is unallocated on this layer,
+         * let's continue the diving.
+         */
+        assert(*pnum <= bytes);
+        bytes = *pnum;
     }
+
+    if (offset + *pnum == eof) {
+        ret |= BDRV_BLOCK_EOF;
+    }
+
     return ret;
 }
 
diff --git a/block/qcow2.c b/block/qcow2.c
index da56b1a4df..15ba0ce81a 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -3872,8 +3872,20 @@ static bool is_zero(BlockDriverState *bs, int64_t offset, int64_t bytes)
     if (!bytes) {
         return true;
     }
-    res = bdrv_block_status_above(bs, NULL, offset, bytes, &nr, NULL, NULL);
-    return res >= 0 && (res & BDRV_BLOCK_ZERO) && nr == bytes;
+
+    /*
+     * bdrv_block_status_above doesn't merge different types of zeros, for
+     * example, zeros which come from the region which is unallocated in
+     * the whole backing chain, and zeros which comes because of a short
+     * backing file. So, we need a loop.
+     */
+    do {
+        res = bdrv_block_status_above(bs, NULL, offset, bytes, &nr, NULL, NULL);
+        offset += nr;
+        bytes -= nr;
+    } while (res >= 0 && (res & BDRV_BLOCK_ZERO) && nr && bytes);
+
+    return res >= 0 && (res & BDRV_BLOCK_ZERO) && bytes == 0;
 }
 
 static coroutine_fn int qcow2_co_pwrite_zeroes(BlockDriverState *bs,
-- 
2.21.3


