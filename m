Return-Path: <SRS0=vzij=WB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91C15C433FF
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 07:14:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EBCF20657
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 07:14:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="rZxUoepw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EBCF20657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51310 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1huXCo-000382-Mj
	for qemu-devel@archiver.kernel.org; Mon, 05 Aug 2019 03:14:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37241)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alxndr@bu.edu>) id 1huX9A-0003An-AZ
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 03:11:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1huX99-0001tz-Ah
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 03:11:08 -0400
Received: from mail-eopbgr680091.outbound.protection.outlook.com
 ([40.107.68.91]:20741 helo=NAM04-BN3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1huX99-0001tG-5S
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 03:11:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KSGZvBtD7lj3qvR4H6fZ+G7H2FFNySmmd8SlM1RCdaAnlHzVkUqFsyg81CS1pAVKT+aPRKGoRU1Jcvr6+flBpQpOQ00JuVVJ0gzn8i+niu5+Xtj0IkanRt/FSSbbbSf72EmWbDyKcjKoAk+FNXrNBc6LEWcvMbCO7sULQmTKMHF1pSRto/XvsQlIuTqTZ3quo5fbxDCIK7M/8dubgVNxM+Jyv+zk0CS1ydZRbLys2XNmP0WUYJANSxco+mwd9A6v7paqR6L019P1q//JsmX5ZJ1x8IT2DzO9BLs7hps9B1Zbn8jB0q8AjLyuolsp4MBCfZo/VR6vYn1ZKCcLT/0dYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p4GBgiG4EQNZD54QyUC/SjoQBw8MmLGO998mNRRXw9k=;
 b=FV7/aiYgV+Os+VFvvVpA6Oh6dat5s57ZyGTULwgBauwxIfRb4BDHNuo2/xLt3uB5wjgtMWhPSh+EkQ2BoyGkqx9vi8gsktAC715EqlhauQ5ci1v0XdFE1mvaDLG1cBddfM/C3u41715xL7FFpE5//kgct/hQ8nebJeb2VYVKGUMN5sHcd/c38CNSUkOwbcdd+/QZss2hQG4Mm16wf3Ek6XTFOhl7RgRUX8zO1GNPQFFWjP0DAMEaTRjcnzk+HVQ3Uf9ZF9c4xwl5tAYF0b32FC2Q5B213omb7ZoyRMFycpaT/b+F0Ui5oVQ8105Em3QV1IpDzBqkaMY6tijVz8MFxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=bu.edu;dmarc=pass action=none header.from=bu.edu;dkim=pass
 header.d=bu.edu;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p4GBgiG4EQNZD54QyUC/SjoQBw8MmLGO998mNRRXw9k=;
 b=rZxUoepwjXhe157v1S3JSFKP0iWDaRuj5Eb3bLXMuIW5j8Wv4+mA1+jOLSyfxxHHuv4KYpqk2vQa7Ts8CXSWhC+u9zqG2HstDWrnaKU8WbENAPJY0/xd8ULFRY6GpD5Kd06pmC7ZJUBqEJxYuLJRKT7k1B5Xa8VSn3Q/e8an04Q=
Received: from CY4PR03MB2872.namprd03.prod.outlook.com (10.175.118.17) by
 CY4PR03MB2646.namprd03.prod.outlook.com (10.173.43.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.16; Mon, 5 Aug 2019 07:11:05 +0000
Received: from CY4PR03MB2872.namprd03.prod.outlook.com
 ([fe80::6cce:cc85:9e3:d33a]) by CY4PR03MB2872.namprd03.prod.outlook.com
 ([fe80::6cce:cc85:9e3:d33a%4]) with mapi id 15.20.2136.018; Mon, 5 Aug 2019
 07:11:05 +0000
From: "Oleinik, Alexander" <alxndr@bu.edu>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [RFC PATCH v2 04/17] fuzz: Skip modules that were already
 initialized
Thread-Index: AQHVS1zyeePe8eajFEyVAJES1NtnGg==
Date: Mon, 5 Aug 2019 07:11:05 +0000
Message-ID: <20190805071038.32146-5-alxndr@bu.edu>
References: <20190805071038.32146-1-alxndr@bu.edu>
In-Reply-To: <20190805071038.32146-1-alxndr@bu.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.20.1
x-originating-ip: [128.197.127.33]
x-clientproxiedby: BL0PR02CA0068.namprd02.prod.outlook.com
 (2603:10b6:207:3d::45) To CY4PR03MB2872.namprd03.prod.outlook.com
 (2603:10b6:903:134::17)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=alxndr@bu.edu; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fbbc3de2-a617-4aa4-7b24-08d7197414f5
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:CY4PR03MB2646; 
x-ms-traffictypediagnostic: CY4PR03MB2646:
x-microsoft-antispam-prvs: <CY4PR03MB2646A563DF0441792C5C217ABADA0@CY4PR03MB2646.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:246;
x-forefront-prvs: 01208B1E18
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(366004)(39860400002)(396003)(136003)(346002)(376002)(189003)(199004)(71200400001)(71190400001)(4744005)(6916009)(186003)(2351001)(1076003)(76176011)(6436002)(53936002)(86362001)(5640700003)(52116002)(6512007)(26005)(5660300002)(102836004)(386003)(6506007)(2501003)(66066001)(75432002)(6486002)(66476007)(2906002)(88552002)(4326008)(8676002)(316002)(786003)(50226002)(54906003)(81166006)(14454004)(81156014)(68736007)(476003)(2616005)(11346002)(446003)(486006)(36756003)(66446008)(66946007)(256004)(64756008)(25786009)(99286004)(478600001)(6116002)(3846002)(7736002)(305945005)(66556008)(8936002)(42522002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:CY4PR03MB2646;
 H:CY4PR03MB2872.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: I1a8mD1LCHEWJRQjIEdvVEyX+RCczBhd2fteZpBMD98ybtoDSi8PugYsPpa83lxSstiJZ5Bo6QtvymFsoCRZogUCfverZmu1Wq+8QJz53v3mKtZzdx0VmMY9SqV+8TbQYq0rO+FyWCI+EiXHSFglCxSM8QfYT7Qz30YMXgRxoCHo4VM3Cdu9qG3Nm/n76E+VWGHAaDQFtJOYZ3YZK7D9+9xz4LR17e5l8rnMv87xQxbIk73zp4aiS7F5Y+N+vdhioJg1QgUwL9hb+eSWCSIGUiKLrQMxy6BtG9xGhkWCF47sEEz0ydmT0FmlcQUwM003yoTwkM9BU+XSSBq798EZWZmVKfgijhjpRfdePOZg1tYZ4A/28kbH3P5Sa7aiuBr6GCm6IxafLc9VOcSmLM+UKQSPMEqzlgtvFw7KuilK9rQ=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: fbbc3de2-a617-4aa4-7b24-08d7197414f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2019 07:11:05.7686 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: alxndr@bu.edu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB2646
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.68.91
Subject: [Qemu-devel] [RFC PATCH v2 04/17] fuzz: Skip modules that were
 already initialized
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
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "bsd@redhat.com" <bsd@redhat.com>, "stefanha@redhat.com" <stefanha@redhat.com>,
 "Oleinik, Alexander" <alxndr@bu.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alexander Oleinik <alxndr@bu.edu>
---
 util/module.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/util/module.c b/util/module.c
index 142db7e911..3d4380fd47 100644
--- a/util/module.c
+++ b/util/module.c
@@ -30,6 +30,7 @@ typedef struct ModuleEntry
 typedef QTAILQ_HEAD(, ModuleEntry) ModuleTypeList;
=20
 static ModuleTypeList init_type_list[MODULE_INIT_MAX];
+static bool modules_init_done[MODULE_INIT_MAX];
=20
 static ModuleTypeList dso_init_list;
=20
@@ -91,11 +92,17 @@ void module_call_init(module_init_type type)
     ModuleTypeList *l;
     ModuleEntry *e;
=20
+    if (modules_init_done[type]) {
+        return;
+    }
+
     l =3D find_type(type);
=20
     QTAILQ_FOREACH(e, l, node) {
         e->init();
     }
+
+    modules_init_done[type] =3D true;
 }
=20
 #ifdef CONFIG_MODULES
--=20
2.20.1


