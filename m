Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF7E0C4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 13:23:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7389B2146E
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 13:23:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="An1IcI0B";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="J3LyeHD4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7389B2146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50354 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDqDi-0003k3-1Y
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 09:23:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52481)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=1667f8e37=Anup.Patel@wdc.com>)
 id 1iDplE-0003Yq-79
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 08:54:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=1667f8e37=Anup.Patel@wdc.com>)
 id 1iDplB-0001iR-QU
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 08:54:12 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:38358)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=1667f8e37=Anup.Patel@wdc.com>)
 id 1iDpl7-0001gq-FO; Fri, 27 Sep 2019 08:54:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1569588868; x=1601124868;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=ZgXu6EP89eScVxxMMksOAviahy2Xh4HX0Qb4xZcaFeU=;
 b=An1IcI0BKHQpQS6XZY3TbnbZLlCP0qrvA709IdwVwR4qRZIx09+JCWda
 nf2BeYPWify+fk7r3C9KT8xrJn2QdJMJ8Y2PCthbO/xPAcObqEbhMbGub
 M7t80WcUtBMpeAjcYVJ/n9FVhtQ8Xw8HIcEXT62Uer1VGX+Gc0iv4Ezjt
 4q7bBR5rI3kBKki4+SiH4xDjI3c4SBh8hnVKfpW+j06uhxA+tIMACX7Z7
 jdYePiNui/QznfhnIr76N/UoWPGzgQbMWHfbqyHuHTS4yZDFutQ24yaEb
 vE7Dkq/uGvVhLul0MVNv+7kLBtds4E4JQL6VihcqX3rIJxiCBs8pdYGua A==;
IronPort-SDR: aXL+zQ9E77m3hz/AL5SWZnlmiXSimbA77NYxicuhjCEt8nbXWC1N6okbDYdhMKzg7xv81mT6T8
 9PyXtEmhfuMzHt+wIWHJRaFfeNf4/SOM5VupK7lchghBE4QDBKX/QI+IlVyREGuc1Vj4S/v2Om
 6jnm+lnIkLb7GmkUG55CvzxMWYctUvkupBw48q3cRCXkEgDUG1AhnJYV/+sBkeyG8hoOMOfnzk
 GaHDakFBqiuwPxwGVNnEaRYhNs2yIu7TGos06ZnZ608YpioQHCSqM2yNizSadoOPFKLfollcz1
 CzU=
X-IronPort-AV: E=Sophos;i="5.64,555,1559491200"; d="scan'208";a="220147513"
Received: from mail-bn3nam04lp2055.outbound.protection.outlook.com (HELO
 NAM04-BN3-obe.outbound.protection.outlook.com) ([104.47.46.55])
 by ob1.hgst.iphmx.com with ESMTP; 27 Sep 2019 20:39:53 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ABCk5UrJaS/7vNgMQSQxKEDAbehshLKjEZe6UJsqX2WnF35wtJMCL8enayW/JDPdSJN1nKggHEBvjWKCcTbyCaGqXXZBDctWPF9GM+ig6Wm5MS6b6bWcL4NH55BUkk+9Tc1/sg1HJJ7qBYBC5FiixOaB13TSt5NAgd19oG8a5q5d8uO1JnBuVz/SXgumM/SBGsCpwb/yRFrRtVBKrYoD2H9YOKrxDderJlhnxwNrzwX7cNpK0ix9COj7f+Xgk8nqCJbCHXsfoQjglH5+Ye8oCga0VoxxNarNSYkLM9jbTpcPFEA3at7dNf18jVEy2V9t1ajTNhy8yPWzb2dO379GLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KPmyxJkmMJdUUq88TMQlMwQptqKbivhNiQmIAN9Kzzs=;
 b=K+x3nXW6l5hkMjORrjSjBUPj08Wq732jvaYruB72CIb1MRhCxOffrw1QslD7wKWYRWp8nmhRj6PIugHsG5gkdVrWq7MFf/sX68jeKPIGzLtQNvJMPnz24HF20waDkOtuudvgn0pt3WSX4D5C3+yxSf5cwE77YyDlcxTYlRZux9chYL7+m4Cq0V3+6ko7UTnnp8BaHDkeI8WRN9g7oxt7wTI0gbUbH5DG89LXxI28RUtb52VTNsDVibFuUxMLtfBFQdJrBzFDgrCWb2Arf33RefqJboRqy6YMpfh4i2GyKtyzHsHZL0X3X76u5YSQHS1O3KCB9LG5OvxzdOd4i8J4Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KPmyxJkmMJdUUq88TMQlMwQptqKbivhNiQmIAN9Kzzs=;
 b=J3LyeHD4A2Awk20bVLx1krvr3HqcTu1dn3A+jWOjNhtIAZUS4rhZpUddCzak3wnVxNbKX9UDZr3G/7Rm8z8YEWklJSeo1gsdSi7IpkF/Y1J4yyQch1ZFxisq5RRK/e+jPvfRdo+QrukrmeY0pjBd+tKlempnGerHNHDtPygA7fw=
