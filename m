Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A413CC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 08:50:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E0C5206C1
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 08:50:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="AIxMhUjB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E0C5206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46722 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jytPe-00060P-Mg
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 04:50:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38380)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jytJE-0001ox-5z; Fri, 24 Jul 2020 04:44:04 -0400
Received: from mail-eopbgr60129.outbound.protection.outlook.com
 ([40.107.6.129]:11111 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jytJC-0008Q9-BF; Fri, 24 Jul 2020 04:44:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F9XNbhv5Vhtau4h8KZvyQ7JhH6jwdOiUezPFbXHQKEm8x0DTkO/R8wOet3QlP+R6e5QBQfyTOz3UhN6j6iKO0lr3sH91r9LF8VOSa98ZBz5BVWC/SPIT4qZ6X7v9euVD7MUQrsrDiC0rNDeNNX9+qQe+Hn3T4noZ+vEu5gZYXxc/4dx7wyCc1uqfjOAOpQqKMlBGmUuqxKGamTYhP4UTExhb0vOTJMZVHqODtJcPTmKtV8H/76wFFnhU83t/k+U2tlW247o1jIqsc1ROT3tT5siyVc7J0EMImV/uNwdhf1zR3LfZIZnr2C8lF4Iy2+LDtUWB7k9UP/sGrPwCCrTQ8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5AhUpV3MYskLeHU9yF+RfQsLqcAE8vCSwXUPMiKsp7s=;
 b=aLkRo9Uopm47aYQuZHN/WjU3s3azmomZ8FKtMsLhNMfda/yB9JLeixyaoKd6N6NHYHWz88LmGumDIRjAk603Id7WoJhWUCP8iCyPl/zItoumafD4uyGuVsu4m47Ha9NpR2Msv9434VYHNqUtCMogJeYzM9zDfuR59HR0x6W9CfOlvgZANEZf/lhOpu+yrq52IZBOaRZCadkFnE6nE+of4lwBJlGFOebUsom292FCKlSQv9X8jUyVVBzxiQgnitYNRAbQjVh5k9WBt4CQIGjatBerTaT4NApvswPPby19dnbf+3B9v8M/ED/VlaHu6k1ZOWxz+LXY33VIBzQ8wfXrsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5AhUpV3MYskLeHU9yF+RfQsLqcAE8vCSwXUPMiKsp7s=;
 b=AIxMhUjBPpn7RroZWUKj7oksX9yWFJFaey5Sce+pXiMSWkT0DE4/jHNDrSR3dk+87/b3Sr9UIdIErWFPJsIP+ASPjxHTIqIOI6Qa9nqXGifFwkUxpc1HaqfaDs+95sehwH1Z2+weWcgfaqt/FLZUA871Dwp6arTxbw/cTK4ckSw=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4849.eurprd08.prod.outlook.com (2603:10a6:20b:c3::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Fri, 24 Jul
 2020 08:44:00 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%4]) with mapi id 15.20.3216.024; Fri, 24 Jul 2020
 08:44:00 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v3 18/21] qemu-iotests/199: prepare for new test-cases addition
Date: Fri, 24 Jul 2020 11:43:24 +0300
Message-Id: <20200724084327.15665-19-vsementsov@virtuozzo.com>
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
 Transport; Fri, 24 Jul 2020 08:43:59 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.156]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 02c61422-8edb-455a-c717-08d82fadb5bc
