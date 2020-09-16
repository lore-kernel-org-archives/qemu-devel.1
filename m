Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8F05C433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 12:37:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C62822225
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 12:37:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="A8QDfnqq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C62822225
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59182 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIWgw-0008Dj-Ar
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 08:37:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34758)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kIWQQ-0004Yj-TT; Wed, 16 Sep 2020 08:20:38 -0400
Received: from mail-vi1eur05on2101.outbound.protection.outlook.com
 ([40.107.21.101]:34273 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kIWQK-0004IB-5M; Wed, 16 Sep 2020 08:20:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XvMNxykX2tMSUXn5+fXaDVhhVteBw4IOQZaUUSYxaAaP+TYRzRVMdfWgpRD0LEmfYu3zQPPiVRvFVmRLBsj5Cts7snxSl3LNpUTt+0+xfSXzBA0Q61f0M9Kbrz3pssVww7dDO+aALdoOyv9eqGE9+o1IW5HtsDHiXf1Sj/k+8pwtIatlvPilB4XGfEIHVfI5FnmO3Y1kZQVQSk1zNRe2BbKDYlnFyiqtwYzYB8QbgsA6fmdyF2KwyG76d/HlEfUUHSWq9o8mpX9oVNG4MFY7bifOT63ENQTLNbgBd+GFDxj5LbAVv3TD8nJXjBtWo4i1dc0PlF9x5sqj6X/riFvcBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zln+dVilZBQzfYEBMdhvqVsUNpWvuzPkRunQgJ15EEg=;
 b=dpd1vt7NWplJN1MrVFTvCQOzEdSjxF5r0WXv1tyh0Xim5Uc2ow9lCk7kgRiCgbtow/I7Z9uud7KWLr75ZJrJAo3R+/cjrGHyo6sUkrIB4kfO6owYjUydc2lEtu7EokVrdI4ohwj+HoKqasculPrpDWPXtrpOcOTWK2e8gRU6/oXouhJRX2WYCAuGZS1o6mcLOPUYxUiWXaSldNScsBzk0RCC0l2gT39s0ulANSRu6gtgonhUdIreji1TD3kot8uN9V/4EVyPS31zvvSyANEJVtxo8fe6gmlX5s21PiFBiqW2Zqa9FtczKDqtZbTp9ZB0LQ2AYPEHO8jQWsUMXU6OWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zln+dVilZBQzfYEBMdhvqVsUNpWvuzPkRunQgJ15EEg=;
 b=A8QDfnqqbCiom/0m7qPHdYVl5yOHIZR7HKvjmYdIzLi/4iU5eATycPHRHCe4oUB9USSaw9hSzhdYdYpU+nkl0C3p+HjUOCtLpAsxYQWNPo/rl1LSuQgu36U7N19SmF3+VK7PYT8O8NXiqfM5WezYTGBToMt9XuiMJq6A7FTvQOU=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4691.eurprd08.prod.outlook.com (2603:10a6:20b:cc::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Wed, 16 Sep
 2020 12:20:26 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692%8]) with mapi id 15.20.3370.019; Wed, 16 Sep 2020
 12:20:26 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, fam@euphon.net, stefanha@redhat.com,
 mreitz@redhat.com, kwolf@redhat.com, eblake@redhat.com, den@openvz.org,
 vsementsov@virtuozzo.com
Subject: [PATCH v6 4/5] block/io: fix bdrv_is_allocated_above
Date: Wed, 16 Sep 2020 15:20:07 +0300
Message-Id: <20200916122008.20303-5-vsementsov@virtuozzo.com>
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
 Transport; Wed, 16 Sep 2020 12:20:25 +0000
