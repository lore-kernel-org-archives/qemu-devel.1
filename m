Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D550C4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 23:07:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2DC422240
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 23:07:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Jy3EvILA";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="mi2nIP2b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2DC422240
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kV0in-0004O7-PI
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 19:07:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55190)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=55587455e=Dmitry.Fomichev@wdc.com>)
 id 1kV0gp-0002uu-CQ; Tue, 20 Oct 2020 19:05:11 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:51667)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=55587455e=Dmitry.Fomichev@wdc.com>)
 id 1kV0gn-0000Do-DR; Tue, 20 Oct 2020 19:05:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1603235109; x=1634771109;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=V45ZIATeF9kTyrZ8kWk9DC2c+cAkfAysjNcvO9xIC68=;
 b=Jy3EvILAbq465CW/iCcYMHmsHweyu8thI2TohOd2iBxG4eGUfq0zeWAh
 g51TMEnlYvBWrlyDji1VfLAlS/EnOMoUxgA1ARVQsX1Lzt/wLZqf+rvr1
 0LtW1Pcpt7XOHr56WdhkumUoQdO0SzOdATckIcJFZwQeMVma4xfR4/i2n
 2TaJ/IyT5sqxrur0uUFkbraxLBifR/+3X3fdut4dgrY4UWs9744TmPawQ
 CFBG7KOmFjsAiQQwU7LK/ioXBZMX3TTMzadzcxc0Pf3iKr396tXM3AfcL
 RRB+yMG3na4yr49qpkKIECBdMK6y4sXf1FgzSwr4HjTSKNaSQa0upxsYq w==;
IronPort-SDR: bsoOkIcCYQ1tQqBT6CEdqclTEyzEusVhD+GG0CSiikvFFmW9RjagWBS9UipzdHlbIymuo5QgOt
 3o8tzZBqUmyk/15fB427TtfggEW6zvE824v6hbpG+dAzGd4DUE5LVULC/XYHnic591y/rQfYxK
 6Akdrh+dibSgbB6oDK7p6b0F69E63Mg01zuG4izmMM5DxzBwZEtoBoAK8Gv/jm0gmmBHKBBr2y
 BC8htLG1xdYYjZdsF6o9YKUI8NsRRO9bWv8TG/Hjs/8A8Xl4HvZ8nA8dZqWr+mztDFIb1oAfaB
 EL8=
X-IronPort-AV: E=Sophos;i="5.77,399,1596470400"; d="scan'208";a="151694330"
Received: from mail-dm6nam12lp2177.outbound.protection.outlook.com (HELO
 NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.177])
 by ob1.hgst.iphmx.com with ESMTP; 21 Oct 2020 07:05:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PNhooMMWoRPOX3Qpr+TD2lIFdnLbT2Q9JyDhvzHXJ7c+3d4OyIUk8mXuyYHgE56PevHpsTgEF5uqq27ABW5dYncLHUea03Q2caOdQ6jZEQauaOxLxyaQrCz8lD9RXZuyJbidOiIv9BF03C9TjUBHsH6wrg39FW03XUddZehTSNi+FRR7fgwpzzjPo2OzRjtPH7Z9xU/Oe9CPnB357S32bXh6y0gVQQzxa8tOYWF5bCce7NzwwFi5ygrZywpf6nfgj9i+rjZdmQEFNmZV/SX9JYNLzruid+RmIhe8RkP1i0QxpH1zIH3vR9pSaunbVhM6APQIKdwisVTNtXQz6I2Xmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V45ZIATeF9kTyrZ8kWk9DC2c+cAkfAysjNcvO9xIC68=;
 b=Qa4YrP9o85P6juybEsIh/EMqPz2UTHebMtXCQWQWj6aJ0Rrw0Dtma/o+4RHE72dqLWOP4TlDmpW9Qzsq3NSj/KSQmigDnugeLlu261E5CDR9k84Klu/pqcHozlZZxMocp2hypUC3irPdsOBXJT2WegAGogwAKLpqtETADJkQiaKHJI5b9vlST6IHPuyDSbDb2NrX47UGCjbPqF7vj0DoHDzSr7gQq+YrMFZ0FH8LCHG0fOrrurTeDCxONDPovvdNtzyu4nPjbAzyZ9//kI3BfRTgqFAQYv6KGHur02t6pRPRee203pdzfWkPUVsDjoFBtHIWv29kpNWnsB7eYMyU0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V45ZIATeF9kTyrZ8kWk9DC2c+cAkfAysjNcvO9xIC68=;
 b=mi2nIP2bUmkYxONTJ2zZESFr560aeDPIhzDLI/LQaJawd6IR6VlsnK7sdYZkm55hQcQI4tCEZ/WO489jJtPdRRIYqNAsm804ifklaFLHBKBlh31FzMJnHuHgqwZ3e+9WM3RzNPD+ls4P5q+JDxuc3K4cZsRegbcDHqKCaaZM5W4=
