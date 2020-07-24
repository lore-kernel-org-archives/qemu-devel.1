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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CA27C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 08:51:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA10F206EB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 08:51:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="AkEw9yqu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA10F206EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48760 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jytQB-0006v8-0n
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 04:51:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38428)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jytJG-0001v2-HF; Fri, 24 Jul 2020 04:44:06 -0400
Received: from mail-eopbgr60129.outbound.protection.outlook.com
 ([40.107.6.129]:11111 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jytJE-0008Q9-Mj; Fri, 24 Jul 2020 04:44:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kq9YDY84tgD41hz21FeuVvABiGdcPB7wakt7k6RJrWXiCL4XkygW1n4WOmiyurl4IBXXjVThyL1cE6tG+JRyslMd7B/hYJYbFbFc0jhU+gA9LLTZpuCIW0/hFkIPdnjezqE81szTV2q2wtU02KW6jAnHklyzOIJFtKCNX82TlVWVNkYQ+lT3RP4GkhLp0qQF5QfvuP7hRURVQ/enItHmUB49yi5slCcjljtL1nI+8shcTU6cBQVDeAWgNhnoWI/VZDOg6/V840zdUmnUTAqIjTL9nb+36nbjFl21G2T1UfJtqFcabRJ8pfbxOh005LyNfyY8ecO7dNS7nOvJeJR2YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EhmnJcai55yk8J6WRd9ZcZ12+V+TeQ+vEQ2lQG9G4v0=;
 b=bIdzuZBPS63uL8bjfnBNBd6a51ccMtwTAHLWwB1CRYSAYRjaZGKd61wCm7cMZEKyyEwyXoAGuvg8FuNosmzjxVtQB7J1dvYI4VAObuSJsj42qhPw5aS9ZRLdWc40AuoYEkE4+xSzfBsxhfBNm45krRsgiY1sE9kJWuvucfOhoD4WwllxbPRPW9aJDP0dh+x5/Hqy+Q+sVPLnQfTRg2ck0DoHa0779qhQquRwOoAt2/IEMhGXrCMTT722GgujN3bYBOrBfvnmRlYj3KgubelON7DZ1flIw2SS79FUhSUVXxcr8o5TiUUVR/8W6AOP3Hx7FyiT40/6QdOCptAHOhHbnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EhmnJcai55yk8J6WRd9ZcZ12+V+TeQ+vEQ2lQG9G4v0=;
 b=AkEw9yquOGjhPi/gKlKyBJgJH6jrCENsxFX6gwmUAETBOFMSkW+kIBWqFe+OKwq6PeTpVuuuB0rmxpmYxojhmHjadxpVEBnjT8U07W1z3OYhrtHSs4+D5Z7EFbjad+72gMmHQSA15lXCJg83hAI++kjz55d5m094bs/J3kTEeSE=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4849.eurprd08.prod.outlook.com (2603:10a6:20b:c3::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Fri, 24 Jul
 2020 08:44:01 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%4]) with mapi id 15.20.3216.024; Fri, 24 Jul 2020
 08:44:00 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v3 19/21] qemu-iotests/199: check persistent bitmaps
Date: Fri, 24 Jul 2020 11:43:25 +0300
Message-Id: <20200724084327.15665-20-vsementsov@virtuozzo.com>
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
 Transport; Fri, 24 Jul 2020 08:44:00 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.156]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c8f1c560-1155-4d18-000a-08d82fadb649
X-MS-TrafficTypeDiagnostic: AM6PR08MB4849:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB484908BF6FA61A77360A6D7BC1770@AM6PR08MB4849.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:949;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VkuEL0YhEI0c6COPyB/zjImKwr/SrGfp9er3BXHnrz4427P9EMj43t3LHBdixfF4cBNkPKE5a2kdp2/Is99rK3hvSAoV/LK/UyPh65f8uLXMCd16FAWBo01+dENghNVugbtAN5ivWnksut1Vc4OdUtOHuMm3t2lYyhh/81Px0Jfao3zLSXBGTSzVWLkiQVGZLmFs8sAZI5ToyFqD9fFhRImDTWPA2o2Ka67ImYo9vFc/zy8B3APxZPpbZ6n1bQm+VSiHzyzK6InzNmJVtJjancqG9L/K8VQ9GzDUt+E49uUdk3j4VehpaUgKXVY1GKQRZl/D2maoWwyBqzCc15N4zxyzgU1Hj3gIcQMVqhQz/REGX85scIAQko64CY1vvnkT
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39840400004)(136003)(346002)(396003)(366004)(376002)(26005)(6916009)(6512007)(478600001)(2616005)(6666004)(316002)(4326008)(186003)(6506007)(956004)(16526019)(86362001)(83380400001)(1076003)(6486002)(66946007)(36756003)(69590400007)(8936002)(107886003)(2906002)(52116002)(5660300002)(7416002)(8676002)(66556008)(66476007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: RE1Fpu9m0lXMrH6gKCxpL6vWHA1dp1CcvYGi7/XkMtvkHvz84ZwaznIcXg6ZiMH5dA1So8YbZnGP9blng8tQO1dcDlinGMA8e4CGdvUFDgO5AYRtMwKyv1lm0f7fZ9H381o+t09iAA77tlMqWvtxe5jX3DRhgd+UkWtmV62DapwQQP++nTuFNhwfl45wK06WcELIavaNEeRTpuuK3h17QM3PWvcqaq2wqnvu3emigwlfnEBzevFumIBtdmafZI5KSsAuKuIZvGJLENk1USUAPEZbmDodiUL2Ghrh3X6viTNnI2ARorvdElK3ymF0m7mkYQ8r7s5KFr21B6WVtmQqce2FEW2cSGh/D9NxwE24Nsf0SpXSGOAMkDN4fybZOeRi0sGz1uGjhRktHpNdNGf3vlvKlSfBFW0MKcmkF3+ZbbwQ4Yr/1MCrIZ2HduwU4L39Hq0ovTrWcIZmx170/TXIXfz/d355iv4rHX/eqmCYlXo=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8f1c560-1155-4d18-000a-08d82fadb649
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2020 08:44:00.8513 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0O434IIDMgPMSfOd7ayLcQDiXgqttcIB20aeHuFcjwiFpw94bp63Tm/4aO8OwXSLlrrBmT2Q8axsR2jTRqU09Kj9FLhTf69iy4gRjsvK/sk=
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


