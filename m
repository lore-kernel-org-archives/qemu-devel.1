Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46D67C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 10:56:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13A49206CB
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 10:56:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="rHf9Nz/Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13A49206CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqaQ0-0006uT-Ap
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 06:56:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44734)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jqaNA-00025i-Sn; Wed, 01 Jul 2020 06:53:48 -0400
Received: from mail-eopbgr10133.outbound.protection.outlook.com
 ([40.107.1.133]:2638 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jqaN9-0002JK-2u; Wed, 01 Jul 2020 06:53:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E4eaGCT5DmjN0yezzXruzmFlEr8Hk/H9ojE43T/BQ+jLMJ6STFdtQto6a2gRdzgOygg0WRfFzJS+lbtjFaPDQ63baZ95DGqQXtOY/gpbpvBA3gSu/UCwS1p4d3gC2jeJIheVzlaiVYylNNqr560WJv8eO/AnolgqKE61dBZ8l8zhIJT7WAMMnZtaK4Sadq+qGsf/QJU8+NoQMLv2Dn6cWNplgVEpUufE9Mcjl/wnrS9vH8Z7HU09bvMv0ccZ7ZpvDCJiTAdVC2JinaT3UZD+a9b+OVMXRVvMEez5hXw6SImnyDLlCOZjFg7iWu4KIVfBpkrG1yYjG0Sm+w9Ked7wQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iTil3AQGxHhzTY22bEOMgdhz3baVKtAIRIum9+ZopiI=;
 b=EKpOUk3VCSVwz/ywIHSomedtyKn1FVe4qqO6WfRh+PxU7jzg6XlOtkehjKfSyWhARgckwr8BwEx3GUIO0ztUaGuPwh6iWYqzuGXhI8pGwBz+jkiTcogcNy9fXXfmtiSRrxjxSErU625x+Yt4YhwHRyuzQejYAzvlcVk4utgyBgYI1E4PRHicULFWiEkHitUN7TDPaOk22T7Zbw3MNRwh/ncmJSpPcZjpoLabUIn2QlfVpb5sQJ7GoOpRSUg1rtXlcgKH30xu3Ic9wamsVx8cqsfB5ltg+hy1WcjGEKW3GJ12se93N67cJVWz575575tQE6ZuCNn1xmcmwrifsr1B+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iTil3AQGxHhzTY22bEOMgdhz3baVKtAIRIum9+ZopiI=;
 b=rHf9Nz/YyVQDzll3K7iKp4qkmfgR/lwJYX3UX8k89xU0d/ddaM0x0aRDBVFBvrtUlAn8xlaQqLsq3vL9oGd9YkeMndEE5o466eji3kpQBrz7P9HmtlBcD/dfELKMf3D7Phl6jFXF/JYXgIGOGnYGhRnk0IkRJcej+cLaXOGVxdM=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4850.eurprd08.prod.outlook.com (2603:10a6:20b:d2::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.26; Wed, 1 Jul
 2020 10:53:40 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%4]) with mapi id 15.20.3131.028; Wed, 1 Jul 2020
 10:53:40 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 3/5] nbd: make nbd_export_close_all() synchronous
