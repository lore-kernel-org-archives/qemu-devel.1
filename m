Return-Path: <SRS0=mi2X=WI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1AB3C31E40
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 15:38:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFC1A20679
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 15:38:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="ZtV2EpEP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFC1A20679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46636 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxCOZ-0006vx-2z
	for qemu-devel@archiver.kernel.org; Mon, 12 Aug 2019 11:38:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45918)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aaron@os.amperecomputing.com>) id 1hxCNs-0006MX-Fo
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 11:37:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aaron@os.amperecomputing.com>) id 1hxCNr-0007D4-29
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 11:37:20 -0400
Received: from mail-eopbgr730129.outbound.protection.outlook.com
 ([40.107.73.129]:16016 helo=NAM05-DM3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aaron@os.amperecomputing.com>)
 id 1hxCNm-0007Ah-44; Mon, 12 Aug 2019 11:37:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gwwxrpiMYxziRMbuiu/oOt7OJjHUd+hQAbUoHlD28xZZdDZ9CCdkRH+LW/L3TOMyiVjTqDa8747DTa2BM4WvBF9s1dIogWdelYPBAZBXwfrcRttov7Rr4V2XB40bf6d3pfnnQgAhadx5+y9NkeJQYLxHQrXqNr4BneSEL1i3pEVEEoC27c3BVv/auOjFsWO8wHb3Fa1Vm3pskpKlVkadOXPMRZej9ZSb+68fUQGGwqBaGFfZk7wq7Xh7JF7tL75OQvzsix6Id6BaWEXJyjQp9DSuFUJfZhvPKKEzJkZ4EiQ975PtRzFvUtyqJ8doQiT+iP7CC00nCTfdGW5TDF/VUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nS9UJDpirTTMgw9hAyYl+ARumctOorqJTcoJ0lc7eU0=;
 b=klfDSaJwhlVkO9SkjNJzupYqHEySVhVnKHwnBV7kxiK3II3+xqit39FLGOze1KFBv+0jPSJtq5NWiHGiN3DrEAWU2zC1vZ5tl1so480MhtIIY0HaqIr5lsaJBFrxASXBGLe7A7hxUf9YNKU5IyPQ0gcpa+raA8g2ded7+vfY2DCRVyyt8szggM8XCiwRenw5ub33goWNTzkoMOZvv5fVSsHRh+C/MNEIx16ISF5jYnBgZghydwuuV6H1++l1a7a0E3bBVY/vN6b20u4JzRMaI4ZTWoEKw3e504x3pSxf/uyORdWfMZn7LktiWlN7WxWf4rRygfzACv1QrpqIcdiyqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nS9UJDpirTTMgw9hAyYl+ARumctOorqJTcoJ0lc7eU0=;
 b=ZtV2EpEPPIb3z6oulyI4V5OQvSOtxMdFFAaKYvy+bRay8VdLZCgIgKFsZVjs6gyFpYyx1JZGWegUVZhuIKreIwDUWudReZMTt3tkrgxMnXzZlsIfIUWZOP5rOBTpaK+cxRc3SJr/0cFZSfNTPYZ9hu6l+x43oko1SYNIF5qBYYE=
