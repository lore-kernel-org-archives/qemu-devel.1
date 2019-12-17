Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D06A8C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 21:50:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 980A02082E
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 21:50:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=data61.csiro.au header.i=@data61.csiro.au header.b="BoKW4h4d";
	dkim=pass (1024-bit key) header.d=CSIROAU.onmicrosoft.com header.i=@CSIROAU.onmicrosoft.com header.b="QLkYOYw4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 980A02082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=data61.csiro.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihKjp-0001nk-OQ
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 16:50:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59159)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=247585865=Peter.Chubb@data61.csiro.au>)
 id 1ihKj4-00011a-Qa
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 16:49:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=247585865=Peter.Chubb@data61.csiro.au>)
 id 1ihKiy-0003Hg-Dy
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 16:49:53 -0500
Received: from act-mtaout3.csiro.au ([2405:b000:e00:257::7:39]:14830)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71)
 (envelope-from <prvs=247585865=Peter.Chubb@data61.csiro.au>)
 id 1ihKix-0003Dp-0v; Tue, 17 Dec 2019 16:49:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=data61.csiro.au; i=@data61.csiro.au; q=dns/txt;
 s=dkim; t=1576619387; x=1608155387;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=qkjFqM00L8fc1oZGowU6qoRUg4YiURVphjoaxH/7HRY=;
 b=BoKW4h4d49Dbuiu+G+HaSfmTJKWfTAN7NnkbHRioRLRaOT1FEGVqz0OZ
 8zKVvLt1kryAaHXN6s5hxCtLVp7EDLz6NpRxWwpT3LlKQG+crP8zMOBst
 dS0iGi5wjjRABKcJWmH7hon9kc51+ymgCflp9CJCJF6cfDK+RAoSa5nr7 w=;
IronPort-SDR: WJmrjT/aVlY/T1ttIYidyCQwK55p0u2u585SgMWV9+lIML+1NRa6JQgS/BQ7HMmB/EcyflS7Wo
 RdNq8jAi+g4Q==
X-SBRS: 5.1
IronPort-PHdr: =?us-ascii?q?9a23=3AvwoO0hZIip4B5ETnayRb/9L/LSx94ef9IxIV55?=
 =?us-ascii?q?w7irlHbqWk+dH4MVfC4el20webRp3VvvRDjeee87vtX2AN+96giDgDa9QNMn?=
 =?us-ascii?q?1NksAKh0olCc+BB1f8KavSYjA3BoJpVEJv9Vm3OFRcRp+4bEbTuHr05CNBUh?=
 =?us-ascii?q?g=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A+E9BADaTPldlwCwBSSwhIATAJKcgDF?=
 =?us-ascii?q?lHQEBAQkBEQUFAYF+gUtQXhN4BDUKh0ADixROnGkDGDwJAQEBDQEfDgIBAQK?=
 =?us-ascii?q?BAoM8AoIZJDgTAgMBAQsBAQUBAQEBAQUEAgIQAQEBAQEeBoVnDINOOTcBAQE?=
 =?us-ascii?q?BAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBBQKBBwU+AgEDEi4?=
 =?us-ascii?q?BATcBDwIBCEYQIiUCBA4FIoMAAYJGAy0BAQICpAwCgTiIYAEBgiaCfgEBBXe?=
 =?us-ascii?q?EJBiCFwkJAYEsjBiCGhKBNYJdPoRJhW6PfIcTl3oHAQKCNIcvjmEbgjOYFpc?=
 =?us-ascii?q?djXGEDAIEAgQFAg4BAQWBaSGBWh1Pg0AJRxEUjRIaghOBRopTdAGBJ49FAYE?=
 =?us-ascii?q?PAQE?=
X-IPAS-Result: =?us-ascii?q?A+E9BADaTPldlwCwBSSwhIATAJKcgDFlHQEBAQkBEQUFA?=
 =?us-ascii?q?YF+gUtQXhN4BDUKh0ADixROnGkDGDwJAQEBDQEfDgIBAQKBAoM8AoIZJDgTA?=
 =?us-ascii?q?gMBAQsBAQUBAQEBAQUEAgIQAQEBAQEeBoVnDINOOTcBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBBQKBBwU+AgEDEi4BATcBDwIBCEYQI?=
 =?us-ascii?q?iUCBA4FIoMAAYJGAy0BAQICpAwCgTiIYAEBgiaCfgEBBXeEJBiCFwkJAYEsj?=
 =?us-ascii?q?BiCGhKBNYJdPoRJhW6PfIcTl3oHAQKCNIcvjmEbgjOYFpcdjXGEDAIEAgQFA?=
 =?us-ascii?q?g4BAQWBaSGBWh1Pg0AJRxEUjRIaghOBRopTdAGBJ49FAYEPAQE?=
