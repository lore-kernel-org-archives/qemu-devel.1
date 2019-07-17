Return-Path: <SRS0=PWhW=VO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15F64C7618F
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 20:58:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1B0C21743
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 20:58:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="CoIOu5b2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1B0C21743
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60446 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnr0U-00038u-W1
	for qemu-devel@archiver.kernel.org; Wed, 17 Jul 2019 16:58:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42167)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pburton@wavecomp.com>) id 1hnr0J-0002es-VA
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 16:58:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pburton@wavecomp.com>) id 1hnr0J-0005h2-0S
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 16:58:23 -0400
Received: from mail-eopbgr690134.outbound.protection.outlook.com
 ([40.107.69.134]:6597 helo=NAM04-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pburton@wavecomp.com>)
 id 1hnr0I-0005eg-M5
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 16:58:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lBZgMPW/iixJxF7iaqN0f9aYFbx5LDPJmHwTW8cCf5Ljlybq2ZeGFeg7zJCFp5Nmd/xQ0U33ibdDrZIk/itOlOsvtEQFK9fdpuihKM9/E01KSwX8jrCzD9RRl/GKlYquBawsM0Qhl30i9YzkTzhlFV9gC5mQ1VKHUwkgwmN6mWePIaeAyFUc6/Jam6yqaocTq19dWh1HjxEr5Vmh4M06O9hFN/ok8XPUIDC1rdfw33nzpAvItb1UATafjXwd+LpkoQVXlGvKVIfoZnMATMf4+itDomWSoIfncHQgUh6XeNkDJvtjW0qhqom0CWgI2IxVLtpr5gs4X2qNz3rac5rgPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xFfr36gWKFim0AmMEBMHPVCAYealNgMI9pTYz1XAD8A=;
 b=CkE578MtHZgxx6tANCJB5Gxokp1/kahIdjOim/bNl95ffnw4mliDzUEnLmeN5jMO8AZgp20hY4Wq5lyqTK+4aQIh8mIF2FDJ2q1T8j5rYL+jUtNOwfvtEipJiNF/S8cq5f3BGKw9liJA6I8u8bHkD0JF+5tH4a70iicV23XukqGcM9o3WfolOGlTfASAg+Tfise8wH/LxfWZ/x9fYwXPrA7o/yqELXVB2tImXGNxj/8Gf4yTcduKyHwX8fyXpCkqPDRtGOPi5P7wG9KP6gK02YE62isbuyckZSVJ0IG0NPk2BFJKmHBOZxsNrEN5IXo3SHp9/MUcjkT7sG21ZULX9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=wavecomp.com;dmarc=pass action=none
 header.from=mips.com;dkim=pass header.d=mips.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavesemi-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xFfr36gWKFim0AmMEBMHPVCAYealNgMI9pTYz1XAD8A=;
 b=CoIOu5b2KpmzMwvsw/Tvidd5JAc/ZnkCXHkG++fGRzIOSorTGfqzilk8g02pDZMzYCl+bq1gmQSSY2z5M2IkEf5DgBDbcKcE3SeF21u01OUA5f1exyGYkjkOa0S1x2jDV+bPOJsCnSj0QDnhOnpgjzz1KQkLrhyfOVY1oZ+hW2s=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.172.60.12) by
 MWHPR2201MB1549.namprd22.prod.outlook.com (10.174.170.162) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.11; Wed, 17 Jul 2019 20:58:17 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::746d:883d:31:522e]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::746d:883d:31:522e%5]) with mapi id 15.20.2073.012; Wed, 17 Jul 2019
 20:58:16 +0000
From: Paul Burton <paul.burton@mips.com>
To: =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <f4bug@amsat.org>
Thread-Topic: [RFC PATCH 10/10] hw/pci-host/gt64120: Clean the decoded address
 space
Thread-Index: AQHVMDe0AxUJbJalrkypsvYZt/0scabPZESA
Date: Wed, 17 Jul 2019 20:58:16 +0000
Message-ID: <20190717205815.3kx45uxu3ahv4q77@pburton-laptop>
References: <20190624222844.26584-1-f4bug@amsat.org>
 <20190624222844.26584-11-f4bug@amsat.org>
 <4fab5459-f1a6-8ac9-2498-bda6a4732a1c@amsat.org>
