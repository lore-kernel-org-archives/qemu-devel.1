Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7626CA9EA1
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 08:38:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2760222BD
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 08:38:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="p0GPZw+R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2760222BD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36662 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLNmQ-0006Uz-UR
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 04:38:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40232)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <saipava@xilinx.com>) id 1iLNlh-00061i-0w
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 04:37:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <saipava@xilinx.com>) id 1iLNld-0003s4-Rq
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 04:37:52 -0400
Received: from mail-eopbgr770053.outbound.protection.outlook.com
 ([40.107.77.53]:49473 helo=NAM02-SN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <saipava@xilinx.com>) id 1iLNld-0003qn-GQ
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 04:37:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KZNCBGtsZYTCiTKw02KcYRy22cn+bp/WuIRZGC0cbICHu1GmY3elPi4MwXDp5aRN9fnijsVZXH0ZeLJYYiLAE9Ryb7T4yLrOc5PfbBvDQfq1Vn/TGVnifWJl2vFXJ6TPTvow5M0bhz3jQlMfTytGms8KqdTMJEcp0M1tgGpnG0yzqh8uKwPLXA1GZSDr8PW93OZTy7DRwR6ukoW1kl4c+e6wFzVunSkrlWJnunXcRkSi2mZna7rjAjbD88nERJo2uXPgJQF8gcbuPmJuqO8JoAIVYHiHkIHyWO4c8c7aLt6zVPuaRXDT9MjKuEtXJ76YqkHL4OL3oNHZWBTOz2tFIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JIrMh4nvgU7O9l8OD/AsF9CC1/VqRuRmxaF2x4XBdZQ=;
 b=iCcqbKjkHS2eypJS6kldzXAMh+y3GNCj80s3UGiQ8/5yTsEDq2sxNu/Am9w5ingCa17BNJ7RUgHxP4MZvBvuk+c+sA0Rtbh8fwQi1rij3XaCtqjPnMAGvGf/qZIQcsViCbW/zQU2d0mXD0ucINV5z5W1AMmcrVqYbKl7Cti8EctLjd+rYsTudJ9MVciVySomzKmShN4nq6ZYTHC9HPgJTXBaVj5GurDRXbgIFGFyIzVT1OrMbpv+eFnQc/R3vQFFMbE+qAHI7VN89kxHldfxuqjc94YqCxUbG99KqAvy5kb55bqiKojHMBslZf4EONUPwwAFH/0jWnijn+nTl6gPQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JIrMh4nvgU7O9l8OD/AsF9CC1/VqRuRmxaF2x4XBdZQ=;
 b=p0GPZw+R4Zq6j9uzhqivTae/lMFvKe1WWatDuzSg5hXtafuds+aVfbTxTyQGszYiwisA+9z4fSpvs4tlm5D0NxGc7f35GoCV8hZ9GCeZZ0NOqCel4B/t+jkcAsNAwI+ue+B4dUY9dfeQe/sELJSWZbuhHKQD/0pnFOj+9ui3HvY=
