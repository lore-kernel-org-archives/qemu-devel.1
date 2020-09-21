Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9AC8C4363C
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 21:40:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E39D120708
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 21:40:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="nPW2vjQp";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="P1uPE3J1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E39D120708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52668 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKTYD-0001F4-31
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 17:40:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51714)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=5267d097f=Dmitry.Fomichev@wdc.com>)
 id 1kKTWw-0008Jc-E6; Mon, 21 Sep 2020 17:39:26 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:2771)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=5267d097f=Dmitry.Fomichev@wdc.com>)
 id 1kKTWp-00060Z-3P; Mon, 21 Sep 2020 17:39:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1600724359; x=1632260359;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=6m+TrWQX9PcuWY3NFWBysHztiLd19dv7M15qj3A4RHg=;
 b=nPW2vjQpFSyhp8dkaYzQiQaGRY23x9GRdvmi5+/TgOLvCaKVe8EpVMQ9
 9tEWFCr6F1P/zxxtZkc/BYBrS0MNAaRzO0kSmqVAscwBNtW/uNYRnOR5A
 F6GmkWLDVXYQV3WoXA0p3Bk+lY5i4HGp72BMsU7jMPTrl1OMDesZGhoqH
 gXj7Pm1ujDScQ5GuLHN3LfRpUHaWhFSCMbTYvqaIlSewMb2cm6ZjYkDXY
 uAJ/0VNcaQLlE2Dv0kagY8Z9IcGEHg97vnOgjpiO2L370V5tsLcaG7BqO
 j0yut7QGH4zNjUKrR6lWWCNbLVcsO367g4ojPkn/4QkLStEQZQiQj3tqT w==;
IronPort-SDR: yT/oBdUAwLri5rhtcMwms9NXpS4pEmaGt9XiV+7dFc2pVTB6a3Rqyz5MOmT9ZBInjBIhr7bkhe
 7p800uXzXbMgN4iFntKphoTmu0vDoas/zXO5gu0/crJqH9wLo202GeOMIfjDWck/Z702tvBU3l
 9PYddw9qcFL1V+sSudPLgv2TFBU6bytwI0whX+C+wUP8N1E4PTQBo0pVP9+buQwgMQ7h9ZvyAr
 OMZRdaH+Q0VqVeBHg67e2PuGHp4x1czuUbTTnLhlDFZHFygklc8mTc3TpGGbuYab/fPL/pyJFG
 IpQ=
X-IronPort-AV: E=Sophos;i="5.77,288,1596470400"; d="scan'208";a="152295638"
Received: from mail-dm6nam12lp2170.outbound.protection.outlook.com (HELO
 NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.170])
 by ob1.hgst.iphmx.com with ESMTP; 22 Sep 2020 05:39:15 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OqF81EoMfC4sJfsRE41zmdSdMeMgn1dt5xsTtlPRTY8yjKcIvmrvXOq2Ryi2q5ni2ad65+A7ququHcjbl2tCdHvDhV6+vWQ+6oH7lcw13QjCpDat2S+zwiT3rwSXcqJLEK55ClFIvWAQ3OUR9BtpJFuifVEC7ocqSBmsXfhnCDmnTGZYjKs51EkWhHUwJnx8aB0h7iK7zLDwyOiErEHV6uRKre5zLJ/XelwS/DxsbOyihqXcc7RvcXYq1GTe43yuRFKfWwi/BEYse5SzKmabA9iHz4H0BNDhrsgJzXP6Z/iElqPT0JcS1Jx+bmJKESsE3OQyACTdmBISzFDuvHoZNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6m+TrWQX9PcuWY3NFWBysHztiLd19dv7M15qj3A4RHg=;
 b=Lho0q+mVbM8h54PO+VljVzHPIBYqdVMyb3r/mR99niw4m1k9kUXccZAzNR0GtE5qEYD45v1RV7eWyuDAFmzv0QkQGI+Thbj+wGp9qEyrJsSghbu2tKvdyl53p9sPG/c1S1gAMp3pKIOZCxBM7ywldcrs92kimGvb5hkU9bw8Hz09j55XHicgSqsVJoJtVgo2X2sNYGBAkXrFRLGIhKhd9f0H+klKtl2QUKOPZvoyH3JR7u0Y33A459Es+UtoGL8B7G0nIz0uEV9XcBAbh5zM9ACEe2EJX7Ippj89R33ZSfkqpoTuMJ4woo1LhXTDVBCKOeaQTshCRnQElFCRWGfvNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6m+TrWQX9PcuWY3NFWBysHztiLd19dv7M15qj3A4RHg=;
 b=P1uPE3J1TXRM1Kx21sM5wZQx7lrc9ztdrX2AJEXlTYlpYq7OCNc4dt5384gCTJaGEgdrzmeki3n9x73cI63QZ3O3mEaNM+Brlo0D1Ka+lBhK9oIdkUG6/CAVLS8eyoRAJNgUfSeuC7Jvf4u/cJLvfH6FZP8w8pK/5W0ZAGPfgv0=
