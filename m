Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E1E2C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 13:02:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61C7C20848
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 13:02:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=permerror (0-bit key) header.d=wdc.com header.i=@wdc.com header.b="RZUYepLM";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="eAQsFP+u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61C7C20848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60158 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSgQQ-0007D5-22
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 09:02:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39546)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=5492a5ee4=Niklas.Cassel@wdc.com>)
 id 1kSgPb-0006gy-Ql; Wed, 14 Oct 2020 09:01:47 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:17098)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=5492a5ee4=Niklas.Cassel@wdc.com>)
 id 1kSgPY-0001vz-Bw; Wed, 14 Oct 2020 09:01:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1602680946; x=1634216946;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=I1hykRkWd2m20+it+2bpEIKtUh7H1jPdmujNrLP2MbY=;
 b=RZUYepLM77jSdURt+P6YIWG+MTflna7zMxn6Lg5Hk0uOo2Y36VVdxHQ3
 /T1016+A1GE1ql0AWFa8adYNuuGIkml2ZgLWhcu7bZBqXXgA/K5XRylok
 jxD29UcvyW13msnhW1lRWaEIf5Bm1LE81t1K9VFR/kLOeXJhw62YBtMCl
 eCSBO0CJtgbEHL4v+J0B8kdQt4B0ukWPJEIG/UlxgxNV41888kHfNoBAr
 kUwyGDwHwyxlzVAINEz92C/QA55bV1bZwa3G1ktFtc23eDoU8RUqsF8uQ
 jIIIoMJpopKw0DYxRIcwaBvKH7HgaOfzB7h9bZhl8gd9KsVz0EyHbx0Sk Q==;
IronPort-SDR: +v8u11Qp46K/ZDgd/EXFACB9iOp9n0LGAAX3HeOCClennyykhB2ZrhjifSgZnxHdRsmy+I45Kp
 teCUOa9hAp6WV8xw+N12cK793Ygzeekx1uLB+mQm2jpFygcKpM7g/U3lkdbTmhsSdIinujQa+i
 OpkzOfe7Ewkpjdbbd+S1Wi97iqE9t0NUgQs/szekdv0bBe/NpFaYxHgQIZLMkMAnh4e3vzJTxD
 f8l+cavVTpzRSOLZ87coZbJUS+byUtWiLaCs1R+tkdQqTA7jn8PE1r0rwWWF/yPba0k+fx597i
 Qh4=
X-IronPort-AV: E=Sophos;i="5.77,374,1596470400"; d="scan'208";a="253288621"
Received: from mail-bn8nam12lp2175.outbound.protection.outlook.com (HELO
 NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.175])
 by ob1.hgst.iphmx.com with ESMTP; 14 Oct 2020 21:08:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=itmvgyNUHhAyfR0hFqWosnqBeTuxoBBgrIGg0ZmFMQPIOpJ70xafsw+aYG/QttIdOJyc7AwziKr04dNeRCW+pAjNIbzGRWJcbIvu/B47DrY23H1tzsjVIIznTzsCKprSmtkbmfchs2r/ugxXXBqPz2NBgrMRhSUShOwjPZ2j36nl6Tjj668XB69xB6VYX8VWhPr1eCcFnHNf/qWKGBQuRSO1NR6PRTUiGHoZZ3K6nqggUyXGrcj72J1yxpWZswIMwZizJfdAj9tZ5So6el+fTlBwZaKumBN9egWPt5HJaqTK/ba4YJmz8nykrmj5XFPu3tnra312a63CpTUU/COJqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z+///nhheuN1H8zKxR77rrTWx4So7OoIj5UxiP/oH7U=;
 b=O2A+8UrlHKrrZHCc6cmL4zfP6M0O1071XdKbhMCaCxi+X2ZFuQqWu0XPdQfDHJwLaYEQs8sWXrlOu03QSgUzDTtL5yABSpUov7AGcLHwNUenPwz+DnjNu72jqEk67MEUjui16MQBht6J1KMFVHNIjlnm8PjmY7NwIU30/BAsRGvmVGepdOSmuuuwLHrxWQkuAX5ToMvyRmEvzY0MWZb9U318xZsV2Z472j2LFeUpM0lvfaPnh+h8nyhW0b01JzF3rFHNKW/uwliFsC+nCmgRkQgBUB98XrGJwJUmg31Ow5dIxorx2wY8TeR9Sy81bddwkGpWbju0MJBJ3H7wBM5WMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z+///nhheuN1H8zKxR77rrTWx4So7OoIj5UxiP/oH7U=;
 b=eAQsFP+uk9hbYNtzpwmuvJtG92laMdBNmIQn+vW2zW02h+vMscqzb3gJdTVRUJapc/fOJ5ti6wMBiFFfgAApUNpV/mQsguYfgPb7gK8YdQqgw/h3wU1+YZ7N74fYknxhGlIHcq1nfNH2oDuuAu1g3dZZmZJqerMMRSPg97or8/k=