Received: from MN2PR02MB5935.namprd02.prod.outlook.com (20.179.86.87) by
 MN2PR02MB5902.namprd02.prod.outlook.com (20.179.86.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2367.20; Fri, 18 Oct 2019 08:37:47 +0000
Received: from MN2PR02MB5935.namprd02.prod.outlook.com
 ([fe80::512c:df91:18db:e74b]) by MN2PR02MB5935.namprd02.prod.outlook.com
 ([fe80::512c:df91:18db:e74b%4]) with mapi id 15.20.2347.023; Fri, 18 Oct 2019
 08:37:46 +0000
From: Sai Pavan Boddu <saipava@xilinx.com>
To: Francisco Iglesias <frasse.iglesias@gmail.com>
Subject: RE: [QEMU][PATCH v2] ssi: xilinx_spips: Skip update of cs and fifo
 releated to spips in gqspi
Thread-Topic: [QEMU][PATCH v2] ssi: xilinx_spips: Skip update of cs and fifo
 releated to spips in gqspi
Thread-Index: AQHVhO+0G/MsAYSWEEKVZR10+0zesadgFITA
Date: Fri, 18 Oct 2019 08:37:46 +0000
Message-ID: <MN2PR02MB5935035FD95D94F8A14F24FACA6C0@MN2PR02MB5935.namprd02.prod.outlook.com>
References: <1571307474-16222-1-git-send-email-sai.pavan.boddu@xilinx.com>
 <20191017133513.ul436a65y5m2vvrm@fralle-msi>
In-Reply-To: <20191017133513.ul436a65y5m2vvrm@fralle-msi>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=saipava@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 859e64d2-1958-41f5-fb68-08d753a673d2
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: MN2PR02MB5902:|MN2PR02MB5902:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR02MB5902C5DE9B1528634051B3CBCA6C0@MN2PR02MB5902.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-forefront-prvs: 01949FE337
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(346002)(376002)(396003)(366004)(39860400002)(199004)(189003)(13464003)(6506007)(53546011)(99286004)(186003)(5660300002)(76176011)(52536014)(26005)(102836004)(71200400001)(74316002)(71190400001)(256004)(55016002)(14444005)(7696005)(11346002)(66946007)(446003)(25786009)(86362001)(66476007)(6916009)(486006)(476003)(81166006)(81156014)(9686003)(76116006)(64756008)(66446008)(66556008)(15650500001)(54906003)(3846002)(478600001)(316002)(66066001)(305945005)(7736002)(4326008)(2906002)(14454004)(6116002)(6246003)(33656002)(229853002)(6436002)(8936002)(8676002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR02MB5902;
 H:MN2PR02MB5935.namprd02.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bMyQjsgZm8eKsYBik8ZeMeZB4KMGdy/hlLVvO07NfTfDI7Oaa6zS3dkvgDZy6q90NCnllXP435owUD1mA8ztCAqi9ewAvYxbASuRTnFMrX67RGAW3E10QMe1c/5HwJTHP+Esyjqtgkw2gw53rb/ns2CWD3B01iomS3BRLuUCdg0P+7UyLv+CjIvHHr3h8bsO/W+gtHfu1Awyk+PtEjHCpQLxMlbiWD6zXARP8NUtamKs1sF6qv04jfTObRlsaRvl34p7FHxiIcLdoyqgPI1YrCQvCqW+MCPREADuzX+/x/9MzFuD1PEq4koV1YgXBmkC/LXFT2fz/27V3ORQaI683JbtRcdvDM6MSChVVpRrNVUBh9YlUhprCxFzUOsGz4d4zu2N7+gYuZ9ttU9pprKWiuIAJ/o0G8mL2VX5zyqK3Ounqf/Sg7/EYbFelDijCPay
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 859e64d2-1958-41f5-fb68-08d753a673d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2019 08:37:46.7788 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YBW2/d+uDhE+zXIFb8J9CmVWZyzNvnaPeGcnm3YivGPHjjuidvFPHicaaxHXiIXn8OyeGiKlQXVly/oTvYYRDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB5902
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.77.53
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

Hi Francisco,

Thanks I will send a V3 following your suggestion.

Regards,
Sai Pavan

> -----Original Message-----
> From: Francisco Iglesias <frasse.iglesias@gmail.com>
> Sent: Thursday, October 17, 2019 7:05 PM
> To: Sai Pavan Boddu <saipava@xilinx.com>
> Cc: Alistair Francis <alistair@alistair23.me>; Edgar Iglesias
> <edgari@xilinx.com>; Peter Maydell <peter.maydell@linaro.org>; qemu-
> devel@nongnu.org
> Subject: Re: [QEMU][PATCH v2] ssi: xilinx_spips: Skip update of cs and fi=
fo
> releated to spips in gqspi
>=20
> Hi Sai,
>=20
> On [2019 Oct 17] Thu 15:47:54, Sai Pavan Boddu wrote:
> > GQSPI handles chip selects and fifos in a different way compared to
> > spips. So skip update of cs and fifos related to spips in gqspi mode.
> >
> > Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
> > ---
> > Changes for V2:
> >     Just skip update of spips cs and fifos
> >     Update commit message accordingly
> >
> >  hw/ssi/xilinx_spips.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/hw/ssi/xilinx_spips.c b/hw/ssi/xilinx_spips.c index
> > a309c71..27154b0 100644
> > --- a/hw/ssi/xilinx_spips.c
> > +++ b/hw/ssi/xilinx_spips.c
> > @@ -1022,6 +1022,13 @@ static void xilinx_spips_write(void *opaque,
> hwaddr addr,
> >      }
> >      s->regs[addr] =3D (s->regs[addr] & ~mask) | (value & mask);
> >  no_reg_update:
> > +    /* In GQSPI mode skip update of CS and fifo's related to spips */
> > +    if (object_dynamic_cast(OBJECT(s), TYPE_XLNX_ZYNQMP_QSPIPS)) {
> > +        XlnxZynqMPQSPIPS *ss =3D XLNX_ZYNQMP_QSPIPS(s);
> > +        if (ARRAY_FIELD_EX32(ss->regs, GQSPI_SELECT, GENERIC_QSPI_EN))
> {
> > +            return;
> > +        }
> > +    }
>=20
> Above corrects the issue for the zynqmp but not for the other two models
> (below functions shouldn't be called when writing the mentioned config re=
gs
> for them either), would it be ok for you to expand to the switch cases yo=
u
> had in v1 (into the switch in this function and return after updating the=
 reg
> values)? (the correction will then spawn all three
> models)
>=20
> Best regards,
> Francisco Iglesias
>=20
> >      xilinx_spips_update_cs_lines(s);
> >      xilinx_spips_check_flush(s);
> >      xilinx_spips_update_cs_lines(s);
> > --
> > 2.7.4
> >
> >