In-Reply-To: <4fab5459-f1a6-8ac9-2498-bda6a4732a1c@amsat.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BY5PR16CA0005.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::18) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:18::12)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [12.94.197.246]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8f9ff55a-9203-475e-80d0-08d70af97d9c
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:MWHPR2201MB1549; 
x-ms-traffictypediagnostic: MWHPR2201MB1549:
x-microsoft-antispam-prvs: <MWHPR2201MB1549A2004BEDC34DD213158CC1C90@MWHPR2201MB1549.namprd22.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 01018CB5B3
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(7916004)(39840400004)(136003)(346002)(396003)(376002)(366004)(189003)(199004)(229853002)(52116002)(256004)(53936002)(7416002)(26005)(6512007)(3846002)(9686003)(6116002)(14444005)(8676002)(66446008)(66556008)(66946007)(66476007)(2906002)(76176011)(64756008)(6486002)(8936002)(476003)(68736007)(14454004)(11346002)(6436002)(7736002)(4326008)(186003)(305945005)(6916009)(6506007)(102836004)(81166006)(81156014)(6246003)(42882007)(386003)(478600001)(33716001)(446003)(44832011)(25786009)(486006)(66066001)(316002)(58126008)(54906003)(5660300002)(4744005)(99286004)(71190400001)(71200400001)(1076003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MWHPR2201MB1549;
 H:MWHPR2201MB1277.namprd22.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: lwQV+hfwNvGE6aMI8ZaM5ebLja0TCR+VaEbJ1oriOG2zzh8o8qCN3QNytygPyUPvucH/2btIcM5r8SPhGlgiKOhB4SI2C0f9UQTgOQEE0oPPvV7fk55LvY9qB3cdvXKoRX3x3KE4GWFCU816q2XH90in5gDkacJ80SoXVyIA9nFkgs/AGGVZFiQ4ppMNNsVOzTgZWKuUU7p4l0tsBy8rnNyyHQeeYijX3cWCncleKgnrB7ti0njltPe42SHhxSUgL16v0gRAN7KaqZZE4QgWzTul/bSjtiMGgDvaVKb+Kd7rUOYxz7+IxcpV0t14SXXQwhiwg4AFaVsjQoUyuT4a0G+caQFLi8tbbg7o/S3vgZOBNBSXTDFOaXn6Lp75ROGYBc1w1Qut60/IQwYAmCPuGJmG5oIPZNwFTqcbZgsDQfc=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <5E79C907D7D0164DA83D665DFF3D1187@namprd22.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f9ff55a-9203-475e-80d0-08d70af97d9c
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2019 20:58:16.8448 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pburton@wavecomp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1549
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.69.134
Subject: Re: [Qemu-devel] [RFC PATCH 10/10] hw/pci-host/gt64120: Clean the
 decoded address space
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Aleksandar Rikalo <arikalo@wavecomp.com>, James Hogan <jhogan@kernel.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
 =?iso-8859-1?Q?Herv=E9_Poussineau?= <hpoussin@reactos.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Philippe,

Sorry for the delay; I was away for a few weeks visiting family.

On Mon, Jul 01, 2019 at 08:06:21PM +0200, Philippe Mathieu-Daud=E9 wrote:
> The difference with the previous content is now we have
> two new holes:
>=20
> - 0x02000000-0x10000000
> - 0x14001000-0x1c000000
>=20
> Ralf/Paul/James, what should happen when a guest access these
> holes (hardware PoV, no QEMU)?

I don't have a Malta handy to check (they're mostly "retired" these
days & the vast majority of surviving ones use newer FPGA daughtercards
with the MSC01-style system controller anyway), but I believe writes
just get dropped & reads return zero. At least that's the way I recall
most accesses to unused address ranges working on Malta.

(Which is really annoying sometimes, and the newer Boston system gives
you a bus error in the equivalent scenario.)

Thanks,
    Paul

