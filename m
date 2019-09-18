Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B97E5C4CEC9
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 23:38:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F8FC218AE
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 23:38:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="QomFLKn/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F8FC218AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36114 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAjWi-00039v-LB
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 19:38:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33282)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1iAjEa-0000OI-KH
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 19:19:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1iAjEZ-0002Zf-HU
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 19:19:40 -0400
Received: from mail-eopbgr710133.outbound.protection.outlook.com
 ([40.107.71.133]:31520 helo=NAM05-BY2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1iAjEZ-0002XS-9f
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 19:19:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C308pU3/eCfvuQm0zabaV03ZlNS4h65N/Kbb+/0arHO3u3JutIvXyzkuolm+STLx7hWcOZ6J+8tsSturU12LhdLYztsT94nha+iyYieTSr2+exvhXXuKNe1zI+fq4wRVoCpDke3Bg4cffc1s/jkNXkY1ZsP54Mv682ySZDO+4i49uWaN/7otMS08FbwELTCxB01rRLam2k8o2wd96W2DzLQCebVXOD2lcOttXgxEZLPpRh0hYJal4Ai0WyLqDby4DFKT7c1N0+cQITlR66uGavsDCiJqmA1pOC2XpaEUEqv8UnPfB1jUTV+mHJGFodW3Lwp7nGT834iMq4M4+aJiIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/p1QzYibvxgsgwaKeWSS4iZiMu6nVwgS1ce72zdQKN8=;
 b=KOMFpfkDqnK/omwJye5rEU04ujMaOK6Lbh+aebOfaAR2EsGqP4SFA2qdrkMhuBA4OrWu6z7ObsYwEh9ZTehfDoDcDPiw8+HbCJ2iGp7GTDvYgRKWnPXaOeS63ol8HU13u8Q38Iy7vzQbmessYs6GyJjC3Bc+g4JKpbsqds0kqdoLz/JgKuC31VuLiGECrYqmCOpvmK2x4YCe1Im/ns7AkwOluRBZYRI9eYErwOEMIxDEb/YgjLXkUuGAI0ZXykAwTgTHgXYhE2PQdB0TzopnDPm9M8xqw08dAees0YkTLqI13bKK43gyQPk/MyhZh6KOyD0u8hZIiwO1LfqUjwmRCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/p1QzYibvxgsgwaKeWSS4iZiMu6nVwgS1ce72zdQKN8=;
 b=QomFLKn/tWKlTLquVQ5orS03fPSYaEO6RPTYM1dpBcR6QJMYUCNKtPzNX9aFE3Qur8I2u5y0rWlj9iUc3qVISUcYDSrYLpn6Ij9pMFRlt6bJpypkR9lsPp8d13/Mb/uZSYp6L3wzETC+315dK49/mKryn/SCsMRoSkEniCOfPks=
Received: from CY4PR03MB2872.namprd03.prod.outlook.com (10.175.118.17) by
 CY4PR03MB3016.namprd03.prod.outlook.com (10.175.117.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20; Wed, 18 Sep 2019 23:19:37 +0000
Received: from CY4PR03MB2872.namprd03.prod.outlook.com
 ([fe80::6d88:c5bd:41ad:b107]) by CY4PR03MB2872.namprd03.prod.outlook.com
 ([fe80::6d88:c5bd:41ad:b107%3]) with mapi id 15.20.2263.023; Wed, 18 Sep 2019
 23:19:37 +0000
From: "Oleinik, Alexander" <alxndr@bu.edu>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [PATCH v3 10/22] tests: provide test variables to other targets
Thread-Index: AQHVbneK1DI7wM20KUi8FpcmDyQxBg==
Date: Wed, 18 Sep 2019 23:19:37 +0000
Message-ID: <20190918231846.22538-11-alxndr@bu.edu>
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
x-ms-office365-filtering-correlation-id: 6cb57690-b2ce-4584-c529-08d73c8eac7a
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
 SRVR:CY4PR03MB3016; 
x-ms-traffictypediagnostic: CY4PR03MB3016:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR03MB30163D36C5635AD0E0254DB7BA8E0@CY4PR03MB3016.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 01644DCF4A
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(39860400002)(366004)(376002)(136003)(346002)(396003)(199004)(189003)(66066001)(86362001)(52116002)(478600001)(2616005)(7736002)(71190400001)(8676002)(36756003)(71200400001)(14454004)(54906003)(316002)(786003)(6486002)(14444005)(81156014)(75432002)(256004)(6436002)(305945005)(6916009)(6512007)(5640700003)(386003)(486006)(26005)(11346002)(186003)(102836004)(99286004)(76176011)(66946007)(446003)(476003)(66476007)(66556008)(64756008)(66446008)(6506007)(5660300002)(4326008)(2501003)(2351001)(6116002)(81166006)(50226002)(25786009)(1076003)(2906002)(88552002)(8936002)(3846002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:CY4PR03MB3016;
 H:CY4PR03MB2872.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 2Dt4xdyyGNelqVHsP2gzH9Eh2aektxmPrp1l0wAkciqH6v9sH3RTKbTmsfQxVTLJeASNSbndfyu2dy7EU6qrxyKxTw7b4NZ8gP0OKMsMwrpl3llz40I0wMxAQ2bNvM9XgOsJp4szJtAL6ij56PyQ4rLVnO991LfA1mWlrUtdes3HdwfoCR4xWsGDzf8brhNa+XLvKnCmHAQFzxGvDzcveJVBbEzBBPt7xBE07NYIyyJLN6J2qbsGV58BcY1ABFKQU9/N+StjTGjyBU1IKSE/yoGJn7u10B/53tQM4yOQ1afhJKj0R6InPUXO0b1pw/jnfxfngQj8jb+5CbOAgSKTGkq0FIu2xXx77I14Al+kqLmdhnCB63K3AiE0o/XNSGflkh6KS8xsQAL0w51Ep3piUrRLPTv7AAu6n2oCLOiY0mM=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cb57690-b2ce-4584-c529-08d73c8eac7a
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2019 23:19:37.5582 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ln3VSPqwd7jg+767FgqotgSwC8iINl3/HTFdGE0QaIwZaDRrPNHNGJH7o8Q/NwJK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB3016
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.71.133
Subject: [Qemu-devel] [PATCH v3 10/22] tests: provide test variables to
 other targets
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

Signed-off-by: Alexander Oleinik <alxndr@bu.edu>
---
 tests/Makefile.include | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index b39860a8d0..a9b3c36259 100644
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
@@ -860,6 +859,8 @@ tests/test-qga$(EXESUF): tests/test-qga.o $(qtest-obj-y=
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


