Return-Path: <SRS0=FCxk=BI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DA4AC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 20:06:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DA9920658
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 20:06:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="htP6OKxC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DA9920658
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44120 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0sLH-0000cB-L5
	for qemu-devel@archiver.kernel.org; Wed, 29 Jul 2020 16:06:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57224)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunilmut@microsoft.com>)
 id 1k0sKi-0000AX-8m
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 16:05:48 -0400
Received: from mail-co1nam11on2134.outbound.protection.outlook.com
 ([40.107.220.134]:6368 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunilmut@microsoft.com>)
 id 1k0sKf-0000lS-Nz
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 16:05:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mNC2OJM0e+zKXaUpLwdaOil1KJjNyj9A0Be1BG1HoabUtTlyaSsaC2HR2crhZ/Df4sNadBEJv9Dllz5fxEyO/k2AJQ8r+40oYYhMrchW4Wry3qVHJ8YoxZ7g2ppT3li1yCmXfMD0ApeHcCSc34lgHibPlmfqWPP0z4KjQ8DBmQ789BzgEZNn11NpKD7d1YSUiqfNWc7VnyTw9l0+OiRIwUg+GhIUZH4TTkWT8DfZODu/DXct8ebAQlHDzjFB9C8zZlzSzEG2lKEMuOOh3d5fPPwONsk+xlK3UcOM4lj2TsHRLEDQK4DbwbMx824kzlz2wGmpg1r/vLqW6tw7mawtJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rxB3Je9hAU3Dzv8uFLX99bnaoi3OsInMjJknNaFLcpg=;
 b=T13EvZS7crHv6dKlUJt+D8c9/3HJ/aJWETdFyWSfopGKBrj0YZWK2wFtQOOG+YGPsRhziNjvpb0Hvq50PEznAgb1MgRPsr7+s2crg3PyP3bpx/DqLteODSenXoKu3wnoaSmMPHX0JTHyzrm+J0Gjjvc8t+IUXInOEkVUEq5vplLf+4kmkJRYTRkjnGlC2JvTzjylTkxKAoTtrlkz1xsciVhRSCGDEuYD/vpdlDCyIVoSKHWMQZluWpDKJrGwtur3vWo4UQ6Zarg/pWVZik5Vshc1sNoLM88r/LVspdTpLVw797cb9OryZ/GvJ/+bMbrJfc+1bITUUMuVz4/Cymi94Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rxB3Je9hAU3Dzv8uFLX99bnaoi3OsInMjJknNaFLcpg=;
 b=htP6OKxCD8TTaFZrMevi+tXLXEQu2TVYsUoYLxxkRtbyliITwEtw3PI4iw4Kc9awmz5qO3vcxqD34dMM6g6FZZ+3qbQLRoWVG0xBIJS9GXCjq0hESq6+bce0sGpKGvC0S14YvOdyd0Jf8wDTGIgUCRPKwfwcRPC6rYcV7pJW150=
