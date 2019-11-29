Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF5F1C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 21:48:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86C4F2464B
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 21:48:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="dYclkLuQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86C4F2464B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35458 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iao7L-0006J0-9l
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 16:47:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48153)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1ianug-00006K-Q4
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 16:34:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1ianue-0002te-P4
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 16:34:54 -0500
Received: from mail-eopbgr790122.outbound.protection.outlook.com
 ([40.107.79.122]:35989 helo=NAM03-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1ianud-0002ny-Gw
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 16:34:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R9DN2KfNRHwJ+o0XOJN8pl0gZTYQuWEg6Du17zhx1qFJtB00KVJGugMDTT/pM9j5pYIuF9o5PcKXwHbfA1bknZ8kdSkYv5kHx9al4mxf7ImxVHjDQMxeZMeRkDNEijb3iqs9980qqx3fw36VUVY7CvFHiVBHEkxBS8TA8995FaJNgWL2dEOwVVY3qcQG/JiZMvUMwWUXLAcQE08/gjBsWH+pJHPR9dGrmnGF+/D3IBrTzJcc3UTfwCH9InZA+qMBGdu3ZZQ44loErHXrhn7g6QbAnCcualZTfFSEsJjq9BnSRzV3Gx6dY2TGjZjF8aw0HAE5cx+NHBxYzjYqjfXziQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=44b5c10DB+Wmml3F/rSxGkbqkBuWfsco+2BPPiJFi9U=;
 b=bISLcEakqkN11HVTBUCGBnnx1I+QnqiglqvL5yOm2raf4376xRVziDkFl7XBSa2EASTFLhUGFwZY7Ib9AVCXnWY1pvwHAS/AvHKk1ZzYbC6i8K7iFRHYRpBmiqw2pWC0R/VwgXMn4gEkLLVCFrIqH4nmMxr02JPQHjqIxIHxaFD3xf16RqNBmiuCzlagb0iuHrjlMm7iGCni3kPSiTjdtUr5IkP90uzC7bLajj3zf+9NqO6kVhYolUuYEsOF6UOf/p2wd17RBxX3+UzEKtropGq/eyo19kmKGJ4BM5MVKi2wpjieSnYkXvJIbEL7/NBLY+GVLkMJW3vQ6AHb1XQbBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=44b5c10DB+Wmml3F/rSxGkbqkBuWfsco+2BPPiJFi9U=;
 b=dYclkLuQ/h+kilzQ6x5HHnrPKe6tF8zBhq4DPHE0VTgIK1NzBt9W0KQ2CA8XfIa2kVc3E4xc7DmVDrFX+ulkEXfKsVf6KRmguAXNLvg66MC2r96wY2ctxW6jemwLvoKSsBx+BCQj73beyN8SUX82lz1HSx9vRTVvAOn2sSeVx/M=
Received: from DM6PR03MB4795.namprd03.prod.outlook.com (20.179.107.22) by
 DM6PR03MB5050.namprd03.prod.outlook.com (10.141.161.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.18; Fri, 29 Nov 2019 21:34:44 +0000
Received: from DM6PR03MB4795.namprd03.prod.outlook.com
 ([fe80::2557:454e:205e:4d74]) by DM6PR03MB4795.namprd03.prod.outlook.com
 ([fe80::2557:454e:205e:4d74%2]) with mapi id 15.20.2495.014; Fri, 29 Nov 2019
 21:34:44 +0000
From: "Oleinik, Alexander" <alxndr@bu.edu>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: [PATCH v6 08/21] tests: provide test variables to other targets
Thread-Topic: [PATCH v6 08/21] tests: provide test variables to other targets
Thread-Index: AQHVpvzQ6XC4DFFAukqfVNsShezdMg==
Date: Fri, 29 Nov 2019 21:34:44 +0000
Message-ID: <20191129213424.6290-9-alxndr@bu.edu>
References: <20191129213424.6290-1-alxndr@bu.edu>
In-Reply-To: <20191129213424.6290-1-alxndr@bu.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.23.0
x-originating-ip: [128.197.127.33]
x-clientproxiedby: BL0PR1501CA0025.namprd15.prod.outlook.com
 (2603:10b6:207:17::38) To DM6PR03MB4795.namprd03.prod.outlook.com
 (2603:10b6:5:18c::22)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=alxndr@bu.edu; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 92cdf1b3-5324-4e9c-7892-08d77513f324
x-ms-traffictypediagnostic: DM6PR03MB5050:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR03MB505008A7921FDB296D349C79BA460@DM6PR03MB5050.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0236114672
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(366004)(346002)(39860400002)(136003)(396003)(199004)(189003)(54906003)(81156014)(81166006)(66066001)(6436002)(3846002)(8936002)(66946007)(6116002)(1076003)(66446008)(64756008)(66476007)(14444005)(256004)(66556008)(316002)(786003)(8676002)(6512007)(102836004)(6486002)(478600001)(71190400001)(71200400001)(2351001)(86362001)(6506007)(14454004)(2501003)(75432002)(386003)(5640700003)(2906002)(6916009)(7736002)(2616005)(25786009)(26005)(52116002)(88552002)(99286004)(5660300002)(76176011)(186003)(446003)(11346002)(305945005)(50226002)(36756003)(4326008);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DM6PR03MB5050;
 H:DM6PR03MB4795.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LA8GAId/mgfjOYLUZzpiBNVFg+/w+fKjrlD8BsXFFpLn/2p1SvDU+yQ/MtOLelI/9mZOXyllCZ2qJkRM9sBvNY5ab701pt5rfZ+kIFAsdQ0CKg5M5IMUEjDsE2T0iknCoYI2CuwjQThZMRjAWePGzz53sdPl5bxpZvGS/TKTDGyDWpI5iiGmk1VI8DLVgAHFkScAbzsD6Y6wrsMnSkmFtAIGma84v8OSPRIbQqidYPa/Zo7EK5wLFg/52R25UvLojLTNdqQEWYwypVuN3uVqhkZPBtPyEkx9HGhED/D412D8MiSmBytXNMPyXgmz3QCfXW2G4bbXgr2CR879mLe3xUfh7q+zoVuKrleIURf12rs2GDyPKzElwix3D06Ta869G/OqimI3a3Oyk4EOdlsb4sh78R4kzCUifU47gOVdBGJbzGDdWh2dIVOQuBsHQ89v
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 92cdf1b3-5324-4e9c-7892-08d77513f324
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2019 21:34:44.2545 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /FHQPEEBD+KIxwbYG9dX8CwqNDJ4YjXcPT1c5nfNy6g3i236Ok3hfhoqCN2TugoS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5050
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.79.122
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
 "bsd@redhat.com" <bsd@redhat.com>, Darren Kenny <darren.kenny@oracle.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>, "Oleinik, 
 Alexander" <alxndr@bu.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Before, when tests/Makefile.include was included, the contents would be
ignored if config-host.mak was defined. Moving the ifneq responsible for
this allows a target to depend on both testing-related and host-related
objects. For example the virtual-device fuzzer relies on both
libqtest/libqos objects and softmmu objects.

Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
---
 tests/Makefile.include | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 8566f5f119..3669fd1dc3 100644
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
@@ -878,6 +877,8 @@ tests/test-qga$(EXESUF): tests/test-qga.o $(qtest-obj-y=
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


