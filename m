Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C987DC433E3
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 19:46:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 968E92074F
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 19:46:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="ItPCJ8+i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 968E92074F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51350 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k095J-0000Pu-PH
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 15:46:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47688)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k091n-00025v-9f; Mon, 27 Jul 2020 15:43:15 -0400
Received: from mail-eopbgr80137.outbound.protection.outlook.com
 ([40.107.8.137]:20036 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k091l-0003fu-AA; Mon, 27 Jul 2020 15:43:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UWHmFkAwBY/MRqPUFDEEY57oFCbBxWOOD9xhDPWWbTgHTBNyvzpy+Yd0OSWr+P3oHnkZq/zQIjqI1jTgK9tTsWDsqQh6uxwopeubnUowbRl+9XiSU8k93yulyPnxoQnchGEsyBabGTsqy76ct/4Ubl7ZP6/jN5U5VxKdREZ6UFJih1O+0LfwBMX+TTzja454jhzQdZocXPdvG8wzu68Ac7Oyxs+x8ewkSU1AddyYj5HdJkxEB6XW4xDa1Uin2fL0T0R4C8qdHmmyc7j9CowoN5egviutt02VyY4zQfH0aTSoxvpOFT7g9Vm3v19Z/rFf1Pmhy2xtv3ANctn7xtyH+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IpZlL9SNYbh4wZnahRYVWrpY+UrJdNndt2i/TkLC5+E=;
 b=arCWohtWjsFA1bQf7G6+AQBfSH6plSF3AEAR0lxpHK7dlbjyhUt0jRDcYWCnPJEk7hWV+iBJazeaMCaNugEKIDUOk1Iyq6AwZCXqn89JcvBtGLmifZYuhTP5OAhHUuCM+AR/9O+PYnZGyrb+TJTlzuBEKpJYM1NCWsHL6OviiqW3Vj72+ZuE1PS0zVRfpGXjmdJbgFdUHwffzgGxYG/t3TbP2GNVmXQGWmBUPX8fm0O4SbhyAsOYhTzoJSn+yW9LxEHUqvyo2ii/krQLtJ+f6yMjf/492kUM6Js2KLbEUg6jWoW+ZjAms6A2XZnt4r5gd51yxKGIkzeB56khCgGw9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IpZlL9SNYbh4wZnahRYVWrpY+UrJdNndt2i/TkLC5+E=;
 b=ItPCJ8+iISEOvVdc5njWuMryEUcAuskTITSxSv9cn8Ux4sab+7+ME193878nbxbYpQKlyXyn1rP4UF52GhKoJjSb4mEpZsUwTp1gaLJQrDtaT94qkOs2pRN9eeNNbNKwF3ibKhfjRZ5YbTT142Jab+tCGKngpGKesNctK2N5XCI=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM5PR0802MB2610.eurprd08.prod.outlook.com (2603:10a6:203:97::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.23; Mon, 27 Jul
 2020 19:43:01 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%4]) with mapi id 15.20.3216.033; Mon, 27 Jul 2020
 19:43:01 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v4 12/21] migration/block-dirty-bitmap: rename finish_lock to
 just lock
Date: Mon, 27 Jul 2020 22:42:27 +0300
Message-Id: <20200727194236.19551-13-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200727194236.19551-1-vsementsov@virtuozzo.com>
References: <20200727194236.19551-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR05CA0084.eurprd05.prod.outlook.com
 (2603:10a6:208:136::24) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.158) by
 AM0PR05CA0084.eurprd05.prod.outlook.com (2603:10a6:208:136::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.20 via Frontend
 Transport; Mon, 27 Jul 2020 19:43:00 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.158]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0a1fc171-f2fb-4b6e-05fb-08d8326545b7