Received: from exch1-cdc.nexus.csiro.au ([IPv6:2405:b000:601:13::247:31])
 by act-ironport-int.csiro.au with ESMTP/TLS/ECDHE-RSA-AES256-SHA384;
 18 Dec 2019 08:49:37 +1100
Received: from exch3-cdc.nexus.csiro.au (2405:b000:601:13::247:33) by
 exch1-cdc.nexus.csiro.au (2405:b000:601:13::247:31) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Wed, 18 Dec 2019 08:49:36 +1100
Received: from ExEdge1.csiro.au (150.229.7.34) by exch3-cdc.nexus.csiro.au
 (152.83.247.33) with Microsoft SMTP Server (TLS) id 15.0.1497.2 via Frontend
 Transport; Wed, 18 Dec 2019 08:49:36 +1100
Received: from AUS01-SY3-obe.outbound.protection.outlook.com (104.47.117.56)
 by ExEdge1.csiro.au (150.229.7.34) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 18 Dec 2019 08:49:31 +1100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CyLxIAj9dt9KqcurUKgZLZwN7H+0dlRSk/Outzpj8XTM6/Dg8vIjTYBBngrnuPCb7Pcpr7h48SnwQsZHMvnt/OfOOBdRDAywaNBbkSKAVtr47Vu1YJmBfGIFFpc/e50wbv7cwSgct60NKNfxw1FXGQUcC0Qy9CM4DWbeXgCYb8ot+ZnyNi7fOA4ERjb5us2nDjYFh9tzW4pAxgxa8lRELBzU/RRgsWwBYfjzki/neRpDzCCeW9Rv+jQfJqzAhoEvttoOTdmilOzZbBE5VoSE34sWctgV8+AcOilsAVYAz/tKYoLe7FyqP2HKFiPNo+Q8kG93jpnGCnBxQDQy3iiOAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KwbbELwpPEKKEdNFlQTeMPMAG4r1desawibRent8UXo=;
 b=S5hDIcwM5ftvjr8tkW3W+jkwjof5rXbC5ADFU2y5tuniAJPK8uWo8tJOARtuqVotpzpCzLVpe2CGzQjkomXGhjfrxoAN9TuVXGaLlGNXllI8JrGmRyup0zWkbgJAINAf2qUVYrjclc1EK3KHNGXjjxUHlmIGZ2ULGYHUvjOl+mP6ttWbkBFGSTRyl7deBO1QMArwDLsvXQmNtiHwzeTK3YBOzJO1H7FMHZCTrhlDHe8UQfflNIiP68rE+IdfddArEFMtf8qpRb0Hq4qUyKlyBZjFoJ7x6fkEfoEGFAx8sPdmLcX6ZTQCs6NBL+mPHQtc/Czi8mksHyA6z+lsrmH38g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=data61.csiro.au; dmarc=pass action=none
 header.from=data61.csiro.au; dkim=pass header.d=data61.csiro.au; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CSIROAU.onmicrosoft.com; s=selector1-CSIROAU-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KwbbELwpPEKKEdNFlQTeMPMAG4r1desawibRent8UXo=;
 b=QLkYOYw4qj8lX1UBZxTIpppdlf4TfoMB3vxmXNneV57c7h3uqamJTCR54zqyc3HouPBv1YCznQxcFSaw4fl91v7Mf/jo99cku02li/5XlSIMpVWFQO0SKbsEjVpqpS6icMhCIgdrDtZkJVRccBiwewLIDci3dj2hxcrqcOg/BuA=
