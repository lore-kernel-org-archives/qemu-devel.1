Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA256C8300C
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 11:19:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3CDB2076D
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 11:19:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="TF3Yhw8A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3CDB2076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58538 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU7Dc-00058a-7J
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 07:19:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57706)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jU78P-0006rZ-07
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 07:14:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jU76t-0005EY-EI
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 07:13:40 -0400
Received: from mail-eopbgr70099.outbound.protection.outlook.com
 ([40.107.7.99]:12710 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jU75g-0003SE-Jn; Thu, 30 Apr 2020 07:10:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MC+CftcrZJfS9kyxHob0+ZhcAGQr/yIQxDtLhh8ElqKz/EfoZvcgK78NJrZOOfGHKnyMxy57ZHk9D2mkyQLs0q3VbB5QCCsOLmhtuGhXMHcc295jq31ZuiRLuP/RhgrQJVdq9cOxzM130BOzCfLBgf8rvRKyu7wMpPCUdlOqJIHS6cZqO8fRuNCtN+FA6v1eY1FLTZZlFPXTftE0+9VfUOSZ6Yns1KwHEI9XBkXUDH2blkqZX0qw4Sn9+6js8rPrP2bD2WCSp4HCZcBPo2ekLInuixX8vmKfobVrZHz6qPU6+mvBhMTQFY1j5dUSoN0gQThkojSj3Ijp9OjSr2N28w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gF05sRHYizg+u644p4qnPQeW1LsP7vuUemd46yD+PME=;
 b=awpxObDfip6CchDE7Fy4olm8wTIM74F0PagNRuhuvZav8wh74hd7znU4+KBBvT85XSVlg/hGUYVT2JPEPTWW6M7nU7seBsye8aBhb3dBkHB/wXVRPxWlC023y8kLzc1TD/+yHpP9u0p2uGpzL0BjkdM+poZmDSyQN4ACU5yEMJQIMk1DCpIzcT8s04rP7iwTuIduCaOwM8K0kheTYSBtsgNTFphK/24BqP3BQ33VPUIdHtzivIAyUhHu8c9JW3UYq3nnCcAVWSVWlNuUicNOdG1fWjguFGOngcnAM+3Lkl0UIhMnAZY2GSHZOIx/4gYrPTNKZAVWV3kABDEAOvQjKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gF05sRHYizg+u644p4qnPQeW1LsP7vuUemd46yD+PME=;
 b=TF3Yhw8Ak66aWherY7P5lwIvVkqBTgUmGF33471VF3zjgYXzNscmwtBp/29c0bAr3b0mQGGOC+ffcXgVA+G9sMmQ/APamtIxTNgoSyXqrtG85H9k97H4SYDqUYlm0PYRtpeRlBy5PwnMoiOtq6aqS7xndkhZQLGL6LnSWLQkeAk=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5399.eurprd08.prod.outlook.com (2603:10a6:20b:104::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20; Thu, 30 Apr
 2020 11:10:48 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2958.020; Thu, 30 Apr 2020
 11:10:48 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v3 01/17] block/throttle-groups:
 throttle_group_co_io_limits_intercept(): 64bit bytes
Date: Thu, 30 Apr 2020 14:10:17 +0300
Message-Id: <20200430111033.29980-2-vsementsov@virtuozzo.com>
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
 15.20.2958.19 via Frontend Transport; Thu, 30 Apr 2020 11:10:47 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.138]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7c992617-3633-4b55-1d01-08d7ecf72319
