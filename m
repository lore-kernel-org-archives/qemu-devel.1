Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE16BC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 16:37:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5D9D2078D
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 16:37:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="WXx8NBGw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5D9D2078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35784 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjQCR-0000H8-S9
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 12:37:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57682)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jjQ2z-0002LP-Gm; Thu, 11 Jun 2020 12:27:21 -0400
Received: from mail-db8eur05on2110.outbound.protection.outlook.com
 ([40.107.20.110]:32417 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jjQ2w-0006oc-C5; Thu, 11 Jun 2020 12:27:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SatIJpzrRyUVQBq3THKiZv5Y3jskB2dKWltYlCqqie5QkUvccbRvq9Jyef4OfSfqDZNXDkWU0vRGHqfmBx0g7wctFu1T/Y0TaM+IJOC943cDPajw8KoZxtSyJCAIYNJSSZPgqNUNfAq3fWeSw180dxc/4eY8xMhEGEvjjsAeB1xkW+/5UFGGd0roZwW7if/Jk9oe9W0drDeaGPvz6h6FK3gQnroIurO5cu39ULJUaUBpGDYSjUe7iZf9NnvW2ZrMIMMNR+fqgrTRQfih1biDEjZJ5RKK/9gfgLB+11UYkRAYLAfQr+pSOBGlZbgSzB2QvqJgRlOcnd4KXK8cK3F/Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r0SO4DX7DNyh9nqVV/vSG+97GsZkC4/oklrCyDg0a4s=;
 b=FlUYWn2a3iP4oZhv4AEMvLjLDnabpVxAfRwWta6y/Kadi5vntkno9fZdCPPPyAKGZHAJErVq6LxT/cfn4ZyA2nZ857Nz/SDXOjzINKEUVdZraB8fwW5TDqW9rGRDcT5SaLoLQMykLxtWIMACyI5JZMqzjnvcSQZrbW8aEK+9J6mauxfclWu74s9K7sEpBRlmT4odL/wuJr1+OVKx6JqKuCmBohC8LfYr1+lgXx9M9Z8Hc1ohyyEQn1eqsDNS7wCpJJKtLLUsKM1Jvn4Ds3+H5aIzoXGfVroo+uhoiYArG7pctmfaFUHXBxlXOHa+EyZh48zu2lZOjz0TOP5Q5YdCeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r0SO4DX7DNyh9nqVV/vSG+97GsZkC4/oklrCyDg0a4s=;
 b=WXx8NBGwtv6jaPzjgVCu7DxefIu6g++HIplmuBbZLSvB+VLw9BMvWhOuu9pbB3WDr8sIr+o+j23EVxtNQeYgD4SR0RXPzeW1zR2IflVK8yZsWfPh/0BwAsKEOsnuYwJdyYqnx+W0MwF6ExOJz+8w2V8zPn9LCU6QK5ygF34dYgI=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5493.eurprd08.prod.outlook.com (2603:10a6:20b:102::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.18; Thu, 11 Jun
 2020 16:27:12 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3088.022; Thu, 11 Jun 2020
 16:27:12 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v4 1/4] block: add max_pwrite_zeroes_fast to BlockLimits
Date: Thu, 11 Jun 2020 19:26:52 +0300
Message-Id: <20200611162655.4538-2-vsementsov@virtuozzo.com>
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
 15.20.3088.18 via Frontend Transport; Thu, 11 Jun 2020 16:27:11 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.159]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 78e6da88-40be-4346-1ccb-08d80e244b5c
