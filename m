Return-Path: <SRS0=QD06=ZF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C886C432C3
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 22:57:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A923206E3
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 22:57:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="EEXcDMAs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A923206E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52088 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iV1Zf-0005BH-KN
	for qemu-devel@archiver.kernel.org; Wed, 13 Nov 2019 17:57:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33960)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1iV1TQ-000848-1S
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 17:50:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1iV1TO-0007et-Me
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 17:50:51 -0500
Received: from mail-eopbgr820113.outbound.protection.outlook.com
 ([40.107.82.113]:22310 helo=NAM01-SN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1iV1TO-0007aZ-G2
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 17:50:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GFPT0o3+QMA6W+LupY7ed+IetrqEZP29+XOSlwqhYK8nt35Im5OCziW2wlJxauKVJsPq/oRPWffGTPwb8RByQYIjEAu+VRMmKbUrX2Jy8fZmNc+x0ORoYrK61ndmj/ZJnnjsF9IJTq4zdfkBCKnpPMgJB/1xFrsPXm8RMt1Mn1Zm/eRUkq6qW6Z3FpeyRfZD5EVwdZx+nN+g7REvgjbXZHfznhpiKLMCHBC3d5zPfce7mwA9TZ7bQrXBAXYq2+HoEt5BqsUW1QxaXDRImX9Dq/W9Hn1uS/vPKOYcl4CRZApF6c8X+QBX/rDsngPpRBk1PvaRSx1nEyaHZ42/9hJw3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DR/qAg/y9lCZVpt0e6hYKMx7ydZ9u+1q+OX86LM2ckM=;
 b=cGLGiyxsUu/spVj0UCWEyezyw2+/bgB0Ysyt7HnZc3NsVFuzGbQy4QA2M0nluPA5fzXwGKkfs7Zo/nRud9YtRlfiEqy6iXIQM7VClk5lR+KwI+TbwaoQaBLNTjUlZhQDiwFqj+5SPdkp1ikAcsOr+mfYAGZYbrAygZ0w8TkSmXY3cA7pqVGBIzVjdWr8EROBSTVbXGpnnQK5LgT+lc2VV01vQF0tkkoOh07SB7EBl41+d93nyfv0TezueaBlUimOgPFInoxieJEEo5VQPpa1yDmvN5P3moFprOQRQKLNdW80BLrR1g5S2Gcbq47mMsw8uO4qYxt0yRxogicjGDNC7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DR/qAg/y9lCZVpt0e6hYKMx7ydZ9u+1q+OX86LM2ckM=;
 b=EEXcDMAsAPz+E6Ai1oMnv2aXYn+CwK6iHDXKCUxrx428wgbL/HhIC/y4ltN+eHQQ7I34BWK1w6oAdlj9uTJ5gsambfLQ+9Ri9cXPnly6J31XAZowxctU8Ss7/kQR0iGbTYRGrkm+JqOZ7h1Ixb1cw3Vf3E3SZ6j1NeOyB6m5oNQ=
Received: from MN2PR03MB4800.namprd03.prod.outlook.com (20.179.82.78) by
 MN2PR03MB5024.namprd03.prod.outlook.com (52.132.169.72) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Wed, 13 Nov 2019 22:50:46 +0000
Received: from MN2PR03MB4800.namprd03.prod.outlook.com
 ([fe80::344f:b88:26f0:9f66]) by MN2PR03MB4800.namprd03.prod.outlook.com
 ([fe80::344f:b88:26f0:9f66%7]) with mapi id 15.20.2451.023; Wed, 13 Nov 2019
 22:50:46 +0000
From: "Oleinik, Alexander" <alxndr@bu.edu>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: [PATCH v5 08/20] tests: provide test variables to other targets
Thread-Topic: [PATCH v5 08/20] tests: provide test variables to other targets
Thread-Index: AQHVmnTJlMgvafk0f0iveCySdZfZOA==
Date: Wed, 13 Nov 2019 22:50:46 +0000
Message-ID: <20191113225030.17023-9-alxndr@bu.edu>
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
x-ms-office365-filtering-correlation-id: 726c51da-e1aa-473c-fcaa-08d7688bebf1
x-ms-traffictypediagnostic: MN2PR03MB5024:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR03MB502492591094DA4D9E9E8048BA760@MN2PR03MB5024.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0220D4B98D
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(366004)(136003)(376002)(346002)(39860400002)(199004)(189003)(2501003)(88552002)(75432002)(54906003)(446003)(7736002)(99286004)(11346002)(6436002)(6486002)(5640700003)(476003)(305945005)(256004)(786003)(2906002)(2351001)(14444005)(316002)(14454004)(6116002)(86362001)(2616005)(6512007)(6916009)(486006)(3846002)(71200400001)(71190400001)(4326008)(1076003)(36756003)(386003)(8676002)(478600001)(66066001)(76176011)(81166006)(186003)(66946007)(5660300002)(6506007)(81156014)(64756008)(52116002)(26005)(102836004)(50226002)(25786009)(8936002)(66476007)(66556008)(66446008);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MN2PR03MB5024;
 H:MN2PR03MB4800.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xw8sCASiTxAGwPOFRuti0fLRSEG1g1qgZE9EoBj74vDMEh7gr0Yt1xGVevKFB8Pwf3oSftwESmQUylb1H/WMpnox5HvkkYhFpeiqKvq0aNr/Js0AkZynxePoyzG5Ar2LsbkgUexNBr/mWYcFRwowHDScQtm/qCe2RFp4voqyUNOWw7sypWEqzU31HR/M68bvoFpWYfWPjlNHgt00jU7etANfW003WKaYgr9RdkTtuSVEZ7eGsCdeTbG0pRNsXXyTzSoH6EErvgOSSKU977L6DwkQjOUBSvKXsTfjnHZNKP5tb0yU1PmQ4rUKbJndBf9XNmtRhNvLCSScenRmMULJAtlgvoSKJMYmu+faZnpJCEdPDri/ZbqxV9iWNjxhYcWIEaZWN7nBX8FnKBbGOvD7ISzb7KTNtc8KtWBR31dPzpdyrICrEfIrAXSZSswl40XT
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 726c51da-e1aa-473c-fcaa-08d7688bebf1
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2019 22:50:46.6690 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y9t25vF38BQcTzN1H7lsX6Fx4hw8kZQKU9dw/LxE75JaOOUFeUs3lMBAyY3lUkRE
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

Before, when tests/Makefile.include was included, the contents would be
ignored if config-host.mak was defined. Moving the ifneq responsible for
this allows a target to depend on both testing-related and host-related
objects. For example the virtual-device fuzzer relies on both
libqtest/libqos objects and softmmu objects.

Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
---
 tests/Makefile.include | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 34ec03391c..67853d10c3 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -27,7 +27,6 @@ check-help:
 	@echo "Default options are -k and (for $(MAKE) V=3D1) --verbose; they can=
 be"
 	@echo "changed with variable GTESTER_OPTIONS."
=20
-ifneq ($(wildcard config-host.mak),)
 export SRC_PATH
=20
 # TODO don't duplicate $(SRC_PATH)/Makefile's qapi-py here
@@ -873,6 +872,8 @@ tests/test-qga$(EXESUF): tests/test-qga.o $(qtest-obj-y=
)
=20
 SPEED =3D quick
=20
+ifneq ($(wildcard config-host.mak),)
+
 # gtester tests, possibly with verbose output
 # do_test_tap runs all tests, even if some of them fail, while do_test_hum=
an
 # stops at the first failure unless -k is given on the command line
--=20
2.23.0


