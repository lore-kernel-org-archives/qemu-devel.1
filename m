Return-Path: <SRS0=vzij=WB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E1E7C0650F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 19:58:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 363DB2054F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 19:58:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=wavecomp.com header.i=@wavecomp.com header.b="saP/3SFX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 363DB2054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wavecomp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56768 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1huj7w-0005g5-Eo
	for qemu-devel@archiver.kernel.org; Mon, 05 Aug 2019 15:58:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54086)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <amarkovic@wavecomp.com>) id 1huj7Y-0005Fn-5x
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 15:58:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <amarkovic@wavecomp.com>) id 1huj7V-0006QR-A6
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 15:58:16 -0400
Received: from mail-eopbgr770119.outbound.protection.outlook.com
 ([40.107.77.119]:17230 helo=NAM02-SN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
 id 1huj7U-0006QA-9K
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 15:58:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YQImtzlPxSfntX9rCyBBUEgwSNR7P1svrOTXUNABtUB2PrW7KyP1PNnms6peMDSwn0t+0FLZItx1a4/apGhCl+kPjcOrlN5M4ZBpfnQ2XXyG8TDR7VOjjWXiiQTlhgWWGlAJuBrxOT/hJmjwjxASKZ8C4KffqdgKfoYTNDMIAaNQawnorkf69Py0jDhxYg5GqIDEL++pBKWleW35HhWRXYC9I0MzVsdQh8TAXlNgDbZxf+SM6Cv81m4WJW6xFcXkwPv7JQU3SxNcjjCFQqJuNXrF1Yc0CDzdEIck7fhVoHMdqc8qkSvJwphRFb9WAaFwOwf8kUjaI69pFtq8G8iEVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c9F97lClV4EGAiVrszp4Qnbb5x33zEW6FuV0N+ZiLug=;
 b=QCng56tDayP/thfyAAoc7IUvT1UHABp+FYhjtt74ol8/Kk+NrZOoUasQy06enyruZbnPTIKc+MvzkrQSAW5Pqh0ZOPdfTra51Aa6FqJOrOZ988A5IjCka1ufH0D9PMJmNEULkPW/bA5+LtISwrKIcpa+5TGJI5SLv/NDtjE/yDuIa/KZvF2y1PUnl7SuQ3cc8lI0Qj07DERJFSm4uVw6Xz67599+AeZ+CXMSRzkprnfE3A+cljIi7B8Gb9kkF/IqQ67aXKZSO7kpfRbLyYk6plY5kiBiOTEUca2MPlM+TdCGM3j0VMW+HVgvTPhNrwTUY6algY8FCxcExJmG9BVYgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=wavecomp.com;dmarc=pass action=none
 header.from=wavecomp.com;dkim=pass header.d=wavecomp.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wavecomp.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c9F97lClV4EGAiVrszp4Qnbb5x33zEW6FuV0N+ZiLug=;
 b=saP/3SFXR53KeBXrE75T8NDuNZLyzscsgHNvnwW/J/39gEpspb56SoNcKPtw0bKAyXtwmcubsuftsw2EMBY0J9tfgpyU1NMSD5xOT29LcJI6sPloQun28NHQyVPHQnRhHOXbyc715nSAcK1XeEf2k/24M82cVV0zU4QrK8MtU+4=
Received: from BN6PR2201MB1251.namprd22.prod.outlook.com (10.174.81.139) by
 BN6PR2201MB1634.namprd22.prod.outlook.com (10.174.86.38) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.16; Mon, 5 Aug 2019 19:58:09 +0000
Received: from BN6PR2201MB1251.namprd22.prod.outlook.com
 ([fe80::509b:7797:a22a:f2bb]) by BN6PR2201MB1251.namprd22.prod.outlook.com
 ([fe80::509b:7797:a22a:f2bb%3]) with mapi id 15.20.2136.018; Mon, 5 Aug 2019
 19:58:09 +0000
From: Aleksandar Markovic <amarkovic@wavecomp.com>
To: =?iso-8859-1?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>
Thread-Topic: ]Re: [Qemu-devel] [BUG] gcov support appears to be broken -
 solved?