X-Mailer: git-send-email 2.21.3
X-Originating-IP: [185.215.60.75]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fa5fdafc-3c77-47c2-a566-08d85a3ae4a3
X-MS-TrafficTypeDiagnostic: AM6PR08MB4691:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB469198D481CD8604425A6E5EC1210@AM6PR08MB4691.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /NG39plXrGQ81uYiKd+Lm+/XXJEhrgDzudkWij68g2vw6WIr9T5HVGdzzESwhAFJexAk5TCMx4FnDtUHCrpV7UJHTW7x8V/qBCwwPJwwfjokFsjGQlXVhAiKIS+83LOxU7oQW4UboGuHW0wIDLdoQMme2ih2ZtY0jUzbg6SnY7H7HCDXDm0bHPByxHCakrXuXR3oYo+JUdBQA4TmvRIaHZzvH+DhUyFba204l2+nSCZ8iW8BR34wxpxnlpX8rYX9Qg3EiCHjAejgvOI7m+34RYahAh28c+uEd155d5KZ3GPwCqNcM08O3WjR2VoxMUHcgVCxC4s+et/P5NkxuRvvkQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39840400004)(366004)(396003)(346002)(376002)(16526019)(66476007)(66556008)(66946007)(86362001)(316002)(2906002)(26005)(186003)(83380400001)(6916009)(52116002)(6506007)(4326008)(8936002)(36756003)(478600001)(6512007)(8676002)(956004)(6666004)(2616005)(5660300002)(1076003)(6486002)(107886003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: jUS8+k3XU7zxXJ/BKoiL6ak9JNXNcp6iGqYd+3VL0MJtjx3ylCr1Gv3Vo19tiMdE+N7ZsE+ubI8I28ME9YjL9mxdCzkQ8k/PgTpIsQQPLLj56uhKE6MfUMEmwzE5YqRgez2gD3nl2r2v8XeRjDIUi1ogdo18FVyWkbqDsEElXVEJknfquBrmN1aMIbcwU8PUUP654xTjV9D9FdWW/0G/OhRJ0OsU2i28zu37mHxmT1HpiX2KiUCiIYo7bfqNd5MfXk4nUYgAhoApPuBBrzgYrX6OJHuHbyXH9LbDgBq2DQZUPa2k2gQrTMq1SfjGtVXPM9SqeWPlZ6DD6ZtvKp2Vew4v9NgDVC+brSzurkoOwLlZxo4oEgRzE3MsBjYAYeFueNfJ7xCfhddNS+EoMtt/2KZTqiVIbYqKg3SwTYT/PBbHDLCe1PyYYPPoJjKV8NEvBL0tnm0mPQ+0x3hq8W+8xJE9J2LJAUsvk7QukKaeN+S8w/3W+8tAqYgl0rVPdSqpWOodFqsOMdnq1p3l3Cv1Rc+tORt56Evq1CpZS+PhYwhsC6tNqkXY8nOlBfi9NesMQkVuspGNXiI5kVKhUTek6/RhgRgQanabUUpEpIQY7ksDhkTk8exiKDwp6CKcZy3R+GZP3HAQ4E7qqQ6Q7FQ99g==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa5fdafc-3c77-47c2-a566-08d85a3ae4a3
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2020 12:20:26.4652 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GVgI+nQvWDDHHCDb8jdeV5K+GFNdhCv2eAiMhRzSH7dUp36DLEYODsAmlFQU2jCQVaSPdVLFpPHYwcNRxAUGcvFclVTYiirpnpVxuKIkXKM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4691
Received-SPF: pass client-ip=40.107.21.101;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 08:20:27
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

bdrv_is_allocated_above wrongly handles short backing files: it reports
after-EOF space as UNALLOCATED which is wrong, as on read the data is
generated on the level of short backing file (if all overlays has
unallocated area at that place).

Reusing bdrv_common_block_status_above fixes the issue and unifies code
path.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 block/io.c | 43 +++++--------------------------------------
 1 file changed, 5 insertions(+), 38 deletions(-)

diff --git a/block/io.c b/block/io.c
index d864d035ac..95b86429ca 100644
--- a/block/io.c
+++ b/block/io.c
@@ -2491,52 +2491,19 @@ int coroutine_fn bdrv_is_allocated(BlockDriverState *bs, int64_t offset,
  * at 'offset + *pnum' may return the same allocation status (in other
  * words, the result is not necessarily the maximum possible range);
  * but 'pnum' will only be 0 when end of file is reached.
- *
  */
 int bdrv_is_allocated_above(BlockDriverState *top,
                             BlockDriverState *base,
                             bool include_base, int64_t offset,
                             int64_t bytes, int64_t *pnum)
 {
-    BlockDriverState *intermediate;
-    int ret;
-    int64_t n = bytes;
-
-    assert(base || !include_base);
-
-    intermediate = top;
-    while (include_base || intermediate != base) {
-        int64_t pnum_inter;
-        int64_t size_inter;
-
-        assert(intermediate);
-        ret = bdrv_is_allocated(intermediate, offset, bytes, &pnum_inter);
-        if (ret < 0) {
-            return ret;
-        }
-        if (ret) {
-            *pnum = pnum_inter;
-            return 1;
-        }
-
-        size_inter = bdrv_getlength(intermediate);
-        if (size_inter < 0) {
-            return size_inter;
-        }
-        if (n > pnum_inter &&
-            (intermediate == top || offset + pnum_inter < size_inter)) {
-            n = pnum_inter;
-        }
-
-        if (intermediate == base) {
-            break;
-        }
-
-        intermediate = backing_bs(intermediate);
+    int ret = bdrv_common_block_status_above(top, base, include_base, false,
+                                             offset, bytes, pnum, NULL, NULL);
+    if (ret < 0) {
+        return ret;
     }
 
-    *pnum = n;
-    return 0;
+    return !!(ret & BDRV_BLOCK_ALLOCATED);
 }
 
 int coroutine_fn
-- 
2.21.3


