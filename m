Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BAF2C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 19:57:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF54A2075F
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 19:57:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="htZmcJny"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF54A2075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35018 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jb8MG-0002Z2-4I
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 15:57:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56210)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jb8Kj-0000JC-VZ; Tue, 19 May 2020 15:55:25 -0400
Received: from mail-eopbgr60098.outbound.protection.outlook.com
 ([40.107.6.98]:52740 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jb8Kj-0003c9-4t; Tue, 19 May 2020 15:55:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h0+Nbcdd5h5iB7Y66LsTKPn7q4XOW6dJqN5R7t4zvdQbQw3gega3e7EMb/U0rEQ9z2Ov3w/elrToI3+P2oF5XVCHOJTBtj3BcQHo9uPCDOhSojvdBiLgDWB6YcvVDBqc1Dl4Hxd227j9iMhMdLUGPmiEKsSS5pwgxUg5i/FJPpcI7ldF5ZraII2zu45vOBy8c/J78x91dqLP88l9/mrdypikRoPECbMnwfKr1m+dZmMnizQkaQO8GHPSqGIOQMzfOXz/ww5jHguP/RFvVQ1Ww54id+OMi0cUifcOQVQ6G+pauXx04IYSywYEMGUFtTylKs+ZCuv1+1vSbHZfHRI5Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qaOq9bLC8qSvlgOR2+X6jP9wOMjq3QpIjYn4KCeGVb8=;
 b=GII21ya7jF9SxxHwBHDABQN0J3vWS7gt9Mx56m220wL/zRQjb+2ZvxzJrglUeo1dSuG5/FBOMC1pqKYwLDj67iJa1SaJruMdILMC5jCxV+lllZe64H5GVw4Ix0CI9uy8EvXdU96js3E+WYqjLLy0QMu0oJEw7skDV0OitZp3rnhmxWvckxvf53Cexh4jykbxy0YqmvLrXwsx1UrWYyXHG90zaGZ5DvsmPmROFUcG4zwHbFmoV1qxbV8TUVWp8MIqoIhZjAAGwULwkyoq0452En53NxcRCTegbjR7XOTNWxzXDd85frO+ufZzqyjZetV8PDV8NZ6IcHfQ/m76XuNh3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qaOq9bLC8qSvlgOR2+X6jP9wOMjq3QpIjYn4KCeGVb8=;
 b=htZmcJnyWpXWyyyqz0FjO9U6rOkZngLxM3rxcTQrecIyyevVA6NRnywkeC9LL7gNG2HzgSiLejdQjQBw82whUPW4kQLYEl5pnWdCoFkw0dr0Uilu54GwUhun+YFCj59MdDGpgd+5xCJumHP70ZuAWmuLY7XnOYgg/w9p1MO2F/Y=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from VI1PR08MB5503.eurprd08.prod.outlook.com (2603:10a6:803:137::19)
 by VI1PR08MB4542.eurprd08.prod.outlook.com (2603:10a6:803:fa::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.25; Tue, 19 May
 2020 19:55:18 +0000
Received: from VI1PR08MB5503.eurprd08.prod.outlook.com
 ([fe80::2c53:d56b:77ba:8aac]) by VI1PR08MB5503.eurprd08.prod.outlook.com
 ([fe80::2c53:d56b:77ba:8aac%7]) with mapi id 15.20.3000.034; Tue, 19 May 2020
 19:55:18 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 4/5] block/io: fix bdrv_is_allocated_above
Date: Tue, 19 May 2020 22:55:00 +0300
Message-Id: <20200519195501.29071-5-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200519195501.29071-1-vsementsov@virtuozzo.com>
References: <20200519195501.29071-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR06CA0093.eurprd06.prod.outlook.com
 (2603:10a6:208:fa::34) To VI1PR08MB5503.eurprd08.prod.outlook.com
 (2603:10a6:803:137::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (185.215.60.178) by
 AM0PR06CA0093.eurprd06.prod.outlook.com (2603:10a6:208:fa::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3000.20 via Frontend Transport; Tue, 19 May 2020 19:55:17 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.178]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0d4d04f2-d410-4a0b-4df2-08d7fc2e8e14
X-MS-TrafficTypeDiagnostic: VI1PR08MB4542:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR08MB4542B4FAC2ED02FD3EF4BE5BC1B90@VI1PR08MB4542.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 040866B734
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H/GOTG2c0yY6E+xIcZx1UYZ4IpXgzKZlK2tAFfvVwcZIVshE+BqSJ5zhvGPjonGqfW+obifdT0emm/nIP/PyJqeimeQGDgnZDNsbMmJqgOjd5+BRlGW5R+ywE5hl3FFc4gE1V8e2nXK9I7R5QOQabn/n/U8NqzJU5a3byQCvWYcdYbfmo6FwZQxGquDaBvCFW7DNIzy7EZc6BqB8UDuXet/dBUOxR7IV9jHHFshcwA28QUeUynofvrsZO5K5MOFeBBlwTZ+LOIhenwcJm2OqIEj/4N4el+5aA1T6Vhym4djnUMCM3ZKSyKBk1D5KN8WyrDUf5iELPCh5CdmgRhZFz01bNpSIZ560BBc7yAp75D6BDkmNBnDaLPougchXQ1gm2ZWqQv70JUbYDvKOJ/KwwSa7g3YjC8shzC4hWHJdPSIPE2YEj37BaJFbhWPi5xLQl2De3/TNUBOh3qR436WDlYNLyxAOavM9sjN80WAtkpS4GUHlVw4sOQmcBLtb0/v8
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR08MB5503.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(136003)(39840400004)(346002)(366004)(376002)(6512007)(2906002)(69590400007)(5660300002)(52116002)(66946007)(36756003)(6666004)(107886003)(316002)(8676002)(16526019)(956004)(6916009)(186003)(8936002)(26005)(6486002)(86362001)(66556008)(66476007)(6506007)(2616005)(478600001)(4326008)(1076003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: p2kjR/qEoVYYiHHMJcbtwFL3Vwmc3dfDoX8JXKaNUBD3CxUG0aqa7o95wO9ZD/LdA1bgVVjWgsQYQiUJ5OKKqPZ8lWG0GMkFl5D/935g6GW4FOKfZpAuJesxnCYPJHczPjD6oSbvNizd9W7PJBLL+Z3iFEfK4TCaKSGTxXShL43o7P8vtxfmWTMDJO3Eh/+zt2tZVLfgqUqdWNK0VjnU7n183L7tj4SJ6wpJUwEdyAftvEhJSb4kk6Fyun9E2p3yuzhaLGVnlCS0MhiTFblb2DP9VkFxK5uRJxdY8d4vNoXohCVolXQzXKl6Xbmi+4AGnbM7KIIeZF2lRJmEJGw2O+on4N9T9ys5ccD14Qdo0hFCYTyAlm6wVqtyENsgoZPyiRbgIIqPCq7YggHC0r+xMm3DGaMNmR8ZmrsYksaLCMHVfEtCgNyLUEO7VkqKPaVsEJOG85f2GNxVI/mVVMfdoxvKpQDWIcWc2LO1dlcJMSQ8E/LjB5RhW5nY/cH4qiTm
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d4d04f2-d410-4a0b-4df2-08d7fc2e8e14
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2020 19:55:18.0153 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: STtIsBJE8n/ZO22VC74Mn5G25n/KIKJoAYWfUVAFYHwoMtKhfd1LGY4cNMNqnL5oDD3FDB0G5eNk5zMV0mC22/KNPfikadYhRjBHbibghyI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB4542
Received-SPF: pass client-ip=40.107.6.98;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-DB3-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/19 15:55:18
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
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

bdrv_is_allocated_above wrongly handles short backing files: it reports
after-EOF space as UNALLOCATED which is wrong, as on read the data is
generated on the level of short backing file (if all overlays has
unallocated area at that place).

Reusing bdrv_common_block_status_above fixes the issue and unifies code
path.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/io.c | 43 +++++--------------------------------------
 1 file changed, 5 insertions(+), 38 deletions(-)

diff --git a/block/io.c b/block/io.c
index df44e89b7d..61f0930626 100644
--- a/block/io.c
+++ b/block/io.c
@@ -2610,52 +2610,19 @@ int coroutine_fn bdrv_is_allocated(BlockDriverState *bs, int64_t offset,
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
 
 typedef struct BdrvVmstateCo {
-- 
2.21.0


