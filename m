Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDDDDC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 16:05:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC1D42074F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 16:05:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="LbvGwbls";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="yt5njOUT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC1D42074F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34704 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqIlM-0007si-92
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 12:05:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50598)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=44341d4e9=Niklas.Cassel@wdc.com>)
 id 1jqIkA-0006tv-Lf; Tue, 30 Jun 2020 12:04:23 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:37698)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=44341d4e9=Niklas.Cassel@wdc.com>)
 id 1jqIk7-0000bP-Ha; Tue, 30 Jun 2020 12:04:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1593533064; x=1625069064;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=/2hfv3Z7KsxzmXTVne1d2tM8/uOuoD+JZJ5n4z/oc4Y=;
 b=LbvGwblsLOaAToGgO9rd3xuhHPCd+1cWl4L9Um5HUK2VuutHTiQ0bQzk
 rr60ubXISZPq4RA5naN2/HEnQTnohCSAUtnc17sWjgJfAD3oJBj9Ynq67
 cx22y3pwYGtbWugzDF/IONhwywGVWM30e8yGxSNfeGTXZnrYRrlo8ZPm+
 Wo9cg+K7D8N+TnBFRv2VAOyHgeV0/7c9kkkzc3AhoYHWNV0/boVhbJOWW
 89Q0Ai5kUO1nvNKkfaLoC5MAOZX4b8wKcwwXeJiKwFycZLeRaLdKi1J4Q
 bumsGj2hS/6Uy0NhNaRFaX70NjU5ndB66iLblZKMJhwyoJDu30xub8wj3 Q==;
IronPort-SDR: AZ1mUQXLcBb4JzL2hpU95ULgMVp9/QSLYZ0xHxNRAemGthweAJfvatYSRJ/BcbT5ieRxZkPO1c
 HLVw3ChXWmsVSJqMbpIayqLn6+zBUYsFkYPqXWBu8Hk7gpfsWxccgnnEf2Y31+8dAJE9j84SGi
 xDsMjEvm24AoJLOIBcri9t0/e5vILJhTROE93HrUokS/ogzrS7jZ43sBX/voKWuXIJBQ3vx0Bz
 G/UU87vicoVV/qw6rMatC3whWxsHrcfnogiAjFfchcAUUtPlV8fpL6OLGoCf4Dwvo0XJC+6060
 KuI=
X-IronPort-AV: E=Sophos;i="5.75,297,1589212800"; d="scan'208";a="244314653"
Received: from mail-dm6nam12lp2176.outbound.protection.outlook.com (HELO
 NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.176])
 by ob1.hgst.iphmx.com with ESMTP; 01 Jul 2020 00:04:17 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mjvn2XMF6Wioz6gx9BaRqXKL3Uk3LsA/1Ce2KtnHRFgU5vbiylLGtejjE9j7Uns0D+Uw+kfis164ZLfUY5ZjRSvJ8p5XePUgeGpsPPnsEbMw0Td63SvOiPJbsHRWyRtQgRYH1A3G18/B9Mezd5D4xv9vO+qxENaSSJ0Clm4v0EbWdV8wnSvuPowIcPyqK8pkbYvIUoig2lRTIqh2fixOzB/JgZoYZpLtntzN51ZAhRN49VWJ22mXmEQu5lHqrgW3D2SWM8FIVWA216VEgTDUwoMKwxQGtfS8bCInjurcFQ/YMtHYBpTkuwIYTu9Kpi4F5+vL32HyLda/FW/RLbLFVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KMbmulMV2qBchI9aLo+jkqljCxfpT8Kh+620d8JFmv8=;
 b=GJ+Ai4NaKvxdVNHGlr9nWoWpLwk0krSNsHp4QdCKtybo8asccFKMAe5SeF/GMxBiWNWkiTwmOfX3yXz0ObkaCGE2SgjBkQJbBUrcmpGWlcJUTt7dGDZOj4eZdKNGqhIedZowOjhbp04SZiZpbfW0vFWR04qWCUq+wZVYxcF4H8FhELxGMbGCbzvSFSPNH7NZMawR8c2YSqvol5sXmT/fXlFuPTh2KZU/yOOMRfiYBXN7gLX+jBBPwTeEqPx6aVHx2uS4CZn+iKjzyo+Hip8xd7betbV/ImXvuSRW39YFdz0YH8cbLEqR1+emcinKcLWJIupr0hXPb8ZE2n84rcDYCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KMbmulMV2qBchI9aLo+jkqljCxfpT8Kh+620d8JFmv8=;
 b=yt5njOUTJeUf9NZ2C/Yp/ZUoG8Q68BntRddowU/IbtveaGe0GlWf6yxx+Z+2DYlVLj+MIKHtmGoS8K6ul3y9LGFD9aKbResVrMgZNuf40fNb5aTbOayq77ZFoZF2SlgVI1n4cxYpxdIxs+IXEp7n+geybMj1DJvZ4SS68kKhTmk=
