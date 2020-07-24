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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C71FBC433E5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 08:48:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E52E2068F
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 08:48:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="phbYkj+U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E52E2068F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37866 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jytNv-0002T7-AV
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 04:48:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38310)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jytJ6-0001U5-D1; Fri, 24 Jul 2020 04:43:56 -0400
Received: from mail-am6eur05on2134.outbound.protection.outlook.com
 ([40.107.22.134]:63329 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jytJ4-0008OD-35; Fri, 24 Jul 2020 04:43:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bBoQkPMVUR+utlUaF1k3iVOga/qWoj6FMXiuMlZMNiBA1fMFr/3uEtf4VCvIgLZg3yjLb5o7bSBpuoA4LoiXsLgFF+JeKXGqD/WSB0PePjq89ozb+pVVmCyJf6ez47NPwrOgEclYkULO6uPSBuwORQa2b0RfVqf1zWZMR7eqTZmhkzNGeglV5K6zxlx7bs2tMeCk6Sght4T3xTeRnZURU5VQ2/PQOoJFlNuBzsvMqEIIOPKqLDUiS0ilxZ5GIxESrqLPGjjzhNoUebK5aHX3h7vyBg75eIAL6v9jrHKQNUnXKnJaNZRVwOoFmz9hqAaS1+zwGjneMgHhfAzDd6wqBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uZVtDeEi855P8dwPdqgdo7JwrCFeRkBhcvJ9Mnf3Fok=;
 b=JqzncopqWlplZjyVZ+VyH7tht7eZ9aJWiQwoMafA4lt3RmELunSTvmzCDvabHJcQsYhIX5iSS7Qqo2gTK8Q6JkePZANlZnAKYeOsnkO3AhFbXPWSLqmV/wlmxAJDVZwZyq1TlTuaF3RBOlA7QpEA9mXZh06B9g8VnDA+UowHpT7GZit9FW1/qCeKK0rYbCJott0BmLR0V/0O+fDK5YqJqQErRBsB122el+5Kj2vAnftOeT3iEZ3g8hqejqVMB/3ZLGnaL14tl0xb1dZQS4Iz+5h0W9Z8CwuL5OClMptC9KoXheZj2clQqEQ/La1adh5uMsL3CI3vimABG2ntoSa7LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uZVtDeEi855P8dwPdqgdo7JwrCFeRkBhcvJ9Mnf3Fok=;
 b=phbYkj+UWwTgAmLuvXwfjoXgxL+kewM9dLmHMAQn85DTSnlcutd0yeJzbAIApMCoxbX6y12AazH5AxGZpjB8RYv/okvovAsc9BLBvboSNCzybUTzCp15+shjdFNZqwtyDKT8iOYNU5CuiWTleQOhgYegdIARboLYn9TRidJRHXc=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4534.eurprd08.prod.outlook.com (2603:10a6:20b:ba::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17; Fri, 24 Jul
 2020 08:43:48 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%4]) with mapi id 15.20.3216.024; Fri, 24 Jul 2020
 08:43:48 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v3 06/21] qemu-iotests/199: increase postcopy period
Date: Fri, 24 Jul 2020 11:43:12 +0300
Message-Id: <20200724084327.15665-7-vsementsov@virtuozzo.com>
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
 Transport; Fri, 24 Jul 2020 08:43:47 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.156]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 19c950cc-5702-426b-1f79-08d82fadaee0
