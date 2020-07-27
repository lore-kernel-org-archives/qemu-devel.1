Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E8DEC433E5
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 19:44:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55A6620738
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 19:44:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="DCiL8sKU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55A6620738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42902 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k093F-0005Jt-J2
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 15:44:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47600)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k091e-0001mO-6j; Mon, 27 Jul 2020 15:43:06 -0400
Received: from mail-eopbgr80137.outbound.protection.outlook.com
 ([40.107.8.137]:20036 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k091a-0003fu-6B; Mon, 27 Jul 2020 15:43:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i9uTKMHucuhBz8vqTXEal0attFQDe/R7qU2eMcaYkRdsN0fwqVOvvCQ96rlcOq3Cu0Cnne00UJRdeRWgs7CFh5ozt+LcRCdS90OaYfAf237ng5i6yNtkdkdcDjAAOE5u51+Mrwzt3qQwDfBjYvgDY+1WQHuTPtVIxA4axLBPcR77Ej9LRBxNywAFGyLiV/9SBquVSEMS82oFyS5Ean0+nOwxV26Z3mDLjiW/FbCvgxkh2KVAVLUVAVPV03CvTFO3BcmF3rY/js95Xi6IXxLJWtDBRope0KTVUOWXOUXZETSAWqy1kaWapvtxW4hUiP7ouzye+g1GgbR87kVv/2pK+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ag2OZSd4XEK0WPwnOZnDuD4ozl6LXYHngLXM4paMDsk=;
 b=LV72lPy2ApkCW/Ych3YTGbEYakasv7Z7hsdlzDQ6x1vqvvPvWBAcrGty5/Wo1ljROPCsPfD8mWy6udgUsoJtaQmrGxV0G4gz1W2f/diGo0VyXSLXbLEKVwSipDDj4uxdFdXA910SUMnbygU5s/wxeL3WEE95AGc1j3hWHrFZJ/hgXZfsvlBZ1KuDytQcHTW48wWl44Lo8QDBRqlaXBu7lL8Gu/gQ4yW2fPoNQaBWMoYjtHAcAmjzdlniz1UskOGhmLgXH3pc0jtPDyHxATJElD5jBMbfH6f8pFQvMBf9ak+Od4HxEr47uLnOR+jq0kTnht1Pci81pWya42gNsjPssw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ag2OZSd4XEK0WPwnOZnDuD4ozl6LXYHngLXM4paMDsk=;
 b=DCiL8sKUq4ZmBHP6SnKhfVxRLY5bLIcQoSwMe82DtAIP4g6A5qHs+ySKAFk0BtksxUTN2yyYpHWu+R1EeTDXacPgm0WP+1mGhsQ1RQIqXEoPUlzLwRWWku/MUZyRFbcUzyQbmP41U3+9qOfXxpHY3j7kezNOsUUTpUPSmJFsgxs=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM5PR0802MB2610.eurprd08.prod.outlook.com (2603:10a6:203:97::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.23; Mon, 27 Jul
 2020 19:42:54 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%4]) with mapi id 15.20.3216.033; Mon, 27 Jul 2020
 19:42:54 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v4 05/21] qemu-iotests/199: change discard patterns
Date: Mon, 27 Jul 2020 22:42:20 +0300
Message-Id: <20200727194236.19551-6-vsementsov@virtuozzo.com>
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
 Transport; Mon, 27 Jul 2020 19:42:53 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.158]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 36fba14b-bd13-4326-4e05-08d83265417a
