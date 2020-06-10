Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4261FC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 12:21:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07C7120691
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 12:21:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="NBZCxdUf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07C7120691
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60092 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jizj7-0004Ar-7r
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 08:21:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44778)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jizTP-0000Gf-4w; Wed, 10 Jun 2020 08:04:51 -0400
Received: from mail-eopbgr150135.outbound.protection.outlook.com
 ([40.107.15.135]:4365 helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jizTO-0004Tg-8y; Wed, 10 Jun 2020 08:04:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OmGpU7Z5J6wB2ZwUjnn25wulPw6eeynqURWY6LCTGrh2XpZJbqM+Mjw1NP0e/gtOzm5/LVLRkYwYAW8NZH4ZgyPetk1uQYxj5TI8DPgezOqC1wML55Z1HkTdlkU3DIyxqJdU6S2uc+GT7+iNnl2VZmKAhtaWlSVIa5alJmUq6TAu0FhJ4sD8G9tM5ft43OBY5XPTfY6uJ0tJd3TMhLrEm7tbhObqYUgWbroGodtW4Y8QiuOBYvUVnPKfvhly/8KO+1c1UW68xXob8Q0kxD4CQF0aHgY07nGXgbkTYLdJhf6EuOJo5N87WPBtlppeCLmieuf8X0M7LbX98/EBDz9o8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zRC+ippozJvApTVRDLqVrvOKBZe4mAelAVlibzaAcx4=;
 b=Dq7tGxxSRiKRPGJDLSgt2JOY5M3+MviKtqZyKMLfktJCYA0FyBchTN+Xr6TABKIj06iDTCyOipTQuTz3uV8In7f2+QBwlfVE6nMOcXPLJktpAOYffMZ/Kpwc1nGrxzQQICPNT5+UwGgvBD7iq8MWupkfKAVTu8u+hhLdt4mNS+NwJNJ2ZDPW3wOVYaOcZqMGwKKuB2bd54yK8JuQjwyjiqzu/spIAHnzpOee0rwJ3F/xBj7BP38mpAPemB6q05IJWYdEjxcuhgiHnAyCukGMKcNPIkauMRX1+1SCmXAojmwiQpfUfAaaXaZGOoJUWbsvkRtcS0m2unp43Msckjq/iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zRC+ippozJvApTVRDLqVrvOKBZe4mAelAVlibzaAcx4=;
 b=NBZCxdUfQpkYSb5aAI619hz1f4iTt2uzgon6coAv25xcsNJTcwv/IL3U4Q912QNe87UIpoJi5SWG2JmQNo9e2s9c9mCbO/gERpXEAuPRZDNFQmSXXUkVxfiIG+/btqYou8ud1joNpxTZfdc12tqRaP/ArKLBLeUc+Y5bowelq3A=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5495.eurprd08.prod.outlook.com (2603:10a6:20b:104::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Wed, 10 Jun
 2020 12:04:44 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3066.023; Wed, 10 Jun 2020
 12:04:44 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v5 3/5] block/io: bdrv_common_block_status_above: support bs
 == base
Date: Wed, 10 Jun 2020 15:04:24 +0300
Message-Id: <20200610120426.12826-4-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200610120426.12826-1-vsementsov@virtuozzo.com>
References: <20200610120426.12826-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM3PR05CA0104.eurprd05.prod.outlook.com
 (2603:10a6:207:1::30) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.166) by
 AM3PR05CA0104.eurprd05.prod.outlook.com (2603:10a6:207:1::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3088.18 via Frontend Transport; Wed, 10 Jun 2020 12:04:43 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.166]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cc002415-ffe5-4e89-2394-08d80d36767f
X-MS-TrafficTypeDiagnostic: AM7PR08MB5495:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB549584BF16B785CFD215027CC1830@AM7PR08MB5495.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1417;
X-Forefront-PRVS: 0430FA5CB7
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zUGhrfJVUH5pufSd5wUub4IXDuNhOJNrJxFHX4gAfmcOCoJB2w7fD+bG79F5M9OFAB8AZDhRSIbslHSdlFuuFeelDANKUIFqt/kH7ZW7halmZZEgUXoFW3HAo2yJh2ByOGIM17E/tEmnnqSAPeKNkB4zq5S+TYAMZX0nRybhYT5TVdtVYlf1KU7Pyd7obLbLm090nUrhOIt+88SuGWTgmZXLVTDWRTAyYMf8bHEKGDc6Orvcj3tiZM+uhKpi2b1uJmsTPArrAB2V8BQIHFL6lM7DBPp4676TXg46gJQqED3mceNKhFAUxOV9Sc59ZLKkQ/U6n6bxGI/MOQf5cPaYdw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(376002)(346002)(396003)(39840400004)(366004)(86362001)(8676002)(478600001)(2616005)(107886003)(8936002)(4326008)(956004)(52116002)(83380400001)(4744005)(1076003)(36756003)(66476007)(5660300002)(6506007)(2906002)(316002)(26005)(6666004)(66946007)(16526019)(6486002)(66556008)(6512007)(6916009)(186003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: yrCIwxSnsZdGK1u9XC5NoFM4cDPeo5PYHKF24UMzTUr+/+66S4dngEqsr46StZt71DvSTtimHvos7c7q77ABGgDahTOvpyLIZeIb0Bo8YW1Cq2qrAGSFJ0oVcHfyFX+VicVT2xzHd8a4UVy8RRLcaMIByyVERveVP4zVpWxabzPKMaKZo+/3JDYJwOaLn15iwQlE5DQur708NBkabTUgKvA08/A0ADPXb34vHhgbnPcNBLFOWW+lGF9F9fCFhH7o5FmGJge73rP5F4m1ycDzId2zQfNmlgD0UT6ZcjO9nv6d9d+GWSKg7eDl7MvSakLjmf5vre2KSre+szj5girC6qB2eE7HzSWqlEOff/XSPjAKI+cSIWzCEBfYPpSreZtBqN1ZvTmEqZM4rTUPK90Juy8QKasZNxKzuhJxL/d6ighYwqPY0I5UxcIGp5fKHBlO/vKtfDyNxOBEXK4Kq4AmpKIZ1cGrs9ZG9MqWjEsRhpl9uwmcq6o8w3413vSLCBu9
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc002415-ffe5-4e89-2394-08d80d36767f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2020 12:04:44.2584 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S73wvdGOvJTgsEp6C58IU60p3g1oHAWANrT9JEpyY3i8mXca/JQZrX5gmGu5Ra9oqDandE5Gz9Ejeyv+5izUQUvznwk6nE8fKUUwUQDAKhg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5495
Received-SPF: pass client-ip=40.107.15.135;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR01-DB5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/10 08:04:42
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: fam@euphon.net, kwolf@redhat.com, vsementsov@virtuozzo.com,
 qemu-devel@nongnu.org, mreitz@redhat.com, stefanha@redhat.com, den@openvz.org
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
---
 block/io.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/block/io.c b/block/io.c
index c3ef387f7e..3df3a5b8ee 100644
--- a/block/io.c
+++ b/block/io.c
@@ -2369,7 +2369,11 @@ bdrv_co_common_block_status_above(BlockDriverState *bs,
     int ret = 0;
     bool first = true;
 
-    assert(include_base || bs != base);
+    if (!include_base && bs == base) {
+        *pnum = bytes;
+        return 0;
+    }
+
     for (p = bs; include_base || p != base; p = backing_bs(p)) {
         ret = bdrv_co_block_status(p, want_zero, offset, bytes, pnum, map,
                                    file);
-- 
2.21.0


