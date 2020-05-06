Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E535C28CBC
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 10:41:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2936C20663
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 10:41:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="h9rXR0ue"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2936C20663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45700 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWHUE-000882-A4
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 06:41:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36452)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1jWHTZ-0007bD-Vn; Wed, 06 May 2020 06:40:30 -0400
Received: from mail-eopbgr680082.outbound.protection.outlook.com
 ([40.107.68.82]:6921 helo=NAM04-BN3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1jWHTW-0007oa-DJ; Wed, 06 May 2020 06:40:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VkVzlNUQ+SVHRJkKvFHWB3T1BPvmM9jI38L0FSjG5anZVi1cSC5+vJ1soXYRlXst0m4V2QE1Xv1szreAeSVNyoRuB+5E6zfPnp7zyuCS9yvNs7RQGne4MMjK9e5T2zxJKy8m08CoPCd6Rkw601CADeckf8czcAYwwht0xLhDcfU7Wp4DJD4N6TBI4QGPqfT49lxe90h2APLoFqGkctktyHKOl1phS91AZa2cmp0jMNVxeNKjXRRrcPHZiWufJ0uWn3aGgkAw034dKmSXZtk9eqNjuy1MEjITRqr8caiombdY8tJTk6ldyegK4yUFKMNZSqNZemc3bk4lPDHgZR6e7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J8BmKc/HG/LDliF76kquHHed1r8J0BvOIKg0e8WQ7t8=;
 b=UU7ShmoJ61w6PKCxTSb9OeF/yqBu+cbr+9EtzpD7REkWZxobP/xMuwzRm+cv0j6uY6BG0TQ91LktnklQQb4ha2FZX7VEjSCPXaDvDomHGVcl86X9jpQtkJCphDcs+9IXCV52uqwZSW4Q7e6pfM4gjpP2EYpgbFkxqevD8I/WK1CVECVqSE/mkHv7VOLy/5MzFfkxLSp4eIoFsbzTzYuXUnYi8K2Aed/bfkpnYf0iBS5h2NGfccd5G5teYkQ9MQRsnwmqU4vLi9ZWapZ6SH+YrnysbfhfrF4Xd31aLRe2Kd/iBlhIMNuNL5QPGE8/LHe60cihoeDSAk3A4k3rkZdtmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J8BmKc/HG/LDliF76kquHHed1r8J0BvOIKg0e8WQ7t8=;
 b=h9rXR0ueF1LLE5bi3WPqKJH9IiXqjtx4wUTZZ6LRr+qqj9OG/xWrG7mSKsE1a1fFBv7mw6C38KhwU24YWECINvVKwVpUhDsBsSrbBS7cFAIqFa8w3hT5E2Rdufnz2cBNcysrdkemopSLsAJFZPxQXv2LprfO2SSP5pC6oXOJJRU=
Received: from BY5PR02MB6772.namprd02.prod.outlook.com (2603:10b6:a03:206::11)
 by BY5PR02MB6017.namprd02.prod.outlook.com (2603:10b6:a03:1f5::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20; Wed, 6 May
 2020 10:40:22 +0000
Received: from BY5PR02MB6772.namprd02.prod.outlook.com
 ([fe80::9165:a37e:f249:48f6]) by BY5PR02MB6772.namprd02.prod.outlook.com
 ([fe80::9165:a37e:f249:48f6%9]) with mapi id 15.20.2979.028; Wed, 6 May 2020
 10:40:22 +0000
From: Sai Pavan Boddu <saipava@xilinx.com>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Subject: RE: [PATCH v2 04/10] net: cadence_gem: Define access permission for
 interrupt registers
Thread-Topic: [PATCH v2 04/10] net: cadence_gem: Define access permission for
 interrupt registers
Thread-Index: AQHWIiRM5nM2lanWykCZb+AnZJCBAaia4RYA
Date: Wed, 6 May 2020 10:40:22 +0000
Message-ID: <BY5PR02MB6772FC19BB5B6E832B9661C8CAA40@BY5PR02MB6772.namprd02.prod.outlook.com>
References: <1588601168-27576-1-git-send-email-sai.pavan.boddu@xilinx.com>
 <1588601168-27576-5-git-send-email-sai.pavan.boddu@xilinx.com>
 <20200504145710.GD5519@toto>
In-Reply-To: <20200504145710.GD5519@toto>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=xilinx.com;
x-originating-ip: [149.199.50.128]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b0de31eb-8afe-4911-5a9e-08d7f1a9e13d
x-ms-traffictypediagnostic: BY5PR02MB6017:|BY5PR02MB6017:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR02MB60173704C5FB634DB08B0229CAA40@BY5PR02MB6017.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:590;
x-forefront-prvs: 03950F25EC
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: A0re2W1Zt4j9izbaHwecLgc8arAgVVLotDy8RXbk4eNDaoBV66aYUeQUxNCLpB8uY7qEDbz47/bty+bpd+B3Gteo3ekL5HUkeGol0G4Wtz70pCdjceIupZhlN4yL1j6S/h7jE4pEaGdJI51ln3qGLZwDHk4xfq8lDWQAOfkAWbeL3LabW2WekF6DIWXbLYPcc75afomMEghEUlWBAtgOCCyi+K7MU9i441xBONv6YR1Gkg9XyykKgBawjbKawRIma/8hG+ELt5d2Wh82Pf+szRISzOOxmOl2zeBTVuP+e9SpI3ldOXvS5oUSuw1in3TlN053PSc80SWRLWPvKezuzZdW7faficzTZYTGNT6RgnBXBNNJdxz63sM/HDdSO38B6u3Ev75lgZlRhPQb8MN3V/bmXBAjZ40hlKzYUID+qT1bfFCqmHWNeMGaKiAwEXP7jbw67rCauaZfiRkVKD539bu6IJAwzEnhRNM10uQ4FbaFWvY7cipsXe2hhJgHK5T31nF0gO5sMnF7vm3V29MH1g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR02MB6772.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(136003)(376002)(346002)(396003)(39860400002)(366004)(33430700001)(52536014)(478600001)(66476007)(66946007)(66446008)(66556008)(64756008)(186003)(26005)(5660300002)(7696005)(6916009)(53546011)(4326008)(6506007)(316002)(9686003)(55016002)(2906002)(33656002)(71200400001)(8936002)(54906003)(8676002)(33440700001)(86362001)(76116006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: Z3UIqzXP1ckzHWtrGgamIbwEquViRqCwVTXa3TYSzfr9mEQA4IdRfHkEWli0/dL8H/bKAkL/VbV8YNl67do0QxHCJbjVRrC6IxdGgUkFrTOvPnVkE8ElyoOCJozI0Ir2zmpSehMWHepbfbvb1APBUvLtweGqeQB5bm//JU06oEV9eameRWmE6cxvS9/4UXMV3Lb39N5PF55I/MeZSMuKjpNNTDCyZ7cSP0OkO3H7LM4VtyoPvWzXqzAyHW5QHosqX4/n0bFM4Nbgo4pSVO3ONrTnPhmmk01Vol0yzfa9QJBg478hUJmKL/wSIDSwFkimEcnvD7f7oi+gQ7SpUZafJ+05BMZ/imnLINkWf9kIL5HmFeEjB8JIZPUh0PqJWPB9tXcde64Swk1wDrx+VLSzzG1SEN6QS2E+qUX3rPqg0d0uGulGbHX7zXEw2v6nnZm1FdQrgObujB34X3xPN4qLF/l/5dohlgPhsppWKkwMhcgivy4TqQhgg/LxtHl5cZq30lBpgtodmaFZM0Qzv0o3dk9V6gRfIh+zUW7HtqlWeapWZQdz51isn1bcMgr9+x94npvyNgFjTjt8aN3VxtzE7nKl3QKF0n9I8sRCQ4Vf5b1qCh+kANjWNyyc6MVRI/u+voIrhGPM/an8G1NH/t4oWYWZQbd7LgoqrIGf8yPW9W3e416rt3cVaF405ulqOnQ3uJpBTQw6GmndMgWnZT1lBfWm2q1qLq/4sR4V7ucGW0rIRTWWdoLFT3fIGM5gaX9dAFRicyV2/sp/zkSmx4zy2W5Zl46xcgFNFBMEuWAr2JE=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0de31eb-8afe-4911-5a9e-08d7f1a9e13d
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2020 10:40:22.5123 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YN955DgYdfCKcDPkvvHMjMgrXwWWMvRonf9FH3+XFjr/Ruj5V/p042NPI3m1b2AqhaUWRphh3yGmLaj2HkZU6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6017
Received-SPF: pass client-ip=40.107.68.82; envelope-from=saipava@xilinx.com;
 helo=NAM04-BN3-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/06 06:40:24
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>,
 Tong Ho <tongh@xilinx.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Edgar,

> -----Original Message-----
> From: Edgar E. Iglesias <edgar.iglesias@gmail.com>
> Sent: Monday, May 4, 2020 8:27 PM
> To: Sai Pavan Boddu <saipava@xilinx.com>
> Cc: Alistair Francis <Alistair.Francis@wdc.com>; Peter Maydell
> <peter.maydell@linaro.org>; Jason Wang <jasowang@redhat.com>; Markus
> Armbruster <armbru@redhat.com>; Philippe Mathieu-Daud=E9
> <philmd@redhat.com>; Tong Ho <tongh@xilinx.com>; Ramon Fried
> <rfried.dev@gmail.com>; qemu-arm@nongnu.org; qemu-
> devel@nongnu.org
> Subject: Re: [PATCH v2 04/10] net: cadence_gem: Define access permission
> for interrupt registers
>=20
> On Mon, May 04, 2020 at 07:36:02PM +0530, Sai Pavan Boddu wrote:
> > Q1 to Q7 ISR's are clear-on-read, IER/IDR registers are write-only,
> > mask reg are read-only.
> >
> > Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
> > ---
> >  hw/net/cadence_gem.c | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> >
> > diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c index
> > a930bf1..c532a14 100644
> > --- a/hw/net/cadence_gem.c
> > +++ b/hw/net/cadence_gem.c
> > @@ -458,6 +458,7 @@ static const uint8_t broadcast_addr[] =3D { 0xFF, 0=
xFF,
> 0xFF, 0xFF, 0xFF, 0xFF };
> >   */
> >  static void gem_init_register_masks(CadenceGEMState *s)  {
> > +    unsigned int i;
> >      /* Mask of register bits which are read only */
> >      memset(&s->regs_ro[0], 0, sizeof(s->regs_ro));
> >      s->regs_ro[GEM_NWCTRL]   =3D 0xFFF80000;
> > @@ -470,10 +471,19 @@ static void
> gem_init_register_masks(CadenceGEMState *s)
> >      s->regs_ro[GEM_ISR]      =3D 0xFFFFFFFF;
> >      s->regs_ro[GEM_IMR]      =3D 0xFFFFFFFF;
> >      s->regs_ro[GEM_MODID]    =3D 0xFFFFFFFF;
> > +    for (i =3D 0; i < s->num_priority_queues; i++) {
> > +        s->regs_ro[GEM_INT_Q1_STATUS + i] =3D 0xFFFFFFFF;
> > +        s->regs_ro[GEM_INT_Q1_ENABLE + i] =3D 0xFFFFE319;
> > +        s->regs_ro[GEM_INT_Q1_DISABLE + i] =3D 0xFFFFE319;
>=20
> Shouldn't these be 0xfffff319?
[Sai Pavan Boddu] This one is right. I would fix it thanks.

Regards,
Sai Pavan
> Perhaps I'm looking at old specs but mine says bits upper bits [31:12] ar=
e
> reserved and read-only.
>=20
>=20
> With that fixed:
> Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
>=20
>=20
>=20
>=20
>=20
> > +        s->regs_ro[GEM_INT_Q1_MASK + i] =3D 0xFFFFFFFF;
>=20
> > +    }
> >
> >      /* Mask of register bits which are clear on read */
> >      memset(&s->regs_rtc[0], 0, sizeof(s->regs_rtc));
> >      s->regs_rtc[GEM_ISR]      =3D 0xFFFFFFFF;
> > +    for (i =3D 0; i < s->num_priority_queues; i++) {
> > +        s->regs_rtc[GEM_INT_Q1_STATUS + i] =3D 0x00000CE6;
> > +    }
> >
> >      /* Mask of register bits which are write 1 to clear */
> >      memset(&s->regs_w1c[0], 0, sizeof(s->regs_w1c)); @@ -485,6
> > +495,10 @@ static void gem_init_register_masks(CadenceGEMState *s)
> >      s->regs_wo[GEM_NWCTRL]   =3D 0x00073E60;
> >      s->regs_wo[GEM_IER]      =3D 0x07FFFFFF;
> >      s->regs_wo[GEM_IDR]      =3D 0x07FFFFFF;
> > +    for (i =3D 0; i < s->num_priority_queues; i++) {
> > +        s->regs_wo[GEM_INT_Q1_ENABLE + i] =3D 0x00000CE6;
> > +        s->regs_wo[GEM_INT_Q1_DISABLE + i] =3D 0x00000CE6;
> > +    }
> >  }
> >
> >  /*
> > --
> > 2.7.4
> >

