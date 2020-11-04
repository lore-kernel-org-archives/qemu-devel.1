Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB517C2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 21:43:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 141EB20825
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 21:43:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=data61.csiro.au header.i=@data61.csiro.au header.b="kQyajoJv";
	dkim=pass (1024-bit key) header.d=CSIROAU.onmicrosoft.com header.i=@CSIROAU.onmicrosoft.com header.b="f+HjbVlt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 141EB20825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=data61.csiro.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43342 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaQZ5-0006Pa-U6
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 16:43:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58264)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=570d0dfbe=Peter.Chubb@data61.csiro.au>)
 id 1kaQW6-0004R2-S7; Wed, 04 Nov 2020 16:40:30 -0500
Received: from act-mtaout3.csiro.au ([2405:b000:e00:257::7:39]:4124)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=570d0dfbe=Peter.Chubb@data61.csiro.au>)
 id 1kaQW2-0006xn-Hz; Wed, 04 Nov 2020 16:40:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=data61.csiro.au; i=@data61.csiro.au; q=dns/txt;
 s=dkim; t=1604526026; x=1636062026;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=RK1f5scDXi13F6cVkZNkJoRU8YmRVkO7W9pTxWWRk1o=;
 b=kQyajoJvoUBwWMuQNNFPOEhhSVyQyRd0VpRzSN93kJuPmMknEaovIcUt
 ktzH6iahpDK05ElW3oFPNftI7Q+Ux0uDMn20YvNks+b6/n/o7taSxwYyK
 t/WXm5bxW114RrN945Gn93pXVyUsuDlDAgpFmruB8V9wV7HyOLguy/PBF I=;
IronPort-SDR: aSU4wRk34IlDvKyKc7hWCIt70DG4E0vATj8pAL5pa6tYsIdzNsCnaW5pGip5Tz5J4MlESEqjr9
 0VrsXWpMqZVw==
X-SBRS: 4.0
IronPort-PHdr: =?us-ascii?q?9a23=3AFKU6OhcP5bcboY3xXbiAr4vclGMj4e+mNxMJ6p?=
 =?us-ascii?q?chl7NFe7ii+JKnJkHE+PFxlwaTB9fb9vtbhuuQuKflCiQM4peE5XYFdpEEFx?=
 =?us-ascii?q?oIkt4fkAFoBsmZQVb6I/jnY21ffoxCWVZp8mv9PR1TH8DzNF3Pq2K/7HgZHR?=
 =?us-ascii?q?CsfQZwL/7+T4jVicn/3uuu+prVNgNPgjf1Yb57IBis6wvLscxDjYJ+I/hojB?=
 =?us-ascii?q?DSo2FPPe1Llm4=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A+EyBABKH6NfjACwBSSYiIBxAISUgiR?=
 =?us-ascii?q?iHgEBCxIMQIFRgVBRYhWBNgqHfAOpIQNUCwEBAQ0CHw4CBAEBAoEDg0UCgg0?=
 =?us-ascii?q?CJTkFDQIDAQELAQEGAQEBAQEGBAICEAEBAQEphhEMg1SBBgEBAQEBAQEBAQE?=
 =?us-ascii?q?BAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEFAoEHBT4CAQMSKAYBATcBDwI?=
 =?us-ascii?q?BCDYQECIlAgQOBSKDBAGCSwMtAQEEpVECgTuJXIE0gwQBAQV7hAsYghAJCQG?=
 =?us-ascii?q?BLoJyikiCGxJ/NoJcPoQ+hXaTJ6R+BwECgm2JCpF/IoMGnmeeRZBxhFsCBAI?=
 =?us-ascii?q?EBQIOAQEFgWyBeh1Pgz0JRxcCDY4fGoIRgUaKWHQCNgIGCgEBAwl8jDsBgRA?=
 =?us-ascii?q?BAQ?=
