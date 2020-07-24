Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D93AC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 08:47:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FE9620674
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 08:47:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="VQ28zukb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FE9620674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jytMA-0007H8-H9
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 04:47:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38246)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jytJ1-0001HI-Jq; Fri, 24 Jul 2020 04:43:51 -0400
Received: from mail-eopbgr60095.outbound.protection.outlook.com
 ([40.107.6.95]:40593 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jytIz-0008Mg-IS; Fri, 24 Jul 2020 04:43:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oTCwF31iU2JfWJ8EIIdKB3/YTyB6oFkQUQ1Xexl1mC7IyXhFhy0mKjRIRVb0SC/5WpVlK1NpWXyz/OCqFaDzKECMzMrUl6DDTiEKTBhYp8MYiXLcz83tPHl0zPx+T8RBvo2a3SpFfnEYTxmVPZXdAEetRIBOtEu50LCFSAItOXGW0Fl26Ypmt2J04McUczeymDRzaLQcGRJJ6Fd1xCNdbR0IqrsYqc7I+jRbrAj8M7fVXz84OGWF1V3Pjk5Win96ZXRr5uawTGAxZQ/BvPX3Xz6g41FyUoGr7OjX/1tBLhtDQeCy6t/EfNYUnOJ8P0YTSTFja1Ob0KsQS4yaQsq5ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6stCfgXPoC2/AaFxjtKjcah3q0/msd1RvhXsnx7wrMY=;
 b=E+GrEOIZb/8+aN9ay121TPUsGrb+zRza0GAHxTFGwHKaUGnbLy4GAgmZ68KDYy4M6amiF2Rkwn1eaw6cFIalrONg8m5mfh8RI9MG3CNfDSmZxLZDYTyavNArKdLboKWQaL6SlS8M0LMVC+ecV6YbmSdMMfakAtc/cj0j9IgNENx9IKbtfWjFjeYKzGf6mB27p55effEL9zEVc9AvKtc+0f6Ha663ILWai1XGvJeuib5n97fO7hhxKGyu644cStvYZI+pVv7tSwFqLWEAqgsLt3SzG3ekSsNgxl3XNrF1IPPbC9AJq8X08ULj5IZir4zv5pJirAQys5WKO68flEOGGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6stCfgXPoC2/AaFxjtKjcah3q0/msd1RvhXsnx7wrMY=;
 b=VQ28zukb3s/juyRTcnU6URCrC/SOW2k7/yaBqEWx78v1wLkIuUuGL7WwL/iBSToX5vn26uVunpvLK1ObBEvxZOwVqnIBFnmgeCAWykXS0xLo2ZQ4JKiP+yTNjEUMrBW9zApygPh9Y/6ZJrY2S89fuDluQt9SAOsKFA59Ba7YIGo=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4849.eurprd08.prod.outlook.com (2603:10a6:20b:c3::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Fri, 24 Jul
 2020 08:43:43 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%4]) with mapi id 15.20.3216.024; Fri, 24 Jul 2020
 08:43:43 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v3 01/21] qemu-iotests/199: fix style
Date: Fri, 24 Jul 2020 11:43:07 +0300
Message-Id: <20200724084327.15665-2-vsementsov@virtuozzo.com>
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
 Transport; Fri, 24 Jul 2020 08:43:42 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.156]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4bc61dc3-eb5f-4085-1517-08d82fadac05
