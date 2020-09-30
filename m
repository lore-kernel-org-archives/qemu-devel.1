Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48A5CC4363D
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 23:13:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A577E206C1
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 23:13:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=permerror (0-bit key) header.d=wdc.com header.i=@wdc.com header.b="m2QBGr4E";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="KEjovRf/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A577E206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51272 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNlHZ-0000sd-Gq
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 19:13:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43244)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=535555f00=Dmitry.Fomichev@wdc.com>)
 id 1kNlGS-00007N-0c; Wed, 30 Sep 2020 19:12:00 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:53586)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=535555f00=Dmitry.Fomichev@wdc.com>)
 id 1kNlFg-0008Dj-97; Wed, 30 Sep 2020 19:11:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1601508630; x=1633044630;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=JOhmRAlohvIC5qhnlz4/weTmisUrRWyzBz4e/1KZam0=;
 b=m2QBGr4EyXv3ZDLD7M4YwA9uW4cirOr+Bfn9VOym5YqG57CY+IEkvYwc
 IawDm1YHIM6DVqm7KB5j9/dx3k45UzgDOHjJsYJhbt1T4H/MS9AuET594
 ezAN4vUaqvp0uICZQXCBc3lHx5wmdTg+9Lg6st0sqES8XNNk8mZykKgJh
 V2NTXF7AT+uTriHjoHH6de2ezv7sTc5hzvcB8ifrH8LfcGQ+Bd9W2w5zk
 iN8iHy754FwDFcKXL33VpcxTv53Ial09hCMEzMsMIUFLK2FYP7zYrs/Xo
 44DssJRgcGCjJb7NQJx1mXKNnXlEWjZ6ei06ua4iDCMWFbVEuywKsyAg5 w==;
IronPort-SDR: hIsbEIsy6VlJhxNKBBuVKJ60o9rfi2xi28lshxgIvjCEQ2uDVxJmg7nVbnkZoF8QNmCZU3zTL9
 kEiRklQ94DOqB8rSAsKGj7qV8YcrFjn21+TjCNBiBi1itRnc/RpW9w6mLX1uJXKdtgb271mL89
 NdPpsc6Sc9S5lbcPDVBTCahGXg5GXw6q+pwzET+ZDu0llWJYtzldpeMFMZLv9QqQw+UqTYNIx3
 WhlYDNg8irDQ2mTD3XKYw1OhyrLyJsWdgVxK2ONvKoD0FoGrX13bROXKIjeh+Rw4A8IxbevY10
 pLE=
X-IronPort-AV: E=Sophos;i="5.77,322,1596470400"; d="scan'208";a="252114464"
Received: from mail-dm6nam11lp2174.outbound.protection.outlook.com (HELO
 NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.174])
 by ob1.hgst.iphmx.com with ESMTP; 01 Oct 2020 07:30:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mp1Z8daJlc8zKEjO9OUByL7NXnCZmt2xdqL4PoYkKkPbKYcsek5dlA49l3/cIa97j/KJHQcX5DPeNU+EJ3kCcgE+e6B+3wmm1a8Kl5YToSP3tCigHN3jlvNeydkeSUvO3QrnIrxazbM/zZOpebb1gXN/hZGe2EQJg6BeoiT3yrs0ZJDcjKVBxoleerR8mIiZnxNFqdRVsMb8T53eSg/WiVvzkO0FeC1JBngvSiXupqfw5JejomBvG3wK5PH+wkajIhz4J1vpoxIGCQFrU8VxOCBNWGLer4Uuy8OuZgcy3fU0IvRPiHqV3z9v3GCwphHqZ5D3RWZdSmtABJbTBelN3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AfHicuR1DCQMigl6gXaDRPa9uPvdIzJrqLddWwfplao=;
 b=BTxrAoHNZczdVnplljB2iedBu2FrMMu/K8D1eMpGGowUfMjpsJJh+8HntRK/qICtdzAtwI7CD8letJ5LEHhuAajupctDIkCvsf+prVNivc2alh2IFOV6q6WSwSLPfxRh7iRSjRdlO65f2RNuveNHzAdEHAIVEL97Ooj31PclbrMXMZee1n1+lujDi9kl08bTaXpEtrQr2lpeOnasI28b8F5r/Wzei4C6INn1CznAfIJAdIPAjJSuSNNbavBLz1I8o5PWw0KrGCnvYQfyWVPr4Pgl/vWK2giYRsZlLNm/iJpI3emQFkliELtQrnu5HXU3y3vPeuwbutiDgToZpjtvuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AfHicuR1DCQMigl6gXaDRPa9uPvdIzJrqLddWwfplao=;
 b=KEjovRf/4tsowLyxRqOcWJYiAp2i7WxxgoYnJFIADa+CHKLyibyTy3BOs6jWxps8mCZDWZrKfNrYynYPhg322BQKB1UO8hNSH3bi6tR/gQLP1qao7SnLlYDy+eaZgVZk0vdjABXdzSbnVuZclVh1g3i8g0p+ad4RihNrUdoj+ns=
