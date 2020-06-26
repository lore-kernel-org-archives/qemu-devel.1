Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73743C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 13:08:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4229E2080C
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 13:08:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="oHyYPjnE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4229E2080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33136 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joo5O-0007zR-Fx
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 09:08:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54144)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1joo4c-0006xb-VA; Fri, 26 Jun 2020 09:07:18 -0400
Received: from mail-eopbgr00102.outbound.protection.outlook.com
 ([40.107.0.102]:17390 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1joo4Z-00050Z-0S; Fri, 26 Jun 2020 09:07:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OsnJLLt8fYOXhTMKlH4sjvT7G3SPaPbBWrT2pIjVzfgkCsmBFS03gIWIQGTx7Vt6vsfoq4KIGm5QkieFNkk5PwcJkkue1SyxydSG2bUfMnnikqBQ3pO788bAEQAPdVckJVoVD9SJCjIOUmJVbyPF29qp959irs9l1whougC3gX4U5wNYfBfaC1wcyy2Y017NNyChjpFwJQF7hLSDigUlkz84BgqiF3NlCoq59iBK9ylf5XrsMnP3oEm5vI5xi0kRcuF3i2OWTZlCGdTOUJ3kACJmwfdVP221H6cwxE7rgdW0SkLyog1OoSyDQtFABWhSdJisoj8Ildyie+xVJ5Ertg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FtTFjFYm+QLHKHTZw+Zr8ktkUggwiZRckA8FXw+KpC8=;
 b=AXdI6QbdpeeXgUAFbbpdsCLROhm+uhbdBJMX/G5Q5cOt31/zD0WLdIRpo3EMGbpCpd4Fx846IGHaGnYR+8jHmFYXYclJdTSPh1xyJfNhAwBH07NCdsmpAnhlDUnetXEwDliIB/RNKJQQkVyO/oZCIxzLunoJTUPGqCEHPEy2PAtR2i1aZb1fO7bg9Y7vaTd0UeNE7Yn9Aog3q0ZXmIpN0pc28UNJkslj6jAEX6K+R2AHwKyq182ju5j21uwmXH3mCp1bHzcmJc7pB6X9juMVjyx+cnzlfPDebUTbIN3DVq2wIXlTk92SySbnOqekvXZ15DZ726o44AjdDek3ElEy4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FtTFjFYm+QLHKHTZw+Zr8ktkUggwiZRckA8FXw+KpC8=;
 b=oHyYPjnEnEOJObt8wAELsNiNz/5KoDIZ4Bj6bn68rUUmtWixA8foQoGYuZJXigIC7faSnWpObPzsf8FQOc9gIsOjEH6c/1zh3Jpq6aUKd+j2W8jUKirtUxWmoIjg77omXGpoPIjEeWOfVdueufOYPmZdKvqDxMUEBLgZejJBUA0=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB3767.eurprd08.prod.outlook.com (2603:10a6:20b:84::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21; Fri, 26 Jun
 2020 13:07:10 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%4]) with mapi id 15.20.3131.025; Fri, 26 Jun 2020
 13:07:10 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH] migration/block-dirty-bitmap: fix add_bitmaps_to_list
