Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D2E5C2D0A3
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 23:10:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 197332078B
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 23:09:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="FvuFNdRp";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ZQFagura"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 197332078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47242 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kbArm-0007FQ-4P
	for qemu-devel@archiver.kernel.org; Fri, 06 Nov 2020 18:09:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53924)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=572b21b8d=Dmitry.Fomichev@wdc.com>)
 id 1kbAps-0004JM-4R; Fri, 06 Nov 2020 18:08:00 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:59197)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=572b21b8d=Dmitry.Fomichev@wdc.com>)
 id 1kbApo-0006qa-I3; Fri, 06 Nov 2020 18:07:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1604704076; x=1636240076;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=y5nwMFxr+6TpbPzU1ELHCWzRoanCpWpH6lzv+te2YHQ=;
 b=FvuFNdRppXGjaOlCra/dR14E+jOg81QqGOGM+rDsOMDD0/U2SOPBzjLV
 /JSkShKQkVKqPnFWZcKsByTV+fdxsW1l1yxwkVRgDiXtW3YqX/YZBIF8x
 LPl8kB7+xT1Y1DunhoZi/FuzJmnorMFihyGjenhi/PuGmQZs8M0eUtcx0
 KxtzSMmhYWPcz8QvoOsZzSaEGuXZhS5BD2Eli0Qc++b//KewP3Ev/6CGP
 tWQcOULyk2DaFwvt9KAsHBcwvAfE4tTMn9GCWPI+yYX1qTtOHZSlGjRHJ
 5wAUn5/lr1T4es1F4LmIFJRyOzL8vWXBxLfxwjPgKWeNp3iqE3CALOv0G w==;
IronPort-SDR: oSRCGRwzsT7Y9O3+HXtuzclwDkGMdhzJzedqRJWnyx8rU6gqQdJtagEWPSj5BoqVnkQjgRtrkp
 3B0iLzXrNKq09ZR/SDR8nIg2IK58A9mj/rp2SKdJUkLZzrIOY59ldQR73zJE+sVUSQXLb+U8uN
 cRmISb2HYgRALr2QGEKAXESlOvzOmK77X8KHS/4HKJ0hVnxBXJ/3lT9XbwSYpegvKuYrI6Cp2J
 a5waIEvWI14p3aimqBVXjAloGYkMAhmkVNKIJ4+3Iw9dIRyFXMyILNw6/ZpqmO2aws5bzX+FVb
 8QI=
X-IronPort-AV: E=Sophos;i="5.77,457,1596470400"; d="scan'208";a="156545901"
Received: from mail-co1nam11lp2174.outbound.protection.outlook.com (HELO
 NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.174])
 by ob1.hgst.iphmx.com with ESMTP; 07 Nov 2020 07:07:51 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SHqx7esU1YspDqhYRDtMDXe2imL+KmaukcUd65G7kE6OvEN1wpG6tHWhO4HN8iklJnrf7v1xn3avE9o13sqhECcThNmCPw4y0pajCQvVvtM+T/sn9ls7qeBLSdwxAzHAzSKQsZesEHeei/kuJiZty9aTufxa4lCsYrCIqvexxc7iYddsZybVZZqYHNlXsfZPr9HO38qn1Bu3fv149xSNL0Ftn30JQ9kyuuNzTClNbc/GUOaL19DEg8jBzSwRCpY6MotsFK8s/OIvYI0/dFoKw77CRVmCBQaU0+zdstnQYItHgSNbexOkasGBnAgT5mIazmvXj+SZtwvhg+uwoYwnqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AQLvKJ//S1Q2eW3mytyMpWvP+EYqFTksdrzahU9/WzA=;
 b=CxCLqDxghkvb0L53CjttE0BnV6cgKVZeH1IQ8CbGLGiEIY8o/zWFv1RD9Z/0i7CPrQMDX6qRb5ujd1Yj+0o1cNI6hZb7lT7YEwshX+h5Ne3mlBHrc3I1op7snT/puwo1p0fW89+0xyzgYkwyWDeeCIdfpiUrZQnau0iJ9NKfPWFIDHfwSfNG79UyaFLlI0Y7XeLM6X2YVGi5lu5kUhEwVKppk0oSFSzsU5LMDybypONdOrspkO4l/Cx2/fXrJh45JnFPZYCyC1VRH8Hg4AgeGx4HtWL9PRkpGT60CySv9fTTxq4mTMRBO9Xi4pWvVsdkOhU00Ai0P2tdDn12KLuBgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AQLvKJ//S1Q2eW3mytyMpWvP+EYqFTksdrzahU9/WzA=;
 b=ZQFagurattW7ZHc2vCf5W5YJKV1QIpbXIgh2jYKi6niTeD148c66Gj2C89ktS4caDQkUkIQK19sjWv1ihnc3B3vw9Bmk/hD8oJb3zsjgMgIYSlo+FaRGAjnSUHJB7c1afa/U1U1Ay5EKLQMSRnNqQmEMEcULXIOlDMvJIc/iz/U=
