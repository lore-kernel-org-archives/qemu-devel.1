Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85A37C4727E
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 12:49:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8281207FB
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 12:49:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Yxw8RJ90";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="xsg/3r4w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8281207FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNbYM-00015s-2K
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 08:49:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51368)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=5353e43af=Niklas.Cassel@wdc.com>)
 id 1kNbW2-0007S9-Id; Wed, 30 Sep 2020 08:47:26 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:59823)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=5353e43af=Niklas.Cassel@wdc.com>)
 id 1kNbVy-0001DQ-6J; Wed, 30 Sep 2020 08:47:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1601470042; x=1633006042;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=T4xDdlcyQGNHiIoHoDLffEHOVtq6rfI48BChPVFMcU8=;
 b=Yxw8RJ90IFtAaMXvY5hPQCvUwU2gMmwnGfaxkxhvKOkjfA6mVg70M62i
 yZqM03I0UEmPWDwk/16/IsDK9usVxT50hT1BC/0UvZaJQur2ZcFygcbWa
 SK0AgY/uy+tAE/H9fPm7yxxVvczX7GPDxCq4xMB3BVrU5ARCROFmKX5RA
 H27zgUa6hGm7tZDdUYaKOjdvZ5or2Hn8JkYliaCjj4cMKBsmum7hvVTik
 tJkTQiZO32WIF2VOCHqIZgAjjVcoCfz050rAJEZmskNPn4b+lGBaDPKgi
 ENCO0waZFiIb1D64I4KH+II29b522m82I+P8O123Hj/qV4Ha++FkUHzam g==;
IronPort-SDR: 7BTAWrgFwoi3Pwje9euGXpAnKEmeZYxYje37Kl9CbmnSF8i/CCXhME2EBUkAhGhhO5HATa8Xlx
 rprV5/q01OGfV3NzcBjdepoDFWNUFwp8AteZTonf2UwbEWGl7FM9+3zpyzjqAQtnDgAzCNWWc4
 0CkRrq7KvXAM/O+LTRUNyldA8KZHUrsXRoPlA02BcxHY7JtuTKV0BvWnbspWQVKCdoHzvGmaNm
 E12V17+PTFeLDc8Z9GgFSXOFteKd7CdMsAPOZiCA1GJ7iIdOt8xJB1paDb7dZecSvz8c6knvo9
 Mec=
X-IronPort-AV: E=Sophos;i="5.77,322,1596470400"; d="scan'208";a="153029216"
Received: from mail-co1nam11lp2169.outbound.protection.outlook.com (HELO
 NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.169])
 by ob1.hgst.iphmx.com with ESMTP; 30 Sep 2020 20:47:18 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fySxv8ruHulp9pBnQHquQkI2JRoR+3DEbNwDR8cMve5CAr+cLnOW2tGDJGDciZ2UmXs71f3MvVQyvZ0K739wRbN/EbdO9bx4tfyCfkdjEZ0AAcUQZtmmel46NUlOBHpyaQdIpCvBZryWhXFS6k5ZZD+3l1elFYyqPUzr7ysYG96bcH9n5hHJTgPHFpjlnarbji2SXXAxOzQCjuCfNl9ITak55zs1zyW6+cKL1rJGlwvV1ytosWlDAyjCjYhn6KviUz/QO5CvfLL+sQEoKCLkTbdZMEh5adVfsfV4hIcaIPFOdoUJofOhGctxyH06/YesNw63P0PxylVl73gptv9gsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nHNLPkb/R8JpvG7HXpO0KzNlRm9y/EEJh4n0Y1ZxtpI=;
 b=JBYVjIFrx9hVpEMBufXdNCE0rbKEw35y0YuC0xXnZiftyJyvhwI9J/Jfk3MurVSYhrdmQscgfhoeNITQIrznSud3pkGt+fjFkeAa56X8mjmtM8qpZFVoh8gyk1k6YQk6ObEBfqdFOhm2zLk5K0vajvVz3xLWgEWr+D2Y2hnmn+JYsMtho2mNQRzPXbBHwtIBsEwTdhrIgVVl/6VCvZY+B44Gp+u8nw0iX01DgzK4PiQrKWwu/dgcb1L5nDhyYHwi26OujygF+4UT5EflWnlWrmbMa0RxIWuDcIH5tj5+Azbj/1w5fZlB7X96aemZWPuyoy1FZsMx0NPm+kO2uMD1lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nHNLPkb/R8JpvG7HXpO0KzNlRm9y/EEJh4n0Y1ZxtpI=;
 b=xsg/3r4wRheOE3jKh3+cAaE9DEaTIzCjHxnJCVJDXpUSjOPAj8ktey6KAnFxTeFj67lCZI4N0KIkXR5iisBziwmttDHgrgu4xarkWNLXBCFpykmUNRETEtpTPaPCucW23HFI1c1Tv/ZHI850jKYpIczASLpJlUOl+BcwHDRC1go=