Received: from BYAPR04MB5112.namprd04.prod.outlook.com (2603:10b6:a03:45::10)
 by BYAPR04MB4598.namprd04.prod.outlook.com (2603:10b6:a03:55::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.20; Tue, 30 Jun
 2020 16:04:13 +0000
Received: from BYAPR04MB5112.namprd04.prod.outlook.com
 ([fe80::a442:4836:baba:c84b]) by BYAPR04MB5112.namprd04.prod.outlook.com
 ([fe80::a442:4836:baba:c84b%6]) with mapi id 15.20.3131.027; Tue, 30 Jun 2020
 16:04:13 +0000
From: Niklas Cassel <Niklas.Cassel@wdc.com>
To: Klaus Jensen <its@irrelevant.dk>
Subject: Re: [PATCH v2 05/18] hw/block/nvme: Introduce the Namespace Types
 definitions
Thread-Topic: [PATCH v2 05/18] hw/block/nvme: Introduce the Namespace Types
 definitions
Thread-Index: AQHWRO8bQ1sdANlR30yceHLn7+/Joqjwq/sAgAC6VoA=
Date: Tue, 30 Jun 2020 16:04:13 +0000
Message-ID: <20200630160411.GA565456@localhost.localdomain>
References: <20200617213415.22417-1-dmitry.fomichev@wdc.com>
 <20200617213415.22417-6-dmitry.fomichev@wdc.com>
 <20200630045716.btz2mxxmtzs4k27v@apples.localdomain>
In-Reply-To: <20200630045716.btz2mxxmtzs4k27v@apples.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: irrelevant.dk; dkim=none (message not signed)
 header.d=none;irrelevant.dk; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [85.224.200.150]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2497307c-a366-4f2a-7539-08d81d0f3b8c
x-ms-traffictypediagnostic: BYAPR04MB4598:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB459870790A714A258B6D26D2F26F0@BYAPR04MB4598.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 0450A714CB
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: S8CG1EQhtXJs7/ARsA8s2DQTJzThw4eMeKyeTs/dc1Qy/pvuvQTiINrEjJMJ4wEEZUA4txH589gWcb61YaVh9fpBO03IOUKa11TcarW8uq0vQzTHYuGIx1mVsMMXOOA8GhDhLcKkWTN4v4vLvkudBGpQ0OpYVn2uiQqY6E7JxI5pXzL9dnNj0sMYDdpuLRCd7y74zztWaSbKkB3nrnpVWC2ZVY933MxCledvretD+KJpAODzXBmtm/Z7YuvA8ET5stdXqnNtG2fzZpcAFCAfSWMpmsYa0nLV6ZJE7ST6pgAzeu/L+JHkS1fF67ZV2mA86utyttBeqdm5C5QXy3Fm5g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB5112.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(136003)(366004)(396003)(376002)(346002)(71200400001)(5660300002)(1076003)(54906003)(76116006)(6512007)(83380400001)(66446008)(64756008)(66556008)(66476007)(9686003)(91956017)(316002)(33656002)(66946007)(86362001)(6506007)(6916009)(6486002)(2906002)(478600001)(8676002)(4326008)(8936002)(26005)(186003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: otMQaHGoDr5KKMBbwo0BN3PAPLuem+OJ0470jEYOIqEvREtQlLKKiSM1O3XwtsNPQhfa0An3OJaKC9SVeoJuI07/SFb7nMndplF4IaDo0Z4SgB6YnBv+rJyA1JfSHuTu6NOx2jqIjVjhioAT/S8z1UX40PMOcM2nYSWcz9uDOZEFxOlxAgDrQeQvfGoqpL6VCwKrc6ROAHaGGvK+PZkNweTxDlQtw/NIPnFv3POd9FEuU2rKRVI8HsRnfX+ES551SmEUGJGx8osqBiU3wqkeLiWD1CFvet4/u2A93sgyS612Y38AwZhOFp4bzUCMalFYcJSd0HXe4GhZ2Gwq9Imryj+jmKGK8rib56r3pjOk7FLoH189NFu4Us2TR1yDOkKGXxHlgWgAh+XSjGA+CHuUwMkcFExzRhIzczjjpYr09BwOGxbbTwpghyoJ4Ks/yZ6FgHyBxoeaTsQZjNVLPAhPkFmsvUSuMD0kshnhN3YKy3nBFeuTjd0ycxxkW9wZso7E
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <B3D8BE06EBB63F40AF8428AEEB3DBD92@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB5112.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2497307c-a366-4f2a-7539-08d81d0f3b8c
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2020 16:04:13.2221 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RcOp/+IFD+ypUjRyOk8q3E6vU3WZlxIWGv1sy6P373dhAiEHATScN0dE7dGGPvi4OAgZr8raToaCxIgkLEA78g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4598
Received-SPF: pass client-ip=68.232.143.124;
 envelope-from=prvs=44341d4e9=Niklas.Cassel@wdc.com; helo=esa2.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 12:04:15
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Damien Le Moal <Damien.LeMoal@wdc.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 Dmitry Fomichev <Dmitry.Fomichev@wdc.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Keith Busch <kbusch@kernel.org>,
 =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>,
 Maxim Levitsky <mlevitsky@redhat.com>,
 Matias Bjorling <Matias.Bjorling@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jun 30, 2020 at 06:57:16AM +0200, Klaus Jensen wrote:
> On Jun 18 06:34, Dmitry Fomichev wrote:
> > From: Niklas Cassel <niklas.cassel@wdc.com>
> >=20
> > Define the structures and constants required to implement
> > Namespace Types support.
> >=20
> > Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
> > Signed-off-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
> > ---
> >  hw/block/nvme.h      |  3 ++
> >  include/block/nvme.h | 75 +++++++++++++++++++++++++++++++++++++++++---
> >  2 files changed, 73 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/hw/block/nvme.h b/hw/block/nvme.h
> > index 4f0dac39ae..4fd155c409 100644
> > --- a/hw/block/nvme.h
> > +++ b/hw/block/nvme.h
> > @@ -63,6 +63,9 @@ typedef struct NvmeCQueue {
> > =20
> >  typedef struct NvmeNamespace {
> >      NvmeIdNs        id_ns;
> > +    uint32_t        nsid;
> > +    uint8_t         csi;
> > +    QemuUUID        uuid;
> >  } NvmeNamespace;
> > =20
> >  static inline NvmeLBAF *nvme_ns_lbaf(NvmeNamespace *ns)
> > diff --git a/include/block/nvme.h b/include/block/nvme.h
> > index 6a58bac0c2..5a1e5e137c 100644
> > --- a/include/block/nvme.h
> > +++ b/include/block/nvme.h
> > @@ -50,6 +50,11 @@ enum NvmeCapMask {
> >      CAP_PMR_MASK       =3D 0x1,
> >  };
> > =20
> > +enum NvmeCapCssBits {
> > +    CAP_CSS_NVM        =3D 0x01,
> > +    CAP_CSS_CSI_SUPP   =3D 0x40,
> > +};
> > +
> >  #define NVME_CAP_MQES(cap)  (((cap) >> CAP_MQES_SHIFT)   & CAP_MQES_MA=
SK)
> >  #define NVME_CAP_CQR(cap)   (((cap) >> CAP_CQR_SHIFT)    & CAP_CQR_MAS=
K)
> >  #define NVME_CAP_AMS(cap)   (((cap) >> CAP_AMS_SHIFT)    & CAP_AMS_MAS=
K)
> > @@ -101,6 +106,12 @@ enum NvmeCcMask {
> >      CC_IOCQES_MASK  =3D 0xf,
> >  };
> > =20
> > +enum NvmeCcCss {
> > +    CSS_NVM_ONLY        =3D 0,
> > +    CSS_ALL_NSTYPES     =3D 6,
>=20
> Maybe we could call this CSS_CSI, since it just specifies that one or
> more command sets are supported, not that ALL namespace types are
> supported.

The enum name here is CcCss, so this represents CC.CSS,
which specifies which Command Sets to enable,
not which Command Sets that are supported.

(Supported Command Sets are defined by CAP.CSS and the
I/O Command Set data structure.)

So it indeed says to enable ALL command sets supported by the
controller. (Although for the CSI case, you need to check the
I/O Command Set data structure to know what is actually supported.)


However, I agree, the name CSS_ALL_NSTYPES is a bit misleading.
ALL_SUPPORTED_CSI would have been a more precise name.
However, simply naming it CSS_CSI, like you suggest, is more intuitive,
and is what we use in the Linux kernel patches, so let's use that :)


Kind regards,
Niklas

>=20
> Otherwise,
> Reviewed-by: Klaus Jensen <k.jensen@samsung.com>
>=20
> > +    CSS_ADMIN_ONLY      =3D 7,
> > +};
> > +
> >  #define NVME_CC_EN(cc)     ((cc >> CC_EN_SHIFT)     & CC_EN_MASK)
> >  #define NVME_CC_CSS(cc)    ((cc >> CC_CSS_SHIFT)    & CC_CSS_MASK)
> >  #define NVME_CC_MPS(cc)    ((cc >> CC_MPS_SHIFT)    & CC_MPS_MASK)
> > @@ -109,6 +120,21 @@ enum NvmeCcMask {
> >  #define NVME_CC_IOSQES(cc) ((cc >> CC_IOSQES_SHIFT) & CC_IOSQES_MASK)
> >  #define NVME_CC_IOCQES(cc) ((cc >> CC_IOCQES_SHIFT) & CC_IOCQES_MASK)
> > =20
> > +#define NVME_SET_CC_EN(cc, val)     \
> > +    (cc |=3D (uint32_t)((val) & CC_EN_MASK) << CC_EN_SHIFT)
> > +#define NVME_SET_CC_CSS(cc, val)    \
> > +    (cc |=3D (uint32_t)((val) & CC_CSS_MASK) << CC_CSS_SHIFT)
> > +#define NVME_SET_CC_MPS(cc, val)    \
> > +    (cc |=3D (uint32_t)((val) & CC_MPS_MASK) << CC_MPS_SHIFT)
> > +#define NVME_SET_CC_AMS(cc, val)    \
> > +    (cc |=3D (uint32_t)((val) & CC_AMS_MASK) << CC_AMS_SHIFT)
> > +#define NVME_SET_CC_SHN(cc, val)    \
> > +    (cc |=3D (uint32_t)((val) & CC_SHN_MASK) << CC_SHN_SHIFT)
> > +#define NVME_SET_CC_IOSQES(cc, val) \
> > +    (cc |=3D (uint32_t)((val) & CC_IOSQES_MASK) << CC_IOSQES_SHIFT)
> > +#define NVME_SET_CC_IOCQES(cc, val) \
> > +    (cc |=3D (uint32_t)((val) & CC_IOCQES_MASK) << CC_IOCQES_SHIFT)
> > +
> >  enum NvmeCstsShift {
> >      CSTS_RDY_SHIFT      =3D 0,
> >      CSTS_CFS_SHIFT      =3D 1,
> > @@ -482,10 +508,41 @@ typedef struct NvmeIdentify {
> >      uint64_t    rsvd2[2];
> >      uint64_t    prp1;
> >      uint64_t    prp2;
> > -    uint32_t    cns;
> > -    uint32_t    rsvd11[5];
> > +    uint8_t     cns;
> > +    uint8_t     rsvd4;
> > +    uint16_t    ctrlid;
> > +    uint16_t    nvmsetid;
> > +    uint8_t     rsvd3;
> > +    uint8_t     csi;
> > +    uint32_t    rsvd12[4];
> >  } NvmeIdentify;
> > =20
> > +typedef struct NvmeNsIdDesc {
> > +    uint8_t     nidt;
> > +    uint8_t     nidl;
> > +    uint16_t    rsvd2;
> > +} NvmeNsIdDesc;
> > +
> > +enum NvmeNidType {
> > +    NVME_NIDT_EUI64             =3D 0x01,
> > +    NVME_NIDT_NGUID             =3D 0x02,
> > +    NVME_NIDT_UUID              =3D 0x03,
> > +    NVME_NIDT_CSI               =3D 0x04,
> > +};
> > +
> > +enum NvmeNidLength {
> > +    NVME_NIDL_EUI64             =3D 8,
> > +    NVME_NIDL_NGUID             =3D 16,
> > +    NVME_NIDL_UUID              =3D 16,
> > +    NVME_NIDL_CSI               =3D 1,
> > +};
> > +
> > +enum NvmeCsi {
> > +    NVME_CSI_NVM                =3D 0x00,
> > +};
> > +
> > +#define NVME_SET_CSI(vec, csi) (vec |=3D (uint8_t)(1 << (csi)))
> > +
> >  typedef struct NvmeRwCmd {
> >      uint8_t     opcode;
> >      uint8_t     flags;
> > @@ -603,6 +660,7 @@ enum NvmeStatusCodes {
> >      NVME_CMD_ABORT_MISSING_FUSE =3D 0x000a,
> >      NVME_INVALID_NSID           =3D 0x000b,
> >      NVME_CMD_SEQ_ERROR          =3D 0x000c,
> > +    NVME_CMD_SET_CMB_REJECTED   =3D 0x002b,
> >      NVME_LBA_RANGE              =3D 0x0080,
> >      NVME_CAP_EXCEEDED           =3D 0x0081,
> >      NVME_NS_NOT_READY           =3D 0x0082,
> > @@ -729,9 +787,14 @@ typedef struct NvmePSD {
> >  #define NVME_IDENTIFY_DATA_SIZE 4096
> > =20
> >  enum {
> > -    NVME_ID_CNS_NS             =3D 0x0,
> > -    NVME_ID_CNS_CTRL           =3D 0x1,
> > -    NVME_ID_CNS_NS_ACTIVE_LIST =3D 0x2,
> > +    NVME_ID_CNS_NS                =3D 0x0,
> > +    NVME_ID_CNS_CTRL              =3D 0x1,
> > +    NVME_ID_CNS_NS_ACTIVE_LIST    =3D 0x2,
> > +    NVME_ID_CNS_NS_DESC_LIST      =3D 0x03,
> > +    NVME_ID_CNS_CS_NS             =3D 0x05,
> > +    NVME_ID_CNS_CS_CTRL           =3D 0x06,
> > +    NVME_ID_CNS_CS_NS_ACTIVE_LIST =3D 0x07,
> > +    NVME_ID_CNS_IO_COMMAND_SET    =3D 0x1c,
> >  };
> > =20
> >  typedef struct NvmeIdCtrl {
> > @@ -825,6 +888,7 @@ enum NvmeFeatureIds {
> >      NVME_WRITE_ATOMICITY            =3D 0xa,
> >      NVME_ASYNCHRONOUS_EVENT_CONF    =3D 0xb,
> >      NVME_TIMESTAMP                  =3D 0xe,
> > +    NVME_COMMAND_SET_PROFILE        =3D 0x19,
> >      NVME_SOFTWARE_PROGRESS_MARKER   =3D 0x80
> >  };
> > =20
> > @@ -914,6 +978,7 @@ static inline void _nvme_check_size(void)
> >      QEMU_BUILD_BUG_ON(sizeof(NvmeFwSlotInfoLog) !=3D 512);
> >      QEMU_BUILD_BUG_ON(sizeof(NvmeSmartLog) !=3D 512);
> >      QEMU_BUILD_BUG_ON(sizeof(NvmeIdCtrl) !=3D 4096);
> > +    QEMU_BUILD_BUG_ON(sizeof(NvmeNsIdDesc) !=3D 4);
> >      QEMU_BUILD_BUG_ON(sizeof(NvmeIdNs) !=3D 4096);
> >      QEMU_BUILD_BUG_ON(sizeof(NvmeEffectsLog) !=3D 4096);
> >  }
> > --=20
> > 2.21.0
> >=20
> > =

