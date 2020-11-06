Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A84AC2D0A3
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 12:00:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6766120720
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 12:00:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Fo4W6aRs";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="dtDC4FsQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6766120720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38536 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kb0QI-0005Pa-Ou
	for qemu-devel@archiver.kernel.org; Fri, 06 Nov 2020 07:00:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50634)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=5722031ee=Niklas.Cassel@wdc.com>)
 id 1kb0Og-0004FN-2R; Fri, 06 Nov 2020 06:59:14 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:18363)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=5722031ee=Niklas.Cassel@wdc.com>)
 id 1kb0Oc-0002y6-L8; Fri, 06 Nov 2020 06:59:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1604663950; x=1636199950;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=hE+G5dGBuX1n7nlPWc8ytB3VCwuyciGXObVPwBEAU+c=;
 b=Fo4W6aRsPG/Rw+dHzN2wlaV8Ke8FssQiooKS5p01qpYLM+TN3vfk8vVr
 /isnXMw6jJ5XojN9ONMSMM1QBlYTtKZjLACaim9FKeQ1EvN41qYC6Y8JC
 r6Geq6gf++0br9P3hW+wDCsKbC3pKBKC+Xl27TXOFHQIum8W7ggMRFUKY
 jAMg+//U6kQap8M4AVD6oYegPwUAeYB8IfWrh673up9yHth4TiejHtzEj
 XT7q65uVxoOCNWWW2p+n1oEQpX3gUsYNkTlb1S3e4gikcH7qKrRr5aofP
 BAnNFdYB0jcZjnpBLNQYTWF9J5QY9dPmFl7uJlbkKuSn0wqW4tLmkrHKs g==;
IronPort-SDR: DmqqKh8DDO4s474JB8avlSOhgh772CukBv9AnSlnaOi3o09wi5gua7dxDQ+oTaIIP28p7YWWD8
 qtCTYO68jtNh21SlHPvdd49IvXZvI0TIIK1euqV0vSggsEyjT80roXiPhTG/PeHgjvBecSeT5U
 kEVu1d+dfYWJzc5hnQkTamLfNy8Gmu/noMp/IVWLbvYAPs9na5T6HCreAnJQ9C6P8espeUO2F9
 p+OD1gjZbE/L1jyHof4QAnkNeLHqcvuFESoE1gZJ2Ze4MFSQ17Oj8CrK6iPDRzdOw07Z74Vdh6
 aMo=
X-IronPort-AV: E=Sophos;i="5.77,456,1596470400"; d="scan'208";a="156508173"
Received: from mail-bn8nam12lp2174.outbound.protection.outlook.com (HELO
 NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.174])
 by ob1.hgst.iphmx.com with ESMTP; 06 Nov 2020 19:59:05 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oPTJo2BDz7hmoKkDK5/GNaZe4RI26gEsDLiTrv8cpMf9lNknZN4TIVOZJe2MDHcKcu+bBlJJxlyXNbsItKbtrPZQ5msAmZBr3pJQmtY2vHKAx0XC7FJTDCQOscmsYxVTsZ0ptIoTw3R6EhG7y1UJtQK8YmSA7o2gc+Qp+HIucTAX4UcWy6MQC621YCBMNaxyLxZGkuF39gVtec/G2wHKYf8hTTXcN+s+x6LHihCVH1gd7uk6/MRpz6ileLQ+mQWZpNlETTLX8I96Yb/0C2MfYlqDx6ePbZN/ArLvc33JI2NSZ83lrvwcLdVM3OJBS5xva1i78jKqJDr8YZzUL4ePnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cyg7/VA9GyQ7VVDKbvegZSkqNxYJIoJYdJTawflJErI=;
 b=Cgbj2xv+32FwNql3028h4vIwwSDk/tjvha5MqD0karmrRdsV3ZLQKF+rghisduhB4i/1tZCgaoiQCFiYzqbgt/tafXgO4fDbNnUwH9GejQnpFGHXOTLn31+0vJKp/VHYPyghCI/6j4k3+ZXKn9rYGas9wRLZJqLjvilk4vj9+9MX+dV7vMVR1iaCaYUoMM/1r3zw9QMiZ63Qzogo1KiZj3Z+5r470w+sbIRGqOLAElL4C1oNaZ2AFR1vhZjy79juH/mNFA0/dLJNDKfSmiLga8FWVKmxv4qPwsSMgtNDyvHc84FejOE61Gxp6ddPMRmZqSnyQx5f89jJ+Ze4KWYG1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cyg7/VA9GyQ7VVDKbvegZSkqNxYJIoJYdJTawflJErI=;
 b=dtDC4FsQR1Srs+qHoXFZqQ3hR8YfLrow6OZuvgTPW46nvHQKxO7Clq5FoHIUHHHedJlzhrFeBsCB1SaLSLKPVXk7bsWaGgeIvYYxV9i2U0JdiPeQMDNwCzymv/sUhF1dP/Rg0OsZySuEKLeLB6jxRq06MNDlG/8qspNzYg6ti4M=