Received: from MN2PR04MB6061.namprd04.prod.outlook.com (20.178.246.15) by
 MN2PR04MB5711.namprd04.prod.outlook.com (20.179.23.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.18; Fri, 27 Sep 2019 12:39:11 +0000
Received: from MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::e1a5:8de2:c3b1:3fb0]) by MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::e1a5:8de2:c3b1:3fb0%7]) with mapi id 15.20.2284.028; Fri, 27 Sep 2019
 12:39:10 +0000
From: Anup Patel <Anup.Patel@wdc.com>
To: "Richard W.M. Jones" <rjones@redhat.com>
Subject: RE: [PATCH 0/2] RTC support for QEMU RISC-V virt machine
Thread-Topic: [PATCH 0/2] RTC support for QEMU RISC-V virt machine
Thread-Index: AQHVcrQDVebPiIecyUaeeiRl9lWtHKc/bjGAgAADe6CAAAeygIAAAFIQ
Date: Fri, 27 Sep 2019 12:39:10 +0000
Message-ID: <MN2PR04MB6061EFA89098F03C51ED173E8D810@MN2PR04MB6061.namprd04.prod.outlook.com>
References: <20190924084201.107958-1-anup.patel@wdc.com>
 <20190927115047.GA6575@redhat.com>
 <MN2PR04MB6061BA18651453F590A1CE738D810@MN2PR04MB6061.namprd04.prod.outlook.com>
 <20190927123047.GO3888@redhat.com>