Received: from SN4PR2101MB0880.namprd21.prod.outlook.com
 (2603:10b6:803:51::33) by SN6PR2101MB1326.namprd21.prod.outlook.com
 (2603:10b6:805:107::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.1; Wed, 29 Jul
 2020 20:05:42 +0000
Received: from SN4PR2101MB0880.namprd21.prod.outlook.com
 ([fe80::99a:30fe:609e:be35]) by SN4PR2101MB0880.namprd21.prod.outlook.com
 ([fe80::99a:30fe:609e:be35%8]) with mapi id 15.20.3239.016; Wed, 29 Jul 2020
 20:05:42 +0000
From: Sunil Muthuswamy <sunilmut@microsoft.com>
To: Paolo Bonzini <bonzini@gnu.org>, Peter Maydell <peter.maydell@linaro.org>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: RE: qemu repo lockdown message for a WHPX PR
Thread-Topic: qemu repo lockdown message for a WHPX PR
Thread-Index: AdZlFApWhEK0UloZS9GdU/X2cvsH+AAz1PVg
Date: Wed, 29 Jul 2020 20:05:42 +0000
Message-ID: <SN4PR2101MB088065186D10AC74BE9721BDC0700@SN4PR2101MB0880.namprd21.prod.outlook.com>
References: <SN4PR2101MB08805B8E85196354ACA49B54C0730@SN4PR2101MB0880.namprd21.prod.outlook.com>
In-Reply-To: <SN4PR2101MB08805B8E85196354ACA49B54C0730@SN4PR2101MB0880.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gnu.org; dkim=none (message not signed)
 header.d=none;gnu.org; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [2601:602:9400:570:c5c8:1863:df3a:3ff6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1eaa4dd4-f2ae-4ab5-4988-08d833fac5b3
x-ms-traffictypediagnostic: SN6PR2101MB1326:
x-microsoft-antispam-prvs: <SN6PR2101MB132659C341219517956A808EC0700@SN6PR2101MB1326.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2887;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kKxraMOaAG/m0GP7n1Qwsna3yQFPyfTK6UAvGhYlduOd6sey7SLxpqE4Ez8fHVCogaFTb0wBFq/XbeGRr/TMMkx9dH5NoCkSgBUvOcOdqd1FetZiocakgh2CswH1fivAIXbuhQFLR+q/yvoihcARlW7RQ9Coi7zAtTG+m5VLd0JTRefcDaho0djKHr33kpTbGAPNQ+BKpNIb2wrBsma4NFb0evufR2DNXW2Wi0VawZhv8z0N81pYAdGv+JTGoNinzLJJ1/SMjdPBc63t1q1w+YR2FsfS1l4XWMVbjERPI5R2bIUkOdEg+vDdxCGg2b6gm6QJNfsMNRfOFy+d3X3Iy+Zq3Pw9QBhH4g/NaKPsxJx3GRsGvNE2wVaqdnoE1hVA7pxGyjzOax1IW39bmSSuKg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN4PR2101MB0880.namprd21.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(346002)(376002)(39860400002)(396003)(136003)(8990500004)(4326008)(9686003)(83380400001)(8936002)(6506007)(55016002)(7696005)(53546011)(966005)(316002)(2906002)(4744005)(52536014)(15650500001)(8676002)(186003)(33656002)(5660300002)(10290500003)(82950400001)(66556008)(66476007)(66946007)(64756008)(66446008)(86362001)(71200400001)(478600001)(82960400001)(76116006)(110136005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: bqFU0SrQwlSwCEMVnyQArgm5tUfwKLKDJccWcGjHBkFqjwjQpAgM42HJBfzMD5ZYc7my+7Y6+8FNZ2vAoMROQmqbE6ey7hd635gXiw6cKZhzWETQXUM6wZKfPO32rLHI2QPrXSlukGIpBQ53Asqfm/RUMehbClZAlkLlfd8pSonxlfwITBXSUepGGW0O6ebsYG2/WI2zEORBCLfFvfUtdIUcUInegjnistftg6HoMQF3Ja35zklohjf5h4UJ/G6sTJKbLxKyjV0Jtw4reL0bidaRZiZ3U/jLboFYHf2HLPo/LvpZyAO9lQhGmkbpan+CusG3elQuVU+HmHQ2F+dolTCuVigZr0Xf2SzxCV02YI2KU+DG/vd4MdDAGuQKg36eXW/DMdVE5DkogS8obbxfc8X2JpLgzuQxeNvOSGKDlEMFUd9WSHchgCe2VFCv0gZD/wYibMdbF2mmkUK6Y+hrv6YUp1QCmgeq71LaXNmsi8AWpl5Xth8kRQYBS5OnaMzpTaQwp0RGrxpMpmwV23TDm0sqvUxdggsDLjOa8hUE43qU6k5E2fbHUa0xmH61jk+Bx5FnIMxRNZl/n4WGIpTxMarknKc8QjxyE9FJ9efUcB7mNlirqN2abaV8kr2wVP5Cwze+x9PZ/g/OZvDOPkAvsOZZetLvK6EVXmPCEoDMqYURY2bxxXr+xAjVsDOdjQozB8+PrAU92o0+F/TpefNlXg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR2101MB0880.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1eaa4dd4-f2ae-4ab5-4988-08d833fac5b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2020 20:05:42.3477 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 38lz/ri43RLJRq4sahTCTnLIYkhsEttyJ5avWk94nqoWMA3hN/TLGcf7oRPUIXjf2auErwdSDNFWIR04I3xcrs8iusCp7aWI30FzQi5RnBg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB1326
Received-SPF: pass client-ip=40.107.220.134;
 envelope-from=sunilmut@microsoft.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/29 16:05:43
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_PASS=-0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Adding Peter Maydell as well.

> -----Original Message-----
> From: Sunil Muthuswamy
> Sent: Tuesday, July 28, 2020 12:20 PM
> To: Paolo Bonzini <bonzini@gnu.org>
> Cc: qemu-devel@nongnu.org
> Subject: qemu repo lockdown message for a WHPX PR
>=20
> Hey Paolo,
>=20
> Following your suggestion of creating PRs for WHPX changes, I tried creat=
ing a PR https://github.com/qemu/qemu/pull/95
>=20
> But, I am getting repo-lockdown message. What do I need to do differently=
?
>=20
> Thanks,
> Sunil

