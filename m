Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 507D1C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 17:46:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19A85204EF
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 17:46:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="HhMgfulq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19A85204EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54100 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgtwP-0001Yl-7R
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 13:46:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32860)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jgtsR-0003F4-Us; Thu, 04 Jun 2020 13:42:08 -0400
Received: from mail-eopbgr80102.outbound.protection.outlook.com
 ([40.107.8.102]:37664 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jgtsR-0005oz-AX; Thu, 04 Jun 2020 13:42:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XKiDPRp5WhY48Sacd0FUE3NlQbwuY/roDHB/61RlvEixBpZGtmw1QaLLINnZgf/Kw1xYKt89iV3HmWicvYyYZixzwYixTfvaqUyBClWEMOOK64Pe2HsVgEaix4kn9PoEmad9AFIsCcLeeheFX4wh31hbfPMPZWqKp0KgMOYvVEENyiU56ILltaweMhraICppLD60sH+sxq5WsMLJfHI7Wp+Ec01eP9wTU3Ehtmg3ylJRsJ7PENMEHdIwqdN7rAXphBoGFovnkAhtvW+dzdlwbIGlYumkhcG1RxtoU87yPAPk5MEj0GuyyNZUEqurljlAsDUtg6ROMcFGvWq5bHW4lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/PLpCaCWiQy3FRWKZ2AB3l8DxmrcNiS/V+hI1S3DZ0Q=;
 b=MdAwFJoeB3A1WKg4NTDjvnNZuwXPvIP3ApJAmo6lfctgDpvgKrTfGe3XbMnAY6yiONqcy3cAOyJX0uWzezSxIhath/1oAUshmjFbt2V+S7Nynf56qzrK3Afyzsturr7BS6nogCQCcx1xJ+3sHgv4Z37NgDaQeJBo9qn40EncoV3cJrDX1bUrmGUt1Nbc9UTDn3FTIJZBbvSMx4mCDBfY5khsr2AwybGHtro+Qr5MntyBYXvzcuVd2V1euEwkjxLBs7f47CY/f6Q0YTB5kj+rPE9ir9MOR/kJma23PovuJn179wyKwcGirsVvWPF+CXapfyflji2BzBZ/mfyufgN8qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/PLpCaCWiQy3FRWKZ2AB3l8DxmrcNiS/V+hI1S3DZ0Q=;
 b=HhMgfulqYj9zkAbVQeq+tJRDDLR2kFwcmTVs/jVPn1qu35j94OaNm5Y4kKbpjWYuVoCg0V11W4oNP6MtrxujocRXAsCZGdkUjsQWOOYieZsb0jTwH/6N8sKlOpb6coxoJJR0gZuI4XFGVoYmhOVdDdqE0GgsW2dRflbdcHeq64M=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5381.eurprd08.prod.outlook.com (2603:10a6:20b:105::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.19; Thu, 4 Jun
 2020 17:41:56 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3066.018; Thu, 4 Jun 2020
 17:41:56 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v4 09/12] qcow2_format.py: QcowHeaderExtension: add dump method
Date: Thu,  4 Jun 2020 20:41:32 +0300
Message-Id: <20200604174135.11042-10-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200604174135.11042-1-vsementsov@virtuozzo.com>
References: <20200604174135.11042-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM4PR0101CA0049.eurprd01.prod.exchangelabs.com
 (2603:10a6:200:41::17) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.190) by
 AM4PR0101CA0049.eurprd01.prod.exchangelabs.com (2603:10a6:200:41::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.19 via Frontend
 Transport; Thu, 4 Jun 2020 17:41:55 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.190]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 247f7c87-2b70-4a49-98ee-08d808ae933e
