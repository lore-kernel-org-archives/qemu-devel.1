Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A45DC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 16:36:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30C792078D
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 16:36:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="epzcQD0G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30C792078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34974 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjQCG-0008NV-8k
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 12:36:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57746)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jjQ34-0002Ww-0l; Thu, 11 Jun 2020 12:27:26 -0400
Received: from mail-db8eur05on2110.outbound.protection.outlook.com
 ([40.107.20.110]:32417 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jjQ32-0006oc-9K; Thu, 11 Jun 2020 12:27:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=awOHVg3tvsboINfwYQv85NydFHJtcqqCkhXgQ3Jd6yB+cRttWF/F5SJlg2oJ9N2G6kFlzdFZNR+LC56qa7GL83TNlUPYkjjx7mz2YN1a+HSIwXGImJ3YB4ZV57ZU/kTVVMktrtBI1tcKNeo46YLW2S9cfgjYKu8TrbOl5s6Wcd1rrLsvkjbNszmGUhYiz/1UlSbjBqtFhZcax6jelhuIBdGWvhmHbF9gO5AeAXjRWo1naqRHBf6UBtuMgABe7FztKeVVxRR5ygpEqa3BLaPxSxKO3pu7nOHT4/lLPeJZ5VXDsYS40yp8Yul1bs6DzRxw+7LHlk5qFSX2ipS4ljDDDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=22avaeLLnRcLu9UcTyT8S1btPLeXV//FNuyxXDx/02Q=;
 b=UwVpxWToLggTWh6wV1KTe2TGsIxCGOGBA/Bp0whaOyU39r7bXHlzMVxpM1rbS0Fw2FDSHOkclvAJ1wBE4ICvX6/7jmG+2uVO+1njqr26yRqSORhP3tXROKdqiqZ2kvjiDTWrNXZjbocrFTDM4Lc4Y0qnpFVqwXwdOS7xaZ82s9qv53R7EIrYlzHWEzyfd7DTs6ZDOBnuZJFt8jcn32HdYuBBivaXjuMdLjO9+H2GVz2ixyYn5Jqj7TZiseCRC5lre41mktoJuCl8anRYXOTRpJAXprIuFHWn7UBz9SJlhsY6bkeSQZT0/9VG6r+/CzfHySao5HI34rYUHSWr4O3EhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=22avaeLLnRcLu9UcTyT8S1btPLeXV//FNuyxXDx/02Q=;
 b=epzcQD0GCKLbzYtVHzJpru1B4qj2Vggy5RDSXC0TbrVGGK0AjYflv68Yxm6z2axBeK8qtpshu3u71Ski/NeJVCrflqtlbvcaGC7MS240nWw+xnt5EjIClVjIciDwVYeozvVCSeHJj3VJBccz4ceofBT1/N1jzE4HmcYwMYhh2Vg=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5493.eurprd08.prod.outlook.com (2603:10a6:20b:102::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.18; Thu, 11 Jun
 2020 16:27:14 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3088.022; Thu, 11 Jun 2020
 16:27:14 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v4 3/4] block/io: refactor bdrv_co_do_pwrite_zeroes head
 calculation
Date: Thu, 11 Jun 2020 19:26:54 +0300
Message-Id: <20200611162655.4538-4-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200611162655.4538-1-vsementsov@virtuozzo.com>
References: <20200611162655.4538-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM3PR05CA0148.eurprd05.prod.outlook.com
 (2603:10a6:207:3::26) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.159) by
 AM3PR05CA0148.eurprd05.prod.outlook.com (2603:10a6:207:3::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3088.18 via Frontend Transport; Thu, 11 Jun 2020 16:27:13 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.159]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8ddfc919-3d4e-4cf7-3ab2-08d80e244c70
