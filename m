Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF870C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 19:49:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A661C206E7
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 19:49:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="bPg+Ixw+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A661C206E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k098I-0005ME-UW
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 15:49:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47622)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k091h-0001p3-1i; Mon, 27 Jul 2020 15:43:09 -0400
Received: from mail-eopbgr80131.outbound.protection.outlook.com
 ([40.107.8.131]:43617 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k091e-0003fa-CN; Mon, 27 Jul 2020 15:43:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wzjy5a4YNJFZZpYmIAPqXTuTCSEBRcOxR8EuWcwGE3XrQGLTY79BB6QrttBsUZG3rjLxsgpHBFEDMaB66hSFD3XnW7Lev+p5DdhbWdOQkwByFizq/Y7QE19B0z8wVVQn0TMkDg0ez8unjOiOMVNyqActOJbMWr1/YXjFctmcrmOFoAXrU1MimyHgoLLFXVZIZhQYepu3vP7/z9hBbtlFU5Rh76Fcd5128X1WCzbJpGcTg3wy1CPRlb0FO0OFo04xKQM9tje0lyEqZnjncbbsnLFKRLXg2ZORKbinaEWLVnBfofzpJ/NRXp240fdl30T7ziQtlZJf2ZWJyxcjS9SpDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uZVtDeEi855P8dwPdqgdo7JwrCFeRkBhcvJ9Mnf3Fok=;
 b=RQu2D+oAJ0X+Ap51rMhqR3scKkC6W3/nkzlGxIBdiBFkDkVxYMYd/m2EbTQDKuOLZuJN5BXqHzPJ81y80bVNeyPQcLgrPLiifr0jO0gkI+Y7CvWVunrDfIVKRqvP4p/ARyLieGTNxpqQtS9u54gBY9LsA6NZXP7tOz4E/YAAazTFJ0UHSxaGbZkfx5aA4cECIxyhlasFC5Q33GyE0NqCJ9Ftu+/yrie0EtTZ2jZKAOSbrZKzi21f1VRenVqHlki1MU7Mv/n5mPqsRH02EOIHzqoax9SfynSWsUS+/hOBLbL+yQ2DL0h5xq9lpCn0GAvXZvPSmzK/XXAUgEn8lULrww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uZVtDeEi855P8dwPdqgdo7JwrCFeRkBhcvJ9Mnf3Fok=;
 b=bPg+Ixw+lwaZLeT6y86hui670cBQdKNQrrRrfXOSrm96Oi4zDvBSxKiJV+OY0aBcUebw+fs8v0UUdE5be82W6etbW/3b+t/QU1EeiPfzjTc1uAziFwCi8QFDkGJYbpDR8v00Mi8h+mBT38hZHMg6DNR2Kcq1dejtqkTkf+xEVjA=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM5PR0802MB2610.eurprd08.prod.outlook.com (2603:10a6:203:97::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.23; Mon, 27 Jul
 2020 19:42:55 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%4]) with mapi id 15.20.3216.033; Mon, 27 Jul 2020
 19:42:55 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v4 06/21] qemu-iotests/199: increase postcopy period
Date: Mon, 27 Jul 2020 22:42:21 +0300
Message-Id: <20200727194236.19551-7-vsementsov@virtuozzo.com>
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
 Transport; Mon, 27 Jul 2020 19:42:54 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.158]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ff26e62c-f28a-422f-63c1-08d83265420b
X-MS-TrafficTypeDiagnostic: AM5PR0802MB2610:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM5PR0802MB2610B918239BBB4F7F686EB6C1720@AM5PR0802MB2610.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1107;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LXGNE5tm62hBOjwi04HlRHvmJuyECWp3LY6QqCGDDYuYKGjdnlrgnbGWAkxGruR1IfMT0kuH4p8kYIsgNg7xAxJKhFwildrvDOLY1IltvNFl5YJajL9rrO3QYBI/scGaOa0WMHkLNA8YIOW+wA5cIpsGukOE04ekN54VPN2iJVHEHv+7v0h1cufZoLMjOWTic1pv9OHlO7VER8USvZoJUeUehn+RjcRnzS4NFZBxw01ipamRh3dwGPvBjC8ksJcbmguRvGoFgXLNgYWYVENKKesIGe0ehSw/kgcT3yT8ns5SwYkybaaLPSkadET6gJSc
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(366004)(376002)(39840400004)(346002)(66556008)(1076003)(66476007)(6512007)(107886003)(86362001)(36756003)(52116002)(4326008)(26005)(2616005)(2906002)(66946007)(8676002)(7416002)(16526019)(6666004)(316002)(6916009)(6486002)(956004)(83380400001)(6506007)(5660300002)(478600001)(186003)(8936002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: k8eGBD680CADn6hXD3gh1fIsXVGCRrbJb6+e5wmR775qTeHSkgtTeNB2GXru7cj5iqclqI2xEKTOfx4hlCv5ekemPSiAW0OJ6I2PeGDunWBaKu9MiuBb0rLoJ2UE1wkd7e3+A0e8uXOJcz0Wii8x5WzmGeBiQX8aGaOGsd6dn/d/ubCgL8Oc5wpTjsXiGQXsb/Ecy8rErK31u2mulZulVPrdpeXujqOAteEHF3hwhrKnkHRxR3Q9lcXVABfoj/iF8H1TxYapZPuICrKxkys/3Wn21tfrs/cOXYCZQAYh5TsK/MwcdB37cKAWiVor218qrwP8w92KTmq9T1X8YAKaMV+8zyq5WkYCARFofZzOUhLxuYmDkWCetjFbznUPyG4WDpY5uPiN8zm1vPqk5olgDjo3as4P7bZTj+M6L1SyEXmjZn1QlaGdoIEYHIm+p3MCIoElQNAeiFdvKZzUxRxMPkSj/ygrQEihmLEpujcrWDw=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff26e62c-f28a-422f-63c1-08d83265420b
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2020 19:42:55.5795 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ROf+QbarUCat/dUxOCnElCtd14J0nZkN49TsVcH0SyyX/5XnBGCL264029NIr6C6Yd0wWma4SKSMCPJZv4t8izDuadoag3TF5mwwkLc2JYk=
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


