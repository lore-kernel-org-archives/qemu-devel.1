Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2BF5C38A2A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 19:24:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CA6420CC7
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 19:24:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="ngstqTUM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CA6420CC7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40756 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jX8c4-0004Ia-Hk
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 15:24:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47614)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1jX8bK-0003B9-Qy; Fri, 08 May 2020 15:24:02 -0400
Received: from mail-eopbgr750047.outbound.protection.outlook.com
 ([40.107.75.47]:54593 helo=NAM02-BL2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1jX8bJ-0004PG-KQ; Fri, 08 May 2020 15:24:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c4skYA2Y/uDdGb2H8PsQCkcl8aRiPneKINjSVFVQAukU6GcvRSF9EF4L70KAnZCWQEZl2hJ1alNnF7gNATga4ESA480pYCqheTEo16mA5IytFvXIbdQPomoKo2oXw4UYiTzhR829SOrpkolNaqqSVegShaZSmQF05rP8eHyHHI18yASXPTRwn154HIiUUjGVFq8LI0HLwtTv2oDpc0qMJ32NSzcga1z31xh5QPh1m5Xm6LYV/XyvojLqrQl93xfr54UrWesRD+kGU+nB3w/nzeP45B9NUPUt19fu6mSiF+hL3YzZljE3B8+kBArEyf7HuS1HhSZCliiiPGqe5E/9iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gq6+i+fqW7JmhEh9DzVwGBT61OfQaV0xohY/6P9p+oM=;
 b=jS5gclgfYCWQBCVzt/YOKJFR7UvJGvEQJl9ddP3uqWVDuGwAONx7p19SPAzz9+GaS0L31tCxR9mSilsT2JbYSVIuMEK6crLGweWGKUM/oWFyvbvf7n/Jf1fG4qBIwUyjnI7uV7aHZLFLm5K2cfy64LWShGsEGv57NN9rUHMRX2Dhb+kwonTk5y+CVhsm/Vo4yf0w6HtU6Ajhqrj/NvTORNd2qpGqjYxZeYdsdeF5QNp0ndNpXb026f5E2ex8vUmRW2W+jwl7eb+PlR8Afknsi12dQ65WEApnMbrhC37qWF+U8xmRk9vvKweO/6W7T7M6WP1gkTDMmAeCTSmz/HrlAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gq6+i+fqW7JmhEh9DzVwGBT61OfQaV0xohY/6P9p+oM=;
 b=ngstqTUM+qwPdcBwgk1uIMTKevjuBmrtDJcKYOs9BirZJ90TcnbS+Z08/uzhbUxaHfXIfKCc6PzALM3sI6VyLR2hapX6SomOJb1lpxihnKoTGJZGX2XwsKMm+jynrYjrJVT1+0TEGD56WXWBoZ33qm9YbekA1QPtj+KZzUYRDXc=
Received: from BY5PR02MB6772.namprd02.prod.outlook.com (2603:10b6:a03:206::11)
 by BY5PR02MB6519.namprd02.prod.outlook.com (2603:10b6:a03:1d9::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.26; Fri, 8 May
 2020 19:23:59 +0000
Received: from BY5PR02MB6772.namprd02.prod.outlook.com
 ([fe80::9165:a37e:f249:48f6]) by BY5PR02MB6772.namprd02.prod.outlook.com
 ([fe80::9165:a37e:f249:48f6%9]) with mapi id 15.20.2979.028; Fri, 8 May 2020
 19:23:59 +0000
From: Sai Pavan Boddu <saipava@xilinx.com>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Subject: RE: [PATCH v3 06/11] net: cadence_gem: Move tx/rx packet buffert to
 CadenceGEMState
Thread-Topic: [PATCH v3 06/11] net: cadence_gem: Move tx/rx packet buffert to
 CadenceGEMState
Thread-Index: AQHWJSwHRBWNW62d8kKtqH+2HT6b4aiekdYg
Date: Fri, 8 May 2020 19:23:59 +0000
Message-ID: <BY5PR02MB677273B8BC597162EDF9B468CAA20@BY5PR02MB6772.namprd02.prod.outlook.com>
References: <1588935645-20351-1-git-send-email-sai.pavan.boddu@xilinx.com>
 <1588935645-20351-7-git-send-email-sai.pavan.boddu@xilinx.com>
 <20200508112947.GN5519@toto>
In-Reply-To: <20200508112947.GN5519@toto>
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
x-ms-office365-filtering-correlation-id: f9e9c627-f455-4aa3-5069-08d7f3855c2d
x-ms-traffictypediagnostic: BY5PR02MB6519:|BY5PR02MB6519:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR02MB651992F199F1D137AE7F78B5CAA20@BY5PR02MB6519.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2733;
x-forefront-prvs: 039735BC4E
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Uo07EOhvwOfbn0Cf617wzREcYA3Q8EVLi54/uwADBNvxkr0/FxnaRG9QBvzCGH7w19zVeaYY1YLuahYxC/qBDblZ6tc9GQQgtoytsRHE644CZUuqtjwZaoTiNUB9EZuxIFVKCpuxsDw+8jfPvM5xYosWIq7VrR7IPYSDIiCi0M4rHD/0FSmyXrymx+pAH7LmYMKDQ29BY6optEcyZh/AdrsdOF+yi8E+YInwhxU1Bc5PwfqSmXKeO9QTaRJ/qEZYMxS+gR6Mk/jQdY6XGKlBNxJwazgsXBGScZWJQ4aoSkIfhCA7s0YGdv6a6chohpkuErTTx3RmpwEXhc1Ny7fZ8tvisxSCbP68KCNDQV5NyqHecUTFnmrqfK+dAIk5Wzchh8f0Y07K9X9A7MK5Tl62h7re02sUaqIa/s3gdeQafX1NdlF1qE4PTizXjCp0JTP/qlo3R8yjYkmdkwlCQg8wd607NWPf5GnVAQXyYTHD02b1Ks5f3SMLbODTBtwemOWqUpGCsxM90Q94lwOUNmpdHA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR02MB6772.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(136003)(366004)(346002)(396003)(39860400002)(376002)(33430700001)(6916009)(54906003)(9686003)(53546011)(66946007)(66556008)(8936002)(8676002)(55016002)(66476007)(76116006)(4326008)(2906002)(83320400001)(83280400001)(83290400001)(186003)(83310400001)(86362001)(83300400001)(6506007)(316002)(66446008)(52536014)(26005)(33656002)(7696005)(64756008)(5660300002)(71200400001)(478600001)(33440700001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: Xx9ICMIH11nxzRRfBCryK3+nR+T6VWlUMk0EjKWzZO12Em1HjQiVGKuQhtdnw2bn7FKRLO9ZqrHRfkpvzrwyNKkyb3G9ZpeeZ7up1GRerPqUYn4/loLhxwWx5Zna177USMIxlGCCT6zlAyJPPIDQJR4t4vR+0D7KUJDz/1Ur3xOipM78wVZYVM/+BkPrY51JYivGoyde+0+ISAr31t6hXSIA6MiY3XfV4u63kWB8CGyHACgmwcwMUZWOXwP2Aln8MxyMCTY1ANhDJVV9r0lqoWJBeko1x1kCXmcEjy4uSKkshOvtD5CkFdV9YemLzVvg6RctfunYKHdmVgmfbtTDv2seZBY1vm03o6wmFqJdJPh/Vl57Xhf4Ulf/a9WyxNuRZUJYDe5m/ssCxjOHbUtev0tf1g1LJv54D1UwMPg/in2wRt6mkPGZj6IbY8tbsbv5zbDAj31Fsrf27m2pDy9oot7BNAkSRD3Uwh774la22Ao2cgHGZV3QIWcIxH53Wb1T
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9e9c627-f455-4aa3-5069-08d7f3855c2d
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2020 19:23:59.7155 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JrMEKH0Tyz+oXQcbo01IhEZAz6ptV/yi93VMJJtb5R0Gv4DhwZbc9kvGRWnheS2SZj25cS+jV1G0l4Kj2IOddg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6519
Received-SPF: pass client-ip=40.107.75.47; envelope-from=saipava@xilinx.com;
 helo=NAM02-BL2-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/08 15:24:00
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
> Sent: Friday, May 8, 2020 5:00 PM
> To: Sai Pavan Boddu <saipava@xilinx.com>
> Cc: Alistair Francis <Alistair.Francis@wdc.com>; Peter Maydell
> <peter.maydell@linaro.org>; Jason Wang <jasowang@redhat.com>; Markus
> Armbruster <armbru@redhat.com>; Philippe Mathieu-Daud=E9
> <philmd@redhat.com>; Tong Ho <tongh@xilinx.com>; Ramon Fried
> <rfried.dev@gmail.com>; qemu-arm@nongnu.org; qemu-
> devel@nongnu.org
> Subject: Re: [PATCH v3 06/11] net: cadence_gem: Move tx/rx packet buffert
> to CadenceGEMState
>=20
> On Fri, May 08, 2020 at 04:30:40PM +0530, Sai Pavan Boddu wrote:
> > Moving this buffers to CadenceGEMState, as their size will be
> > increased more when JUMBO frames support is added.
> >
> > Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
> > ---
> >  hw/net/cadence_gem.c         | 52 ++++++++++++++++++++++++++---------
> ---------
> >  include/hw/net/cadence_gem.h |  2 ++
> >  2 files changed, 33 insertions(+), 21 deletions(-)
> >
> > diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c index
> > 77a0588..5ccec1a 100644
> > --- a/hw/net/cadence_gem.c
> > +++ b/hw/net/cadence_gem.c
> > @@ -314,6 +314,8 @@
> >
> >  #define GEM_MODID_VALUE 0x00020118
> >
> > +#define MAX_FRAME_SIZE 2048
> > +
> >  static inline uint64_t tx_desc_get_buffer(CadenceGEMState *s,
> > uint32_t *desc)  {
> >      uint64_t ret =3D desc[0];
> > @@ -928,17 +930,14 @@ static void gem_get_rx_desc(CadenceGEMState
> *s, int q)
> >   */
> >  static ssize_t gem_receive(NetClientState *nc, const uint8_t *buf,
> > size_t size)  {
> > -    CadenceGEMState *s;
> > +    CadenceGEMState *s =3D qemu_get_nic_opaque(nc);
> >      unsigned   rxbufsize, bytes_to_copy;
> >      unsigned   rxbuf_offset;
> > -    uint8_t    rxbuf[2048];
> >      uint8_t   *rxbuf_ptr;
> >      bool first_desc =3D true;
> >      int maf;
> >      int q =3D 0;
> >
> > -    s =3D qemu_get_nic_opaque(nc);
> > -
> >      /* Is this destination MAC address "for us" ? */
> >      maf =3D gem_mac_address_filter(s, buf);
> >      if (maf =3D=3D GEM_RX_REJECT) {
> > @@ -994,19 +993,19 @@ static ssize_t gem_receive(NetClientState *nc,
> const uint8_t *buf, size_t size)
> >      } else {
> >          unsigned crc_val;
> >
> > -        if (size > sizeof(rxbuf) - sizeof(crc_val)) {
> > -            size =3D sizeof(rxbuf) - sizeof(crc_val);
> > +        if (size > MAX_FRAME_SIZE - sizeof(crc_val)) {
> > +            size =3D MAX_FRAME_SIZE - sizeof(crc_val);
> >          }
> >          bytes_to_copy =3D size;
> >          /* The application wants the FCS field, which QEMU does not pr=
ovide.
> >           * We must try and calculate one.
> >           */
> >
> > -        memcpy(rxbuf, buf, size);
> > -        memset(rxbuf + size, 0, sizeof(rxbuf) - size);
> > -        rxbuf_ptr =3D rxbuf;
> > -        crc_val =3D cpu_to_le32(crc32(0, rxbuf, MAX(size, 60)));
> > -        memcpy(rxbuf + size, &crc_val, sizeof(crc_val));
> > +        memcpy(s->rx_packet, buf, size);
> > +        memset(s->rx_packet + size, 0, MAX_FRAME_SIZE - size);
> > +        rxbuf_ptr =3D s->rx_packet;
> > +        crc_val =3D cpu_to_le32(crc32(0, s->rx_packet, MAX(size, 60)))=
;
> > +        memcpy(s->rx_packet + size, &crc_val, sizeof(crc_val));
> >
> >          bytes_to_copy +=3D 4;
> >          size +=3D 4;
> > @@ -1152,7 +1151,6 @@ static void gem_transmit(CadenceGEMState *s)  {
> >      uint32_t desc[DESC_MAX_NUM_WORDS];
> >      hwaddr packet_desc_addr;
> > -    uint8_t     tx_packet[2048];
> >      uint8_t     *p;
> >      unsigned    total_bytes;
> >      int q =3D 0;
> > @@ -1168,7 +1166,7 @@ static void gem_transmit(CadenceGEMState *s)
> >       * Packets scattered across multiple descriptors are gathered to t=
his
> >       * one contiguous buffer first.
> >       */
> > -    p =3D tx_packet;
> > +    p =3D s->tx_packet;
> >      total_bytes =3D 0;
> >
> >      for (q =3D s->num_priority_queues - 1; q >=3D 0; q--) { @@ -1198,1=
2
> > +1196,12 @@ static void gem_transmit(CadenceGEMState *s)
> >                  break;
> >              }
> >
> > -            if (tx_desc_get_length(desc) > sizeof(tx_packet) -
> > -                                               (p - tx_packet)) {
> > +            if (tx_desc_get_length(desc) > MAX_FRAME_SIZE -
> > +                                               (p - s->tx_packet)) {
> >                  DB_PRINT("TX descriptor @ 0x%" HWADDR_PRIx \
> >                           " too large: size 0x%x space 0x%zx\n",
> >                           packet_desc_addr, tx_desc_get_length(desc),
> > -                         sizeof(tx_packet) - (p - tx_packet));
> > +                         MAX_FRAME_SIZE - (p - s->tx_packet));
> >                  break;
> >              }
> >
> > @@ -1248,24 +1246,24 @@ static void gem_transmit(CadenceGEMState
> *s)
> >
> >                  /* Is checksum offload enabled? */
> >                  if (s->regs[GEM_DMACFG] & GEM_DMACFG_TXCSUM_OFFL) {
> > -                    net_checksum_calculate(tx_packet, total_bytes);
> > +                    net_checksum_calculate(s->tx_packet,
> > + total_bytes);
> >                  }
> >
> >                  /* Update MAC statistics */
> > -                gem_transmit_updatestats(s, tx_packet, total_bytes);
> > +                gem_transmit_updatestats(s, s->tx_packet,
> > + total_bytes);
> >
> >                  /* Send the packet somewhere */
> >                  if (s->phy_loop || (s->regs[GEM_NWCTRL] &
> >                                      GEM_NWCTRL_LOCALLOOP)) {
> > -                    gem_receive(qemu_get_queue(s->nic), tx_packet,
> > +                    gem_receive(qemu_get_queue(s->nic), s->tx_packet,
> >                                  total_bytes);
> >                  } else {
> > -                    qemu_send_packet(qemu_get_queue(s->nic), tx_packet=
,
> > +                    qemu_send_packet(qemu_get_queue(s->nic),
> > + s->tx_packet,
> >                                       total_bytes);
> >                  }
> >
> >                  /* Prepare for next packet */
> > -                p =3D tx_packet;
> > +                p =3D s->tx_packet;
> >                  total_bytes =3D 0;
> >              }
> >
> > @@ -1612,6 +1610,17 @@ static void gem_realize(DeviceState *dev, Error
> > **errp)
> >
> >      s->nic =3D qemu_new_nic(&net_gem_info, &s->conf,
> >                            object_get_typename(OBJECT(dev)), dev->id,
> > s);
> > +
> > +    s->tx_packet =3D g_new0(uint8_t, MAX_FRAME_SIZE);
> > +    s->rx_packet =3D g_new0(uint8_t, MAX_FRAME_SIZE);
>=20
> Hi Sai,
>=20
> Since you're only using MAX_FRAME_SIZE these could be arrays in
> CadenceGEMState.
[Sai Pavan Boddu] Ok, I will put this in v4.

Thanks,
Sai Pavan
>=20
> With that change:
> Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>

