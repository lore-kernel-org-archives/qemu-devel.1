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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C762DC433E4
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 08:45:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D54B20674
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 08:45:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="onryG/w9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D54B20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50072 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jytKW-0004Ov-Nw
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 04:45:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38280)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jytJ3-0001Md-Ka; Fri, 24 Jul 2020 04:43:53 -0400
Received: from mail-am6eur05on2134.outbound.protection.outlook.com
 ([40.107.22.134]:63329 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jytJ1-0008OD-NW; Fri, 24 Jul 2020 04:43:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W3GW5EHgxL3HxobQZTcjihkWXjRX6cdL4cmzmhbwuWmlUH39KpUV1JHaAF+t7XsFDjHyky4qRgEKETjoCeKEBEyAM6JMsdVWAg1Nqs+/d/ZZM3ivxpuB1pAWDV1cFjPIOuDvE1o2oBSJty+tS7pN/bu9wr/L6GthIufV4cWTzmWLNCwhyysLE2tWrAmUhid8OHVZXAQ+NXux1mFlsRyNUT5B3rcUcUN6x07ZUZzXeUMq45gDDBJHwT3ueQpclDZo+nyeIGxyKxiIHWWofe8ua5qRj2YOBvjZwzRAyG9n0nrilXtNG9HOZyRCIxAbFb8cfQHEO5Ol0roXE6q8GgrFmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ag2OZSd4XEK0WPwnOZnDuD4ozl6LXYHngLXM4paMDsk=;
 b=bd6IBdPnC/IjB8WTy5l8kQtzoCvQUjVoFZ8TglPqcpaPN6FVRcYkxYET7txRRRH4OdSVmRXvx3T5wLZTxS61uCqkJIXvffCNeVsuTN54iZ+Qy0uW4GjMoT4JdKu0pMV+TYFidNY1wq3DhWELGhiX1K6R6KVj2qj8Dl/vQRvuKzpe7aDvafAZ1g20BOH11ql9x4TdyRYuDzXQmsHkB/wywcWvmDY/D0Cj/3N7Sgr4bYe7kvokZ9acGCRJ8j9dYRkqshkfXmgaamDvAcILynRCPuZpamLodeE0KqpKBb7KCudYUMoF1JoLWn9OKn8s5JmFdOb3nKQqgk33B1khR4Feqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ag2OZSd4XEK0WPwnOZnDuD4ozl6LXYHngLXM4paMDsk=;
 b=onryG/w9BXq9DAu9CAXjb9ja9K838+Yo2j626kvZui9YXgIgNVvYYQuAUb8uKeZsfCZRHl6bgQPYDmT7yk/QZgcJ02wiPDu0c7zCtOiHsHeOCzJgrGCiRWE10+5IK6hf2rweYLE7/BWDlQTPY566bTDh0WOmx5/NUk7iIzP/nHs=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4534.eurprd08.prod.outlook.com (2603:10a6:20b:ba::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17; Fri, 24 Jul
 2020 08:43:47 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%4]) with mapi id 15.20.3216.024; Fri, 24 Jul 2020
 08:43:47 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v3 05/21] qemu-iotests/199: change discard patterns
Date: Fri, 24 Jul 2020 11:43:11 +0300
Message-Id: <20200724084327.15665-6-vsementsov@virtuozzo.com>
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
 Transport; Fri, 24 Jul 2020 08:43:46 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.156]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4212e3c3-28ee-4254-dcb2-08d82fadae50
X-MS-TrafficTypeDiagnostic: AM6PR08MB4534:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB4534F89CE40B6ADAD12E0A26C1770@AM6PR08MB4534.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:34;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 36JT+Kiqlv4G9wycf4B+mHj8FEH9r+kJVsJKC2e+zECDsEPgxilVB9lGaBU5swHL701eLRPOdDzND2WmxTe8xP58jQ2FbCAYS+edOj5YViDiGu7DfLDxCyedLmOp5tNtk7nkla1sVK9UKXmu0I33bfu0f7tPyhbVfqu93FigAUWRjzjokFD6dv86vz7Ie/WiQ8sNkzjzw8blcd2jdEBcg6fgrmPZftyNBNaB47N8plDNvGPLAYGBYQIzS8QbeoSxC9SRCHT9H/i1a8QQv/uFaLkpwbx1EHCgEU6Zz9xBeRIHH2faWrVSYZsFWQwY7eJgcDA/C5U4X3W4FX9Hlfvr9/rGdSlEUrBh3LeDknX7FqLx/Ajd57gT8XZxHyfPsWIs
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(346002)(396003)(136003)(39840400004)(376002)(6512007)(6916009)(66476007)(8676002)(66556008)(52116002)(66946007)(4326008)(83380400001)(6506007)(36756003)(6486002)(956004)(26005)(6666004)(2616005)(69590400007)(7416002)(186003)(5660300002)(478600001)(8936002)(2906002)(107886003)(16526019)(86362001)(316002)(1076003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: CrggtobVk+pAaugJoLejVnbWvAr2RpZ3inxoc9Rzr/k1N5UbVMmLasNKqlh00HDgIt0DxpnRyRHJw7C8bjnjoM7GlRqXfG1syzCg0unMlJRRvjilPn7moJCg5EkTgyR6wCVBtpYdNzo2OZbRg0Si4cuhHV/6aoq4dY1CmKo6a2RKmEABS0Q7ml0e3kh0NNYrGGFmh7P1KXaz1eUQmyhYCutjUV8Gq1dik29i8YS9rq4Fs0g0xqcG8Wc75KCkpH4cE96an/CGAlze1Pny59ZmOZ+ecY94tyTuJwwQ4s+zeHC+Fa/VUddOZrEH8Xpy8Pt+OWy1onLz2ZGdEu72fyG1CjQg9QG1BmFzlJSeGgZJgT9r3PydBlxtgh6ED3thfeSEXLXTtXe4L3Ketzg3Fci412MnwvR4u/xAdVswLwgxfaeArEgZwuMR0jeo8NBUa/yPbsm2oMmdRYD3v7rl+4UP1sNdZ+9ptBiLXxD5WbxbJaw=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4212e3c3-28ee-4254-dcb2-08d82fadae50
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2020 08:43:47.4711 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oD53SDHa/RKgo8Il0yTH/zmV2LNJ3HUvuNSb6UtfHjNi3ny2QZVGmZDfUzhLKFGlEod/ZZUVAlDwWCZY+F2ed464/JCYkmpckk192RE3tMA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4534
Received-SPF: pass client-ip=40.107.22.134;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/24 04:43:47
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


