Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34241C4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 14:23:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F25752146E
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 14:23:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="M2hQkRMn";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="LKAlbRMT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F25752146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51584 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDrA4-00078z-6V
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 10:23:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39046)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=1667f8e37=Anup.Patel@wdc.com>)
 id 1iDqWP-000629-Ug
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 09:42:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=1667f8e37=Anup.Patel@wdc.com>)
 id 1iDqWO-0005OQ-F3
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 09:42:57 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:42151)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=1667f8e37=Anup.Patel@wdc.com>)
 id 1iDqWI-0005Mf-Uq; Fri, 27 Sep 2019 09:42:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1569591770; x=1601127770;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=AdG/Ma97bGwYoW5GHdxg4pVBxOBYmdMDcr8pNIivH0Q=;
 b=M2hQkRMndzlR+aLAPfk+fG78IQeekhqxhzj4f0g+M/CG/cmqpNRGh/Zz
 PT71ilFhB5SruJj3jIXlawDW5JxY8FZ/Yryf6zzOV4eKVwvpv5sQY0aq6
 OfU3NrST7vu/ZEVIYLNRLiv9Iqkh1plPo6ZGXbdUi+zdiAFhE9P/34qzB
 MhnqMmX1WB7AvD418pYZS0grlmWa61zvBL34TBqCb4nzCC20uFlAvrXa7
 KxdoanAeYj1+VCMOc9ck/9N7fpQayvIaJ4FHopnemW15b3IWjkXmmiJ4C
 Ks99BamspnO3rPzNYdlnyUzIr1da+X7ebjZsiZHq1unIvh12qQEiORY5I A==;
IronPort-SDR: WVFBquT3WmdAhZpokO+orBlAxpgwNHJ6NU1z5mFtnrTzF6xYKP9pFFBhKet+9QBvGP2H+IbpJz
 tfVBPQyM5VQdqFyRaWegYgWA8uh+MiJboz21F9lg/G4SlHlgn3Rqb/JiLzg4mmOm0F/FmaDnOm
 o+WMBG7pd1A7lD6OJKtgJQNse32JYYgQq/8EZXpfEcPnCEnRSii5YVSu7ngqpPpF4F3UGasMSb
 kwYPUIQri/ZztzO8UQLsslM+PQqFWaXZS/4ioIbdo3GTa2w9wwix/sbJ1kPPorVzDa826UcTPS
 wfE=
X-IronPort-AV: E=Sophos;i="5.64,555,1559491200"; d="scan'208";a="226150602"
Received: from mail-sn1nam01lp2055.outbound.protection.outlook.com (HELO
 NAM01-SN1-obe.outbound.protection.outlook.com) ([104.47.32.55])
 by ob1.hgst.iphmx.com with ESMTP; 27 Sep 2019 20:05:46 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TR8ltAm9vVyPDBwNTckPu9V1Lxrjex2q/pfpeDCfBI381LlqsF2jJlnW8DhFirz4VL11Feql51GvxC6YaBUEUI4Sk4tjUHe7WLGZKdJrNToyM349rdyWifrtICb8GTYC9loZ90SGNY1jGThlNwNBjPb5g5KXUG/jNDa7Y+TX2S9aaG4cxfAKvYnYrLRJnz84PEaDbIuI6PJSjzbDx+vqXiFFbbqqCMLMETNEHS3BKiBD/IvFAb99zOP9zcx10/bSytm+gOZhIVc4pRTdISiPqSSTKQt27ciJwFgH4Z70Wpg1f3KK9H5/1gt2rjqvMGCJKZILxfaipI79posDYoIF3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zMs5nPI/BWWnFzJpQsnBNJaBSfFZgPPzwjxpQbw0bA8=;
 b=Oms0EnoPtuqxNNNlzXn4i6J+abAqKga5AXDRW+xkW7aKBEjmR6s1NL+P5iAN51LZ/9TjRrnjTgEREcNtZDBdrE68Oz0fJscZHO67rF7vM3MmJUATbQ+F5so6oQdKLosq1qa/ybFWLZjgTgVjx6+a1mXCHjZrLrDRdziPug2QdSFr9eYg80KGeiLysZxIXGIfEpqu2Y3F8HTePNWyhDspclMrJzAE20yswHT5mctdmYnoAUFLZS2cfxGXzQeCX4UWNE567lKQXAjzXWKqoraSc5QCVn1Z3gBBOpqof4DinY9w31OA5z/NMQulwEO3CYmMjJMUvZ8ma1NJJ31uB/xurw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zMs5nPI/BWWnFzJpQsnBNJaBSfFZgPPzwjxpQbw0bA8=;
 b=LKAlbRMTzDqxDr945d4OMfPLWS4LYQ/vBwyWzgat/PGETafXA++oUxP3ZcO5LcWQHeXtQF+Yvsy4nIZlDoEjpHNVe97Ldy4CX8/r5kBAzq/HkU9G7ukXmYSZbAOcLcDcs+fl1pJkcvnx6+Y9h1tSDp8rLAVrzK0rdclG+93qp6o=