X-MS-TrafficTypeDiagnostic: AM7PR08MB5493:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5493FD4A09393C43D2279571C1800@AM7PR08MB5493.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0431F981D8
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VvSBPMWe0wcjWWuU7RwG71oofYJbQmD4lJRYa/Em0kAfiaJ1QH5zl24AbMIwgU6ChWs35Ef0i1lq/+JYHA9XfwWgAveo+xk6px3OpZbY6lVZqpjwrxZzb9pOrshFDMzLQR1ozzTzAWaMBebMsJGlRzJ9Hti45Az6RYjMTjMGz3qEbpZi3Dl+ggs1wkyE7kP2HI3rUVT1bhBjUwubazhZiFPhfl/iu+VRYBV4so+7lVANqCy4NlUUkSOYItsdjnz5vj3HzmpqxpeotIv5QyqfDaVRBh+hk2/B1oL84YdpAxozBBXH5JHgfmGxmg0zd8xE
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(346002)(136003)(39840400004)(366004)(396003)(6512007)(316002)(478600001)(16526019)(186003)(8676002)(36756003)(6486002)(8936002)(52116002)(83380400001)(2616005)(107886003)(6506007)(26005)(956004)(4326008)(6916009)(66556008)(6666004)(66476007)(5660300002)(1076003)(86362001)(66946007)(2906002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: QTCJC5v/4oMNtQ0HaT4neht8Gz/5251i6TpzAur4GJ+7/Bqwt0nU6oGLuAyzS626QC8x4xCpTYYBJT++A3i6PplNmirJaKQKQVqQ35S2+aFMu6EdKtVkmDSi6d5VfMOUyV7UmkmGErzG6N4rZfwdItk8b4/4uEILMggLnu/sqy8UvKXjBQy0ob3z4YWvks6rmCNuMZDNXr2+rC7zIkazFzouTKdXoOiGpaKMpw6FDzrXLiuIX7CwIKcGsi4eTLzvK1QYl/jCj7O3SfgX6Z/Aa/VGhkympdbEdbC5ZBQImwU1nSXmRho7jHXXwYIFvub4YN7WQ96FBSldcNnG0fICIi/JRU9Ao7aXLya41aS71V0YDib1GsEcZWEw35KYrzAYa7hzXytFZ7+kNs6WJGRTqYS0nnGFfnrsvwSxDUBBoCS3uD+txdEKDuAv4fcNjgBpvHQm4U8FF47xj/on0uFqHt9ynN1uvcToAVclGa+ZCJfh7tG4NuE7aDVHboVl4qeU
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ddfc919-3d4e-4cf7-3ab2-08d80e244c70
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2020 16:27:13.8976 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gigYqep1pA6t/4y0lbFCoQ0PVb7E88cMM5JzQoCL25ZqiSXjyJFJ56J6yc+rAsz7fydhTSR/acGJf9fINFKNpau9shlhkH3ogAGfb4wBEeY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5493
Received-SPF: pass client-ip=40.107.20.110;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 12:27:11
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
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
 qemu-devel@nongnu.org, mreitz@redhat.com, stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It's wrong to update head using num in this place, as num may be
reduced during the iteration (seems it doesn't, but it's not obvious),
and we'll have wrong head value on next iteration.

Instead update head at iteration end.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 block/io.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/block/io.c b/block/io.c
index 0af62a53fd..3fae97da2d 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1813,7 +1813,6 @@ static int coroutine_fn bdrv_co_do_pwrite_zeroes(BlockDriverState *bs,
              * convenience, limit this request to max_transfer even if
              * we don't need to fall back to writes.  */
             num = MIN(MIN(bytes, max_transfer), alignment - head);
-            head = (head + num) % alignment;
             assert(num < max_write_zeroes);
         } else if (tail && num > alignment) {
             /* Shorten the request to the last aligned sector.  */
@@ -1872,6 +1871,9 @@ static int coroutine_fn bdrv_co_do_pwrite_zeroes(BlockDriverState *bs,
 
         offset += num;
         bytes -= num;
+        if (head) {
+            head = offset % alignment;
+        }
     }
 
 fail:
-- 
2.21.0


