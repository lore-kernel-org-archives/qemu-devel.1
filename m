Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45186C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 08:34:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 069B8205CB
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 08:34:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="sFOxLK+a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 069B8205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42564 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jglKw-0006dD-9R
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 04:34:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49766)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jglK6-0005qw-Nx; Thu, 04 Jun 2020 04:34:02 -0400
Received: from mail-eopbgr140098.outbound.protection.outlook.com
 ([40.107.14.98]:12946 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jglK4-0006iw-Fn; Thu, 04 Jun 2020 04:34:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XCf08osLK62JojPCcsPv4MKOm7CHmLrbPF4v31uV/GpdlL6ave4XYq/FMCJXlMzAlMOuHOoDft9kOLUpkvB0N3+++7CQiQRLdvwFt3wPCCJUreKs5NuLe0GfNNOBVv7zXvJs440ZpIkHKIDiBvaXFFMJKij6By4QvIm5wz4Ry54fBgcExGCOSp5Sa+SpQgPaaen5ro3tjN4I2EIcChZLWPqbP8jfzXCh2mtRjfn2nNSHVKTkYn9yKre5i6HeBBuStWr5//WINMjv8ghsI25Yb1IJek8aqAC9d8m0H30mThU92ggUAOX9uLN9d1z73atKLdyNbmc+xcHv+D/VkKrf4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vig8Yz7pr2lV1wIB65UYp5XEiSnfBFahnO/GpDNSz6A=;
 b=MyezRGcBnFI98qVzKnfYBCsvgdI8/4tARVew4CoPR16W6pXKF42iwztGTanPYrPM7enOgVG3ZUTQ7xkebUxboebrMYvtiuNX7YLz0qqoo7wKBrhGPcGJYVNpzHpi2n+GvVgXio6APfAxC7xOLEPwBcHFki30e8xYmg1AqPl2P3PMyCz3yxCfrNry3uQ+AiNpvi4fZGiUonOwZaMM0zHxj8fV0L+0YVMhLcS6QzhAWQIIqGo/CHFdIqejMh0jvmIieEV0oYPSsDVgimdiphAvYjNKlWKfaANjGq62pCcIRvxJXfSebk8WZT/eZTmrJ3eCkV29WgdJ7VxVae1/R13N2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vig8Yz7pr2lV1wIB65UYp5XEiSnfBFahnO/GpDNSz6A=;
 b=sFOxLK+apmIVW6Z+Wit8e95L4jiFIjOtvO4MaIPRvWyylHqUZzqcKX8NWXDXE37CD6ruqTRXfcDj8URCpLD01ES/7HTO5UEm3Vr9VRf+oZJSv19r/7dbjEGZSda9W9d0YM/xdsdo8bIa5zRg3nFS4NDbGBsCzTy0iKJV303baDw=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5303.eurprd08.prod.outlook.com (2603:10a6:20b:102::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Thu, 4 Jun
 2020 08:33:55 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3066.018; Thu, 4 Jun 2020
 08:33:55 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH] iotests: 194: wait migration completion on target too
Date: Thu,  4 Jun 2020 11:33:41 +0300
Message-Id: <20200604083341.26978-1-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR05CA0079.eurprd05.prod.outlook.com
 (2603:10a6:208:136::19) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.190) by
 AM0PR05CA0079.eurprd05.prod.outlook.com (2603:10a6:208:136::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18 via Frontend
 Transport; Thu, 4 Jun 2020 08:33:54 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.190]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4973fa53-272d-43ad-65af-08d808620479