Received: from DM6PR01MB4825.prod.exchangelabs.com (20.177.218.222) by
 DM6PR01MB3737.prod.exchangelabs.com (20.176.67.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.21; Mon, 12 Aug 2019 15:37:11 +0000
Received: from DM6PR01MB4825.prod.exchangelabs.com
 ([fe80::4943:2b46:af24:e807]) by DM6PR01MB4825.prod.exchangelabs.com
 ([fe80::4943:2b46:af24:e807%7]) with mapi id 15.20.2157.020; Mon, 12 Aug 2019
 15:37:11 +0000
To: Peter Maydell <peter.maydell@linaro.org>
Thread-Topic: [Qemu-arm] [PATCH] elf: Allow loading AArch64 ELF files
Thread-Index: AQHVURy4yDbUMFtoS0GmsVnUb69OAqb3m9CAgAAJkAA=
Date: Mon, 12 Aug 2019 15:37:11 +0000
Message-ID: <20190812153708.GB9200@quinoa.localdomain>
References: <20190812144442.30027-1-aaron@os.amperecomputing.com>
 <CAFEAcA-GnPAL41MQouLxs_7y9Xj_E30k4Agx20eWObau2p02AA@mail.gmail.com>
In-Reply-To: <CAFEAcA-GnPAL41MQouLxs_7y9Xj_E30k4Agx20eWObau2p02AA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CY4PR03CA0023.namprd03.prod.outlook.com
 (2603:10b6:903:33::33) To DM6PR01MB4825.prod.exchangelabs.com
 (2603:10b6:5:6b::30)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aaron@os.amperecomputing.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [108.169.132.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: aef91c47-f670-4c26-3992-08d71f3af16f
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DM6PR01MB3737; 
x-ms-traffictypediagnostic: DM6PR01MB3737:
x-microsoft-antispam-prvs: <DM6PR01MB3737222555CE7416D69474108AD30@DM6PR01MB3737.prod.exchangelabs.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 012792EC17
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(136003)(366004)(39840400004)(346002)(396003)(376002)(189003)(199004)(31014005)(52314003)(54906003)(14454004)(6916009)(478600001)(33656002)(99286004)(316002)(6436002)(6486002)(229853002)(6512007)(9686003)(8936002)(486006)(11346002)(446003)(66556008)(66476007)(66946007)(64756008)(476003)(76176011)(52116002)(66446008)(102836004)(256004)(14444005)(6506007)(386003)(26005)(186003)(66066001)(81156014)(305945005)(81166006)(71200400001)(71190400001)(8676002)(5660300002)(7736002)(53936002)(25786009)(86362001)(4326008)(3846002)(2906002)(6116002)(1076003)(6246003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DM6PR01MB3737;
 H:DM6PR01MB4825.prod.exchangelabs.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:0; 
received-spf: None (protection.outlook.com: os.amperecomputing.com does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: UHv8pYbHe/GU8/CsyNxrvPJGYJrng+re6NIQ9TRE6SPDIC7QGrRzkgI8xPs17qzsxNevgM9vzp4vmVyRL5nrg95UlCu0ccUYLgvuoqlROF3CoW8KhJ2/odjSGi/nM1cpAv135Cyu1U47uPp9pXeYuXSKW9mvgNwhWPfBtEGfXURgtJqqNKdthNYhAf/eB1NTbK5+U2LLYgUEgRTTqflbLxz3c6/8e/JCpzbMH91cQtKVG+7TgvE/xK3NF1SXiVMRYUUaEwVJHB/31JB0uMO0djAom8RDlj0fEM1Yaqi4HgcJWA8DIIWpt44xe4N036zrV8scgw/Os/VV/LFNx9JEtN3n/FEgKtulaSLvYzwaDhNknp7lOhSSKO0xPcJRKR9bye5rJJVlTj2SUxzYLDcGyQ42sfSw91DjYa34KBZ9Kto=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4C61CF139CA4B3409EDC75EF9F370C48@prod.exchangelabs.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aef91c47-f670-4c26-3992-08d71f3af16f
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2019 15:37:11.6944 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DfV3okvnnVWgQTGxQG0ow5wXY53QA1/s4Xr4lQnuapX+lla1BvBagRP722lBYFCyNJty/OUurGO7PvFz5iuJUtfy7/drcSc+37o/UJrcxuw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR01MB3737
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.73.129
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH] elf: Allow loading AArch64 ELF
 files
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
From: Aaron Lindsay OS via Qemu-devel <qemu-devel@nongnu.org>
Reply-To: Aaron Lindsay OS <aaron@os.amperecomputing.com>
Cc: Peter Crosthwaite <crosthwaitepeter@gmail.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Alistair Francis <alistair.francis@xilinx.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Aug 12 16:02, Peter Maydell wrote:
> On Mon, 12 Aug 2019 at 15:46, Aaron Lindsay OS via Qemu-arm
> <qemu-arm@nongnu.org> wrote:
> >
> > Treat EM_AARCH64 as a valid value when checking the ELF's machine-type
> > header.
> >
> > Signed-off-by: Aaron Lindsay <aaron@os.amperecomputing.com>
> > ---
> >  include/hw/elf_ops.h | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/include/hw/elf_ops.h b/include/hw/elf_ops.h
> > index 690f9238c8..f12faa90a1 100644
> > --- a/include/hw/elf_ops.h
> > +++ b/include/hw/elf_ops.h
> > @@ -381,6 +381,12 @@ static int glue(load_elf, SZ)(const char *name, in=
t fd,
> >                  goto fail;
> >              }
> >              break;
> > +        case EM_AARCH64:
> > +            if (ehdr.e_machine !=3D EM_AARCH64) {
> > +                ret =3D ELF_LOAD_WRONG_ARCH;
> > +                goto fail;
> > +            }
> > +            break;
> >          default:
> >              if (elf_machine !=3D ehdr.e_machine) {
> >                  ret =3D ELF_LOAD_WRONG_ARCH;
> > --
> > 2.17.1
>=20
> What problem are we trying to solve here ? If I'm reading your patch
> correctly then it makes no difference to execution, because we're
> switching on 'elf_machine', and so this extra case is saying
> "if elf_machine is EM_AARCH64, insist that ehdr.e_machine
> is also EM_AARCH64", which is exactly what the default
> case would do anyway. The only reason to add extra cases in
> this switch is to handle the situation where a target's board/loader
> code says "I can handle elf files of type X" but actually this
> implicitly means it can handle both X and Y (so for EM_X86_64 we
> need to accept both EM_X86_64 and EM_386, for EM_PPC64 we need to
> accept both EM_PPC64 and EM_PPC, and so on). We don't have a
> case like that for aarch64/arm because the boot loader code has
> to deal with the 32 bit and 64 bit code separately anyway, so
> we can pass in the correct value depending on whether the CPU
> is 32-bit or 64-bit.
>=20
> The code in hw/arm/boot.c passes in an elf_machine value of
> EM_AARCH64 when it wants to load an AArch64 ELF file, so
> for that the default case is OK. The code in hw/core/generic-loader.c
> passes in 0 (EM_NONE) which will be handled by the check just
> before this switch statement, so the default case should
> work there too. Presumably there's some other code path
> for ELF file loading that doesn't work that you're trying to fix?

Please disregard this patch.

I'm sorry, upon closer inspection you are obviously correct... and I
have no earthly idea what happened here. I hit the "goto fail" in the
"default" case when debugging why I couldn't load an ELF on AArch64 last
week. I was in a hurry and saw that there were other architectures in
the switch/case and threw this code in there quickly without much
thought, and after re-compiling, it worked!

...But after your email this morning, I'm completely unable to reproduce
the failure case. I must have had another local issue which was
coincidentally resolved at the same time, unbeknownst to me.

-Aaron

