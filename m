Return-Path: <SRS0=g5aJ=2O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5082CC2D0C3
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2019 03:34:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1152520705
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2019 03:34:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavecomp.com header.i=@wavecomp.com header.b="guGAUgaD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1152520705
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wavecomp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35686 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ijayD-0005jc-4X
	for qemu-devel@archiver.kernel.org; Mon, 23 Dec 2019 22:34:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54378)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <amarkovic@wavecomp.com>) id 1ijaxQ-0005Id-BH
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 22:34:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <amarkovic@wavecomp.com>) id 1ijaxO-0007pt-Ny
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 22:34:03 -0500
Received: from mail-eopbgr680099.outbound.protection.outlook.com
 ([40.107.68.99]:56531 helo=NAM04-BN3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
 id 1ijaxO-0007mW-Cr
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 22:34:02 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YslFIMb+kYfLt2qNh4/VmFPtbu1s0FCEw3TQyYln3bIk1uhMYMra++E52izO5YcMt7zuleKqAgp5aWeJhcdyhFJ3Jr6cdjJTkTopN1je/RVICdMRLKZ9evofdFXxdvjbhrpdSigyJpDGSAW/kcxbIA6f3s7GI6oP80ZMo768FE/nKJGsMVGLKtzlNkrZmqDzrU8C255wyUNQ1/bItOPPVcw2B4Yp7aBf9vGxxuG8vOIz+DpHWEURI/EnbuHkfA+qbBxWIJPfoJKbCYK+lwkvQkJNaeVDanvyWkNDsrOWWuIPmD2qgG60BYgUSpOcaPWxZvTVdSUhiAc4bYLVmOu22w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TK1sCfvmXIe5IcW4CfgE+PeI1HiVNmNQwsMIJ9BTxWU=;
 b=dLJVD6m/05f7Qzkr/R9XqQg6ZyiiCaev9PCNoycEwFgb2+ca4YaMP2exsEa5JNG+HmVK55+TrRSSRG/glWZrDQEroo8B/k6dKmc192cvk/1CgQKrtmo+E1ZTfJZWg/NW4qkBbbNxH4aGH7beQYs32u3qFgCsJ1LOa1XRYeGMHMKpkhzwZTGqptiywax5RpQE5QbNhBnK1ry59Ja11Y20M2R1fEF6Y7klenZNp/NrS9sD/vQBQ4xQFLYdXnpuCzSi4pvvEZM974rU5vBcRFf7+HQ7hfVBTAQgNX9kHVRTh90ynPybu4Y+9cqYeCYgu3JiRrbaR4pGjeZusvrK/3ejcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wavecomp.com; dmarc=pass action=none header.from=wavecomp.com;
 dkim=pass header.d=wavecomp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wavecomp.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TK1sCfvmXIe5IcW4CfgE+PeI1HiVNmNQwsMIJ9BTxWU=;
 b=guGAUgaDHhzAbIwxd2DPiDy5fZ1wVIWS45890teGqlGBesvmjqSB7H/qWP+HROWAHUkoX/5p/CaIp6+AigZeLcER9S8JsPjf2zPcyyJVxZ5iqwIPjBHF4wBbNJNiTULmqU5bz2iRDmdXH2T4oBRucwtZqXom/zN3JxwAh9DJ4fI=
Received: from BN6PR2201MB1251.namprd22.prod.outlook.com (10.174.81.139) by
 BN6PR2201MB1266.namprd22.prod.outlook.com (10.174.80.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.17; Tue, 24 Dec 2019 03:33:59 +0000
Received: from BN6PR2201MB1251.namprd22.prod.outlook.com
 ([fe80::8d7a:f373:d18d:db1c]) by BN6PR2201MB1251.namprd22.prod.outlook.com
 ([fe80::8d7a:f373:d18d:db1c%10]) with mapi id 15.20.2559.017; Tue, 24 Dec
 2019 03:33:58 +0000
From: Aleksandar Markovic <amarkovic@wavecomp.com>
To: Max Filippov <jcmvbkbc@gmail.com>, Aleksandar Markovic
 <aleksandar.markovic@rt-rk.com>
Subject: Re: [EXTERNAL]Re: [PATCH 1/5] linux-user: Fix some constants in
 termbits.h
Thread-Topic: [EXTERNAL]Re: [PATCH 1/5] linux-user: Fix some constants in
 termbits.h
Thread-Index: AQHVugfw82dkOUS3w0mLoHGctPKd2KfIoVGe
Date: Tue, 24 Dec 2019 03:33:58 +0000
Message-ID: <BN6PR2201MB12511435B4D91291F632A1CBC6290@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <1577155187-12622-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1577155187-12622-2-git-send-email-aleksandar.markovic@rt-rk.com>,
 <CAMo8Bf+gYien0BWW8EmHNF1TXRoBuc=pOq8Qb5pBTspsnkeAYQ@mail.gmail.com>
In-Reply-To: <CAMo8Bf+gYien0BWW8EmHNF1TXRoBuc=pOq8Qb5pBTspsnkeAYQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=amarkovic@wavecomp.com; 
x-originating-ip: [82.117.201.26]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1d37903f-f6ad-4aff-a4a8-08d788221ca6
x-ms-traffictypediagnostic: BN6PR2201MB1266:
x-microsoft-antispam-prvs: <BN6PR2201MB1266D0C671C0E8595D125AA8C6290@BN6PR2201MB1266.namprd22.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1079;
x-forefront-prvs: 0261CCEEDF
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(39840400004)(396003)(376002)(346002)(136003)(199004)(189003)(51914003)(81166006)(55016002)(8936002)(81156014)(8676002)(2906002)(4326008)(71200400001)(9686003)(54906003)(33656002)(110136005)(52536014)(64756008)(66446008)(66476007)(66556008)(66946007)(91956017)(76116006)(316002)(7696005)(4744005)(26005)(5660300002)(6506007)(55236004)(186003)(508600001)(86362001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BN6PR2201MB1266;
 H:BN6PR2201MB1251.namprd22.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MfFtflSIfCu5IEVMprTq6/OZN+4stRGMU4EvaLKvN1e2kPC9rsMUOblmZ6SvyFgD6zl/jO9ScEkI7aB6ZtsiBU/I3V5BEnrhZLSdFKQAWSb1lrudHEifUYuNjTotk/+xl3M14XL81JdoydeBtgqWyVyVYFAgwO1UHKvTjiBbb9Qxmgb3U0eaZuWHSWmO+aaiL6NOt0mTcQERNkwZm9WnZh2mIf9f3o1o69ZhjPC9l4aHMpP0pIqlF2VQbSchT5zs1VosrEfFxDoFGOeiK5oew0zPKBQkskuh1g7VfzcKjsiXscpyiSskrUcVu8MDOu5/hD7MSoFi5KWeuQx4ZNrdz1tZ8E2RpgJcgr7hzOv4hrhtP0CHVG3EBwrDpMeKzO+Qe7J066Rira4pWpVT5u5YPHPN/qd4b1uAMcCyDKvgTyRe0P0uYn5dMEy9XLuho3MfTkvHFMjBjyDBw5kfCaYkUSVmCiwj2uvYhMN9OW9w75FQJ0WUXFRMeJfjl/x6CGVF
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wavecomp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d37903f-f6ad-4aff-a4a8-08d788221ca6
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Dec 2019 03:33:58.4144 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /EymPfeOGwUhE2LD6g+TVidcjIB/MJ3SnW9y8B3SZO77PtQA6GEMQHisETKBn5vp0S2jU1CdWfVNd3Jow4bKUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR2201MB1266
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.68.99
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
Cc: qemu-devel <qemu-devel@nongnu.org>, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> > -#define TARGET_TIOCMIWAIT  _IO('T', 92) /* wait for a change on serial=
 input line(s) */=0A=
> > -#define TARGET_TIOCGICOUNT 0x545D  /* read serial port inline interrup=
t counts */=0A=
> > +/* wait for a change on serial input line(s) */=0A=
> > +#define TARGET_TIOCMIWAIT  _IO('T', 92)=0A=
> =0A=
> This one should also be TARGET_IO, right?=0A=
> =0A=
=0A=
Right - it slipped through the cracks. I'll fix it in v2.=0A=
=0A=
Thanks for the review, and spotting this one!=0A=
=0A=
Aleksandar=0A=
=0A=
> --=0A=
> Thanks.=0A=
> -- Max=0A=