Received: from DM6PR04MB5483.namprd04.prod.outlook.com (2603:10b6:5:126::20)
 by DM6PR04MB6315.namprd04.prod.outlook.com (2603:10b6:5:1e4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.27; Fri, 6 Nov
 2020 11:59:04 +0000
Received: from DM6PR04MB5483.namprd04.prod.outlook.com
 ([fe80::c8ee:62d1:5ed1:2ee]) by DM6PR04MB5483.namprd04.prod.outlook.com
 ([fe80::c8ee:62d1:5ed1:2ee%6]) with mapi id 15.20.3499.032; Fri, 6 Nov 2020
 11:59:04 +0000
From: Niklas Cassel <Niklas.Cassel@wdc.com>
To: Dmitry Fomichev <Dmitry.Fomichev@wdc.com>
Subject: Re: [PATCH v9 08/12] hw/block/nvme: Support Zoned Namespace Command
 Set
Thread-Topic: [PATCH v9 08/12] hw/block/nvme: Support Zoned Namespace Command
 Set
Thread-Index: AQHWsx7wguGmqxJQhkusvOgBtX9HUqm7AjKA
Date: Fri, 6 Nov 2020 11:59:03 +0000
Message-ID: <20201106115903.GA345539@localhost.localdomain>
References: <20201105025342.9037-1-dmitry.fomichev@wdc.com>
 <20201105025342.9037-9-dmitry.fomichev@wdc.com>
In-Reply-To: <20201105025342.9037-9-dmitry.fomichev@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [85.226.244.4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 23307296-5319-426c-1398-08d8824b5b7c
x-ms-traffictypediagnostic: DM6PR04MB6315:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR04MB63150BE1F8E3F373D6E3BA5EF2ED0@DM6PR04MB6315.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: P8/FY+eW9cwKC9WjBBP9Gc4RGrDBEo9fGzaaOqyJxffp3bG9O22PMbG7ih4GVaMAeoiz8ThnJNhAAOVReb7ClJcIz4W7P1MdJgc9CtSY3+RmtPHDNcXr5lRu/Qn5vDCaG+UmpdnudwfcyqKDtDLt5h/7sh2thslNqC/YxUtwVISUCigpjR32IXvcJpd+0zRVk2QeOyOTwyxZLteikX0efgcnfFQg32qKvAPcMzXWqJ6cO1OTYovKTnLptZQXrJPkebmul0vSCE6juFjQe4aqhnjshgvjJGWBHezVCNpC7QpqqjmdH0tLxx2hhqmGs9y4o0YETOW4vOOQmvCibYLBFw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR04MB5483.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(366004)(396003)(136003)(39860400002)(9686003)(54906003)(6512007)(8676002)(6862004)(66476007)(66446008)(2906002)(316002)(26005)(83380400001)(4326008)(33656002)(1076003)(86362001)(478600001)(186003)(66946007)(64756008)(6486002)(5660300002)(71200400001)(8936002)(91956017)(76116006)(6506007)(6636002)(66556008);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: h0JeA+bP5Va50x9+yvmaAxlGvWX5JiJXWFJZLlLYpz8tArrQxLpgFVMFe4Cj7pItZOFNzpnmSlwgQ7wgjEvM9l0XCBo0rTSGrUHLBSKD10N10fWhcYIXybWNDQPwbkS+XXcNsaf21pc1Ckh+y84JBkU2dZsheWmUqUuZBw+jFTdRhw/+3kL+Iv9S3D11rAlEgr8wCqspCRMlHxTAcrG6EjXFuxDF9pCsbFpg2l8NpcD7sAkkTUbVpDSrvkWHUgyllc03mwt8gTtFvJWZ/30iH7ovuCK0zWpdQEk6KGu+Xk1e234xnLwFwtiXj8bez/JN1J534lLarYWC6FONyOSe+Cs11n20oTYVrafyWFIkuPp7TOIf2u4j0zQQ1bQ454Zsa9Jc0adLcgCkLq8MTNuPM268E6JJuhZGlZJnNMlrRBQgD4OpS5SuZju8d+W9h5PV0572UOoIlavUkRh9kk9tGMxRVFEqo+RNhLfZbkBBNMMwltauUz+vBmdq1HW4t4ljXlc8rgyRtIF1Md1QSEgWJVq/tRcNQMEVWPwTX5UDY+y1RdBfOYOkhnJD/QNb9zP7S8K+HBqQW0Bb9lDOBuQFAN42o4Z17QEC4W0ATSIG2ZKeoGEAhySp7QwELhZrqdYNSnrpNU66QOjOgDlo0Jw8SQ==
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <BD94B89FED5B0F4C9B74600E8D2E715E@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB5483.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23307296-5319-426c-1398-08d8824b5b7c
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2020 11:59:03.9902 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vtSP9M3NJFC1/MfBVHbma/8fTkQ69Q4gQGm35VhmdF8hCL98l61LErMQi/RfNoRbbSGW1fDWkj/deAtkqMBVBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6315
Received-SPF: pass client-ip=216.71.153.141;
 envelope-from=prvs=5722031ee=Niklas.Cassel@wdc.com; helo=esa3.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/06 06:59:07
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

On Thu, Nov 05, 2020 at 11:53:38AM +0900, Dmitry Fomichev wrote:
> The emulation code has been changed to advertise NVM Command Set when
> "zoned" device property is not set (default) and Zoned Namespace
> Command Set otherwise.
>=20
> Define values and structures that are needed to support Zoned
> Namespace Command Set (NVMe TP 4053) in PCI NVMe controller emulator.
> Define trace events where needed in newly introduced code.
>=20
> In order to improve scalability, all open, closed and full zones
> are organized in separate linked lists. Consequently, almost all
> zone operations don't require scanning of the entire zone array
> (which potentially can be quite large) - it is only necessary to
> enumerate one or more zone lists.
>=20
> Handlers for three new NVMe commands introduced in Zoned Namespace
> Command Set specification are added, namely for Zone Management
> Receive, Zone Management Send and Zone Append.
>=20
> Device initialization code has been extended to create a proper
> configuration for zoned operation using device properties.
>=20
> Read/Write command handler is modified to only allow writes at the
> write pointer if the namespace is zoned. For Zone Append command,
> writes implicitly happen at the write pointer and the starting write
> pointer value is returned as the result of the command. Write Zeroes
> handler is modified to add zoned checks that are identical to those
> done as a part of Write flow.
>=20
> Subsequent commits in this series add ZDE support and checks for
> active and open zone limits.
>=20
> Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
> Signed-off-by: Hans Holmberg <hans.holmberg@wdc.com>
> Signed-off-by: Ajay Joshi <ajay.joshi@wdc.com>
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> Signed-off-by: Matias Bjorling <matias.bjorling@wdc.com>
> Signed-off-by: Aravind Ramesh <aravind.ramesh@wdc.com>
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> Signed-off-by: Adam Manzanares <adam.manzanares@wdc.com>
> Signed-off-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
> Reviewed-by: Niklas Cassel <Niklas.Cassel@wdc.com>
> ---
>  hw/block/nvme-ns.h    |  54 +++
>  hw/block/nvme.h       |   8 +
>  hw/block/nvme-ns.c    | 173 ++++++++
>  hw/block/nvme.c       | 971 +++++++++++++++++++++++++++++++++++++++++-
>  hw/block/trace-events |  18 +-
>  5 files changed, 1209 insertions(+), 15 deletions(-)
>=20

(snip)

> +static uint16_t nvme_zone_mgmt_recv(NvmeCtrl *n, NvmeRequest *req)
> +{
> +    NvmeCmd *cmd =3D (NvmeCmd *)&req->cmd;
> +    NvmeNamespace *ns =3D req->ns;
> +    /* cdw12 is zero-based number of dwords to return. Convert to bytes =
*/
> +    uint32_t data_size =3D (le32_to_cpu(cmd->cdw12) + 1) << 2;
> +    uint32_t dw13 =3D le32_to_cpu(cmd->cdw13);
> +    uint32_t zone_idx, zra, zrasf, partial;
> +    uint64_t max_zones, nr_zones =3D 0;
> +    uint16_t ret;
> +    uint64_t slba;
> +    NvmeZoneDescr *z;
> +    NvmeZone *zs;
> +    NvmeZoneReportHeader *header;
> +    void *buf, *buf_p;
> +    size_t zone_entry_sz;
> +
> +    req->status =3D NVME_SUCCESS;
> +
> +    ret =3D nvme_get_mgmt_zone_slba_idx(ns, cmd, &slba, &zone_idx);
> +    if (ret) {
> +        return ret;
> +    }
> +
> +    zra =3D dw13 & 0xff;
> +    if (zra !=3D NVME_ZONE_REPORT) {
> +        return NVME_INVALID_FIELD | NVME_DNR;
> +    }
> +
> +    zrasf =3D (dw13 >> 8) & 0xff;
> +    if (zrasf > NVME_ZONE_REPORT_OFFLINE) {
> +        return NVME_INVALID_FIELD | NVME_DNR;
> +    }
> +
> +    if (data_size < sizeof(NvmeZoneReportHeader)) {
> +        return NVME_INVALID_FIELD | NVME_DNR;
> +    }
> +
> +    ret =3D nvme_map_dptr(n, data_size, req);

nvme_map_dptr() call was not here in v8 patch set.

On v7 I commented that you were missing a call to nvme_check_mdts().
I think you still need to call nvme_check_mdts in order to verify
that data_size < mdts, no?

This function already has a call do nvme_dma(). nvme_dma() already
calls nvme_map_dptr().
If you use nvme_dma(), you cannot use nvme_map_dptr().

It will call nvme_map_addr() (which calls qemu_sglist_add()) on the
same buffer twice, causing the qsg->size to be twice what the user
sent in. Which will cause the:

        if (unlikely(residual)) {

check in nvme_dma() to fail.


Looking at nvme_read()/nvme_write(), they use nvme_map_dptr()
(without any call to nvme_dma()), and then use dma_blk_read() or
dma_blk_write(). (and they both call nvme_check_mdts())


Kind regards,
Niklas

> +    if (ret) {
> +        return ret;
> +    }
> +
> +    partial =3D (dw13 >> 16) & 0x01;
> +
> +    zone_entry_sz =3D sizeof(NvmeZoneDescr);
> +
> +    max_zones =3D (data_size - sizeof(NvmeZoneReportHeader)) / zone_entr=
y_sz;
> +    buf =3D g_malloc0(data_size);
> +
> +    header =3D (NvmeZoneReportHeader *)buf;
> +    buf_p =3D buf + sizeof(NvmeZoneReportHeader);
> +
> +    while (zone_idx < ns->num_zones && nr_zones < max_zones) {
> +        zs =3D &ns->zone_array[zone_idx];
> +
> +        if (!nvme_zone_matches_filter(zrasf, zs)) {
> +            zone_idx++;
> +            continue;
> +        }
> +
> +        z =3D (NvmeZoneDescr *)buf_p;
> +        buf_p +=3D sizeof(NvmeZoneDescr);
> +        nr_zones++;
> +
> +        z->zt =3D zs->d.zt;
> +        z->zs =3D zs->d.zs;
> +        z->zcap =3D cpu_to_le64(zs->d.zcap);
> +        z->zslba =3D cpu_to_le64(zs->d.zslba);
> +        z->za =3D zs->d.za;
> +
> +        if (nvme_wp_is_valid(zs)) {
> +            z->wp =3D cpu_to_le64(zs->d.wp);
> +        } else {
> +            z->wp =3D cpu_to_le64(~0ULL);
> +        }
> +
> +        zone_idx++;
> +    }
> +
> +    if (!partial) {
> +        for (; zone_idx < ns->num_zones; zone_idx++) {
> +            zs =3D &ns->zone_array[zone_idx];
> +            if (nvme_zone_matches_filter(zrasf, zs)) {
> +                nr_zones++;
> +            }
> +        }
> +    }
> +    header->nr_zones =3D cpu_to_le64(nr_zones);
> +
> +    ret =3D nvme_dma(n, (uint8_t *)buf, data_size,
> +                   DMA_DIRECTION_FROM_DEVICE, req);
> +
> +    g_free(buf);
> +
> +    return ret;
> +}
> +=

