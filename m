Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC1F6C433E6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 10:59:11 +0000 (UTC)
Received: from lists.gnu.org (unknown [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B94D2071B
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 10:59:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="eM1g9L+d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B94D2071B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41728 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD40E-0005BH-EV
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 06:59:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33002)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1kD3zV-0004ky-Ht
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 06:58:17 -0400
Received: from mail-eopbgr770040.outbound.protection.outlook.com
 ([40.107.77.40]:45028 helo=NAM02-SN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1kD3zT-00045D-5X
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 06:58:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lKubHbLTAjiwWtswfiiKcsMSIwWdaVyw3jsrCKM7vWQ1Rk/hgxHu+486lD6a844huETG8Lsk5FLy8yiqkPoNfAuzTWpxg3t/c1FNx64q7vuQO//mPjix1aqrPOxpwa1zaN8QxP6ZOYw91dCMYGDysPE0Zm208YYU8UUAB8nevZvOaHQP8Q4alRJTifkj6i6lg6MRJGlKp5aaWom5V4maiC4P2L2oeTmKinzIXNIRGJjgfblAxTBt2BsmxWcEvzbvIgG5SE/w/VANwuWAfp0pUJc/dqeRrlKW89/9G8ps5w78uZh49ZTZdFWYCBNsBaGZV07HvlJuOMtXMRkdLidKHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pWwWDK1o7XklGRR2N1zrKJ2inqOF7p9HjDKPvOUnppw=;
 b=Z5JcAKvUn2jQAeGZG1Q9aGOUHnYOwMTb/vKAr4r3ahDfJKmwD6emRRONd8j1g3NXjd4MInnNdEEHcb88WeueFonefKuWq56I4aEXs31Hq8FIkK069RVUfc3kF+9T82GALxvVfhODchOef5bgSgcByE3/qCqjJx5GJ0L9J83+IXCzqlirTZkNvtiVbWDUfRu1mChCFk6Ri6SuXnopzA++tyBh8CnAtpnE2SJqieBexsqWfrPVgqPqyAV9g81vUNEYBSv0UREzXzhtFkkDBilgIcb1wow7rXp1S5gpOVXgK0wAlaHsRDFaQ1Vmf3Yf/95IsfHkDEqMn6OybZc++5fCDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pWwWDK1o7XklGRR2N1zrKJ2inqOF7p9HjDKPvOUnppw=;
 b=eM1g9L+dmaNFHCHYW9vHKTlpTQcxXe3rUnUl/HTMVAVIj4SIIKocp+hONtJ6CHOdEKTm8VeIsixIXlhF4XX6aF55fojjvbFjDfpkncKaWZtnx5bi+kD5nAn47AHjizADWocIcVYc5EMFFBIpq73rVJf4scSJu3LWn/IxBTrYj+M=
Received: from BY5PR02MB6772.namprd02.prod.outlook.com (2603:10b6:a03:206::11)
 by BYAPR02MB4789.namprd02.prod.outlook.com (2603:10b6:a03:46::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.23; Tue, 1 Sep
 2020 10:58:11 +0000
Received: from BY5PR02MB6772.namprd02.prod.outlook.com
 ([fe80::1007:f094:45c9:bb47]) by BY5PR02MB6772.namprd02.prod.outlook.com
 ([fe80::1007:f094:45c9:bb47%8]) with mapi id 15.20.3326.025; Tue, 1 Sep 2020
 10:58:11 +0000
From: Sai Pavan Boddu <saipava@xilinx.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: RE: [PATCH v4 6/7] usb: Add DWC3 model
Thread-Topic: [PATCH v4 6/7] usb: Add DWC3 model
Thread-Index: AQHWfW+WHR4pElPyOUGpEwwUJL4Xo6lRz3gAgAGazMA=
Date: Tue, 1 Sep 2020 10:58:10 +0000
Message-ID: <BY5PR02MB6772AC53A0D1E055FE975E3CCA2E0@BY5PR02MB6772.namprd02.prod.outlook.com>
References: <1598642380-27817-1-git-send-email-sai.pavan.boddu@xilinx.com>
 <1598642380-27817-7-git-send-email-sai.pavan.boddu@xilinx.com>
 <20200831070556.scvdophxvytneoax@sirius.home.kraxel.org>
In-Reply-To: <20200831070556.scvdophxvytneoax@sirius.home.kraxel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=xilinx.com;
x-originating-ip: [49.205.235.17]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 44766338-45a7-499a-eb70-08d84e65eacd
x-ms-traffictypediagnostic: BYAPR02MB4789:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR02MB47894AD2FA1BFFEE44CABFFDCA2E0@BYAPR02MB4789.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mzou+ANvTOspecinosSsj0kQprtK/mdBrGD9iAjZAhsWGYIImlqb9SuWaKUnk1v+l1ZBMy0/lgLgFg6XJNai+MtLx/yCViAFrk+/XN3Zuyo+apjiGjUQ5v4O984dbcFR8LcEOFkgJTeeFUsnibgg1kds9y/re29K4dfcUCDaosjt4eRVZ5bKk8uEKZkDqk7M9CZY09RKRaNlFQSMAgbnouwpGNdxRXtvsiHBwm+gzxahwCZoSLtKY7vNFxRnkEWFUzIlFL5vL6GMABANRPW8vt/IU2pWYQKVKau0NYJ37yDOPMQpkm+Hmp+Y+l6zJDW2ogbJbkbhmWvvjSzMJJY0Yw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR02MB6772.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(136003)(396003)(39860400002)(346002)(376002)(5660300002)(83380400001)(186003)(26005)(53546011)(478600001)(6916009)(52536014)(6506007)(8676002)(8936002)(71200400001)(9686003)(7696005)(7416002)(33656002)(2906002)(66446008)(64756008)(66476007)(66556008)(66946007)(86362001)(54906003)(316002)(55016002)(76116006)(4326008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: HHgWZ7crWZ/rlC8qBapc+kMFynDwmzQqtep0l5NUEVUln6rj0GaaLGcK0LkGUY2Ktz8EL2QhUuaogveQjB52U9nwZPKK/v11mGUAtucrxRjU6N3JvU1GlWloGNx1+pVG7XaaL9qlQVF+EhpeempmPqwgSlqutjtjfvMXWua78EUQfpEATVo9sqka+zc9wb7v6YtJ1mcpx7lhKTu2nTJtUc7bOQOv89+0EVQ8wLqw+CXqBV5UGtQWkP6pV0lMz7jKvcY5IBJxre7Yrksa/I1l04IwVuedc3L/HthkdLoi49oCZUVqdMbjr/cUNtISE0H88gqntwvOR28oMCVYqGXQaHZvAjUxi+IixYkMq611f1Q1JCu8Xu6ScjfTLXPwBCiH3Lv0FiM1PdN0SEc6DGTjIXn40Jh6ck+DzTAvV0zom9vxbOL+KJXoaL4H6M7HZDV1DwuZdlURTZ4RfIMzyZwiY5ODWUPg4uTGZTsMrlPVGdmldkhwZDSbGvmckjJbN6ayOwAS1mCAm5W8laDHMPDuFgscDuQ5suexjMA3hJfXFg95fLg4EL5Z69BKM9QsJzVwkLlfKBBXQMfQcME1V3l2fBlDd3IO09vELsXtKZoaj92GuRafRMAPu9MJouFSdSgm1qzFZNOcd3rBO7VfnUlimA==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR02MB6772.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44766338-45a7-499a-eb70-08d84e65eacd
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2020 10:58:10.9070 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7bcPBWptU2v3MHehA6ou7TSD85B/FWdzziW1jnKC6JzqR9KyV6XRmQQoBlg5dkFSX+Swa6ZY3jNxLo6dNur1cQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4789
Received-SPF: pass client-ip=40.107.77.40; envelope-from=saipava@xilinx.com;
 helo=NAM02-SN1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 06:58:13
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
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

HI Gred,

> -----Original Message-----
> From: Gerd Hoffmann <kraxel@redhat.com>
> Sent: Monday, August 31, 2020 12:36 PM
> To: Sai Pavan Boddu <saipava@xilinx.com>
> Cc: Peter Maydell <peter.maydell@linaro.org>; Markus Armbruster
> <armbru@redhat.com>; 'Marc-Andr=E9 Lureau'
> <marcandre.lureau@redhat.com>; Paolo Bonzini <pbonzini@redhat.com>;
> Edgar Iglesias <edgari@xilinx.com>; Francisco Eduardo Iglesias
> <figlesia@xilinx.com>; qemu-devel@nongnu.org; Alistair Francis
> <alistair.francis@wdc.com>; Eduardo Habkost <ehabkost@redhat.com>;
> Ying Fang <fangying1@huawei.com>; 'Philippe Mathieu-Daud=E9'
> <philmd@redhat.com>; Vikram Garhwal <fnuv@xilinx.com>; Paul
> Zimmerman <pauldzim@gmail.com>
> Subject: Re: [PATCH v4 6/7] usb: Add DWC3 model
>=20
> On Sat, Aug 29, 2020 at 12:49:39AM +0530, Sai Pavan Boddu wrote:
> > From: Vikram Garhwal <fnu.vikram@xilinx.com>
> >
> > This patch adds skeleton model of dwc3 usb controller attached to
> > xhci-sysbus device.
>=20
> --verbose.
>=20
> This looks like xhci with a bunch of extra registers?
[Sai Pavan Boddu]=20
> What these registers are good for?
These are also put to make the guest happy.
This module contain dwc3 global registers which deal with power management,=
 phy config and ID registers.
And also has Device and OTG registers which are incomplete at present.

What I realized is, we could clean many of these registers and only emulate=
 ID registers at present. As others are meaningless. I would just define a =
reserved space, to skip io access errors.

Thanks,
Sai Pavan
>=20
> > +/*
> > + * QEMU model of the USB DWC3 host controller emulation.
>=20
> (answer should go to both this comment and the commit message).
>=20
> thanks,
>   Gerd


