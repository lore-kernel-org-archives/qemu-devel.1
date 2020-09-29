Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73F3BC4346E
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 07:00:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 954FB2083B
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 07:00:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="lYMVdCNy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 954FB2083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51800 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kN9cR-0003dw-6K
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 03:00:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52744)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1kN9as-0002uu-Bx
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 02:58:34 -0400
Received: from mail-bn8nam12on2083.outbound.protection.outlook.com
 ([40.107.237.83]:33056 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1kN9ao-0006kb-5M
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 02:58:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UJCoWnw1ZkgUibIymRxecDjqRkm0WsLmGQjTlZ/9S8iSpc9hlNh++8rj7ZmnqEafeZyC3LocWsVsRGbedgJVQbLAh38t+w9uAe+cOyGEiBiKPAgjb4Tx8vodRWpT7WX9O9eY67JDnUYPEUHybkIcW2vF+/Cb7Xwti+Sb5tOjkADvEz2+wD1plAUlXxrF2ju8q5GDkh3qd744ShOIdlBDYL22uYVQbork7JcrwSj7q21YYUMde3TLxWgv5FRdei1M3Z2pXMn+grf208diRlrev1wQl/7btiDlVRaGyXLssLSNE9Ep3C4GkcPknjHDCpWfb7cn2pOCbc69AtUV0N6EeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=510SSB/zK9/FTMvlydTAvdUjsDf5SbsX80/b0ZzGiOo=;
 b=drXqr92ZedixOOuQfqzsDzV+WwhsWunJkAD2u9fiPd9+WCHXncA+bI2mJbW5wW0qJTndlbLN5yrSNEEmauYXGc4EdXcqi//ul7KEK5EhRq4ZLeP6GqftCFYaKLeE/do0ubPZv7VVMj0tjVKNBtQ2bcPCiEVnmDH6MmKdacwljc6/3lHtlHOFppkgkbr0OuksXJwN7WVqPsIHFL0NJ87+62jn8h2oWcpHVOw2B7pz+pKzxnRUnoIxW580g8zFcAMTq8iUzxLAeVFXopWVXrRrEMqhWjlwYyLpe7XTPl7ouNIHei1KjMl2zPbTB/vFfSZyAaF63bvZU3t2Lk4MD/jg/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=510SSB/zK9/FTMvlydTAvdUjsDf5SbsX80/b0ZzGiOo=;
 b=lYMVdCNy7hY88K7d8yR3Rb9OgjggTFV+YoKqc6FpcB0ePBY+x6Q0hxEKVOu5jE7ZSw2L4OuljzQuAJB7awC1knRncfjeM9N6L6VYtsuQZ4Bwy6MbGNTuXV5o+lY6NxAtUmeEx14QJSzHzw7L3SIH7S8/TcHTWKSoUkOWg4GHAQI=
Received: from BY5PR02MB6772.namprd02.prod.outlook.com (2603:10b6:a03:206::11)
 by BYAPR02MB4792.namprd02.prod.outlook.com (2603:10b6:a03:4a::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.28; Tue, 29 Sep
 2020 06:58:21 +0000
Received: from BY5PR02MB6772.namprd02.prod.outlook.com
 ([fe80::68a7:8ea6:8731:d69f]) by BY5PR02MB6772.namprd02.prod.outlook.com
 ([fe80::68a7:8ea6:8731:d69f%4]) with mapi id 15.20.3412.029; Tue, 29 Sep 2020
 06:58:20 +0000
From: Sai Pavan Boddu <saipava@xilinx.com>
To: Gerd Hoffmann <kraxel@redhat.com>, Edgar Iglesias <edgari@xilinx.com>
Subject: RE: [PATCH v10 7/7] Versal: Connect DWC3 controller with virt-versal
Thread-Topic: [PATCH v10 7/7] Versal: Connect DWC3 controller with virt-versal
Thread-Index: AQHWkn4NObfrliwoYESqClEcN+w/eKl5sX8AgARcVYCAASi6cA==
Date: Tue, 29 Sep 2020 06:58:20 +0000
Message-ID: <BY5PR02MB6772C79EDB5F7CC0BEDBB5DECA320@BY5PR02MB6772.namprd02.prod.outlook.com>
References: <1600957256-6494-1-git-send-email-sai.pavan.boddu@xilinx.com>
 <1600957256-6494-8-git-send-email-sai.pavan.boddu@xilinx.com>
 <20200925183946.GP4142@toto>
 <20200928131517.hmczcqisasv47tls@sirius.home.kraxel.org>
In-Reply-To: <20200928131517.hmczcqisasv47tls@sirius.home.kraxel.org>
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
x-ms-office365-filtering-correlation-id: 733bdb80-ce58-4634-f335-08d864450d1f
x-ms-traffictypediagnostic: BYAPR02MB4792:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR02MB4792189CE709B9248CBC7DF9CA320@BYAPR02MB4792.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YcOryz9/i7zKq+eaGPy2t3obZvibgVOyBiaFI1xMCL8/x+8FLQMYSHvhCAKvbdSs5p8+KOIuhbgEyhLpZO/pvlN4JOdl93AuLtfiFYlUhpMzHOSDCZDcFz5NwKzVpz7qpLisknNS+sO6GgxTGeAeiObf5j2wJeNqJ/KnX1GzQwOeWEJ75EZME+1/b/5MeMYKlcJCLAnL3uItXHwuI2AqMSon9RJgy9qlhGEeavAlPlugmVIWN8f0p9uH3P/i1rFgjzeQ3v68BDLxy7AGrFLwaZvvlUtkw2ZptO7PYCpaA68SA4AfplNLL+o5AQsheABp7DwWAJ9RS+vB+v2yTC+sDC1aKvnT86ak6d6D8d4hxHXlv/zI9wj5J6UHTgCysA8n
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR02MB6772.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(39860400002)(376002)(346002)(396003)(136003)(55016002)(52536014)(53546011)(316002)(110136005)(54906003)(6506007)(186003)(4326008)(26005)(66556008)(83380400001)(86362001)(33656002)(66476007)(71200400001)(64756008)(66446008)(5660300002)(478600001)(76116006)(9686003)(66946007)(6636002)(2906002)(7416002)(8676002)(7696005)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: tCDubSeSRg3ypF9FR8NGdYTHa1hdFrYKDzeuUDyXHhh/zmzD7g8OD51N7G53ZoKY9L/mL5pcfuxtKhGhYIDOi8D6oObnZxYFv8vUYvWFph6FWVSLYCe5hUE9OX7wXUrZaCBP69VSiUkr/yQp0wvQQv3P6to434ijzoUdrFChsF1McS1b7V0eTo/zVwH+7mPoCttXx5LtMxwSmhSvlco/F42tEbyCujAad4cFbxiWvT6f1jtug83raV6Gdm2mGpdVsqjf2ouZ0Yv4wpFN+aDlnCgX0/Q9qFSBNradt6LcVSLDag697A0YvZNh03pOmoKedTKDqjaVDzjMYKvhQxBMJsHP/2u0LNnWYPjQ2rw+TEQIpFxylsqqLX/Go/TQolCzLlpgQvnEfVlq1LOgfq9VahENmYH5pjoV3dW1rcxdNjHCRbJ7R0bP73g51JPiqsnSV4ngstpFYwKoUngwMnz3vi2NAlrsvHRKw655gDTd9y7yCzy9Z6D9Jj+gPikaOndtC2hLDUzYHHRPwZzbe+krXQl1nlWNqfjxWTlw+i+bLpsjJiT97X4LmS4/yvIqR29LIeZk/5BwSMufOj+6Jv9vzEDK/Pn8tiGAcQv64mABGo2olnliVZx7lfFjYBbNvbupmEXFaK3eQnZdGdPXwhk9lA==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR02MB6772.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 733bdb80-ce58-4634-f335-08d864450d1f
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2020 06:58:20.4492 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KXAI4qMhrLV1lXo2wHwJy7a7JRViVmzpUbNvRQH3R6cVjshy4ZMJ0nasbBgSkmsbZc36KSJD4vtFnKnO7oOfTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4792
Received-SPF: pass client-ip=40.107.237.83; envelope-from=saipava@xilinx.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/29 02:58:28
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.614,
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
Cc: Francisco Eduardo Iglesias <figlesia@xilinx.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Vikram Garhwal <fnuv@xilinx.com>,
 Markus Armbruster <armbru@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Edgar Iglesias <edgari@xilinx.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?iso-8859-1?Q?=27Marc-Andr=E9_Lureau=27?= <marcandre.lureau@redhat.com>,
 Ying Fang <fangying1@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Paul Zimmerman <pauldzim@gmail.com>,
 =?iso-8859-1?Q?=27Philippe_Mathieu-Daud=E9=27?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Gerd,

> -----Original Message-----
> From: Gerd Hoffmann <kraxel@redhat.com>
> Sent: Monday, September 28, 2020 6:45 PM
> To: Edgar Iglesias <edgari@xilinx.com>
> Cc: Sai Pavan Boddu <saipava@xilinx.com>; Peter Maydell
> <peter.maydell@linaro.org>; Markus Armbruster <armbru@redhat.com>;
> 'Marc-Andr=E9 Lureau' <marcandre.lureau@redhat.com>; Paolo Bonzini
> <pbonzini@redhat.com>; Edgar Iglesias <edgari@xilinx.com>; Francisco
> Eduardo Iglesias <figlesia@xilinx.com>; qemu-devel@nongnu.org; Alistair
> Francis <alistair.francis@wdc.com>; Eduardo Habkost
> <ehabkost@redhat.com>; Ying Fang <fangying1@huawei.com>; 'Philippe
> Mathieu-Daud=E9' <philmd@redhat.com>; Vikram Garhwal
> <fnuv@xilinx.com>; Paul Zimmerman <pauldzim@gmail.com>; Sai Pavan
> Boddu <saipava@xilinx.com>
> Subject: Re: [PATCH v10 7/7] Versal: Connect DWC3 controller with virt-ve=
rsal
>=20
> On Fri, Sep 25, 2020 at 08:39:46PM +0200, Edgar E. Iglesias wrote:
> > On Thu, Sep 24, 2020 at 07:50:56PM +0530, Sai Pavan Boddu wrote:
> > > From: Vikram Garhwal <fnu.vikram@xilinx.com>
> > >
> > > Connect dwc3 controller and usb2-reg module to xlnx-versal SOC, its
> > > placed in iou of lpd domain and configure it as dual port host
> > > controller. Add the respective guest dts nodes for "xlnx-versal-virt"
> machine.
> >
> > Hi Sai,
> >
> > One minor comment inline.
>=20
> Cherry-picked patches 1-4 for the usb queue, leaving 5-7 for later (or ma=
ybe
> the arm queue).
[Sai Pavan Boddu] Thanks,=20
I would make new patch series for pending ones.

Regards,
Sai Pavan
>=20
> take care,
>   Gerd


