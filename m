Return-Path: <SRS0=TBk9=V5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A49BC433FF
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 16:30:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 238E120B7C
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 16:30:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=wavecomp.com header.i=@wavecomp.com header.b="O+ZI82pF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 238E120B7C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wavecomp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57572 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htDyC-0003dr-E9
	for qemu-devel@archiver.kernel.org; Thu, 01 Aug 2019 12:30:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54361)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <amarkovic@wavecomp.com>) id 1htDws-0002Uy-JQ
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 12:29:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <amarkovic@wavecomp.com>) id 1htDwr-0002MR-LV
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 12:29:02 -0400
Received: from mail-eopbgr810094.outbound.protection.outlook.com
 ([40.107.81.94]:4160 helo=NAM01-BY2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
 id 1htDwr-0002L1-AJ
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 12:29:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KDSeLeFSauGItiHhDNKtFm5NtJuECQ6ZaC4DI+3jYmvVFA1wTIGzN/g7QNfFNRsG+wasaKeDivm0wq5Sy7eXtqfwWiLysQWZbqcmCSM/I8OaDHEcxAcSCf4gNG8NA+y8nM5RHTWo72j103gxq5PVA+NMj6BzHCywfDwleW5CFrufiW98Kcp0D9GSxQXLuXQav1RdDBtBoMfuqLPIIryhNV8+AUUEg2W/Om+adKAjVipOHmyYkmzJUUXIsmnyWnBHPH8uqa3siwZ9YFmSbP+adderQyQDVOWLqHZJb+fCIS8wldcCa/1BD4G87nX8fbPz+IFibGRk4zEybWw3vw9zdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1yx1JhBwaXn+YbORD71c9Cse+W37GxuBAWy1AAU2xc8=;
 b=TRqpcIZW4slgIzblURM/5R8S5e7+koSCi6N5wBWw6kOdjWB9OPeTiGnqeX4NFNbZ6X+w4cyGfNz0oEfZXDsMGyYii8PP5FznXdjHSkDBoY39MqJt9EWvEqB+olZGGFzbqHrq8s9QazRrl5MTz7KKKx3yLKVfHLYHAjcZ4+/Q/iMTfwGd8tqJ+0hy4vg3jBsWTlp6fLc0QhGWI4rpPBkaDzCC0Yp7F7+2ncPChCGF2s7sGf/mvn6rESrCuSQyR69mi8bWLYFyoiZtSqUe6PrBSSSiN+r6R4eVfifzHTRteeaBEZtyS6xDMSpOqNr/Hp9FGm99iG9RWDq9vQ83bNJNrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=wavecomp.com;dmarc=pass action=none
 header.from=wavecomp.com;dkim=pass header.d=wavecomp.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wavecomp.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1yx1JhBwaXn+YbORD71c9Cse+W37GxuBAWy1AAU2xc8=;
 b=O+ZI82pFvv9EEq1Zx+8IxtgszV6dlqf7w6MXIA5XvniqtsqJjK7jKB/ttE2xEYLEUhhLf8EG4BM7S4qpr9SicKA7NzpoAAN4Ep0BqwXTh/cMnP8DTuNuqeLwHaVKxnBaqYjkCv7mHYXYLcX38E043uws5XUyA1/7GZ+GCx/DcL8=
Received: from BN6PR2201MB1251.namprd22.prod.outlook.com (10.174.81.139) by
 BN6PR2201MB1058.namprd22.prod.outlook.com (10.174.90.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.14; Thu, 1 Aug 2019 16:28:55 +0000
Received: from BN6PR2201MB1251.namprd22.prod.outlook.com
 ([fe80::509b:7797:a22a:f2bb]) by BN6PR2201MB1251.namprd22.prod.outlook.com
 ([fe80::509b:7797:a22a:f2bb%3]) with mapi id 15.20.2115.005; Thu, 1 Aug 2019
 16:28:55 +0000
From: Aleksandar Markovic <amarkovic@wavecomp.com>
To: =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>, Aleksandar
 Markovic <aleksandar.markovic@rt-rk.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Thread-Topic: [EXTERNAL]Re: [Qemu-devel] [PATCH for 4.2 v4 0/6] target/mips:
 Misc patches for 4.2
Thread-Index: AQHVSITFvs0seoQurkKy4e0cL6Tf86bmeTPF
Date: Thu, 1 Aug 2019 16:28:55 +0000
Message-ID: <BN6PR2201MB12516A775087FDF8F8E45920C6DE0@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <1564514832-29482-1-git-send-email-aleksandar.markovic@rt-rk.com>,
 <8f13328e-cc0a-5bd9-9a66-ca1b239b1099@redhat.com>
In-Reply-To: <8f13328e-cc0a-5bd9-9a66-ca1b239b1099@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=amarkovic@wavecomp.com; 
x-originating-ip: [82.117.201.26]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bace525a-85e8-4d3c-964d-08d7169d591c
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:BN6PR2201MB1058; 
x-ms-traffictypediagnostic: BN6PR2201MB1058:
x-microsoft-antispam-prvs: <BN6PR2201MB1058CC094D1F4FC3C2A31B81C6DE0@BN6PR2201MB1058.namprd22.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 01165471DB
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39840400004)(396003)(136003)(346002)(366004)(376002)(199004)(189003)(256004)(2501003)(2906002)(7736002)(71190400001)(71200400001)(110136005)(68736007)(26005)(305945005)(33656002)(54906003)(74316002)(91956017)(66574012)(6506007)(53546011)(486006)(76116006)(229853002)(66946007)(7696005)(64756008)(76176011)(66476007)(55236004)(99286004)(6436002)(66556008)(66446008)(14454004)(3846002)(476003)(53936002)(478600001)(5660300002)(316002)(446003)(86362001)(52536014)(25786009)(9686003)(8936002)(102836004)(11346002)(8676002)(81156014)(81166006)(66066001)(55016002)(6116002)(186003)(4326008)(6246003)(586874002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BN6PR2201MB1058;
 H:BN6PR2201MB1251.namprd22.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: UAmqupsooiwDXF8EGGC/NEcUzdKv2admDfsIiHyYf6estirfg1r+GpJACAttfVrfkw891rDEGAtNZK5q4GT7XIepGcCaXJeiRZl8K3pv81Q1o7/JG30Mg0nGiNsb7cga3v9TEJuTJ6PAG/9r0+zrKgelpV314CkIEe5U4M8CgEvuHJ6pOj5srM5bYo+vBdNqbpP+gAj3wJ+BWedIzjtz76VEbibc3aQcR0FlEJtNCLrmbDrrcINqF1osTA6+LdfPxk+59x5fLuBnE2Vz6NBaBkZJPV+vWzQKnEt9AZIPs77XuMSY70xxCqBvMuHgPbZJPmnQbarSOBbp8Tam/Phd/kqNdOEmfKQCIonpeV2tcjvYEjLQgGho3DgHVNOcO8O/u/3jHKlt20Zedy8X5cY7t8vclhVWXQfxk+2hfoA9iKI=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wavecomp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bace525a-85e8-4d3c-964d-08d7169d591c
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2019 16:28:55.6407 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: amarkovic@wavecomp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR2201MB1058
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.81.94
Subject: Re: [Qemu-devel] [EXTERNAL]Re: [PATCH for 4.2 v4 0/6] target/mips:
 Misc patches for 4.2
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
Cc: Aleksandar Rikalo <arikalo@wavecomp.com>, "sw@weilnetz.de" <sw@weilnetz.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

=0A=
=0A=
________________________________________=0A=
From: Philippe Mathieu-Daud=E9 <philmd@redhat.com>=0A=
Sent: Thursday, August 1, 2019 6:18 PM=0A=
To: Aleksandar Markovic; qemu-devel@nongnu.org=0A=
Cc: Aleksandar Rikalo; sw@weilnetz.de; Aleksandar Markovic=0A=
Subject: [EXTERNAL]Re: [Qemu-devel] [PATCH for 4.2 v4 0/6] target/mips: Mis=
c patches for 4.2=0A=
=0A=
Hi Aleksandar,=0A=
=0A=
On 7/30/19 9:27 PM, Aleksandar Markovic wrote:=0A=
> From: Aleksandar Markovic <amarkovic@wavecomp.com>=0A=
>=0A=
> This series includes misc MIPS patches intended to be integrated after=0A=
> 4.1 release.=0A=
> >=0A=
> > Yongbok Kim (4):=0A=
> >   target/mips: Add support for DSPRAM=0A=
> >   target/mips: Amend CP0 WatchHi register implementation=0A=
> >   target/mips: Implement Global Invalidate TLB instruction=0A=
> >   target/mips: Add emulation of CRC32 instructions=0A=
> =0A=
> I'm interested in reviewing Yongbok's work but I won't have time before=
=0A=
> next week.=0A=
=0A=
Pas de probl=E8me.=0A=
=0A=
I will anyway send new versions (with some, mostly minor, corrections) in=
=0A=
next few days.=0A=
=0A=
Unfortunately, there is still ample room for improvements. :(=0A=
=0A=
Yours,=0A=
Aleksandar=0A=
=0A=
> Regards,=0A=
> =0A=
> Phil.=0A=

