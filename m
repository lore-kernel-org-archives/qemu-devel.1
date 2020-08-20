Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42428C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 18:42:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 087BA206DA
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 18:42:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="DhLAfoi0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 087BA206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55284 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8pVl-0002mU-7M
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 14:42:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35290)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k8pUA-0000op-1P; Thu, 20 Aug 2020 14:40:26 -0400
Received: from mail-eopbgr00105.outbound.protection.outlook.com
 ([40.107.0.105]:40648 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k8pU8-0003Bm-0u; Thu, 20 Aug 2020 14:40:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SVYpUwiO4DA583L9PmA/Eo8ncPvVFgIHCBqpUqp1vmmOuZhjM/Ii08Fa5m/39VJnapjMfkrWBSVIstH21/vLPgy4emMAJ+z8KrGDtx5zSua0kHifYZtLs9UfNuVCBMoNL6JeqvVrUh2ZQ/97EL5cIyiKch01SJm5vJDTHPJmprO5Cw5fGZouYQYgZ45h0praIiVeIplbXp5HG0aeMBLflTEf7K/g9C7M8qUhsTUEwoKX8NzEvgQMS7TVRgjUKgdujcJkE/kZYwPxix+S/uJwcL7MjQF3AoEGLvnK/DmuUDU3oBQ0bpKvgq24aJGymYP+AIWoS2fihxybzvg4ghOSfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iOSs8tSaCsvqszeIfYHYua4c4UTbNH955appswRjkts=;
 b=OLD0D06RFGhPg+U/fcVdxWFPyPcTeyS2QE6q42kaFf3DsGnUaTl4Lo+ovCQs5qvC+W7waeLnJ7z/3t/sHAqnBm0fmUQJ5Yk3Mdj0Ka5TnBVhu2A/cTYHbSPptLlpbJtCaCZA+dJ8QynXo/ZawEFWsd+nP+53BA+Aeqf+skPoK20mBIYMCXtLd+jiU9NRS7ctbqQ1Loc1U0C2fnyLt+F2mHmWmxBZGHh3uLKxlTX6ohPJn7Fz2+ldNq25+Fx1c59Cxza/NaO4NzqivW/9JcltG06hofFHan2cwSphiNra7iUeMdKNjhEkHbyCtum4twZTMxhtP1mboiY/pCl9PvW5EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iOSs8tSaCsvqszeIfYHYua4c4UTbNH955appswRjkts=;
 b=DhLAfoi0Z7qjnctn8/IItUlYDHCIxIa/74inBDwcOHGmXr5zyjcR0keKvm0cVsVQH96TWN+dPFKmZ8QIRbM49m5q6KCo4Kasnq6v4NK5rNpJktVhLCfXCRiWN7YVefvJQ9D0hUvt75fUVNX/iZH6zzy4KwTrTe87NA1b/30t33M=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB3032.eurprd08.prod.outlook.com (2603:10a6:209:43::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25; Thu, 20 Aug
 2020 18:40:07 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%3]) with mapi id 15.20.3283.027; Thu, 20 Aug 2020
 18:40:07 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v4 04/10] block/io: bdrv_wait_serialising_requests_locked:
 drop extra bs arg
