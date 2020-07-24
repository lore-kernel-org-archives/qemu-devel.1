Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 100ADC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 08:47:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCED12068F
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 08:47:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="t5rdfjHJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCED12068F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59362 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jytMY-0008Dw-Vu
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 04:47:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38312)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jytJ7-0001Vv-50; Fri, 24 Jul 2020 04:43:57 -0400
Received: from mail-eopbgr60095.outbound.protection.outlook.com
 ([40.107.6.95]:40593 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jytJ4-0008Mg-Cw; Fri, 24 Jul 2020 04:43:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lAR7qXLRXHLT1fhBHlF6tx0G3AQCrZByk03koEQVZXN9FnZlOISPovlREVwzcUvzE/J23Ns6nyjEZNwZpGKcYEjd7A1v02q8nvvrIGGm0lDNTQgwNZYqhzcFiXIK2W0wIkq409FM4wj2g20oiKESEMZCrZ0/QEjghroNmhxvoXKDjiCJV92hDEFEY2GFKHe/pZPcUVmXps5e/qo5oSXSnV2zkvdfv7WePwDt/+l0pAQpmep4YUG1okzFukNy6ih4F0GJXPys6ppx3LUKVCi03NgXVM6zlgE0CjvQY6xZ3d6uOZH4/nRxG+3VM/W2OeWIOrHN9FZBXJ5BEfxYmWtG9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KIUczuyo7ZVpEctMGRMGsSWl8WOF68jEM2Gk2nPLJCU=;
 b=GEwWWf7apq1k1meUb5DvvNeEkW++RIVXu9pk5w9E0064NpwqXfgvfQnNNSlWQHJtFrgZ0BijtwMnsq955+SPzQFsweOUqXX6P3jPNm+mDzh3FM9TGI3KpnV1e2fJ9nT+PUbCZU+ca6awnfk2bKKwdruEj+cfKGTgvDr4gdG3wrS/Mso65FILT9fPvfoOo6psh5Mo7o306X7z5Jf3jTYREm2SMf2q6o2n/g+cWmsFo/Nckw1qQpeZaR+qLWE+bfZluLFZ4009PiV+bfH/sK8Pkm5QoA26A537jjduqxSvS9OpkIxOoFICkwCrfPgxkn65NOAjq+l+4knTxPj+9GXMGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KIUczuyo7ZVpEctMGRMGsSWl8WOF68jEM2Gk2nPLJCU=;
 b=t5rdfjHJNxgUm5BpYyvwnn62HfeZ9qjl6pXNqsDPd3gDiOi+vn2iu/CWFoPdUvHEfpmHBID01o/R8AEZ9qzQLrKIixrCI14m8oA/MPjYMXEuUOo3zfUmtYjhvuUK1HjHFju/kORhJPcjpoaO7qAAEz2KQTxeVR8KYDN+uA0wJkM=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4849.eurprd08.prod.outlook.com (2603:10a6:20b:c3::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Fri, 24 Jul
 2020 08:43:45 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%4]) with mapi id 15.20.3216.024; Fri, 24 Jul 2020
 08:43:45 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v3 03/21] qemu-iotests/199: better catch postcopy time
Date: Fri, 24 Jul 2020 11:43:09 +0300
Message-Id: <20200724084327.15665-4-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200724084327.15665-1-vsementsov@virtuozzo.com>
References: <20200724084327.15665-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR01CA0160.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:aa::29) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (185.215.60.156) by
 AM0PR01CA0160.eurprd01.prod.exchangelabs.com (2603:10a6:208:aa::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.21 via Frontend
 Transport; Fri, 24 Jul 2020 08:43:44 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.156]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d91cfacd-c768-4a43-5d8b-08d82fadad30
