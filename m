Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4841FC4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 15:54:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19692208C4
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 15:54:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="Tehl2KoZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19692208C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33560 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgtD6-0002t3-BF
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 11:54:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55920)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aaron@os.amperecomputing.com>) id 1hgsq3-0006vd-IT
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 11:31:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aaron@os.amperecomputing.com>) id 1hgsq1-0006uJ-If
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 11:30:59 -0400
Received: from mail-co1nam03on0720.outbound.protection.outlook.com
 ([2a01:111:f400:fe48::720]:6139
 helo=NAM03-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aaron@os.amperecomputing.com>)
 id 1hgspz-0006rr-E3
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 11:30:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=testarcselector01; d=microsoft.com; cv=none;
 b=eVZAXeVRpf6Nqu9AfrSJ8U77+s+GCwGv8PIqDP3zQk8bx8CY3TFgcwuMeXqBzygyjHtPyNSgmT7wo/YIDYuzMFuGfZZ26ZsLG3tMtO7A58IpM228peaebuKtI3mmMgv+Qtq0Fxg363Watp+zKbIUG1sGycZsIg1iwJZSDKayd1k=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=testarcselector01;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WotkyJAP371SUq8JaXS84XL34cD9F/v1Eq/efYzzIoA=;
 b=uRlMDDbIqhyTqbzIcfr+eWzG3nAww/9yODf8eHIOsy/malyGuuFwXAMjZ2YU8OHkSUiSeuceJu4fHQRNmKDqghjayAxLcNolBSW6XR/eWNf9skc3iOvf3/ikNjcqoa6dgGmcyOP7lOH6u1c4vesXzAiXA0OBnJ00K+1u7QHjqhg=
ARC-Authentication-Results: i=1; test.office365.com
 1;spf=none;dmarc=none;dkim=none;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WotkyJAP371SUq8JaXS84XL34cD9F/v1Eq/efYzzIoA=;
 b=Tehl2KoZtY00EueQ82SxmL+MDwetLCJltJJFD3lMLAhrxSqXciPLrCiWsFN+8zSin7sfGHnzcbu6KO9fG3VlGzcPxDBl5kV1ODkjbsdCBYhnMlPn3zCnEfugXcCxOs+ZUHiLsapnqWIbP4uPuWe+tNWMzcgBW1DLKMUP6e27pMA=
Received: from DM6PR01MB4825.prod.exchangelabs.com (20.177.218.222) by
 DM6PR01MB4316.prod.exchangelabs.com (20.176.106.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Fri, 28 Jun 2019 15:30:51 +0000
Received: from DM6PR01MB4825.prod.exchangelabs.com
 ([fe80::390e:9996:6dec:d60f]) by DM6PR01MB4825.prod.exchangelabs.com
 ([fe80::390e:9996:6dec:d60f%6]) with mapi id 15.20.2032.018; Fri, 28 Jun 2019
 15:30:51 +0000
To: =?iso-8859-1?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>
Thread-Topic: [Qemu-devel] [PATCH v3 19/50] tcg: let plugins instrument memory
 accesses
Thread-Index: AQHVIt11hLjmFwnAA0W4zaK1l+4xhaaxRysA
Date: Fri, 28 Jun 2019 15:30:51 +0000
Message-ID: <20190628153044.GB26345@quinoa.localdomain>
References: <20190614171200.21078-1-alex.bennee@linaro.org>
 <20190614171200.21078-20-alex.bennee@linaro.org>
In-Reply-To: <20190614171200.21078-20-alex.bennee@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CY4PR2201CA0039.namprd22.prod.outlook.com
 (2603:10b6:910:3e::28) To DM6PR01MB4825.prod.exchangelabs.com
 (2603:10b6:5:6b::30)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aaron@os.amperecomputing.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [108.169.132.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4e9e5629-1748-4203-946a-08d6fbdd9a3d
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DM6PR01MB4316; 
x-ms-traffictypediagnostic: DM6PR01MB4316:
x-microsoft-antispam-prvs: <DM6PR01MB4316A0E96BD7BDE25BA787D08AFC0@DM6PR01MB4316.prod.exchangelabs.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 00826B6158
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(366004)(136003)(39840400004)(396003)(376002)(346002)(189003)(199004)(6116002)(52116002)(66446008)(53936002)(54906003)(316002)(6512007)(9686003)(6486002)(2906002)(305945005)(25786009)(14454004)(486006)(73956011)(14444005)(446003)(476003)(5660300002)(102836004)(66574012)(64756008)(66946007)(71200400001)(71190400001)(4744005)(7736002)(6436002)(66476007)(26005)(186003)(256004)(6916009)(6506007)(33656002)(99286004)(76176011)(66556008)(1076003)(11346002)(6246003)(229853002)(8676002)(3846002)(81156014)(81166006)(386003)(4326008)(478600001)(68736007)(8936002)(86362001)(66066001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DM6PR01MB4316;
 H:DM6PR01MB4825.prod.exchangelabs.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:0; 
received-spf: None (protection.outlook.com: os.amperecomputing.com does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: vvAU1k2RnIQ7wfR2Q8HqIwNVgrbOGGd021mS+5a555rleC9ZeSt4e6x77pWJFd2PIWmJyFsj4EVU6OrvX3T7f4Nr5Siw2bKGL07C3jLjk74uZoxQIcgmtviynmSjVzCW4Gt4UNQyGIclw4tZwZstSVKNN8vS60vKQVafrLcUfJuyr5PeaDf0DZQWOZuaaTPu5dgdVcx16ZxBUBS2jlT2ACNPPOkj0N9Q6UV1vNM1M4TTTJCrvNlQ6Jdmq5R+/blywmQRrgk9TU9GQbtdB4lzkr4H1D58p1ELyISC1BnOF5wGu0p5mXxXBXulQ1BzeM3V9HN2P/a3v0Tm13VTEOyrYhTtlMya7C3wV1HDJg0VEmEBGpYGx4KtMwyN2r4ueEAVr6TlKrujUb7m+JdIMpE8w2fhg1hqvTKhUDjPJX4E4uE=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <07F2A4705F54C54BA9E6B1ED9A17D043@prod.exchangelabs.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e9e5629-1748-4203-946a-08d6fbdd9a3d
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2019 15:30:51.6303 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Aaron@os.amperecomputing.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR01MB4316
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe48::720
Subject: Re: [Qemu-devel] [PATCH v3 19/50] tcg: let plugins instrument
 memory accesses
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
From: Aaron Lindsay OS via Qemu-devel <qemu-devel@nongnu.org>
Reply-To: Aaron Lindsay OS <aaron@os.amperecomputing.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Emilio G. Cota" <cota@braap.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Jun 14 18:11, Alex Benn=E9e wrote:
> From: "Emilio G. Cota" <cota@braap.org>
>=20
> Here the trickiest feature is passing the host address to
> memory callbacks that request it. Perhaps it would be more
> appropriate to pass a "physical" address to plugins, but since
> in QEMU host addr ~=3D guest physical, I'm going with that for
> simplicity.

How much more difficult would it be to get the true physical address (on
the guest)?

This is important enough to me that I would be willing to help if
pointed in the right direction.

-Aaron

