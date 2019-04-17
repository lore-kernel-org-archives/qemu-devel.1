Return-Path: <SRS0=PAXx=ST=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A7F6C282DA
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 20:23:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07F23206BA
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 20:23:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="K9j6w/vs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07F23206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wavecomp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59236 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGr5P-0004d2-Oc
	for qemu-devel@archiver.kernel.org; Wed, 17 Apr 2019 16:23:15 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49047)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1hGr4e-0004L4-Tl
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 16:22:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1hGr4e-0007uX-00
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 16:22:28 -0400
Received: from mail-eopbgr820109.outbound.protection.outlook.com
	([40.107.82.109]:6800
	helo=NAM01-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1hGr4d-0007rC-Gb
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 16:22:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=bHZKP0UbUMRFqzrrGlBefLYr2MSsl5Vm0pXo/ytbFN0=;
	b=K9j6w/vsty17fmD5ha4hKTy8W1xxNzKX6HSycNpDY9ZsC7rxiCHsouiCGhiyCa4lnyS4apvUKxbEtNYPmPDfk3gFMhMgwIwun+s3PTmHrX95hMBDsiN/ej7LiQd0bwkg2CIoWlpYw9shA/QB5dcjNtMfFX1AIm4I2TnaAQLI7FQ=
Received: from BN6PR2201MB1251.namprd22.prod.outlook.com (10.174.81.139) by
	BN6PR2201MB1540.namprd22.prod.outlook.com (10.174.89.146) with
	Microsoft SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1792.19; Wed, 17 Apr 2019 20:22:24 +0000
Received: from BN6PR2201MB1251.namprd22.prod.outlook.com
	([fe80::3c70:1ca4:2aa:9e81]) by
	BN6PR2201MB1251.namprd22.prod.outlook.com
	([fe80::3c70:1ca4:2aa:9e81%2]) with mapi id 15.20.1813.011;
	Wed, 17 Apr 2019 20:22:24 +0000
From: Aleksandar Markovic <amarkovic@wavecomp.com>
To: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>, "qemu-devel@nongnu.org"
	<qemu-devel@nongnu.org>
Thread-Topic: [PATCH] target/mips: Amend tests for MSA binary integer
	operations
Thread-Index: AQHU9Pya4W8sjyOEjUq6twmw2Q2Ub6ZAjgU6gAA8nEo=
Date: Wed, 17 Apr 2019 20:22:24 +0000
Message-ID:
 <BN6PR2201MB1251599D75CE44B174BD5116C6250@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <1555491867-5922-1-git-send-email-mateja.marjanovic@rt-rk.com>,
	<BN6PR2201MB1251516C13CAE873ADDA73DBC6250@BN6PR2201MB1251.namprd22.prod.outlook.com>
In-Reply-To: <BN6PR2201MB1251516C13CAE873ADDA73DBC6250@BN6PR2201MB1251.namprd22.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=amarkovic@wavecomp.com; 
x-originating-ip: [82.117.201.26]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7555e502-534d-4f61-b341-08d6c3726706
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(5600141)(711020)(4605104)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
	SRVR:BN6PR2201MB1540; 
x-ms-traffictypediagnostic: BN6PR2201MB1540:
x-microsoft-antispam-prvs: <BN6PR2201MB154015C6B859D807825D4EA9C6250@BN6PR2201MB1540.namprd22.prod.outlook.com>
x-forefront-prvs: 0010D93EFE
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(366004)(396003)(346002)(376002)(136003)(39850400004)(199004)(189003)(2940100002)(305945005)(476003)(229853002)(76176011)(105586002)(14454004)(53936002)(52536014)(2906002)(93156006)(55016002)(6116002)(3846002)(6436002)(66066001)(71200400001)(71190400001)(2501003)(7736002)(81166006)(8676002)(81156014)(68736007)(33656002)(8936002)(6246003)(107886003)(6506007)(86362001)(55236004)(102836004)(5660300002)(74316002)(14444005)(110136005)(99286004)(256004)(97736004)(446003)(54906003)(4326008)(26005)(486006)(9686003)(186003)(316002)(478600001)(25786009)(11346002)(106356001)(7696005);
	DIR:OUT; SFP:1102; SCL:1; SRVR:BN6PR2201MB1540;
	H:BN6PR2201MB1251.namprd22.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: wavecomp.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Cg75kin+6Q4wjEkh4WOedeLpTvZEloakhERxuhl0J4NT95FqQtXAKJ+ilMHw4BASfVGQbNUdKazTZP1HsPUlI8x0rm1dYcY1T/IPZ3BfIiSoWlJ9jEIgnOqOedYUcYylGlf09N9zP4S4seYW80D2IrB+aE0KmLUnm19eqvrtrYuGj1L2qBs02qSkAIAwCXWlSIcpwbASCQb1tPd//I1/oeynX4OgAtBmj+W8iQH9u4Yqr/rzPd+t0F7PGY3EA9DrBNu31W9Qio/3XobbWFRMvrw6kFJdGX8tKyHYHcsMQkLki6GPe8tgSISzXGDJe+ae+0iaADi5sgS27bxqSVhtNMCmL/aG1JYonoMWKyoJSRvjPrUKMnTPOFycYPPqVTTdzvNiXeIw9nw+C9V7oix1cbEd8TQpDEL7Tha2TZsAnmw=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wavecomp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7555e502-534d-4f61-b341-08d6c3726706
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2019 20:22:24.0793 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR2201MB1540
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.82.109
Subject: Re: [Qemu-devel] [PATCH] target/mips: Amend tests for MSA binary
 integer operations
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Aleksandar Rikalo <arikalo@wavecomp.com>,
	"aurelien@aurel32.net" <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190417202224.qCHTlBoO45GtQs5PfCx3KFk2lBVp4Clp57CR3Tl548M@z>

> From: Aleksandar Markovic
> Subject: Re: [PATCH] target/mips: Amend tests for MSA binary integer oper=
ations
>=20
> > From: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
> > Subject: [PATCH] target/mips: Amend tests for MSA binary integer operat=
ions
> >
> > Amend tests for certain MSA binary integer instructions
> > (for example DIV_S.B) by appending two missing test cases
> > to complete standard battery of 80 test cases for each
> > such instruction. Expected values were pulled from the
> > results of the MIPS64r6 machine that executed those
> > instruction, and QEMU emulation should produce the same
> > results.
> >
> > Signed-off-by: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
> > ---
>=20
> I'm afraid your patch doesn't apply to the tip of the source tree:

Unfortunately, Mateja, even after resolving patch application conflicts,
the code doesn't build.

For example, wrappers for many MSA instructions are missing, and
there are other problems too.

The patch needs a major amending and refactoring, which I will do
tomorrow, or in next few days, so that you can focus on your other
remaining tasks (for example, explaining "active_fpu" role from
another series, and big endian host MSA test failures).

The good thing is that we will eventually expand test coverage.

Thanks,
Aleksandar=