Date: Thu, 20 Aug 2020 21:39:44 +0300
Message-Id: <20200820183950.13109-5-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200820183950.13109-1-vsementsov@virtuozzo.com>
References: <20200820183950.13109-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM4PR0202CA0003.eurprd02.prod.outlook.com
 (2603:10a6:200:89::13) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.171) by
 AM4PR0202CA0003.eurprd02.prod.outlook.com (2603:10a6:200:89::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25 via Frontend
 Transport; Thu, 20 Aug 2020 18:40:06 +0000
X-Mailer: git-send-email 2.21.3
X-Originating-IP: [185.215.60.171]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2fcfb961-347a-4640-14f2-08d845387604
X-MS-TrafficTypeDiagnostic: AM6PR08MB3032:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB3032B6D64716B23C7ADD8378C15A0@AM6PR08MB3032.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Dq028sUGLYcNA5uz++1aPD0Z8c9gNq5TNI6Yt9ukKEjDlVg9WR9hvPuA+tMPcHHA38U4btxgEqq12pPg+ykWWEB9MKfTY6fObBd73AlUub99Q0mfUnMQzcATS9oCAOpU3aUbaCM/in49ipDTOEd7rO1IQElqAic0NRcTSEtrIsZFiGIZo9KmTnaD/XtTnwRPNtOkG5cU+K0yTBPoanVAl1mejGD+0a1hOF/qajmopdGLm+dE+HAktsv3UYIeyu9+97n6FSGwBjxcvuFS8umjIIE7Np/icd3WIKIrlq7d5gw1N0nbMehbBc48uBT4F5jsuPJC1W4YwM4TQi7FYGgfgA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39840400004)(376002)(346002)(396003)(136003)(4326008)(6666004)(8676002)(16526019)(186003)(26005)(316002)(107886003)(6486002)(83380400001)(36756003)(86362001)(2906002)(478600001)(6916009)(5660300002)(8936002)(66946007)(66476007)(66556008)(6506007)(45080400002)(1076003)(6512007)(956004)(2616005)(52116002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: liQJjP2aEQkprfQ3F1FymhHwOs5tsa0/8WRxVtbXAzM+vCgEwHy6wjeEDColdCLE1ryc6F84sEjz0Nq2LeoFyuMuzaKm8GgRrNvpuYOXdjQGF7oxNHITWpR3Jn78wJGj4ioHKlehUKY3+94vFbBZ42iYsWngBa32otH4paK+UYeL11+nR7HbqER+UNvxoSS+Dq2Oo6yNOYJqlMqsYOiPz0kpLmZkguozzkSK4CoCahRwkq3hzkbKabzxUH5AgtIi5gYE6O4qghuQrQQKgh7oJsr5LCuqr7i7+Qlc8fXg7K0eKLRNT3tcK6I8o6+NjH5n/xP/RifeNgyhVoH/ikMq0HHW/BNz3Gk+YDrdokOoxqynQ5kNEIGRlCYMp6oZajGAIoTZ86vnhoajqaCHbr+Hbf3kFvWxnEtkrXwSXyrPn2AJBRJUYwpdDidCJlQDg9n6pKebfYXLzW0MUwI7/qJxsx8CoJ99eOqoFeiCrFmssykmmVx/iU9ML/L7eflgzT7mOTlLs2MNkGd+e2a1rxaZTrE+V/Hg4gpboXAYemLZveQYc0hOnl04GP0BqbIv5vGRKxtSE75iNN4dwUjtZ+3a0kJQ7ljZXSwqoLaLCTUuUm0zfUcPq1reoygV/64wM8fW49oPe7/Q8CUk/o16zm1n1A==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fcfb961-347a-4640-14f2-08d845387604
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2020 18:40:07.4603 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +l0d1DrWXyBhLUFaZmqjXQK32GVTyf9T8vR/RwpNTzpD/ONhcLOjIbfJIhivb7BQHS6CohuBguY+46HpeUHOe5q3dG5QcrXuImVEjpbKPZo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3032
Received-SPF: pass client-ip=40.107.0.105;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR02-AM5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/20 14:40:09
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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

bs is linked in req, so no needs to pass it separately. Most of
tracked-requests API doesn't have bs argument. Actually, after this
patch only tracked_request_begin has it, but it's for purpose.

While being here, also add a comment about what "_locked" is.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/io.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/block/io.c b/block/io.c
index 5b96715058..36bbe4b9b1 100644
--- a/block/io.c
+++ b/block/io.c
@@ -761,16 +761,16 @@ bdrv_find_conflicting_request(BdrvTrackedRequest *self)
     return NULL;
 }
 
+/* Called with self->bs->reqs_lock held */
 static bool coroutine_fn
-bdrv_wait_serialising_requests_locked(BlockDriverState *bs,
-                                      BdrvTrackedRequest *self)
+bdrv_wait_serialising_requests_locked(BdrvTrackedRequest *self)
 {
     BdrvTrackedRequest *req;
     bool waited = false;
 
     while ((req = bdrv_find_conflicting_request(self))) {
         self->waiting_for = req;
-        qemu_co_queue_wait(&req->wait_queue, &bs->reqs_lock);
+        qemu_co_queue_wait(&req->wait_queue, &self->bs->reqs_lock);
         self->waiting_for = NULL;
         waited = true;
     }
@@ -794,7 +794,7 @@ bool bdrv_mark_request_serialising(BdrvTrackedRequest *req, uint64_t align)
 
     req->overlap_offset = MIN(req->overlap_offset, overlap_offset);
     req->overlap_bytes = MAX(req->overlap_bytes, overlap_bytes);
-    waited = bdrv_wait_serialising_requests_locked(bs, req);
+    waited = bdrv_wait_serialising_requests_locked(req);
     qemu_co_mutex_unlock(&bs->reqs_lock);
     return waited;
 }
@@ -876,7 +876,7 @@ static bool coroutine_fn bdrv_wait_serialising_requests(BdrvTrackedRequest *self
     }
 
     qemu_co_mutex_lock(&bs->reqs_lock);
-    waited = bdrv_wait_serialising_requests_locked(bs, self);
+    waited = bdrv_wait_serialising_requests_locked(self);
     qemu_co_mutex_unlock(&bs->reqs_lock);
 
     return waited;
-- 
2.21.3