Received: from MN2PR04MB6061.namprd04.prod.outlook.com (20.178.246.15) by
 MN2PR04MB6992.namprd04.prod.outlook.com (10.186.145.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.17; Fri, 27 Sep 2019 12:05:45 +0000
Received: from MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::e1a5:8de2:c3b1:3fb0]) by MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::e1a5:8de2:c3b1:3fb0%7]) with mapi id 15.20.2284.028; Fri, 27 Sep 2019
 12:05:44 +0000
From: Anup Patel <Anup.Patel@wdc.com>
To: "Richard W.M. Jones" <rjones@redhat.com>
Subject: RE: [PATCH 0/2] RTC support for QEMU RISC-V virt machine
Thread-Topic: [PATCH 0/2] RTC support for QEMU RISC-V virt machine
Thread-Index: AQHVcrQDVebPiIecyUaeeiRl9lWtHKc/bjGAgAADe6A=
Date: Fri, 27 Sep 2019 12:05:43 +0000
Message-ID: <MN2PR04MB6061BA18651453F590A1CE738D810@MN2PR04MB6061.namprd04.prod.outlook.com>
References: <20190924084201.107958-1-anup.patel@wdc.com>
 <20190927115047.GA6575@redhat.com>
In-Reply-To: <20190927115047.GA6575@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Anup.Patel@wdc.com; 
x-originating-ip: [49.207.51.217]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 41d1a28a-24c6-4e01-eaa7-08d74343067f
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: MN2PR04MB6992:
x-ms-exchange-purlcount: 4
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR04MB69921A7C40E1FE78CF1EE49B8D810@MN2PR04MB6992.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 0173C6D4D5
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(366004)(396003)(346002)(39860400002)(136003)(376002)(13464003)(199004)(189003)(478600001)(14444005)(7696005)(5660300002)(6306002)(256004)(14454004)(53546011)(316002)(6506007)(4326008)(99286004)(9686003)(71190400001)(71200400001)(966005)(6436002)(25786009)(66946007)(229853002)(186003)(102836004)(486006)(52536014)(66556008)(76116006)(64756008)(11346002)(446003)(66446008)(54906003)(66476007)(476003)(6916009)(8936002)(2906002)(74316002)(587094005)(55236004)(26005)(6246003)(81166006)(81156014)(6116002)(3846002)(33656002)(8676002)(305945005)(7736002)(66066001)(55016002)(86362001)(76176011);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MN2PR04MB6992;
 H:MN2PR04MB6061.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: H3PJ42lmoRMeibFd6Y5p2aiPgWM6Xeywxumyt26w+50IE1hYGmTy5kAIHeoxv4QsiybKsIumNUQsyytytlrtpzLLlEGS1lpLLEHWPcQjRWOZlci1QzzGMvdqUR7j9RzOxXfr5Ikg/+0UHE9cOsgJIY3/RK/K/4alCvW6oOv5i8Ow0rHgKYIkXyTxilxvxMeyeWQUM71YDN5kfqsu4vGRTr/S15fHQRTlpBTbpFnR8c18sQZlc22ZByV3zWvjwXTFjuvKweK51oC9zoVZ5pkzl/aLXySqffC/ujysNaxXnZPaYn7maQsVeuqvrUIpc2erh7GfcF350e9XW22w9wxFr5xsOGjNrNkK1B0TPmsIlOV+XtsCrHVHf/FkG0VJdFEiu2fMBiNXWjnyD35oJrYh6+V05QQnkOIfbt1bmomu2t1E8XOL5B7Toti0MeXVjjHcKMVPGZ+bKH2DC0ya9LptLA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41d1a28a-24c6-4e01-eaa7-08d74343067f
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2019 12:05:44.1953 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hmfZdH4UpDYARbc9OW2wNy1gWZY0RWdZx9/+cuqOTgJGdDd6Z9rvdC3fObGXW10vcukhI4PV3m6iOkuTDLf4rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6992
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 68.232.141.245
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
> Sent: Friday, September 27, 2019 5:21 PM
> To: Anup Patel <Anup.Patel@wdc.com>
> Cc: Palmer Dabbelt <palmer@sifive.com>; Alistair Francis
> <Alistair.Francis@wdc.com>; Sagar Karandikar <sagark@eecs.berkeley.edu>;
> Bastian Koppelmann <kbastian@mail.uni-paderborn.de>; Atish Patra
> <Atish.Patra@wdc.com>; qemu-riscv@nongnu.org; qemu-
> devel@nongnu.org; Anup Patel <anup@brainfault.org>
> Subject: Re: [PATCH 0/2] RTC support for QEMU RISC-V virt machine
>=20
>=20
> On Tue, Sep 24, 2019 at 08:42:36AM +0000, Anup Patel wrote:
> > This series adds RTC device to QEMU RISC-V virt machine. We have
> > selected Goldfish RTC device model for this. It's a pretty simple
> > synthetic device with few MMIO registers and no dependency external
> > clock. The driver for Goldfish RTC is already available in Linux so we
> > just need to enable it in Kconfig for RISCV and also update Linux
> > defconfigs.
> >
> > We have tested this series with Linux-5.3 plus defconfig changes
> > available in 'goldfish_rtc_v1' branch of:
> > https://github.com/avpatel/linux.git
>=20
> Why was this device chosen instead of kvm-clock?

