Return-Path: <SRS0=hY9S=T7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28958C04AB6
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 14:47:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAE6A26AE3
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 14:47:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="gI5nY+zQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAE6A26AE3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wavecomp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44701 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWio9-0007we-1a
	for qemu-devel@archiver.kernel.org; Fri, 31 May 2019 10:47:01 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48657)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arikalo@wavecomp.com>) id 1hWimW-0006xa-0z
	for qemu-devel@nongnu.org; Fri, 31 May 2019 10:45:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arikalo@wavecomp.com>) id 1hWimU-0002Ir-VB
	for qemu-devel@nongnu.org; Fri, 31 May 2019 10:45:19 -0400
Received: from mail-eopbgr680124.outbound.protection.outlook.com
	([40.107.68.124]:14976
	helo=NAM04-BN3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <arikalo@wavecomp.com>)
	id 1hWimU-0002IF-QL
	for qemu-devel@nongnu.org; Fri, 31 May 2019 10:45:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=wavesemi.onmicrosoft.com; s=selector1-wavesemi-onmicrosoft-com;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=KwGF/hLc2CAYRwMPrFg2LuKsqo2xYAAxa3Ozu5AdvR4=;
	b=gI5nY+zQ0saxYpbpYcAJUUaPAfiUmMR3WUFbkZ2JY+ZREXzkbHtz3Cb7egZTTUkSh32RhSv4V/AcsqMmdhz3v8qbtVY1PHuarVqnl9JEvtNwcBnldzWpLgOI2QpXQS4AcGspY/KMKfx78PvcoXOxbEKqnkhCSxiBA64+7gO6SR4=
Received: from DM5PR22MB1658.namprd22.prod.outlook.com (10.164.152.163) by
	DM5PR22MB0858.namprd22.prod.outlook.com (10.171.161.10) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1943.18; Fri, 31 May 2019 14:45:15 +0000
Received: from DM5PR22MB1658.namprd22.prod.outlook.com
	([fe80::1037:fb85:b06:6dba]) by DM5PR22MB1658.namprd22.prod.outlook.com
	([fe80::1037:fb85:b06:6dba%7]) with mapi id 15.20.1922.021;
	Fri, 31 May 2019 14:45:15 +0000
From: Aleksandar Rikalo <arikalo@wavecomp.com>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [PATCH 5/5] tests/tcg: target/mips: Add README for MSA tests
Thread-Index: AQHU9t8PfxQ8WVsxGUiRbghXzOdj/KaFkQY2
Date: Fri, 31 May 2019 14:45:15 +0000
Message-ID: <DM5PR22MB16585CA0B53656270F8E37ADD2190@DM5PR22MB1658.namprd22.prod.outlook.com>
References: <1555699081-24577-1-git-send-email-aleksandar.markovic@rt-rk.com>,
	<1555699081-24577-6-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1555699081-24577-6-git-send-email-aleksandar.markovic@rt-rk.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=arikalo@wavecomp.com; 
x-originating-ip: [82.117.201.26]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b9513a2b-208a-4a0a-3241-08d6e5d69820
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
	SRVR:DM5PR22MB0858; 
x-ms-traffictypediagnostic: DM5PR22MB0858:
x-microsoft-antispam-prvs: <DM5PR22MB08582D111AF5C84CB17D62A6D2190@DM5PR22MB0858.namprd22.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 00540983E2
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(376002)(346002)(39840400004)(136003)(366004)(396003)(189003)(199004)(8676002)(81166006)(2906002)(81156014)(66066001)(9686003)(99286004)(6506007)(53546011)(7696005)(74316002)(7736002)(55236004)(102836004)(76176011)(71200400001)(5660300002)(229853002)(76116006)(52536014)(86362001)(6436002)(6606003)(55016002)(71190400001)(91956017)(4744005)(54896002)(53936002)(256004)(66446008)(66476007)(66946007)(64756008)(66556008)(73956011)(6246003)(4326008)(107886003)(25786009)(316002)(19627405001)(26005)(68736007)(33656002)(186003)(486006)(2501003)(14454004)(478600001)(110136005)(54906003)(446003)(8936002)(11346002)(3846002)(6116002)(476003);
	DIR:OUT; SFP:1102; SCL:1; SRVR:DM5PR22MB0858;
	H:DM5PR22MB1658.namprd22.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: wavecomp.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: NG4XadDYnj5aPK1XGRSTLcyYBkBn4EpK0CEY5H8JYHUqJYF1YNPo5l5UW+zsxRa1vpZ//y2CHvK5qszK5Qk2h7EeEZ4HN+EXRtqH8M3pbhCkOGl3Fy6zB5sIe3CVOjCsdL/pbvE1Ib4sSM8x7SRyTCCcDtCQAfoVgO4QNsveIj3yWiXiBfb40KcbvdMxpzbB8ZA7GBBz9EtjZabDBd+JKWDOBmYvij5btftFQbAF+LDgEg6+EMtGFXnkvKAtbF4Bj9P7SehZ/HyoFoIdmSov/o8gpOZWz/nwV0FUFYthvPH7SmFYrn+fbQXLF3IJnNustlUDVtQcZK86DvdD/JReBlJw8iHsKMXoiuJWV9lV4RyixVcbyJRal8BvQkwCCLn2A9vlEx9jmPyPE39SOZgGLKbSuKGlwgAe1NzsF0qXg6I=
MIME-Version: 1.0
X-OriginatorOrg: wavecomp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9513a2b-208a-4a0a-3241-08d6e5d69820
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2019 14:45:15.5593 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: arikalo@wavecomp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR22MB0858
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.68.124
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH 5/5] tests/tcg: target/mips: Add README for
 MSA tests
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
Cc: Aleksandar Markovic <amarkovic@wavecomp.com>,
	"aurelien@aurel32.net" <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
> Sent: Friday, April 19, 2019 8:38 PM
> To: qemu-devel@nongnu.org
> Cc: aurelien@aurel32.net; Aleksandar Markovic; Aleksandar Rikalo
> Subject: [PATCH 5/5] tests/tcg: target/mips: Add README for MSA tests
>
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
>
> Add README for MSA tests. This is just to explain how to run tests even
> without Makefile. Makefile will be provided later on.
>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> ---

Besides README, until MSA TCG tests are integrated via Makefiles,
we should at least have a shell script that would enable developers
ro run the tests for the time being. Otherwise,

Reviewed-by: Aleksandar Rikalo <arikalo@wavecomp.com>

>  tests/tcg/mips/user/ase/msa/README | 639 +++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 639 insertions(+)
>  create mode 100644 tests/tcg/mips/user/ase/msa/README
>
