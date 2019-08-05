Return-Path: <SRS0=vzij=WB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCC74C0650F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 19:32:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8497820C01
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 19:32:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavecomp.com header.i=@wavecomp.com header.b="htggfnIY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8497820C01
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wavecomp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56722 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1huiia-0001Bh-Pt
	for qemu-devel@archiver.kernel.org; Mon, 05 Aug 2019 15:32:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48902)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <amarkovic@wavecomp.com>) id 1huii5-0000me-1y
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 15:31:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <amarkovic@wavecomp.com>) id 1huii4-0003bh-0R
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 15:31:57 -0400
Received: from mail-eopbgr700105.outbound.protection.outlook.com
 ([40.107.70.105]:51136 helo=NAM04-SN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
 id 1huii2-0003b2-Uv
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 15:31:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uwh8yFK6ZswbbF0mRhQniTJsV/aEP1fxZroxxASUUsoANbJByQoGblvNoy8x/UQQo1ttMAL2qaP/7XxqYUd1s6KdSG7PRo9gsb6QwKkCQ+1AFZzNG9bSr8Z2qsI+eF4+6L2IXjnRxWAYrGm65luhLlLBRxTsshVN8av7AdTN/tjQosqwtijNDsK3jmSxi8J5eJEykmZX4NgnwHg9o3L1cPiZizF6pp4KFdVfG8fHKxFx622FLl2VQo6WS4yOzb/90l4OQo+ZLy7AtMRUlO5VRJG/secRmAytG2wv8DWksAwwkjg4H9DZ/zQcjqR+c3z1FUnJBFBUGvgSA0I1twqnoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pwTwiK83vVOWcWOw2NNmTRKjCb7GyoiPfXy//ItatFg=;
 b=QpmXl29Cz6Zt3HfHhhiRpnilGKRKUTzKhKVO+aejHRgfTtblKZ4pWh3oDbyBx6NuvPm/2FBYLsgOZwPa9s0hcuZyhTUZY6E0ow37t1Phuzr4875HCfUYziXrD719UnJEYDpMYrFOt7cLRLg48zoE/HjQUh44co+8/VxKKg5KQv0I+Eql+nPTwjhCa10JpVu1iedhfjcJNcjZOgbaXGrIbzw/e3cyi1vZFy28w1TlOPXLwU2cKsfwE0SwICK3+jjmUgQ6iGpwG3kxSVJIaJNX0fg6sNPK1YHP28DwKWYSnOEeJS3XMySYDvP0/VmDtJgyfCAIbTjALtuTnY49GuCdkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=wavecomp.com;dmarc=pass action=none
 header.from=wavecomp.com;dkim=pass header.d=wavecomp.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wavecomp.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pwTwiK83vVOWcWOw2NNmTRKjCb7GyoiPfXy//ItatFg=;
 b=htggfnIYAaFhwxHS9aG034sqD5PxO3yROAFuHSEGq+FtGSOoGzDYh2XEPZ7mZdqK5hCTbCDna6fv3FDJ/1FBQdik3cW/Ggtk7nwJgayuG1OvrEq07ESuVnPitrY89D1DXH5+xYBMcjYW5AUhTghDv1qh7vLNMFcKICrEOmNpfx8=
Received: from BN6PR2201MB1251.namprd22.prod.outlook.com (10.174.81.139) by
 BN6PR2201MB1442.namprd22.prod.outlook.com (10.174.91.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.17; Mon, 5 Aug 2019 19:31:51 +0000
Received: from BN6PR2201MB1251.namprd22.prod.outlook.com
 ([fe80::509b:7797:a22a:f2bb]) by BN6PR2201MB1251.namprd22.prod.outlook.com
 ([fe80::509b:7797:a22a:f2bb%3]) with mapi id 15.20.2136.018; Mon, 5 Aug 2019
 19:31:51 +0000
From: Aleksandar Markovic <amarkovic@wavecomp.com>
To: =?iso-8859-1?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>
Thread-Topic: [Qemu-devel] [BUG] gcov support appears to be broken - solved?
Thread-Index: AQHVS8RuV7fvwvKXI0mHpPLby5HUJA==
Date: Mon, 5 Aug 2019 19:31:50 +0000
Message-ID: <BN6PR2201MB1251B4D1780F2ECEBEEE2599C6DA0@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <BN6PR2201MB1251F757F3129C433E540F9AC6DA0@BN6PR2201MB1251.namprd22.prod.outlook.com>
 <CAFEAcA8NE=hy4a-WuDuKeysi3KOjy8=ybHbLKkvzPM=ELvXBnQ@mail.gmail.com>
 <BN6PR2201MB12512C8AF64BD24CFFA9BCCFC6DA0@BN6PR2201MB1251.namprd22.prod.outlook.com>
 <BN6PR2201MB1251F3D9E077A24F1E6106B6C6DA0@BN6PR2201MB1251.namprd22.prod.outlook.com>,
 <87y307ifqv.fsf@linaro.org>
In-Reply-To: <87y307ifqv.fsf@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=amarkovic@wavecomp.com; 
x-originating-ip: [82.117.201.26]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ce23601b-9268-4b61-71a5-08d719db90b5
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:BN6PR2201MB1442; 
x-ms-traffictypediagnostic: BN6PR2201MB1442:
x-microsoft-antispam-prvs: <BN6PR2201MB1442EBED37BA38A8C94B33FCC6DA0@BN6PR2201MB1442.namprd22.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 01208B1E18
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39840400004)(366004)(136003)(376002)(346002)(396003)(199004)(189003)(66446008)(68736007)(229853002)(478600001)(6246003)(53936002)(25786009)(2906002)(66476007)(64756008)(14454004)(6436002)(4326008)(9686003)(55016002)(33656002)(66066001)(476003)(11346002)(6916009)(486006)(66946007)(446003)(91956017)(76116006)(76176011)(66556008)(305945005)(7736002)(316002)(54906003)(74316002)(5660300002)(99286004)(6506007)(55236004)(26005)(8676002)(186003)(81166006)(81156014)(8936002)(102836004)(7696005)(86362001)(6116002)(3846002)(66574012)(52536014)(4744005)(71190400001)(71200400001)(256004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BN6PR2201MB1442;
 H:BN6PR2201MB1251.namprd22.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: P9nXDO/xgXASjMbYxuxKD1uc1YVbkasAVA4fYzYTfZndf1QVeO5C2pcUaF922+O3VdAi7alrAPg3ahkd/do4/Ophkik4K1gY+IM/AYIFcJzmm5dZjQarLkgJhhfkzF3MQbqaqmx48QfPle1sP5rkZYfyoUWEfzWdrmQ+MpemRTDm8+yMYrNfkW5okgSBi5QxTmHjl7JY9X9CvoUY1W6wBVQo77Ilf1wBK4e4AHQpxbiKuj3DEidYahcfqSouI/nEKIBcEnwBoaYHxte2b1nTxOLWJAfXYsl3EiV3bnqBsqi/CZjEbMwGNdok56dEYkK3g1t3dpk1OK0OrsNU8e1buQhlvAA4VCq71TKsVriDDijf3FdZXgKciMvgdH47Ss8xD1xoxgWQVrihnJoX9WrKXu2/n+NBGm8qlkab4QOTj2o=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wavecomp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce23601b-9268-4b61-71a5-08d719db90b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2019 19:31:51.0327 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: amarkovic@wavecomp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR2201MB1442
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.70.105
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> > it shows very low coverage for our FP code (softfloat), while, in=0A=
> > fact, we know that "make check" contains detailed tests on FP=0A=
> > functionalities. But this is most likely a separate problem of a very=
=0A=
> > different nature, perhaps the issue of separate git repo for FP tests=
=0A=
> > (testfloat) that our FP tests use as a mid-layer.=0A=
> =0A=
> I get:=0A=
> =0A=
> 68.6 %  2593 / 3782     62.2 %  1690 / 2718=0A=
> =0A=
=0A=
I would expect that kind of result too.=0A=
=0A=
However, I get:=0A=
=0A=
File: 	fpu/softfloat.c 		Lines: 	8 	3334 	0.2 %=0A=
Date: 	2019-08-05 19:56:58 		Branches: 	3 	2376 	0.1 %=0A=
=0A=
:(=0A=
=0A=
OK, I'll try to figure that out, and most likely I could live with it if it=
 is an isolated problem.=0A=
=0A=
Thank you for your assistance in this matter,=0A=
Aleksandar=0A=
=0A=
> Which is not bad considering we don't exercise the 80 and 128 bit=0A=
> softfloat code at all (which is not shared by the re-factored 16/32/64=0A=
> bit code).=0A=
> =0A=
> Alex Benn=E9e=0A=

