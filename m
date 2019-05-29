Return-Path: <SRS0=DspQ=T5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D08FC04AB3
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 08:23:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C4D820665
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 08:23:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="fiQ9wlwe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C4D820665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wavecomp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49768 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVtsL-0002WM-6d
	for qemu-devel@archiver.kernel.org; Wed, 29 May 2019 04:23:57 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40240)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1hVtqp-0001O6-4S
	for qemu-devel@nongnu.org; Wed, 29 May 2019 04:22:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1hVtqo-0000iz-7r
	for qemu-devel@nongnu.org; Wed, 29 May 2019 04:22:23 -0400
Received: from mail-eopbgr740090.outbound.protection.outlook.com
	([40.107.74.90]:61520
	helo=NAM01-BN3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1hVtqn-0000iF-Vu
	for qemu-devel@nongnu.org; Wed, 29 May 2019 04:22:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=wavesemi.onmicrosoft.com; s=selector1-wavesemi-onmicrosoft-com;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=xuDupgo3l7tMk0mg9zmmye4mOxqET2Ji6aMQj2BAV58=;
	b=fiQ9wlwePJIDjz35rfePvzy345hbsPne3uOYUbDEGjdzaEza6piftbGoi6r6mBXdopcLXZuugBGddHbEQmVlw2l8Eq1RfRPxGd+kk+GYB+1Ckx7z/CwytctecHtficx3z+Q6up0izvv6l7wt8ixe4rCBcPDd3GpSUXFwOYv5EsY=
Received: from BN6PR2201MB1251.namprd22.prod.outlook.com (10.174.81.139) by
	BN6PR2201MB1315.namprd22.prod.outlook.com (10.174.80.9) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1922.16; Wed, 29 May 2019 08:22:18 +0000
Received: from BN6PR2201MB1251.namprd22.prod.outlook.com
	([fe80::854a:15e2:b5f:e2c8]) by
	BN6PR2201MB1251.namprd22.prod.outlook.com
	([fe80::854a:15e2:b5f:e2c8%8]) with mapi id 15.20.1922.021;
	Wed, 29 May 2019 08:22:18 +0000
From: Aleksandar Markovic <amarkovic@wavecomp.com>
To: =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>
Thread-Topic: Malta-related files in MAINTAINERS
Thread-Index: AQHVFfeR5EFnlOiftEqy3oXDxtUD/g==
Date: Wed, 29 May 2019 08:22:18 +0000
Message-ID: <BN6PR2201MB1251C914F948CFB53757492DC61F0@BN6PR2201MB1251.namprd22.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=amarkovic@wavecomp.com; 
x-originating-ip: [109.245.225.115]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6204a8f0-67a2-4823-fc1a-08d6e40ec3f5
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
	SRVR:BN6PR2201MB1315; 
x-ms-traffictypediagnostic: BN6PR2201MB1315:
x-microsoft-antispam-prvs: <BN6PR2201MB1315DFD0AED8F8A83DA231D0C61F0@BN6PR2201MB1315.namprd22.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-forefront-prvs: 0052308DC6
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(136003)(366004)(346002)(396003)(39850400004)(376002)(199004)(189003)(86362001)(486006)(476003)(3846002)(6116002)(66476007)(66556008)(66946007)(91956017)(6506007)(5660300002)(64756008)(9686003)(76116006)(53936002)(7696005)(102836004)(66446008)(2906002)(6436002)(73956011)(55016002)(3480700005)(186003)(26005)(8676002)(8936002)(316002)(81156014)(52536014)(66066001)(81166006)(7736002)(305945005)(74316002)(99286004)(71200400001)(256004)(68736007)(71190400001)(558084003)(33656002)(4326008)(478600001)(25786009)(14454004)(6916009);
	DIR:OUT; SFP:1102; SCL:1; SRVR:BN6PR2201MB1315;
	H:BN6PR2201MB1251.namprd22.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: wavecomp.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 9PIl7L2GoCxkLqOnNhLpN2ATt9jfpE79hHG/EabY0oNrN1qRUXVaBq6j+3BFou3lGRrNAj3gP8pXsAHERXMmLlbJHtyLlcdR1bRTDK4kpBYGbm1qciXeeB1F+uihSlh3V0XEAGkeAheG3ObGcc8IxZ1PUWcs4wJdyoR2hPvezx0dH70hqwysH6yA2bWBAM8aSf0r059W+voALAXwFssr0cwWuahaD/Tqoyt961XHfPcf9waPQ5VtxbG3tq3IYbj8zcUl9/MLIv0dBKuglMomrUcVMivvdBvY5V1DTzxyhmOtbABeezsFIBrvHnEIfwhgf76MpEXaowL67kqE+vIgoMyRdXqhRkek1KsjfG2AH/KlEfzho3/E+5Zix9QXCLgQBWreUtGx2X81maBH01yw+vb2x1g0HoKZNu9usP1RsAA=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wavecomp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6204a8f0-67a2-4823-fc1a-08d6e40ec3f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2019 08:22:18.5264 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: amarkovic@wavecomp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR2201MB1315
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.74.90
Subject: [Qemu-devel] Malta-related files in MAINTAINERS
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello, Philippe.

Currently, we have these two files in Malta MAINTAINERS section:
F: hw/mips/mips_malta.c
F: tests/acceptance/linux_ssh_mips_malta.py

Do we need to add more files, or other Malta-related files naturally belong=
 to some other sections, or are shared by many boards?

Yours, Aleksandae