Received: from DM6PR04MB5483.namprd04.prod.outlook.com (2603:10b6:5:126::20)
 by DM6PR04MB6476.namprd04.prod.outlook.com (2603:10b6:5:1f0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Wed, 14 Oct
 2020 13:01:25 +0000
Received: from DM6PR04MB5483.namprd04.prod.outlook.com
 ([fe80::c8ee:62d1:5ed1:2ee]) by DM6PR04MB5483.namprd04.prod.outlook.com
 ([fe80::c8ee:62d1:5ed1:2ee%6]) with mapi id 15.20.3455.030; Wed, 14 Oct 2020
 13:01:25 +0000
From: Niklas Cassel <Niklas.Cassel@wdc.com>
To: Dmitry Fomichev <Dmitry.Fomichev@wdc.com>
Subject: Re: [PATCH v6 03/11] hw/block/nvme: Add support for Namespace Types
Thread-Topic: [PATCH v6 03/11] hw/block/nvme: Add support for Namespace Types
Thread-Index: AQHWoam/e3I6NbvhxEW/Kkz40073IKmXEOkA
Date: Wed, 14 Oct 2020 13:01:25 +0000
Message-ID: <20201014130124.GA133631@localhost.localdomain>
References: <20201013214212.2152-1-dmitry.fomichev@wdc.com>
 <20201013214212.2152-4-dmitry.fomichev@wdc.com>
In-Reply-To: <20201013214212.2152-4-dmitry.fomichev@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [85.226.244.4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 58534d81-59b9-4a99-5eb2-08d8704141ea
x-ms-traffictypediagnostic: DM6PR04MB6476:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR04MB6476DC5A0E13083776DB65C8F2050@DM6PR04MB6476.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7yz1MBIx7H9kVWGXvhMaJ2uWMMqcKBdBR2igtPySEzBiRBuUOdrT1EGjYtL1PXQl8lf6/sBUWykytw66+2pXs7dljj+bjryiBgkccaNToRhjJb4N0nNDjdW6gCPp8WJJ2GbsWtbx7tCCVfBWvJJ9URsDjqQUZrHBhgnWR8C+pEzbVcoTjRVR9xQTwLsMl6jFgSTWlS9lKcOVtzF/7jQo7f4RnkzBHvaEQe6UN8WTuayeTnvMW8vsBk2RLWjLzmpIpYJjLXh6jUoxyZ4K4wXKOZJMWQYHfDZoUEP9ZN1d33dNUWfiPVVoAZ0cka5apOcx/+9qBHLQmPjor2YXvb8qrQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR04MB5483.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(39860400002)(136003)(376002)(366004)(2906002)(66476007)(64756008)(91956017)(66446008)(76116006)(66556008)(1076003)(6506007)(83380400001)(8936002)(71200400001)(66946007)(4326008)(6512007)(6636002)(9686003)(6862004)(5660300002)(316002)(8676002)(54906003)(6486002)(86362001)(186003)(26005)(478600001)(33656002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: IpkzmQ+rhuRpOBw4a4zEh1qSnW9y9CszSeTWwDZVyM+nUxy2XgarQnxhepCfp4RHxAEfLJyz+5xwsU+2ibcx33cYozPk76pCmjL2gKKaDcA925KRded8UOHcq/vAmsBWyrO0GhLR/jVYiSxDAI6REhEkdKcrJV8wpbl1rOl8sIuRIUGF2Me9tbDYhcVmBONfQZzLTQ+EJL6H0bQ8z5a6S1FOaim4ZXn5KhkhFdQGMMNcXybM6/2z058a6TFl0gDdDDI4uzNiO8JTO9EeKPeRFJ157tghNwiC3EeHhBZI/5w2mrxIQzBqTzoEnk5E71cZI2QC43ScyTVjSUgoqKkGAr5RkunOMzLEh7hgxbCO/VFCPcKz8Sexwi19Tu8YS4+axkFuc4s92yF2roRDOS6uVByzRye7AjVF82pek6gMtA8EhY2psGCiwvvVe1PkwbHX20mv5DFqa/r26PAP96udqcs6JfB0j5LY540eAZL8STJxkTlFDUkWok6XjGR1NHIpYdwsrDGKSdrnOpSY9eN2u9n7Hnppnh8uCdwqBf9HccU6TbWSPEjZzhLFzzV7zCByrmBcOy3xLCJyoc50tdJaNAR0yRROQ8AwJj7BaUI7bLw+8Y9bpecP+tR61NbRF5c9BDCIsAnmcvZWhyVHoIygIg==
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <DEAB5863FCE9F74B809507A12D23839F@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB5483.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58534d81-59b9-4a99-5eb2-08d8704141ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2020 13:01:25.3389 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7Fc/vC1pvzPI/nV+OYBSjDZWjiCpMIsLlG0X2cYJe7sC9YQ+DvQbcBd6PCCYptm5qAyEOOMSrxMDpO5FOwVCpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6476
Received-SPF: pass client-ip=68.232.143.124;
 envelope-from=prvs=5492a5ee4=Niklas.Cassel@wdc.com; helo=esa2.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/14 09:01:39
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

On Wed, Oct 14, 2020 at 06:42:04AM +0900, Dmitry Fomichev wrote:
> From: Niklas Cassel <niklas.cassel@wdc.com>
>=20
> Define the structures and constants required to implement
> Namespace Types support.
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

(snip)

> @@ -2090,6 +2199,27 @@ static void nvme_clear_ctrl(NvmeCtrl *n)
>      n->bar.cc =3D 0;
>  }
> =20
> +static void nvme_select_ns_iocs(NvmeCtrl *n)
> +{
> +    NvmeNamespace *ns;
> +    int i;
> +
> +    for (i =3D 1; i <=3D n->num_namespaces; i++) {
> +        ns =3D nvme_ns(n, i);
> +        if (!ns) {
> +            continue;
> +        }
> +        ns->iocs =3D nvme_cse_iocs_none;
> +        switch (ns->csi) {
> +        case NVME_CSI_NVM:
> +            if (NVME_CC_CSS(n->bar.cc) !=3D NVME_CC_CSS_ADMIN_ONLY) {
> +                ns->iocs =3D nvme_cse_iocs_nvm;
> +            }
> +            break;
> +        }
> +    }
> +}
> +
>  static int nvme_start_ctrl(NvmeCtrl *n)
>  {
>      uint32_t page_bits =3D NVME_CC_MPS(n->bar.cc) + 12;
> @@ -2188,6 +2318,8 @@ static int nvme_start_ctrl(NvmeCtrl *n)
> =20
>      QTAILQ_INIT(&n->aer_queue);
> =20
> +    nvme_select_ns_iocs(n);
> +
>      return 0;
>  }
> =20
> @@ -2655,7 +2787,6 @@ int nvme_register_namespace(NvmeCtrl *n, NvmeNamesp=
ace *ns, Error **errp)
>      trace_pci_nvme_register_namespace(nsid);
> =20
>      n->namespaces[nsid - 1] =3D ns;
> -    ns->iocs =3D nvme_cse_iocs_nvm;
> =20
>      return 0;
>  }

Considering how tightly coupled the three above diffs are with the
Commands Supported and Effects log, and since patch 1 already adds
the ns->iocs checking in nvme_admin_cmd() and nvme_io_cmd(),
and since these three diffs are not really related to NS types,
I think they should be moved to patch 1.

It really helps the reviewer if both the ns->iocs assignment
and checking is done in the same patch, and introduced as early
as possible. And since this code is needed/valid simply to check
if ADMIN_ONLY is selected (even before NS Types were introduced),
I don't see any reason not to introduce them in to patch 1
together with the other ns->iocs stuff.

(We were always able to select a I/O Command Set using CC.CSS
(Admin only/None, or NVM), NS types simply introduced the ability
to select/enable more than one command set at the same time.)


Kind regards,
Niklas=