X-MS-TrafficTypeDiagnostic: AM7PR08MB5493:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5493899FE599E5A1BE2EF297C1800@AM7PR08MB5493.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:538;
X-Forefront-PRVS: 0431F981D8
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: creaBap4AMfCNZ6LosCaY3+HHVjeE6sY9MDPxlKr24ogi9ftvDVFmCEdkL7UJqeTjUfb6VsbvZjEf1R7Zg/s2huTke2GjYhhatuYHiFe9S7CfwQ0DUKCO+c+9UJCxyquK3C6V/cgjAhVi7RJutBoOf9uSuF3Hpbx3Is1GY8BicLB6b+RvqVa44wiK39R9qrV7GY10jJ+YVUUYESQ0hISDK+hFYeET8su/lfp2Oi76C9k/Erwz7Ng+9SEs2dO/WaVcJOpfghbQFqRD2J5ZI91qQ+GwSaED8Av3unmrXF9oaT2DJxoYT6NWRaSNuV0R5SOEh7wsh9w+QDVmIkrWSUpZA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(346002)(136003)(39840400004)(366004)(396003)(6512007)(316002)(478600001)(16526019)(186003)(8676002)(36756003)(6486002)(8936002)(52116002)(83380400001)(2616005)(107886003)(6506007)(26005)(956004)(4326008)(6916009)(66556008)(6666004)(66476007)(5660300002)(1076003)(86362001)(66946007)(2906002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: /RNDZtVWhHyjAMMuG8zX7COIOjmz5bvoJLY+5WS/qTkd69vRQB3KZwNrzgJrjXkZbAX5lUXhJYOgJK74ydsgfwEZnkkFn3TS9F1tZb4iKWjEGIu5gwuap2H/juJ5KBSedntr7bdnbT0OYTbb18beZ5DgvU9Pu19tGdXPXt09/VwyGnR4iwQRXqCxIrgmYg6RuO1yuS61Nj4j4jtBZZQHO1hPLr69NIxYVwRcOOgTs1y5fRYxZZt/6//CRvRA2RSVFOX+y/8e2kbGawpkHdu5U4EgpwH67RPrDfFiKC7aRVtdcVsN9j6nmpGYBtv2OANe1u7br/cNFKnLe8pS0QL3REYW8GLYOB0PpA4HEeAZceSVXbVC75NKOF26s3n+K8vbvkkTk3PKrA7vGe6CL8ZZXqq+CDXnq6W9I+2/eo9ELXD5D9DG3w+nCxVKkbDGEeYQ98LWGEIGBzHswtEaLAFJiKBylQ2DGlwa29mMnnaq4kUXHM06fZcz1fR2+jvertpb
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78e6da88-40be-4346-1ccb-08d80e244b5c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2020 16:27:12.0447 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W5koqcg2vdOvnizq0VEVuU2h6RJ6lN945f2gaPmYL6Fqtde+d2FpiCbuP8G5HgGqlbjqRXy8nmxCs2kSgZnIdrcc6Sr/SFej33cxgj1axz4=
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

The NBD spec was recently updated to clarify that max_block doesn't
relate to NBD_CMD_WRITE_ZEROES with NBD_CMD_FLAG_FAST_ZERO (which
mirrors Qemu flag BDRV_REQ_NO_FALLBACK). To drop the restriction we
need new max_pwrite_zeroes_fast.

Default value of new max_pwrite_zeroes_fast is zero and it means
use max_pwrite_zeroes. So this commit semantically changes nothing.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 include/block/block_int.h |  8 ++++++++
 block/io.c                | 17 ++++++++++++-----
 2 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/include/block/block_int.h b/include/block/block_int.h
index 791de6a59c..277e32fe31 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -626,6 +626,14 @@ typedef struct BlockLimits {
      * pwrite_zeroes_alignment. May be 0 if no inherent 32-bit limit */
     int32_t max_pwrite_zeroes;
 
+    /*
+     * Maximum number of bytes that can zeroed at once if flag
+     * BDRV_REQ_NO_FALLBACK specified. Must be multiple of
+     * pwrite_zeroes_alignment.
+     * If 0, max_pwrite_zeroes is used for no-fallback case.
+     */
+    int64_t max_pwrite_zeroes_fast;
+
     /* Optimal alignment for write zeroes requests in bytes. A power
      * of 2 is best but not mandatory.  Must be a multiple of
      * bl.request_alignment, and must be less than max_pwrite_zeroes
diff --git a/block/io.c b/block/io.c
index df8f2a98d4..0af62a53fd 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1774,12 +1774,13 @@ static int coroutine_fn bdrv_co_do_pwrite_zeroes(BlockDriverState *bs,
     bool need_flush = false;
     int head = 0;
     int tail = 0;
-
-    int max_write_zeroes = MIN_NON_ZERO(bs->bl.max_pwrite_zeroes, INT_MAX);
+    int max_write_zeroes;
     int alignment = MAX(bs->bl.pwrite_zeroes_alignment,
                         bs->bl.request_alignment);
     int max_transfer = MIN_NON_ZERO(bs->bl.max_transfer, MAX_BOUNCE_BUFFER);
 
+    assert(alignment % bs->bl.request_alignment == 0);
+
     if (!drv) {
         return -ENOMEDIUM;
     }
@@ -1788,12 +1789,18 @@ static int coroutine_fn bdrv_co_do_pwrite_zeroes(BlockDriverState *bs,
         return -ENOTSUP;
     }
 
-    assert(alignment % bs->bl.request_alignment == 0);
-    head = offset % alignment;
-    tail = (offset + bytes) % alignment;
+    if ((flags & BDRV_REQ_NO_FALLBACK) && bs->bl.max_pwrite_zeroes_fast) {
+        max_write_zeroes = bs->bl.max_pwrite_zeroes_fast;
+    } else {
+        max_write_zeroes = bs->bl.max_pwrite_zeroes;
+    }
+    max_write_zeroes = MIN_NON_ZERO(max_write_zeroes, INT_MAX);
     max_write_zeroes = QEMU_ALIGN_DOWN(max_write_zeroes, alignment);
     assert(max_write_zeroes >= bs->bl.request_alignment);
 
+    head = offset % alignment;
+    tail = (offset + bytes) % alignment;
+
     while (bytes > 0 && !ret) {
         int num = bytes;
 
-- 
2.21.0


