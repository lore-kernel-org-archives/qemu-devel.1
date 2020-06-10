Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1AB8C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 18:24:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70AC32072E
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 18:24:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="HwSsjNX8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70AC32072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50180 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jj5PA-0004RZ-Mc
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 14:24:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48208)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jj5Nn-00023s-HC; Wed, 10 Jun 2020 14:23:27 -0400
Received: from mail-eopbgr30109.outbound.protection.outlook.com
 ([40.107.3.109]:7846 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jj5Nm-0006OY-PT; Wed, 10 Jun 2020 14:23:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MW2Fbmj8kexIC9b7oyNOiUSCTlzaaKnKX3jBKKKdCEY9JyBX7rQTi8zMq1aFcrL1SV1YbXAmuUhf0jBjVnTS/byRxY2KgXLlHibtuqeKE/d5ZWsOcyBu5m2z+ft2r8E5ZutYK3yTSdtZCsxrtyDdqYTGlms+4WThf+AtHbHwriHUIujO/w0dohwB99QeZdJBFsMd8otPmDwOEs4NzKHx3EKHfN3AbkP5HLpA87nsgO77TegIWp6qS0hOmLO++p/5g04eEBsY/s8ok1+c7SkMAcyvY9DICQxyKHey7YiXFfdij0EqmBXRJfU2uh+2mpDpUea52WJnXXgLwpC7O/LPEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=22avaeLLnRcLu9UcTyT8S1btPLeXV//FNuyxXDx/02Q=;
 b=l5KszkAgEOuZizzxm3+WtQDe3dOqHafGM+tzwXvbZ26BBuvB/R1q2v7t591i83SNg6rBrPcegEaAKj4+Pk/dEnAMjWTwZIfdzayhAACQW9j0+gbQzLun+v4nGErlYbnetwxbL0aDHdhlF178lk9u5JslgHJ1Z0HiOQcEdk7LuCfu1YqKVayWwLlJX5o/MtrkspNPhug6yX5wvimwKscbo06fLMHtXf6m/OrjaQENo4z4bo8kZ2HQ2/t+WG/IkCZfgoETSTMqqA6giDS4We/ER15wQIDuZt2J5p91wT4WGjIo4/p2tPolmz7xNTVQKXIcGIzGjKMckhrHbYhimoeJhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=22avaeLLnRcLu9UcTyT8S1btPLeXV//FNuyxXDx/02Q=;
 b=HwSsjNX8rsiRB9yeiUvW91VZJ6yzcQPI3Fd+qydPceEEzGwzoF1Yr1MRbZNJe8daGj8XTp6rqbZq91JVcQWmgbg6P/pNKNyKHcwZnUn8H+BFBEux6nh4IXgT7iDmI8xXUKdxWfFxgKjzSfRjLezbT23GI6FM7umDTDkDHHLXjHM=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5350.eurprd08.prod.outlook.com (2603:10a6:20b:101::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Wed, 10 Jun
 2020 18:23:20 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3066.023; Wed, 10 Jun 2020
 18:23:20 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v3 3/4] block/io: refactor bdrv_co_do_pwrite_zeroes head
 calculation
Date: Wed, 10 Jun 2020 21:23:04 +0300
Message-Id: <20200610182305.3462-4-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200610182305.3462-1-vsementsov@virtuozzo.com>
References: <20200610182305.3462-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR06CA0138.eurprd06.prod.outlook.com
 (2603:10a6:208:ab::43) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.166) by
 AM0PR06CA0138.eurprd06.prod.outlook.com (2603:10a6:208:ab::43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3088.21 via Frontend Transport; Wed, 10 Jun 2020 18:23:20 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.166]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8842fd28-5c38-4b6c-49e4-08d80d6b5aaa
X-MS-TrafficTypeDiagnostic: AM7PR08MB5350:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB53506AC206F0E197DE12E03DC1830@AM7PR08MB5350.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0430FA5CB7
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E/8ic4IKA9dmkRzJgMDnwg+PKbJVJ1+5LqYP1eZs2b7xdDJ7IQmAL6vJXn7AVmj5/J9ro3tw107ZnvC+SIe9/uZvvPRGXSqQZ2I8AW3ZPdvsqTKIW3kTHQidHsxJSM9BnG0K4EU7KxtOYE7e2yYFFldevvS4YoBU/3oHmDoCy30W08UnQWylPT1HWVvJ2lLEEU2fKD1/oyZQvURxefnmydrlO50l7zauZeExus8qz27dqRRwPv0gbsNc5LPzUIoVxwrmUmY9OuRvdjzNOhV3kxAMJDh96uAYj+w2UvumaG7OYBtMXdc6fncswna5soaD
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(136003)(346002)(39850400004)(396003)(366004)(1076003)(956004)(8676002)(52116002)(8936002)(83380400001)(86362001)(4326008)(2616005)(478600001)(107886003)(6512007)(316002)(186003)(5660300002)(26005)(66946007)(2906002)(66556008)(16526019)(66476007)(6666004)(36756003)(6916009)(6506007)(6486002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: Lh28qlfmg9vGYCtE4Zp9euQgmnvrhcvPsopWKbIn5OQYEN/8kiaFXszWx/8jQu8qsmmUaTt3lUTMZG3cwsgv64ejcXGjAVccSxNIa0a/ytftGn2Imf/Tu+/9xNfFISDVNh3N277VuMZje23jnb5tXShHog1a0qpdl/ffMkzpU/x0/26PZffIMes13PIMn3qGtwaC1Df85a5ab7Vqs81EiRXL/5LW1+OQd14hNR/nApbRjh+USRxAuX4YWOArc+Azwjp/4rd15RU4XEaEOT4OmJnxHmtdblh8pdM+clobY7d7x0vKOKgCgrbllW7LmVfS1UJazrj+maxKQohPVJZhHIvXO0bXThYij0qG30OZssUTXm73fUl0S9YJnl2WhFMv2xiHgGvtUifY16fxP3uaB9d/E0xakccGoKa3dE6c0LyF9V4ORxFiAkoXkyfFxoT5UtL4Jku8R0GqjSSxghQO967cbOeftq9MUQ5xYTaOH94=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8842fd28-5c38-4b6c-49e4-08d80d6b5aaa
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2020 18:23:20.8379 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m/rSKyRoowvbREcJIl9FeDOqOVui2Ys6uLz+P83og2fGqFc82Jtv3GjZMjLTWZQwGgpa68oBNRFd5l1UdBYODAD4zYtWY3JSAjn9XNIS8SI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5350
Received-SPF: pass client-ip=40.107.3.109;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR03-AM5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/10 14:23:19
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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


