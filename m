Return-Path: <SRS0=QD06=ZF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B47B0C432C3
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 22:54:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B989206E3
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 22:54:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="zutnINZ8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B989206E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52052 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iV1Wd-0001T4-Fx
	for qemu-devel@archiver.kernel.org; Wed, 13 Nov 2019 17:54:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33938)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1iV1TP-000846-LI
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 17:50:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1iV1TO-0007eB-9S
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 17:50:51 -0500
Received: from mail-eopbgr820113.outbound.protection.outlook.com
 ([40.107.82.113]:22310 helo=NAM01-SN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1iV1TO-0007aZ-2s
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 17:50:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YJcpMKhDLA3gWLKihQnXmpkOA2rnikXg1HcYGvegxw+CC8qYURoeJ/xLPwQF6gsKa/n000tFT+vpX7N6J4DwGd3CO4zm83SvD+J7abZrLPsELTEApYHZUpgN7spC//saoDCOWwlbGqUuFZDAV/S6YeHLwwUKo0PwkjHqdObT5YSklqjK/ywHSyqKNWWKGVr0kr0YXgl2/BVUuZWgZiFjNTVMY93isYMeky/apdfQn6gqpWLYG1t0R3GKQopKXMM72/cqF8SMnmwznU60/O1qvSw+VSCdoFT8EoZcfLpPVDh2hrhR6ipu0UoSqeB69WPlM8/sR3kSsPpTaP4vEAZgcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6afFiOyBWOOLzbjXQ9U0Kolbxh5m42cEv6mePcB7hXk=;
 b=KeUxaDKuFzuTfDIamDomZFdjHs1TJx1CcD4Btv6USGZs4f1PLONZPjPBQdALxiTDDp5PoBa4JRGS0sEZ2S0wqeu0cg+Fa6Xy7jSjUKlf4Es6GuWSuWEX1Gb86NE/uKTxgOi8nw02stozNMJzCRws6DMwVZchbjUI2aad03jWlrml+G/j+gSahnZ+xEbEokFcOlWJmlKjRp2noZcfmex+J9VzMOc3j5nTEE/K5NssQtULuwoOGwoo2J5z4T6FNg3H76/Rk0zidxagaEnu6h/Qm8+CKkvKTSa0x1GHj5P63XdDBcCJpD6ArM0HcKfncNg5f56ZE4O79GZwHTAhHh4KEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6afFiOyBWOOLzbjXQ9U0Kolbxh5m42cEv6mePcB7hXk=;
 b=zutnINZ8xZ0JvDtQmWuptl1OJNXuDS4kA03MVtQAeVU5kKOqia3OxIBrxnuo88eNvU04REOhvMTbqa7V+qJCQ236N+RTDmIgB6UiJ3y+htyIcCXG9W1Zw3axkrSToKaHM1J3q/VOXAuiSKt0juSTUVSyWEW+Cyhjkj9/O61ERtM=
Received: from MN2PR03MB4800.namprd03.prod.outlook.com (20.179.82.78) by
 MN2PR03MB5024.namprd03.prod.outlook.com (52.132.169.72) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Wed, 13 Nov 2019 22:50:45 +0000
Received: from MN2PR03MB4800.namprd03.prod.outlook.com
 ([fe80::344f:b88:26f0:9f66]) by MN2PR03MB4800.namprd03.prod.outlook.com
 ([fe80::344f:b88:26f0:9f66%7]) with mapi id 15.20.2451.023; Wed, 13 Nov 2019
 22:50:45 +0000
From: "Oleinik, Alexander" <alxndr@bu.edu>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: [PATCH v5 06/20] module: check module wasn't already initialized
Thread-Topic: [PATCH v5 06/20] module: check module wasn't already initialized
Thread-Index: AQHVmnTIoCmmcimMlkur3cd9c8xcvQ==
Date: Wed, 13 Nov 2019 22:50:45 +0000
Message-ID: <20191113225030.17023-7-alxndr@bu.edu>
References: <20191113225030.17023-1-alxndr@bu.edu>
In-Reply-To: <20191113225030.17023-1-alxndr@bu.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.23.0
x-originating-ip: [128.197.127.33]
x-clientproxiedby: MN2PR15CA0028.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::41) To MN2PR03MB4800.namprd03.prod.outlook.com
 (2603:10b6:208:101::14)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=alxndr@bu.edu; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 737dff43-bfc6-43a5-030d-08d7688beb5b
x-ms-traffictypediagnostic: MN2PR03MB5024:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR03MB5024FFA2CD58DF77554D0795BA760@MN2PR03MB5024.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-forefront-prvs: 0220D4B98D
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(366004)(136003)(376002)(346002)(39860400002)(199004)(189003)(2501003)(88552002)(75432002)(54906003)(446003)(7736002)(99286004)(11346002)(6436002)(6486002)(5640700003)(476003)(305945005)(256004)(786003)(2906002)(2351001)(316002)(14454004)(6116002)(86362001)(2616005)(6512007)(6916009)(486006)(3846002)(71200400001)(71190400001)(4326008)(1076003)(36756003)(386003)(8676002)(478600001)(66066001)(76176011)(81166006)(186003)(66946007)(5660300002)(6506007)(81156014)(64756008)(52116002)(26005)(102836004)(50226002)(25786009)(8936002)(66476007)(66556008)(66446008);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MN2PR03MB5024;
 H:MN2PR03MB4800.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yJ1aM6zoOAbCzGUZJJXJmRSNmum7v6v9Z0vPZuFuiEnyP/zP6toT8wl2lvcNPjBFhBEqz52yWhRfL36SJM1J1I10V0Us3ludOzZbD6z5+dABmBIYrxAtEdyWQVxqMscO0MtyOZE2IG/aEExNOb5c1P4tcFcBGeyEiGjfIMP3oUT+j9WqUszyvd+/8g1YFYSDP0FrXIfBQkvgskJaWFnKCB9B+a0DwOrAyMS+VhTGf3FMkz2G2rvxZTftNQDKxlRLg+jXFRzuiFS8IqTkAKHJ08okNMLyjA1Kw+ScDWPWCwtY10Cbl690zRKXL7/AtRPymNrhVjH7GJ7zjkLUpwtsLDVZpQ5TIL2pvZ+ldYqshANZixH5xYViH0zDYBlASmUOlUTgaaoiwzxjJIVYZO0U7UaITYORtxo2gn8dOtMdv6p+A7oXNaC74QKPPSF9jWkf
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 737dff43-bfc6-43a5-030d-08d7688beb5b
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2019 22:50:45.6146 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J2/134U4pxjzm9EcNfEGv5Zw8DX6kiSurhxpYgWsyLwYZhi0ZUKntSxV3mwb0dPJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB5024
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.82.113
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

Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
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


