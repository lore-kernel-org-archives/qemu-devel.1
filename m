Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 053A3C4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 07:47:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3E8F206E0
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 07:47:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="cVfSupWZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3E8F206E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wavecomp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57434 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hglbq-0007f7-Ur
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 03:47:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52330)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <amarkovic@wavecomp.com>) id 1hglaY-0007DH-3D
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 03:46:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <amarkovic@wavecomp.com>) id 1hglaW-0006wg-Dv
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 03:46:30 -0400
Received: from mail-eopbgr750130.outbound.protection.outlook.com
 ([40.107.75.130]:44783 helo=NAM02-BL2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
 id 1hglaW-0006w0-0u
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 03:46:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavesemi-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mFSGqYa8uTSwejvg7li/uTUzvO/3okYXRF5wTD94W2I=;
 b=cVfSupWZY4mjcVnC/5OBT6FLjiI1HNG9YxVMTTgNQ2GLr3r6PK8Lh2jTpXZI64k9CBRJdABv9uCWenhzldNKlegAf0DyWJQr/uhuixZE0kAuoO8z4xO/tyjxFWumsG89LXzZQOqhrIZ9BjtvRsJeZDsgEe711yoIpZl1kaWUb+g=
Received: from BN6PR2201MB1251.namprd22.prod.outlook.com (10.174.81.139) by
 BN6PR2201MB1041.namprd22.prod.outlook.com (10.174.91.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.17; Fri, 28 Jun 2019 07:46:24 +0000
Received: from BN6PR2201MB1251.namprd22.prod.outlook.com
 ([fe80::b0c5:c059:f809:fc07]) by BN6PR2201MB1251.namprd22.prod.outlook.com
 ([fe80::b0c5:c059:f809:fc07%2]) with mapi id 15.20.2008.018; Fri, 28 Jun 2019
 07:46:24 +0000
From: Aleksandar Markovic <amarkovic@wavecomp.com>
To: Laurent Vivier <laurent@vivier.eu>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "aleksandar.markovic@rt-rk.com"
 <aleksandar.markovic@rt-rk.com>
Thread-Topic: [Qemu-devel] [PATCH v13 0/5] linux-user: A set of miscellaneous
 patches
Thread-Index: AQHVLPqt1oJQLlOmV0mvki9B6RRRNaav4sgAgADHeACAAAMOhg==
Date: Fri, 28 Jun 2019 07:46:24 +0000
Message-ID: <BN6PR2201MB1251D7AD0E7630773C962012C6FC0@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <156166365360.6332.12789669195894130027@c4a48874b076>,
 <735eb279-4f0f-b033-6ee9-eac0262a099d@vivier.eu>
In-Reply-To: <735eb279-4f0f-b033-6ee9-eac0262a099d@vivier.eu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=amarkovic@wavecomp.com; 
x-originating-ip: [82.117.201.26]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 762e0898-00be-44f2-9f89-08d6fb9cb849
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:BN6PR2201MB1041; 
x-ms-traffictypediagnostic: BN6PR2201MB1041:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <BN6PR2201MB104161BFE682FA8CAF659A5FC6FC0@BN6PR2201MB1041.namprd22.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 00826B6158
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(136003)(39850400004)(366004)(396003)(376002)(189003)(199004)(229853002)(186003)(33656002)(8676002)(476003)(11346002)(2501003)(68736007)(5660300002)(7736002)(7696005)(91956017)(486006)(99286004)(76176011)(52536014)(2906002)(8936002)(55236004)(53936002)(53546011)(478600001)(76116006)(81166006)(81156014)(6246003)(73956011)(66946007)(6436002)(256004)(26005)(25786009)(66446008)(64756008)(66556008)(305945005)(316002)(6306002)(102836004)(6506007)(74316002)(66476007)(9686003)(446003)(3846002)(6116002)(55016002)(66574012)(86362001)(2201001)(66066001)(110136005)(71190400001)(71200400001)(966005)(14454004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BN6PR2201MB1041;
 H:BN6PR2201MB1251.namprd22.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: eFXYVt5NUAhoHOZn7SCT6uRIUZbqxNcuk+kwLKadWoZgYmhiEt6M85Bjr835VrIYS8Zrugrqd7yeYcWKa0hmWj9yVyfKa1yHmIfgdzmGQ1iMoPKi4Bin+oCumjzxRpCRcmOAuJGg8h/UHmpkdbVotnbDAsODPCf2kWtombBaTZqITbeyg3foKu4WmWIKL7vY5An1qvFgVxGvhHV34ezTBviwwdilBYvZf/ymfbzRtc9oh+Zh/FUSO8ppZPde1c3C4I3sBIUlmOTdIZZDeicEGFs68NxutHe3SdQW9Nl1vtktqE5pzI8k+ITTHE/ieHPqFSMsZI6sxTOosWSxTIXE9O6+d7qrIlrY3SQrr1FP8N32ksO9z1E3VCQUVAkr3o/lFrNskBqVxNt/yv47sRfogxNbE+hA1D4m3wRSQEsiOr4=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wavecomp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 762e0898-00be-44f2-9f89-08d6fb9cb849
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2019 07:46:24.2264 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: amarkovic@wavecomp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR2201MB1041
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.75.130
Subject: Re: [Qemu-devel] [PATCH v13 0/5] linux-user: A set of miscellaneous
 patches
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

> From: Laurent Vivier <laurent@vivier.eu>
> Sent: Friday, June 28, 2019 9:21 AM
> To: qemu-devel@nongnu.org; aleksandar.markovic@rt-rk.com
> Cc: Aleksandar Markovic
> Subject: Re: [Qemu-devel] [PATCH v13 0/5] linux-user: A set of miscellane=
ous patches
>=20
> Le 27/06/2019 =E0 21:27, no-reply@patchew.org a =E9crit :
> > Patchew URL: https://patchew.org/> QEMU/1561648298-18100-1-git-send-ema=
il-aleksandar.markovic@rt-rk.com/
> >   CC      i386-linux-user/linux-user/uname.o
> >   CCAS    i386-linux-user/linux-user/safe-syscall.o
> >   CC      i386-linux-user/linux-user/i386/signal.o
> > /var/tmp/patchew-tester-tmp-zqhqa95y/src/linux-user/syscall.c:323:16: e=
rror: > conflicting types for =91statx=92
> >   323 | _syscall5(int, statx, int, dirfd, const char *, pathname, int, =
flags,
> >       |                ^~~~~
> > /var/tmp/patchew-tester-tmp-zqhqa95y/src/linux-user/syscall.c:214:13: n=
ote: in > definition of macro =91_syscall5=92
> >
>=20
> This is a real error. To avoid this you can rename it to "sys_statx"
> (see sys_gettid() for instance).
>=20

Ok, Laurent. But the root cause is a little deeper, I would say - the error=
 appears because <sys/stat.h> is superfluously included, and glibc defines =
statx() basically in that header (in fact, in a headed that is always inclu=
ded by stat.h) - hence the error, I guess only for build systems with glibc=
 >=3D 2.28.

I am going to remove #include <sys/stat.h> too from the patch, is that OK, =
in your opinion? (and, honestly, I am almost positive this line removal is =
sufficient for removing build error without any name changes etc.)

Yours,
Aleksandar

> Thanks,
> Laurent


