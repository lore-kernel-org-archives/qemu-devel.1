Return-Path: <SRS0=qR42=YW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2512CA9EC3
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 10:08:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80C8420830
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 10:08:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="giw3YxOR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80C8420830
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54118 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPOQ4-0007Uv-JT
	for qemu-devel@archiver.kernel.org; Tue, 29 Oct 2019 06:08:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54825)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <saipava@xilinx.com>) id 1iPOPL-0006H2-Vk
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 06:07:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <saipava@xilinx.com>) id 1iPOPK-0007n0-Mo
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 06:07:23 -0400
Received: from mail-eopbgr690053.outbound.protection.outlook.com
 ([40.107.69.53]:8727 helo=NAM04-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <saipava@xilinx.com>) id 1iPOPJ-0007mF-FQ
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 06:07:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oWE7yqKNVKicZUKX6746eZQgkHvWz4K3jxDd1yCH/ODFIgO+6oDZUWiqG1cw/E3xdx3ioCkkfd8/EdzYlbw1bySQ7NNyhr3KNvmrqv0f6FuUe3yNEWHLA6HqtGP16IyCp2OZhH57iV3c8g7eUdBVBefapQEgtpZcf06YbB+gODhq/ipGs8TEmhV8aQWZLCUgd+jhVWp7HoPoBBFUYAKx2ErdqTbrfHN6ugENCfcwv4qf+5z5+/0bQsRMcsJTU7zePk9TMzcUKcbdqXITGo8ceKq96MPSbzj+WPLUciY6Osv+CI+6wddziGvsRfVUFxyg5jEgZomDkkIS9Pq6RfGmQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3OFQAgxzKMl2/hNQOmfZLJMyciYtVh2h3xRGwpAkXzc=;
 b=RfvwcsZtXKVC9yNSufl0uGhsvc+ZkpEl9vGeab8otvk1s2yXngzFiKysZdaYHADUmrTSQm9YV0z67hDtJyP9fOAuMohhk/F0krVJCJsP8e4JMKkQr5DmfH50C0YOh4xae1fPpmI1L7HB59HpFWc969+QuZ0gQhN0JkgulROiEob+RvCPfnYOKqYvMQhL3BSquFycsyL8uts0JObt8RYUn74T1ttOa+xK9QgBfvwcT6mCTd1Kb6sbcnCRt6tiMjMSTT1xtAHvDJNyZGnmO6Ewsgz8jFK7n3nB40/6mmdc1TKLnBLPOiEfWptsJZNRv85slD8wOK3tVU71xufgLJN0EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3OFQAgxzKMl2/hNQOmfZLJMyciYtVh2h3xRGwpAkXzc=;
 b=giw3YxORu6ORClcpZ2kyGahagREXlLafpwJwE+Nz3K6aCaFzacKszr5vi5RKxEt8wtQEUYf47aY0q5zoUgKPBGMCVCfIgc994KufUcIeTPls1eVhAh0YRGbIZa1BX8UkndhTzE+EWNNu1qfRaDP+4LsRsZcMMgnlC6ymLQGUY3Y=