Date: Wed,  1 Jul 2020 13:53:29 +0300
Message-Id: <20200701105331.121670-4-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200701105331.121670-1-vsementsov@virtuozzo.com>
References: <20200701105331.121670-1-vsementsov@virtuozzo.com>
Content-Type: text/plain
X-ClientProxiedBy: AM0P190CA0004.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::14) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.28) by
 AM0P190CA0004.EURP190.PROD.OUTLOOK.COM (2603:10a6:208:190::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3153.20 via Frontend Transport; Wed, 1 Jul 2020 10:53:39 +0000
X-Mailer: git-send-email 2.18.0
X-Originating-IP: [185.215.60.28]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5895c814-13c0-4f8e-ce14-08d81dad03de
X-MS-TrafficTypeDiagnostic: AM6PR08MB4850:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB4850839EC8483113CB07F51DC16C0@AM6PR08MB4850.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-Forefront-PRVS: 04519BA941
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eHUY3jhihVBZEK7EFZvL55Lx+7mmzCTiZOXjn2jXoBfj2jL3gy+m08Y/Uu1xSE7SMt5Su4LBio+dxdbseYggDADdALkUoiGJhybqJ13skFfX2SJ9AcS34ayU2J2nmVNpiO5gc7VcnVy1mmQNCf2MEIZEYJ3Hh/YSt8fgLPZr5yQSR0qvH/iA+gyTVd3ytpjOsba9XhK/SxpiVLiPt4wEI7nXf+rKTbX7/AaekF+4iUpCFwM19k9kZRvc9GpzRWq8GcLL3liYsA52wUwmpLS2fMmSBOuBf8gV2ASHR7bL9252q+fypagsvfV4vB1nzhe7d3ljHMa1BBEjXY9Hm/9MOg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(366004)(39840400004)(376002)(346002)(396003)(2906002)(83380400001)(956004)(316002)(2616005)(6512007)(6916009)(107886003)(6666004)(66946007)(66556008)(4326008)(5660300002)(66476007)(86362001)(1076003)(478600001)(186003)(6506007)(36756003)(52116002)(8936002)(26005)(16526019)(6486002)(8676002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 1+sCkSpx0DpXWajS685Tx+V5T3jqMimluTH+tOqEYEuG5GUjmifJljl7UMZRSSmZCmLNFAr0VrtIyuByX446KCnkZPQgeJ8KQCrF29znTrkteARHf2WjhVqGAlIhM6MInnUn8Edj44q+oK1rx9Y6t0Pycro3N0VQxaGGQM3OhOvfVo5u2+FEahoKszHI12dST/2QH4ZwmBdqdQtPq0bUey75oh8M+WgddnBKrBrf5CBkixBkRLiFg3YYv4x6YZWw/yBuK6P1n3R0zT52zZYTwJj60Sn1cCkvG3xhrVstSyGOtDcelLgks8thN3zpLSad3OchvSoCXvZR0HPpnL1eeexEVxP7i/1FmnUb8xGTaV6MFBau2BgJyn/lL/V9m1Sw/iutebnduOQl8IUSK3Kt5a5USoryqOmMaZ6cSvXb9bZ4QfRR7OUSRIOvg5vcwUFEDT8UBUaxp2KtB0NA4V5WokBKCzdC9KwHy/514EU1aX8=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5895c814-13c0-4f8e-ce14-08d81dad03de
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2020 10:53:40.6377 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JNUhP1KOOpwk/0H0g556y5qyqwmU5UTlBkk22e3N5bFjoJnP5N23fWlffRiounOxk5tI67XgzvEIAeti7HUg4mqLuSOLzF1pdTylntf8TpU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4850
Received-SPF: pass client-ip=40.107.1.133;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR02-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/01 06:53:39
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, qemu-devel@nongnu.org,
 mreitz@redhat.com, stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Consider nbd_export_close_all(). The call-stack looks like this:
 nbd_export_close_all() -> nbd_export_close -> call client_close() for
each client.

client_close() doesn't guarantee that client is closed: nbd_trip()
keeps reference to it. So, nbd_export_close_all() just reduce
reference counter on export and removes it from the list, but doesn't
guarantee that nbd_trip() finished neither export actually removed.

Let's wait for all exports actually removed.

Without this fix, the following crash is possible:

- export bitmap through internal Qemu NBD server
- connect a client
- shutdown Qemu

On shutdown nbd_export_close_all is called, but it actually don't wait
for nbd_trip() to finish and to release its references. So, export is
not release, and exported bitmap remains busy, and on try to remove the
bitmap (which is part of bdrv_close()) the assertion fails:

bdrv_release_dirty_bitmap_locked: Assertion `!bdrv_dirty_bitmap_busy(bitmap)' failed

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---

v2: rewritten, try to wait exports directly.

Note: I'm not sure in my understanding of AIO_WAIT_WHILE and related things
and really hope for review.


 nbd/server.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/nbd/server.c b/nbd/server.c
index 20754e9ebc..9d64b00f4b 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -102,6 +102,8 @@ struct NBDExport {
 };
 
 static QTAILQ_HEAD(, NBDExport) exports = QTAILQ_HEAD_INITIALIZER(exports);
+static QTAILQ_HEAD(, NBDExport) closed_exports =
+        QTAILQ_HEAD_INITIALIZER(closed_exports);
 
 /* NBDExportMetaContexts represents a list of contexts to be exported,
  * as selected by NBD_OPT_SET_META_CONTEXT. Also used for
@@ -1655,6 +1657,7 @@ void nbd_export_close(NBDExport *exp)
         g_free(exp->name);
         exp->name = NULL;
         QTAILQ_REMOVE(&exports, exp, next);
+        QTAILQ_INSERT_TAIL(&closed_exports, exp, next);
     }
     g_free(exp->description);
     exp->description = NULL;
@@ -1717,7 +1720,9 @@ void nbd_export_put(NBDExport *exp)
             g_free(exp->export_bitmap_context);
         }
 
+        QTAILQ_REMOVE(&closed_exports, exp, next);
         g_free(exp);
+        aio_wait_kick();
     }
 }
 
@@ -1737,6 +1742,9 @@ void nbd_export_close_all(void)
         nbd_export_close(exp);
         aio_context_release(aio_context);
     }
+
+    AIO_WAIT_WHILE(NULL, !(QTAILQ_EMPTY(&exports) &&
+                           QTAILQ_EMPTY(&closed_exports)));
 }
 
 static int coroutine_fn nbd_co_send_iov(NBDClient *client, struct iovec *iov,
-- 
2.18.0


