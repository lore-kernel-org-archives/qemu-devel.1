Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51C73C433E3
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 08:44:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C0D82068F
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 08:44:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="U3iusLtt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C0D82068F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jytK6-0003Wn-Bw
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 04:44:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38244)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jytJ1-0001GD-5j; Fri, 24 Jul 2020 04:43:51 -0400
Received: from mail-am6eur05on2134.outbound.protection.outlook.com
 ([40.107.22.134]:63329 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jytIz-0008OD-4L; Fri, 24 Jul 2020 04:43:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B4Fm4isbLKmz5K4B1JOEyWPlLc/3E6YmGhIwJ/esuLWtTUQOhUTBBB73/vyOs7J3tRKo8cfu26IXKsY8sdocqjAnU9dMHF3i8al45VpOKkiKJ3buSJmBGKryQ6lKvjPdulptIZ6vCANZAukUBOv5F1m9uTkwlk91uuRPf/Yg1y+GKZ0doDN0keaENz+JAMQVxiViX0RFjvhOcxEo+0UxNiNAfas3lp4PGujoKvVD+uRwKp/4n9ViRHn/I1D9UCcX3kMWH1ZLHaWb50dETz0eilBG/808ZpX2CPEvgWh/IT1Wt5oUYNPcOioo6NGyDQGU+MkcS9M3p3DT0C2tcoiHQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tl486APdJgMxQD8NFBHBW3Xh3Bwx2Gw0wiffDVVWwT8=;
 b=RrTC5+XBdwUxlVD6DyGn9n6XttYkhySMv+1mYdhUWKLa/OJ4uoi252thWEKeLsiB06n6RqmAzAGuBhjMOqVq1tTz1WgRbSeg30Y+CwF6VIsKOqyNKtB6o/pYNpB/TI6cd4/FHi8h5Tt20BM9UV1Anlh0Dy5ODAVFvBz2iHplg/dVMgeKov7GemTfIvTU2dTIpO+/ZPQtzuvnzUGZJ2rX5RANxo9yXgH0JkowirfoEBkaVpfenvpoLH1BCz8xXAQZCOT+N91QN5o7Cjr+BlJoxYDymYC0x/Rs/lHT1V7ZMHz4ES6HgxlBsA1b1nuB2NIQMT8W52Ixr7ALQqzBZJ3s0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tl486APdJgMxQD8NFBHBW3Xh3Bwx2Gw0wiffDVVWwT8=;
 b=U3iusLttr6UhEn4Rr8EiqQDhcvSrabZs4i8upwQLXTdTMB030WXU8cmZK5VPLr1zGkkF+ar4kEhI/0Nb2m2wqXDKXGcg6lr4ja4l5Aog0M6bFc3/RxkQNOoc+HgMUetE9mpmEY/Rl6mhRUXw3sRuBGimRvpfrTBwdQRj7xRS5EE=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4534.eurprd08.prod.outlook.com (2603:10a6:20b:ba::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17; Fri, 24 Jul
 2020 08:43:46 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%4]) with mapi id 15.20.3216.024; Fri, 24 Jul 2020
 08:43:46 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v3 04/21] qemu-iotests/199: improve performance: set bitmap by
 discard
Date: Fri, 24 Jul 2020 11:43:10 +0300
Message-Id: <20200724084327.15665-5-vsementsov@virtuozzo.com>
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
 Transport; Fri, 24 Jul 2020 08:43:45 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.156]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8df52518-8c7c-42c6-c737-08d82fadadbf
