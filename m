Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCD35C4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 19:47:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FEEB2220C
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 19:47:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="m53LeD6L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FEEB2220C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35418 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLXDN-00080h-B9
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 15:47:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53214)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kLX6Q-0002De-Dd; Thu, 24 Sep 2020 15:40:26 -0400
Received: from mail-eopbgr30093.outbound.protection.outlook.com
 ([40.107.3.93]:8707 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kLX6O-00085Q-Kv; Thu, 24 Sep 2020 15:40:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fCWZVN2xxD/ggOsyCkZJpyAA8KINACGVCTaZDFksLhOglcRVd5D4uy21Jo8zYu+lBqLKmKkg9BX9EA1o58ia9GP3ytLmw5/FyMjoDL7N+eIrpsfuuVEcRMm/ZuFVQL5ZNWGT70j9mV8PltAypAM6BVgsyoihhe7N26hqn2vBoht6bfMTmPuDxTJkxU5+qf3UBE+ag6MLQ/L3W83Yh+diESNKQwPzQQh7o9W0r2nCwT/GeKSdCciEUQN6HhWLZ8Kiq1Kk3zcz32RI1nvcWFxdlaVibBqFVkdCoupcfSOrASXuvhM1pejPmzGSsRGE6gdht3MBQxkeaWG1ciHmfX/8QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5132FUDEOt4Ku2kTboJY3laAYqCd3DLn1Het1veGTj8=;
 b=d3dwzdHbTlz1Ypc0rIKTVOK2842QF6IKqbRNuVlH5eH6n+aANciOaT7vASgfauya2GnAHp234nICOFSfD+IUSsqhr2YGuZKHvE7ASUigIz8QYwKrCIIiWRLUtJXzAbXkEVJstJMsZ/2vDNKdxOdStMIOmgpqLqF5DFKw/sV7wgPx2cQQQipgpmJSo2Fn7ZP2vnFhtAlgLn3gGukQ4Rh69Cwn8LcOYQ+LFWr2XKnBKvHwdz2rb616215ZbSnpjbG1EK7WMLwXv/W/WNZpasuKjngyNhy1mrYYEc9aPsMLKZdBft/Sozz4yZTnyGbY+zdnOZi+neU/0Kpw0MybMCPrkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5132FUDEOt4Ku2kTboJY3laAYqCd3DLn1Het1veGTj8=;
 b=m53LeD6LVP7nS7FQftGEd0eZB1s9kS+FGkNpantLbejXCkA1XVshlt+ZQZ89t6de865q03bRKg71gGI9pw0UUOOzJ6LsZjXGxzFjubRS+Bi8i9GFFIj5uZNOmKlOf+AhK/G+ESx1c8Sf3x0uOMi+3a3Xh4xwvj8BNFmsxkC9yZY=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB3288.eurprd08.prod.outlook.com (2603:10a6:209:47::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.22; Thu, 24 Sep
 2020 19:40:17 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692%8]) with mapi id 15.20.3370.033; Thu, 24 Sep 2020
 19:40:17 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, fam@euphon.net, stefanha@redhat.com,
 mreitz@redhat.com, kwolf@redhat.com, den@openvz.org,
 vsementsov@virtuozzo.com, eblake@redhat.com,
 Alberto Garcia <berto@igalia.com>
Subject: [PATCH v7 3/5] block/io: bdrv_common_block_status_above: support bs
 == base