Received: from MN2PR04MB5951.namprd04.prod.outlook.com (2603:10b6:208:3f::13)
 by MN2PR04MB5743.namprd04.prod.outlook.com (2603:10b6:208:38::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20; Wed, 30 Sep
 2020 23:11:00 +0000
Received: from MN2PR04MB5951.namprd04.prod.outlook.com
 ([fe80::44d8:522e:db29:bb94]) by MN2PR04MB5951.namprd04.prod.outlook.com
 ([fe80::44d8:522e:db29:bb94%6]) with mapi id 15.20.3433.034; Wed, 30 Sep 2020
 23:11:00 +0000
From: Dmitry Fomichev <Dmitry.Fomichev@wdc.com>
To: Keith Busch <kbusch@kernel.org>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Klaus Jensen <k.jensen@samsung.com>
Subject: RE: [PATCH 6/9] hw/block/nvme: reject io commands if only admin
 command set selected
Thread-Topic: [PATCH 6/9] hw/block/nvme: reject io commands if only admin
 command set selected
Thread-Index: AQHWl3WrC1Ph0ejSD0GQiYgaMBu4FqmBzmuw
Date: Wed, 30 Sep 2020 23:11:00 +0000
Message-ID: <MN2PR04MB5951DD3210B99E1B14B84CD4E1330@MN2PR04MB5951.namprd04.prod.outlook.com>
References: <20200930220414.562527-1-kbusch@kernel.org>
 <20200930220414.562527-7-kbusch@kernel.org>
In-Reply-To: <20200930220414.562527-7-kbusch@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4671a276-0741-48fd-d569-08d8659618ae
x-ms-traffictypediagnostic: MN2PR04MB5743:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR04MB5743F07376864BC51D9E729FE1330@MN2PR04MB5743.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HWpGyyxHgM4dIxX4bekP76NJCFp8yIO4GIqTP0xojrm5aFFxMYNPUXoxYw/RAWLHGaVgqrv0koRXn37WLk6w9/Q4/LBZ35XV1iC1o4UGvUmNBeqq0Fa12F7YmYqRQSsDVp0dt3LdG+/x7KO0++uBR8IKrhjslnKTaSbJ2Sr3QRwZGHRku1+SlB9xhSw6dZInyx9KR10JLo8mVupcjlDeTO7Bx85bPPjmzoV/oZAXGCd9ogbEhtgbW+4MTfXkokH8dc5F3yj/yJVSkXtXvLvzV93/URO/kEVj6Z5VgFGRSr2ekDZ07H6jsEZ4BTS0st8i21IfXU1lsmzylhDrGq3SnOSUdmm6yXWNGfIz1Iz5g6RTkTtYlgVMkaqLTeJuEId9
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR04MB5951.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(346002)(39860400002)(136003)(376002)(316002)(110136005)(8676002)(4326008)(186003)(33656002)(83380400001)(8936002)(478600001)(76116006)(7696005)(71200400001)(6506007)(66556008)(52536014)(55016002)(5660300002)(66446008)(9686003)(86362001)(2906002)(66476007)(64756008)(54906003)(66946007)(53546011)(26005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: N9CsgYpDaRmnbXBBdZxow2pC0/R41xZagV+z4JIKmGdkliTF9rDcB9E077rjBMpcvQa6x/ujmva6ImRiDrxjUKnaZYrek55TZRIgD63WV+hbnEYUutIrlAaL0DYOyPgoLzfLz5YM2aO2elU1Km35VRz8WPR31JYCPHddxUeW2OBaJuXktYHpYM4XXVv2VG9hqzkUuI/CZ3do/xmxT9VSOmvmc6wXquQAxYg1zIld8yf43s/a/tZt9i5gMPPKnbYne5IhuesD+V4z43SQIPOd6j5844cICLwTCduIKBYwvC6n9zzv9Cl2/P7ZR7kwWZP8aMm2LTYbLuoUPxLeb0EOfBoHOwKCzbubTthK//7n7Maruz2ilfy/RdPy4fqSvDxTr+F0ptyCkvW2VcUu5SEQVtIbIqrlOn/cr1UeTtXqAw4s+22i1wCeEUdieTRdUkIWYIzy7UUolEsw8x4LALe7/mNgmxwJH5dMXsNhNYhj4wx3BXgHmiJflpOtR+Xfh8rCDS9xCUX6E/VssOd+IUJM5YdEV6cYm/V1/PqIua5Ncmqu5UxbQu2lcz9VYSJ7uJxiRpc0CxMyyLXR6fodwF/UjwZMr1+PAQm7eIG7B34wEtR7XxR9uenndionRFEm1dUQcnAuEA7IMqYTdXrU8pJD4Q==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB5951.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4671a276-0741-48fd-d569-08d8659618ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2020 23:11:00.5146 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BVYNznn7B0yK95NGLZ7lIPcwzuUR3WhnA3x0EPDv9Al2kbHuNosMn/RGJeOrtZk5mb+3oynACh+oGNhbVF6nCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5743
Received-SPF: pass client-ip=68.232.143.124;
 envelope-from=prvs=535555f00=Dmitry.Fomichev@wdc.com; helo=esa2.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 19:11:08
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Niklas Cassel <Niklas.Cassel@wdc.com>,
 =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> -----Original Message-----
> From: Keith Busch <kbusch@kernel.org>
> Sent: Wednesday, September 30, 2020 6:04 PM
> To: qemu-block@nongnu.org; qemu-devel@nongnu.org; Klaus Jensen
> <k.jensen@samsung.com>
> Cc: Niklas Cassel <Niklas.Cassel@wdc.com>; Dmitry Fomichev
> <Dmitry.Fomichev@wdc.com>; Kevin Wolf <kwolf@redhat.com>; Philippe
> Mathieu-Daud=E9 <philmd@redhat.com>; Keith Busch <kbusch@kernel.org>
> Subject: [PATCH 6/9] hw/block/nvme: reject io commands if only admin
> command set selected
>=20
> From: Klaus Jensen <k.jensen@samsung.com>
>=20
> If the host sets CC.CSS to 111b, all commands submitted to I/O queues
> should be completed with status Invalid Command Opcode.
>=20
> Note that this is technically a v1.4 feature, but it does not hurt to
> implement before we finally bump the reported version implemented.
>=20
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> Signed-off-by: Keith Busch <kbusch@kernel.org>

Reviewed-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>

> ---
>  hw/block/nvme.c      | 4 ++++
>  include/block/nvme.h | 5 +++++
>  2 files changed, 9 insertions(+)
>=20
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index ec7363ea40..80730e1c03 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -1026,6 +1026,10 @@ static uint16_t nvme_io_cmd(NvmeCtrl *n,
> NvmeRequest *req)
>      trace_pci_nvme_io_cmd(nvme_cid(req), nsid, nvme_sqid(req),
>                            req->cmd.opcode, nvme_io_opc_str(req->cmd.opco=
de));
>=20
> +    if (NVME_CC_CSS(n->bar.cc) =3D=3D NVME_CC_CSS_ADMIN_ONLY) {
> +        return NVME_INVALID_OPCODE | NVME_DNR;
> +    }
> +
>      if (!nvme_nsid_valid(n, nsid)) {
>          return NVME_INVALID_NSID | NVME_DNR;
>      }
> diff --git a/include/block/nvme.h b/include/block/nvme.h
> index 521533fd2a..6de2d5aa75 100644
> --- a/include/block/nvme.h
> +++ b/include/block/nvme.h
> @@ -115,6 +115,11 @@ enum NvmeCcMask {
>  #define NVME_CC_IOSQES(cc) ((cc >> CC_IOSQES_SHIFT) &
> CC_IOSQES_MASK)
>  #define NVME_CC_IOCQES(cc) ((cc >> CC_IOCQES_SHIFT) &
> CC_IOCQES_MASK)
>=20
> +enum NvmeCcCss {
> +    NVME_CC_CSS_NVM        =3D 0x0,
> +    NVME_CC_CSS_ADMIN_ONLY =3D 0x7,
> +};
> +
>  enum NvmeCstsShift {
>      CSTS_RDY_SHIFT      =3D 0,
>      CSTS_CFS_SHIFT      =3D 1,
> --
> 2.24.1


