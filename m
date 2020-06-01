Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 166FDC433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 18:13:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA5F920776
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 18:13:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="j1yyaMNW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA5F920776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfovl-0006s3-0e
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 14:13:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37664)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jfouR-0004nI-G2; Mon, 01 Jun 2020 14:11:39 -0400
Received: from mail-eopbgr70093.outbound.protection.outlook.com
 ([40.107.7.93]:39047 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jfouQ-00026c-OL; Mon, 01 Jun 2020 14:11:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h+t5KfniMETPi1ayaxrRUHTvCn3oeVKGzFXLT9RfYkFM7P22NV4VET2H+D/U+b8zMrU8KD1kJJN7M7C898GGKOuve252P3q/4crkEvGKzoG39/oGlRotijGQJdsBAp6f1oMre/OVOTu2HtXogYSqQ0r1kMRUe+RO3g7dRYp05kzPJDZLx9QTkCGC0GSIku3Q+W/mqVSWuhZMIUYG5kWNI7xc/qf+Rb+tMMI0gXXmLx//vRJr9SV3VACUyUW3av8h66qUqzfywyBJEMjE1hCCM6+c5uSX9fD359vAPhFHsOmE515MrN4d1fwZ0qPct6EnRchn1JVd5Ki/YeygiDT4WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k3AiKf4IdqJuJVI4XnnAK3JP1HTdcTOI5m8XjztJ7fQ=;
 b=fyMaa5xKDhhvJGKrR0+gQSLh7wOP0Dmg6oM+whyRbTQxyGquj9YmLq88xjwvwaVSkNkkav10Xl16KbxZCKQpvIjocUyNb6Ys5X3aqA0MKcd2rrxegOy4Wo3xsGmbKBdV3igvKjzxkSAezVIX/24odFBAHVY4gtZSksDom3RJJ0zGbuurhYTkcXFWVBLufNKIBX5xdEO1k7YgZLoUMr4qdxCPOBwM8Ur9uDic42bfeuYYuntDBbxEqM76NHOa/gU4ZLq1xyTBnbaNmSh+kAUZpG11dB0s0lCRumcMIFMIdmkdV3DQW1aKSN2qbHarujJ80n3ytFeutdSj0/AjwrJnBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k3AiKf4IdqJuJVI4XnnAK3JP1HTdcTOI5m8XjztJ7fQ=;
 b=j1yyaMNW8gzVEiR6Z+dxy+N+RibYO/hYfhoA5GmrM7NwDeRdL3KwLtCb1QAttZNUqJ2di5w+oD1ins51bewx/Sr3tA2ThMgZUgS9hMg4A5UMLR1GzzCGQag9AJLfbCZfr5gpLSD8Jj/GAW9w0NL9ElLTUS464k0JMOmfWOJBADc=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5317.eurprd08.prod.outlook.com (2603:10a6:20b:101::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.19; Mon, 1 Jun
 2020 18:11:32 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%4]) with mapi id 15.20.3045.024; Mon, 1 Jun 2020
 18:11:32 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 01/20] block/block-copy: block_copy_dirty_clusters: fix
 failure check
Date: Mon,  1 Jun 2020 21:10:59 +0300
Message-Id: <20200601181118.579-2-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200601181118.579-1-vsementsov@virtuozzo.com>
References: <20200601181118.579-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0P190CA0028.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::38) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (185.215.60.170) by
 AM0P190CA0028.EURP190.PROD.OUTLOOK.COM (2603:10a6:208:190::38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3045.18 via Frontend Transport; Mon, 1 Jun 2020 18:11:31 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.170]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0af8347d-9b2f-4c10-588b-08d806573688
