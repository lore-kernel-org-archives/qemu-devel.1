Return-Path: <SRS0=NHD5=ZG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D02ABC43141
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 12:35:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EB2820709
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 12:35:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavecomp.com header.i=@wavecomp.com header.b="LaLDx5uE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EB2820709
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wavecomp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVELd-0005os-Nq
	for qemu-devel@archiver.kernel.org; Thu, 14 Nov 2019 07:35:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49699)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <amarkovic@wavecomp.com>) id 1iVEK8-000450-77
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 07:34:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <amarkovic@wavecomp.com>) id 1iVEK4-0008Af-Oi
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 07:34:07 -0500
Received: from mail-eopbgr800123.outbound.protection.outlook.com
 ([40.107.80.123]:60840 helo=NAM03-DM3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
 id 1iVEK2-00087j-H4
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 07:34:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MQILEE6eAOXJgXvljbad4zI/DUWirzBpFqFfB6h1hLftP1oGn5B/iJZ2qW3RUqxEMKEBTCPYfGDH1S5RPJ/gAwMCrMYlZN4Kwnxg/GW0g/xR/oT2OsAw0BheqUu0YG2PfDlKu309N7z0JFEO9r6TMBV3ulu+69/s/1/d8rusIyTvOhXeCPHEDbsIg+Cg9PBYTTUNJ4ffN5i1ejRezInhOpxStu9t6gXexU7ZNZpKvUUhgAl9DeUB4C3X/oQJYxRwR3uFXWlEu17ZTC3/Ih4gAlD4Hdxbo41JYDQZUWIp+kSmmQwLEW8HVZ4boOuIjDjfwNWDTzGM4pYh5mZUYThC6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ykEm5qyJK/WFl7VLafPEaOpi2aXWgo7Y/G1GFVqnBs=;
 b=eaiswVR/lIAHkiLPYT2HT9HxStYB4AxPnTSay3Nkmjd3qu+8UqzqNO6nfwk0VS9TfpA5fyIyEHN4VMs71kgrLMZ9UEtCQ1eEOoW5Wz34bn84tzuvO+K7Y/TNTJEgldCtgEQYH6cl39zv0Ns1pWkLvCrT7tZdZsF+UXvitfW3Iz8LVh9zRt1C1krScnRy4WEFlUY4IXVfiXA7xMSOTmSc2jl6HSdjWinNFr+zohb+R/QrM/I/AAHgmVEe9TcFDizgs8YvEvt7oYJy/Q2xr0KwWBCXTPTXcv43I3MkeCGXWR0LvSDhGMESsScl5dx6SbN4LuAZ6fPFmhzvCMEHhbzEFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wavecomp.com; dmarc=pass action=none header.from=wavecomp.com;
 dkim=pass header.d=wavecomp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wavecomp.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ykEm5qyJK/WFl7VLafPEaOpi2aXWgo7Y/G1GFVqnBs=;
 b=LaLDx5uEXbJeCmI/vpYN6TGhzGXLFeYnaS6I5KjHe3VmgX6F91Zl1SbdgCW1XcqB4fqWN1URQe49CdtkYCApXdtvtvKoVsApJvCp7LcfbAsXhsT+zIEXBUuOIfBc65jm7F+DfUMHfpQc+G8V+j6LeZ/QJWGzkCglnBTmFYu3iv0=
Received: from BN6PR2201MB1251.namprd22.prod.outlook.com (10.174.81.139) by
 BN6PR2201MB1508.namprd22.prod.outlook.com (10.174.85.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.26; Thu, 14 Nov 2019 12:33:57 +0000
Received: from BN6PR2201MB1251.namprd22.prod.outlook.com
 ([fe80::302a:6e1a:7c8e:867]) by BN6PR2201MB1251.namprd22.prod.outlook.com
 ([fe80::302a:6e1a:7c8e:867%11]) with mapi id 15.20.2430.027; Thu, 14 Nov 2019
 12:33:57 +0000
From: Aleksandar Markovic <amarkovic@wavecomp.com>
To: =?windows-1256?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>,
 Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, Huacai Chen <chenhc@lemote.com>, Huacai Chen
 <zltjiangshi@gmail.com>
Subject: Re: [EXTERNAL]Re: [PATCH v2 2/5] MAINTAINERS: Adjust maintainership
 for Fulong 2E board
Thread-Topic: [EXTERNAL]Re: [PATCH v2 2/5] MAINTAINERS: Adjust maintainership
 for Fulong 2E board
Thread-Index: AQHVmuGOIzx1v7lzjk6+/PRRo+xr1aeKlvkQ
Date: Thu, 14 Nov 2019 12:33:57 +0000
Message-ID: <BN6PR2201MB12512B977314BCFCA202449DC6710@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <1573652826-23987-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1573652826-23987-3-git-send-email-aleksandar.markovic@rt-rk.com>,
 <c053c16c-c6f4-4f73-7383-7b66e54ad696@redhat.com>
In-Reply-To: <c053c16c-c6f4-4f73-7383-7b66e54ad696@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=amarkovic@wavecomp.com; 
x-originating-ip: [82.117.201.26]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e794155e-7a6a-47de-1696-08d768feeb7d
x-ms-traffictypediagnostic: BN6PR2201MB1508:
x-microsoft-antispam-prvs: <BN6PR2201MB1508D43D326DE8A6FEDADBC9C6710@BN6PR2201MB1508.namprd22.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 02213C82F8
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(346002)(366004)(39840400004)(136003)(396003)(199004)(189003)(53546011)(229853002)(4326008)(5660300002)(7696005)(6506007)(52536014)(26005)(71190400001)(71200400001)(76176011)(446003)(316002)(76116006)(91956017)(66946007)(102836004)(9686003)(55016002)(478600001)(25786009)(186003)(6246003)(6436002)(55236004)(256004)(2501003)(66476007)(66446008)(66556008)(64756008)(86362001)(305945005)(7736002)(74316002)(486006)(33656002)(6116002)(3846002)(81156014)(54906003)(99286004)(476003)(14454004)(11346002)(81166006)(8936002)(110136005)(8676002)(2906002)(66066001)(498294003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BN6PR2201MB1508;
 H:BN6PR2201MB1251.namprd22.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EEqVF8XfbnwHGUMGt8EfFUV8RVFInbw4/buSuqic8rABEs2igfo3P/kYEKw0zCljlzq9vJQU8d6AUHIL9t6Gj/DXfaP3jPqvwQTmmwEGdeBXSw1fhOraI5X/2WVQ0zwHoemBj6M/QhACiPswoDS7E16v254+kkQNFyNKGSKxcpsaTj8XyWAYVfclV1AFTV6P/xnK5MIJGlJNDKVmN3CXBLMUOH+hDlhD5KzSJ5Atg74SvVxgxJXgxO/tB0kW9JvagfSy5Dqt9tuoNTxiZEwNvmzad86+qzgadUhz8FDsK4111xgIoMg6hLrpXAMLazy0JkTB21XuqTi9F4JCdi0eaQW84Jzm0wT8NIng64XzYf0nGcfWO8zyO/dSgd335XwRXqdyKBHZbLC000ENvzWwSUCcfHFV1xBIKRKK3v0kOidiucp497mhz4q2HDiPPCdA
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="windows-1256"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wavecomp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e794155e-7a6a-47de-1696-08d768feeb7d
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2019 12:33:57.6940 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iTwWrJwew3yLFYEfKPxem4oBIEVTyGABtaPx5GfwdGNybWGQ4yxzLT4LCrWH7uY6oAiUsQ0W2y1j+Hvbzl4o8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR2201MB1508
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.80.123
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
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "aleksandar.rikalo@rt-rk.com" <aleksandar.rikalo@rt-rk.com>,
 "hpoussin@reactos.org" <hpoussin@reactos.org>,
 "aurelien@aurel32.net" <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi, Philippe,=0A=
=0A=
> From: Philippe Mathieu-Daud=E9 <philmd@redhat.com>=0A=
> =0A=
> Hi Aleksandar,=0A=
> =0A=
> On 11/13/19 2:47 PM, Aleksandar Markovic wrote:=0A=
> > From: Aleksandar Markovic <amarkovic@wavecomp.com>=0A=
> >=0A=
> > Change the maintainership for Fulong 2E board to improve its quality.=
=0A=
> =0A=
> IIRC you told me once this board is named Fuloong, and its CPU is a=0A=
=FD> Loongson, both with 2x 'o' :) I have a patch renaming the various=0A=
> occurrences.=0A=
> =0A=
=0A=
I still think that the oficial name is "Fuloong 2E", however, it is=0A=
shortened to "Fulong 2E" quite often in communication, and, it seems,=0A=
sometimes even in various docs/app notes etc.=0A=
=0A=
Can perhaps Huacai Chen enlighten us regarding the right spelling?=0A=
=0A=
> > Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>=0A=
> > ---=0A=
> >   MAINTAINERS | 7 ++++---=0A=
> >   1 file changed, 4 insertions(+), 3 deletions(-)=0A=
> >=0A=
> > diff --git a/MAINTAINERS b/MAINTAINERS=0A=
> > index fd9ba32..3bf2144 100644=0A=
> > --- a/MAINTAINERS=0A=
> > +++ b/MAINTAINERS=0A=
> > @@ -976,9 +976,10 @@ S: Maintained=0A=
> >   F: hw/mips/mips_r4k.c=0A=
> >=0A=
> >   Fulong 2E=0A=
> > -M: Aleksandar Markovic <amarkovic@wavecomp.com>=0A=
> > -R: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>=0A=
> > -S: Odd Fixes=0A=
> > +M: Philippe Mathieu-Daud=E9 <philmd@redhat.com>=0A=
> =0A=
> I am happy to keep the Fuloong working, but this will be on my personal=
=0A=
> (hobbyist) time. This area is not a priority for my employer, so I'll=0A=
> use my personal email: f4bug@amsat.org.=0A=
> =0A=
=0A=
OK.=0A=
=0A=
> The original author is active on the Linux kernel, let ask him if he'd=0A=
> be OK to keep an eye on his work.=0A=
> =0A=
> Huacai, would you agree to be listed as a reviewer on the Fuloong=0A=
> related QEMU files? You don't have to worry about the generic QEMU code=
=0A=
> plate (like keeping API up to date) I'll manage that, but I'd like to=0A=
> have you listed to assert the hardware is properly modeled.=0A=
> =0A=
> You would appear as:=0A=
> R: Huacai Chen <chenhc@lemote.com>=0A=
> =0A=
=0A=
That is a great idea!=0A=
=0A=
Please, Chen, get involved, you would be very welcomed, there is a place=0A=
for you in QEMU community!=0A=
=0A=
=0A=
> > +R: Herv=E9 Poussineau <hpoussin@reactos.org>=0A=
> =0A=
> I don't think Herv=E9 is interested by this board, he has not modified th=
e=0A=
> code.=0A=
> =0A=
> > +R: Aleksandar Markovic <amarkovic@wavecomp.com>=0A=
> > +S: Maintained=0A=
> =0A=
> Let keep it as "Odd Fixes" :)=0A=
> =0A=
=0A=
OK.=0A=
=0A=
>    Odd Fixes:   It has a maintainer but they don't have=0A=
>                 time to do much other than throw the odd=0A=
>                 patch in.=0A=
> =0A=
> >   F: hw/mips/mips_fulong2e.c=0A=
> >   F: hw/isa/vt82c686.c=0A=
> >   F: hw/pci-host/bonito.c=0A=
> >=0A=
> =0A=
> So the patch would be:=0A=
> =0A=
> -- 8< --=0A=
>   Fulong 2E=0A=
> -M: Aleksandar Markovic <amarkovic@wavecomp.com>=0A=
> -R: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>=0A=
> +M: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>=0A=
> +R: Aleksandar Markovic <amarkovic@wavecomp.com>=0A=
> +R: Huacai Chen <chenhc@lemote.com>=0A=
>   S: Odd Fixes=0A=
>   F: hw/mips/mips_fulong2e.c=0A=
>   F: hw/isa/vt82c686.c=0A=
=0A=
Plus possible s/Fulong 2E/Fuloong 2E/=0A=
=0A=
> ---=0A=
> =0A=
> But let's wait to see what Huacai Chen thinks of it, before posting it.=
=0A=
> =0A=
> Thanks for taking care of those changes!=0A=
> =0A=
> Phil.=0A=
> =0A=
> =0A=
=0A=
Thank you!=0A=
=0A=
Aleksandar=

