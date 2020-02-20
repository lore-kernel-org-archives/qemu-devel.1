Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC79EC11D14
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 17:31:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2D2B2467A
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 17:31:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="SLy5T073"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2D2B2467A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4pfc-0001XS-Qw
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 12:31:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41150)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <juterry@microsoft.com>) id 1j4pef-00016u-MW
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 12:30:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <juterry@microsoft.com>) id 1j4peb-0007L6-Qr
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 12:30:28 -0500
Received: from mail-dm6nam11on2134.outbound.protection.outlook.com
 ([40.107.223.134]:60001 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <juterry@microsoft.com>)
 id 1j4peb-0007KQ-Eo; Thu, 20 Feb 2020 12:30:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H/o0efGE2qA8sZn5UwfSrqfsqva7u1H60DJJH9uL28fmGBb52H+30tT/62bi/u3UyhWZfdTLGAJYedKaj2YQYYXo7M8fkbGwAtOrV5dUoJZkRiGBsfUUUY2FKrwBRaGfhuTx9il8ncnNMh5SFG85kyZ7SLTmJRAWhO4PheRN6trzkhBoL74EBFYJy8XuV+hk15ns29Ndrymwh5iwkTaB5EXu/O/7hG1SXjuENaKTdxp8Cir7kRotPrX1yENJ3mnOAOh8NAmR1djYTdOey0QjQOqIhyawWZq08lejGdqdpjH4X83gRHcobB79h1Sxg1zK0sBiuzHfQJhGCmNJITtnbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/H+XiFxtVKVi6mcA3j5F6siX42P6ZkUhLbMWPyWe8Lo=;
 b=kcDFsiaJh9M2QXSEkkV7H3rfks2scOuEkyGLicLR3UhngazTAOwBWgSDUF+UDnzgo0SpesBG8Sjtsxqw9LsMHBMGnGPOL5ltYGvTcYnXLuSm7MohJB6jPqmMWjwyI19oMql1HAcFLmY7yYfo8rb8zwG79QT/WDX4ub3PEeh8PQMLq2pSmNWVHBoTTM9TBHD+6NEch9vHGMb38AFT63efxjlezxBbCSpAH7qNIoBYVwYkx4ZiU8x5bqHIItm1wb0YHKVm0v++75/9/lecibp6Z2J9t3jNlZOfd4zk2aF7oYZToWcG4maZnOkCEslOaxdNQ7XjjmNpkR6xWYKRJRXF1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/H+XiFxtVKVi6mcA3j5F6siX42P6ZkUhLbMWPyWe8Lo=;
 b=SLy5T073yXYsUBT6pBAAW4d7kVvbOZcepYJmYydDdL9Vl6Bho3O6IwBjDT3+tA9WRUKDFZnI/P1lD5rYtI5osxYCHbRSPmIztR3HUFu/+24oRd5tXq34HlY3gUAgAuGHbCkDkIurEVdJHvW0K97GIlPnmA4GCFpb1CYIkbM0bn0=