X-MS-TrafficTypeDiagnostic: AM7PR08MB5317:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5317A3A1A77EF753AA49BBCDC18A0@AM7PR08MB5317.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-Forefront-PRVS: 0421BF7135
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +DehiY1v2FqMcSWtxbFUbISiCkOPQ2tyy8t6MmXH42glOcv/yG6alEBVHuiq9ys/XcLBodmDvgRfKyAGgoOLSimy8TTQGPE4HkXUtjQWsv23fr222E+kpKhXx0H91nZpra5JKqAHVoDAUs6F93ixEO7idbcJcjcgqBV5A+pshBxNFuaKif5i6VyIQ2KcYr4Rp5VGBa22nA8BNSrkFaD3mQHPbeoTS05MhqqtBYTvHUbnNXnPj42GrojQmV3h8ZPttZ/6OTnn5ijsp4tGpOYqHelwYbg6dKjkHBgYl7OVqGzxk7fDLRY/G48TSOmgALfnU15ha20vjEdh+ZKy0/I62DE94kROGMIkbKHf7ddmAV0BoSXmMcdp3N44UvLLQ/Q/0g7JSOfOXeIBMikcQI5nUil3sV9pZRbjIPtvI7ugPD8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(376002)(39840400004)(346002)(366004)(186003)(16526019)(8936002)(2906002)(8676002)(26005)(107886003)(36756003)(316002)(6916009)(52116002)(2616005)(956004)(478600001)(4326008)(86362001)(6486002)(66946007)(66476007)(66556008)(4744005)(6512007)(6666004)(1076003)(69590400007)(5660300002)(83380400001)(6506007)(14143004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: cCTlH+pPmBe/1fhuQQLHggSo28CJ15GUCjM42JoqO6wsHk6+Udkqam885LzPwJJ4OlQLaH/B/Ab1we5LFYphvpRLfW6Aj4FSWlKR73Vo4iwHNQjkxJF4ocXTmToNnmYVbCUtSNJx7LOFdMUMRxuTBB7W4utMEyHIkcaDZhqzS9Xjty6HVN8XF6DJAOAjUN+LjnREkQKxX/wIz+4QU8G0yUm0YIlc+Xg7mCKeoktlA91q8t3kVvjgIaV1pcPFPpMaXUhaeM0NIuCZVIB3+o6dz4nls/lOY7cjLEonm/WHpCfDw9sJYSc21bX2e5gc3AmaWDEDBUryxqlfVGgtx8vrhvNcVE4diCkSmKix4h84lV1z1Kr8jXVSpCUY82e7bD5b4Fjd07h5FvrAc4AQv0i5kYyrVSVqcUFbdhDiUPbSqKI86bF4S7VF9d6o1kpwfScLzjoRthUIn5KH4imCSA5x/cgChHelv/mnsuPVKIVIYzQ=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0af8347d-9b2f-4c10-588b-08d806573688
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2020 18:11:32.1743 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WiIPmIVVE/Xx/TVUop2ELuDa6VIu6FzIEQOugNf2914UZVFAtYoUGpo3k+vlIpmEDqKlRVHrbqP/2vrQL5WZdduC4NDKlP74coqx+MDIW3Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5317
Received-SPF: pass client-ip=40.107.7.93;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/01 14:11:32
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, qemu-devel@nongnu.org,
 wencongyang2@huawei.com, xiechanglong.d@gmail.com, armbru@redhat.com,
 mreitz@redhat.com, den@openvz.org, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

ret may be > 0 on success path at this point. Fix assertion, which may
crash currently.

Fixes: 4ce5dd3e9b5ee0fac18625860eb3727399ee965e
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/block-copy.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/block/block-copy.c b/block/block-copy.c
index bb8d0569f2..f7428a7c08 100644
--- a/block/block-copy.c
+++ b/block/block-copy.c
@@ -622,8 +622,10 @@ out:
          * block_copy_task_run. If it fails, it means some task already failed
          * for real reason, let's return first failure.
          * Still, assert that we don't rewrite failure by success.
+         *
+         * Note: ret may be positive here because of block-status result.
          */
-        assert(ret == 0 || aio_task_pool_status(aio) < 0);
+        assert(ret >= 0 || aio_task_pool_status(aio) < 0);
         ret = aio_task_pool_status(aio);
 
         aio_task_pool_free(aio);
-- 
2.21.0