Thread-Index: AQHVS8gawpQe2i5k0UCvqDlNkI5TPQ==
Date: Mon, 5 Aug 2019 19:58:08 +0000
Message-ID: <BN6PR2201MB1251DDE90B06660DCE54FA9EC6DA0@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <BN6PR2201MB1251F757F3129C433E540F9AC6DA0@BN6PR2201MB1251.namprd22.prod.outlook.com>
 <CAFEAcA8NE=hy4a-WuDuKeysi3KOjy8=ybHbLKkvzPM=ELvXBnQ@mail.gmail.com>
 <BN6PR2201MB12512C8AF64BD24CFFA9BCCFC6DA0@BN6PR2201MB1251.namprd22.prod.outlook.com>
 <BN6PR2201MB1251F3D9E077A24F1E6106B6C6DA0@BN6PR2201MB1251.namprd22.prod.outlook.com>,
 <87y307ifqv.fsf@linaro.org>
In-Reply-To: <87y307ifqv.fsf@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=amarkovic@wavecomp.com; 
x-originating-ip: [82.117.201.26]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5e85117d-055a-498d-ceaa-08d719df3d1f
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:BN6PR2201MB1634; 
x-ms-traffictypediagnostic: BN6PR2201MB1634:
x-microsoft-antispam-prvs: <BN6PR2201MB1634FFA1792F3F50FECEB081C6DA0@BN6PR2201MB1634.namprd22.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 01208B1E18
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(396003)(346002)(39840400004)(366004)(136003)(189003)(199004)(71190400001)(76176011)(6506007)(91956017)(25786009)(4326008)(2906002)(9686003)(74316002)(54906003)(305945005)(55016002)(76116006)(7736002)(53936002)(6436002)(66066001)(66446008)(64756008)(66556008)(66476007)(66946007)(316002)(3846002)(4744005)(256004)(476003)(11346002)(52536014)(5660300002)(33656002)(71200400001)(186003)(486006)(26005)(6116002)(86362001)(68736007)(55236004)(102836004)(6916009)(478600001)(446003)(14454004)(81166006)(8676002)(7696005)(81156014)(8936002)(99286004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BN6PR2201MB1634;
 H:BN6PR2201MB1251.namprd22.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 0zlBzhEAAFj0F71XORfyorXwym5EGM0eAOx4Jepstabz/S1DHtYrpReV0R2KKr9fvcpvTSPRhGHfhR7D947aCyzPHEr6ax5hJU8daaKV7vw0HV4JreKhvFV7bQoBvi1JIV3VLS0J3xs4NiaY5E6h5rpouLWIBnbqG9xLpOW+N1qwt4bPCoMo2EHniZ69/Oxk7CKKCQf0XIog4vlum5xXuHmBD7KHyoAdfCrE3+MP7/DDVQRsGYsNbbAjygJcDOmxM6KETGtSkJ7FVeny2ksKWdv6dzfVZck2opN09V47ll4kCjcD/zES7hR7avwz7B+bWA7tF1div88Nf+djFDLNgHL23CLVnaHMIstwVfxzLyUp4kKp3FP6x3UzHQpsk584mL7t5eFlVN9+tCiitEq4fXr8JWlZ2piKMmCqzQtepic=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wavecomp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e85117d-055a-498d-ceaa-08d719df3d1f
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2019 19:58:08.9560 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: amarkovic@wavecomp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR2201MB1634
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.77.119
Subject: [Qemu-devel] ]Re: [BUG] gcov support appears to be broken - solved?
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> > it shows very low coverage for our FP code (softfloat), while, in=0A=
> > fact, we know that "make check" contains detailed tests on FP=0A=
> > functionalities. But this is most likely a separate problem of a very=
=0A=
> > different nature, perhaps the issue of separate git repo for FP tests=
=0A=
> > (testfloat) that our FP tests use as a mid-layer.=0A=
> =0A=
> I get:=0A=
> =0A=
> 68.6 %  2593 / 3782     62.2 %  1690 / 2718=0A=
> =0A=
=0A=
This problem is solved too. (and it is my fault)=0A=
=0A=
I worked with multiple versions of QEMU, and my previous low-coverage resul=
ts were for QEMU 3.0, and for that version the directory tests/fp did not e=
ven exist. :D (<blush>)=0A=
=0A=
For QEMU ToT, I get now:=0A=
=0A=
fpu/softfloat.c 	=0A=
	68.8 % 	2592 / 3770 	62.3 % 	1693 / 2718=0A=
=0A=
which is identical for all intents and purposes to your result.=0A=
=0A=
Yours cordially,=0A=
Aleksandar=