We need a RTC device which worked fine in TCG mode (even without
KVM). The KVMCLOCK is PTP clock which depends on KVM hypercalls.

On ARM virt machine, we have PL031 so instead of that we have
Goldfish RTC on RISC-V virt machine.

Regards,
Anup

>=20
> Rich.
>=20
> > Anup Patel (2):
> >   hw: timer: Add Goldfish RTC device
> >   riscv: virt: Use Goldfish RTC device
> >
> >  hw/riscv/Kconfig                |   1 +
> >  hw/riscv/virt.c                 |  15 +++
> >  hw/timer/Kconfig                |   3 +
> >  hw/timer/Makefile.objs          |   1 +
> >  hw/timer/goldfish_rtc.c         | 221
> ++++++++++++++++++++++++++++++++
> >  include/hw/riscv/virt.h         |   2 +
> >  include/hw/timer/goldfish_rtc.h |  45 +++++++
> >  7 files changed, 288 insertions(+)
> >  create mode 100644 hw/timer/goldfish_rtc.c  create mode 100644
> > include/hw/timer/goldfish_rtc.h
> >
> > --
> > 2.17.1
>=20
> --
> Richard Jones, Virtualization Group, Red Hat
> http://people.redhat.com/~rjones Read my programming and virtualization
> blog: http://rwmj.wordpress.com virt-top is 'top' for virtual machines.  =
Tiny
> program with many powerful monitoring features, net stats, disk stats,
> logging, etc.
> http://people.redhat.com/~rjones/virt-top