X-MS-TrafficTypeDiagnostic: AM6PR08MB4534:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB4534B2E6F0B1A0600C207B3BC1770@AM6PR08MB4534.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1107;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YHGSezpf/NlBKfi0/Im6foKMvQ+xh9+SzHA8IoMu96E/ycLC/93jP4G1XpUG/feLP3Fy/9ntTZJhacF0hML5BTE7wuhIGQb3bZq5EsnQxld8qjtAlay2i7Ib1xJ0cDkxmK5qFU0BjSejHtIKW+VR2O7zYfObnGiNBDAqzpszXxDZWlL1GIl02ZgyymfFk1LlgF0JwreVlXEBdz3hSe1SvhRoG4adImXjVCtHzPU3XN+9b1udN9hjWl17xATcyZ/4U+tQ4UoD792PZidbW+7CUn9NOZdgVSR72XoPZTfq7iyl5pdtbbeZfDOeGDr/A0yYgXYdrmaRwO7YroTPKBseNOgvZFjsuZjmhJbXVuyFaikRdRvbMRQdWKasdIgUKe8m
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(346002)(396003)(136003)(39840400004)(376002)(6512007)(6916009)(66476007)(8676002)(66556008)(52116002)(66946007)(4326008)(83380400001)(6506007)(36756003)(6486002)(956004)(26005)(6666004)(2616005)(69590400007)(7416002)(186003)(5660300002)(478600001)(8936002)(2906002)(107886003)(16526019)(86362001)(316002)(1076003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: rlOnzJQOqInvPCjF2BNeU+Rovql9cVgPkra/OAc1ryShgJNiIOZOp04J0TBL0YOtuX8VC2mcLD8KDlbXia5SkBmMH9E4YsUs2nYzJqbRwUpKaC3DA5bGUXPsDLgl/HPItLAMN/Rzb0c7NqL345za9NS7HmZKeA4S9d24jg6iZKNQpG6Kp/Mncgoy5/TuaVk0LHQSLD3VJpWsxKGyRxDtMp5tkd4rgyObe2OLQlukWzpNHlP/6gowvNhKkHD3ADMs+FRk39wYq/l4eON0eWk/IZlrqJV3YCUqxDvx9zrrAdyKz59KHwuzFBdZesx0LBOHSGD4n2b92famIdxYqR+svoIjaRYdnlaTIqyCC6LIEeCyFRgKD8eaIAG8ZPPTUufencKvjzrAYj+m7vJW012n+OCTionMvaC7+acu32SdQylLxOy3hmlMkRabysbONFZz5mWdZzZtVITMjCumq48p6OoW6vD17iXMBENtRp793IQ=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19c950cc-5702-426b-1f79-08d82fadaee0
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2020 08:43:48.4040 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C5N3bvGN7uUMwXMeqDqNS1/Y6LjBu94oiz9uIwjz0EyJq+EDHYJ76wMYQ6ZHb6X3ZKrLRtQq2TwohKE1ZuiV1h7FfkLewr24XkVpENr6Els=
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

The test wants to force a bitmap postcopy. Still, the resulting
postcopy period is very small. Let's increase it by adding more
bitmaps to migrate. Also, test disabled bitmaps migration.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Tested-by: Eric Blake <eblake@redhat.com>
---
 tests/qemu-iotests/199 | 58 ++++++++++++++++++++++++++++--------------
 1 file changed, 39 insertions(+), 19 deletions(-)

diff --git a/tests/qemu-iotests/199 b/tests/qemu-iotests/199
index da4dae01fb..d8532e49da 100755
--- a/tests/qemu-iotests/199
+++ b/tests/qemu-iotests/199
@@ -103,29 +103,45 @@ class TestDirtyBitmapPostcopyMigration(iotests.QMPTestCase):
 
     def test_postcopy(self):
         granularity = 512
+        nb_bitmaps = 15
 
-        result = self.vm_a.qmp('block-dirty-bitmap-add', node='drive0',
-                               name='bitmap', granularity=granularity)
-        self.assert_qmp(result, 'return', {})
+        for i in range(nb_bitmaps):
+            result = self.vm_a.qmp('block-dirty-bitmap-add', node='drive0',
+                                   name='bitmap{}'.format(i),
+                                   granularity=granularity)
+            self.assert_qmp(result, 'return', {})
 
         result = self.vm_a.qmp('x-debug-block-dirty-bitmap-sha256',
-                               node='drive0', name='bitmap')
+                               node='drive0', name='bitmap0')
         empty_sha256 = result['return']['sha256']
 
