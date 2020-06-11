Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51836C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 07:38:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C2792074B
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 07:38:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="X2InG3d5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C2792074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33432 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjHnC-0003ui-BR
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 03:38:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54198)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jjHlk-0002dy-G1; Thu, 11 Jun 2020 03:37:00 -0400
Received: from mail-eopbgr20128.outbound.protection.outlook.com
 ([40.107.2.128]:14561 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jjHlg-00066c-ME; Thu, 11 Jun 2020 03:36:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lgeXC5m6c0mrX/+aNoD9uUe8i2y4EkUGrTUfH5H+cYMhp8RjWXMPlQEQxM89GXCf8GAgJwbLkbZ+zXLGccz0gZ7xmvVb2dm6CYqixsJx/vT8sGr66nSV4d+Fb4tD0R5PhBXi59Pw4AuOJY8DVcKedYxlkK6Y1SyFQJONNFXHTR9N0ZN06Z0bDy9IsLI1rVAAw7M4yJEjhHpGxRSnaPqFFpTbvX/gUBWRJBj6cSI2TgpWpZGi28/KrUqMi/mRbA7fSmt7y2oYV4C6bvRv81r4jRbem6Hu6mPI29iY3xDZRfAn68LSBSLk7lujiqGHLJkDFbDFXrmM4vZXSOdntgUUlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RQI6j/S8OWyPmlOqvH7qfs/N6yXUe3w7QAZhMFeg7ms=;
 b=GaW64Dxl9ySHDuw0Sa2oXRCG0wvsr77SVgMMs4/w/U3nC1wdLgAHzD94593kjGN1/QamKcjlAXsfbX1D6w2z5+qMHNCLuvCmaUXG1Ik604edThqX0/MXCxUs9iRlJ/3ZAVLDEBWFQsLinDAQtn7fn3+sGZoCli1fHb05/XVHBoKwdljthIXwMTSLme1aw0g5vxBY7E+30g9YCQZOmD/O8At3nBoMxieNcSZfDHWs/CgSYKPB17/CVHly++JLJlCF8hXWaTcMFgIRr1Nx21oA5AOYO64Rg+RUwT2AyqYr/4onLOrg4CRqc8MSmib/fST2CVJ9jXaUwJXpn7YNHbB1XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RQI6j/S8OWyPmlOqvH7qfs/N6yXUe3w7QAZhMFeg7ms=;
 b=X2InG3d5jPKnkpg6TSoyR4nIdTAS74l7C9jUzsPnhIZ+g1zfY/mkmMrulNcUJY/hHTUD/Ik6U+GxToKNE5xwomyErUXQlB0M0TO2QqJfJ5eosusBvDLxtw+9A8UECiRvfhGGbIF7SLOH9XCfKEWv+9/g/hKIJ+pGT/WIQMdCuWg=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5416.eurprd08.prod.outlook.com (2603:10a6:20b:10e::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Thu, 11 Jun
 2020 07:36:52 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3088.022; Thu, 11 Jun 2020
 07:36:51 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH] block/aio_task: allow start/wait task from any coroutine
Date: Thu, 11 Jun 2020 10:36:31 +0300
Message-Id: <20200611073631.10817-1-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200610190058.10781-2-den@openvz.org>
References: <20200610190058.10781-2-den@openvz.org>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FRYP281CA0016.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::26)
 To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (185.215.60.159) by
 FRYP281CA0016.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3088.18 via Frontend Transport; Thu, 11 Jun 2020 07:36:51 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.159]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d29023f6-3cd9-4a02-a56d-08d80dda3505