Received: from MN2PR04MB5951.namprd04.prod.outlook.com (2603:10b6:208:3f::13)
 by MN2PR04MB5821.namprd04.prod.outlook.com (2603:10b6:208:a1::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.27; Fri, 6 Nov
 2020 23:07:50 +0000
Received: from MN2PR04MB5951.namprd04.prod.outlook.com
 ([fe80::44c9:85df:4910:44d8]) by MN2PR04MB5951.namprd04.prod.outlook.com
 ([fe80::44c9:85df:4910:44d8%4]) with mapi id 15.20.3541.022; Fri, 6 Nov 2020
 23:07:50 +0000
From: Dmitry Fomichev <Dmitry.Fomichev@wdc.com>
To: Niklas Cassel <Niklas.Cassel@wdc.com>
Subject: RE: [PATCH v9 08/12] hw/block/nvme: Support Zoned Namespace Command
 Set
Thread-Topic: [PATCH v9 08/12] hw/block/nvme: Support Zoned Namespace Command
 Set
Thread-Index: AQHWsx7wYCt5lx+QlEqSmzx8mJXt96m7AjKAgACkXBA=
Date: Fri, 6 Nov 2020 23:07:49 +0000
Message-ID: <MN2PR04MB5951A587754969FA3FFF7DEFE1ED0@MN2PR04MB5951.namprd04.prod.outlook.com>
References: <20201105025342.9037-1-dmitry.fomichev@wdc.com>
 <20201105025342.9037-9-dmitry.fomichev@wdc.com>
 <20201106115903.GA345539@localhost.localdomain>
In-Reply-To: <20201106115903.GA345539@localhost.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d93184f2-a0f0-4a92-b2ed-08d882a8c866
x-ms-traffictypediagnostic: MN2PR04MB5821:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR04MB58218FAE884FDC9693207745E1ED0@MN2PR04MB5821.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: U4fqNzLc0GPgIdsudZHM6EPJ0kXwRHq8Z16d/Cx7WR9u5jK30Wh8rtKilXVqo6NBEK6X+y3vYmv2FL/oeacwxbVYg8t+24KWPhA6hU7D1O3wXGibEpB8H86JiJ3zn4+rbUZNDTJxL2TlBfdhrJTr3LX1ormaDjyj654GedjvwYZPZKftoTZ2rNtQTRA2TPH31jCBVSwC5giFSLnpqUQP94n0iteIUeWVOf2gNPvG7wSOm7N/ASfqctsLlORA51OHnA+/op/ZYkDt5vR7d99zhsGTg9TcLTLpPrmJP+U+Y4FRi92lE0rZjKwCiHeD2D7aJha/0O6lgELL9qw447/eJQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR04MB5951.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(376002)(366004)(396003)(346002)(86362001)(66476007)(7696005)(9686003)(33656002)(66946007)(55016002)(54906003)(53546011)(83380400001)(26005)(6506007)(186003)(64756008)(66556008)(66446008)(5660300002)(8676002)(76116006)(8936002)(71200400001)(52536014)(2906002)(316002)(6636002)(4326008)(6862004)(478600001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: cOXnF26AZ5o9l5yXKUEEZBYwzpeMwvYyFl44TZqkMBiR283Vu8h+rMnNFBOEDhnYQ/lZNIjoaPhdZBcZldYWC6jOAXtmQlqaXRfcWgqk+u/8iTaAO6xSPPtPMZ/dWwYcVoEkDARtukHXkGFfBwcO6m/rHHOZiWCQgtPXxexcAIk51olFCXpZHtmwxQeTjtqfK6DgovhQn112pNQ/U+5M3PYliEjDgjvynaR+RubN3+DJ09F0OXmwbCCzmUjSQHJa6TGx8dlPReXCrcUm5hRE6I4YOdc1CJ733z98RHdB61k5Ee4ofLUMkyE9LlDHbOR6oUxnQolBFL7/hFXMn4XRlmE/JPuWyONNg/Kv60KNzUEEUTOfZYfDE21YW6T9u26yC7pln140+gjwAjUv9EywCjsHGM99xEoLGhGoGHBc62MWL2/EPPk2P3pLubMv2o4I0gq/CcjFdb9lBDh5RbGAZIsSx8NIw+rha9+hP5FocwW3fc1bVr0yjzTMnocbDNb3PVHRkdYlqsUugAuFAKGo3bUTFKNXrOoFTFUxQcMRdiVGl8i24YAcUFiebgsMc6KPUYmWBlfUxqBU6QkwvPb7CM3/IiJgrQu5/2S1p9G3ZG8v3yVfiHEK4QZFBZY1glcZZr7FBYh1TCMeq/CVVlC4Dg==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB5951.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d93184f2-a0f0-4a92-b2ed-08d882a8c866
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2020 23:07:50.0306 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GUAFoiVsdGT0VTEIQk2ognLdFiqOqffN6WMNPpVyEbv5wqzC+xPyEY/cjEyYQyY5vm85Mh3SffwYIWJHhh0duA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5821
Received-SPF: pass client-ip=216.71.153.141;
 envelope-from=prvs=572b21b8d=Dmitry.Fomichev@wdc.com; helo=esa3.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/06 18:07:53
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Damien Le Moal <Damien.LeMoal@wdc.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 Klaus Jensen <k.jensen@samsung.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Maxim Levitsky <mlevitsk@redhat.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, Keith Busch <kbusch@kernel.org>,
 Max Reitz <mreitz@redhat.com>,
 =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>,
 Matias Bjorling <Matias.Bjorling@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> -----Original Message-----
> From: Niklas Cassel <Niklas.Cassel@wdc.com>
> Sent: Friday, November 6, 2020 6:59 AM
> To: Dmitry Fomichev <Dmitry.Fomichev@wdc.com>
> Cc: Keith Busch <kbusch@kernel.org>; Klaus Jensen
> <k.jensen@samsung.com>; Kevin Wolf <kwolf@redhat.com>; Philippe
> Mathieu-Daud=E9 <philmd@redhat.com>; Max Reitz <mreitz@redhat.com>;
> Maxim Levitsky <mlevitsk@redhat.com>; Fam Zheng <fam@euphon.net>;
> Alistair Francis <Alistair.Francis@wdc.com>; Matias Bjorling
> <Matias.Bjorling@wdc.com>; Damien Le Moal <Damien.LeMoal@wdc.com>;
> qemu-block@nongnu.org; qemu-devel@nongnu.org
> Subject: Re: [PATCH v9 08/12] hw/block/nvme: Support Zoned Namespace
> Command Set
>=20
> On Thu, Nov 05, 2020 at 11:53:38AM +0900, Dmitry Fomichev wrote:
> > The emulation code has been changed to advertise NVM Command Set
> when
> > "zoned" device property is not set (default) and Zoned Namespace
> > Command Set otherwise.
> >
> > Define values and structures that are needed to support Zoned
> > Namespace Command Set (NVMe TP 4053) in PCI NVMe controller
> emulator.
> > Define trace events where needed in newly introduced code.
> >
> > In order to improve scalability, all open, closed and full zones
> > are organized in separate linked lists. Consequently, almost all
> > zone operations don't require scanning of the entire zone array
> > (which potentially can be quite large) - it is only necessary to
> > enumerate one or more zone lists.
> >
> > Handlers for three new NVMe commands introduced in Zoned Namespace
> > Command Set specification are added, namely for Zone Management
> > Receive, Zone Management Send and Zone Append.
> >
> > Device initialization code has been extended to create a proper
> > configuration for zoned operation using device properties.
> >
> > Read/Write command handler is modified to only allow writes at the
> > write pointer if the namespace is zoned. For Zone Append command,
> > writes implicitly happen at the write pointer and the starting write
> > pointer value is returned as the result of the command. Write Zeroes
> > handler is modified to add zoned checks that are identical to those
> > done as a part of Write flow.
> >
> > Subsequent commits in this series add ZDE support and checks for
> > active and open zone limits.
> >
> > Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
> > Signed-off-by: Hans Holmberg <hans.holmberg@wdc.com>
> > Signed-off-by: Ajay Joshi <ajay.joshi@wdc.com>
> > Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> > Signed-off-by: Matias Bjorling <matias.bjorling@wdc.com>
> > Signed-off-by: Aravind Ramesh <aravind.ramesh@wdc.com>
> > Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> > Signed-off-by: Adam Manzanares <adam.manzanares@wdc.com>
> > Signed-off-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
> > Reviewed-by: Niklas Cassel <Niklas.Cassel@wdc.com>
> > ---
> >  hw/block/nvme-ns.h    |  54 +++
> >  hw/block/nvme.h       |   8 +
> >  hw/block/nvme-ns.c    | 173 ++++++++
> >  hw/block/nvme.c       | 971
> +++++++++++++++++++++++++++++++++++++++++-
> >  hw/block/trace-events |  18 +-
> >  5 files changed, 1209 insertions(+), 15 deletions(-)
> >
>=20
> (snip)
>=20
> > +static uint16_t nvme_zone_mgmt_recv(NvmeCtrl *n, NvmeRequest
> *req)
> > +{
> > +    NvmeCmd *cmd =3D (NvmeCmd *)&req->cmd;
> > +    NvmeNamespace *ns =3D req->ns;
> > +    /* cdw12 is zero-based number of dwords to return. Convert to byte=
s
> */
> > +    uint32_t data_size =3D (le32_to_cpu(cmd->cdw12) + 1) << 2;
> > +    uint32_t dw13 =3D le32_to_cpu(cmd->cdw13);
> > +    uint32_t zone_idx, zra, zrasf, partial;
> > +    uint64_t max_zones, nr_zones =3D 0;
> > +    uint16_t ret;
> > +    uint64_t slba;
> > +    NvmeZoneDescr *z;
> > +    NvmeZone *zs;
> > +    NvmeZoneReportHeader *header;
> > +    void *buf, *buf_p;
> > +    size_t zone_entry_sz;
> > +
> > +    req->status =3D NVME_SUCCESS;
> > +
> > +    ret =3D nvme_get_mgmt_zone_slba_idx(ns, cmd, &slba, &zone_idx);
> > +    if (ret) {
> > +        return ret;
> > +    }
> > +
> > +    zra =3D dw13 & 0xff;
> > +    if (zra !=3D NVME_ZONE_REPORT) {
> > +        return NVME_INVALID_FIELD | NVME_DNR;
> > +    }
> > +
> > +    zrasf =3D (dw13 >> 8) & 0xff;
> > +    if (zrasf > NVME_ZONE_REPORT_OFFLINE) {
> > +        return NVME_INVALID_FIELD | NVME_DNR;
> > +    }
> > +
> > +    if (data_size < sizeof(NvmeZoneReportHeader)) {
> > +        return NVME_INVALID_FIELD | NVME_DNR;
> > +    }
> > +
> > +    ret =3D nvme_map_dptr(n, data_size, req);
>=20
> nvme_map_dptr() call was not here in v8 patch set.
>=20
> On v7 I commented that you were missing a call to nvme_check_mdts().
> I think you still need to call nvme_check_mdts in order to verify
> that data_size < mdts, no?

Ugh, I've added nvme_map_dptr() instead of nvme_check_mdts() :o
Will send the corrected version shortly...

Cheers,
DF

>=20
> This function already has a call do nvme_dma(). nvme_dma() already
> calls nvme_map_dptr().
> If you use nvme_dma(), you cannot use nvme_map_dptr().
>=20
> It will call nvme_map_addr() (which calls qemu_sglist_add()) on the
> same buffer twice, causing the qsg->size to be twice what the user
> sent in. Which will cause the:
>=20
>         if (unlikely(residual)) {
>=20
> check in nvme_dma() to fail.
>=20
>=20
> Looking at nvme_read()/nvme_write(), they use nvme_map_dptr()
> (without any call to nvme_dma()), and then use dma_blk_read() or
> dma_blk_write(). (and they both call nvme_check_mdts())
>=20
>=20
> Kind regards,
> Niklas
>=20
> > +    if (ret) {
> > +        return ret;
> > +    }
> > +
> > +    partial =3D (dw13 >> 16) & 0x01;
> > +
> > +    zone_entry_sz =3D sizeof(NvmeZoneDescr);
> > +
> > +    max_zones =3D (data_size - sizeof(NvmeZoneReportHeader)) /
> zone_entry_sz;
> > +    buf =3D g_malloc0(data_size);
> > +
> > +    header =3D (NvmeZoneReportHeader *)buf;
> > +    buf_p =3D buf + sizeof(NvmeZoneReportHeader);
> > +
> > +    while (zone_idx < ns->num_zones && nr_zones < max_zones) {
> > +        zs =3D &ns->zone_array[zone_idx];
> > +
> > +        if (!nvme_zone_matches_filter(zrasf, zs)) {
> > +            zone_idx++;
> > +            continue;
> > +        }
> > +
> > +        z =3D (NvmeZoneDescr *)buf_p;
> > +        buf_p +=3D sizeof(NvmeZoneDescr);
> > +        nr_zones++;
> > +
> > +        z->zt =3D zs->d.zt;
> > +        z->zs =3D zs->d.zs;
> > +        z->zcap =3D cpu_to_le64(zs->d.zcap);
> > +        z->zslba =3D cpu_to_le64(zs->d.zslba);
> > +        z->za =3D zs->d.za;
> > +
> > +        if (nvme_wp_is_valid(zs)) {
> > +            z->wp =3D cpu_to_le64(zs->d.wp);
> > +        } else {
> > +            z->wp =3D cpu_to_le64(~0ULL);
> > +        }
> > +
> > +        zone_idx++;
> > +    }
> > +
> > +    if (!partial) {
> > +        for (; zone_idx < ns->num_zones; zone_idx++) {
> > +            zs =3D &ns->zone_array[zone_idx];
> > +            if (nvme_zone_matches_filter(zrasf, zs)) {
> > +                nr_zones++;
> > +            }
> > +        }
> > +    }
> > +    header->nr_zones =3D cpu_to_le64(nr_zones);
> > +
> > +    ret =3D nvme_dma(n, (uint8_t *)buf, data_size,
> > +                   DMA_DIRECTION_FROM_DEVICE, req);
> > +
> > +    g_free(buf);
> > +
> > +    return ret;
> > +}
> > +

