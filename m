Return-Path: <SRS0=v56/=TT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 914C2C04AB4
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 12:01:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54AB92182B
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 12:01:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="CT4M6Tp4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54AB92182B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wavecomp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47871 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSKVT-0004EM-D5
	for qemu-devel@archiver.kernel.org; Sun, 19 May 2019 08:01:35 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37217)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1hSKUh-0003c7-Mu
	for qemu-devel@nongnu.org; Sun, 19 May 2019 08:00:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1hSKUg-0001Q6-Qr
	for qemu-devel@nongnu.org; Sun, 19 May 2019 08:00:47 -0400
Received: from mail-eopbgr750094.outbound.protection.outlook.com
	([40.107.75.94]:55047
	helo=NAM02-BL2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1hSKUf-0001Ns-Ji
	for qemu-devel@nongnu.org; Sun, 19 May 2019 08:00:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=wavesemi.onmicrosoft.com; s=selector1-wavesemi-onmicrosoft-com;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=WhjZmyWhyg9q6E2g+Xslt6ggtC49B+GcejKakceCgvg=;
	b=CT4M6Tp4LPe8OuOY1rMJFLHQKpxZQzdgtPpE7qxUOBpB7W4OU0p0tJjRgn82E/cIsPuuOyjtKF0hj85tudyp+0NfKLSKzYNuKj9jrsAc8+BKQcjmTSRMo57MBce4XgJXyB4xpPRBpYF3vxSpxj4AICg8qdJTQmt5dxLV1q4EiUA=
Received: from BN6PR2201MB1251.namprd22.prod.outlook.com (10.174.81.139) by
	BN6PR2201MB1171.namprd22.prod.outlook.com (10.174.90.27) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1900.18; Sun, 19 May 2019 12:00:41 +0000
Received: from BN6PR2201MB1251.namprd22.prod.outlook.com
	([fe80::854a:15e2:b5f:e2c8]) by
	BN6PR2201MB1251.namprd22.prod.outlook.com
	([fe80::854a:15e2:b5f:e2c8%8]) with mapi id 15.20.1900.020;
	Sun, 19 May 2019 12:00:41 +0000
From: Aleksandar Markovic <amarkovic@wavecomp.com>
To: Jakub Jermar <jakub.jermar@kernkonzept.com>, Aleksandar Markovic
	<aleksandar.markovic@rt-rk.com>, "qemu-devel@nongnu.org"
	<qemu-devel@nongnu.org>
Thread-Topic: [Qemu-devel] [PULL 00/10] MIPS queue for May 19th, 2019
Thread-Index: AQHVDjD42uPeb3UWpEan+oXB5O/BoaZyUQ+AgAAGylA=
Date: Sun, 19 May 2019 12:00:41 +0000
Message-ID: <BN6PR2201MB125130243EB8B0ED9AE36848C6050@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <1558263144-8776-1-git-send-email-aleksandar.markovic@rt-rk.com>,
	<bb25cbee-9265-260a-681d-d7d390c007ee@kernkonzept.com>
In-Reply-To: <bb25cbee-9265-260a-681d-d7d390c007ee@kernkonzept.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=amarkovic@wavecomp.com; 
x-originating-ip: [82.117.201.26]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 76f2ff3d-cd5c-48a3-c9cb-08d6dc519d87
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);
	SRVR:BN6PR2201MB1171; 
x-ms-traffictypediagnostic: BN6PR2201MB1171:
x-microsoft-antispam-prvs: <BN6PR2201MB11717E2B4015D4A438A9B31FC6050@BN6PR2201MB1171.namprd22.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 00429279BA
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(136003)(396003)(39830400003)(376002)(346002)(366004)(189003)(199004)(86362001)(55236004)(8936002)(7736002)(2501003)(6436002)(76116006)(305945005)(66446008)(64756008)(446003)(316002)(6506007)(66066001)(476003)(6116002)(81156014)(8676002)(486006)(4326008)(73956011)(81166006)(3846002)(5660300002)(26005)(110136005)(7696005)(6246003)(2906002)(53936002)(55016002)(256004)(478600001)(14454004)(71200400001)(52536014)(71190400001)(4744005)(11346002)(102836004)(25786009)(99286004)(33656002)(68736007)(9686003)(186003)(74316002)(229853002)(66946007)(66556008)(66476007)(76176011);
	DIR:OUT; SFP:1102; SCL:1; SRVR:BN6PR2201MB1171;
	H:BN6PR2201MB1251.namprd22.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: wavecomp.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: TnH0e7f98q8eAIVJ6+3MNKP2+qPO0arW60QliTr/vpBS0YNtrzVZU7k2FU2ib98+4byXOTXcFE48jtNa0Mimd+wNH+myWb1A4FU4k4b+OdRK3Ndo9G4VygcMDhFhSUY8X9+36ur2fAczsWAzfqYkcwGbsf0ebuFVOysCxQ08EoG9eKX3LaItK7MnYIc0u5Xke6DGCZwupatbIfIy9QJorkPTn+BTzztLT3A0LfwE37wtll6mfrOikY/5C6PtJ6r7hE0kRGP+yi8ZZwjvK7Y9VjRk9i8pbVmHt+6kgTEg1RkHIrl8p2/ZZbgxosENzlM4Ub2OBdAmA9JCVHIH2Gdj+RUxGmMS6seMk/AzR2iQDzDRIqrGFwQRvn2bOtELfxBJp35Vy59/TcyHS7ADce9HxY7AakHZm1/mGqOuFg7ooA8=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wavecomp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76f2ff3d-cd5c-48a3-c9cb-08d6dc519d87
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2019 12:00:41.0305 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR2201MB1171
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.75.94
Subject: Re: [Qemu-devel] [PULL 00/10] MIPS queue for May 19th, 2019
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> >
> >   * A fix for HelenOS boot hang (related to the flag PAGE_EXEC)
>=20
> This was rather a problem with failing non-executable page tests in
> L4Re, not HelenOS. Even though I tested HelenOS for regressions.

OK, Jakub, what would be your suggestion for a high-level description
of this message for end users (it is definitely a change that affects end
user)? Something like" Improved PAGE_EXEC flag handling"?

Thanks,
Aleksandar