Received: from BN8PR21MB1297.namprd21.prod.outlook.com (20.179.74.207) by
 BN8PR21MB1265.namprd21.prod.outlook.com (20.179.74.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.4; Thu, 20 Feb 2020 17:30:22 +0000
Received: from BN8PR21MB1297.namprd21.prod.outlook.com
 ([fe80::b03c:f27:72c7:8b9b]) by BN8PR21MB1297.namprd21.prod.outlook.com
 ([fe80::b03c:f27:72c7:8b9b%7]) with mapi id 15.20.2772.004; Thu, 20 Feb 2020
 17:30:22 +0000
From: "Justin Terry (SF)" <juterry@microsoft.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>, Sunil
 Muthuswamy <sunilmut@microsoft.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Max Reitz
 <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Thomas Huth
 <thuth@redhat.com>, Fam Zheng <fam@euphon.net>, Eduardo Habkost
 <ehabkost@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>, Richard Henderson <rth@twiddle.net>,
 Julia Suvorova <jusual@redhat.com>, Thomas Huth <huth@tuxfamily.org>, "Edgar
 E. Iglesias" <edgar.iglesias@gmail.com>, Aarushi Mehta
 <mehta.aaru20@gmail.com>, "qemu-trivial@nongnu.org"
 <qemu-trivial@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Alistair
 Francis <alistair@alistair23.me>, Gerd Hoffmann <kraxel@redhat.com>, Luc
 Michel <luc.michel@greensocs.com>, Laurent Vivier <lvivier@redhat.com>, Juan
 Quintela <quintela@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>, Laurent
 Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>, Yuval Shaia
 <yuval.shaia.ml@gmail.com>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: RE: [EXTERNAL] Re: [PATCH RESEND 11/13] target/i386/whpx: Remove
 superfluous semicolon
Thread-Topic: [EXTERNAL] Re: [PATCH RESEND 11/13] target/i386/whpx: Remove
 superfluous semicolon
Thread-Index: AQHV5kJPYeMUg9xD2U6kjYYIlU3R0KgkWeyQ
Date: Thu, 20 Feb 2020 17:30:22 +0000
Message-ID: <BN8PR21MB12975CD3759819BAEC6D106DB6130@BN8PR21MB1297.namprd21.prod.outlook.com>
References: <20200218094402.26625-1-philmd@redhat.com>
 <20200218094402.26625-12-philmd@redhat.com> <20200218100029.GN3080@work-vm>
In-Reply-To: <20200218100029.GN3080@work-vm>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=juterry@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-02-20T17:30:21.0165359Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=d12cbcb7-1b50-4bb7-8b77-955dd54347ba;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=juterry@microsoft.com; 
x-originating-ip: [67.185.128.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b6bb9039-7b5a-4f8a-778b-08d7b62a90a6
x-ms-traffictypediagnostic: BN8PR21MB1265:|BN8PR21MB1265:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN8PR21MB12651F137C4B758D71FC6FEFB6130@BN8PR21MB1265.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:139;
x-forefront-prvs: 031996B7EF
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(346002)(39860400002)(366004)(136003)(396003)(376002)(199004)(189003)(110136005)(7696005)(478600001)(316002)(9686003)(55016002)(33656002)(2906002)(8936002)(81166006)(81156014)(10290500003)(8676002)(4326008)(66476007)(52536014)(5660300002)(66446008)(6636002)(86362001)(8990500004)(7416002)(186003)(26005)(71200400001)(6506007)(53546011)(64756008)(54906003)(66946007)(66556008)(76116006);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BN8PR21MB1265;
 H:BN8PR21MB1297.namprd21.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Gmt7BNfX05hzuLHGF4proO8Uva3fJMN7cHv6mpsZbCx0F50BkShvHMch5p/M1bYfcDOlYueo1/iQxghcHHsedrk+nnWK71x8oEQd+SRlN9GiYY5qfcDWvDCYvOw+eqp11WFM2m/nPKpv6rBBUtDIbACi6s92qrLUXWuQMQ5dyy/2tTX2eCOalGlmb04eWJgIWDcLGPrAbTfcewgBQzxjbmXqTfA9hfjQsNqY9qmp3sZPSmBm5NS4AloXk597+jCVw5U0eSKNO3x2QRhR1nsBLRptD338X/8HY6akJXbbbHtUJLc2Bn0RWrm0f5MLvFmJreRsaRJBWagQjGWALDoBlbVTw0lfNc3HGWd5KHWiSY/zThtYi9XrOZqqaP8IUx5dU4GJ2h5t8QH1++g+YEJiH5JATm8Rr/Osvb51EXVVb2Wm/VM8qDvcVfJhnk9/Oxjm
x-ms-exchange-antispam-messagedata: p/uvQ37W3KAJwJWaReveOlTxhBhB0nYuj1EzpPR7myk5pg8skiRr3kD3Pp+B9xCoNqq/449dgQEeWmARsBoU4JgRDLSdu/1HHrIlqZgbUvW9OTjIUyDQJM3wPsstVNNBeirzf3GTAS+xo925liHADw==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6bb9039-7b5a-4f8a-778b-08d7b62a90a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2020 17:30:22.5466 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: acmujX9qQ5u1h6ziFBi9N9cwVAnVzQ4lur+3wox6qyZ1rPBa+bs8KMrYwGYzzX6plaUMNhUMY5cJAMN4XdZi8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR21MB1265
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.223.134
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

+Sunil Muthuswamy <sunilmut@microsoft.com>

LGTM. Thanks!

Reviewed-by: Justin Terry (VM) <juterry@microsoft.com>

> -----Original Message-----
> From: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Sent: Tuesday, February 18, 2020 2:00 AM
> To: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> Cc: qemu-devel@nongnu.org; Max Reitz <mreitz@redhat.com>; Kevin Wolf
> <kwolf@redhat.com>; Thomas Huth <thuth@redhat.com>; Fam Zheng
> <fam@euphon.net>; Eduardo Habkost <ehabkost@redhat.com>; Alex
> Williamson <alex.williamson@redhat.com>; Marcel Apfelbaum
> <marcel.apfelbaum@gmail.com>; Richard Henderson <rth@twiddle.net>;
> Julia Suvorova <jusual@redhat.com>; Thomas Huth <huth@tuxfamily.org>;
> Edgar E. Iglesias <edgar.iglesias@gmail.com>; Aarushi Mehta
> <mehta.aaru20@gmail.com>; qemu-trivial@nongnu.org; Stefan Hajnoczi
> <stefanha@redhat.com>; Alistair Francis <alistair@alistair23.me>; Gerd
> Hoffmann <kraxel@redhat.com>; Luc Michel <luc.michel@greensocs.com>;
> Laurent Vivier <lvivier@redhat.com>; Juan Quintela
> <quintela@redhat.com>; Michael Tokarev <mjt@tls.msk.ru>; Laurent Vivier
> <laurent@vivier.eu>; Paolo Bonzini <pbonzini@redhat.com>; Yuval Shaia
> <yuval.shaia.ml@gmail.com>; qemu-arm@nongnu.org; Peter Maydell
> <peter.maydell@linaro.org>; qemu-block@nongnu.org; Justin Terry (SF)
> <juterry@microsoft.com>
> Subject: [EXTERNAL] Re: [PATCH RESEND 11/13] target/i386/whpx: Remove
> superfluous semicolon
>=20
> * Philippe Mathieu-Daud=E9 (philmd@redhat.com) wrote:
> > Fixes: 812d49f2a3e
> > Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
>=20
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>=20
> > ---
> > Cc: Justin Terry (VM) <juterry@microsoft.com>
> > ---
> >  target/i386/whpx-all.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/target/i386/whpx-all.c b/target/i386/whpx-all.c index
> > 3ed2aa1892..35601b8176 100644
> > --- a/target/i386/whpx-all.c
> > +++ b/target/i386/whpx-all.c
> > @@ -511,7 +511,7 @@ static void whpx_get_registers(CPUState *cpu)
> >      /* WHvX64RegisterPat - Skipped */
> >
> >      assert(whpx_register_names[idx] =3D=3D WHvX64RegisterSysenterCs);
> > -    env->sysenter_cs =3D vcxt.values[idx++].Reg64;;
> > +    env->sysenter_cs =3D vcxt.values[idx++].Reg64;
> >      assert(whpx_register_names[idx] =3D=3D WHvX64RegisterSysenterEip);
> >      env->sysenter_eip =3D vcxt.values[idx++].Reg64;
> >      assert(whpx_register_names[idx] =3D=3D WHvX64RegisterSysenterEsp);
> > --
> > 2.21.1
> >
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