X-MS-TrafficTypeDiagnostic: AM6PR08MB4849:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB48499076FC49A9BE94778385C1770@AM6PR08MB4849.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l5iDhJoHadUiXGhI0QCr/CUmJ9JaSX4G9XLWNoZPutceWJJtClUBOuSokBPep0JvtW8R1ZHBhLb5PItWnvuI7fHKwotHBjfum70esqmYPz2nfwEzLeGOgd73iBSri2jQ9UNbnzn7v0hQumo2cuRcdnyIjdvsLHLkJyccaIhW4r96xajTF9t3K9BMZquwqOlam2yw0/JTc/7Zm6zujTSxBxVtLDXa2JhYvNspRyogz/3JU62vuG9osZB01ZgoN8bAfQr2bBloMtoogtx9AYT9OybsSjbfUhczVjDr06VfkgP7j60+pG1lXA1rMQFGHUr0vTyjikCW6TpNI1Jy+tyghj9gT2C0GqZo4tDFLfruPaAJKtkPWKEbg8XAJ08F/ONh
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39840400004)(136003)(346002)(396003)(366004)(376002)(26005)(6916009)(6512007)(478600001)(2616005)(6666004)(316002)(4326008)(186003)(6506007)(956004)(16526019)(86362001)(83380400001)(1076003)(6486002)(66946007)(36756003)(69590400007)(8936002)(107886003)(2906002)(52116002)(5660300002)(7416002)(8676002)(66556008)(66476007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: kE9HY3KiX8R8z1WMV1+hem0SPJbL3a/WJwRNgsFtjl1dP55rTrPELD2Zqr3Dyv9IIujAGL/b/Hf/iaw2fQoqmkWSR5a4U/U2n2mYC9DcNLL9YFILk8ImH43HTjJuvpRbuwYnfdcOy0lb2tx1dQUwsR2a01MtIMJy/QUnULyxQjDiBOl0dCW2kYl2vTUnhDcpG8hrZT6JI4tGghRMwIn6YAOC5Zwk5W9pwz9Au/ID1RKrNr6H8P+Ng7YOHFbO4iLS2DcgtsiRG8jEEgM9KOYikyFuLorlpU+wJxuKPOFOV7ld9OqoqwE+0NwE2065RhIrRkoEzLpZP/1EFfZCp48NVUs98Z0ouoOBojmnLLBeVpY2Y+o/I2ll8JCw2e+MxHpebVrU7nKJ/jW84j+uRlwPKYk3k5Dp0FFij+wB2tWLaGcAbl2X2B+7DKIPqZLIK+8whqX0oAfGGXm0vhSix+HZCFoOOQaaAEPLgMuubRgfqng=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bc61dc3-eb5f-4085-1517-08d82fadac05
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2020 08:43:43.6668 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NGFV+rTv62V4MyzeNpCgNPal+wDWtVT+OdoKlwbzsUx0EJQkPW3Vf5jKB0f8eU4s+ryHSSE6rbrLBSOeinPIfzrL2Lz0UxujsvIh+kniyvc=
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

Mostly, satisfy pep8 complains.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Tested-by: Eric Blake <eblake@redhat.com>
---
 tests/qemu-iotests/199 | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/tests/qemu-iotests/199 b/tests/qemu-iotests/199
index 40774eed74..de9ba8d94c 100755
--- a/tests/qemu-iotests/199
+++ b/tests/qemu-iotests/199
@@ -28,8 +28,8 @@ disk_b = os.path.join(iotests.test_dir, 'disk_b')
 size = '256G'
 fifo = os.path.join(iotests.test_dir, 'mig_fifo')
 
-class TestDirtyBitmapPostcopyMigration(iotests.QMPTestCase):
 
+class TestDirtyBitmapPostcopyMigration(iotests.QMPTestCase):
     def tearDown(self):
         self.vm_a.shutdown()
         self.vm_b.shutdown()
@@ -54,7 +54,7 @@ class TestDirtyBitmapPostcopyMigration(iotests.QMPTestCase):
 
         result = self.vm_a.qmp('block-dirty-bitmap-add', node='drive0',
                                name='bitmap', granularity=granularity)
-        self.assert_qmp(result, 'return', {});
+        self.assert_qmp(result, 'return', {})
 
         s = 0
         while s < write_size:
@@ -71,7 +71,7 @@ class TestDirtyBitmapPostcopyMigration(iotests.QMPTestCase):
 
         result = self.vm_a.qmp('block-dirty-bitmap-clear', node='drive0',
                                name='bitmap')
-        self.assert_qmp(result, 'return', {});
+        self.assert_qmp(result, 'return', {})
         s = 0
         while s < write_size:
             self.vm_a.hmp_qemu_io('drive0', 'write %d %d' % (s, chunk))
@@ -104,15 +104,16 @@ class TestDirtyBitmapPostcopyMigration(iotests.QMPTestCase):
             self.vm_b.hmp_qemu_io('drive0', 'write %d %d' % (s, chunk))
             s += 0x10000
 
-        result = self.vm_b.qmp('query-block');
+        result = self.vm_b.qmp('query-block')
         while len(result['return'][0]['dirty-bitmaps']) > 1:
             time.sleep(2)
-            result = self.vm_b.qmp('query-block');
+            result = self.vm_b.qmp('query-block')
 
         result = self.vm_b.qmp('x-debug-block-dirty-bitmap-sha256',
                                node='drive0', name='bitmap')
 
-        self.assert_qmp(result, 'return/sha256', sha256);
+        self.assert_qmp(result, 'return/sha256', sha256)
+
 
 if __name__ == '__main__':
     iotests.main(supported_fmts=['qcow2'], supported_cache_modes=['none'],
-- 
2.21.0


