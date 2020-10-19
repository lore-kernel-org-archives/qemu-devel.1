Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 422AEC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 07:34:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEA8622243
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 07:34:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="fMgTm+Tg";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="MWp/hdaj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEA8622243
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40908 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUPgZ-00007F-S0
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 03:34:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50496)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=554f0a31b=Niklas.Cassel@wdc.com>)
 id 1kUPeR-0007wF-3U; Mon, 19 Oct 2020 03:32:20 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:27572)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=554f0a31b=Niklas.Cassel@wdc.com>)
 id 1kUPeN-0000ro-6s; Mon, 19 Oct 2020 03:32:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1603092731; x=1634628731;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=luN7BatVFGam3mhwO1Ptfo4sGRMZKBnbw1b0Z8ibblE=;
 b=fMgTm+TgqtzXbZ14kEBGLfWFEFALectHQ0FUYcsYvWZuqJaa9PiwAxH3
 krwJtQbT1YxSxjdSo+gQ/rGuACzYgupJkZ6J/1AJL6cPiSCAFFFaj0aA2
 RnrLYov2NmCikuqKaog4zwrOWkOz1RfEqXChy/DJuGKu8Q9NCILpHv1dr
 lfmMixKH+Unj/xJDkfcNZGQ8pOQioBRRiRNvoyufgjh3si76so85QqOJH
 CadsDToXFGE8//w4ojzfU0RDODCBKaFsHKFKcnh+u8rUqnwPov/rxiG3g
 HBgm7yHujHPvkRq3XeO1ZtZGxiVVxf8bUVlLKzIfsA1/hOayDhZshBT1u A==;
IronPort-SDR: LoHJxzK+9f/c07gOFFmVmIeq1RKcFoiF+yObYUuhwvqULRN9vBa5lz4DQwUTdRUiIPbgU5NkjQ
 LJGDlbKM1Uu3fOugnyyXtfcxJ5tmXc228/i0hO54FaDC4MmITlJqYvqF6VWtaDv3B1/vtWrEPm
 OET3JRWqV8f53fTJShIvoeSRqt+FDIubFlFKrKrvfUpOCXsLTnX5O6ayeYMVE76OOKVCOZH4Nc
 1Z1GaNKSI97cu1lNC3PzUrqaguV4ZLSa2qW720k4UnOEKI3lotdz1DQRrHHIF4zyPK9N7swZEp
 nLk=
X-IronPort-AV: E=Sophos;i="5.77,394,1596470400"; d="scan'208";a="150226377"
Received: from mail-sn1nam04lp2055.outbound.protection.outlook.com (HELO
 NAM04-SN1-obe.outbound.protection.outlook.com) ([104.47.44.55])
 by ob1.hgst.iphmx.com with ESMTP; 19 Oct 2020 15:32:04 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JynIJDaTm22a7mxIIO5nHK4SysMR33MkE9RKGY3sI992+aypIiQuWHio0kzbXPhyaLOO4BJoNFmFIbf7z/CAMGEs812wKkBSVfqBS8IsgCwuCi7O2MpSQ1rFXeQLP/CsVn1iB2F1y4FoHEn5i3fZiPGsNM0p8d1+v7GD8CCHBTpc3k4wcjhipScVSsx2CrN9nWK1LF2/kCNkoRrUKDH/1urQHsToZQXdLDAxKLFp7vIPSZnRJgf90PuFowVHmYgxbVTToK8qX9ezDqPn/hA/U/eR9Go3ZFBxV8fpDjKVak0t3Kfel35fWwa/RLlULOxZkrG/TY0+6eXzsFvrjIUxNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0+UM7nBswRbKyWMQsybqEVS54QUQBdP06XcldtJp82Y=;
 b=fllCeV16WHOFyIMTlUieUXtPXXZLJJbJlW57In7MDGuWS735NgrIJRKGEMZYDIQ9E/XWHqRdgjoenT9ms8t5+xQXP0djrqP66rQ/fr1ckkEQQqEcSAFS5Ha1owAbgCaqwOexyOa121abRR9SXF/C7agLUukYaxvVu14JsmEKcPPgeoovXnPp8cskOJrOp/9lxHCbREtwxS+OVurIzcd34oISfGAAf6cZku+4jkiCrSDGhPjwGNNxCohfFl6LadDQ5r1C654lEkwrn9N72DBuAqs9xhCTuBVyyhQUCgrBrJMmVA9++9c7PNhSaY2YqvmgUxGfEV07x6az8/ZlqVmJ9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0+UM7nBswRbKyWMQsybqEVS54QUQBdP06XcldtJp82Y=;
 b=MWp/hdajWyWGpJthY/7Y5WWxjzLJYDJU2ehPTDvPRKSXYek3AwB8Tc1+bJi8fhHz80V6x3I/h0UC6beExvSM5Toz5d2dHI9DsYC2+RhM32/Tr+1T7dcozzyEW5l1tdbmL+K7lu3CUqHhYvNmibSldO5rMqr/ryZQiY8Z4aVwJWA=