X-MS-TrafficTypeDiagnostic: AM6PR08MB4849:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB4849EA32CC3D641C33CCE22DC1770@AM6PR08MB4849.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:175;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RhaQCukjG5OSpL5azgx1zMTxASzOjgD8w9vWRSHG0w+9v6sg3dayQFUToOIH3Hvd2JCsm4SQASL8ptv/20rPQpwdOqYB/Ao/QKN+1MQKFbNPLaImdpzqzaryRYG8cb574bEnOfwVOkzAx9eL0tg8bucoPx7qu//JCIJenmXzd6a7VeOxpnEI1SUBczGRAOTX+FZPte8iTAuwT89Cq5DagBGizcHvjkWz9zCSV+7jp57ps4WupTqVbt3D2dSe6v5GMyIIgvaWx2+9Y3TtmJ225EVzEfKDcryHEv2ec8DQO5lkbaXkq47dsfK4R2RwrjHFU02yPNqsxyh3mtfA5O1n9rwzHN9Gn8cAOuaUURNoweGLgFZ2kOcYJw6zqXSv+wmC
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39840400004)(136003)(346002)(396003)(366004)(376002)(26005)(6916009)(6512007)(478600001)(2616005)(6666004)(316002)(4326008)(186003)(6506007)(956004)(16526019)(86362001)(83380400001)(1076003)(6486002)(66946007)(36756003)(69590400007)(8936002)(107886003)(2906002)(52116002)(5660300002)(7416002)(8676002)(66556008)(66476007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: NZCsCfx5tKguTirQkPcbgcv5JTo1Tyr1eARDuSKiEwynzkNIc0GVRYpVGS4eAxM2YNfcH3zCADnv1bqfRijbN4BuqkZbE7eyN7xhrnXgIiBZp1e2O+lDTLqi0h9Unlw//hJatDKgio4HUAPNMIbBXDtZT7emmy4QNIDBAUsNaCmJPuwfmikL9NTwRYhaI2ZdWpFwSudiYTNaH04yurle3P5GZo/txtOfwwbo0abUnmaE10HH5Abz8Y2vz7uW2CefK+M7Hig5/LG6eurJnlYP8+x6DGenYG4mkCgYGR5RDep3YfISf3W5ycbcgEq6At7ltQy68ZNAWwh8swa7lfar5WQURfc6l0u8sh82MXEJUgAvLjdfZnE6AI4sCaSjoYc5eYPq00NBSb+NcHCzHyRy23X6SlBMGj6srAxlc24mbUEdBBQTT/iuWQH7GAYdw76wX1hPP1JuLAf/qCF6w/fBh5EDed44UkrH+e1XJkGPYdY=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d91cfacd-c768-4a43-5d8b-08d82fadad30
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2020 08:43:45.5605 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QebCed8D5WSO5Kmd8WA+WLWAjXPXH7qSXhu/bmEDDKmM3/8Cj1unBsSiWPzC6dlJpsAHqoph0+zWk902b0lANt5eTwllj2v6oRzYN9u0Bes=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4849
Received-SPF: pass client-ip=40.107.6.95;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-DB3-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/24 04:43:44
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
 stefanha@redhat.com, andrey.shinkevich@virtuozzo.com, den@openvz.org,
 mreitz@redhat.com, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The test aims to test _postcopy_ migration, and wants to do some write
operations during postcopy time.

Test considers migrate status=complete event on source as start of
postcopy. This is completely wrong, completion is completion of the
whole migration process. Let's instead consider destination start as
start of postcopy, and use RESUME event for it.

Next, as migration finish, let's use migration status=complete event on
target, as such method is closer to what libvirt or another user will
do, than tracking number of dirty-bitmaps.

Finally, add a possibility to dump events for debug. And if
set debug to True, we see, that actual postcopy period is very small
relatively to the whole test duration time (~0.2 seconds to >40 seconds
for me). This means, that test is very inefficient in what it supposed
to do. Let's improve it in following commits.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Tested-by: Eric Blake <eblake@redhat.com>
---
 tests/qemu-iotests/199 | 72 +++++++++++++++++++++++++++++++++---------
 1 file changed, 57 insertions(+), 15 deletions(-)

diff --git a/tests/qemu-iotests/199 b/tests/qemu-iotests/199
index dda918450a..dd6044768c 100755
--- a/tests/qemu-iotests/199
+++ b/tests/qemu-iotests/199
@@ -20,17 +20,43 @@
 
 import os
 import iotests
-import time
 from iotests import qemu_img
 
+debug = False
+
 disk_a = os.path.join(iotests.test_dir, 'disk_a')
 disk_b = os.path.join(iotests.test_dir, 'disk_b')
 size = '256G'
 fifo = os.path.join(iotests.test_dir, 'mig_fifo')
 
 
+def event_seconds(event):
+    return event['timestamp']['seconds'] + \
+        event['timestamp']['microseconds'] / 1000000.0
+
+
+def event_dist(e1, e2):
+    return event_seconds(e2) - event_seconds(e1)
+
+
 class TestDirtyBitmapPostcopyMigration(iotests.QMPTestCase):
     def tearDown(self):
+        if debug:
+            self.vm_a_events += self.vm_a.get_qmp_events()
+            self.vm_b_events += self.vm_b.get_qmp_events()
+            for e in self.vm_a_events:
+                e['vm'] = 'SRC'
+            for e in self.vm_b_events:
+                e['vm'] = 'DST'
+            events = (self.vm_a_events + self.vm_b_events)
+            events = [(e['timestamp']['seconds'],
+                       e['timestamp']['microseconds'],
+                       e['vm'],
+                       e['event'],
+                       e.get('data', '')) for e in events]
+            for e in sorted(events):
+                print('{}.{:06} {} {} {}'.format(*e))
+
         self.vm_a.shutdown()
         self.vm_b.shutdown()
         os.remove(disk_a)
@@ -47,6 +73,10 @@ class TestDirtyBitmapPostcopyMigration(iotests.QMPTestCase):
         self.vm_a.launch()
         self.vm_b.launch()
 
+        # collect received events for debug
+        self.vm_a_events = []
+        self.vm_b_events = []
+
     def test_postcopy(self):
         write_size = 0x40000000
         granularity = 512
@@ -77,15 +107,13 @@ class TestDirtyBitmapPostcopyMigration(iotests.QMPTestCase):
             self.vm_a.hmp_qemu_io('drive0', 'write %d %d' % (s, chunk))
             s += 0x10000
 
-        bitmaps_cap = {'capability': 'dirty-bitmaps', 'state': True}
-        events_cap = {'capability': 'events', 'state': True}
+        caps = [{'capability': 'dirty-bitmaps', 'state': True},
+                {'capability': 'events', 'state': True}]
 
-        result = self.vm_a.qmp('migrate-set-capabilities',
-                               capabilities=[bitmaps_cap, events_cap])
+        result = self.vm_a.qmp('migrate-set-capabilities', capabilities=caps)
         self.assert_qmp(result, 'return', {})
 
-        result = self.vm_b.qmp('migrate-set-capabilities',
-                               capabilities=[bitmaps_cap])
+        result = self.vm_b.qmp('migrate-set-capabilities', capabilities=caps)
         self.assert_qmp(result, 'return', {})
 
         result = self.vm_a.qmp('migrate', uri='exec:cat>' + fifo)
@@ -94,24 +122,38 @@ class TestDirtyBitmapPostcopyMigration(iotests.QMPTestCase):
         result = self.vm_a.qmp('migrate-start-postcopy')
         self.assert_qmp(result, 'return', {})
 
-        while True:
-            event = self.vm_a.event_wait('MIGRATION')
-            if event['data']['status'] == 'completed':
-                break
+        event_resume = self.vm_b.event_wait('RESUME')
+        self.vm_b_events.append(event_resume)
 
         s = 0x8000
         while s < write_size:
             self.vm_b.hmp_qemu_io('drive0', 'write %d %d' % (s, chunk))
             s += 0x10000
 
+        match = {'data': {'status': 'completed'}}
+        event_complete = self.vm_b.event_wait('MIGRATION', match=match)
+        self.vm_b_events.append(event_complete)
+
+        # take queued event, should already been happened
+        event_stop = self.vm_a.event_wait('STOP')
+        self.vm_a_events.append(event_stop)
+
+        downtime = event_dist(event_stop, event_resume)
+        postcopy_time = event_dist(event_resume, event_complete)
+
+        # TODO: assert downtime * 10 < postcopy_time
+        if debug:
+            print('downtime:', downtime)
+            print('postcopy_time:', postcopy_time)
+
+        # Assert that bitmap migration is finished (check that successor bitmap
+        # is removed)
         result = self.vm_b.qmp('query-block')
-        while len(result['return'][0]['dirty-bitmaps']) > 1:
-            time.sleep(2)
-            result = self.vm_b.qmp('query-block')
+        assert len(result['return'][0]['dirty-bitmaps']) == 1
 
+        # Check content of migrated (and updated by new writes) bitmap
         result = self.vm_b.qmp('x-debug-block-dirty-bitmap-sha256',
                                node='drive0', name='bitmap')
-
         self.assert_qmp(result, 'return/sha256', sha256)
 
 
-- 
2.21.0


