Return-Path: <SRS0=3XOk=S2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BDC5C10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 13:23:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0646D218D2
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 13:23:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="fJF5rH5N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0646D218D2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wavecomp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41694 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJHs2-0006BP-3w
	for qemu-devel@archiver.kernel.org; Wed, 24 Apr 2019 09:23:30 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52586)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1hJHnP-0002I7-5A
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 09:18:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1hJHen-0003jZ-K0
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 09:09:50 -0400
Received: from mail-eopbgr700107.outbound.protection.outlook.com
	([40.107.70.107]:4245
	helo=NAM04-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1hJHYw-0005p0-Lt
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 09:03:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=Co0uvXE9ZaL+GtY6AQQArvxQjv8KxZlpPDY2An+PlIY=;
	b=fJF5rH5N0717ek0x5oVYLI3aMq8rVLVWWFeJehTuh3xQlI89jA7cPgdzaevUckYjIlP8JIJgoml16N384txldnC75ZTKzeR8Z1eERsZo/NLpC2rigYAbhQ/TmNg/nMehnB7mTKMkBA5HyZniFqeDrhOxg9ZUvCbsO+rJEYv90Fs=
Received: from BN6PR2201MB1251.namprd22.prod.outlook.com (10.174.81.139) by
	BN6PR2201MB1091.namprd22.prod.outlook.com (10.174.90.158) with
	Microsoft SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1835.12; Wed, 24 Apr 2019 13:03:44 +0000
Received: from BN6PR2201MB1251.namprd22.prod.outlook.com
	([fe80::854a:15e2:b5f:e2c8]) by
	BN6PR2201MB1251.namprd22.prod.outlook.com
	([fe80::854a:15e2:b5f:e2c8%8]) with mapi id 15.20.1835.010;
	Wed, 24 Apr 2019 13:03:44 +0000
From: Aleksandar Markovic <amarkovic@wavecomp.com>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "jcmvbkbc@gmail.com"
	<jcmvbkbc@gmail.com>
Thread-Topic: [PATCH v2 1/5] linux-user: Fix support for the SIOCATMARK and
	SIOCGPGRP ioctls for eXtensa
Thread-Index: AQHU+p1Y/NJ0jKECQUO0ttCBBe2dtaZLRbBH
Date: Wed, 24 Apr 2019 13:03:43 +0000
Message-ID:
 <BN6PR2201MB1251B9F471655E8E079E83E2C63C0@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <1556110623-655-1-git-send-email-aleksandar.markovic@rt-rk.com>,
	<1556110623-655-2-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1556110623-655-2-git-send-email-aleksandar.markovic@rt-rk.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=amarkovic@wavecomp.com; 
x-originating-ip: [82.117.201.26]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 02f0e5ea-ee71-4716-6f22-08d6c8b547f7
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);
	SRVR:BN6PR2201MB1091; 
x-ms-traffictypediagnostic: BN6PR2201MB1091:
x-microsoft-antispam-prvs: <BN6PR2201MB1091FE140B0049875A9F3C2EC63C0@BN6PR2201MB1091.namprd22.prod.outlook.com>
x-forefront-prvs: 00179089FD
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(366004)(39850400004)(346002)(136003)(396003)(376002)(199004)(189003)(81166006)(6246003)(53936002)(8676002)(81156014)(8936002)(25786009)(14454004)(4326008)(478600001)(486006)(305945005)(256004)(74316002)(4744005)(7736002)(55016002)(2501003)(9686003)(476003)(66446008)(7696005)(68736007)(229853002)(73956011)(66556008)(64756008)(76116006)(66476007)(66946007)(6436002)(55236004)(86362001)(102836004)(97736004)(26005)(2201001)(6506007)(99286004)(71200400001)(71190400001)(66066001)(6116002)(3846002)(186003)(33656002)(5660300002)(2906002)(52536014)(110136005)(11346002)(54906003)(316002)(446003)(76176011)(91956017);
	DIR:OUT; SFP:1102; SCL:1; SRVR:BN6PR2201MB1091;
	H:BN6PR2201MB1251.namprd22.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: wavecomp.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: rb6NJ7fCRe7QtVjQVap/Xv7wTP8TaajGPugTKw1SrK3eN9ptbCNeEwDS5BNQSuvUNG1eWQpw8bZBwIy2clRmfSCZDlpzukwaRL4naRfnQvtfzpjRbdu+W1cjsmGnFkronwfqlDZkkWBeZZHw5d5W0RfXgvS++S6opM8mC9xCMd+nTFi4Ta0lzBuGI55MrYlNyOziRkwTn+m8EO+vGsNyOXG4nC8xn4cs2qhbHCxpi0OfXijA0jQXwa0b49xe7gOYxd9UfaJ7zMYt6eskzVTKU/E2w32EecURapokvByZCqeCsTzOD/saclN5ieuymW+kE4S15wM72Hn9jXksfXuBlv7likamDqBnvP88G/WzpVvVUiwPit1IwTwmrjulqPZaIxCVIsiizGcsoXxNEQ1cCvb03AmCK81mBzhi8VQURcU=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wavecomp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02f0e5ea-ee71-4716-6f22-08d6c8b547f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2019 13:03:43.9356 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR2201MB1091
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.70.107
Subject: Re: [Qemu-devel] [PATCH v2 1/5] linux-user: Fix support for the
 SIOCATMARK and SIOCGPGRP ioctls for eXtensa
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
Cc: "lvivier@redhat.com" <lvivier@redhat.com>,
	"thuth@redhat.com" <thuth@redhat.com>,
	Aleksandar Rikalo <arikalo@wavecomp.com>,
	"daniel.santos@pobox.com" <daniel.santos@pobox.com>,
	"philmd@redhat.com" <philmd@redhat.com>,
	"aurelien@aurel32.net" <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190424130343.F048IvUGyWmQvIOCl7Q1LXyAahiro9IdMfoj55je49o@z>

> From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
> Subject: [PATCH v2 1/5] linux-user: Fix support for the SIOCATMARK and SI=
OCGPGRP ioctls for eXtensa
>
> Fix support for the SIOCATMARK and SIOCGPGRP ioctls for eXtensa by
> correcting corresponding macro definition.

Hello, Xtensa folks!

This patch was devised while looking at some MIPS scenarios, but, in fact,
it affects Xtensa platform only (found by inspecting relevant Linux kernel
headers).

Could someone form Xtensa Ack ot Not-Ack this patch?

Sincerely, Aleksandar=

