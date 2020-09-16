Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAE41C43461
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 14:18:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E11722242
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 14:18:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="jeTu5u+u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E11722242
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49062 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIYGL-0000IB-Dw
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 10:18:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38986)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1kIYFC-00083t-Bv
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 10:17:11 -0400
Received: from mail-bn7nam10on2072.outbound.protection.outlook.com
 ([40.107.92.72]:14048 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1kIYFA-0003TF-Gk
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 10:17:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eY2u3wyxNfqsTrTZ1XYcUP0CFKuE9D1c65jvh3c23t47BtXBtJBGSExJ5N+nBhVujzrJ4zLJBnI/W7qUkBWEnOOTYQA2kKmbrXxjsdXoCM3jy30yOjXBO45E/cg8YZ08O0qwtWZ7FntT2Qkz8HsuGQjBjurs+SymLbrhY7XB7ZECkNH5XcGHUbc9S2NHDIu/5CsGXum3qvZ9AoYj0kIAh4T2JTFGdV+Y3EvspAFbcyoU8GA/KZzUY1484YFT4CsvM2uaK+tZbFk4kQ2ZPFon7rPstyKc/n8kZbTP5XMhBJfV7QUaAqFFyvG3MsT1C4RvLVlOIFhL8GPdj6pNSdqJfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sN5d7HC+6/h/NMgQgMdLj0eHVc/Pkl0F9msHYoy747w=;
 b=GI2ET9eXLXpgs1/zQBq/8iynZejvciQBULNERbL3YN4fpPRzo99GHm2TQBZkwDZOW5gPAQzN7reAIywt73eFCJ591ek4GDAo/OPrD0YZMTkL1UhoN/hTzV4XYlR/3VjNXO3D7TG51Ir17QLHUaUXtoluncyO45Sd16uoQi0v4C06GZ56pmH9OwDswpnZWWdaYjjs5XERFD/KFPkdKgk+wXPqSjy8Ty2KZxaIgHs1/2c1/4lMCnIM5QJUM88ZM3IEDOyBqviEZ64F6Ga6qiUjSLNqKewRB6NrAnIPHtxB5ukPMAt6qzaiCesmF7HSi8DhaagsusgdfkdVWUv53yi9Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sN5d7HC+6/h/NMgQgMdLj0eHVc/Pkl0F9msHYoy747w=;
 b=jeTu5u+u3nHA5OlF3a3Z+FPYGBQbVAEhowYGeZmtGzvRSUGVZehRAezj9oDoNH98wYKWK/Z6XeyK9Md1n3JgGsNeyVpA4sC1M1I7iqOK43KtKRhq99U8Dvk9YU3iZbFLvxIFVOkD8YuRIPgGzumRnHfV9edqTLCaEgqfwzjIcts=
Received: from BY5PR02MB6772.namprd02.prod.outlook.com (2603:10b6:a03:206::11)
 by BY5PR02MB6502.namprd02.prod.outlook.com (2603:10b6:a03:1da::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.19; Wed, 16 Sep
 2020 14:17:06 +0000
Received: from BY5PR02MB6772.namprd02.prod.outlook.com
 ([fe80::1007:f094:45c9:bb47]) by BY5PR02MB6772.namprd02.prod.outlook.com
 ([fe80::1007:f094:45c9:bb47%8]) with mapi id 15.20.3370.019; Wed, 16 Sep 2020
 14:17:06 +0000
From: Sai Pavan Boddu <saipava@xilinx.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: RE: [PATCH v6 5/7] misc: Add versal-usb2-ctrl-regs module
Thread-Topic: [PATCH v6 5/7] misc: Add versal-usb2-ctrl-regs module
Thread-Index: AQHWjB4EKGfHRFGdX02c3BO/ym2tfqlrKkIAgAAlVBA=
Date: Wed, 16 Sep 2020 14:17:06 +0000
Message-ID: <BY5PR02MB6772337EC26D9C4141AE3D95CA210@BY5PR02MB6772.namprd02.prod.outlook.com>
References: <1600256469-13130-1-git-send-email-sai.pavan.boddu@xilinx.com>
 <1600256469-13130-6-git-send-email-sai.pavan.boddu@xilinx.com>
 <20200916120228.e5hrxabhwde2gl6u@sirius.home.kraxel.org>
In-Reply-To: <20200916120228.e5hrxabhwde2gl6u@sirius.home.kraxel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=xilinx.com;
x-originating-ip: [149.199.50.130]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a9a48c1e-daa9-4405-1707-08d85a4b3115
x-ms-traffictypediagnostic: BY5PR02MB6502:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR02MB650223ADE5E07C9A06751194CA210@BY5PR02MB6502.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: moNoPUfXvOHHrHYbxzhsUfStKuO2B/5vTSzibL1x9n+zJYGPMFsR3CZkt5PjhOyY6oQoE3OzA+1u68HFveQbBXtBokIrw9y30/Kizn3GK/Hwi0Q5zK10XTi6urZXQD8n8QdNspWGrm1i2wT7xuyZtTO/HWXWZnVQTXkmRPtReocTpGUxS+dkrLcMaAnu9Qm+T/j/1kr/obfyMQcSh79GjtduitYPZW+bV0j8I1vKrZBxeOnRt5BSmSOuRbuwWGcezM9jTbs2J0wXFunfh1ahDfSRIs+jAdKopaJJCjQjl8uKu+31ZJZHaegC3PUvXkZUvq0bZ5NaXouvNxcYk5FVug==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR02MB6772.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(136003)(396003)(39850400004)(376002)(346002)(366004)(8676002)(2906002)(4326008)(83380400001)(76116006)(71200400001)(6916009)(8936002)(7416002)(9686003)(86362001)(55016002)(66946007)(66446008)(64756008)(66556008)(66476007)(5660300002)(26005)(186003)(478600001)(6506007)(54906003)(7696005)(52536014)(316002)(53546011)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: w2yeLB88GojPNIlXjateocQcXE7sMqN4YHLGHS4R/ukaue7/8f5eQJpK4DzvbGUS+N6Z6x8sELFMXK1gtMCihw9CcvSmW5YLUQCkVjHsjWKcJ+gw9SSCbW6eorlD/vCN+52/SMJ1PqwLRh2ldSWF6WdLXApbRHw1rGDp+iXGEmIcJGqWc6vdhhY6Ln2fQVjNSWGhE1+XekNTQPbl42ACSXB7/+KGtCKZAZfCcbVXFtJ/O6RnCCMU2lmEa3KaKZV8a2wzRGfr0ZF7Wvhsdtq9eJ/M4D/+tApynEOvW9Bf7NtyjFCmH0s8ToGJVmWyovZaE5P3upqFfjG+ctQNIWpWLoSGLH1LgzC3InaTX4dmbDsQNXHqxFB8NvFqTgVwc+GDylbBQUMdjO8o7gdJnzVLZgBAEtGHzSDLD8WdH9lQLuw59x9FRnA6mLZrOXYMnJIvrdgJSrpErMEJn9y6GxQcR3nj4NliirKMiLxoVq1jlvf6oLPdECUcJ1Hx8qfZwUgiPG4GUMEbnaLQq4bRpUPDJr5bAmtyxjT6lmMX8H2aDEU4smsaShxGpREGUqtyebOS+i2rJiOlpFwxstuPdxEdrX9N5PpzXud+zV91X9JJ5V8ow8s3P7qHq6rV3bBuF3gl4mYAvUCM4qJpkI0Vz1FeXQ==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR02MB6772.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9a48c1e-daa9-4405-1707-08d85a4b3115
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2020 14:17:06.3914 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nZE9Yr9icUTKFXxB4dcmK9cxGoEMkaUi/JwSMo1rbKISArKEsb9vXeVMHjJhQ93ohYfOeT2K7xGYw2ZZBchQHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6502
Received-SPF: pass client-ip=40.107.92.72; envelope-from=saipava@xilinx.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 10:17:07
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
> Sent: Wednesday, September 16, 2020 5:32 PM
> To: Sai Pavan Boddu <saipava@xilinx.com>
> Cc: Peter Maydell <peter.maydell@linaro.org>; Markus Armbruster
> <armbru@redhat.com>; 'Marc-Andr=E9 Lureau'
> <marcandre.lureau@redhat.com>; Paolo Bonzini <pbonzini@redhat.com>;
> Edgar Iglesias <edgari@xilinx.com>; Francisco Eduardo Iglesias
> <figlesia@xilinx.com>; qemu-devel@nongnu.org; Alistair Francis
> <alistair.francis@wdc.com>; Eduardo Habkost <ehabkost@redhat.com>;
> Ying Fang <fangying1@huawei.com>; 'Philippe Mathieu-Daud=E9'
> <philmd@redhat.com>; Vikram Garhwal <fnuv@xilinx.com>; Paul
> Zimmerman <pauldzim@gmail.com>; Sai Pavan Boddu
> <saipava@xilinx.com>
> Subject: Re: [PATCH v6 5/7] misc: Add versal-usb2-ctrl-regs module
>=20
> On Wed, Sep 16, 2020 at 05:11:06PM +0530, Sai Pavan Boddu wrote:
> > This module emulates control registers of versal usb2 controller, this
> > is added just to make guest happy. In general this module would
> > control the phy-reset signal from usb controller, data coherency of
> > the transactions, signals the host system errors received from controll=
er.
> >
> > Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
> > Signed-off-by: Vikram Garhwal <fnu.vikram@xilinx.com>
>=20
> Huh?  Patch 5/7 is twice in this series ...
[Sai Pavan Boddu] Sorry, that was a mistake. Sending out V7.

Regards,
Sai Pavan
>=20
> take care,
>   Gerd