X-MS-TrafficTypeDiagnostic: AM5PR0802MB2610:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM5PR0802MB26109455D206458B44F59CD0C1720@AM5PR0802MB2610.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:34;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +P4kbIcniExNK09Nbkuj4tE1NlMWvFCdlwy17JcxVnQumtm9WLTbQ423bl/4BdjTB7YWqbSp276EuTXJq4d+1iJfEubMOuKcuLcma32AWBpNTCnIfM4BYM0RoEpzVqPVeiFJwpcx+mGJcNEizatLa5O2ZCoPO4DlyxIm+57QPRo5d0XPC+jE+ZvwaUKfaBGgbt+qmKzV9+UsoPOYZJWPtFfD+K7+Phw5ShOIRJVMbRJ+o9Mky1fx+1UDxf3Mhe6YWLxfG6C71X6KN1xj5zosDQmV18C9AIe5lOEMJkWD2RW1j9E53pnTBJvpi539iG0P5BO44mc2j7NTwK8/GxtYFg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(366004)(376002)(39840400004)(346002)(66556008)(1076003)(66476007)(6512007)(107886003)(86362001)(36756003)(52116002)(4326008)(26005)(2616005)(2906002)(66946007)(8676002)(7416002)(16526019)(6666004)(316002)(6916009)(6486002)(956004)(83380400001)(6506007)(5660300002)(478600001)(186003)(8936002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: h5Ys0Yg20wy12YjWJy3lWRs323KMlaUlIlPEYuSqO6I0hhdGsbInoyLfWZ+9xwm2OFFlK20JhlMdZzWqdZrDJ4ZD0Y9rt51PNuY2z2WzCVVLtJeIrXWpXd5vro/RqEmY8wf/75tJXTySd6S7uDJFD7wGhPlpsIlHJeAadugG+ycmfWRd+ArCWgcwV44oePVVciGeAPVgLW1yVXZK/3AJFlMCo90kru3Nhu06wVPu9HqAVf83zWHoEGnq9QuNW+15YVSNw/nCSUZSN1ctXStYm3U4/3JME5kuPd30DA84jD5vD3NSSn2ITCEmBjxtAnMGyU8lfW6hmYO4bkn8XbbdV2+Uj8tzgv3g/tk1nBmr/JFmQaJiYoAQe+glbdctqbAZ09luacWk+c/AipH89hlVowt/1USQy03gbwQ4hqnINzV0V16ivugaDWIw2k/OZ7i2mEAc+JONAMydP7F0CV4EHZwnHpRbYpV9jpWu3j6PeJI=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36fba14b-bd13-4326-4e05-08d83265417a
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2020 19:42:54.6138 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kAMOMymLql1iDMAr+2nzdAtz3lVO5QevTk6Q6v7BQtDwWosMy2+FgSLtzVuWeFCty+OXSVR4pL26Wq1zyCYMsFZ1jGe9VVj6GRrMg0NV5xc=
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

iotest 199 works too long because of many discard operations. At the
same time, postcopy period is very short, in spite of all these
efforts.

So, let's use less discards (and with more interesting patterns) to
reduce test timing. In the next commit we'll increase postcopy period.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Tested-by: Eric Blake <eblake@redhat.com>
---
 tests/qemu-iotests/199 | 44 +++++++++++++++++++++++++-----------------
 1 file changed, 26 insertions(+), 18 deletions(-)

diff --git a/tests/qemu-iotests/199 b/tests/qemu-iotests/199
index 190e820b84..da4dae01fb 100755
--- a/tests/qemu-iotests/199
+++ b/tests/qemu-iotests/199
@@ -30,6 +30,28 @@ size = '256G'
 fifo = os.path.join(iotests.test_dir, 'mig_fifo')
 
 
+GiB = 1024 * 1024 * 1024
+
+discards1 = (
+    (0, GiB),
+    (2 * GiB + 512 * 5, 512),
+    (3 * GiB + 512 * 5, 512),
+    (100 * GiB, GiB)
+)
+
+discards2 = (
+    (3 * GiB + 512 * 8, 512),
+    (4 * GiB + 512 * 8, 512),
+    (50 * GiB, GiB),
+    (100 * GiB + GiB // 2, GiB)
+)
+
+
+def apply_discards(vm, discards):
+    for d in discards:
+        vm.hmp_qemu_io('drive0', 'discard {} {}'.format(*d))
+
+
 def event_seconds(event):
     return event['timestamp']['seconds'] + \
         event['timestamp']['microseconds'] / 1000000.0
@@ -80,9 +102,7 @@ class TestDirtyBitmapPostcopyMigration(iotests.QMPTestCase):
         self.vm_b_events = []
 
     def test_postcopy(self):
-        discard_size = 0x40000000
         granularity = 512
-        chunk = 4096
 
         result = self.vm_a.qmp('block-dirty-bitmap-add', node='drive0',
                                name='bitmap', granularity=granularity)
@@ -92,14 +112,7 @@ class TestDirtyBitmapPostcopyMigration(iotests.QMPTestCase):
                                node='drive0', name='bitmap')
         empty_sha256 = result['return']['sha256']
 
-        s = 0
-        while s < discard_size:
-            self.vm_a.hmp_qemu_io('drive0', 'discard %d %d' % (s, chunk))
-            s += 0x10000
-        s = 0x8000
-        while s < discard_size:
-            self.vm_a.hmp_qemu_io('drive0', 'discard %d %d' % (s, chunk))
-            s += 0x10000
+        apply_discards(self.vm_a, discards1 + discards2)
 
         result = self.vm_a.qmp('x-debug-block-dirty-bitmap-sha256',
                                node='drive0', name='bitmap')
@@ -111,10 +124,8 @@ class TestDirtyBitmapPostcopyMigration(iotests.QMPTestCase):
         result = self.vm_a.qmp('block-dirty-bitmap-clear', node='drive0',
                                name='bitmap')
         self.assert_qmp(result, 'return', {})
-        s = 0
-        while s < discard_size:
-            self.vm_a.hmp_qemu_io('drive0', 'discard %d %d' % (s, chunk))
-            s += 0x10000
+
+        apply_discards(self.vm_a, discards1)
 
         caps = [{'capability': 'dirty-bitmaps', 'state': True},
                 {'capability': 'events', 'state': True}]
@@ -134,10 +145,7 @@ class TestDirtyBitmapPostcopyMigration(iotests.QMPTestCase):
         event_resume = self.vm_b.event_wait('RESUME')
         self.vm_b_events.append(event_resume)
 
-        s = 0x8000
-        while s < discard_size:
-            self.vm_b.hmp_qemu_io('drive0', 'discard %d %d' % (s, chunk))
-            s += 0x10000
+        apply_discards(self.vm_b, discards2)
 
         match = {'data': {'status': 'completed'}}
         event_complete = self.vm_b.event_wait('MIGRATION', match=match)
-- 
2.21.0