X-MS-TrafficTypeDiagnostic: AM7PR08MB5399:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB53990F765FBB5B5DB48F10E4C1AA0@AM7PR08MB5399.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0389EDA07F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3vkFgPpczJiZxHJ+CHwhBlmYqRsdv2uA6GtVhVt7D43QrosaXIbgxGML7eOKt7hEvrCrzaQm4+WbBZ1RChoJzNgOK5/MWRwrozDMms7ZH5XYNn0iAJD9EPiZHGBGOG6gUc0AXZqESFsQI41yljI6FnDjGQOKA2RejzJv/VD7gE6kj8RockroClLuPx1cbiHI03QVY75Lb5UxLfv8l52ooV6xDQogcp+G7C5YtTIVaic6jg7gbQ1hB3OjvbqepCtvj0fXesvjxbcGlcr8lTTSon3uW0Q50FndFPEiJ2QVFpeRYwQcPxjTh5RLV6CuBvAH1+6c6k2ck7XRjVgrELyrdjGgSLaUFirjSqQIDnn4BCd4JpTL0bEcCuvnwGkLx63QBs7OTCMtE9SnpH2to55Ox+lz086qZSmOFBG0fHSsK5HD1wlhOy8qS/0aaUCwuC8z
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(366004)(39840400004)(346002)(136003)(376002)(1076003)(36756003)(478600001)(8936002)(26005)(6512007)(7416002)(5660300002)(107886003)(6486002)(66476007)(66556008)(86362001)(6916009)(6506007)(6666004)(8676002)(316002)(2906002)(186003)(66946007)(16526019)(2616005)(956004)(4326008)(52116002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: q78d8Jp69aeS0HkHanXYWzL0sJvU5Q2uk7ot62rXY207SJEOHNYagSwIy9oPwePkExB2A9vxglR6GifgrEb1TpwM/Vdfhl6f3esQsX74hDBhjHraNRIATZIu2o5To/6a74BJGlcaTUX+OsSmxZn1ER5alixgA+fpPcUZ5FdCxhgp8x+bHDGdKAE7DvZDzBT65iEdrMfCb5INByZrniIFK0ZgYuTD45SZFAGDjVll+G5Bm98OG3imUzmUmXFuFmQjVNG4gfHFDH3VBMzUTd/7ok8K17LHuLkRSNVZ1ff7BEQBE9oYgv9HCww+NZZVBLjEWfQcHQL1iKFSHCColuY8V1Q/XkY64O7zOze36RqYP5X6N3XCPRR8DwAbLO1G/1sKOXVaUk3CAba8MrhTnl++FNml2KCNT5ZM4w69AOvHzDj8rcyrBoudO/LvadgjiDS8F6hOye2uHR6fdsach/t/znpjQ2Xk6Pmq6ZFJjf5LKDmKz1U6lAQohS/hETdNbCdDFOnbGvabouRsidtNYFApWCklnAjRnzMOlds5/v7OvcWRsyBYw4wzzAMen/qMK/c3Y25+mkzNrspF1k8lFmBGZDN8aRzOVgMT2GbDN+g1gn8Hm9QSPtbSdIqgwJhA0mb0qSnfe70BOyHFeegTnZvAnfsQzY8xTyxcZdrcQz5ciEstUlnDDv4FvvV6EZkgx82FWAkwL8zUpy7y336wIH6WqcwcJdCOnRYEMjVDbmloJwQr5fb4+7t1cn3vrDBY849fQsBl67AFwVGrvxulBhH21qQIKWFK9S8cMhgm3EkkvvA=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c992617-3633-4b55-1d01-08d7ecf72319
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2020 11:10:48.8569 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oiiEcrtyRwzQ2YuA5nDZ3XZe0I3w8UeOJsNVH15kvz67XJ4LLKxpvrs6u1cDxjSp99wl7N5A12jfR3SUyO6+6/En+p6MoQyHv+ApfmfUczA=
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

The function is called from 64bit io handlers, and bytes is just passed
to throttle_account() which is 64bit too (unsigned though). So, let's
convert intermediate argument to 64bit too.

This patch is a first in the 64-bit-blocklayer series, so we are
generally moving to int64_t for both offset and bytes parameters on all
io paths. Main motivation is realization of 64-bit write_zeroes
operation for fast zeroing large disk chunks, up to the whole disk.

We chose signed type, to be consistent with off_t (which is signed) and
with possibility for signed return type (where negative value means
error).

Patch-correctness audit by Eric Blake:

  Caller has 32-bit, this patch now causes widening which is safe:
  block/block-backend.c: blk_do_preadv() passes 'unsigned int'
  block/block-backend.c: blk_do_pwritev_part() passes 'unsigned int'
  block/throttle.c: throttle_co_pwrite_zeroes() passes 'int'
  block/throttle.c: throttle_co_pdiscard() passes 'int'

  Caller has 64-bit, this patch fixes potential bug where pre-patch
  could narrow, except it's easy enough to trace that callers are still
  capped at 2G actions:
  block/throttle.c: throttle_co_preadv() passes 'uint64_t'
  block/throttle.c: throttle_co_pwritev() passes 'uint64_t'

  Implementation in question: block/throttle-groups.c
  throttle_group_co_io_limits_intercept() takes 'unsigned int bytes'
  and uses it: argument to util/throttle.c throttle_account(uint64_t)

  All safe: it patches a latent bug, and does not introduce any 64-bit
  gotchas once throttle_co_p{read,write}v are relaxed, and assuming
  throttle_account() is not buggy.

Series: 64bit-block-status
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 include/block/throttle-groups.h | 2 +-
 block/throttle-groups.c         | 5 ++++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/block/throttle-groups.h b/include/block/throttle-groups.h
index 712a8e64b4..f921994b8a 100644
--- a/include/block/throttle-groups.h
+++ b/include/block/throttle-groups.h
@@ -76,7 +76,7 @@ void throttle_group_unregister_tgm(ThrottleGroupMember *tgm);
 void throttle_group_restart_tgm(ThrottleGroupMember *tgm);
 
 void coroutine_fn throttle_group_co_io_limits_intercept(ThrottleGroupMember *tgm,
-                                                        unsigned int bytes,
+                                                        int64_t bytes,
                                                         bool is_write);
 void throttle_group_attach_aio_context(ThrottleGroupMember *tgm,
                                        AioContext *new_context);
diff --git a/block/throttle-groups.c b/block/throttle-groups.c
index 37695b0cd7..14b74b7b8f 100644
--- a/block/throttle-groups.c
+++ b/block/throttle-groups.c
@@ -358,12 +358,15 @@ static void schedule_next_request(ThrottleGroupMember *tgm, bool is_write)
  * @is_write:  the type of operation (read/write)
  */
 void coroutine_fn throttle_group_co_io_limits_intercept(ThrottleGroupMember *tgm,
-                                                        unsigned int bytes,
+                                                        int64_t bytes,
                                                         bool is_write)
 {
     bool must_wait;
     ThrottleGroupMember *token;
     ThrottleGroup *tg = container_of(tgm->throttle_state, ThrottleGroup, ts);
+
+    assert(bytes >= 0);
+
     qemu_mutex_lock(&tg->lock);
 
     /* First we check if this I/O has to be throttled. */
-- 
2.21.0


