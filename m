Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F9E7C2D0FD
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 05:17:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C3C0206F5
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 05:17:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="FUkH3aod"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C3C0206F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40460 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYjlZ-0004PM-9w
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 01:17:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39760)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1jYjkS-0003s7-TB; Wed, 13 May 2020 01:16:04 -0400
Received: from mail-dm6nam12on2040.outbound.protection.outlook.com
 ([40.107.243.40]:6105 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1jYjkP-0000Gs-Bu; Wed, 13 May 2020 01:16:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CByqtdfjJZxGveIZbIfifAmYehL1erF0hdF6WnMAXZgMzhxcrC+lDxXuQZ0EGUJyp2s4Gjd0M6Tin8ea5dY0T9tdEWSk3IehC/JRcJEY/j1W/fP5ntLKdjkjSEjGYv3lS5kXQ9tgkGDOGjk37ettc4r8/Np/gGDGc1Isbxj0WOC6uOqDT75iuL/FZwIGTrB9iWnJIjLk8nNlN1B5/GZNUtbiDECUwrdwgG5AdyE9YXCC0o+tv5pAglPcwVphjhc+VhG9s/fwuUWfCfcM0xQjDcZoI5spU20wU1Y1IHHSi2CwQodjU3k55HJI4HgLpdUkvnOQb0clbHna4PMYkfwrRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uR2ghuoYjlO3y65GdJiv7a5VJo7eX7aOmqJlp2fbxv8=;
 b=ndmx+4/kuIvqiddCDiO8p7ARuRQHhHv0tF7Ch1hQEysbJd7mHp42UTn3s4k25WCaH6qwesXHLrela79yGPDYlwqcuQsRVNugdvzcg69GU4aJDks6P5ND24JCt92vuUHE/H+mNeDDMNImKHJCBRSS26A2KY74V8SDgVKfru7fXOVaMdVj3grgXHHzout7nDjBqjbtm/VjzfSX/oASImXPk8jcnxIKITP2Is39xN9WBOrUKgLUIBA/LYtq9x/C7TXsh8xkwg79feekgJVXBcbrMyBPS3/f02pkMq0MAZ0E2uouwW2r+TqGrm1/G62NL1jUCFR44znJCubrlFJdvRY5hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uR2ghuoYjlO3y65GdJiv7a5VJo7eX7aOmqJlp2fbxv8=;
 b=FUkH3aodSdT7nbKjckwOF+78E+k66O4bpZarTYNOVBVdWpdx4mdOGF3qg0KA2jx3IrRMXU1HKQedregJtz8R4kL3id+Sv8JQ+mkYOcb89FhjawXygj6U5tBljEvao/klZc73k9PpzPsKyL4NNoH7gR4Fz4auKxQnr5lPtqcJBCw=
Received: from BY5PR02MB6772.namprd02.prod.outlook.com (2603:10b6:a03:206::11)
 by BY5PR02MB6550.namprd02.prod.outlook.com (2603:10b6:a03:1d5::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.33; Wed, 13 May
 2020 05:15:57 +0000
Received: from BY5PR02MB6772.namprd02.prod.outlook.com
 ([fe80::6ca8:ed9c:1704:a816]) by BY5PR02MB6772.namprd02.prod.outlook.com
 ([fe80::6ca8:ed9c:1704:a816%7]) with mapi id 15.20.3000.016; Wed, 13 May 2020
 05:15:57 +0000
From: Sai Pavan Boddu <saipava@xilinx.com>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Subject: RE: [PATCH v5 08/12] net: cadence_gem: Add support for jumbo frames
Thread-Topic: [PATCH v5 08/12] net: cadence_gem: Add support for jumbo frames
Thread-Index: AQHWKHDYl22G0IhT6kaF6VDMpqzj1KileiKg
Date: Wed, 13 May 2020 05:15:57 +0000
Message-ID: <BY5PR02MB6772E781D4D106FB679ACDB2CABF0@BY5PR02MB6772.namprd02.prod.outlook.com>
References: <1589295294-26466-1-git-send-email-sai.pavan.boddu@xilinx.com>
 <1589295294-26466-9-git-send-email-sai.pavan.boddu@xilinx.com>
 <20200512151956.GU5519@toto>
In-Reply-To: <20200512151956.GU5519@toto>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=xilinx.com;
x-originating-ip: [183.83.78.103]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b4f4d993-1b6e-4629-02f2-08d7f6fcb7e1
x-ms-traffictypediagnostic: BY5PR02MB6550:|BY5PR02MB6550:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR02MB6550B530ACC63C0422D45C0BCABF0@BY5PR02MB6550.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:304;
x-forefront-prvs: 0402872DA1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: d7rbaULVkblCaib29IJnJEr+KrJAwIlYbGzObfJwHNI1QhP8NIvr/Aaim/D617E/nFvhZGtlrKIPA2+2Ibn45rAUWvGO2IrgXY3iaCmOsa74TLtvhaSONR6WkcFC/TC0tARR8WO4Eeyj2M+Mk9Dy+lzFS0EumVrCRcXM84/sZJ+5boDElqnj1VWRKpRpOFvBYjPPS+HF5dxPHQGBM8axjcQ7WiXBe5pMdl7GK819Ka8VY/vpUEreNKbU05p3R93AN1kVHBoQMMGN3FHHsHMcjmBjQbTeOiQbGexKJ00QRAYfUumE7a7UZBSiALOlOhIu4trQwXEU941Z50V3oszQeEuhtat/ANzChqdTOc8d6WmYYYX+xZvrGhm0J3R79DYcIEsoeG0MrGB9oOZFZwIlt76svrJgdeW3U32fJybeizkoEawR2HIkbNG2ATICVo2ww5a00HfwpIGwpjW5+2jBjWddQC13jSH/NPSrtBYoLF8xz+5Vat4d29GLrHRXzgfhmw3pFURUtGNC/GdS0Pm2CA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR02MB6772.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(396003)(376002)(136003)(366004)(346002)(39860400002)(33430700001)(53546011)(33440700001)(66556008)(66446008)(26005)(55016002)(8936002)(8676002)(6506007)(9686003)(5660300002)(33656002)(64756008)(186003)(6916009)(7696005)(478600001)(52536014)(86362001)(76116006)(54906003)(4326008)(71200400001)(66476007)(316002)(2906002)(66946007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: p0M2UvjvoseEWfkS0mhgXbvJzMSf4j5WDw7lIMtgoHJGhtkeMVWasq++vejClFGLz8jqkSaDWkxybeRojqyLxwo+UjUzhiV41cqz2k8zUFq0qekP260lkBTT4zubPnc5OjiIqy0WcQS+rUUT8GUdeIhkokjlipzNu3PJj8gSvtftELlwwbdhZguK5dDVU23l8atZy5BK8OALR8ZtzJAi+ADI1jU3a2g3FVdokkNRuMM/EfNgRIhZEOU8gK6B++8bIJKPhWR+ZDJ3UDIbmN+pKC6zIo9DaM4zZKK7jQtZrOwZKV2ine+nllZ0nfpmUjTBWn+PpSU4rx5iNl+z43l5p9H6scdSPruhSlJnIwlU6rW24numFrYYUue81Vtcv2JI9NvwOXCT0G+WC+PvCKNcE+33LcPGxWL+xmre8oAljiPBy9i7hRFh63uw8dtVwExwKnkqsU9J1mdMTmuLoLgokf7rJsJvS8Tu02U6rUQD2y8=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4f4d993-1b6e-4629-02f2-08d7f6fcb7e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2020 05:15:57.1341 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I/ClFXZWwGkoyBmlqe0OG3N6wCVXZZQhwAcp990WSNsMoIBQ+WIz8fCHdXLvHvZSTMIi7JB+tRlPc1G1lhEe5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6550
Received-SPF: pass client-ip=40.107.243.40; envelope-from=saipava@xilinx.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 01:15:58
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

Thanks for review edgar!

Regards,
Sai pavan

> -----Original Message-----
> From: Edgar E. Iglesias <edgar.iglesias@gmail.com>
> Sent: Tuesday, May 12, 2020 8:50 PM
> To: Sai Pavan Boddu <saipava@xilinx.com>
> Cc: Alistair Francis <Alistair.Francis@wdc.com>; Peter Maydell
> <peter.maydell@linaro.org>; Jason Wang <jasowang@redhat.com>; Markus
> Armbruster <armbru@redhat.com>; Philippe Mathieu-Daud=E9
> <philmd@redhat.com>; Tong Ho <tongh@xilinx.com>; Ramon Fried
> <rfried.dev@gmail.com>; qemu-arm@nongnu.org; qemu-
> devel@nongnu.org
> Subject: Re: [PATCH v5 08/12] net: cadence_gem: Add support for jumbo
> frames
>=20
> On Tue, May 12, 2020 at 08:24:50PM +0530, Sai Pavan Boddu wrote:
> > Add a property "jumbo-max-len", which sets default value of jumbo
> > frames up to 16,383 bytes. Add Frame length checks for standard and
> > jumbo frames.
>=20
> Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
>=20
>=20
>=20
> >
> > Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
> > ---
> >  hw/net/cadence_gem.c         | 51
> +++++++++++++++++++++++++++++++++++++++-----
> >  include/hw/net/cadence_gem.h |  4 +++-
> >  2 files changed, 49 insertions(+), 6 deletions(-)
> >
> > diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c index
> > f6ff27c..eb02946 100644
> > --- a/hw/net/cadence_gem.c
> > +++ b/hw/net/cadence_gem.c
> > @@ -61,6 +61,7 @@
> >  #define GEM_TXPAUSE       (0x0000003C / 4) /* TX Pause Time reg */
> >  #define GEM_TXPARTIALSF   (0x00000040 / 4) /* TX Partial Store and
> Forward */
> >  #define GEM_RXPARTIALSF   (0x00000044 / 4) /* RX Partial Store and
> Forward */
> > +#define GEM_JUMBO_MAX_LEN (0x00000048 / 4) /* Max Jumbo Frame
> Size */
> >  #define GEM_HASHLO        (0x00000080 / 4) /* Hash Low address reg */
> >  #define GEM_HASHHI        (0x00000084 / 4) /* Hash High address reg */
> >  #define GEM_SPADDR1LO     (0x00000088 / 4) /* Specific addr 1 low reg =
*/
> > @@ -212,10 +213,12 @@
> >  #define GEM_NWCFG_LERR_DISC    0x00010000 /* Discard RX frames with
> len err */
> >  #define GEM_NWCFG_BUFF_OFST_M  0x0000C000 /* Receive buffer
> offset mask */
> >  #define GEM_NWCFG_BUFF_OFST_S  14         /* Receive buffer offset shi=
ft
> */
> > +#define GEM_NWCFG_RCV_1538     0x00000100 /* Receive 1538 bytes
> frame */
> >  #define GEM_NWCFG_UCAST_HASH   0x00000080 /* accept unicast if hash
> match */
> >  #define GEM_NWCFG_MCAST_HASH   0x00000040 /* accept multicast if
> hash match */
> >  #define GEM_NWCFG_BCAST_REJ    0x00000020 /* Reject broadcast
> packets */
> >  #define GEM_NWCFG_PROMISC      0x00000010 /* Accept all packets */
> > +#define GEM_NWCFG_JUMBO_FRAME  0x00000008 /* Jumbo Frames
> enable */
> >
> >  #define GEM_DMACFG_ADDR_64B    (1U << 30)
> >  #define GEM_DMACFG_TX_BD_EXT   (1U << 29)
> > @@ -233,6 +236,7 @@
> >
> >  /* GEM_ISR GEM_IER GEM_IDR GEM_IMR */
> >  #define GEM_INT_TXCMPL        0x00000080 /* Transmit Complete */
> > +#define GEM_INT_AMBA_ERR      0x00000040
> >  #define GEM_INT_TXUSED         0x00000008
> >  #define GEM_INT_RXUSED         0x00000004
> >  #define GEM_INT_RXCMPL        0x00000002
> > @@ -453,6 +457,24 @@ static inline void rx_desc_set_sar(uint32_t
> > *desc, int sar_idx)
> >  /* The broadcast MAC address: 0xFFFFFFFFFFFF */  static const uint8_t
> > broadcast_addr[] =3D { 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF };
> >
> > +static uint32_t gem_get_max_buf_len(CadenceGEMState *s, bool tx) {
> > +    uint32_t size;
> > +    if (s->regs[GEM_NWCFG] & GEM_NWCFG_JUMBO_FRAME) {
> > +        size =3D s->regs[GEM_JUMBO_MAX_LEN];
> > +        if (size > s->jumbo_max_len) {
> > +            size =3D s->jumbo_max_len;
> > +            qemu_log_mask(LOG_GUEST_ERROR, "GEM_JUMBO_MAX_LEN
> reg cannot be"
> > +                " greater than 0x%" PRIx32 "\n", s->jumbo_max_len);
> > +        }
> > +    } else if (tx) {
> > +        size =3D 1518;
> > +    } else {
> > +        size =3D s->regs[GEM_NWCFG] & GEM_NWCFG_RCV_1538 ? 1538 :
> 1518;
> > +    }
> > +    return size;
> > +}
> > +
> >  static void gem_set_isr(CadenceGEMState *s, int q, uint32_t flag)  {
> >      if (q =3D=3D 0) {
> > @@ -1016,6 +1038,12 @@ static ssize_t gem_receive(NetClientState *nc,
> const uint8_t *buf, size_t size)
> >      /* Find which queue we are targeting */
> >      q =3D get_queue_from_screen(s, rxbuf_ptr, rxbufsize);
> >
> > +    if (size > gem_get_max_buf_len(s, false)) {
> > +        qemu_log_mask(LOG_GUEST_ERROR, "rx frame too long\n");
> > +        gem_set_isr(s, q, GEM_INT_AMBA_ERR);
> > +        return -1;
> > +    }
> > +
> >      while (bytes_to_copy) {
> >          hwaddr desc_addr;
> >
> > @@ -1196,12 +1224,13 @@ static void gem_transmit(CadenceGEMState
> *s)
> >                  break;
> >              }
> >
> > -            if (tx_desc_get_length(desc) > MAX_FRAME_SIZE -
> > +            if (tx_desc_get_length(desc) > gem_get_max_buf_len(s,
> > + true) -
> >                                                 (p - s->tx_packet)) {
> > -                DB_PRINT("TX descriptor @ 0x%" HWADDR_PRIx \
> > -                         " too large: size 0x%x space 0x%zx\n",
> > +                qemu_log_mask(LOG_GUEST_ERROR, "TX descriptor @ 0x%" \
> > +                         HWADDR_PRIx " too large: size 0x%x space
> > + 0x%zx\n",
> >                           packet_desc_addr, tx_desc_get_length(desc),
> > -                         MAX_FRAME_SIZE - (p - s->tx_packet));
> > +                         gem_get_max_buf_len(s, true) - (p - s->tx_pac=
ket));
> > +                gem_set_isr(s, q, GEM_INT_AMBA_ERR);
> >                  break;
> >              }
> >
> > @@ -1343,9 +1372,10 @@ static void gem_reset(DeviceState *d)
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
> > @@ -1516,6 +1546,9 @@ static void gem_write(void *opaque, hwaddr
> offset, uint64_t val,
> >          s->regs[GEM_IMR] &=3D ~val;
> >          gem_update_int_status(s);
> >          break;
> > +    case GEM_JUMBO_MAX_LEN:
> > +        s->regs[GEM_JUMBO_MAX_LEN] =3D val &
> MAX_JUMBO_FRAME_SIZE_MASK;
> > +        break;
> >      case GEM_INT_Q1_ENABLE ... GEM_INT_Q7_ENABLE:
> >          s->regs[GEM_INT_Q1_MASK + offset - GEM_INT_Q1_ENABLE] &=3D
> ~val;
> >          gem_update_int_status(s);
> > @@ -1610,6 +1643,12 @@ static void gem_realize(DeviceState *dev, Error
> > **errp)
> >
> >      s->nic =3D qemu_new_nic(&net_gem_info, &s->conf,
> >                            object_get_typename(OBJECT(dev)), dev->id,
> > s);
> > +
> > +    if (s->jumbo_max_len > MAX_FRAME_SIZE) {
> > +        error_setg(errp, "jumbo-max-len is greater than %d",
> > +                  MAX_FRAME_SIZE);
> > +        return;
> > +    }
> >  }
> >
> >  static void gem_init(Object *obj)
> > @@ -1659,6 +1698,8 @@ static Property gem_properties[] =3D {
> >                        num_type1_screeners, 4),
> >      DEFINE_PROP_UINT8("num-type2-screeners", CadenceGEMState,
> >                        num_type2_screeners, 4),
> > +    DEFINE_PROP_UINT16("jumbo-max-len", CadenceGEMState,
> > +                       jumbo_max_len, 10240),
> >      DEFINE_PROP_END_OF_LIST(),
> >  };
> >
> > diff --git a/include/hw/net/cadence_gem.h
> > b/include/hw/net/cadence_gem.h index eddac70..54e646f 100644
> > --- a/include/hw/net/cadence_gem.h
> > +++ b/include/hw/net/cadence_gem.h
> > @@ -40,7 +40,8 @@
> >  #define MAX_TYPE1_SCREENERS             16
> >  #define MAX_TYPE2_SCREENERS             16
> >
> > -#define MAX_FRAME_SIZE 2048
> > +#define MAX_JUMBO_FRAME_SIZE_MASK 0x3FFF #define
> MAX_FRAME_SIZE
> > +MAX_JUMBO_FRAME_SIZE_MASK
> >
> >  typedef struct CadenceGEMState {
> >      /*< private >*/
> > @@ -59,6 +60,7 @@ typedef struct CadenceGEMState {
> >      uint8_t num_type1_screeners;
> >      uint8_t num_type2_screeners;
> >      uint32_t revision;
> > +    uint16_t jumbo_max_len;
> >
> >      /* GEM registers backing store */
> >      uint32_t regs[CADENCE_GEM_MAXREG];
> > --
> > 2.7.4
> >