X-MS-TrafficTypeDiagnostic: AM7PR08MB5303:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5303AF03BCDB24F9EE40A044C1890@AM7PR08MB5303.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:534;
X-Forefront-PRVS: 04244E0DC5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xLoJlkXd7/M1W6HVKDVHhkbJ4ZdS/FBfT6CegVOBREDqLZEeK/PhPZ9XJ87BVkETtle1vc6DdMzqTebGLH/CP+wtIXuZEYl1fOD7shYkmGuBEQCYNv7PzNTVzE2LfJzAkb2Psruokz8qlNWYNBZcBDZAMrFLzkQW5/Le1fLph1eyMo0xAsRN93pp4q16ZNsZxCFwu/mIvJpcIs6k4egRlCRTbR2Ql18iXieVnfCEUlLWwFyO4jvevjlh6Mt1qGp4HvpgJFkT0gxBOXuV2WBWahhppU3yqOYLgqGjSsWcMRveZssT+Q77q2FPJi5AdZ/KqmR2PElUr+gc+aOxF+HIBw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39840400004)(396003)(376002)(366004)(346002)(136003)(16526019)(66556008)(66946007)(83380400001)(86362001)(26005)(8676002)(956004)(2616005)(8936002)(6512007)(66476007)(478600001)(6486002)(6916009)(6506007)(7416002)(186003)(52116002)(6666004)(1076003)(5660300002)(36756003)(2906002)(316002)(4326008);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: ZHmiAxCK6nsbSBACjsxEm9VLAV7oWxLDYkM9mXmwdtrY8uHKm9WDTFWsNrkbPgqCNzNQzviFGQtFeIJ3xEe0zlVECpI7t+v5DEpDUIOVp6liztN3MevxyQqEJwKErB59pJqcyxfrMNZx2BDHbV9Pz2eIGapnVrQq1dzgWBCSJbGwmEmw0brBhzLY5ip8Meqw8aGnhjgF9ZfHw/QBzkQmAZbpNxtY2bBmwP5KaMFoWz9IsF1Tz2f4J1MzoBEnWapjWnD2+bQobzwBJsxXMengwgb3by33WxxWF5v80j593d/lmbP6dsRq9B40VFs/+fYq8jp3Db7n0zxAeUFn9D7is6j0SqRRLOMVB/B/UkcT8Z9jdYpkmi+lXzaiXjKqW3idIvBAMcIFJH/vhKAA14HQmsMYZ49+uk7J36YLKu3zVpnmQvNGBGjts+Q5LEUumUoN/DXZYoBFics1XdosqB2NnFNHBsOtgRJ49lobYcTvnWHOv+EVLcDuHrT7wxOgTNv5
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4973fa53-272d-43ad-65af-08d808620479
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2020 08:33:54.9260 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SKwHqYGyFmGllvMdlBQVaTjTf/2FtGuTP9XenG1vEIlwpkNZNWOGOAeQ6tx+W3bzkQXF0QFjG192Ot7LxaghXEEqXlhu5JqLvP8uL4Y6+Vc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5303
Received-SPF: pass client-ip=40.107.14.98;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR01-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/04 04:33:56
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, MSGID_FROM_MTA_HEADER=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_SBL_CSS=3.335,
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
Cc: kwolf@redhat.com, fam@euphon.net, thuth@redhat.com,
 vsementsov@virtuozzo.com, quintela@redhat.com, alex.bennee@linaro.org,
 qemu-devel@nongnu.org, mreitz@redhat.com, stefanha@redhat.com, den@openvz.org,
 jsnow@redhat.com, dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It is possible, that shutdown on target occurs earlier than migration
finish. In this case we crash in bdrv_release_dirty_bitmap_locked()
on assertion "assert(!bdrv_dirty_bitmap_busy(bitmap));" as we do have
busy bitmap, as bitmap migration is ongoing.

We'll fix bitmap migration to gracefully cancel on early shutdown soon.
Now let's fix iotest 194 to wait migration completion before shutdown.

Note that in this test dest_vm.shutdown() is called implicitly, as vms
used as context-providers, see __exit__() method of QEMUMachine class.

Actually, not waiting migration finish is a wrong thing, but the test
started to crash after commit ae00aa239847682
"iotests: 194: test also migration of dirty bitmap", which added dirty
bitmaps here. So, Fixes: tag won't hurt.

Fixes: ae00aa2398476824f0eca80461da215e7cdc1c3b
Reported-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 tests/qemu-iotests/194     | 10 ++++++++++
 tests/qemu-iotests/194.out |  5 +++++
 2 files changed, 15 insertions(+)

diff --git a/tests/qemu-iotests/194 b/tests/qemu-iotests/194
index 3fad7c6c1a..6dc2bc94d7 100755
--- a/tests/qemu-iotests/194
+++ b/tests/qemu-iotests/194
@@ -87,4 +87,14 @@ with iotests.FilePath('source.img') as source_img_path, \
             iotests.log(dest_vm.qmp('nbd-server-stop'))
             break
 
+    iotests.log('Wait migration completion on target...')
+    migr_events = (('MIGRATION', {'data': {'status': 'completed'}}),
+                   ('MIGRATION', {'data': {'status': 'failed'}}))
+    event = dest_vm.events_wait(migr_events)
+    iotests.log(event, filters=[iotests.filter_qmp_event])
+
+    iotests.log('Check bitmaps on source:')
     iotests.log(source_vm.qmp('query-block')['return'][0]['dirty-bitmaps'])
+
+    iotests.log('Check bitmaps on target:')
+    iotests.log(dest_vm.qmp('query-block')['return'][0]['dirty-bitmaps'])
diff --git a/tests/qemu-iotests/194.out b/tests/qemu-iotests/194.out
index dd60dcc14f..f70cf7610e 100644
--- a/tests/qemu-iotests/194.out
+++ b/tests/qemu-iotests/194.out
@@ -21,4 +21,9 @@ Gracefully ending the `drive-mirror` job on source...
 {"data": {"device": "mirror-job0", "len": 1073741824, "offset": 1073741824, "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 Stopping the NBD server on destination...
 {"return": {}}
+Wait migration completion on target...
+{"data": {"status": "completed"}, "event": "MIGRATION", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+Check bitmaps on source:
+[{"busy": false, "count": 0, "granularity": 65536, "name": "bitmap0", "persistent": false, "recording": true, "status": "active"}]
+Check bitmaps on target:
 [{"busy": false, "count": 0, "granularity": 65536, "name": "bitmap0", "persistent": false, "recording": true, "status": "active"}]
-- 
2.21.0


