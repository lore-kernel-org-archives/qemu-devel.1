Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E62FBC433E3
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 19:51:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAAE92072E
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 19:51:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="guG0Igq1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAAE92072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39348 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k099K-00076O-VE
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 15:51:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47806)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k091u-0002QH-CV; Mon, 27 Jul 2020 15:43:22 -0400
Received: from mail-eopbgr80137.outbound.protection.outlook.com
 ([40.107.8.137]:20036 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k091s-0003fu-KH; Mon, 27 Jul 2020 15:43:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XgOjd459KBJs0ndVYGD1ln32TaDVt8fVCsaPYOcpbr7r5I2keuDiI1QWMVNKxvGoxEOpu64WE/IsmJaDZUFhenuNeXpzKTVtRrDA9RQl5mJVC+fHvFWfI/4at1fQayR9BpnFsruYBj4l1WtRWA8I0jH56d2w8bPXUmmUP7gAIAc4uxeF0PUddX5HaUC5FLe1Tx/ZEI1An7jro+wlfBbvd1+oKUVHmw6mt5H4M1ljfVM6vWRiNxxU3NZMg1s9vGh4QXMXQmpRcI78G90QOVDvVIRo8DwvPIlhqsVJgp0MNR0goKmfRxu5Rr6yNCUHrJ0LabJxMNwd0XaCl5cdws6y3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EhmnJcai55yk8J6WRd9ZcZ12+V+TeQ+vEQ2lQG9G4v0=;
 b=D5X/68oJ2asZ5w/m5zXVcTTqtTrbs33nbeKalH3sqckApyGyWK6WwaEWhYSwEYRqscs9dLdR+7CmQ6TW4FYAabMcsNLjkUjD16Y1TrmJrWWbdDwZ86Rx02Civ5AIEBTWKUFexlCAec771wEe4c9DqJ/VUVFL4+csG9ZhYfaBKLMPD0rcmPK/IYiRGFhShiNtAZ1TwEjbietMe7zbEa5tCNh7EuhkuxtXe16FKClOQnufY77xnYYCXVE8JHKvJkVHS8mDtqFx7Ow+UwJuXbnYM2yvKrDDv8g2Q2CYrUlxYZhUUKseCYeIasSurCE/jUjtDSrgeaCdKO4oKHTisUBdjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EhmnJcai55yk8J6WRd9ZcZ12+V+TeQ+vEQ2lQG9G4v0=;
 b=guG0Igq1n1eNJ2L4naj1sjAqBQ9h+rrJ/DCXP/Xx9k/n6yE2xDhwPnn1Wk0ZKAip5adsEE4KKVeRUzmb3QL3w+1B0nHxJmUwJ0COIVk/6R043+3F07JHKlI4LNnoc2IDEVCcIXzmE1Q1PZb41cUSVfiW9KWVgSlLCix/yHwaL84=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM5PR0802MB2610.eurprd08.prod.outlook.com (2603:10a6:203:97::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.23; Mon, 27 Jul
 2020 19:43:08 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%4]) with mapi id 15.20.3216.033; Mon, 27 Jul 2020
 19:43:08 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v4 19/21] qemu-iotests/199: check persistent bitmaps
Date: Mon, 27 Jul 2020 22:42:34 +0300
Message-Id: <20200727194236.19551-20-vsementsov@virtuozzo.com>
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
 Transport; Mon, 27 Jul 2020 19:43:07 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.158]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4cb95197-f432-40ee-45d6-08d8326549ee