Date: Fri, 26 Jun 2020 16:06:58 +0300
Message-Id: <20200626130658.76498-1-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.18.0
Content-Type: text/plain
X-ClientProxiedBy: AM0PR01CA0177.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:aa::46) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.17) by
 AM0PR01CA0177.eurprd01.prod.exchangelabs.com (2603:10a6:208:aa::46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21 via Frontend
 Transport; Fri, 26 Jun 2020 13:07:10 +0000
X-Mailer: git-send-email 2.18.0
X-Originating-IP: [185.215.60.17]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 13186761-18e3-4ffd-5c1a-08d819d1d63f
X-MS-TrafficTypeDiagnostic: AM6PR08MB3767:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB37671F161726C6CC283C3368C1930@AM6PR08MB3767.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:52;
X-Forefront-PRVS: 0446F0FCE1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Yh2yztjSBMHstTWyJmdwU92MLmWOP5YdQTuP0OJNL98cdq3uEVV20sovUT8s8Ht7qXoCRyvWfoWGUrApW7dYKQgSJltpIPrOfE5X3mu4SWRzNgS4Od+22opNAdScJCkARacFAx7fRh5tyhrF24IKDqRScagpqv/eX4iVLkqICPgLiMNmy9GyaPgcej1z6Sc+B6Kx0JhjbQcjPDeqgWIyQo5cAPhfxpxVU1MZ5dymotfRL2qxeX/02NkxFo/wnWk/tdHJWbM91kvwtqzlZDvU3Yazm6+lioezr08Q0srwENAGdsny6FbzLzKKsyFrGUxIJKU/bx28XVzjOO54c09+p6YTEnPouxzGwnMTPnaBeZpG9WNzpLazMBl6Tb++eA87
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(376002)(396003)(366004)(346002)(39840400004)(83380400001)(956004)(316002)(2616005)(86362001)(26005)(186003)(16526019)(6506007)(8936002)(52116002)(8676002)(5660300002)(478600001)(36756003)(66476007)(2906002)(66946007)(66556008)(1076003)(6512007)(4326008)(4744005)(6486002)(6666004)(6916009)(14143004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: CB0MtV3xFWjolcz2gC+S0xGKpEEAxtxChDWRB7A4O0Yxn7UN3ZtUjkh8dddpDbHVpWW7HYE1zCQJyMRss4VvvFnZu2ZV7BiJSZa4gaxD0yMFsFit1rjFXSPpSAjvtXtHXPaIEel8RGcrkwPGLQQyKom1427QwNDnpScqSWiqMRIeM0wXYrPH/lkbDl9KPTsoTH3A4xIE8TzfOJtC0xHIYObFn9HrwJF/cxsC1m2xbCSC0HHiAzxGN5LbrJU/+Q2pMzENAeLi0z7pOobkbN6AbvqUyYXXfFtxVSn+xGw4uGLLNrQSD9s/kOX3TlMj1sDQm1ttDW6WZoL6l4MIeBzhKW68+12K4JjR3XjVGXkvCg/ux/WBNtgIO8ZeDnEVET8RGj+O3jv/994zIeTSlly68J04MsigV8B2UblUV7wKMItEQxDYQpcMaCbCuAX7xpw1OEw4yxC1VHltK+Y9ZQbV7WY9PY2x0QrSCeEJhI85+GEQDdPTSH9N2+FC9Wzgpm12
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13186761-18e3-4ffd-5c1a-08d819d1d63f
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2020 13:07:10.7794 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l0E+pnQy/Vf9yeeCj0L4THo1uGDiZsvvHnMuwaxMEf6nMZ6fxxB/tDBS+o7Bl3LzVkV2SqTeZFSvZy8uaP/EaMztjH141yCi7qrvTyWc8wk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3767
Received-SPF: pass client-ip=40.107.0.102;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR02-AM5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/26 09:07:11
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
Cc: fam@euphon.net, vsementsov@virtuozzo.com, quintela@redhat.com,
 qemu-devel@nongnu.org, dgilbert@redhat.com, stefanha@redhat.com,
 jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We shouldn't fail, if found unnamed bitmap in a unnamed node or node
with auto-generated node name, as bitmap migration ignores such bitmaps
at all.

Fixes: 82640edb88faa
Fixes: 4ff5cc121b089
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 migration/block-dirty-bitmap.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitmap.c
index 47bc0f650c..b0dbf9eeed 100644
--- a/migration/block-dirty-bitmap.c
+++ b/migration/block-dirty-bitmap.c
@@ -274,7 +274,11 @@ static int add_bitmaps_to_list(BlockDriverState *bs, const char *bs_name)
     DirtyBitmapMigBitmapState *dbms;
     Error *local_err = NULL;
 
-    bitmap = bdrv_dirty_bitmap_first(bs);
+    FOR_EACH_DIRTY_BITMAP(bs, bitmap) {
+        if (bdrv_dirty_bitmap_name(bitmap)) {
+            break;
+        }
+    }
     if (!bitmap) {
         return 0;
     }
-- 
2.18.0


