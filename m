Return-Path: <SRS0=68uo=YX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27EBBCA9EC5
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2019 14:54:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E22D12087E
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2019 14:54:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="5s5tgxIW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E22D12087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41188 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPpMO-0002N1-Oy
	for qemu-devel@archiver.kernel.org; Wed, 30 Oct 2019 10:54:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35303)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1iPpIP-000502-DD
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 10:50:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1iPpIO-0007H9-23
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 10:50:01 -0400
Received: from mail-eopbgr800133.outbound.protection.outlook.com
 ([40.107.80.133]:23904 helo=NAM03-DM3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1iPpIN-00079I-TW
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 10:50:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nrx3GZeaMMuzXrZO2E2L99uE2nVSsDw/MGygl6q4h+doj9WRdYxqg2KLNKIvyBOB6IgxXVkQbkvhs+nTkCJPMuF1548FLi0i7IRqiM6xl96UMn6VPjZn5XylooV3O9Ld7j+Kse+0/ngaP9XgjkhnWZY0o8PeqU9VA107VHiuPa8lJ6JXAqoQ8/AkGr4yjP4lN2oW2DAaGMqjEzlkOXfG2OMCihj8nq4TNvbSiIK5CmrZ83MioQ04VQMOwW+M9u4IvozzbiIHv1GniPlQgAXbLWlK397afq9vBR/wzXf5Gt2+KUqjbnDVsX3gUA+svVAA1AqgPd/pxWr1+dYQOpPalQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ImLy9FMlqKl3hHhCtlXcmui/XhpdIZAb8SKftD2NrAo=;
 b=S744nIWGoc4cpdKGJw5vU3h92TXhcPflGt0PBvQfJyNtkNKnLnWsKJqdG9MPuf6Lme87HIyAhil1LY5gTjzG4JLK3LGesuaTWh72HC4+4fFXoLboyRmtrbaStJasY2l4CZr4WA+HHwxakHAQRu+rk3agiqHxCpoPnAQtM+Px5sD8N8tNoLzgZIYfHEaCw0HUa1OqIJRBL81WubN7XcZR/MbPCdATfZ0ZvIxsNEDL5kG2/UWySC1POSs/zEqPYEGNtEPl3Ripd1m4thrkN5tIiiGy3yKKvHTmUzEV0X5FJk4O/fF7IvAm9E+2ybFmvkwZ7xyACz5oI5gGjOwYFtDjyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ImLy9FMlqKl3hHhCtlXcmui/XhpdIZAb8SKftD2NrAo=;
 b=5s5tgxIWWeEqOiz2xdbq6CEQuY6R67FRuamhft9QVT6hBEf614c+LJpmU/eTaLJvk4qb10V/777qY3VS8LD4Sxv5v4ZP3pxSzu/u4YUcR9XizU+DQIL2jijhJouiUYw+2yRNN9s7agLDnKr/+wuvw+T30fczRg87/sdpxguHTfc=
Received: from MN2PR03MB4800.namprd03.prod.outlook.com (20.179.82.78) by
 MN2PR03MB5054.namprd03.prod.outlook.com (52.132.170.200) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.17; Wed, 30 Oct 2019 14:49:53 +0000
Received: from MN2PR03MB4800.namprd03.prod.outlook.com
 ([fe80::344f:b88:26f0:9f66]) by MN2PR03MB4800.namprd03.prod.outlook.com
 ([fe80::344f:b88:26f0:9f66%7]) with mapi id 15.20.2387.028; Wed, 30 Oct 2019
 14:49:53 +0000
From: "Oleinik, Alexander" <alxndr@bu.edu>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: [PATCH v4 06/20] module: check module wasn't already initialized
Thread-Topic: [PATCH v4 06/20] module: check module wasn't already initialized
Thread-Index: AQHVjzFJwDtTDBvtp0WSvkX0SfACaA==
Date: Wed, 30 Oct 2019 14:49:52 +0000
Message-ID: <20191030144926.11873-7-alxndr@bu.edu>
References: <20191030144926.11873-1-alxndr@bu.edu>
In-Reply-To: <20191030144926.11873-1-alxndr@bu.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.23.0
x-originating-ip: [128.197.127.33]
x-clientproxiedby: DM5PR08CA0048.namprd08.prod.outlook.com
 (2603:10b6:4:60::37) To MN2PR03MB4800.namprd03.prod.outlook.com
 (2603:10b6:208:101::14)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=alxndr@bu.edu; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 434adcd3-ce44-40da-1183-08d75d486bf8
x-ms-traffictypediagnostic: MN2PR03MB5054:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR03MB50549AAA6A46EECAE31F537BBA600@MN2PR03MB5054.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-forefront-prvs: 02065A9E77
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(366004)(396003)(346002)(136003)(39860400002)(189003)(199004)(2501003)(36756003)(476003)(86362001)(88552002)(386003)(256004)(316002)(5640700003)(1076003)(99286004)(6916009)(75432002)(486006)(786003)(11346002)(6506007)(4326008)(186003)(2906002)(66946007)(26005)(6116002)(14454004)(446003)(2616005)(6512007)(305945005)(71200400001)(478600001)(71190400001)(81166006)(102836004)(66556008)(64756008)(50226002)(8676002)(81156014)(66446008)(6436002)(2351001)(25786009)(5660300002)(66066001)(52116002)(66476007)(6486002)(3846002)(8936002)(7736002)(76176011);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MN2PR03MB5054;
 H:MN2PR03MB4800.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZzT/A5W4/HpScmVIee3553F/A59L0BV8ESLlaeE968X83/Qc0rDKx8YjtOanoctNqCxmI2qA8R4YWxwGG/1yXxRb4A/Q+YRqYKWw0842encx8IoZrb2NCUwSyk5BJ5Y4VyRMQqaKF0Au33jPsnzUd5VOqG8AR+e5ud429dmlvmskb4glja+ksvi3eFdgLT1ZIyad5U0G3ygAFC+6weNBospklvuzCBgLiygkVhAFTqKMC+y/WDBLz42CeFHqSBEyuUaT0IMkbJMwb/bC4Fo0/Bpp3VM3zqmhFnk5SzvsCuuT1FWXix8PhofhjtWj2ZeU0q3cIIn2JssAZRoWOMwVGOUlsZFAMYyt/h2vSDzk5/atCn8E8BrrWU6VCUT8sVRdn2s8PL0WRG24+tSjJvE3UtrI0L7RIM4x5kC1A70pvoWoVhNJtJ/rJJrA+Ovrqcbo
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 434adcd3-ce44-40da-1183-08d75d486bf8
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2019 14:49:52.9810 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yJdT9Kj+qTlloBHjvzK4qKUBWdhSK2SsqJu87Fiezco3/GHdxqa45uFVwqRO/95X
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB5054
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.80.133
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
Cc: "Oleinik, Alexander" <alxndr@bu.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alexander Oleinik <alxndr@bu.edu>

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


