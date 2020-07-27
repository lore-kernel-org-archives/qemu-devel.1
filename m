Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F721C433E4
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 19:45:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49CF320672
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 19:45:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="giGLJLVb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49CF320672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46532 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k093v-0006mT-I6
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 15:45:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47544)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k091Y-0001g9-Gy; Mon, 27 Jul 2020 15:43:00 -0400
Received: from mail-eopbgr80131.outbound.protection.outlook.com
 ([40.107.8.131]:43617 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k091W-0003fa-L0; Mon, 27 Jul 2020 15:43:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f2HvXOCXsOUpEXPy8P2pr7ytxTtOovJ/8c2bh5RlvI9qQG9jw0Y5cL6r8xaF62QiD/vPYUdiWz2gL7Cvp+ex5Lq84DmivWC8dzz131iRFn7VeIx28wn0N4pO1Bw8a3Bg1l7GjR0AtDvbw2uWi1rOAWzDIYMtfoMm5PSn4aohuqENiOhBul656iInXjeayJJ4+ceLMU0Do2YUHRb+bWDu0quV8ZD+uddFmKGcFM7x0MX44Gzoehqtp8SgZZJASYIBRIJpUH3+1uwUgnDL+I+b299hjrs2YdHv6+LCZb68CkX+L/JPCD3I7qPW/OxHHkmqfjfOFXDejtJgDkaMxbUcfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KIUczuyo7ZVpEctMGRMGsSWl8WOF68jEM2Gk2nPLJCU=;
 b=EKOoMjer18GaBkYWvRV8CWdYHM7jNiylcadGHcIg5NVNRvy0dirwLy5EkA7E9OFWGXIJIEL927d33ZtnqFk6tD51uGz5xkvHDcmuefghfTBM2lEHT0AfFy+vcX+kqfwHQCrgZRFYa7H08tiyTARyg/BAjHVPwzJaywFK5xhomJIkbFva8pvqpOpp0bX+kF2JYZrz1kS2ZPkuRNhZfIZHz/n77bE6efJbCNtQfZ3/TdeXYJFDi7xApWLu6yJ4x2E3ad7QeIajQ804gWIZQbovNn7kEwBylnJuoG9bK0gB7QBYiRhmdFw03+GATrOjlH/abxwatfLT/cZbrmq07wbQyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KIUczuyo7ZVpEctMGRMGsSWl8WOF68jEM2Gk2nPLJCU=;
 b=giGLJLVb0yJRkawysFyjT0jFrS+hRXi9McRn/Q9djyElMLBkCkqGSxHJHMJQFbhW9Cea4UcQHiDPAfu78QvpDKx1BRpDmAo9SvTNyl7l6r6X0MfA+p+zyZ1nh6LB14lAgGaqWpfavcW0w1wvAUxqQ3RVmUikI3H1bDY9KOjU5BM=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM5PR0802MB2610.eurprd08.prod.outlook.com (2603:10a6:203:97::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.23; Mon, 27 Jul
 2020 19:42:52 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%4]) with mapi id 15.20.3216.033; Mon, 27 Jul 2020
 19:42:52 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v4 03/21] qemu-iotests/199: better catch postcopy time
Date: Mon, 27 Jul 2020 22:42:18 +0300
Message-Id: <20200727194236.19551-4-vsementsov@virtuozzo.com>
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
 Transport; Mon, 27 Jul 2020 19:42:51 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.158]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 089ff93b-1330-483a-4f5e-08d83265404a
X-MS-TrafficTypeDiagnostic: AM5PR0802MB2610:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM5PR0802MB261005A04A4EF0FC552C65BAC1720@AM5PR0802MB2610.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:175;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bhGIo1GNHHAkoMrjHNH6dTXEOwVBl7eU1JDXaFqUyKEpG6RdOLtanH7Llxy47at7tSNJuqRL1G6lH8goXJ1adsh0xYHhlagjVGrNXa2mR3Eqnygzf7xYf+j8iZJrmM5/v3HW6gyFTvodtDp0hz51MznZEqfA9YBeafbi+ML3oaR19HvMXmQQBNZqWjyo1GTVr7+OxjVeqpWF+yPnfQ73j2MOK78ilDN0k8a1V29IM3DhU6vB/4rrSikVyOCmYfGgZkvlT0GV0Omzs1Zf/JFYtLvPuoTVK/g8OOF8xh4j5bwidke9c5KDx1iRTJiZH0r6+//0fYtTfY83MrSaCBtUiQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(366004)(376002)(39840400004)(346002)(66556008)(1076003)(66476007)(6512007)(107886003)(86362001)(36756003)(52116002)(4326008)(26005)(2616005)(2906002)(66946007)(8676002)(7416002)(16526019)(6666004)(316002)(6916009)(6486002)(956004)(83380400001)(6506007)(5660300002)(478600001)(186003)(8936002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: wpddMtOpmZNPztEvqRNgqITIuzz8PklXsymkqWN1Jx9HYtPCq01j64Dotr8VBE3amp73CU8QRQODdEctuwow7Dln+d/ZcmwGFPOmKN9DG5Gy/O9j8PSn5joCGsE4iDPMKXyavACC7vBGDQI2bGSbaMyN1LPWFcrpF7VO8ndtPVFpQ3z1b4VGwM3xa80srep9b06MBvsvk2tiJJAvE8oVNmGHAoF74R9mpdsZlqldhJuh+GfQpxOI6Ts3GkudlcYErwrVVIF+Dxz69NDaLZmjONYIL3SyUsYWektPiRDQ2iMK4cXyChQRA4Lj2lI4fjPu8xfzqeBslV9/gMJBNs4Hi8B6zPRdsA+6Q1GzfmVb/kmEonS9SAfToqgsmK8r3z/+7HmPhGzIDpOE7UYWzzXcxfrSfBJcpCHqDSdYcFSdFGirbHi2V6C7pEdPC0NAKpOrAi6I6fM9hRquUKztLWTgA+ZQ0RnVhoMLwWMvv4N9Kt8=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 089ff93b-1330-483a-4f5e-08d83265404a
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2020 19:42:52.6584 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YVDuedSDqEBn9gs1O8WPz0cyOAJPgdUB4x/nA/TEkNitq2SGNrpDM4pX0XIfiOLKnkoTWHGTFEjciMXdw4X4SiLkyJTo76XVgKyuuNXI63w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0802MB2610
Received-SPF: pass client-ip=40.107.8.131;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 15:42:50
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


