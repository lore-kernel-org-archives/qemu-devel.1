Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FF60C4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 13:57:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8ADAF2224F
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 13:57:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="Ns7tGuwS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8ADAF2224F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59330 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUs98-0000nz-GQ
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 09:57:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33810)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1kUs6q-0007j8-DJ
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 09:55:28 -0400
Received: from mail-co1nam11on2051.outbound.protection.outlook.com
 ([40.107.220.51]:34400 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1kUs6h-0004Kl-M9
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 09:55:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lgS1uSRtzi5qq4IUW1LOledpn7gBk2t8aL5tnYVVIzpOhFtUP4J6Bi/H+qGwkQcen/fX70WWq9kREGw4pRnJw2Tjvodsdz+zgfyM7NrjC3Z7VwBEyeBEL0wUFRtEREh65ZQcvM2vfNzmV376x6ygiatlqi3wqsmxXwiAhFqAacsEvqq6NHlnBjjuRDiNxzGDJU5dBlCPmkYTFEj3v9iD5GVCLFOHJNNETfr3YV/Nt/bZkG6TpRmRcHYe0ZcDkYLZKNlshGGXPCF1Ul+CfDS8wgP+YFN9Zw/+V9e+o9+bTGJbGPOgPsD1ZBBGj+fXYGPUzEVN+CmaDmocR45S759I3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UdwIl5B6IX4SKD2dkBQGUZZwjOZRQ2kK2hahs6YhPMU=;
 b=W0MX+odDRMYTjlwxNHGeWdvdyeesiayJpXFCXKL++tznGL8BiLTUw7c+BtOevitQqrZer2YR3GzROE4oky95AltlzQdv0gN2oeAV7aOgFM8wlhEQd+vIFq7TEi05+lVbxV50sAi1kx7j4g2ARoBw7337v3PSX8M4EAX243jPdxMLHWmAlvwdDZTw587nXMxEeKOk/22dUN7x/FQFxgPu7tlBTVGNO6hR86pgEOPQLeR0rz7h/HcDPqPTfmC1bWESoYWc7HChac+8Izsk4LivfJE04NVFMSWi21IlSe6iXMptn54dgBcPOTywovZoHfaMtEbIb/Asy6uR1YjknB10Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UdwIl5B6IX4SKD2dkBQGUZZwjOZRQ2kK2hahs6YhPMU=;
 b=Ns7tGuwSrtVtJzmnqi/SkDssJTZwbXL9Xdz3m3vw81ogbTco9utLSJn5x4R/Di2zM+ERNTGZGwQZGAliAZrre88+JAL/k4Y+ZN/iYyZVaMVvAOws08xZ/Pif0MEf1B3ST7EayNkkrqF9ZmgDEB0WHwPvi+gCWUlKXY5AX+hukk0=
Received: from BY5PR02MB6772.namprd02.prod.outlook.com (2603:10b6:a03:206::11)
 by BY5PR02MB6275.namprd02.prod.outlook.com (2603:10b6:a03:1b6::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.25; Tue, 20 Oct
 2020 13:55:15 +0000
Received: from BY5PR02MB6772.namprd02.prod.outlook.com
 ([fe80::75ed:4271:263b:fd15]) by BY5PR02MB6772.namprd02.prod.outlook.com
 ([fe80::75ed:4271:263b:fd15%3]) with mapi id 15.20.3499.018; Tue, 20 Oct 2020
 13:55:15 +0000
From: Sai Pavan Boddu <saipava@xilinx.com>
To: Gerd Hoffmann <kraxel@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: RE: [PATCH v3 04/10] usb/xhci: fixup xhci kconfig deps
Thread-Topic: [PATCH v3 04/10] usb/xhci: fixup xhci kconfig deps
Thread-Index: AQHWprV8HwT4XRr0ckyxnjMy9KWlDamggKUw
Date: Tue, 20 Oct 2020 13:55:15 +0000
Message-ID: <BY5PR02MB6772CCC1445BA34D4CD5AF33CA1F0@BY5PR02MB6772.namprd02.prod.outlook.com>
References: <20201020074844.5304-1-kraxel@redhat.com>
 <20201020074844.5304-5-kraxel@redhat.com>
In-Reply-To: <20201020074844.5304-5-kraxel@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=xilinx.com;
x-originating-ip: [149.199.50.129]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9064e436-f2df-4f10-f9de-08d874ffc5a4
x-ms-traffictypediagnostic: BY5PR02MB6275:
x-microsoft-antispam-prvs: <BY5PR02MB62754A2055B8C596F58F6D21CA1F0@BY5PR02MB6275.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2089;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 77y6gKUYgrAf9aoyWKmsM6+SGUsYyjAhBFm7zW5dsTsNchaZfh2db43KibQkoqks/G3XybPgPsE3lOZUINVhXehZLUkuF/v7Uacs+XOpDVUOghQKkGO+HvQK9LV4ANS8cFEyIyyrwkhzVOqK9gGbJw+rtzoUDxUGbzLm/oxfYcI0lyO0sMEQHDfaDnNgi2BTJqOeLoNdpNgQ1mUuqTgL1w4d/NaqR6Whpe/c3zf5gclnnATgkroN0y/ePjOWtbYzrMV3g9vx2Xjg8547FEyDnT8DwJ2HjzKVZmPVCX4ehGp7rkRfeHW7fpiGnMuNxkLpFYMbOBqsL/EosjrGeExoHQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR02MB6772.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(396003)(136003)(366004)(346002)(376002)(39860400002)(186003)(54906003)(7696005)(478600001)(110136005)(316002)(6506007)(53546011)(7416002)(33656002)(26005)(71200400001)(76116006)(83380400001)(8676002)(2906002)(66446008)(8936002)(55016002)(4326008)(9686003)(5660300002)(52536014)(86362001)(66476007)(64756008)(66556008)(66946007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: /FrEvH3iDgnBzMshfD4cXDFfqkIYie5rsbuSqr4qZ/EbigFVOPqa4pE79jGUX+q93DlzK9vxMrGpssbWbl0myOFwqKlX8FW4G9rePGb0EB0LFt0K8jf4cGUPiO2DpUHg88jeJ8hdlaVpL0cfMKdo9X0Z42X1sBhsiffnKWNNjxFaQum9TGO5bNh7QuhDTtbGaORAE09Ok3aKeOI73PAUTspKJe+XU5wnkHcwN4aj5SgqYLUWmh7IA8FEUu2mNyPdBcP95WZepl/JZls5qEYXGUfNm58r0O6DhZ7U8b4EkXxglDtod2TbMfPLONplqfJgcYioyM22YUFQPmhlLcHnA+06GOrfYMJwZr7l2EjJoxnEuI95zT+76BjWgw5hXPQna73GQLmhtY+Ih3FHu0vBt77ooOJ6mkXfTaJlLRh4KVyuNajmFB3WAk5REfqIHxkqA1WF7xwX/yXpd4UesQYdWKQALCMSBYNTjAZpu98FClFRKXyaTFcZ+SuTjGhCEoE/0kPcla5U80Yo0w8ZYFAoKvYGQ8dwIdVkUnt1ZZXcYIDMAX0syDq9AsuokShVNzJyzYk8KgE4pzHuRvmOPKCzMSQhI6hWK5YYaS6qRLe7QtuECrRSR1MyGCAAQdUJ40b9ywGkMwJoswVl+WzySa359Q==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR02MB6772.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9064e436-f2df-4f10-f9de-08d874ffc5a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2020 13:55:15.3235 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GqJb5ySMY/MEncy+MybL1qs49IzsWFROhSSBs6SO8Ahbthoj1+zRjdSC2jM/dfEI0dxlG+wpOVCj5DphpB9F8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6275
Received-SPF: pass client-ip=40.107.220.51; envelope-from=saipava@xilinx.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 09:55:17
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

> -----Original Message-----
> From: Gerd Hoffmann <kraxel@redhat.com>
> Sent: Tuesday, October 20, 2020 1:19 PM
> To: qemu-devel@nongnu.org
> Cc: Sergio Lopez <slp@redhat.com>; Sai Pavan Boddu <saipava@xilinx.com>;
> Igor Mammedov <imammedo@redhat.com>; Michael S. Tsirkin
> <mst@redhat.com>; Marcel Apfelbaum <marcel.apfelbaum@gmail.com>;
> Paolo Bonzini <pbonzini@redhat.com>; Thomas Huth <thuth@redhat.com>;
> Richard Henderson <rth@twiddle.net>; Gerd Hoffmann <kraxel@redhat.com>;
> Eduardo Habkost <ehabkost@redhat.com>; Laurent Vivier
> <lvivier@redhat.com>
> Subject: [PATCH v3 04/10] usb/xhci: fixup xhci kconfig deps
>=20
> USB_XHCI does not depend on PCI any more.
> USB_XHCI_SYSBUS must select USB_XHCI not USB.
>=20
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
[Sai Pavan Boddu]=20
Looks clean now. I forgot to take care of this previously, this was one of =
our requirements initially.

Reviewed-by: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>

Regards,
Sai Pavan

> ---
>  hw/usb/Kconfig | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>=20
> diff --git a/hw/usb/Kconfig b/hw/usb/Kconfig index
> 4dd2ba9630cb..a674ce4c542e 100644
> --- a/hw/usb/Kconfig
> +++ b/hw/usb/Kconfig
> @@ -32,8 +32,6 @@ config USB_EHCI_SYSBUS
>=20
>  config USB_XHCI
>      bool
> -    default y if PCI_DEVICES
> -    depends on PCI
>      select USB
>=20
>  config USB_XHCI_PCI
> @@ -50,8 +48,8 @@ config USB_XHCI_NEC
>=20
>  config USB_XHCI_SYSBUS
>      bool
> -    default y if USB_XHCI
> -    select USB
> +    default y
> +    select USB_XHCI
>=20
>  config USB_MUSB
>      bool
> --
> 2.27.0


