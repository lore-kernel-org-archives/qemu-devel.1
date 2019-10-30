Return-Path: <SRS0=68uo=YX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50AC1CA9EC7
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2019 15:01:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 179D620874
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2019 15:01:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="TaHvtkrj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 179D620874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41300 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPpTU-00049a-5j
	for qemu-devel@archiver.kernel.org; Wed, 30 Oct 2019 11:01:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35312)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1iPpIP-00050O-KY
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 10:50:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1iPpIO-0007Hu-CK
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 10:50:01 -0400
Received: from mail-eopbgr800133.outbound.protection.outlook.com
 ([40.107.80.133]:23904 helo=NAM03-DM3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1iPpIO-00079I-7H
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 10:50:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ecfaSHLJt2CURlWJqMsQsGw8exX3XcFhCFdUXfgzOrOKJAaDfgH0fO2zLvQcZlm5iBQ2vYovS1mSecsP/DRNZc2THVccSwCYlirltB+qwZ+Kzn1WFzqCutvP5o9AW3M1XVU8MxaJgo+XCN7hdwJ2GpjEgzAiaw/Vxay6gdftG0Xykrf9UuIOEQh0kSPf8jzHi8/pWvqGPKsJ6TrDQov5Dofoa0SJKOhNk049QyU5OqdQ+crig7fPfPFmPv1AyIfJnEOGuGD5g5vndHdOrTGmdsjMher/esW6WItw8MZ+5SVVgCK5mlOTdldIwwoCzexVPikKOMGQ9fIBSucu8Qfpyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xGhDICg0i0yiAmYx6RdhRfwFQpxKfFEBTDkOM/PVokM=;
 b=ZVjGHnZ60RBeRSCckKz5zEA5ue7R506OBuOer1qkbHTw66o2oSUiuwTCxfEr+UGPPY8TR1Gepooj1RR1q8t4I+J7qI8AfwLg5pOP4WEyO4ibp7yEUjgecT9UDtuTqF6Iyec5kZaV1eH6CVJKvfiLzJR4goYTToKYOc9yXzZX4Xejg2jdbgkHgWsVZbQh8Z7CPrrKV7nD0XscNZCVs/5ILLKem3pJ5Ck/NOkylzMOO/2FpzmaHXYnP71lIVuGQVcs9zmOV5dFGCJBt07rxHVVgzofPM8r+jYNIckWu6FGk4XwNq31SqMkCqn2aCnWUcWcMRN01jowOjBuH1YaUxTObA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xGhDICg0i0yiAmYx6RdhRfwFQpxKfFEBTDkOM/PVokM=;
 b=TaHvtkrjPEJTSKkPiVrx3izfG+OsiYulKxYaCkgLryY7AoxQLh7iR6CgQUtfUCh3X8iZetob/iyLstKQvqDUc0CEfnmajX8pvRp+TvcMf+iTl5oQk0IYrLbp7Jv9zJHNkchqzvN6HAt60Ren3iE2pDc/u5ByiDnXupfeDaXugbw=
Received: from MN2PR03MB4800.namprd03.prod.outlook.com (20.179.82.78) by
 MN2PR03MB5054.namprd03.prod.outlook.com (52.132.170.200) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.17; Wed, 30 Oct 2019 14:49:54 +0000
Received: from MN2PR03MB4800.namprd03.prod.outlook.com
 ([fe80::344f:b88:26f0:9f66]) by MN2PR03MB4800.namprd03.prod.outlook.com
 ([fe80::344f:b88:26f0:9f66%7]) with mapi id 15.20.2387.028; Wed, 30 Oct 2019
 14:49:54 +0000
From: "Oleinik, Alexander" <alxndr@bu.edu>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: [PATCH v4 08/20] tests: provide test variables to other targets
Thread-Topic: [PATCH v4 08/20] tests: provide test variables to other targets
Thread-Index: AQHVjzFKWc/rcZWvH0iPIgR45s9YjQ==
Date: Wed, 30 Oct 2019 14:49:54 +0000
Message-ID: <20191030144926.11873-9-alxndr@bu.edu>
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
x-ms-office365-filtering-correlation-id: e5656aff-6c64-47d5-e376-08d75d486d11
x-ms-traffictypediagnostic: MN2PR03MB5054:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR03MB505417C97FD63FBA42039254BA600@MN2PR03MB5054.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 02065A9E77
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(366004)(396003)(346002)(136003)(39860400002)(189003)(199004)(2501003)(36756003)(476003)(86362001)(88552002)(386003)(256004)(316002)(14444005)(5640700003)(1076003)(99286004)(6916009)(75432002)(486006)(786003)(11346002)(6506007)(4326008)(186003)(2906002)(66946007)(26005)(6116002)(14454004)(446003)(2616005)(6512007)(305945005)(71200400001)(478600001)(71190400001)(81166006)(102836004)(66556008)(64756008)(50226002)(8676002)(81156014)(66446008)(6436002)(2351001)(25786009)(5660300002)(66066001)(52116002)(66476007)(6486002)(3846002)(8936002)(7736002)(76176011);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MN2PR03MB5054;
 H:MN2PR03MB4800.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QGnd6nrzhoyCO4NRaZ5ECOP5pYwQm8lSzHfPgLae3MkH6MyaDs2VaUD/njwwuz17d8jqhBMuGdPXE09tRvHCxow9XPhurVqoUbQm4u9tfNC3X4pB+izuKlLO4VANAaSvb7QA8VNACzVNh7cUeHhQex5pKXYY2aDZJl0bD9USj825Wh5UhejgQ1gA06NY90Q4HIx3tpN0ZzA+YQ04+rKuYzjUPIROSURRUJooDsnVdXlYRbPyURWujyp2l/q8d6ogfd2tCzYMJBuGlYOPPHVJ9szkA32JMQX5nzSGpxAk5CuGYMFirUuNqqaN5deH+sm5vXDK9UB4fFCCnY8XKbYAxn5gJ7+Ksfe54ZDLC8A6g9zNvOB92M4uRwtH2adIjemYo0D7whGNeYeNWHu96vm3IqaBfQEjkqU1Xnm18/WudRDpzj4RAnxse6CuMzMETDbU
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: e5656aff-6c64-47d5-e376-08d75d486d11
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2019 14:49:54.8340 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WrY8ITreqGbRG6Yi1rtw2iDKZVEFg3HHeRphcaH20x6NJKiy4DrkTL7UfRrJqPzn
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

Before, when tests/Makefile.include was included, the contents would be
ignored if config-host.mak was defined. Moving the ifneq responsible for
this allows a target to depend on both testing-related and host-related
objects. For example the virtual-device fuzzer relies on both
libqtest/libqos objects and softmmu objects.

Signed-off-by: Alexander Oleinik <alxndr@bu.edu>
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


