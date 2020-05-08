Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E439BC38A2A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 19:24:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6AC120CC7
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 19:24:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="oO4XaSge"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6AC120CC7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jX8bK-0002sM-Sm
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 15:24:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47446)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1jX8aH-0001aZ-Qm; Fri, 08 May 2020 15:22:57 -0400
Received: from mail-eopbgr750041.outbound.protection.outlook.com
 ([40.107.75.41]:50666 helo=NAM02-BL2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1jX8aF-00044k-OL; Fri, 08 May 2020 15:22:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZPy3cs9U3zgQ6CDZdxCx/5INR3eVxvHvCB7RP6e7fkp238drRDfy0VsafHb2ARxKoAJc6UvaBMb0hQJNnxbPF2K6nj3Nkc5vPEDG8IPaOydeXYfX4FSUqb7+4qs6yQ/wuljGFHwQQeD47Qp2AXcLH1IDUZCIdZsX7Gt7KbeTODO01XLRwEzR3wNlGWLxlDyxhVsXa6S+/zlCMbG+sJCktNdpQveT71e8HwHUUi8ztTA+E90fZPnyOtOtbq18pu+mHeM0i1cLxlR6q1eDeyltib5Cqdy10Z53U10aYqbGdDK4dPZQHQedoaqD77r0Rx+nJA+hvmYAFnX9qi9toye/PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9hO+dP6Bnk5ka63XpauTV2RcjpbutoGncE637moB8ZI=;
 b=mJrmWi7mIOHOATDFlr9DpsVa0F0jAKjrK+SO+yaCrb+T27aSXGMK9wB595cGACeIS3MClvEO+IFgCCthnT1avTMpjEwyZHaV9BlvSgaPbIFbOj7FOvxLYoB1x65VpJz1ociL05EYFrXPSvRePUR3Uvc7r5W84VobYBjznTCzpSmBmUvq2RCcSemCqqT2rgGA1xD4PeqTtQc60uyIWENy/ajNfGq4puYH5p5TuqqRr5tWHAY10RrMBQ5dFWmhT7B6fX5ZKHKOJVAMVSUvOejfl+prL4weibpXDJWU/LpIRo3fxsau/g+0o+6O7EX6FaJTRcL5hCgo8Dh+R68Jzq+Ocg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9hO+dP6Bnk5ka63XpauTV2RcjpbutoGncE637moB8ZI=;
 b=oO4XaSgeqzY9Tu6ARroMD4VJUceTkeXLUJ1cgFeYYOdfCUztjhRk73Y7cHIphL8+QCjvsbE/Z85XFVX+/8Qzf/xIhRUrTX+pe/AdpgHfIzMgbqaWjizzQtePiGEj8ihN2bqG9v89gocBezgym0msbmZzYcbD/85ZXk3vO8cx2nI=
Received: from BY5PR02MB6772.namprd02.prod.outlook.com (2603:10b6:a03:206::11)
 by BY5PR02MB6519.namprd02.prod.outlook.com (2603:10b6:a03:1d9::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.26; Fri, 8 May
 2020 19:22:52 +0000
Received: from BY5PR02MB6772.namprd02.prod.outlook.com
 ([fe80::9165:a37e:f249:48f6]) by BY5PR02MB6772.namprd02.prod.outlook.com
 ([fe80::9165:a37e:f249:48f6%9]) with mapi id 15.20.2979.028; Fri, 8 May 2020
 19:22:52 +0000
From: Sai Pavan Boddu <saipava@xilinx.com>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Subject: RE: [PATCH v3 07/11] net: cadence_gem: Add support for jumbo frames
Thread-Topic: [PATCH v3 07/11] net: cadence_gem: Add support for jumbo frames
Thread-Index: AQHWJS37nEK4El8uyU6FgqYGeBrGyaiejVbA
Date: Fri, 8 May 2020 19:22:51 +0000
Message-ID: <BY5PR02MB6772360CA5745794340B1CCCCAA20@BY5PR02MB6772.namprd02.prod.outlook.com>
References: <1588935645-20351-1-git-send-email-sai.pavan.boddu@xilinx.com>
 <1588935645-20351-8-git-send-email-sai.pavan.boddu@xilinx.com>
 <20200508114347.GO5519@toto>
In-Reply-To: <20200508114347.GO5519@toto>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=xilinx.com;
x-originating-ip: [149.199.50.130]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bc435c1f-2295-4021-26a3-08d7f38533c3
x-ms-traffictypediagnostic: BY5PR02MB6519:|BY5PR02MB6519:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR02MB651931F4E69521AACBF6F8AFCAA20@BY5PR02MB6519.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 039735BC4E
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CY7nwEKUI59reHHZg/ULgCL6p31ZmHvwDpdNdhtWhqwEZyDUIIVmBpVdDNQDrLKQDcYy30/epG60Ul64qGaz1neVS+prVSEUfZeLURDwPuibYj1Kru2eDFtJitZtpvZ4XCPMmt6WUYydmbolpZzJeTDBMm/4QVTxqZu4U70yNNP/Qr2iKQgmu4aKnjZiIOTOuqhWBNd3kyZ0xKMcL7Za0DKIWbhwNy39ThbaZzwXk+RJTJ0qGYW++PQOAoO+j2gb+tmqHExwbwTlDGBLtJPTeobDTntHxV75MJa6mgDZqpPcbBRCiZYgsRVxhdOFyzDrR6ap1qPPZsZXLtrOEGowhMOAXqi5d9klvsEj8Gxi3nzO6XZGNXja9rXVLSGR1vOf6tMiiFgSmEJjx7S44wfYlRJ/2QskewufnsAF19csws2HYKrYNnQDwbgutras1VHSfy3HoDRy3ZWNjDFbVU26engKzgy8zuHRPdtSzQKypGVQnhHzP1mZIJxgloFenFsuMWarV23/fg+I/93cm4PBog==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR02MB6772.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(136003)(366004)(346002)(396003)(39860400002)(376002)(33430700001)(6916009)(54906003)(9686003)(53546011)(66946007)(66556008)(8936002)(8676002)(55016002)(66476007)(76116006)(4326008)(2906002)(83320400001)(83280400001)(83290400001)(186003)(83310400001)(86362001)(83300400001)(6506007)(316002)(66446008)(52536014)(26005)(33656002)(7696005)(64756008)(5660300002)(71200400001)(478600001)(33440700001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: UGf1h/T/iRAHCn5HZMYK9xf9yd4vr6myXlM2XiRwLvx9YwidpONOnXU+EHnkUb96+849sP+Www1K2QmXKYQGA9+98xXCHl1uRcAiWGw7ZIYxSgnuZu+lH1pCqZU9H287AjgclVu+c03LsMfKqYzA3rtcJ4gLn33QBqnAICctvSY1DmBgBimlNgVQcP3S+1gFB7tK3jIHnVDhhrPe/pu7FGghj6qui1NW49uWhH22IJZ+EHe44FqWO5txU713cC3t5kWayA3zd9fkJerJh96EfsMs0PaKRNOXnJ/lzPpbWLJop033pceBHEk2f8vcTmh5daA6oQqkpWYpzCo1mDFZWi1Q4dAOdoGLQTYrrNlPu+KAIRKyOzhnH+KP/e8RPr4n//otpgxeEhzd3QWowiL1/MnIE1UI9lWc8Jg9+G6XdUmtDlBjKhRhHW0OV1nPxn/qsXr4Utm11Q4fNUXaKTYrLsTbv/s1v1r/iwLdsaatOigVn4dP9hyYHbiTbkm57rYV
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc435c1f-2295-4021-26a3-08d7f38533c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2020 19:22:51.7864 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BVoOb4ceB1ieJmZ1PEXKn/ijXiBccOb5uTlYWGHP2+ZS07X8+4EMadJzTjYmgi3eGWjPRYFyQpMfx+iY+zjRiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6519
Received-SPF: pass client-ip=40.107.75.41; envelope-from=saipava@xilinx.com;
 helo=NAM02-BL2-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/08 15:22:53
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
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
> Sent: Friday, May 8, 2020 5:14 PM
> To: Sai Pavan Boddu <saipava@xilinx.com>
> Cc: Alistair Francis <Alistair.Francis@wdc.com>; Peter Maydell
> <peter.maydell@linaro.org>; Jason Wang <jasowang@redhat.com>; Markus
> Armbruster <armbru@redhat.com>; Philippe Mathieu-Daud=E9
> <philmd@redhat.com>; Tong Ho <tongh@xilinx.com>; Ramon Fried
> <rfried.dev@gmail.com>; qemu-arm@nongnu.org; qemu-
> devel@nongnu.org
> Subject: Re: [PATCH v3 07/11] net: cadence_gem: Add support for jumbo
> frames
>=20
> On Fri, May 08, 2020 at 04:30:41PM +0530, Sai Pavan Boddu wrote:
> > Add a property "jumbo-max-len", which can be configured for jumbo
> > frame size up to 16,383 bytes, and also introduce new register
> GEM_JUMBO_MAX_LEN.
> >
> > Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
> > ---
> >  hw/net/cadence_gem.c         | 21 +++++++++++++++++++--
> >  include/hw/net/cadence_gem.h |  1 +
> >  2 files changed, 20 insertions(+), 2 deletions(-)
> >
> > diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c index
> > 5ccec1a..45c50ab 100644
> > --- a/hw/net/cadence_gem.c
> > +++ b/hw/net/cadence_gem.c
> > @@ -61,6 +61,7 @@
> >  #define GEM_TXPAUSE       (0x0000003C/4) /* TX Pause Time reg */
> >  #define GEM_TXPARTIALSF   (0x00000040/4) /* TX Partial Store and
> Forward */
> >  #define GEM_RXPARTIALSF   (0x00000044/4) /* RX Partial Store and
> Forward */
> > +#define GEM_JUMBO_MAX_LEN (0x00000048 / 4) /* Max Jumbo Frame
> Size */
>=20
> Would be nice to align this in the same way as all the others...
>=20
>=20
>=20
> >  #define GEM_HASHLO        (0x00000080/4) /* Hash Low address reg */
> >  #define GEM_HASHHI        (0x00000084/4) /* Hash High address reg */
> >  #define GEM_SPADDR1LO     (0x00000088/4) /* Specific addr 1 low reg */
> > @@ -314,7 +315,8 @@
> >
> >  #define GEM_MODID_VALUE 0x00020118
> >
> > -#define MAX_FRAME_SIZE 2048
> > +#define MAX_JUMBO_FRAME_SIZE_MASK 0x3FFF #define
> MAX_FRAME_SIZE
> > +MAX_JUMBO_FRAME_SIZE_MASK
> >
> >  static inline uint64_t tx_desc_get_buffer(CadenceGEMState *s,
> > uint32_t *desc)  { @@ -1343,9 +1345,10 @@ static void
> > gem_reset(DeviceState *d)
> >      s->regs[GEM_RXPARTIALSF] =3D 0x000003ff;
> >      s->regs[GEM_MODID] =3D s->revision;
> >      s->regs[GEM_DESCONF] =3D 0x02500111;
> > -    s->regs[GEM_DESCONF2] =3D 0x2ab13fff;
> > +    s->regs[GEM_DESCONF2] =3D 0x2ab10000 | s->jumbo_max_len;
> >      s->regs[GEM_DESCONF5] =3D 0x002f2045;
> >      s->regs[GEM_DESCONF6] =3D GEM_DESCONF6_64B_MASK;
> > +    s->regs[GEM_JUMBO_MAX_LEN] =3D s->jumbo_max_len;
> >
> >      if (s->num_priority_queues > 1) {
> >          queues_mask =3D MAKE_64BIT_MASK(1, s->num_priority_queues - 1)=
;
> > @@ -1420,6 +1423,9 @@ static uint64_t gem_read(void *opaque, hwaddr
> offset, unsigned size)
> >          DB_PRINT("lowering irqs on ISR read\n");
> >          /* The interrupts get updated at the end of the function. */
> >          break;
> > +    case GEM_JUMBO_MAX_LEN:
> > +        retval =3D s->jumbo_max_len;
> > +        break;
> >      case GEM_PHYMNTNC:
> >          if (retval & GEM_PHYMNTNC_OP_R) {
> >              uint32_t phy_addr, reg_num; @@ -1516,6 +1522,9 @@ static
> > void gem_write(void *opaque, hwaddr offset, uint64_t val,
> >          s->regs[GEM_IMR] &=3D ~val;
> >          gem_update_int_status(s);
> >          break;
> > +    case GEM_JUMBO_MAX_LEN:
> > +        s->jumbo_max_len =3D val & MAX_JUMBO_FRAME_SIZE_MASK;
>=20
> I don't think writing to this register may increase the max len beyond th=
e
> max-len selected at design time (the property).
> TBH I'm surprised this register is RW in the spec.
>=20
> We may need two variables here, one for the design-time configured max
> and another for the runtime configurable max.
[Sai Pavan Boddu] Better way is to, use new created property  to set the re=
set value of  this register. Which can be overwritten by guest on runtime b=
y writing to regs[GEM_JUMBO_MAX_LEN].

I would add few checks, so that frames does not cross JUMBO max length conf=
igured.

Thanks,
Sai Pavan
>=20
>=20
> > +        break;
> >      case GEM_INT_Q1_ENABLE ... GEM_INT_Q7_ENABLE:
> >          s->regs[GEM_INT_Q1_MASK + offset - GEM_INT_Q1_ENABLE] &=3D
> ~val;
> >          gem_update_int_status(s);
> > @@ -1611,6 +1620,12 @@ static void gem_realize(DeviceState *dev, Error
> **errp)
> >      s->nic =3D qemu_new_nic(&net_gem_info, &s->conf,
> >                            object_get_typename(OBJECT(dev)), dev->id,
> > s);
> >
> > +    if (s->jumbo_max_len > MAX_FRAME_SIZE) {
> > +        g_warning("jumbo-max-len is grater than %d",
>=20
>=20
> You've got a typo here "grater".
>=20
> I also think we could error out here if wrong values are chosen.
>=20
> Best regards,
> Edgar

