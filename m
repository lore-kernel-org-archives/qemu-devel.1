Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 180E3C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 19:53:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7AFA2072E
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 19:53:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="TBGJm0us"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7AFA2072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k09Bi-0003Ia-4f
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 15:53:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47796)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k091t-0002P2-VN; Mon, 27 Jul 2020 15:43:21 -0400
Received: from mail-eopbgr80112.outbound.protection.outlook.com
 ([40.107.8.112]:11911 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k091s-0003hz-2i; Mon, 27 Jul 2020 15:43:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=duN6KCyZIHFnpDhEk5MCNXQIFjzkoN8LjIfr8jhR/5s3NRFQF0l84gB7irsHWKU7G+P7ejyy8AVwqMDfLxx8xkxqUQ1/cXuLDkh5S0vH8FAHxiW302YmojK9ms6vuUvb+iSE31YwtDv8u2DIpKhWwgNMma8np71axcgREr3tkd82wOn2yyGYOYbX8cVj0T0sTCTKzrONfe3Jk8zW4S7t4IvscLp4y3gnZizJZstK+pFRCsTUn9TZNbMDx6pm5rHD0McgMxf+byJc9ZJBqJkimf07Dzu5JGgDhxpmF3HFelDE5dqoQVKFEgVOmn3DjdW/5dMfpSEFca4VsW/FGGnBaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5AhUpV3MYskLeHU9yF+RfQsLqcAE8vCSwXUPMiKsp7s=;
 b=D/eDKcHokGAnRfC3h0zNcn/gwC5ZJLcMpEivFnMSgXxhxpbDsh/57dyxEDyAj4dS5Mq1mEHEnFU2STEo0kXOrofD31nNzpVlwJ2fSTE/E2iugXY/UIMXwYKXWddodPb+ihs53Yh1e1afcBvP6hW7ggDYK26HLWlvEt3YRuN2JKVBYqz122j4yuH2asmwekGMoDAHchfU5RKkUA3udisWq5WSyGZnigj+KhZ5dFS4WFXIoU7C4SLKQlhLtvAkscJgOYWAYRnn1xI7ehzOFFae/95BtTtjOJyp6M8mv9/2o+ZFThfJbp9VCslq9gkSj9BMe7HhoLPAwlfninoh7NGOUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5AhUpV3MYskLeHU9yF+RfQsLqcAE8vCSwXUPMiKsp7s=;
 b=TBGJm0usKgJO5g+F9jFinhFSi3rS2rNjDVvVyfBREVEKzQmt5Lr/YzEVymYrCxYks+LAc+he0wIGwbBfBhHlgARx1Q7EkJwkVmlhbfI97h/n3UkTyh870yhrT8UeTwJxofVp6fs5NnuHmsLJ4SvT4MuPU2kmOe/WGmUUz5gwefY=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM5PR0802MB2610.eurprd08.prod.outlook.com (2603:10a6:203:97::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.23; Mon, 27 Jul
 2020 19:43:07 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%4]) with mapi id 15.20.3216.033; Mon, 27 Jul 2020
 19:43:07 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v4 18/21] qemu-iotests/199: prepare for new test-cases addition
Date: Mon, 27 Jul 2020 22:42:33 +0300
Message-Id: <20200727194236.19551-19-vsementsov@virtuozzo.com>
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
 Transport; Mon, 27 Jul 2020 19:43:06 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.158]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 457ed1d4-9e85-4c81-b800-08d832654957
X-MS-TrafficTypeDiagnostic: AM5PR0802MB2610:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM5PR0802MB2610B7ECE339B30DE2736F29C1720@AM5PR0802MB2610.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:386;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z186olEyYKXGMSsgMpFohfBV7FQQt+OUr53VMpZV0s+gcJudcoySBTRwcVG9rHiAfbp3fVFUDo/yfteH0dDr/Gi/yJ9tzz++v9Bot1g35XEr2S7YFMvIstwjFu/WxRfrJLL+4/8bQo3fxS0qkfHsYs/S9IZReEnFfAM8uGr9zmHhj+e8MaEyVNO59MCaqNM34MImLlb0VE/mU+LgiHVRnf3z1nWsxQEWvd7/yH6i/Ey0acOUE5wdQv8lGYiHXRGCVGzivAFx4DVFoR7nW8K32OKJqk+N6T6A0/9CTh8QgXvlBG8doL2I/8H2S7QM5FzU
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(366004)(376002)(39850400004)(346002)(66556008)(1076003)(66476007)(6512007)(107886003)(86362001)(36756003)(52116002)(4326008)(26005)(2616005)(2906002)(66946007)(8676002)(7416002)(16526019)(6666004)(316002)(6916009)(6486002)(956004)(83380400001)(6506007)(5660300002)(478600001)(186003)(8936002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: kuvkhX7uQkUhfjzgdioVETQardeukM1BVTOsoZXYvnLzepbqkEUrX74iDGfbZcFWpcfA9FFejaEQmcbloSoOVtv6lqqS4tkqystC1UoDUTv/kjAIho/eu/y4EIZ6rzFj1vU0TP9AElU+3qQeSrG7Fo7bwRr0YneA5s2Zp4RbLgSUFP71AVi5KqtCjQAzd9148Nb+0JEPL/kAm9tS/21VOOAsLj1TJfnYfGvTEiQLji/zV6DOl+IE0MfqUJWxCe2wlS4N+s4/QXuECj1/DP5MAghUNNoMZ1P2L+nrKR/BlDWBi6fY8ONj8UbLiTNtuNwYAGyiMgGNXnW97CR4+TdRzav3PKteSI0Use/WHwdnTX+9mUgUzzslkmXSowqYgyskS8bYv5MxEswH0KaTp0rRiF5QTkCNhMWJKKjoMCVIK3ioUakyo3N1DVWz9Z/7r+QA5eBkb+sEx35UoBZD/Dhg9UF1jiJAK/M5tbZf5ZpYnHQ=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 457ed1d4-9e85-4c81-b800-08d832654957
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2020 19:43:07.8218 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QkQ73GP0OtYoGI9JUrEUOemUJLoSXpVF0/Ja0W6sR8gjG0Yv/XsoikgKn2yhTT7A+8P0c68k8CdWkbjptkmRSt8ORtURQUcK//KRl9u68+Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0802MB2610
Received-SPF: pass client-ip=40.107.8.112;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 15:43:12
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