Received: from BN6PR04MB0724.namprd04.prod.outlook.com (2603:10b6:404:ce::23)
 by BN6PR04MB0564.namprd04.prod.outlook.com (2603:10b6:404:97::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.36; Wed, 30 Sep
 2020 12:47:16 +0000
Received: from BN6PR04MB0724.namprd04.prod.outlook.com
 ([fe80::acb1:47a4:73ba:69a7]) by BN6PR04MB0724.namprd04.prod.outlook.com
 ([fe80::acb1:47a4:73ba:69a7%9]) with mapi id 15.20.3412.029; Wed, 30 Sep 2020
 12:47:15 +0000
From: Niklas Cassel <Niklas.Cassel@wdc.com>
To: Dmitry Fomichev <Dmitry.Fomichev@wdc.com>
Subject: Re: [PATCH v5 05/14] hw/block/nvme: Add support for Namespace Types
Thread-Topic: [PATCH v5 05/14] hw/block/nvme: Add support for Namespace Types
Thread-Index: AQHWlUAVwLU3dDmYeECN1HNLSzDofqmBJSQA
Date: Wed, 30 Sep 2020 12:47:15 +0000
Message-ID: <20200930124714.GA200449@localhost.localdomain>
References: <20200928023528.15260-1-dmitry.fomichev@wdc.com>
 <20200928023528.15260-6-dmitry.fomichev@wdc.com>
In-Reply-To: <20200928023528.15260-6-dmitry.fomichev@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [85.226.244.4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a18766ee-099f-4057-cba0-08d8653ef5ca
x-ms-traffictypediagnostic: BN6PR04MB0564:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR04MB056469B26A59D35A5FF6DF17F2330@BN6PR04MB0564.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uNCp3ri9QyhlSIlXuHu3z5HfhKSagvsoY/RDXfyVgMDWwHTtBhcjHN0xOFNstoc7nti9zBZeZApwopRQaT5JnZsrXgtzspsyP7iHOYeXJoTIB4Fk8AXT2+Hkc8M9ub6NtMCA53gtC7A+k/hetOYa12/eEaJpUS0utfCOcEIwBSPuXm9M8WHkubPBZxapujPCthZ1aNZgEju/vfNCz6Vmr/FC1LQPkQ6J52y+IyG6Nef2B9jvRrXkLmrQ/fiDjpJRz4BrTzBQ6rLT0Qt6IpbYdlzoUJuJsAq53wsnyeKeKVu1hNuDxHPgFmxfJ1ksxl8TiKwXpkJIoWKtg/726uajxg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN6PR04MB0724.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(136003)(396003)(39860400002)(376002)(54906003)(186003)(316002)(6636002)(478600001)(33656002)(91956017)(76116006)(8936002)(71200400001)(1076003)(5660300002)(2906002)(86362001)(6862004)(6506007)(26005)(8676002)(9686003)(6512007)(66556008)(83380400001)(66946007)(66476007)(64756008)(66446008)(6486002)(4326008);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: dffCyxFNQSpqfyWvL+1WS7RPdLSv2nvBu57KWEmsQavdN5wKu95GsIadkoUnJlyzjiz/kYqOlsNmwVJ8wVzZfXmDLF1xdGmyF3FB0Cbnd1FI+AXYxGPvcGgsyWlPshX94OVDiNGl7+whyGlhn7NpvVNMnWVij1/Zm6MseNMibFJNYSVD3/SI9ZrwzBZYgYAnWe7KEhAdjm2C5i/z7wVNV7lORr+dTlOJszhcbQTYZ8EVu04YJZHqGMdSnOF5qDKfZuMg7rNYjNyk21qDpZXYe0bYFbjRU8T2Y8/c0n1TgZh2t5uS6NmwtUcELLuI9at8Nd9l5T+QxGR/ZZmqovTeSXueIpnwmFs6fCQvqE2K4TNW5yYRfP4v7kY91YT2UdnE7k5bP/5768ewiJwkng9MD5PewiKJd3hnUauPS3MY7MrNMNzvpye6iGwoAYB66YN2TY9W8pR8+yX1Mf0IcQYjNtgDffzr3s29rXAv6GvHK1ZdO6tNL/qppCbuhK2wvhoCCCR6IDPtUAgrCJE8yvCvejbwP+feZievdoKmF42TfBiJAAyG0R2SjJna9ya2DShN4mlh8dr4Otj0yf2k/QQXw0aj1J49UjAfTa1IfrNGE5kXoWQ4K6btltMsTSWNFj18aukvH5npM1CRbojZWTsnoQ==
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <5736E84CAD1F12438441AB45F4CB1E41@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR04MB0724.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a18766ee-099f-4057-cba0-08d8653ef5ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2020 12:47:15.7112 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Zklnv24T80/I//xIZuLs8+NH5SDS918QiAfxSEvTKctSvvaXkAL3VxcQ2kKnl5X3TRhkTXcDktiCryDw84F/rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR04MB0564
Received-SPF: pass client-ip=216.71.153.141;
 envelope-from=prvs=5353e43af=Niklas.Cassel@wdc.com; helo=esa3.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 08:47:18
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Damien Le Moal <Damien.LeMoal@wdc.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 Klaus Jensen <k.jensen@samsung.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Maxim Levitsky <mlevitsk@redhat.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, Keith Busch <kbusch@kernel.org>,
 =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>,
 Matias Bjorling <Matias.Bjorling@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Sep 28, 2020 at 11:35:19AM +0900, Dmitry Fomichev wrote:
> From: Niklas Cassel <niklas.cassel@wdc.com>
>=20
> Namespace Types introduce a new command set, "I/O Command Sets",
> that allows the host to retrieve the command sets associated with
> a namespace. Introduce support for the command set and enable
> detection for the NVM Command Set.
>=20
> The new workflows for identify commands rely heavily on zero-filled
> identify structs. E.g., certain CNS commands are defined to return
> a zero-filled identify struct when an inactive namespace NSID
> is supplied.
>=20
> Add a helper function in order to avoid code duplication when
> reporting zero-filled identify structures.
>=20
> Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
> Signed-off-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
> ---
>  hw/block/nvme-ns.c |   3 +
>  hw/block/nvme.c    | 210 +++++++++++++++++++++++++++++++++++++--------
>  2 files changed, 175 insertions(+), 38 deletions(-)
>=20
> diff --git a/hw/block/nvme-ns.c b/hw/block/nvme-ns.c
> index bbd7879492..31b7f986c3 100644
> --- a/hw/block/nvme-ns.c
> +++ b/hw/block/nvme-ns.c

(snip)

> @@ -1597,12 +1667,31 @@ static uint16_t nvme_identify_ns_descr_list(NvmeC=
trl *n, NvmeRequest *req)
>       * Namespace Identification Descriptor. Add a very basic Namespace U=
UID
>       * here.
>       */
> -    ns_descrs->uuid.hdr.nidt =3D NVME_NIDT_UUID;
> -    ns_descrs->uuid.hdr.nidl =3D NVME_NIDL_UUID;
> -    stl_be_p(&ns_descrs->uuid.v, nsid);
> +    desc =3D list_ptr;
> +    desc->nidt =3D NVME_NIDT_UUID;
> +    desc->nidl =3D NVME_NIDL_UUID;
> +    list_ptr +=3D sizeof(*desc);
> +    memcpy(list_ptr, ns->params.uuid.data, NVME_NIDL_UUID);
> +    list_ptr +=3D NVME_NIDL_UUID;
> =20
> -    return nvme_dma(n, list, NVME_IDENTIFY_DATA_SIZE,
> -                    DMA_DIRECTION_FROM_DEVICE, req);
> +    desc =3D list_ptr;
> +    desc->nidt =3D NVME_NIDT_CSI;
> +    desc->nidl =3D NVME_NIDL_CSI;
> +    list_ptr +=3D sizeof(*desc);
> +    *(uint8_t *)list_ptr =3D NVME_CSI_NVM;

I think that we should use ns->csi/ns->params.csi here rather than
NVME_CSI_NVM.
You do this change in a later patch, but I think it is more correct
to do it here already. (No reason not to, since ns->csi/ns->params.csi
should be set to NVME_CSI_NVM for NVM namespace already in this patch.)

> +
> +    return nvme_dma(n, list, data_len, DMA_DIRECTION_FROM_DEVICE, req);
> +}=