In-Reply-To: <20190927123047.GO3888@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Anup.Patel@wdc.com; 
x-originating-ip: [49.207.51.217]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9609d91f-1660-4fd2-d99d-08d74347b255
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: MN2PR04MB5711:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR04MB57113FA6C16ECA03F4E456388D810@MN2PR04MB5711.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 0173C6D4D5
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(366004)(39860400002)(346002)(396003)(376002)(136003)(13464003)(199004)(189003)(81156014)(8676002)(81166006)(229853002)(8936002)(33656002)(25786009)(9686003)(6306002)(66446008)(14454004)(5660300002)(966005)(66556008)(478600001)(6246003)(55016002)(64756008)(99286004)(66946007)(66476007)(2906002)(4326008)(86362001)(76116006)(186003)(6916009)(53546011)(6506007)(52536014)(486006)(11346002)(476003)(7736002)(6436002)(55236004)(102836004)(305945005)(446003)(316002)(26005)(66066001)(71190400001)(71200400001)(7696005)(6116002)(14444005)(256004)(54906003)(3846002)(74316002)(76176011);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MN2PR04MB5711;
 H:MN2PR04MB6061.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Mzpn1p9nmbf5tNOhguillFnFIUpBC97qWp8mRYz6gvAoKEuyTNeNW6Hdx219j/MvAkxAieiZV2fyPJbgOroNkA1i23gCqGhXuap+Q7IQnOd1EVXo82aM1Pc+BPXmYNSThYXFloeyVkYZrJlQALapxRIOWsViqDYubZXIhtuefIpgmMMCc2dguDzCMr4/vXQ0EJx0tmgX2vPEpkZrtgd91zNptZTl/EpOTRdFVRuHgknNfSMXqJMmkAU/wdgrxnl40R/2oYkdZ3U84uGH3nb1auHJh/gu3IVRyYy8Ovkd8/tSZ8s+Ri+VvCxnC0bijHLykqQ1HbuwbenfPYvTvprKXxwjdHwdAJzcFpDJK+1jacN43YDecYGFsZnbksMPsdKnZp2I0h3AQSVdy9eYMFYJIHXYSZ5eIreI5MSmGw9nIuuF9uFy3JtOXISTn+Mlo3JDAmlWcsY5YHDbAhzK7klsdg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9609d91f-1660-4fd2-d99d-08d74347b255
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2019 12:39:10.8185 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5dCbeTYBFY3DhEi6NnairkPlc73lDBYwtUIaUeTKy5/N3z4Ga+Yhb2MtYYQbqOc5qztvsM5/kP3sv1mHEki66A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5711
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 68.232.143.124
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
Cc: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmer@sifive.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Atish Patra <Atish.Patra@wdc.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 Anup Patel <anup@brainfault.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> -----Original Message-----
> From: Richard W.M. Jones <rjones@redhat.com>
> Sent: Friday, September 27, 2019 6:01 PM
> To: Anup Patel <Anup.Patel@wdc.com>
> Cc: Palmer Dabbelt <palmer@sifive.com>; Alistair Francis
> <Alistair.Francis@wdc.com>; Sagar Karandikar <sagark@eecs.berkeley.edu>;
> Bastian Koppelmann <kbastian@mail.uni-paderborn.de>; Atish Patra
> <Atish.Patra@wdc.com>; qemu-riscv@nongnu.org; qemu-
> devel@nongnu.org; Anup Patel <anup@brainfault.org>
> Subject: Re: [PATCH 0/2] RTC support for QEMU RISC-V virt machine
>=20
> On Fri, Sep 27, 2019 at 12:05:43PM +0000, Anup Patel wrote:
> >
> >
> > > -----Original Message-----
> > > From: Richard W.M. Jones <rjones@redhat.com>
> > > Sent: Friday, September 27, 2019 5:21 PM
> > > To: Anup Patel <Anup.Patel@wdc.com>
> > > Cc: Palmer Dabbelt <palmer@sifive.com>; Alistair Francis
> > > <Alistair.Francis@wdc.com>; Sagar Karandikar
> > > <sagark@eecs.berkeley.edu>; Bastian Koppelmann
> > > <kbastian@mail.uni-paderborn.de>; Atish Patra
> <Atish.Patra@wdc.com>;
> > > qemu-riscv@nongnu.org; qemu- devel@nongnu.org; Anup Patel
> > > <anup@brainfault.org>
> > > Subject: Re: [PATCH 0/2] RTC support for QEMU RISC-V virt machine
> > >
> > >
> > > On Tue, Sep 24, 2019 at 08:42:36AM +0000, Anup Patel wrote:
> > > > This series adds RTC device to QEMU RISC-V virt machine. We have
> > > > selected Goldfish RTC device model for this. It's a pretty simple
> > > > synthetic device with few MMIO registers and no dependency
> > > > external clock. The driver for Goldfish RTC is already available
> > > > in Linux so we just need to enable it in Kconfig for RISCV and
> > > > also update Linux defconfigs.
> > > >
> > > > We have tested this series with Linux-5.3 plus defconfig changes
> > > > available in 'goldfish_rtc_v1' branch of:
> > > > https://github.com/avpatel/linux.git
> > >
> > > Why was this device chosen instead of kvm-clock?
> >
> > We need a RTC device which worked fine in TCG mode (even without
> KVM).
> > The KVMCLOCK is PTP clock which depends on KVM hypercalls.
> >
> > On ARM virt machine, we have PL031 so instead of that we have Goldfish
> > RTC on RISC-V virt machine.
>=20
> Could we not make kvm-clock work on TCG (I wasn't aware that it needed
> actual KVM - I wonder how timekeeping works on TCG?)
>=20
> Alternately why not use PL031 here?

PL031 requires input clock.

Of course, we can provide fake input clock (i.e. some random
fixed clock) to make it work but it will be a HACK.

Also, it will be really strange to hook an ARM device into RISC-V
virt machine. On other hand, Goldfish para-virt devices are used
across architectures x86, ARM and MIPS.

>=20
> The reason I'm asking this is because adding a new virtual device means w=
e
> have to change this all the way up the stack (libvirt,
> virt-*) _and_ have special cases everywhere just for RISC-V.  That's a lo=
ad of
> extra work for everyone.

The RTC devices are pretty much transparent in usage. I am not sure
why libvirt will require to know about type of RTC device.

Regards,
Anup

