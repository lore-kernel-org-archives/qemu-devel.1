Return-Path: <SRS0=faK4=7T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C68A7C433E0
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2020 08:22:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91DBA207D0
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2020 08:22:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="HlnXXobt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91DBA207D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58048 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhU6O-00032S-RI
	for qemu-devel@archiver.kernel.org; Sat, 06 Jun 2020 04:22:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43656)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jhU2P-0003Mn-DK; Sat, 06 Jun 2020 04:18:45 -0400
Received: from mail-eopbgr80098.outbound.protection.outlook.com
 ([40.107.8.98]:10318 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jhU2O-0000aF-HI; Sat, 06 Jun 2020 04:18:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SDTvQ6KHTJctrUSE5KtdsoMRBExO3cQWYJ0jmm5TY7vvBtUfdL1S6+d92y5JYlryDkToyScwSrarz+Jel5IjpOf2e42VpXuMnu8KN9/VsGqeFWh9cMAkYSCvtRcgz0/uv+OoaJzhoZ+eF74mfvdsqabdAHECmYHWhff1QPxqXNV16J5FqiPGofe4brrWQtCDckVt55jYvJyrkcBk/Lr/RW2YB4GSmhFdcs/ZM4V0GyKSGvKd0zs1IPv6r/83ZY7TVxfBN6sLBfvqRDOZsziWCaDjgXec2NtpEM0Lm4NprXBP5wz1KZaPUzcE8vrw5bbiPH+ijeda2eSsehQc0lOELA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0sZqqV1iSKd1Sg26YcCLKy73hbqWBzNLdaeOWWyX6mE=;
 b=Cth/njbb3UrVICVqz6ntNhCMaRzNXllV89tyt9XvllghAkABh1sks0e3tOqzuUDdISSciB7FMgO7swXvG1qFWmyhxC5j9eACcWrSydPed/5lUgLthhaFH/cesloE4FoKQzGNvmXQt5AEe+o2ScVLWoEvGKBmQRtTzzrh1I1Kj5C/MfS31fv4b88nXmwsm63Vg0gqfcPCL4c4BDf4mwMmo6mK1jAI7CYC4GUOUmgyVfpVh1KqxCDLhV+fsyyBQYc14kpQyFmp2sP94patcCCR0CD2C+vqvR7rw8QA6KfZbRRw0N7RanSMZKDqVLNU6r4c2k4InMs8TgiPr6yeg+V9zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0sZqqV1iSKd1Sg26YcCLKy73hbqWBzNLdaeOWWyX6mE=;
 b=HlnXXobtHKLptkqzeiBPcNsJx/r/D4Ay4W+XQOG7Q4mPFDkca5yVO7Uj/0831icCBoQTcIqUPDRI0CGKUwj7ol4zt/9rN1dzwoRvb/8S/2TIsV8ANPl8hFQ39FAJPc49Jfdx8zdjI9y5A5Mow07ClIvHXWoOykGRdL3bpk2PSL8=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5480.eurprd08.prod.outlook.com (2603:10a6:20b:de::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Sat, 6 Jun
 2020 08:18:30 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3066.023; Sat, 6 Jun 2020
 08:18:30 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v5 10/13] qcow2_format.py: QcowHeaderExtension: add dump method
Date: Sat,  6 Jun 2020 11:18:03 +0300
Message-Id: <20200606081806.23897-11-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200606081806.23897-1-vsementsov@virtuozzo.com>
References: <20200606081806.23897-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0036.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::23) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.130) by
 FR2P281CA0036.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:14::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3066.18 via Frontend Transport; Sat, 6 Jun 2020 08:18:29 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.130]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6d4c8b91-f1a8-4601-fa6e-08d809f23210
X-MS-TrafficTypeDiagnostic: AM7PR08MB5480:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5480429064DF5387F87DF8DFC1870@AM7PR08MB5480.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-Forefront-PRVS: 04267075BD
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OCPllso8ukDqFhe5xlyYjOQdZexMsGz4oKFd+juRVD47E9orEYhq3RnKQzThayDI0rFM07zg0xrQypOaDrXqVjTP7+I2h4dHuqsIsP4GBF2Yeg3jEjXJwnyQoZmmmBgERXKnppZB8mrP3MmoHZiM71vRf67sGViaogJKDLIGjvkm5eUklcpgpBPaxLLvd8AF4TKXwfLbf6WIOq5cGkyemESxHFd2sEYzapZUISy8Sy5OAvCz/98yS1tOnjYe0BZDT/ek25DBFJD2ABbrkgzZsOicPQubahe3Tgx5E/mM1zBLq6FUU4EOjYu+sp1CCtrKp/KN9G1cobpXH31Keqab1w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(366004)(39830400003)(376002)(346002)(396003)(107886003)(1076003)(4326008)(2906002)(36756003)(6512007)(66946007)(66556008)(66476007)(6486002)(5660300002)(83380400001)(478600001)(86362001)(2616005)(956004)(316002)(26005)(6506007)(52116002)(6666004)(8936002)(6916009)(16526019)(186003)(8676002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: pPCgOV5l4fB3GD+YbWqtfvDxnA9eP9FrnJauQEPwAuPWClh9eYGPM0zqL+bWQMO10N22UkHYql3J9JM0MFygFEkOyK2qTQnetdyuVZgGVs7/pFhdr9zBXpf2hthWHxjlKMMxcsSDvk69Vr1zHYAT/Z26OOSI1HXKF+1lMajaxTY3vHp/x3sEceifeWwg1PPE3zyAZGpvNTV72YFQhO8oIRXk5i7b0jGfx4Tt4Q0BV1rvqhCtrgzqg6GbHAX8mjr3dijOAN78fD7617Ek4J6ndFrhR3TOMbs7t8fQodrYGlF7ei/jJXuRboOWJRfGc/N6iq4i437QPoVNln3Sle89BslAB03iiMdB/Ljsn8/WvSMaHqALwmQM/6dP4z0FWkegDxV6ijL3QwI1YsyzmLhNITGJWWU7CxzGxX4DwOCstkgZjyizaTlHZcRRoL+aOwZhIuY+Eui3U/xYlh+ZnqCrQwgrzSfIsE/rt2RGQOc+JQ0=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d4c8b91-f1a8-4601-fa6e-08d809f23210
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2020 08:18:30.0749 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: saxgg0pFKA3OPy6jNM9lXMRzCg76EsxdE3aCb33XMTAVqzaIIIGArbMU5r48heaiDprMaZLlk1QIzI7EDuz3CGCbovQrB6uvvtSjVU+dNW0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5480
Received-SPF: pass client-ip=40.107.8.98;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/06 04:18:34
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
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
Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
---
 tests/qemu-iotests/qcow2_format.py | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/tests/qemu-iotests/qcow2_format.py b/tests/qemu-iotests/qcow2_format.py
index 74a82f9263..d4ad5431b2 100644
--- a/tests/qemu-iotests/qcow2_format.py
+++ b/tests/qemu-iotests/qcow2_format.py
@@ -108,6 +108,17 @@ class QcowHeaderExtension:
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
@@ -210,15 +221,6 @@ class QcowHeader(Qcow2Struct):
 
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