Received: from MN2PR04MB5951.namprd04.prod.outlook.com (2603:10b6:208:3f::13)
 by MN2PR04MB5551.namprd04.prod.outlook.com (2603:10b6:208:e3::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.25; Tue, 20 Oct
 2020 23:05:06 +0000
Received: from MN2PR04MB5951.namprd04.prod.outlook.com
 ([fe80::44c9:85df:4910:44d8]) by MN2PR04MB5951.namprd04.prod.outlook.com
 ([fe80::44c9:85df:4910:44d8%4]) with mapi id 15.20.3477.028; Tue, 20 Oct 2020
 23:05:06 +0000
From: Dmitry Fomichev <Dmitry.Fomichev@wdc.com>
To: Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>
Subject: RE: [PATCH v7 10/11] hw/block/nvme: Separate read and write handlers
Thread-Topic: [PATCH v7 10/11] hw/block/nvme: Separate read and write handlers
Thread-Index: AQHWpb4RWJ+SZT94N02Uqvb2Z2YJwamgKnUAgABFTACAAFfnsA==
Date: Tue, 20 Oct 2020 23:05:06 +0000
Message-ID: <MN2PR04MB595185AC8B1FD655C1961771E11F0@MN2PR04MB5951.namprd04.prod.outlook.com>
References: <20201019021726.12048-1-dmitry.fomichev@wdc.com>
 <20201019021726.12048-11-dmitry.fomichev@wdc.com>
 <20201020082822.GB178548@apples.localdomain>
 <20201020123624.GH1435260@dhcp-10-100-145-180.wdc.com>
In-Reply-To: <20201020123624.GH1435260@dhcp-10-100-145-180.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8274a7b3-bb9b-4ffc-7d0e-08d8754c95e3
x-ms-traffictypediagnostic: MN2PR04MB5551:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR04MB5551579A7A11155A5544805CE11F0@MN2PR04MB5551.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iv+Rj3EBcOgcM7dacFCVQsRSeTSBbjQJBiM9dLWEe1g7DZ9wv6mTboiW9XcuYA7TFozvI5gn99ZkAqmPKIi98GgSIPOuvCgudTUgDtpDFupDQSGOzWS6vcbpxVyV1fngBso5XE5ctO7YkrdQSQNjaLXlYyk6j/u8kWY9/Jb9M9YxYwyVEtdFnUZHJl7FP3Czr/XD9CtN8Ia19wKRMANjsLzEhxJ97sQ2fvGmNSO1kIoDZAiKq/of8la3VdZsKayctClZ3S2nMrQVZ+ZqlLjo29SN+nWFnJZOdJkSfaB50LiyN37xhUnAaVKf694C7kglA6xlKcY5i5F/4lQ2gQSrrA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR04MB5951.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(366004)(346002)(376002)(39850400004)(26005)(33656002)(2906002)(55016002)(478600001)(83380400001)(8676002)(4326008)(6506007)(64756008)(110136005)(8936002)(66946007)(9686003)(76116006)(5660300002)(7696005)(86362001)(53546011)(66446008)(71200400001)(316002)(186003)(52536014)(66476007)(54906003)(66556008);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: 0qWcSqCFsgoKV3boweFrPFSevE17Hfovbh3pxuLnmOWXgP2JhzdQdsmo9uCTcc38CColWv0SekBZUok3bnKNZPVJJQpdMnnQKwU5Sg7NyqbWicKqAid162D+NGLzSPnVf6L/ebfYwOhbWpHTxecW6OWfTphi0Sis0MHeb7DORTC6OjCjFdY6wSeXYdDtRdk4Sp5dwzL4Aep+rKD/PKU8fVr6DJadnBDdjVHqCYnPRrLrqgKgBQFRDs1Ev6RioCdEuevh3FAbLjDFKinXxLE0h0xX03Qk1CzeZJcqURN7kKd5KXLbYjHkYz9zMQ7syJJSNT49xE7OLLWGzd9P7382WHL+CCUZuv+iKVWVyfs1f1D2X5pwxVDdG3pi70JFYKeMLdVQCVRX7VjWdJuEk0yTqeUXXSCptpcmMQJkqJ8TwgpOlbbz69GjRiWgQdTXlkOXTmeNprreOD6+4VnzbgkJ84ASP2YsG/iIQBpMnwZWYE2l/OBVzr7nlsjIVDnkSCUpf41BGE6tMgHRXvVlep7RWOTd4L40yypAwVosRrsEPzWW5XaPSUZqJ+kcRJgDbtCixf/2uxWFIRUHfsjpc67C+HHmg1nhxuikYuMuHTCbp7XUvuE8e7+NjJWQDC3MbT5oCuI3SajEroixDsHsFFFDXg==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB5951.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8274a7b3-bb9b-4ffc-7d0e-08d8754c95e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2020 23:05:06.3724 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sBuixbBCk7P5ur3QKTCP8Tzyc+FcVk9mPuwfE5sN/Om/hBtKSxB1oDKQ9uRdeAyOYEFxIVCa+85uHtGNDPJwpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5551
Received-SPF: pass client-ip=216.71.154.45;
 envelope-from=prvs=55587455e=Dmitry.Fomichev@wdc.com; helo=esa6.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 19:04:59
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Damien Le Moal <Damien.LeMoal@wdc.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 Niklas Cassel <Niklas.Cassel@wdc.com>, Klaus Jensen <k.jensen@samsung.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Maxim Levitsky <mlevitsk@redhat.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>,
 Matias Bjorling <Matias.Bjorling@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> -----Original Message-----
> From: Keith Busch <kbusch@kernel.org>
> Sent: Tuesday, October 20, 2020 8:36 AM
> To: Klaus Jensen <its@irrelevant.dk>
> Cc: Dmitry Fomichev <Dmitry.Fomichev@wdc.com>; Klaus Jensen
> <k.jensen@samsung.com>; Kevin Wolf <kwolf@redhat.com>; Philippe
> Mathieu-Daud=E9 <philmd@redhat.com>; Maxim Levitsky
> <mlevitsk@redhat.com>; Fam Zheng <fam@euphon.net>; Niklas Cassel
> <Niklas.Cassel@wdc.com>; Damien Le Moal <Damien.LeMoal@wdc.com>;
> qemu-block@nongnu.org; qemu-devel@nongnu.org; Alistair Francis
> <Alistair.Francis@wdc.com>; Matias Bjorling <Matias.Bjorling@wdc.com>
> Subject: Re: [PATCH v7 10/11] hw/block/nvme: Separate read and write
> handlers
>=20
> On Tue, Oct 20, 2020 at 10:28:22AM +0200, Klaus Jensen wrote:
> > On Oct 19 11:17, Dmitry Fomichev wrote:
> > > With ZNS support in place, the majority of code in nvme_rw() has
> > > become read- or write-specific. Move these parts to two separate
> > > handlers, nvme_read() and nvme_write() to make the code more
> > > readable and to remove multiple is_write checks that so far existed
> > > in the i/o path.
> > >
> > > This is a refactoring patch, no change in functionality.
> > >
> >
> > This makes a lot of sense, totally Acked, but it might be better to mov=
e
> > it ahead as a preparation patch? It would make the zoned patch easier o=
n
> > the eye.
>=20
> I agree with the suggestion.

Ok, will move them to the front of the series.