Received: from DM6PR04MB5483.namprd04.prod.outlook.com (2603:10b6:5:126::20)
 by DM5PR04MB3724.namprd04.prod.outlook.com (2603:10b6:3:f4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Mon, 19 Oct
 2020 07:32:03 +0000
Received: from DM6PR04MB5483.namprd04.prod.outlook.com
 ([fe80::c8ee:62d1:5ed1:2ee]) by DM6PR04MB5483.namprd04.prod.outlook.com
 ([fe80::c8ee:62d1:5ed1:2ee%6]) with mapi id 15.20.3477.028; Mon, 19 Oct 2020
 07:32:03 +0000
From: Niklas Cassel <Niklas.Cassel@wdc.com>
To: Dmitry Fomichev <Dmitry.Fomichev@wdc.com>
Subject: Re: [PATCH v7 00/11] hw/block/nvme: Support Namespace Types and Zoned
 Namespace Command Set
Thread-Topic: [PATCH v7 00/11] hw/block/nvme: Support Namespace Types and
 Zoned Namespace Command Set
Thread-Index: AQHWpb4CxGq0MF0VIU2GbuWPU+YlhKmeiGKA
Date: Mon, 19 Oct 2020 07:32:02 +0000
Message-ID: <20201019073201.GA260317@localhost.localdomain>
References: <20201019021726.12048-1-dmitry.fomichev@wdc.com>
In-Reply-To: <20201019021726.12048-1-dmitry.fomichev@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [85.226.244.4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d4ffd2dc-ba7e-4588-4200-08d87401130a
x-ms-traffictypediagnostic: DM5PR04MB3724:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR04MB37248923E020756B3960EC02F21E0@DM5PR04MB3724.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VQoH7WG9kzvfkfnC0dS9Co8+SK9Qpr1nOI1BAjwz/jecnt7Ers9W35W2KM4vtVFJBdxuwWQvdlxP/lkWBZdVgVSk2kTqMk9JP3viATwy+EcIWgJgbW3R+vaBRPsDeJI2LgCGsoXQ8SnqDZU0nPBnap7tZc56axUJToYvrG8eau2Mn85Xm4VrDfixriO9nyugOnmeiaVRXDeVjfVTZuQSWDbJdDF5C4dwAGsPY03TfjNYkj9B7Ct3MVOGvTXuYAdljqdhbXsbTMAemoBgQJ68/ji0/MGFW0MYsFMolC3nGRsayJhxIL9+TEI28H9AwEWwKUlFIolzfivMI7JvxW8U4w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR04MB5483.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(39860400002)(346002)(376002)(366004)(5660300002)(186003)(26005)(76116006)(54906003)(66476007)(1076003)(83380400001)(91956017)(66556008)(316002)(66946007)(6486002)(64756008)(66446008)(6506007)(8936002)(6862004)(33656002)(4326008)(8676002)(6512007)(478600001)(9686003)(71200400001)(6636002)(2906002)(86362001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: zK44wyw05+COZeqDWY51d3j+9771xeD7gVPHkyr3thizfe3Ah77T6L9YzP+5auuC2GM4u4xZAzDBBAxPCQ0cc6L/OdasYSgHGXAexXiaairBnIVUkm0/6mBc0MvrWs6jgn5pwaSHCj5vgdQYYrTmFDLuIGjD75k1lnTdeWmt7+UbZUUrssHCZcUAKuW1DQxcxii4k05n3P33+5GXMJjWaaykItZ/EsbBRkizmF6F7DBGwF3Z+H+WGgZBZUPPNZSffACqj8o+lBK5cevvnt03pKPoeF1c7n8eMrR3nPwjqbXA4bm0Ek7sEskvvs/CFKWX341qtDGI8VmRKQA+V0O0Q+ctnzrxGfhcjZ52xjibMdxuX69MfHQ91D1UTzPzKL/mhMQI4ZFBUTj3dhKACgr3OVOZAT2517yA/0oZBJDKSEB8kmiUxJCb5AXR848JeU9SVwH2ccNnOwxBx6eLmeps9uIELVK5KW9j81ewoYePk+yIX7DuK/gEoqQFM1bAGGZDJ+9AbB0QutrW4yx8hsqreyFDI2UCucxK+0lfAmIpJd4lOV/u88N0Wqb3X9iLuMGgqEj2IoWLIx0al4ER4T0Gq9qjy/PRgZaa+g64KgCq92SCItdS6ngG9CpJkZZW1RvWzVMo8FvlMyw0nPq/HBMRhA==
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <6532BFD4C4915A40B35456B8377C5B38@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB5483.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4ffd2dc-ba7e-4588-4200-08d87401130a
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2020 07:32:03.3225 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RvSCYHKX2j0ykBcCMTWOgp8wvPnT/MyWTETT92iuzrW05le14UkGR7W/v4Z6gQoSn2KRXYjXHIOcZYhlMrQQ8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR04MB3724
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=554f0a31b=Niklas.Cassel@wdc.com; helo=esa4.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/19 03:32:06
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

On Mon, Oct 19, 2020 at 11:17:15AM +0900, Dmitry Fomichev wrote:

(snip)

>=20
> Dmitry Fomichev (9):
>   hw/block/nvme: Add Commands Supported and Effects log
>   hw/block/nvme: Generate namespace UUIDs
>   hw/block/nvme: Support Zoned Namespace Command Set
>   hw/block/nvme: Introduce max active and open zone limits
>   hw/block/nvme: Support Zone Descriptor Extensions
>   hw/block/nvme: Add injection of Offline/Read-Only zones
>   hw/block/nvme: Document zoned parameters in usage text
>   hw/block/nvme: Separate read and write handlers
>   hw/block/nvme: Merge nvme_write_zeroes() with nvme_write()
>=20
> Niklas Cassel (2):
>   hw/block/nvme: Add support for Namespace Types
>   hw/block/nvme: Support allocated CNS command variants
>=20
>  block/nvme.c          |    2 +-
>  hw/block/nvme-ns.c    |  295 ++++++++
>  hw/block/nvme-ns.h    |  109 +++
>  hw/block/nvme.c       | 1550 ++++++++++++++++++++++++++++++++++++++---
>  hw/block/nvme.h       |    9 +
>  hw/block/trace-events |   36 +-
>  include/block/nvme.h  |  201 +++++-
>  7 files changed, 2078 insertions(+), 124 deletions(-)
>=20
> --=20
> 2.21.0
>=20

Thank you Dmitry, this version was easier to review.

Except for a missing
/* fall through */ comment in nvme_cmd_effects().
(in the "hw/block/nvme: Add Commands Supported and Effects log" patch.)

For the whole series:
Reviewed-by: Niklas Cassel <niklas.cassel@wdc.com>=

