Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F370AC43464
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 20:03:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AC9320725
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 20:03:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="LNVwN/aV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AC9320725
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56672 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJ089-0002M0-Lb
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 16:03:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59344)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kJ00W-0002l8-K4; Thu, 17 Sep 2020 15:55:52 -0400
Received: from mail-db8eur05on2139.outbound.protection.outlook.com
 ([40.107.20.139]:28641 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kJ00P-0005sK-Je; Thu, 17 Sep 2020 15:55:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=abqu/GRmp3PDdMr+pO3Sib+Vsp7YS/lVZ+WyFVAQP+/IeNtFbjGJLQGMTBrPp2ruYdwgvbDeYc4mFARLDuhakV7/RU6CZHCJPCQd7xglKz/Bpta+p8PywpvnyhdAi72krTdC0OLSu9QUEe3ltMWTxijpJiKjJjkABadmrn8HeHtwQWGvSRQ/73HFps3y+vOETCJUK6DUcXgpzSpYluS2EkVz325EYzsjgSgxTAUCsTpoF8xBp7t3eNC8EZ9sEQFIRApeRBaqK9g2RCvDw2i8NqpzeVMhDWBauoSjW9hf6uoIJ5Kxpy2zansMtIdLUjKjE3ArLliPakTdPfU4tuEVhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j8oIbEFv9BaYaNrdRO8hV+GAJDPNzXwgXnYu/AaHapQ=;
 b=bePa4teQOKcFmi9+RutrmwKd8AmkYDJ5ZJtaDOGHrmsSRNWbyYGMytzAALDQvWpaKkBMgyenix0kouNQ25wSuI2X363Mkxlb9gUBjfKQeiOxMTEVE0DPdISYmXjBcuUNsoqcJrpgdeIoPqYxEfXK3/B/2x1ZpeDaFjnZPoZxUg82DCHEnWDN83nKXaZYkdkrDByXuku+jDJOsv/Q9MTd6jrrtLMqfAAQM8tUMqDE2pZKU6Dj9ZUHfqvmnPL3Nt7WtTem7FtqNA+g572eYQ2VAZoqLcI5CCTAO+nIcKCQwXr5Lv8wDWy/anOYnhK2qEy0OECg7P5hCv2jB1DSUoBmPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j8oIbEFv9BaYaNrdRO8hV+GAJDPNzXwgXnYu/AaHapQ=;
 b=LNVwN/aVjl5Xz8M9W84EKzEqmMLWt5up9g2OVK3xJHm4iLJYifDiHV2ccqvYZI2tYPGsuGdWFqCN12Qi31EYm2+oFdOe/iecSM3K52O6nzi2mfZ2yahbE2RXECZCRhkjBYqkX0+lbD21WaKcCsOy2MS0gODuDsHecK6rifw6TC4=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB3032.eurprd08.prod.outlook.com (2603:10a6:209:43::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11; Thu, 17 Sep
 2020 19:55:39 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692%8]) with mapi id 15.20.3370.019; Thu, 17 Sep 2020
 19:55:39 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, armbru@redhat.com, berto@igalia.com,
 vsementsov@virtuozzo.com, eblake@redhat.com, jsnow@redhat.com,
 stefanha@redhat.com, pbonzini@redhat.com, pavel.dovgaluk@ispras.ru,
 ari@tuxera.com, mreitz@redhat.com, kwolf@redhat.com, groug@kaod.org
