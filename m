Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5D9EC433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 19:48:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83614206E7
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 19:48:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="HlAthsCi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83614206E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55018 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k096W-0001vE-CL
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 15:48:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47586)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k091c-0001l1-0q; Mon, 27 Jul 2020 15:43:04 -0400
Received: from mail-eopbgr80131.outbound.protection.outlook.com
 ([40.107.8.131]:43617 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k091Z-0003fa-5L; Mon, 27 Jul 2020 15:43:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dyYR2yx6btD3Wd45R2d6/QjQmXmRBBR8tPmYXDWHbpX8U3E7LMR2IiCPT3eKUkF1vV72sAFcupF0AsWMquymlgVIWyFIp2ReQV0ndKOvjgH+jj+Xtd7HVdPpHlT+W7gUfPTEovGLOl4GJ+9wx3Jx2T8KgIa/IKB5QTH9pQ2HA1p+/tctWVpC6Q8VVWrpRZ7jn/N+hm30noBqdAgg5aMIbxaDYqQnXpCOQ3rAqWuwj18TZ/8FdTbel7mshcHD0Z7NlwS49qdRIwIQnCiWEAmzcGitQZMPQn3VjxMutTOPeFne3wzkvJNo2BlA+EA+PNEh6eT7bdhF/nms2ymitdvNQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tl486APdJgMxQD8NFBHBW3Xh3Bwx2Gw0wiffDVVWwT8=;
 b=iwKML51Ic7Vic1w3MKiMLUTR7VvE4se0ErazU09Wu1j69oru68nwBlgYmpyfDLa4cKfIxo2xO/aTNvFQ2R/O/Zo56kRjVxZEE74JZ/zvS2Cz0AjqrZr9alVmIy5x0RiMAuK83XC5u0lf8awrwLBQ33uLxPr0f215pjcfILJumoA7d3EHQgJSv+oMNVp0acB1DJwc1l5i8Im19KWfR7B/btO2D199GZaHBMeSXjW6waABnOiSHMrsJnzP37+opMf8xUoKYftAXUq3fi37OFH9awVmFTCJQ/XvP7Kk3ep+hR9ELchZp404erpAPhstKN85Cz8QdICcUmZbof64RprD/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tl486APdJgMxQD8NFBHBW3Xh3Bwx2Gw0wiffDVVWwT8=;
 b=HlAthsCiekne+TV4KIkAd4uY1wqfjHaGTUpn7ssE4fQcI1MAi09RQx9SIcGqT2Z7JNuid0pI66rhI2P6PnuzMruV7KP3v4eLH6fDcTxyKrZhX2h74XTMq/82F4IMiESZ9hdIxmjcv/iIGg/gt1tleQrRwLq0UGjhiPiyEXHOEes=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM5PR0802MB2610.eurprd08.prod.outlook.com (2603:10a6:203:97::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.23; Mon, 27 Jul
 2020 19:42:53 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%4]) with mapi id 15.20.3216.033; Mon, 27 Jul 2020
 19:42:53 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v4 04/21] qemu-iotests/199: improve performance: set bitmap by
 discard
Date: Mon, 27 Jul 2020 22:42:19 +0300
Message-Id: <20200727194236.19551-5-vsementsov@virtuozzo.com>
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
 Transport; Mon, 27 Jul 2020 19:42:52 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.158]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e0a82433-b2cb-4b6b-c6a7-08d8326540e1
X-MS-TrafficTypeDiagnostic: AM5PR0802MB2610:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM5PR0802MB2610988CDB0EE50A3D9B2A86C1720@AM5PR0802MB2610.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:14;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zQxwmvV3LBJtLBqquAhaeYArDzR5leKj0UJ6BiGyqHOFfH03IS2LPzZtNcEg8LnSRxE+sf9ZaXHh9DMqOu2A0Q5h17r1txi1hUczkpWJhUbvFWeYA48H/1+8Ns7UBgvjozGNlvjn47WDdDQxbdWU756UoTF8zPvRYsMCEuhfV5pAC2xfx2IfQC913JsjSz7MS0P4aqTlS6IDtn5oM18iRtI2BCinuQ4CqPyLWVnM3nX9L4bqSKY3ydDXyVPlNWEWqYBdu4ZzhVNtv5HSISHz9wC1A9ZhXt59mmNAh4f5yNrghlHgtVN/HZsb3zx/0y9ts10Y3/uJKH5msy88wgKXhQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(366004)(376002)(39840400004)(346002)(66556008)(1076003)(66476007)(6512007)(107886003)(86362001)(36756003)(52116002)(4326008)(26005)(2616005)(2906002)(66946007)(8676002)(7416002)(16526019)(6666004)(316002)(6916009)(6486002)(956004)(83380400001)(6506007)(5660300002)(478600001)(186003)(8936002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: Dhjx00l+Cgg7bnSwoodzTzTkzZGAVJ0XC/ZZX8JVl1THq1zFnh3MRzhuKr6YTq4HfkemWoWzHKuZgIkLJ0csWz9P3WO82odp2x1lqHTjYLgXLHYZl7u5dbP8LhB2PrSt5+52YXN1rmcMyfjWQbM+sIF5MARLzIUDeSk2u2OF4cLjck9thyod7v08XqwKg3RJXp9qcQrNDBdbQSkGnWojdTYJ1rfP/2O6jWvUXC/+Hdc2StYSgi2Hxd3e7ydcqLkfrJGTwHZfhgv1J6/cRuk6OI8ceeMs8ld+YedXoR5ucF0Axr8PcCdXsPqCSMOnhg5itsRPgLOcCC4hCQXDZn+zgjTqKsCvN2PrzQ8RpTikxs0eOvCq83NGrcHc0A5qB+jqa8ePaCTgEjb8GUm3kaWrwztfmjbbnkacKlYJYfa8r7dYAvuiCzBD3CyZ8IUFF2sN4cxrN47UicuqyBQgCmRkDAg8MNqyR3elWUN45TEa+ko=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0a82433-b2cb-4b6b-c6a7-08d8326540e1
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2020 19:42:53.6440 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Dt5teHoQYjCIVhU06hw9SK0lrzRAwRVRXGFvAHvMhi+1GRFCxVtTRIJc3hJ3oPAWmOOxf8/siH9xx/lw/MGzndycBoaIsnN9KPo1c+yQ9c=
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