X-MS-TrafficTypeDiagnostic: AM7PR08MB5416:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5416E1FD731CEAC0A5343F20C1800@AM7PR08MB5416.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0431F981D8
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5q36yWDgZX+h8b78zS3Yr8YuiSvMrHyK8B7U2CTvRDcBOJmickPuDUC0GHvgVU0anO4/sF/zhgm6tUw5lSE6qRCKCzoRVe/jmc+zgW+nkht6lE3Db1t7ypXkO/569jbRgftwIlCU3nsoUmVXE+BJNH4npSSyRXU79iBRiqsIZPOhOHChArNlQbdEWFMuAnUI+FiU3Rxk2mZVlYTynYi6gPtICuiegg+zbmA4Ec1l7lBJu/ZKVTsd0G0GYQD0tCgXWoHJ60wiktg6NCHL1LqHmz85w03IX4DdkfkXIb87rOnCdbIUNgDC9/anT37mBwQ5qublVX8IwsUziGSUSaJHi+B5ZktyTaRlIaSgyrUZZOKvrAKHmXIhpRB+zNjE5Bh1
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(39850400004)(346002)(366004)(136003)(376002)(16526019)(5660300002)(69590400007)(186003)(83380400001)(956004)(36756003)(66476007)(2616005)(1076003)(66556008)(478600001)(66946007)(8936002)(6666004)(316002)(8676002)(107886003)(6512007)(6506007)(52116002)(2906002)(6486002)(86362001)(26005)(4326008);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: d9txzRZPdomSrw17EJLz5/WqlPCU2JpCNlPIeAlhZye4RPA+cxx9rRlbdfqOR8/0T3LKak8L88DfOFHYIcYwK65yvezA07XH7wZzU5R7kuuH1ACjjfW8bwpuffCiG2mlIigkSlaZ15eeh7K0Xj8vfDaSEmyKIGLEgQvvlnWZL0DcTZnFVwJ7gEGl33aKByzabFAep044gMAA3lRz5vKwqTI+go7vrgmKlJH8EBbhw4+5IRay5fTdu4z5iNQ12rGhLwKr1No5a6XI6t5JqIBD+rQGRpBweFOQTvdYGyNI3dOLW+yssHQqZdU9KpNj6Bd0iveqc5X/G071uOioValx2rBS7D6jYd3LHZ9pgo+xA1NVBQR2u8mjuZk0SucKwsf2VTlz91Tn1jdB2DCIoYf/UiY3UkvrYaGtTvaX5JpiclFTNAmUWDUU6y59gjxD76HxpWtDznqcdIUjZd3Z4IRbGShily4JoNhekNE6F2QubH4h0lsXwi0i6ZX2YMBcDbIS
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d29023f6-3cd9-4a02-a56d-08d80dda3505
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2020 07:36:51.8575 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OFqxYsHp4q/AlOY09+QN2jZplrUYLj4MtOFCTeUaaI+fK2a4NbK52TnGNV+ZUGUrV94bYidSKsaaFsoZ6Yau1BoXHtPgIwnTlc36q/MJcIk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5416
Received-SPF: pass client-ip=40.107.2.128;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR02-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 03:36:53
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
Cc: kwolf@redhat.com, den@openvz.org, vsementsov@virtuozzo.com,
 dplotnikov@virtuozzo.com, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Currently, aio task pool assumes that there is a main coroutine, which
creates tasks and wait for them. Let's remove the restriction by using
CoQueue. Code becomes clearer, interface more obvious.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---

Hi! Here is my counter-propasal for
"[PATCH 1/2] aio: allow to wait for coroutine pool from different coroutine"
by Denis. I'm sure that if we are going to change something here, better
is make the interface work from any coroutine without the restriction of
only-on-waiter at the moment.

(Note, that it is still not thread-safe)


 block/aio_task.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/block/aio_task.c b/block/aio_task.c
index 88989fa248..d48b29ff83 100644
--- a/block/aio_task.c
+++ b/block/aio_task.c
@@ -27,11 +27,10 @@
 #include "block/aio_task.h"
 
 struct AioTaskPool {
-    Coroutine *main_co;
     int status;
     int max_busy_tasks;
     int busy_tasks;
-    bool waiting;
+    CoQueue waiters;
 };
 
 static void coroutine_fn aio_task_co(void *opaque)
@@ -52,21 +51,15 @@ static void coroutine_fn aio_task_co(void *opaque)
 
     g_free(task);
 
-    if (pool->waiting) {
-        pool->waiting = false;
-        aio_co_wake(pool->main_co);
-    }
+    qemu_co_queue_next(&pool->waiters);
 }
 
 void coroutine_fn aio_task_pool_wait_one(AioTaskPool *pool)
 {
     assert(pool->busy_tasks > 0);
-    assert(qemu_coroutine_self() == pool->main_co);
 
-    pool->waiting = true;
-    qemu_coroutine_yield();
+    qemu_co_queue_wait(&pool->waiters, NULL);
 
-    assert(!pool->waiting);
     assert(pool->busy_tasks < pool->max_busy_tasks);
 }
 
@@ -98,8 +91,8 @@ AioTaskPool *coroutine_fn aio_task_pool_new(int max_busy_tasks)
 {
     AioTaskPool *pool = g_new0(AioTaskPool, 1);
 
-    pool->main_co = qemu_coroutine_self();
     pool->max_busy_tasks = max_busy_tasks;
+    qemu_co_queue_init(&pool->waiters);
 
     return pool;
 }
-- 
2.21.0