X-MS-TrafficTypeDiagnostic: AM5PR0802MB2610:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM5PR0802MB261064821E24269BCAA2CFE6C1720@AM5PR0802MB2610.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:949;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HH+/9Jwu/8ahvyQuGF3QqyL86rKedE/V4ZC9v/AEtX0VjtPJp7YpJwStw/Xmw7auH0fLrWN2i/Rwm097qXfLnKcqQKBEo0ofZH2zamWVtGQTrHHYuil+ubv8E/k4YqDDgR/5KxAWWQ02PVYifE3MqmzOzYb4VTrFsWsMHtsxYBwlaKuRLDMB+lsdaJEIIUrdtPkXsDO2XOZXGDgIOTtrzcmtS+fMJfFd32G0XxHjm9Ks4UNaqSsYl+5km5VczMhvN2CZp4/Whi2+8Vd/NbDYh6eeBroInopy7V9httsqaaUNX/fwgXGGoyPwt5vss7Dq64O9UV5mAazeXzF9dywI6Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(366004)(376002)(39850400004)(346002)(66556008)(1076003)(66476007)(6512007)(107886003)(86362001)(36756003)(52116002)(4326008)(26005)(2616005)(2906002)(66946007)(8676002)(7416002)(16526019)(6666004)(316002)(6916009)(6486002)(956004)(83380400001)(6506007)(5660300002)(478600001)(186003)(8936002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: FO6G3NEoBZWiyLwqCUAEkLR3DLyWjh3KqfRDnKij4nQN7emlVY2Jz/IwPWRSlTGNhpwUrF5KRgV0nhpJ8M9eUdiSbmd0dwrhwBOwnliHTLiuvSmJQgf714Nc6KwlE5Z974snnAIOcVml+1oja2nmdRKnLC8xYNOwbnzWQi+KI8wPQxQ4Q2t2A7HrWb6xiemuGwZLQptHw54bWGKZWyKSNp/xbfNR/8krIUVUwS47I1DQd2qNIlaFIOMHp9W/dWXTLiO/RZslHfHuPWyAP5reWX0N+gao7E9szARnfdUl4lwOkiImrfIdclCu3/1n68CKIaA8x/Ff8RgMb/xxbk1Qv++Y5U+GjOEiU1x4GNC7ybf6OQSeAY6K7p7pL4OXTsZxgl73vhnwR6/mJxW2xQ0YCq9z3KYdKhItR+l265HkpmeWXUDGrF4wEPyqkVmTOiIuETWHbBcCrRQbkUqYN2nH6t0rk3/qtf/+9R0WVvMiJ5w=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cb95197-f432-40ee-45d6-08d8326549ee
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2020 19:43:08.7966 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cNtdotjfd+tImrBFQ5eqBoCnPy+v4aykYlA/5qdHAkvp075ciJoJIQwp69jam9+f4Cm/l8GTX6bT6mxSUaYbMww9EC7AMUlWJoSGbfqQkUo=
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

Check that persistent bitmaps are not stored on source and that bitmaps
are persistent on destination.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
---
 tests/qemu-iotests/199 | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/199 b/tests/qemu-iotests/199
index 355c0b2885..5fd34f0fcd 100755
--- a/tests/qemu-iotests/199
+++ b/tests/qemu-iotests/199
@@ -117,7 +117,8 @@ class TestDirtyBitmapPostcopyMigration(iotests.QMPTestCase):
         for i in range(nb_bitmaps):
             result = self.vm_a.qmp('block-dirty-bitmap-add', node='drive0',
                                    name='bitmap{}'.format(i),
-                                   granularity=granularity)
+                                   granularity=granularity,
+                                   persistent=True)
             self.assert_qmp(result, 'return', {})
 
         result = self.vm_a.qmp('x-debug-block-dirty-bitmap-sha256',
@@ -193,6 +194,19 @@ class TestDirtyBitmapPostcopyMigration(iotests.QMPTestCase):
             print('downtime:', downtime)
             print('postcopy_time:', postcopy_time)
 
+        # check that there are no bitmaps stored on source
+        self.vm_a_events += self.vm_a.get_qmp_events()
+        self.vm_a.shutdown()
+        self.vm_a.launch()
+        check_bitmaps(self.vm_a, 0)
+
+        # check that bitmaps are migrated and persistence works
+        check_bitmaps(self.vm_b, nb_bitmaps)
+        self.vm_b.shutdown()
+        # recreate vm_b, so there is no incoming option, which prevents
+        # loading bitmaps from disk
+        self.vm_b = iotests.VM(path_suffix='b').add_drive(disk_b)
+        self.vm_b.launch()
         check_bitmaps(self.vm_b, nb_bitmaps)
 
         # Check content of migrated bitmaps. Still, don't waste time checking
-- 
2.21.0