X-IPAS-Result: =?us-ascii?q?A+EyBABKH6NfjACwBSSYiIBxAISUgiRiHgEBCxIMQIFRg?=
 =?us-ascii?q?VBRYhWBNgqHfAOpIQNUCwEBAQ0CHw4CBAEBAoEDg0UCgg0CJTkFDQIDAQELA?=
 =?us-ascii?q?QEGAQEBAQEGBAICEAEBAQEphhEMg1SBBgEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEFAoEHBT4CAQMSKAYBATcBDwIBCDYQECIlAgQOB?=
 =?us-ascii?q?SKDBAGCSwMtAQEEpVECgTuJXIE0gwQBAQV7hAsYghAJCQGBLoJyikiCGxJ/N?=
 =?us-ascii?q?oJcPoQ+hXaTJ6R+BwECgm2JCpF/IoMGnmeeRZBxhFsCBAIEBQIOAQEFgWyBe?=
 =?us-ascii?q?h1Pgz0JRxcCDY4fGoIRgUaKWHQCNgIGCgEBAwl8jDsBgRABAQ?=
Received: from exch4-mel.nexus.csiro.au ([IPv6:2405:b000:302:71::85:124])
 by act-ironport-int.csiro.au with ESMTP/TLS/ECDHE-RSA-AES256-SHA384;
 05 Nov 2020 08:39:57 +1100
Received: from exch2-mel.nexus.csiro.au (2405:b000:302:71::85:122) by
 exch4-mel.nexus.csiro.au (2405:b000:302:71::85:124) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Thu, 5 Nov 2020 08:39:57 +1100
Received: from exedge2.csiro.au (150.229.64.34) by exch2-mel.nexus.csiro.au
 (138.194.85.122) with Microsoft SMTP Server (TLS) id 15.0.1497.2 via Frontend
 Transport; Thu, 5 Nov 2020 08:39:57 +1100
Received: from AUS01-SY3-obe.outbound.protection.outlook.com (104.47.117.58)
 by exedge2.csiro.au (150.229.64.34) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 5 Nov 2020 08:39:52 +1100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XRxUltTc39c4awxNrY98Diy8pRAtkyd/sQdCHRboIM1ui47r+srX5O+dGwuIfqm0+msJEoEM84wFZJ3QuntN1M0bXI4BJFirQaaA3gsVyTiZyg5lcQT5B0fA/n6UPHHpHUV/pFkdGjqidCNpfO47WRNelIDAapffHoNRM2vlm9qwkbxQiuTEw0QlAzeK8SUfvN/qexaHmBBC2wIhSNw426TD0n2d8RT8Y/nBDgEcBGhsid8j32cS8wxSztlE7gMfnqdpDbSCOFLBHmipBzs0Nw6n8JWx0Se1z4HYmIR4Z9n1wmuVCGwyWTXU/5sXTzrwUz/4cVSJrX6YX1Hwe8wHJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SS7JC37GuJpw3LFXvYKagKRC9l3ILS0UCZgBZbcpCr0=;
 b=WspgV69+yVeOLDBxOWoxdNsAmFahxueGwZauWqWj4tCKWutyPW2CLXaupE15eM4w4pq0IoZNOsmryAfHR2JSr9V+3mT0UyDQDnAvNHuoTvby1YDb68ngmJeS3XFR9j+KnZGM/+5YtlDNTxoK4PExKjqFjTrhz+01cPw5nrzyyfM/WM5NbvFINaqtXVz86i2ibZvg+pN+cLvG8YvQtfjp5Uoosy0RA9C1cq3Ar6q8UviZ9uSJlB6/sIIrt4vTYovUsBXVf6zTS9aFGGEW6mohRrLhUlTI3IQCGbm7rjjYCUxUg0bBWErzALvSguYWVrzPYak5p2cQYYkwb0snM1j48A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=data61.csiro.au; dmarc=pass action=none
 header.from=data61.csiro.au; dkim=pass header.d=data61.csiro.au; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CSIROAU.onmicrosoft.com; s=selector1-CSIROAU-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SS7JC37GuJpw3LFXvYKagKRC9l3ILS0UCZgBZbcpCr0=;
 b=f+HjbVlt3CpITAdNkQYh7D66PjCgYKf6rha+c313Bqp/7WVCqzHjn1jAErfHI5M7YWdMS1dWHtBysB0Z/44M1L3vtxvCEnoc4mWe4UH2EPnOSTZWLPir/jnnQ9WYgb128hDLVJ8zf+R7DHr+iow68zgZGCRtoGah5+P/vFX1bfc=
