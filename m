Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0708C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 18:27:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9E5A20656
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 18:27:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="FkJHvuPd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9E5A20656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57160 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jj5Rx-0007av-19
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 14:27:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48214)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jj5No-00026K-RB; Wed, 10 Jun 2020 14:23:28 -0400
Received: from mail-eopbgr30109.outbound.protection.outlook.com
 ([40.107.3.109]:7846 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jj5No-0006OY-1i; Wed, 10 Jun 2020 14:23:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l1nF8LH47j16wqBikX67E+M6hz+BxBdhsSKsanSnOJ1E0qsGNs7531irS51oqZyJL9D0KwWQzkY41lLARpDAaf3tXGzZq7nU9ro7qda7+I7RApf2AMv4nTy0DDXmUDJ4IYxk66eV30ebidSl+NxKJQiftOwLBBp/0RG4Ib9T9c2IxvVqr78RuileHbbxYTW8s+/RNGbBo5YZadmZV+yTBgkcxRpir798gLviF/ejZd27dMrzOYgOzRXbfq0Rrk/hpDJO2XBGAaEEOLqL1FDr/YjpmA9i8TR8ISQMjRrWseh01Y1CfVG7GKaC+1R+7RM3BjaZHvVSQw5SA6zJNA18Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=peKo/CsEmyV7SKMrRVYNRaDGKEUjIuK8zHqtEPa9Cvg=;
 b=aRwrWFvSeBh+RvXLegvyuhCwSK0GeqTDvev/1SkMEciArCH7Iij5igwLNnZYXsUr3z+fn7VXB0+LIFMIQ18st4JOFcWfigl+O7foyaA7aPb/iziSWgXYUDBK0QXEpS+JbNs8MpdUEzeAuiLlbcp+Q6j579oUjaFkyUgHM3jM1mmsscyEBl1w3W4LQpAtjItn0FwiZCMuJo2NTMJfsAGhpph1Ga7d+DdEUQeVWTaTP+QK9toPnMX74yHJIgf/zIJ/1KqELMYD6wrqzdUliF6bielZcMrV6BWklFkRVeFmNPpl8YwHLYmVWTit8bb63s/AEtDVj6YASiJGk9tXU1fr2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=peKo/CsEmyV7SKMrRVYNRaDGKEUjIuK8zHqtEPa9Cvg=;
 b=FkJHvuPdMTifK6z3BjIDoHqhQZbvMUnEBVXwRg8hC883JuQHIlHnqzvomXlRgiuael5LWGef0vNqI7r1nHhVXgTEeuG/tfOI9/iGmZHQg89KqEn3hoODWZJD828kQ8mMHJILaULGkKJRxSDvd2bt/QWE2JEFLAnEBcsiyD53K40=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5350.eurprd08.prod.outlook.com (2603:10a6:20b:101::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Wed, 10 Jun
 2020 18:23:21 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3066.023; Wed, 10 Jun 2020
 18:23:21 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v3 4/4] block/io: auto-no-fallback for write-zeroes
Date: Wed, 10 Jun 2020 21:23:05 +0300
Message-Id: <20200610182305.3462-5-vsementsov@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: a94707e2-bc16-4822-dff9-08d80d6b5b2b
X-MS-TrafficTypeDiagnostic: AM7PR08MB5350:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB535068AB020DA62915B82AB9C1830@AM7PR08MB5350.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:381;
X-Forefront-PRVS: 0430FA5CB7
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8Ii2WXcmBP7l4PW6JVJIzx70O9vrnWXPHcGMEcQnF9zWNyrbDU0i8/WKidTG+v5c9NKcwUEbbPMeUDDGlirgw9v2aB2sQt+Z0Sq6FYpWFtIBhPNGaXPNqLWyrpw3aAm433Ae2V9Jf9Z3bxLXJouCpSocxAFnScq/OgCzR257eZixaEBYd5fobJBVR0cZQ7nBAoTvkf64P4RrZVB3+POISMzlXYz1vxtq4o3TEtTIvMOHwferLQUVXp4veLzHBBy69cNe4swl4ddThSALWkcsPmtlfZ/nVOk2GBZ7QIF48mIJHUa/AxnFNsQk328hLStRuh4r8v1bONCTPLhIuHoHqg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(136003)(346002)(39850400004)(396003)(366004)(1076003)(956004)(8676002)(52116002)(8936002)(83380400001)(86362001)(4326008)(2616005)(478600001)(107886003)(6512007)(316002)(186003)(5660300002)(26005)(66946007)(2906002)(66556008)(16526019)(66476007)(6666004)(36756003)(6916009)(6506007)(6486002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: p9Jo6/BXAip1CKl6TIRa91GFf2rZZiq/26oAu9iojfEU9sRAWFAEivo4QNGAc5wC7e7o3gDAd7Y0j6t3VemjjV+IRalY8SXcX15OQsBWd72IdQw+AAgwJbyudqaQl5IbshQD8VXqhT+x9i9pD2G02hJfpyr5blvUSmAL1JvR2c6EyiEUQwQ8jg1xAz0mz0J/lYKVlZBb88gcpTKbR8cjegLMxfq5+Ktml3NkEbyreBQndNURKBpDuZVRRBbfVn/wRcE/claWuJc4LeI/EnDmnq6zZtuZvQ+zHiaZmEMhkXw6gYUnDKMn1DV333A6PHaqyODw0u0DZ4FFa5hHAPGiH+GfRHv14n2p55egp1kPtc/CCCweGYgVPwXJ4ly3nkNzD6POeQxkSi1Zbmtm0wAZb8J6/m2jr5ISiMsO517WWDY4jXHHFwenRAjQwJJxnESJOBPKGl/qy1sK9PxXI58qAYfVeuLCi1dkwyri8vqKuOk=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a94707e2-bc16-4822-dff9-08d80d6b5b2b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2020 18:23:21.6353 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GshKsdKAP5cbhL0+TRaW/76XTZ3NwqBW3m6x4xvftxYpqJCRUgq655ry4JU2kFu8gJwvbjKFQHP9qhB0IWpSST4g9hUFmmtvgVkoetUASgo=
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

When BDRV_REQ_NO_FALLBACK is supported, the NBD driver supports a
larger request size.  Add code to try large zero requests with a
NO_FALLBACK request prior to having to split a request into chunks
according to max_pwrite_zeroes.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/io.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/block/io.c b/block/io.c
index 3fae97da2d..9a6dabb595 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1778,6 +1778,7 @@ static int coroutine_fn bdrv_co_do_pwrite_zeroes(BlockDriverState *bs,
     int alignment = MAX(bs->bl.pwrite_zeroes_alignment,
                         bs->bl.request_alignment);
     int max_transfer = MIN_NON_ZERO(bs->bl.max_transfer, MAX_BOUNCE_BUFFER);
+    bool auto_no_fallback;
 
     assert(alignment % bs->bl.request_alignment == 0);
 
@@ -1785,6 +1786,16 @@ static int coroutine_fn bdrv_co_do_pwrite_zeroes(BlockDriverState *bs,
         return -ENOMEDIUM;
     }
 
+    if (!(flags & BDRV_REQ_NO_FALLBACK) &&
+        (bs->supported_zero_flags & BDRV_REQ_NO_FALLBACK) &&
+        bs->bl.max_pwrite_zeroes && bs->bl.max_pwrite_zeroes < bytes &&
+        bs->bl.max_pwrite_zeroes < bs->bl.max_pwrite_zeroes_fast)
+    {
+        assert(drv->bdrv_co_pwrite_zeroes);
+        flags |= BDRV_REQ_NO_FALLBACK;
+        auto_no_fallback = true;
+    }
+
     if ((flags & ~bs->supported_zero_flags) & BDRV_REQ_NO_FALLBACK) {
         return -ENOTSUP;
     }
@@ -1829,6 +1840,13 @@ static int coroutine_fn bdrv_co_do_pwrite_zeroes(BlockDriverState *bs,
         if (drv->bdrv_co_pwrite_zeroes) {
             ret = drv->bdrv_co_pwrite_zeroes(bs, offset, num,
                                              flags & bs->supported_zero_flags);
+            if (ret == -ENOTSUP && auto_no_fallback) {
+                flags &= ~BDRV_REQ_NO_FALLBACK;
+                max_write_zeroes =
+                    QEMU_ALIGN_DOWN(MIN_NON_ZERO(bs->bl.max_pwrite_zeroes,
+                                                 INT_MAX), alignment);
+                continue;
+            }
             if (ret != -ENOTSUP && (flags & BDRV_REQ_FUA) &&
                 !(bs->supported_zero_flags & BDRV_REQ_FUA)) {
                 need_flush = true;
-- 
2.21.0