Subject: [PATCH v2 04/13] blockdev: fix drive_backup_prepare() missed error
Date: Thu, 17 Sep 2020 22:55:10 +0300
Message-Id: <20200917195519.19589-5-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200917195519.19589-1-vsementsov@virtuozzo.com>
References: <20200917195519.19589-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM4PR05CA0011.eurprd05.prod.outlook.com (2603:10a6:205::24)
 To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.75) by
 AM4PR05CA0011.eurprd05.prod.outlook.com (2603:10a6:205::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.11 via Frontend Transport; Thu, 17 Sep 2020 19:55:38 +0000
X-Mailer: git-send-email 2.21.3
X-Originating-IP: [185.215.60.75]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c82cb734-b005-49d1-003e-08d85b43a686
X-MS-TrafficTypeDiagnostic: AM6PR08MB3032:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB3032540495B0FB2D7774C0F9C13E0@AM6PR08MB3032.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1051;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5s52s+MnUJ8jGNb+/RAxO8Jy9fb+Q6anXt67txM6R+Ex9W33wZ9JS+Q3mQ2WKqutSYuoLX44dcspKCnjC9FJwSTrhfDm9gvn7UO5V20FltaV721KuRzabwguqeGaPKtxDn7JlQMhzzxk9viOylTdtWm95coIKSqMWUBs5HgmOgXvn9r4teBUtK4s5vhTJY59VMjUWW+KSziiyEzMXDPs58AcgUJJmhKPHER6kS+IKxk7Ik4jxHM6VFLg4PFOVLnOGbZ1fPvsrhVqPWRLIno9nqKn51E0GFCpB6jC132tvLi+8Vc2jT/Svydt3mHGTbqrs7ptRBwF3vWIrvuWdWckrQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(376002)(39840400004)(396003)(136003)(26005)(186003)(316002)(6486002)(4326008)(86362001)(478600001)(6666004)(16526019)(8936002)(956004)(6512007)(2616005)(6916009)(6506007)(2906002)(7416002)(36756003)(4744005)(5660300002)(83380400001)(66476007)(66946007)(1076003)(8676002)(52116002)(66556008);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: xH7SHPr54nPdFRYwa3iz78J3t4DWK/C+gG3NYW6OWJbWee9CP715fgXLx1i543NHX0kAJKxiuB8/lBnx+Y6JwNfs+zU3VKL3YHEXHPUp6X7BxbVbfLTPUKDyerTLhJc1DVXN8b5TCG7GI8hjt7MuZj7xW1EveFSyxpJSlGcoa8fwN9s+/nTZkjQ6boJ/2W6vsVSPmTlb8JkIcanYrl5f3YEt4bbGsB3J2GKbkpC5vYHEgome5q8DEx0D9aXY1DPfj4ek/9UwT4Z16UCCYRWzWt9XJ1A5EDjCO1Am3xmJOzKr88M0W0uvkR8k1T5X5un4UCEGe0d8DBsk/2du/uB/E2QTcVoC9fptyodpTdbAmJBXpHhRecoiiyTu1bhPFkEtxRQUgP8TuvPJrpJmq15Cb2hU3yxVTezfavRVFrztR4QdYVK/X5k+wPUQhFW9EiOfOHVnHx+87huDHbW2eMrAIbh06qEQYb12UYv5V2UiEq/64aVHxsO+cMLo3pTio5gbM1jjW0Pgnfd+YWiwUWGqh7WLjZdm1OhB+IITVDV42gVXlFtPyH0gizD8pTDp3cMSUzzYbzvRr1AUewLhWOYUN1LVuSQ+/DM79jgJpjYGcaQulJhWO80K6R2o22by7OL4ZITSjOuQT5AWDk5OGXkWyA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c82cb734-b005-49d1-003e-08d85b43a686
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2020 19:55:38.8905 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pHyRPVZXDEwEFJlTy/0pDnK5nvuUzmv7QQ65r4O9rsY6WHhas6+sMHeVQnOnljp9281msqVISRAQkCj6gBturg1+7+gEYYjAVXKJmGd5jXo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3032
Received-SPF: pass client-ip=40.107.20.139;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/17 15:55:40
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

We leak local_err and don't report failure to the caller. It's
definitely wrong, let's fix.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Alberto Garcia <berto@igalia.com>
---
 blockdev.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/blockdev.c b/blockdev.c
index b9803e553f..d6bde81ad4 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -1813,8 +1813,7 @@ static void drive_backup_prepare(BlkActionState *common, Error **errp)
     aio_context_acquire(aio_context);
 
     if (set_backing_hd) {
-        bdrv_set_backing_hd(target_bs, source, &local_err);
-        if (local_err) {
+        if (bdrv_set_backing_hd(target_bs, source, errp) < 0) {
             goto unref;
         }
     }
-- 
2.21.3


