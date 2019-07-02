Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29A6CC06510
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 16:57:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA415206A3
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 16:57:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="m9pR/3Q+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA415206A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wavecomp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55312 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiM5q-0008Ph-6f
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 12:57:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43955)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <amarkovic@wavecomp.com>) id 1hiLFc-0001mI-3g
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 12:03:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <amarkovic@wavecomp.com>) id 1hiLFR-00087L-9J
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 12:03:16 -0400
Received: from mail-eopbgr680132.outbound.protection.outlook.com
 ([40.107.68.132]:18019 helo=NAM04-BN3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
 id 1hiLFQ-000861-UO
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 12:03:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavesemi-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K/Z5cy4xfEm7dcGAB6hVK9WiBlsR+cAcb0peNiEUffI=;
 b=m9pR/3Q+9tQcOs3m2fCoLcKlTB2mALjIi1VMmrwmaDtUjjMcKw+ulLOdDj5JLVxo9c6p4Hk0lANAXzDGfoxzbFxQO9Ym7oNmYnlh9vxUi3+9CyEaZ4AyJL1C0fIK2HlI+4Yx7Rz0TYRgTRqI5H+Ujpsy4FGpe+DsbGa0GTjPSVE=
Received: from BN6PR2201MB1251.namprd22.prod.outlook.com (10.174.81.139) by
 BN6PR2201MB1252.namprd22.prod.outlook.com (10.174.82.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.17; Tue, 2 Jul 2019 16:03:09 +0000
Received: from BN6PR2201MB1251.namprd22.prod.outlook.com
 ([fe80::c4a7:ebf7:ad07:f5f7]) by BN6PR2201MB1251.namprd22.prod.outlook.com
 ([fe80::c4a7:ebf7:ad07:f5f7%10]) with mapi id 15.20.2032.019; Tue, 2 Jul 2019
 16:03:09 +0000
From: Aleksandar Markovic <amarkovic@wavecomp.com>
To: "aleksandar.markovic@rt-rk.com" <aleksandar.markovic@rt-rk.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [Qemu-devel] [PATCH v2 0/7] target/mips: Misc improvements for
 4.1
Thread-Index: AQHVMMxkc7+c3bpKOEqFWCUH4gUOlaa3bC4AgAAQsvM=
Date: Tue, 2 Jul 2019 16:03:09 +0000
Message-ID: <BN6PR2201MB1251A724A176CCEB92E50663C6F80@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <1562068213-11307-1-git-send-email-aleksandar.markovic@rt-rk.com>,
 <156207962968.14342.2512093401997997805@c4a48874b076>
In-Reply-To: <156207962968.14342.2512093401997997805@c4a48874b076>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=amarkovic@wavecomp.com; 
x-originating-ip: [82.117.201.26]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ac9b6a25-ff1a-4ce7-e0ec-08d6ff06c735
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:BN6PR2201MB1252; 
x-ms-traffictypediagnostic: BN6PR2201MB1252:
x-microsoft-antispam-prvs: <BN6PR2201MB12520DDC78CA2D59DAF6E4A1C6F80@BN6PR2201MB1252.namprd22.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 008663486A
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(346002)(136003)(376002)(396003)(39840400004)(189003)(199004)(5660300002)(55016002)(186003)(9686003)(4326008)(26005)(229853002)(33656002)(99286004)(478600001)(53936002)(8676002)(8936002)(110136005)(6116002)(2501003)(52536014)(76176011)(25786009)(6436002)(3846002)(107886003)(76116006)(66946007)(446003)(66476007)(66556008)(64756008)(66446008)(14444005)(256004)(71190400001)(7696005)(91956017)(316002)(73956011)(14454004)(486006)(68736007)(86362001)(305945005)(6246003)(7736002)(81166006)(81156014)(4744005)(2906002)(6506007)(55236004)(71200400001)(66066001)(476003)(74316002)(11346002)(102836004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BN6PR2201MB1252;
 H:BN6PR2201MB1251.namprd22.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Mb+CqmkMWi0oCGjBNpXQbJM1uWyTURhSlO3AyJVrjuIkLmpbFyoS0ofIzv6Nm9OWWddP9Q9+MLybuwEBcKKyHf1Z57AhPZifNKsS2/UnG3Rt4M/9YcxN4j+U7Hxkw2tMZQqmwsVHZhlTv6eP1981uQYgQiHntYHUNfITS9Oxp7UwC3sClJgW/JNjUiE1WoyL6KXZAJ1hJkqxLdl/l2pda4q4zo4hGn4Yni4oArSOs644hkxAH0cERL1LID5K+cRoJIYoD9nmVgdSQSubvEAte6luoheiBHzpvflu+Ei1wDyG1LCAWUVpAg+Mh0RKAnjz+rCqGj1YlCybn3Fj0ocZk7YKGtbmm8xHuv9Ev3lkNDbCVUI8778x1GjNiL/QyPozdTsAYGKTAD9LCzjxqKlU2lJJm6lr+Y8DBAfkBejmnS4=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wavecomp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac9b6a25-ff1a-4ce7-e0ec-08d6ff06c735
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2019 16:03:09.6047 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: amarkovic@wavecomp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR2201MB1252
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.68.132
Subject: Re: [Qemu-devel] [PATCH v2 0/7] target/mips: Misc improvements for
 4.1
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
Cc: Aleksandar Rikalo <arikalo@wavecomp.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> This series failed the asan build test. Please find the testing commands =
and
> their output below. If you have Docker installed, you can probably reprod=
uce it
> locally.

This appears to be a false positive related to the this series (the failure=
 does not have
a logical connection to this series, which deals with mips target exclusive=
ly)

Yours,
Aleksandar=