X-MS-TrafficTypeDiagnostic: AM6PR08MB4849:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB4849C1E54F51A5EB0B6E159CC1770@AM6PR08MB4849.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:386;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yknKrdUHDRto/cYT6lue26LhyVTrEE1IkaeH7ipi0+r9KUhqxG/XDzyuQkRknjtGY9XVq4kknhWstmJlauNiww2y2bbiLA8O9V0N1eOGJFhkdLX+mtNusYiR0SAUqjDGkcijK0Rsi8EaSAavWL+aXyxauRApZwUQeeP+CIFzi3RyfUkbI0hVfpB4HJ3OJs9YGS13hhkTHWUFvsa6yJ58oeC9hzbL6pYURyeSKLP7uZ5+uHbjrrVp62t3RpReeTWzza5iu5tBZDOg3CTtP4DU+wzSaV8m5mAq28p/bvCZCY/ab3XBt/dyos0Tq+VtedZOIWfT1x4YSTV2KT077MpibtftLUNgW91w/Q7XonfnippmEShwthAJJC8w4Wv2Gxba
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39840400004)(136003)(346002)(396003)(366004)(376002)(26005)(6916009)(6512007)(478600001)(2616005)(6666004)(316002)(4326008)(186003)(6506007)(956004)(16526019)(86362001)(83380400001)(1076003)(6486002)(66946007)(36756003)(69590400007)(8936002)(107886003)(2906002)(52116002)(5660300002)(7416002)(8676002)(66556008)(66476007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: Cenvmj+kqIGc06T9FknbD7K7EN5WVd+xsdmw3232fUlvcrS5dM0/v6WESRvQfL46zdcaDH5uyY4OlvbehRP7HZv0/BaKMgGEdOYjOepnZ9CuL+0FICoJAdWYfP9xlbUiDiSocuoCpqpSzWTTrFH7x7p5weZDWFJBONldneO6WPmEBTJtrQgegMciLgfXAw2oC9iBdnnMDJ8Tg0pcBVRvUWP8df+mQ+BP6Gj7MRG02eYdEJ2PiQZP/k9boS+uNZm8w0t3txUNA7hlnpQnm+Gv0eHzWF6QTiPtYiPIgM0hJvuO80rB/S1j9pbFrx2M/JAKW+GNY/zgM9VIyxYMsW6mrmLWlA3OimGofqY6s78vlnjJ/IfaD29tpOr5WTungaYQCvdxlmYCXk+WXy8lY6/276ygkmWUFaizoiprYkcrVaqfOk297YI4Aoxw7uh0BIvzgwqeqPmaFOAiIP9xBbU7cotU7eQWjFZXfAob1F28dp8=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02c61422-8edb-455a-c717-08d82fadb5bc
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2020 08:43:59.8995 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U3maIgyYbwSKZtREA/NIGQKnngUhs69c4xh9+87haleDbflVaG7/SM+rsyO29hOn/orcXw2sRqc3V9Hl0tzsBm6vwJt4n2FzuIZ3Tw5F5ws=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4849
Received-SPF: pass client-ip=40.107.6.129;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-DB3-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/24 04:44:00
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

Move future common part to start_postcopy() method. Move checking
number of bitmaps to check_bitmap().

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
---
 tests/qemu-iotests/199 | 36 +++++++++++++++++++++++-------------
 1 file changed, 23 insertions(+), 13 deletions(-)

diff --git a/tests/qemu-iotests/199 b/tests/qemu-iotests/199
index d8532e49da..355c0b2885 100755
--- a/tests/qemu-iotests/199
+++ b/tests/qemu-iotests/199
@@ -29,6 +29,8 @@ disk_b = os.path.join(iotests.test_dir, 'disk_b')
 size = '256G'
 fifo = os.path.join(iotests.test_dir, 'mig_fifo')
 
+granularity = 512
+nb_bitmaps = 15
 
 GiB = 1024 * 1024 * 1024
 
@@ -61,6 +63,15 @@ def event_dist(e1, e2):
     return event_seconds(e2) - event_seconds(e1)
 
 
+def check_bitmaps(vm, count):
+    result = vm.qmp('query-block')
+
+    if count == 0:
+        assert 'dirty-bitmaps' not in result['return'][0]
+    else:
+        assert len(result['return'][0]['dirty-bitmaps']) == count
+
+
 class TestDirtyBitmapPostcopyMigration(iotests.QMPTestCase):
     def tearDown(self):
         if debug:
@@ -101,10 +112,8 @@ class TestDirtyBitmapPostcopyMigration(iotests.QMPTestCase):
         self.vm_a_events = []
         self.vm_b_events = []
 
-    def test_postcopy(self):
-        granularity = 512
-        nb_bitmaps = 15
-
+    def start_postcopy(self):
+        """ Run migration until RESUME event on target. Return this event. """
         for i in range(nb_bitmaps):
             result = self.vm_a.qmp('block-dirty-bitmap-add', node='drive0',
                                    name='bitmap{}'.format(i),
@@ -119,10 +128,10 @@ class TestDirtyBitmapPostcopyMigration(iotests.QMPTestCase):
 
         result = self.vm_a.qmp('x-debug-block-dirty-bitmap-sha256',
                                node='drive0', name='bitmap0')
-        discards1_sha256 = result['return']['sha256']
+        self.discards1_sha256 = result['return']['sha256']
 
         # Check, that updating the bitmap by discards works
-        assert discards1_sha256 != empty_sha256
+        assert self.discards1_sha256 != empty_sha256
 
         # We want to calculate resulting sha256. Do it in bitmap0, so, disable
         # other bitmaps
@@ -135,7 +144,7 @@ class TestDirtyBitmapPostcopyMigration(iotests.QMPTestCase):
 
         result = self.vm_a.qmp('x-debug-block-dirty-bitmap-sha256',
                                node='drive0', name='bitmap0')
-        all_discards_sha256 = result['return']['sha256']
+        self.all_discards_sha256 = result['return']['sha256']
 
         # Now, enable some bitmaps, to be updated during migration
         for i in range(2, nb_bitmaps, 2):
@@ -160,6 +169,10 @@ class TestDirtyBitmapPostcopyMigration(iotests.QMPTestCase):
 
         event_resume = self.vm_b.event_wait('RESUME')
         self.vm_b_events.append(event_resume)
+        return event_resume
+
+    def test_postcopy_success(self):
+        event_resume = self.start_postcopy()
 
         # enabled bitmaps should be updated
         apply_discards(self.vm_b, discards2)
@@ -180,18 +193,15 @@ class TestDirtyBitmapPostcopyMigration(iotests.QMPTestCase):
             print('downtime:', downtime)
             print('postcopy_time:', postcopy_time)
 
-        # Assert that bitmap migration is finished (check that successor bitmap
-        # is removed)
-        result = self.vm_b.qmp('query-block')
-        assert len(result['return'][0]['dirty-bitmaps']) == nb_bitmaps
+        check_bitmaps(self.vm_b, nb_bitmaps)
 
         # Check content of migrated bitmaps. Still, don't waste time checking
         # every bitmap
         for i in range(0, nb_bitmaps, 5):
             result = self.vm_b.qmp('x-debug-block-dirty-bitmap-sha256',
                                    node='drive0', name='bitmap{}'.format(i))
-            sha256 = discards1_sha256 if i % 2 else all_discards_sha256
-            self.assert_qmp(result, 'return/sha256', sha256)
+            sha = self.discards1_sha256 if i % 2 else self.all_discards_sha256
+            self.assert_qmp(result, 'return/sha256', sha)
 
 
 if __name__ == '__main__':
-- 
2.21.0