Received: from ME2PR01MB5203.ausprd01.prod.outlook.com (2603:10c6:220:4e::23)
 by MEAPR01MB3718.ausprd01.prod.outlook.com (2603:10c6:201:3e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.29; Wed, 4 Nov
 2020 21:39:55 +0000
Received: from ME2PR01MB5203.ausprd01.prod.outlook.com
 ([fe80::a8b3:f385:7f65:2d1]) by ME2PR01MB5203.ausprd01.prod.outlook.com
 ([fe80::a8b3:f385:7f65:2d1%7]) with mapi id 15.20.3499.029; Wed, 4 Nov 2020
 21:39:55 +0000
From: "Chubb, Peter (Data61, Kensington NSW)" <Peter.Chubb@data61.csiro.au>
To: AlexChen <alex.chen@huawei.com>
Subject: Re: [PATCH] ssi: Fix bad printf format specifiers
Thread-Topic: [PATCH] ssi: Fix bad printf format specifiers
Thread-Index: AQHWspSIWIQfoutEU0i8i4+gpfJha6m4gOIA
Date: Wed, 4 Nov 2020 21:39:55 +0000
Message-ID: <877dr06btl.wl-Peter.Chubb@data61.csiro.au>
References: <5FA280F5.8060902@huawei.com>
In-Reply-To: <5FA280F5.8060902@huawei.com>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM/1.14.9 (Goj?) APEL/10.8 Emacs/27.1 (x86_64-pc-linux-gnu) MULE/6.0
 (HANACHIRUSATO)
authentication-results: huawei.com; dkim=none (message not signed)
 header.d=none; huawei.com; dmarc=none action=none header.from=data61.csiro.au; 
x-originating-ip: [221.199.209.25]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9c513197-0b7b-46af-2cd9-08d8810a2b8a
x-ms-traffictypediagnostic: MEAPR01MB3718:
x-microsoft-antispam-prvs: <MEAPR01MB37186DF11E36BA35F413C98EBBEF0@MEAPR01MB3718.ausprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:291;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ckaA46EmOlxTBR2Zca28hyyXMrkrutL8MuPj0ja36dZyVdjEZ6wqSryCOUPAIHlXWalH7APTxckEqlnbHrpAAp6PzwoT1vCCGAA6sp6tJfHWkYCpaXMv7tdTeBUit3h4rIH2AlvIu/EXAobJ+CzTMtighqFSiIEXKX6ysU4IFa/5e06Loz0lJ90Ng6V/V9u0EcbsXzAzMTSRdRcGDaaOTuakaSDQdF+dhsacb0gYt4AwtdH5RXIEAST7xqZmbiz4Zkk88K/NoT3Ts4vKF+X38wgIjQpqPPl1sHAULnP99oFbE0J2PtO8/u6cs2PGPleNPn9Be5qeJND/ZXGf4+IrZUYus+mVtATj4NaMyQg4zhOTnFw7NopKj5WnxRa/FxoNegLrWTwWmqtfz/066XoS0dsBw6EXVGilI4wb7m8i7QbyRkSNAZJZH1pragwl/bDhq4LuUtrIwoq/qSy9xMvaHQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ME2PR01MB5203.ausprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(39850400004)(396003)(136003)(376002)(2906002)(26005)(186003)(6916009)(4326008)(478600001)(316002)(6512007)(54906003)(966005)(8676002)(83080400002)(4744005)(71200400001)(86362001)(6486002)(76116006)(5660300002)(66446008)(91956017)(66556008)(66946007)(66476007)(8936002)(64756008)(6506007)(2616005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: z31YUjQzuJgKYBvawtcF0+UHIog9SimxseL2Qqk7sdOdKz6C39Suh+tI1u0QbDf8oDRc2gqj8a1umlznOYr4zbGlyMNPY2YrK3f1EAcnbzQ67fltp0J4ZAEwuHRF0mNNTI3RqKE6AhJxjWKtnElNk4jVCX36K95WytdjAv5n4jLBx4zluDVJbQUPI4VZivLtDW7xYgXTkHnLM20YNz0Ee5BIasqQ9IOZ2/8fGx46bu6W80JaE6eN52oxG+5/tSV/gN/Sau5b7b7ty7ihd67ZvbDBIQSs3QJUL5UaXswMeBfOXFesCFyNliPjTIc66DHQ9TEbicU/WQItc8Dac9SWUVDnxs21yarCf+Uy/yVzXmZhnfuRlil+9k5ARqBZdXboD7AD77fXKwQ8EjREOBsTOCwBqtVgv5BAH5FD/cjXqlHue6JOSS2TNGgz7/Xi4WuQ1IlIA2qurJ17UeDjCTfyn3el2j+XY+pLRyOG15JTL5I9Y+fJjL5Hq+oiHeFskPosYjcUsPp4Xsuf+fPnW1CxjrbJY/XOOSRR/0WRSX51W+MUnFZS/cybw8Zq0YvS72lFFVPF7Ki20P7uwLY2mjGtp31cvQVKhTPvnz1BIZUNchVztObbHn+V9RhPQhh9ss50klieKUhBnytfeydGaVi6Dw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <98E59C59EB2D8C4F988742F0F7816B87@ausprd01.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ME2PR01MB5203.ausprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c513197-0b7b-46af-2cd9-08d8810a2b8a
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2020 21:39:55.2487 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0fe05593-19ac-4f98-adbf-0375fce7f160
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wviMVDsBcmS2X2pWhtFV3NiT38w9OJPjLqJE91lp6KhiHWg7ra6ebVW0FrQYhW4Q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MEAPR01MB3718
X-OriginatorOrg: data61.csiro.au
Received-SPF: pass client-ip=2405:b000:e00:257::7:39;
 envelope-from=prvs=570d0dfbe=Peter.Chubb@data61.csiro.au;
 helo=act-MTAout3.csiro.au
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "zhang.zhanghailiang@huawei.com" <zhang.zhanghailiang@huawei.com>,
 QEMU Trivial <qemu-trivial@nongnu.org>,
 "alistair@alistair23.me" <alistair@alistair23.me>,
 QEMU <qemu-devel@nongnu.org>, "jcd@tribudubois.net" <jcd@tribudubois.net>,
 qemu-arm <qemu-arm@nongnu.org>,
 "peter.chubb@nicta.com.au" <peter.chubb@nicta.com.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

>>>>> "AlexChen" =3D=3D AlexChen  <alex.chen@huawei.com> writes:

AlexChen> We should use printf format specifier "%u" instead of "%d"
AlexChen> for argument of type "unsigned int".

AlexChen> Reported-by: Euler Robot <euler.robot@huawei.com>
AlexChen>Signed-off-by: Alex Chen <alex.chen@huawei.com> ---

LGTM,
add
Reviewed-By: Peter Chubb <peter.chubb@data61.csiro.au>

--=20
Peter Chubb            Tel: +61 2 9490 5852      http://ts.data61.csiro.au/
Trustworthy Systems Group                                    CSIRO's Data61=