Received: from MEAPR01MB3734.ausprd01.prod.outlook.com (52.134.217.84) by
 MEAPR01MB3157.ausprd01.prod.outlook.com (52.134.218.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.14; Tue, 17 Dec 2019 21:49:35 +0000
Received: from MEAPR01MB3734.ausprd01.prod.outlook.com
 ([fe80::f88a:bacd:6866:d53f]) by MEAPR01MB3734.ausprd01.prod.outlook.com
 ([fe80::f88a:bacd:6866:d53f%6]) with mapi id 15.20.2538.019; Tue, 17 Dec 2019
 21:49:35 +0000
From: "Chubb, Peter (Data61, Kensington NSW)" <Peter.Chubb@data61.csiro.au>
To: =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH 0/6] Fix more GCC9 -O3 warnings
Thread-Topic: [PATCH 0/6] Fix more GCC9 -O3 warnings
Thread-Index: AQHVtQAZ6Ml9ApUzXk+fEju4sv41Uqe+3bwA
Date: Tue, 17 Dec 2019 21:49:35 +0000
Message-ID: <84fthiaahd.wl-Peter.Chubb@data61.csiro.au>
References: <20191217173252.4672-1-philmd@redhat.com>
In-Reply-To: <20191217173252.4672-1-philmd@redhat.com>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Peter.Chubb@data61.csiro.au; 
x-originating-ip: [221.199.209.40]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a43f49b0-2c64-47c6-c025-08d7833b0201
x-ms-traffictypediagnostic: MEAPR01MB3157:
x-microsoft-antispam-prvs: <MEAPR01MB315710482C07AB9FB2493632BB500@MEAPR01MB3157.ausprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 02543CD7CD
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(376002)(136003)(39850400004)(396003)(346002)(189003)(199004)(966005)(6512007)(54906003)(316002)(6916009)(478600001)(71200400001)(86362001)(2906002)(5660300002)(66446008)(4744005)(8676002)(6486002)(81156014)(66946007)(186003)(64756008)(66556008)(66476007)(6506007)(7416002)(4326008)(8936002)(2616005)(91956017)(76116006)(81166006)(26005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MEAPR01MB3157;
 H:MEAPR01MB3734.ausprd01.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /HBXqG5O1G7jURFQGWMwOVuPNRBzQ9wkXZF3hNImumaNV3N4u85L8UtNextP7u+51h3FXcc/E9scn2YuzVUNcAJ+szaU7296jgvDou/lU7PwIsGBMFpC0VR8r0RLDFvn+/akF1wDT5vyrwdvJBEUDmUz9MtqFrGDLFWOGk6WtoXWJY5HT5C2pokyoKjZ5wwYydNPiH9DTNtj+FVMYGV/c9ZHTkiZwlQ+EzCUqCHQ0XVQOuRQjgFLEEkMFX33aPyxyoT4xvi+bAWVVlP+cfw89mHGvcJj/luX9UIMD3SjNK6lFcXmYymegQo4IXcHgWl+TOecblmakO+WTf+Tq/Fo+U02YXFAEEFLtsWL0I+Pr4AFcXUb9fYgzag89B20zisTukYHVhztnFJjCWf8Mjwl2RmseW11icwwq2exz2EVvgwJb/wUuOYYH+gkM5awLj4bD+/W+4vEggACDLxsWTkyLSA+rj/Ve64epZQ2Xc331B0=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <A2029B2BBC9C7342B1F8C1B1D87EC8E0@ausprd01.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: a43f49b0-2c64-47c6-c025-08d7833b0201
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2019 21:49:35.5793 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0fe05593-19ac-4f98-adbf-0375fce7f160
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RVDyJtkhXJY0zrm+o+Lhpw4wsozuQuTvGQMhriD/BvLNSBdyGo+lVx1/VWKaKJaT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MEAPR01MB3157
X-OriginatorOrg: data61.csiro.au
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2405:b000:e00:257::7:39
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Hannes Reinecke <hare@suse.com>, Gerd Hoffmann <kraxel@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>, Jason
 Wang <jasowang@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 Andrew Jeffery <andrew@aj.id.au>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 Peter Chubb <peter.chubb@nicta.com.au>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>,
 Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

>>>>> "Philippe" =3D=3D Philippe Mathieu-Daud=E9 <philmd@redhat.com> writes=
:

Philippe> Fix some trivial warnings when building with -O3.

For compatibility with lint and other older checkers, it'd be good to keep
this as /* FALLTHROUGH */ (which gcc should accept according to its
manual).

Fixing the comments' placement is a different matter, and should be
done.  Seems to me that until gcc started warning for this, noone had
actually run a checker, and the comments were just for human info.

Peter C
--=20
Dr Peter Chubb         Tel: +61 2 9490 5852      http://ts.data61.csiro.au/
Trustworthy Systems Group                           Data61 (formerly NICTA)=