Received: from MN2PR04MB5951.namprd04.prod.outlook.com (2603:10b6:208:3f::13)
 by MN2PR04MB5663.namprd04.prod.outlook.com (2603:10b6:208:a3::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11; Mon, 21 Sep
 2020 21:39:09 +0000
Received: from MN2PR04MB5951.namprd04.prod.outlook.com
 ([fe80::44d8:522e:db29:bb94]) by MN2PR04MB5951.namprd04.prod.outlook.com
 ([fe80::44d8:522e:db29:bb94%6]) with mapi id 15.20.3391.026; Mon, 21 Sep 2020
 21:39:09 +0000
From: Dmitry Fomichev <Dmitry.Fomichev@wdc.com>
To: Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>
Subject: RE: [PATCH v3 01/15] hw/block/nvme: Define 64 bit cqe.result
Thread-Topic: [PATCH v3 01/15] hw/block/nvme: Define 64 bit cqe.result
Thread-Index: AQHWihtL9tNHpqz1v0eii/7TyAZucKlpUd8AgAC3oNCAABaxAIAACKzwgAAGJoCABL0KgIAEvKPA
Date: Mon, 21 Sep 2020 21:39:09 +0000
Message-ID: <MN2PR04MB5951966E28E9F3604C5D48B0E13A0@MN2PR04MB5951.namprd04.prod.outlook.com>
References: <20200913221436.22844-1-dmitry.fomichev@wdc.com>
 <20200913221436.22844-2-dmitry.fomichev@wdc.com>
 <20200915073720.GB499689@apples.localdomain>
 <MN2PR04MB5951ED0FD5633E8144459A28E1200@MN2PR04MB5951.namprd04.prod.outlook.com>
 <20200915195546.GA14485@apples.localdomain>
 <MN2PR04MB5951E0BA1D9E217C37B82ED3E1200@MN2PR04MB5951.namprd04.prod.outlook.com>
 <20200915204849.GC14485@apples.localdomain>
 <20200918211027.GD4030837@dhcp-10-100-145-180.wdl.wdc.com>
In-Reply-To: <20200918211027.GD4030837@dhcp-10-100-145-180.wdl.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a4ecb863-4918-4e29-658c-08d85e76c5e8
x-ms-traffictypediagnostic: MN2PR04MB5663:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR04MB5663E02A16EAF3232A94E1E4E13A0@MN2PR04MB5663.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZgFEf6r1YVSZu2vp3+hUOmTElJmtGVJZIyB3QmHOTZZp9lvZdRjI7EqPTOW3Cpg2Tv6uiKgwPbVG+7Uy7sEYJz/dKxfReasNISoPLCGPEXJRPKGzZWQzIM+msIJJKLznLQQSi0VAC7LHAcTaYcae95z2JuRpcnORDN1uDIOxsbn9KHjCfct40rp60mDOkTvKEM8wAzYrx1JadDhQmRolvhi427QPvCLq/YBbxU1ILOvPl8Uf3qN7cQ7aLmVmM7/nZfAwzaX0bbC95c45QclcbzjF6SzKeCtv4m6yemsTx4lRCzE1EAR36qOy7sScBC86y8OhCLszvhY7t6N4Hs1ngA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR04MB5951.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(346002)(136003)(376002)(39860400002)(478600001)(316002)(66476007)(76116006)(64756008)(7696005)(8936002)(26005)(4326008)(71200400001)(83380400001)(86362001)(6506007)(186003)(53546011)(54906003)(8676002)(110136005)(5660300002)(2906002)(66556008)(66446008)(66946007)(55016002)(33656002)(9686003)(52536014);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: z8uES8gDdZOD6t1YmV+OdaWarvnm39Wu10TSkwsMq5qUQv8Lne/t1dEoG5qyzLuKY9f32A92AKJO4fPUYa8Xu6Ujz3ztQ+0gxzejOtIbxk36a+9oHwLKQbME8PyeWtumgtO9r6sqkDDMJilHcsxtYE+N7vz/B7k5ETUhhc6bX2af4V2OENIx3E+F1QDYaIvzBmarbXT7TcO0Zt5PAoRm+XnT38cvvLnJsrL+HtHGktgGTcOfdWpRsiB3VlaNPW/MXwjqX3U/ERO0fXBjhUmApr/x3a9xv6aCagOYeShBhLGa63rZjPeyIiVEX0mTACpbkzFT7Mum3UbwwxyH3ijbJIa2ywoLzG/qtnxhXojCBUcli7+L4r3qsqQIQdrCE57zM99W5PgceBHznnlKPEyhsz+b6BG9mObvL3rG5Vmm6r0r16M7UY/KaZtBrMhQ7mJtwFhO3aIcOhcZFJ1yJ68cMzBMFwO1ossgxGLBEvYN7e06VL3Z4XCVlfoRLorqfEPuSmt4TVKmboybHQ3g61pSqAjjZ+yjGPlyDFeawDWDY9wLz+RzMtV5A6KR9oCwLgEmJesAkl6G2aPGuNOE+NbGkjrUk30pZzJHGVOO2kbheNcpE4oqJqXMAsNhCXaxPD7A+gzl+87ykovK5zt6MxOomw==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB5951.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4ecb863-4918-4e29-658c-08d85e76c5e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2020 21:39:09.0570 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZEvfnJVfBt6mYzYhd6AnZZVq2dOik1u7/RZtnLVqF53RmP8yx6jK36B+j6OHg8caNLkZPXab6qMVuGaR5Cd27w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5663
Received-SPF: pass client-ip=216.71.153.141;
 envelope-from=prvs=5267d097f=Dmitry.Fomichev@wdc.com; helo=esa3.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/21 17:39:15
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Damien Le Moal <Damien.LeMoal@wdc.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 Niklas Cassel <Niklas.Cassel@wdc.com>, Klaus Jensen <k.jensen@samsung.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>,
 Matias Bjorling <Matias.Bjorling@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> -----Original Message-----
> From: Keith Busch <kbusch@kernel.org>
> Sent: Friday, September 18, 2020 5:10 PM
> To: Klaus Jensen <its@irrelevant.dk>
> Cc: Dmitry Fomichev <Dmitry.Fomichev@wdc.com>; Fam Zheng
> <fam@euphon.net>; Kevin Wolf <kwolf@redhat.com>; Damien Le Moal
> <Damien.LeMoal@wdc.com>; qemu-block@nongnu.org; Niklas Cassel
> <Niklas.Cassel@wdc.com>; Klaus Jensen <k.jensen@samsung.com>; qemu-
> devel@nongnu.org; Alistair Francis <Alistair.Francis@wdc.com>; Philippe
> Mathieu-Daud=E9 <philmd@redhat.com>; Matias Bjorling
> <Matias.Bjorling@wdc.com>
> Subject: Re: [PATCH v3 01/15] hw/block/nvme: Define 64 bit cqe.result
>=20
> On Tue, Sep 15, 2020 at 10:48:49PM +0200, Klaus Jensen wrote:
> > On Sep 15 20:44, Dmitry Fomichev wrote:
> > >
> > > It is not necessary to change it in NST patch since result64 field is=
 not used
> > > in that patch. But if you insist, I can move it to NST patch :)
> >
> > You are right of course, but since it is a change to the "spec" related
> > data structures that go into include/block/nvme.h, I think it belongs i=
n
> > "hw/block/nvme: Introduce the Namespace Types definitions".
>=20
> Just my $.02, unless you're making exernal APIs, I really find it easier
> to review internal changes inline with the patches that use it.
>=20
> Another example, there are patches in this series that introduce trace
> points, but the patch that use them come later. I find that harder to
> review since I need to look at two different patches to understand its
> value.
>=20

I decided to split the trace events to be separate because I felt that it
could make the reviewing process simpler. Since the majority of the patches
in this series are on the large side, I thought it would be easier to open
them in separate sessions rather than to review a large single diff.
Let me know if you'd like me to fold the tracing stuff together with
the code...

DF

> I realize this particular patch is implementing a spec feature, but I'd
> prefer to see how it's used over of making a round trip to the spec.