-        apply_discards(self.vm_a, discards1 + discards2)
+        apply_discards(self.vm_a, discards1)
 
         result = self.vm_a.qmp('x-debug-block-dirty-bitmap-sha256',
-                               node='drive0', name='bitmap')
-        sha256 = result['return']['sha256']
+                               node='drive0', name='bitmap0')
+        discards1_sha256 = result['return']['sha256']
 
         # Check, that updating the bitmap by discards works
-        assert sha256 != empty_sha256
+        assert discards1_sha256 != empty_sha256
 
-        result = self.vm_a.qmp('block-dirty-bitmap-clear', node='drive0',
-                               name='bitmap')
-        self.assert_qmp(result, 'return', {})
+        # We want to calculate resulting sha256. Do it in bitmap0, so, disable
+        # other bitmaps
+        for i in range(1, nb_bitmaps):
+            result = self.vm_a.qmp('block-dirty-bitmap-disable', node='drive0',
+                                   name='bitmap{}'.format(i))
+            self.assert_qmp(result, 'return', {})
 
-        apply_discards(self.vm_a, discards1)
+        apply_discards(self.vm_a, discards2)
+
+        result = self.vm_a.qmp('x-debug-block-dirty-bitmap-sha256',
+                               node='drive0', name='bitmap0')
+        all_discards_sha256 = result['return']['sha256']
+
+        # Now, enable some bitmaps, to be updated during migration
+        for i in range(2, nb_bitmaps, 2):
+            result = self.vm_a.qmp('block-dirty-bitmap-enable', node='drive0',
+                                   name='bitmap{}'.format(i))
+            self.assert_qmp(result, 'return', {})
 
         caps = [{'capability': 'dirty-bitmaps', 'state': True},
                 {'capability': 'events', 'state': True}]
@@ -145,6 +161,7 @@ class TestDirtyBitmapPostcopyMigration(iotests.QMPTestCase):
         event_resume = self.vm_b.event_wait('RESUME')
         self.vm_b_events.append(event_resume)
 
+        # enabled bitmaps should be updated
         apply_discards(self.vm_b, discards2)
 
         match = {'data': {'status': 'completed'}}
@@ -158,7 +175,7 @@ class TestDirtyBitmapPostcopyMigration(iotests.QMPTestCase):
         downtime = event_dist(event_stop, event_resume)
         postcopy_time = event_dist(event_resume, event_complete)
 
-        # TODO: assert downtime * 10 < postcopy_time
+        assert downtime * 10 < postcopy_time
         if debug:
             print('downtime:', downtime)
             print('postcopy_time:', postcopy_time)
@@ -166,12 +183,15 @@ class TestDirtyBitmapPostcopyMigration(iotests.QMPTestCase):
         # Assert that bitmap migration is finished (check that successor bitmap
         # is removed)
         result = self.vm_b.qmp('query-block')
-        assert len(result['return'][0]['dirty-bitmaps']) == 1
-
-        # Check content of migrated (and updated by new writes) bitmap
-        result = self.vm_b.qmp('x-debug-block-dirty-bitmap-sha256',
-                               node='drive0', name='bitmap')
-        self.assert_qmp(result, 'return/sha256', sha256)
+        assert len(result['return'][0]['dirty-bitmaps']) == nb_bitmaps
+
+        # Check content of migrated bitmaps. Still, don't waste time checking
+        # every bitmap
+        for i in range(0, nb_bitmaps, 5):
+            result = self.vm_b.qmp('x-debug-block-dirty-bitmap-sha256',
+                                   node='drive0', name='bitmap{}'.format(i))
+            sha256 = discards1_sha256 if i % 2 else all_discards_sha256
+            self.assert_qmp(result, 'return/sha256', sha256)
 
 
 if __name__ == '__main__':
-- 
2.21.0