Date: Thu, 24 Sep 2020 22:40:01 +0300
Message-Id: <20200924194003.22080-4-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200924194003.22080-1-vsementsov@virtuozzo.com>
References: <20200924194003.22080-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM3PR07CA0112.eurprd07.prod.outlook.com
 (2603:10a6:207:7::22) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.94) by
 AM3PR07CA0112.eurprd07.prod.outlook.com (2603:10a6:207:7::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3433.14 via Frontend Transport; Thu, 24 Sep 2020 19:40:16 +0000
X-Mailer: git-send-email 2.21.3
X-Originating-IP: [185.215.60.94]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8515d962-2476-4720-c2c3-08d860c1a9fe
X-MS-TrafficTypeDiagnostic: AM6PR08MB3288:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB3288F060DFFBC637F3FAFF10C1390@AM6PR08MB3288.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1417;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LeSaHP3eimf13EIUGyKzfk3aQMNQZG5AN/pz0F0DoXGpVcKSUaKYgVg0XjQbvEIbVMoUCJML+RxRgJfKMOh1ePfkvgIF0EKZuafcvdwg0BEQBqJaadVq13itLiUu9J6LQTwzVxPkiD+O3tPefAhEDhJ9qJuXHlCaqeMNjr0CEX20hGfmxc5TahXdBgsCqCawfI6yIJ0fNcAq6VwpRLqGfUakUxxjcIwHXSA1EuwcIKAQoD7Q9Vz0R8ta6JG1qJ/YTZGv9xqy0nPE8R7HdtcJUDSy0KAmXML5ZPuksNklMVqPe9PBStdd5jOXUsGTF9JwzisggysJNPjH9UMs4v06cA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39840400004)(376002)(366004)(396003)(346002)(136003)(8676002)(66946007)(5660300002)(6916009)(8936002)(1076003)(26005)(66476007)(52116002)(478600001)(66556008)(4326008)(6666004)(186003)(6506007)(16526019)(6486002)(2616005)(6512007)(2906002)(36756003)(956004)(86362001)(83380400001)(316002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: UFLrdMk2+Ie61urX2EuRdYZ6Nt0GAfrEx3iLfmcCkHVckBfiiZ05kqnPbs/WXMU2Ku60NovwWv75f8eNJa0dE2vuyBnDQnryoJZgL4KEjjfCQJD9t1b8yfbyqug1gx/hzyPpy4hoD++VUm/gXdhvGBCB39L8ztcvO7nUQ3aM+HVKKIS7+d+DZOhIjkSRhL+9COLr9xVBAWBfPM5v+Nd74gfbSUrln3UuQle3hH6wa2x2CAgcIa6Z8sYW8J2lmmV1bo7tSby+zZ+wxhJ5KdVcMvKrRcMk6wQgEnLnZAN6X2CEZyU78RE4f/1HLvAI4efZFuR057af/vvCHbaWNA1EtFKRbx1BGJX0XOzRzrY1vLfKwgCVBuRpcfBr8B+MhRcmGgXJ4r6vv3TH36hb34fdky31KvkF46POKvPUwdT29Jr7Aec7FFR6vAq21/BNg5rX/gWfq4f2f/6IEYnKjjOoLId3sEzlG9T0BqysuxQpQo01bIwrT+WhU1zZ05DIQX8cEZ0EvI3STG7Q8fXUs1F0O6IOl33uJKhfhBqDb1MUjL13rfBlW68U3vwOa4JF0XcXTe5dEzejTx/0ZU8YwkXSCqyr8xZ4MHxRBBtWF8lM5zkgHSRAJZSzXogRGrJTynhfiBDM5a/ZVETBaegnrvR/FA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8515d962-2476-4720-c2c3-08d860c1a9fe
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2020 19:40:17.1219 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +92eS/3EG8MHl2A44qtEP4XjrStYSlr8bcFdOtl9aMFcBj7wcDuB39vBZeDSLu4iGXAliboWn6iJhTui2BsUFqSkBlIKBXQKHy9+Ez6FwSc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3288
Received-SPF: pass client-ip=40.107.3.93;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR03-AM5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/24 15:40:15
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

We are going to reuse bdrv_common_block_status_above in
bdrv_is_allocated_above. bdrv_is_allocated_above may be called with
include_base == false and still bs == base (for ex. from img_rebase()).

So, support this corner case.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
---
 block/io.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/block/io.c b/block/io.c
index b88c7a6314..82a3afa3dc 100644
--- a/block/io.c
+++ b/block/io.c
@@ -2355,9 +2355,13 @@ bdrv_co_common_block_status_above(BlockDriverState *bs,
     BlockDriverState *p;
     int64_t eof = 0;
 
-    assert(include_base || bs != base);
     assert(!include_base || base); /* Can't include NULL base */
 
+    if (!include_base && bs == base) {
+        *pnum = bytes;
+        return 0;
+    }
+
     ret = bdrv_co_block_status(bs, want_zero, offset, bytes, pnum, map, file);
     if (ret < 0 || *pnum == 0 || ret & BDRV_BLOCK_ALLOCATED || bs == base) {
         return ret;
-- 
2.21.3


