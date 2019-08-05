Return-Path: <SRS0=vzij=WB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01063C433FF
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 18:56:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BED2E2086D
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 18:56:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavecomp.com header.i=@wavecomp.com header.b="HDrxEcR/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BED2E2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wavecomp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56598 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1huiA1-0001Xu-19
	for qemu-devel@archiver.kernel.org; Mon, 05 Aug 2019 14:56:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42179)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <amarkovic@wavecomp.com>) id 1hui9R-000199-5b
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 14:56:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <amarkovic@wavecomp.com>) id 1hui9Q-000192-5U
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 14:56:09 -0400
Received: from mail-eopbgr810131.outbound.protection.outlook.com
 ([40.107.81.131]:30400 helo=NAM01-BY2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
 id 1hui9P-00016i-KR
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 14:56:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LQjiIc8a2lJZmV5roG6KAmgDec9fPmE8rpvTaMlLUG5Gb5NdTFK2v+XRRTT85XzM/gM2vJvjHNwWxSLBPwkSTPaHUsrq6wm5A1KI2l4kRcQY3PAiPnqRpdVH1x5MjLsmB8XQqyEKCRAtUdwZXJCW3/9SFOmMySvSZ+mQRDMitA1YyB0x+bT5BT+w+vulpx+wuP5z5vm0s00bzv0mVN5MJI0NDTi6/lvb7U2vBdZQXxgsiCedAzLFeAjfEOE0UOZ2ZoEW+RTMii5rOFXInnoF0fQfJieGkw+Uk1RORbF9+fHXXMOjXzIirO9vWFZecJ4l1ks0VGdkHHQokrES31EjZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OcVCrqQyKsEIqNXf+E274/jAeynmwrq/dJ7AxU40nSk=;
 b=KAbe18sririLRJAZRV7ms33PpN42lMLFAw9RDA27+Dup8EJrpkp3Dt7TsRnWip76MTTgDOQ3mhNdunJI81ZN9Udt6AqOsGb6zS2g/JOz5wNZLbhgNh+JiglD8Uzdqq96L5nufnPh+tX9F81qgud4DKXvijxH+uqFuSdOLcGfiMWBKAqE4Ev2KOpfnKGE9PjE8eC1jFkCz/pOhIs6pWD5yzQJv2LHsm2hOzeuT7V0rb+vWf6aHvXN3VMEOSJZ0J9kuN3gmPWlkyhGec1jEX77g7oCQVs61PLwlXMm9GMzgOooRYX5wbMQnV/EpppUMmymW6PFd50Bq8R9CD1RlLb0lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=wavecomp.com;dmarc=pass action=none
 header.from=wavecomp.com;dkim=pass header.d=wavecomp.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wavecomp.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OcVCrqQyKsEIqNXf+E274/jAeynmwrq/dJ7AxU40nSk=;
 b=HDrxEcR/+LSRzcu6IoiHsFdF5Y1UdjBzQ16lTXeD2gcj38IrqSfDGpuS4dhOgeGKTvlmZBnm2oKSLuCTf4ljuPZLwjCv481JklcUJWVjH0C+nUoIELHEQzUhuDyZS2dm+oK+S3G0padxkwosyxUJbzYlxZY2S0FnW0IhYgvrz0U=
Received: from BN6PR2201MB1251.namprd22.prod.outlook.com (10.174.81.139) by
 BN6PR2201MB1556.namprd22.prod.outlook.com (10.174.82.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.17; Mon, 5 Aug 2019 18:56:02 +0000
Received: from BN6PR2201MB1251.namprd22.prod.outlook.com
 ([fe80::509b:7797:a22a:f2bb]) by BN6PR2201MB1251.namprd22.prod.outlook.com
 ([fe80::509b:7797:a22a:f2bb%3]) with mapi id 15.20.2136.018; Mon, 5 Aug 2019
 18:56:02 +0000
From: Aleksandar Markovic <amarkovic@wavecomp.com>
To: =?iso-8859-1?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>, Peter Maydell
 <peter.maydell@linaro.org>
Thread-Topic: [Qemu-devel] [BUG] gcov support appears to be broken - solved?
Thread-Index: AQHVS79tjXWwDlUpEUios0kBKe2HrQ==
Date: Mon, 5 Aug 2019 18:56:02 +0000
Message-ID: <BN6PR2201MB1251F3D9E077A24F1E6106B6C6DA0@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <BN6PR2201MB1251F757F3129C433E540F9AC6DA0@BN6PR2201MB1251.namprd22.prod.outlook.com>
 <CAFEAcA8NE=hy4a-WuDuKeysi3KOjy8=ybHbLKkvzPM=ELvXBnQ@mail.gmail.com>,
 <871rxzk8ho.fsf@linaro.org>,
 <BN6PR2201MB12511114EB865D69305CC9D9C6DA0@BN6PR2201MB1251.namprd22.prod.outlook.com>,
 <BN6PR2201MB12512C8AF64BD24CFFA9BCCFC6DA0@BN6PR2201MB1251.namprd22.prod.outlook.com>
In-Reply-To: <BN6PR2201MB12512C8AF64BD24CFFA9BCCFC6DA0@BN6PR2201MB1251.namprd22.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=amarkovic@wavecomp.com; 
x-originating-ip: [82.117.201.26]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d14842b1-af90-44e7-c30b-08d719d68ff4
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:BN6PR2201MB1556; 
x-ms-traffictypediagnostic: BN6PR2201MB1556:
x-microsoft-antispam-prvs: <BN6PR2201MB1556C7EB2FC33CB01F1BEA90C6DA0@BN6PR2201MB1556.namprd22.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 01208B1E18
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(136003)(366004)(346002)(396003)(39840400004)(199004)(189003)(316002)(81156014)(81166006)(7736002)(6116002)(305945005)(74316002)(66574012)(2906002)(110136005)(3846002)(486006)(2940100002)(55016002)(71190400001)(64756008)(76116006)(86362001)(66946007)(6436002)(71200400001)(66556008)(8676002)(8936002)(53936002)(476003)(229853002)(91956017)(66476007)(446003)(66446008)(11346002)(7696005)(9686003)(26005)(186003)(4326008)(99286004)(33656002)(6506007)(102836004)(55236004)(52536014)(68736007)(76176011)(25786009)(14454004)(66066001)(478600001)(5660300002)(6246003)(256004)(14444005);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BN6PR2201MB1556;
 H:BN6PR2201MB1251.namprd22.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: r0lVGECDWG+KjFiwesb5fUy6UprmqLQUTZkPQbMqzHGoTSOIoBcHT+pM2cnCZ6qCLHrsP7qdfa+2l8P0ZRuPRscVw9h5XlaYNCCatRR0ujQUWoQU/oovNUcuMb1ZLR4xpWqk8DymtU9Js6ERrki4Xow/KuIexZHvfta45TnsCY/jCi5QtOQQ6tzp0gU0WVkOy1EIB2xsiOxltGAYimkoQzi/WM3yvSwQJOCfdxqhgXgGW0Zm7BYcWXjqzBOkigRcDg+Ai4xKXOf4s8Pj2niVV3zRcmNTrmTMVNlDqb2IF2uHTKDBmm+2lvQ3gHzsoxCts0J7TZlRfx+DYUIuyPftRImGuAHWMl1xzuqxQerLC9bN1ejgw4YjCjUtwIyECT7dMTTTC33ITdgk3s5VTUwzr9fWvWHIXDtf0EIw2Fs65w0=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wavecomp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d14842b1-af90-44e7-c30b-08d719d68ff4
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2019 18:56:02.4233 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: amarkovic@wavecomp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR2201MB1556
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.81.131
Subject: Re: [Qemu-devel] [BUG] gcov support appears to be broken - solved?
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

=0A=
>> #./configure --enable-gcov=0A=
>> #make=0A=
>> #make check=0A=
>> #make coverage-report=0A=
>>=0A=
>> It seems that first three commands execute as expected. (For example,=0A=
>> there are plenty of files generated by "make check" that would've not=0A=
>> been generated if "enable-gcov" hadn't been chosen.) However, the=0A=
>> last command complains about some missing files related to FP=0A=
=0A=
> So your failure mode is no report is generated at all? It's working for=
=0A=
> me here.=0A=
=0A=
Alex, here is the thing:=0A=
=0A=
Seeing that my gcovr is relatively old (2014) 3.2 version, I upgraded it fr=
om git repo to the most recent 4.1 (actually, to a dev version, from the ve=
ry tip of the tree), and "make coverage-report" started generating coverage=
 reports. It did emit some error messages (totally different than previous)=
, but still it did not stop like it used to do with gcovr 3.2.=0A=
=0A=
Perhaps you would want to add some gcov/gcovr minimal version info in our d=
ocs. (or at least a statement "this was tested with such and such gcc, gcov=
 and gcovr", etc.?)=0A=
=0A=
Coverage report looked fine at first glance, but it a kind of disappointed =
me when I digged deeper into its content - for example, it shows very low c=
overage for our FP code (softfloat), while, in fact, we know that "make che=
ck" contains detailed tests on FP functionalities. But this is most likely =
a separate problem of a very different nature, perhaps the issue of separat=
e git repo for FP tests (testfloat) that our FP tests use as a mid-layer.=
=0A=
=0A=
I'll try how everything works with my test examples, and will let you know.=
=0A=
=0A=
Your help is greatly appreciated,=0A=
Aleksandar=0A=
=0A=
Fond regards,=0A=
Aleksandar=0A=
=0A=
=0A=
> Alex Benn=E9e=0A=