X-MS-TrafficTypeDiagnostic: AM6PR08MB4534:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB45348A0024C5F7E315230410C1770@AM6PR08MB4534.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:14;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pOeFSn3NHSVwl1PNmycoblTgUopYA7BTEm9G7kZNnXSvVHjxks4tNnMqN/Mz0SGmNFXPQOZY3J4cDQ09Njc03jtwzLDnfKynyR/7WvLq2LTVKR0b+akqrA7oL1UYGeeblwmK9coBpfy248zTay7DR9ZDYlOX6vT5xr5y+e7zYTNkRZ5YZa8EWRLsU5zsE6f91+Q0T55ewTO8kyBELr6o3W6BiszgYJQWxgTNPSFr3vju/5XrLezhQBV6QkyT5heViJmvNhJrcTVdcfSMma7gNOTXvmSC3w8Og4JmNstHJr17bl7vKCSMXe2HN2p+5lLp33Fn50hGPdB80n5DnW6ENIiTxFC0fHVIcHX3ru+AKsJjT9v5aN13unes+q5LmI/M
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(346002)(396003)(136003)(39840400004)(376002)(6512007)(6916009)(66476007)(8676002)(66556008)(52116002)(66946007)(4326008)(83380400001)(6506007)(36756003)(6486002)(956004)(26005)(6666004)(2616005)(69590400007)(7416002)(186003)(5660300002)(478600001)(8936002)(2906002)(107886003)(16526019)(86362001)(316002)(1076003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 4wYz5Juu4hF7Ay0BoWDO/zcqXje+Pwf4I+uDx2spUdCLr/paRubgdBAWSd3oxiYbhISaegVg6YH5Bw6e+RifwYpYOPU2nIvZLSaFcn+of9UUWu9t4JofweeMS6+w9iLuvu6ZCJbD+PvNM+BvK1PS3Vgf/cQ5mE4zygrYyepjUHon12n9uHvqmHjdY7GZ01k/kZxo1gQia+WBH+3p8/J9PsCBM+NvcpgxcDZ1T+XnJcADWl7znqP0mVIgsvv9dyJNyxOHrBPBxXzi7lBtluVVB0H+y7WZ3qEK3dbMlaPhmWHuTpmsiKEmshvOCuiJUFkqr+Q0/h00qrvz3c0AzPKYkk2csmmcHhlhqW47hn4CBLusfEG+jAKf6aXQE0RNVxXUhwn64E+1N5fSdgjL/sTDPvjalde+vb3k32AjS993K0HvZDLuACRDCFBGf6Xzc39BLjo+NwNbfeK2pmypvHFfz7LJ/UpsvKfqvMH0d9RZx8c=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8df52518-8c7c-42c6-c737-08d82fadadbf
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2020 08:43:46.5093 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MGoYPI5qPfjuhv83a9l7SNQ7MRAe0gQxrssWFk1sZXIMyGLIfiP/nZCLkQ71Qf58iLMcQkmWma22fEGuy8wZ3lWDikJnBdbUdY55FbPYmyA=
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

Discard dirties dirty-bitmap as well as write, but works faster. Let's
use it instead.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Tested-by: Eric Blake <eblake@redhat.com>
---
 tests/qemu-iotests/199 | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/tests/qemu-iotests/199 b/tests/qemu-iotests/199
index dd6044768c..190e820b84 100755
--- a/tests/qemu-iotests/199
+++ b/tests/qemu-iotests/199
@@ -67,8 +67,10 @@ class TestDirtyBitmapPostcopyMigration(iotests.QMPTestCase):
         os.mkfifo(fifo)
         qemu_img('create', '-f', iotests.imgfmt, disk_a, size)
         qemu_img('create', '-f', iotests.imgfmt, disk_b, size)
-        self.vm_a = iotests.VM(path_suffix='a').add_drive(disk_a)
-        self.vm_b = iotests.VM(path_suffix='b').add_drive(disk_b)
+        self.vm_a = iotests.VM(path_suffix='a').add_drive(disk_a,
+                                                          'discard=unmap')
+        self.vm_b = iotests.VM(path_suffix='b').add_drive(disk_b,
+                                                          'discard=unmap')
         self.vm_b.add_incoming("exec: cat '" + fifo + "'")
         self.vm_a.launch()
         self.vm_b.launch()
@@ -78,7 +80,7 @@ class TestDirtyBitmapPostcopyMigration(iotests.QMPTestCase):
         self.vm_b_events = []
 
     def test_postcopy(self):
-        write_size = 0x40000000
+        discard_size = 0x40000000
         granularity = 512
         chunk = 4096
 
@@ -86,25 +88,32 @@ class TestDirtyBitmapPostcopyMigration(iotests.QMPTestCase):
                                name='bitmap', granularity=granularity)
         self.assert_qmp(result, 'return', {})
 
+        result = self.vm_a.qmp('x-debug-block-dirty-bitmap-sha256',
+                               node='drive0', name='bitmap')
+        empty_sha256 = result['return']['sha256']
+
         s = 0
-        while s < write_size:
-            self.vm_a.hmp_qemu_io('drive0', 'write %d %d' % (s, chunk))
+        while s < discard_size:
+            self.vm_a.hmp_qemu_io('drive0', 'discard %d %d' % (s, chunk))
             s += 0x10000
         s = 0x8000
-        while s < write_size:
-            self.vm_a.hmp_qemu_io('drive0', 'write %d %d' % (s, chunk))
+        while s < discard_size:
+            self.vm_a.hmp_qemu_io('drive0', 'discard %d %d' % (s, chunk))
             s += 0x10000
 
         result = self.vm_a.qmp('x-debug-block-dirty-bitmap-sha256',
                                node='drive0', name='bitmap')
         sha256 = result['return']['sha256']
 
+        # Check, that updating the bitmap by discards works
+        assert sha256 != empty_sha256
+
         result = self.vm_a.qmp('block-dirty-bitmap-clear', node='drive0',
                                name='bitmap')
         self.assert_qmp(result, 'return', {})
         s = 0
-        while s < write_size:
-            self.vm_a.hmp_qemu_io('drive0', 'write %d %d' % (s, chunk))
+        while s < discard_size:
+            self.vm_a.hmp_qemu_io('drive0', 'discard %d %d' % (s, chunk))
             s += 0x10000
 
         caps = [{'capability': 'dirty-bitmaps', 'state': True},
@@ -126,8 +135,8 @@ class TestDirtyBitmapPostcopyMigration(iotests.QMPTestCase):
         self.vm_b_events.append(event_resume)
 
         s = 0x8000
-        while s < write_size:
-            self.vm_b.hmp_qemu_io('drive0', 'write %d %d' % (s, chunk))
+        while s < discard_size:
+            self.vm_b.hmp_qemu_io('drive0', 'discard %d %d' % (s, chunk))
             s += 0x10000
 
         match = {'data': {'status': 'completed'}}
-- 
2.21.0