X-MS-TrafficTypeDiagnostic: AM7PR08MB5381:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5381A3FF0E2889F28FC5B691C1890@AM7PR08MB5381.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-Forefront-PRVS: 04244E0DC5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wu/exqftDboib236V7ZOK/VviRxKnsKA0yVVF/ZLqw1nwgJycMo5KYO6KbOcdX/g8iEm0J3KeYq7Dymjn/wCRhWTxtG31O9/+ze8wgbTLg3ktva7XQ5NtWP7L9zXbUcC6PuLKeEnptOh2zB2vIHaKhBVBe25kOWAP6nMpLq7wFxYSZGJidAXVNH17m3Dymt+a6rgSoAfpjIN/fH7SoP3oQz2yeNjjX37p4w3qb93NQLBs8dw5VPscRVmFoJHNBuGMImAj6Z55hRTuNoXCEZSofWjkDMxVv8oO79Xv1FgRqDO/E1JICOtmCkW0H8s8WUiUvK26EO3GmG7VEVGyYK63w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39840400004)(376002)(346002)(366004)(396003)(136003)(5660300002)(66556008)(26005)(66476007)(478600001)(2906002)(6916009)(107886003)(16526019)(4326008)(66946007)(1076003)(186003)(6666004)(36756003)(86362001)(2616005)(6506007)(83380400001)(316002)(956004)(8936002)(8676002)(52116002)(6512007)(6486002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: i4nX5Ja8g58slHXYca/NpVWoLC2dDkHsjzQzoiFm+RvzB6OkQSFqvFHGIFiwkxPwLYCloOAl9QClcjQvNxgxW7VjiuwWTGg9c+6Q1WMyubjHQmbBVjNYwsRKSlSiRm8d42ojRgbZAys/bCghwy5wp9Aoij7jxOc9KnrQIE69KGCprCCZYBLBFZ1HASxPAZRIwglwPCkPSYQRAzKArlwjRtWO7QlL8kYPVbgaFWOYm4MnBwoUHlzpF5ub5mXeI2h816HUorEOtUAtUmQIYArQOVBEIsGFO6F1snLEgJMrREL8vChUJxjyeFcDCpbQKATp3Miufm4qqD9GDTvrIxeoHUd7d2370mGQO8uPzIUrqxRaPldMw7M9JFelVqd8wfb7nvoieUv9a7kGqY0xSpQnIzlFXlcLqFQ+3tXblIdFqKTjLgUUGIXMJKt5iF9pkgFSveAJUjRt9z5qhAYZ1fbEcLzZ2Q8WnODQcx/7Ssd102M=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 247f7c87-2b70-4a49-98ee-08d808ae933e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2020 17:41:56.2362 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: udgD+ok09wmoEh42/c8UtWCd/Dvgk3+IbhNdgfZAgFSUl4Plt6xEos5wybj3Vk6J4Ib38qs7LKf0ACfIy9acBemGnEvIOD7pqzc7POVOhXQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5381
Received-SPF: pass client-ip=40.107.8.102;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/04 13:41:57
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, MSGID_FROM_MTA_HEADER=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, qemu-devel@nongnu.org,
 mreitz@redhat.com, andrey.shinkevich@virtuozzo.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Obviously, for-loop body in dump_extensions should be the dump method
of extension.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 tests/qemu-iotests/qcow2_format.py | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/tests/qemu-iotests/qcow2_format.py b/tests/qemu-iotests/qcow2_format.py
index ceb09bde5a..ffc7c35b18 100644
--- a/tests/qemu-iotests/qcow2_format.py
+++ b/tests/qemu-iotests/qcow2_format.py
@@ -84,6 +84,17 @@ class QcowHeaderExtension:
         self.length = length
         self.data = data
 
+    def dump(self):
+        data = self.data[:self.length]
+        if all(c in string.printable.encode('ascii') for c in data):
+            data = f"'{ data.decode('ascii') }'"
+        else:
+            data = '<binary>'
+
+        print(f'{"magic":<25} {self.magic:#x}')
+        print(f'{"length":<25} {self.length}')
+        print(f'{"data":<25} {data}')
+
     @classmethod
     def create(cls, magic, data):
         return QcowHeaderExtension(magic, len(data), data)
@@ -186,15 +197,6 @@ class QcowHeader(Qcow2Struct):
 
     def dump_extensions(self):
         for ex in self.extensions:
-
-            data = ex.data[:ex.length]
-            if all(c in string.printable.encode('ascii') for c in data):
-                data = f"'{ data.decode('ascii') }'"
-            else:
-                data = '<binary>'
-
             print('Header extension:')
-            print(f'{"magic":<25} {ex.magic:#x}')
-            print(f'{"length":<25} {ex.length}')
-            print(f'{"data":<25} {data}')
+            ex.dump()
             print()
-- 
2.21.0