X-MS-TrafficTypeDiagnostic: AM5PR0802MB2610:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM5PR0802MB261080159C282C1DC41A94BFC1720@AM5PR0802MB2610.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:47;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UIJ+H8c0vyXU0GtQW2jBQpFZ2RMq52QFWtdIzeeeL7ftIGrMmWYWjczcN/Qxja6DtNJQxx7t16S3pMe/1TKLUhVDa1FLjeF5SMMXyL3F8FXdgUKirIyMvIxtjE2CmgRGzupILTeGLx+8bEHHfx0wvCbZRn82E/zEoryC+qwAVAonnmRjuuD2XKR9387l9zLnaxRp8wtltR4dZHzWIxkwmYeVuY3XRzEMAu+sF4PbM1KP4B2vcvFw/ESHbrplg84sle/1+H/auqduWDPI8wIPTT6IVYSgup0nlz8ZU3T5WcLVhc1VpbcRdvChzEQ82FD+f22LUavSofTEM9OF0N8xSnQVRZrV33IeMv3nVn347bpUR8QtKOlAbdCF/n4d7txT
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(366004)(376002)(39850400004)(346002)(66556008)(1076003)(66476007)(6512007)(107886003)(86362001)(36756003)(52116002)(4326008)(26005)(2616005)(2906002)(66946007)(8676002)(7416002)(16526019)(6666004)(316002)(6916009)(6486002)(956004)(83380400001)(6506007)(5660300002)(478600001)(186003)(8936002)(14143004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: xk8DQ2oqN4y/rd6UbO635i8PjxZnc9YiawB0fS6WGPyUja2uoYHMrLJouMTq523vg6b4TsTQgMD2CTOMh9wyqJnl9BYSIvE32B8wYPdVUAyOhV3ymVcHIrIMQs73zKTyW98pllomiZ79WwscCMEHZks8M2josPzaDjFXydpAAk+T2nvmgqo6v9rB+FFJPQY+oNJCw0cU8yVfTVDubXaMLcTpFd2P9A68KC+xNiVgS0MUzUDlpOEtRDgNl9YJ4KRCgThiB/slcqAxbDczCc3rRzWupF2epnwnS7ucTTJc8nMOUd+zAGib+VzLylixiqSJ+mVXhppQveArnUnE9oZSDA843gvbvU5WTe8uG4+pu5UPc0mVJhJbCtvpVzTb+Qu9Tn9qe/e8JNNGSNy+Z/YlunXHG9Q/7QHgZrjsRLlMLiQQOH4jgsdCT/IReOx6XcQJNGFSqzLmsw7MjQCEx2gaH4lrm4WZ4dFt5vENI229Z2M=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a1fc171-f2fb-4b6e-05fb-08d8326545b7
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2020 19:43:01.7495 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DCDIUhDzMHyKCfLbPQwhO6tq3PBPXMvVDoXvS/rW5cQMbmuu1AA7wiCMeyZGm9cCuo3RACc4SjypW1yVFQ/lx9F9wRsrIKwPrFUkOX0QKAM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0802MB2610
Received-SPF: pass client-ip=40.107.8.137;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 15:42:57
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
Cc: kwolf@redhat.com, fam@euphon.net, vsementsov@virtuozzo.com,
 quintela@redhat.com, qemu-devel@nongnu.org, dgilbert@redhat.com,
 stefanha@redhat.com, Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 den@openvz.org, mreitz@redhat.com, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

finish_lock is bad name, as lock used not only on process end.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
---
 migration/block-dirty-bitmap.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitmap.c
index 9b39e7aa2b..9194807b54 100644
--- a/migration/block-dirty-bitmap.c
+++ b/migration/block-dirty-bitmap.c
@@ -143,7 +143,7 @@ typedef struct DBMLoadState {
     BdrvDirtyBitmap *bitmap;
 
     GSList *enabled_bitmaps;
-    QemuMutex finish_lock;
+    QemuMutex lock; /* protect enabled_bitmaps */
 } DBMLoadState;
 
 typedef struct DBMState {
@@ -575,7 +575,7 @@ void dirty_bitmap_mig_before_vm_start(void)
     DBMLoadState *s = &dbm_state.load;
     GSList *item;
 
-    qemu_mutex_lock(&s->finish_lock);
+    qemu_mutex_lock(&s->lock);
 
     for (item = s->enabled_bitmaps; item; item = g_slist_next(item)) {
         LoadBitmapState *b = item->data;
@@ -592,7 +592,7 @@ void dirty_bitmap_mig_before_vm_start(void)
     g_slist_free(s->enabled_bitmaps);
     s->enabled_bitmaps = NULL;
 
-    qemu_mutex_unlock(&s->finish_lock);
+    qemu_mutex_unlock(&s->lock);
 }
 
 static void dirty_bitmap_load_complete(QEMUFile *f, DBMLoadState *s)
@@ -601,7 +601,7 @@ static void dirty_bitmap_load_complete(QEMUFile *f, DBMLoadState *s)
     trace_dirty_bitmap_load_complete();
     bdrv_dirty_bitmap_deserialize_finish(s->bitmap);
 
-    qemu_mutex_lock(&s->finish_lock);
+    qemu_mutex_lock(&s->lock);
 
     for (item = s->enabled_bitmaps; item; item = g_slist_next(item)) {
         LoadBitmapState *b = item->data;
@@ -633,7 +633,7 @@ static void dirty_bitmap_load_complete(QEMUFile *f, DBMLoadState *s)
         bdrv_dirty_bitmap_unlock(s->bitmap);
     }
 
-    qemu_mutex_unlock(&s->finish_lock);
+    qemu_mutex_unlock(&s->lock);
 }
 
 static int dirty_bitmap_load_bits(QEMUFile *f, DBMLoadState *s)
@@ -815,7 +815,7 @@ static SaveVMHandlers savevm_dirty_bitmap_handlers = {
 void dirty_bitmap_mig_init(void)
 {
     QSIMPLEQ_INIT(&dbm_state.save.dbms_list);
-    qemu_mutex_init(&dbm_state.load.finish_lock);
+    qemu_mutex_init(&dbm_state.load.lock);
 
     register_savevm_live("dirty-bitmap", 0, 1,
                          &savevm_dirty_bitmap_handlers,
-- 
2.21.0