Received: from MN2PR02MB5935.namprd02.prod.outlook.com (20.179.86.87) by
 MN2PR02MB6333.namprd02.prod.outlook.com (52.132.173.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.24; Tue, 29 Oct 2019 10:07:19 +0000
Received: from MN2PR02MB5935.namprd02.prod.outlook.com
 ([fe80::f112:f0f9:7b15:74ed]) by MN2PR02MB5935.namprd02.prod.outlook.com
 ([fe80::f112:f0f9:7b15:74ed%6]) with mapi id 15.20.2387.027; Tue, 29 Oct 2019
 10:07:19 +0000
From: Sai Pavan Boddu <saipava@xilinx.com>
To: Francisco Iglesias <frasse.iglesias@gmail.com>
Subject: RE: [PATCH v5] ssi: xilinx_spips: Skip spi bus update for a few
 register writes
Thread-Topic: [PATCH v5] ssi: xilinx_spips: Skip spi bus update for a few
 register writes
Thread-Index: AQHVizaJS7lTJ/WsXEWclDEjOUkX3qdxaPAA
Date: Tue, 29 Oct 2019 10:07:19 +0000
Message-ID: <MN2PR02MB5935B0443A9AB09711949107CA610@MN2PR02MB5935.namprd02.prod.outlook.com>
References: <1571981531-27498-1-git-send-email-sai.pavan.boddu@xilinx.com>
 <20191025131713.pthu3ihbuhllzszd@fralle-msi>
In-Reply-To: <20191025131713.pthu3ihbuhllzszd@fralle-msi>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=saipava@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d06c236f-e256-425f-5507-08d75c57c89b
x-ms-traffictypediagnostic: MN2PR02MB6333:|MN2PR02MB6333:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR02MB633385A66AB775A27850A5A7CA610@MN2PR02MB6333.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:139;
x-forefront-prvs: 0205EDCD76
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(396003)(136003)(39850400004)(366004)(346002)(189003)(199004)(13464003)(66066001)(71200400001)(71190400001)(3846002)(6116002)(26005)(4326008)(14454004)(2906002)(52536014)(6506007)(478600001)(53546011)(102836004)(186003)(6916009)(66946007)(33656002)(7736002)(256004)(64756008)(9686003)(15650500001)(66446008)(66556008)(66476007)(81166006)(81156014)(7696005)(305945005)(76116006)(5660300002)(229853002)(99286004)(446003)(486006)(11346002)(74316002)(86362001)(54906003)(14444005)(6246003)(8936002)(76176011)(476003)(6436002)(25786009)(55016002)(316002)(8676002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR02MB6333;
 H:MN2PR02MB5935.namprd02.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: taAjdBL3lULQ8Ut/V3duf7vXt0+TBjY+MMxAAP3JX9GUYVaCi8nX+LWLvG5X6zfYs3yYrSl0b1iSVqB4ZAiAkxx+c3TjIxnuY7tTIDBFrLNzIlaSjdmSULUc1nrUsQ6fimnBLXe6mryxJRen6fbUaGsLmCpsvLeOhdpdMjnCjOePp7gwUxHMMauPo9s69BltZIWJ9Uz3Rqisj7tz10cEBLk0mDZnZg8drRfasS83Pq+ITKfcnpdNHJ3AwVRVOmoFQJxGeB/9CyDEdCBfYvjYedKBaVSPRv19MX0xRyiut3abkqYkf0xkKQF0c/18IZ2UXUpzO/Br3/JgTdAH/+/SdkImUVaTipUh+K71oI7G991Yh4ww72V7XRo1e5Uz9b81KopAjIrBX32+9Jb11plZeL6FIcoKvleQ/AnGe2hjEbQLvNphNmNqgJGlPcuFcs/R
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d06c236f-e256-425f-5507-08d75c57c89b
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2019 10:07:19.1439 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SIrn3QGgBmm/tjG92ccfl3ucwtNFqoV2EH8BVcz4aMwUlXa1dqeRNY99znYN0Ahz9xILTJlmIRzikMzYALsjeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6333
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.69.53
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
 Edgar Iglesias <edgari@xilinx.com>, Alistair Francis <alistair@alistair23.me>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Thanks Francisco & Alistair for review.
I have sent V6 with Review tags and commit message fix.

Regards,
Sai Pavan

> -----Original Message-----
> From: Francisco Iglesias <frasse.iglesias@gmail.com>
> Sent: Friday, October 25, 2019 6:47 PM
> To: Sai Pavan Boddu <saipava@xilinx.com>
> Cc: Alistair Francis <alistair@alistair23.me>; Peter Maydell
> <peter.maydell@linaro.org>; Edgar Iglesias <edgari@xilinx.com>; qemu-
> devel@nongnu.org
> Subject: Re: [PATCH v5] ssi: xilinx_spips: Skip spi bus update for a few =
register
> writes
>=20
> Hi Sai,
>=20
> On [2019 Oct 25] Fri 11:02:11, Sai Pavan Boddu wrote:
> > A few configuration register writes need not update the spi bus state,
> > so just return after register write.
>=20
> s/register write/the register write/
>=20
> >
> > Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
>=20
> After above change:
>=20
> Reviewed-by: Francisco Iglesias <frasse.iglesias@gmail.com>
> Tested-by: Francisco Iglesias <frasse.iglesias@gmail.com>
>=20
> Best regards,
> Francisco Iglesias
>=20
> > ---
> >
> > Changes for V2:
> > 	Just skip update of spips cs and fifos
> > 	Update commit message accordingly
> > Changes for V4:
> > 	Avoid checking for zynqmp qspi
> > 	Skip spi bus update for few of the registers Changes for V4:
> > 	Move the register list to existing switch case above.
> > Change for V5:
> > 	Fixed Commit message.
> >
> >  hw/ssi/xilinx_spips.c | 22 ++++++++++++++++++----
> >  1 file changed, 18 insertions(+), 4 deletions(-)
> >
> > diff --git a/hw/ssi/xilinx_spips.c b/hw/ssi/xilinx_spips.c index
> > a309c71..0d6c2e1 100644
> > --- a/hw/ssi/xilinx_spips.c
> > +++ b/hw/ssi/xilinx_spips.c
> > @@ -109,6 +109,7 @@
> >  #define R_GPIO              (0x30 / 4)
> >  #define R_LPBK_DLY_ADJ      (0x38 / 4)
> >  #define R_LPBK_DLY_ADJ_RESET (0x33)
> > +#define R_IOU_TAPDLY_BYPASS (0x3C / 4)
> >  #define R_TXD1              (0x80 / 4)
> >  #define R_TXD2              (0x84 / 4)
> >  #define R_TXD3              (0x88 / 4)
> > @@ -139,6 +140,8 @@
> >  #define R_LQSPI_STS         (0xA4 / 4)
> >  #define LQSPI_STS_WR_RECVD      (1 << 1)
> >
> > +#define R_DUMMY_CYCLE_EN    (0xC8 / 4)
> > +#define R_ECO               (0xF8 / 4)
> >  #define R_MOD_ID            (0xFC / 4)
> >
> >  #define R_GQSPI_SELECT          (0x144 / 4)
> > @@ -970,6 +973,7 @@ static void xilinx_spips_write(void *opaque,
> > hwaddr addr,  {
> >      int mask =3D ~0;
> >      XilinxSPIPS *s =3D opaque;
> > +    bool try_flush =3D true;
> >
> >      DB_PRINT_L(0, "addr=3D" TARGET_FMT_plx " =3D %x\n", addr,
> (unsigned)value);
> >      addr >>=3D 2;
> > @@ -1019,13 +1023,23 @@ static void xilinx_spips_write(void *opaque,
> hwaddr addr,
> >          tx_data_bytes(&s->tx_fifo, (uint32_t)value, 3,
> >                        s->regs[R_CONFIG] & R_CONFIG_ENDIAN);
> >          goto no_reg_update;
> > +    /* Skip SPI bus update for below registers writes */
> > +    case R_GPIO:
> > +    case R_LPBK_DLY_ADJ:
> > +    case R_IOU_TAPDLY_BYPASS:
> > +    case R_DUMMY_CYCLE_EN:
> > +    case R_ECO:
> > +        try_flush =3D false;
> > +        break;
> >      }
> >      s->regs[addr] =3D (s->regs[addr] & ~mask) | (value & mask);
> >  no_reg_update:
> > -    xilinx_spips_update_cs_lines(s);
> > -    xilinx_spips_check_flush(s);
> > -    xilinx_spips_update_cs_lines(s);
> > -    xilinx_spips_update_ixr(s);
> > +    if (try_flush) {
> > +        xilinx_spips_update_cs_lines(s);
> > +        xilinx_spips_check_flush(s);
> > +        xilinx_spips_update_cs_lines(s);
> > +        xilinx_spips_update_ixr(s);
> > +    }
> >  }
> >
> >  static const MemoryRegionOps spips_ops =3D {
> > --
> > 2.7.4
> >

