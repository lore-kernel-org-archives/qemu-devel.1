Return-Path: <SRS0=vzij=WB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2057C0650F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 10:39:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D7B520679
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 10:39:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=wavecomp.com header.i=@wavecomp.com header.b="ZR81vnp1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D7B520679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wavecomp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52540 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1huaP3-0005kt-IF
	for qemu-devel@archiver.kernel.org; Mon, 05 Aug 2019 06:39:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46483)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <amarkovic@wavecomp.com>) id 1huaOT-0005Kk-Qo
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 06:39:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <amarkovic@wavecomp.com>) id 1huaOS-0007v5-0S
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 06:39:09 -0400
Received: from mail-eopbgr740139.outbound.protection.outlook.com
 ([40.107.74.139]:40096 helo=NAM01-BN3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
 id 1huaOR-0007qF-PU
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 06:39:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RNJzPhQJVaS/1ymZefzDRHw0L2fwdQtAUZ9JmmccgzE79UQ2jYSyJnC7tFuiHPcToK25xoZx/GVOjS7MQkVWyL+Ac1vXgVYmzmrJbkkL1hqw2k/ECzhseq4YJKKdf/SXgT8vd+6t3OsjkJtYzyObSHkZXYNOqFLfcu4pgceVYqUYsHZ+WvrzjmPkgJ708sY4G61SIZR8OPxlAR4d4Pj95XsC1hKhtwiap1TNgO/a5WkU7nNzAlm0jrmfmar7IfY9DwyPAY2N9COs2lVN9jWgHjV1zePGOzJ0x/MOJE4UEKX4QN6OB4N79FDfbgB+6mukp07IFyPKztGA4gFHOsaTAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ba/XpDWMADgFGQNVtFQooA8u62DgtddWzPIEdoSM4MQ=;
 b=X2MSgw09CbfFu7ZzB05/QktyzmlW+u3Jcvez9k1pDNCRKFADEwshHkR9GfpRkQmaUFc9rcYvQKNlL7vo/RB5Vk+p7X6oTKDC0bBC2M5VeF4mGwpkuxp6BkJ8t6XeMA5mrOtgX2B14YgMEqg9BcXYZgx5qxXq0Kj30QRkExgqoceH0hwmhAPkOgHNnWoArO+36Cqq1v4X82JQNKc1v9s7Ctw+giVn4ENhLJq0+u0T0SsqHdXA2+Oe60FinNTNpJ/OLSdE/eOemWkDjrbrxDU75K04lIGt/q9/Dt/ons+r1pUibx7zgt5LqA/QcRBIPdzUaCocnJA2Jv7UlMvqoUGMxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=wavecomp.com;dmarc=pass action=none
 header.from=wavecomp.com;dkim=pass header.d=wavecomp.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wavecomp.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ba/XpDWMADgFGQNVtFQooA8u62DgtddWzPIEdoSM4MQ=;
 b=ZR81vnp1+/UFPL/v85ksfqSRIRvvY2JW6KLDVvE5ur14Qfs/g7PQZtGIi14HxXfIly129WmYzZ5ToTwbldAFyAFYn23NncTQh0YTCX/e6GbCBseDDPF9oL0lLKP2z/zM2w74GEJmVWBLOGOsJCzUj95KL/WCv+1jYFZdcob2Kpk=
Received: from BN6PR2201MB1251.namprd22.prod.outlook.com (10.174.81.139) by
 BN6PR2201MB1265.namprd22.prod.outlook.com (10.174.82.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.19; Mon, 5 Aug 2019 10:39:03 +0000
Received: from BN6PR2201MB1251.namprd22.prod.outlook.com
 ([fe80::509b:7797:a22a:f2bb]) by BN6PR2201MB1251.namprd22.prod.outlook.com
 ([fe80::509b:7797:a22a:f2bb%3]) with mapi id 15.20.2136.018; Mon, 5 Aug 2019
 10:39:03 +0000
From: Aleksandar Markovic <amarkovic@wavecomp.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [BUG] gcov support appears to be broken
Thread-Index: AQHVS3iZjD+NiDYGdECgADXmGKMWkA==
Date: Mon, 5 Aug 2019 10:39:03 +0000
Message-ID: <BN6PR2201MB1251F757F3129C433E540F9AC6DA0@BN6PR2201MB1251.namprd22.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=amarkovic@wavecomp.com; 
x-originating-ip: [82.117.201.26]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c82ba366-c530-49b9-5224-08d71991225f
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:BN6PR2201MB1265; 
x-ms-traffictypediagnostic: BN6PR2201MB1265:
x-microsoft-antispam-prvs: <BN6PR2201MB1265D7F76D75B09090B259B8C6DA0@BN6PR2201MB1265.namprd22.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 01208B1E18
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(346002)(39840400004)(366004)(136003)(376002)(199004)(189003)(9686003)(14454004)(68736007)(256004)(486006)(186003)(25786009)(99286004)(71190400001)(71200400001)(476003)(86362001)(2351001)(26005)(52536014)(55016002)(478600001)(66066001)(76116006)(66946007)(91956017)(66446008)(66556008)(64756008)(55236004)(6506007)(316002)(2501003)(4744005)(102836004)(5660300002)(33656002)(7696005)(5640700003)(6436002)(66476007)(6916009)(74316002)(53936002)(3846002)(81166006)(81156014)(8676002)(6116002)(8936002)(305945005)(7736002)(2906002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BN6PR2201MB1265;
 H:BN6PR2201MB1251.namprd22.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: g8mMds3nP06dzQqja1g8lttYshHxIPULza4B1Mw8Wx76gA+0TEATzm3EdRnYSAid84Atb4MtNOA0Z1GNw02HbfBv/hMA00MeuRgyg6H0c4u18yKj+FbC35G+yb8dJgT7ETJ6GKRdOrNG5NKWVdkQX8AGIGwXBstk8ibLpNVHWjgS8qcbwyUVkRzZvr8APRV8tyneE5vtabDUM2sjaz3so/wWu742l0TH2tNNRFcM78CUUUrppXNSszBNGK0wY7KsYJJrgsRBD1BRwh8hV2obsp+wfJ2VrAxFN6SVqdAclPraYds3zWMnaahGTyJ0pXEoc8FT+LMf2YpD+Hai2It+jVXePW52la7evRdtbLLAuogerHGa7oIORyEr8op42z83h/UmysVWlCc7qWoPriGQo6+XbkfxTEJlV45gnXqMOnY=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wavecomp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c82ba366-c530-49b9-5224-08d71991225f
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2019 10:39:03.2729 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: amarkovic@wavecomp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR2201MB1265
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.74.139
Subject: [Qemu-devel] [BUG] gcov support appears to be broken
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello, according to out docs, here is the procedure that should produce cov=
erage report for execution of the complete "make check":=0A=
=0A=
#./configure --enable-gcov=0A=
#make=0A=
#make check=0A=
#make coverage-report=0A=
=0A=
It seems that first three commands execute as expected. (For example, there=
 are plenty of files generated by "make check" that would've not been gener=
ated if "enable-gcov" hadn't been chosen.) However, the last command compla=
ins about some missing files related to FP support. If those files are adde=
d (for example, artificially, using "touch <missing-file"), that it starts =
complaining about missing some decodetree-generated files. Other kinds of f=
iles are involved too.=0A=
=0A=
It would be nice to have coverage support working. Please somebody take a l=
ook, or explain if I make a mistake or misunderstood our gcov support.=0A=
=0A=
Yours,=0A=
Aleksandar=

