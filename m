Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44F3DC4CEC4
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 23:22:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A4C8218AF
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 23:22:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="H8HIecMM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A4C8218AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35952 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAjHF-0002o8-Ka
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 19:22:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33243)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1iAjEY-0000J0-EX
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 19:19:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1iAjEX-0002Wh-D5
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 19:19:38 -0400
Received: from mail-eopbgr680129.outbound.protection.outlook.com
 ([40.107.68.129]:42238 helo=NAM04-BN3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1iAjEX-0002Vm-85
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 19:19:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XDWVh8CLMuXnqwEQaUph15SOI9eV5uq87I7YpyKmGa6Tu04TOvSYReIh+vGwWeYogr47Ddpyig6Ph0LSAiXStq8EedViwMyK0sx3y1wOaAby0zxrTUy44OASWAs44NHr6VMXT9Z4tKp7Otcfew8E3cglQa0Fsi2KZASnENM9AdYbYSdVW/E6Y4VhKp5bYNLXRyVdjoUXPhh8UXJv5n6UXJ14EL8Wo53Q8JwbTTTA8D8XWEfq+5OBYQLgX9uzL9H/FakVVLqLMlr8YvTNYnAmhhcQI02N4StoQS7jdEIzIxHygF8/dr29wGPv4OG9COKJJDLA+59Ks8lVv+/LYDS2BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pgJ+FDSetf9Xbcixba+4dxJmPzmsrIkckesKqeaQtJM=;
 b=fM1kmZNk9XZ9hmOykZOfny64wdG2DcQqsLSgGFBZcGSk3N49YkvPwnbyywZgNDGnrJVsSlTOQ3WgeM2cNZ9T+FDmjsSKmDvpy2NeMBI+UvRFkKD5SY+FSebHXUYN8UmTUTFOUceN6ggsD9FNweI59BfmSO3AZc+nn5QkTZJmQwsTYYrNo4FUR5S0z3LK48ewSh2Voh6ghzzVvBBVBcUDicK69U673MRkwLJq88F0UugmowAtNuJPrdws1KWK2OqNDKDnpXHvKJBMXWFYWD1Q5HBztFEXALDvTU6PyAEN9izo7Dy17KQ2hxb0hIADp+YG7VGdFOmBdd3F8P7kDQkqeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pgJ+FDSetf9Xbcixba+4dxJmPzmsrIkckesKqeaQtJM=;
 b=H8HIecMMQ5EGkzmgbcxRIdyHUcDIxKc4aBeHu7YwcOTQD/2WeFdh/NZqkB7hoW6WUxwLGsrAzLdqPOxTlH/+GyAye+kqB1XoKctMZFVM2lSv+q3DxKC3L/8KcQ2VNSdTbsRKduyrGKuAufbcNsHXhlhHNGHgnV53IoATbMLbqYM=
Received: from CY4PR03MB2872.namprd03.prod.outlook.com (10.175.118.17) by
 CY4PR03MB2695.namprd03.prod.outlook.com (10.173.43.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.15; Wed, 18 Sep 2019 23:19:35 +0000
Received: from CY4PR03MB2872.namprd03.prod.outlook.com
 ([fe80::6d88:c5bd:41ad:b107]) by CY4PR03MB2872.namprd03.prod.outlook.com
 ([fe80::6d88:c5bd:41ad:b107%3]) with mapi id 15.20.2263.023; Wed, 18 Sep 2019
 23:19:35 +0000
From: "Oleinik, Alexander" <alxndr@bu.edu>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [PATCH v3 08/22] module: check module wasn't already initialized
Thread-Index: AQHVbneIl3rR1NcDEEWCktt8ha+RNw==
Date: Wed, 18 Sep 2019 23:19:35 +0000
Message-ID: <20190918231846.22538-9-alxndr@bu.edu>
References: <20190918231846.22538-1-alxndr@bu.edu>
In-Reply-To: <20190918231846.22538-1-alxndr@bu.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.23.0
x-originating-ip: [128.197.127.33]
x-clientproxiedby: BL0PR02CA0124.namprd02.prod.outlook.com
 (2603:10b6:208:35::29) To CY4PR03MB2872.namprd03.prod.outlook.com
 (2603:10b6:903:134::17)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=alxndr@bu.edu; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 00b2fcf6-8c94-466a-b300-08d73c8eab3b
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
 SRVR:CY4PR03MB2695; 
x-ms-traffictypediagnostic: CY4PR03MB2695:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR03MB26951D8614F51CF2A43A93EEBA8E0@CY4PR03MB2695.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-forefront-prvs: 01644DCF4A
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(39860400002)(396003)(366004)(136003)(376002)(346002)(199004)(189003)(2501003)(36756003)(86362001)(316002)(2351001)(6916009)(3846002)(6486002)(6506007)(6436002)(76176011)(386003)(52116002)(88552002)(75432002)(2906002)(99286004)(5660300002)(5640700003)(6116002)(6512007)(4326008)(25786009)(7736002)(186003)(50226002)(305945005)(102836004)(66476007)(446003)(26005)(2616005)(476003)(66446008)(478600001)(71190400001)(14454004)(64756008)(71200400001)(66066001)(786003)(8676002)(54906003)(1076003)(486006)(11346002)(66556008)(66946007)(8936002)(81166006)(81156014)(256004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:CY4PR03MB2695;
 H:CY4PR03MB2872.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: jxR9/qZ+6YW4O01lbq39j//hbCfjMWQVCzafJnOpwdbmIudLMGSmTmW0jX+l+o+g+5PS3SstrECLqXlBabA9ZjhcmiC3giPgqyFuhCenZ2QSitH3f+jjsbxQAFIW/tgfpTTNwObvzqKmt9x77PQeU9Gno8iaIGhA+HvdOIFjLdQkXfWH1P99pBXnIes5Ic2Bm7VU260ZbP997X0seJ32fRmh7k6iVMfBcoq0QXBRZuEHQM+vsvw77aXlhiyUqF5dFC8CfqQ9XhdfGGwPbHiVv0RNNZ7Dl5jnvq86VDx6jrJRrGBit7Tv2vktJiII10rs9U8RfJPADPzXsLAjTbF/kn6A2U3JiVeX18A7wQwfmCBUzbxLaTczzVA8D2ge+Bg+T5fmMqmnSBr5AqxMfz1ue5Ez+f6MkAI5h2gTRlyKPTQ=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 00b2fcf6-8c94-466a-b300-08d73c8eab3b
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2019 23:19:35.4202 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AJcXg6hiMwN8+nR9XNh0/TVNgLPjNVWEFMgpmsifVocpgz+/RIszQ1gb5DjVtzQ5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB2695
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.68.129
Subject: [Qemu-devel] [PATCH v3 08/22] module: check module wasn't already
 initialized
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

The virtual-device fuzzer must initialize QOM, prior to running
vl:qemu_init, so that it can use the qos_graph to identify the arguments
required to initialize a guest for libqos-assisted fuzzing. This change
prevents errors when vl:qemu_init tries to (re)initialize the previously
initialized QOM module.

Signed-off-by: Alexander Oleinik <alxndr@bu.edu>
---
 util/module.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/util/module.c b/util/module.c
index e9fe3e5422..841e490e06 100644
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
2.23.0


