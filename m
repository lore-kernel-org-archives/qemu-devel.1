Return-Path: <SRS0=vrBk=VF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E9F2C606CA
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 19:39:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28E75217D6
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 19:39:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="bNiBmVWv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28E75217D6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wavecomp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44312 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkZUB-0002bh-85
	for qemu-devel@archiver.kernel.org; Mon, 08 Jul 2019 15:39:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39416)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <amarkovic@wavecomp.com>) id 1hkZTe-0002AN-No
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 15:39:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <amarkovic@wavecomp.com>) id 1hkZTd-0004gw-M5
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 15:39:06 -0400
Received: from mail-eopbgr690106.outbound.protection.outlook.com
 ([40.107.69.106]:14311 helo=NAM04-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
 id 1hkZTd-0004gi-B4
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 15:39:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavesemi-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4pKNt9UE21vJIkh8aGlnng8mItXEa7Q43F+PXKwLpBg=;
 b=bNiBmVWv5o2ew3wuP2oPixb/HK/XMPQhxzgAanv9V7I5Le5sm0hhV+3YyWo9fZfSCRHbRNLHN7oC4Yhm4hfMaSS1sV0h5bqaJh9thK3PCrR+wKqwDdRqfqNU+kdtAw0LU1AztZormUEm8JmIwKNg4BUmN6mqo3MxhnQSa+0Rs/w=
Received: from BN6PR2201MB1251.namprd22.prod.outlook.com (10.174.81.139) by
 BN6PR2201MB1730.namprd22.prod.outlook.com (10.161.152.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.19; Mon, 8 Jul 2019 19:39:00 +0000
Received: from BN6PR2201MB1251.namprd22.prod.outlook.com
 ([fe80::509b:7797:a22a:f2bb]) by BN6PR2201MB1251.namprd22.prod.outlook.com
 ([fe80::509b:7797:a22a:f2bb%3]) with mapi id 15.20.2052.020; Mon, 8 Jul 2019
 19:39:00 +0000
From: Aleksandar Markovic <amarkovic@wavecomp.com>
To: Stefan Weil <sw@weilnetz.de>, Aleksandar Markovic
 <aleksandar.m.mail@gmail.com>, "Daniel P. Berrange" <berrange@redhat.com>
Thread-Topic: [Qemu-devel] Handling of fall through code (was: [PATCH v8
 04/87] target/mips: Mark switch fallthroughs with interpretable comments
Thread-Index: AQHVNWUdmanK06Ai10ycVAoxonexAqbAn8qAgAB8TaI=
Date: Mon, 8 Jul 2019 19:39:00 +0000
Message-ID: <BN6PR2201MB12519E6C72689FF70B5CA3E4C6F60@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <1534182832-554-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1534182832-554-5-git-send-email-aleksandar.markovic@rt-rk.com>
 <4da49ffe-902f-2cf2-8a21-2bbd511b17a4@weilnetz.de>
 <CAL1e-=jE8X1ODnA0aSXe5OCqJzYA0J47h5b6=H_UivPP11zSQA@mail.gmail.com>,
 <591d71a5-5b10-ab22-4751-01da8613d84c@weilnetz.de>
In-Reply-To: <591d71a5-5b10-ab22-4751-01da8613d84c@weilnetz.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=amarkovic@wavecomp.com; 
x-originating-ip: [82.117.201.26]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 417b1ec7-498b-4b20-b7e6-08d703dbed0e
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:BN6PR2201MB1730; 
x-ms-traffictypediagnostic: BN6PR2201MB1730:
x-microsoft-antispam-prvs: <BN6PR2201MB17303E3858D4EEC84ECE5BF6C6F60@BN6PR2201MB1730.namprd22.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:328;
x-forefront-prvs: 00922518D8
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(376002)(136003)(366004)(39840400004)(396003)(189003)(199004)(25786009)(5660300002)(68736007)(3846002)(66476007)(6116002)(478600001)(6436002)(446003)(66556008)(229853002)(11346002)(7416002)(66446008)(64756008)(6246003)(73956011)(76116006)(110136005)(316002)(2906002)(54906003)(14454004)(4326008)(52536014)(476003)(33656002)(66946007)(486006)(14444005)(74316002)(256004)(26005)(8676002)(81156014)(8936002)(71200400001)(71190400001)(76176011)(66066001)(102836004)(7736002)(7696005)(6506007)(99286004)(305945005)(53936002)(86362001)(55236004)(9686003)(55016002)(186003)(81166006);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BN6PR2201MB1730;
 H:BN6PR2201MB1251.namprd22.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 6TRf5ouCYjklj+T166PNO5Nofv8veNkcsPF4Twr1S/mgZxxoDnzz5VAAaMID2IGr65CNLt7yiz4/eii1z+m7KshLXVo3FVl4wbkp2lGS3mOqwqUoTj+SIPFJHOEV9RoZDuGJLa6XH49H1Il63HIvOinrl0KoeyA9Yl7EN4MqNnw06VG3URR7OTzr/Ll6IPQ2WkeFuNkDMkl4QiqeIxMDPUCmuJ+/Lh8OY26JxBYC9D4pl+Pp+4B0S8lzzpxqTdlaHgFkI99AWOut7W2exWzNxunfdtn2AT4EIwsKeg1Y+WbUI9I6mEHwXT11yP4Sy7UhiRKwPv5g/M+cfq+Yw4WVCG24bsiH6IxxVA/uMl/LJb1oh6jtdlFuapKQNp3linZnx53ds2VfcDeW4gHXRzDN2FiGByr2REsTFVp9QDILOpo=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wavecomp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 417b1ec7-498b-4b20-b7e6-08d703dbed0e
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2019 19:39:00.2462 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: amarkovic@wavecomp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR2201MB1730
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.69.106
Subject: Re: [Qemu-devel] Handling of fall through code (was: [PATCH v8
 04/87] target/mips: Mark switch fallthroughs with interpretable comments
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
Cc: Paul Burton <pburton@wavecomp.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "riku.voipio@iki.fi" <riku.voipio@iki.fi>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "laurent@vivier.eu" <laurent@vivier.eu>,
 Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
 "philippe.mathieu.daude@gmail.com" <philippe.mathieu.daude@gmail.com>,
 Petar Jovanovic <pjovanovic@wavecomp.com>,
 "aurelien@aurel32.net" <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> ...this is the list of warnings for target/mips/translate.c:=0A=
=0A=
> /home/debian/src/github/qemu/qemu/target/mips/translate.c:10047:13: warni=
ng: this statement may fall through [-Wimplicit-fallthrough=3D]=0A=
> /home/debian/src/github/qemu/qemu/target/mips/translate.c:10056:13: warni=
ng: this statement may fall through [-Wimplicit-fallthrough=3D]=0A=
> /home/debian/src/github/qemu/qemu/target/mips/translate.c:20138:13: warni=
ng: this statement may fall through [-Wimplicit-fallthrough=3D]=0A=
> /home/debian/src/github/qemu/qemu/target/mips/translate.c:20144:13: warni=
ng: this statement may fall through [-Wimplicit-fallthrough=3D]=0A=
> /home/debian/src/github/qemu/qemu/target/mips/translate.c:6739:9: warning=
: this statement may fall through [-Wimplicit-fallthrough=3D]=0A=
> /home/debian/src/github/qemu/qemu/target/mips/translate.c:9820:13: warnin=
g: this statement may fall through [-Wimplicit-fallthrough=3D]=0A=
> /home/debian/src/github/qemu/qemu/target/mips/translate.c:9829:13: warnin=
g: this statement may fall through [-Wimplicit-fallthrough=3D]=0A=
=0A=
They are all real issues. Two of them are cases of missing '/* fall through=
 */' (I plan to send fixes for them in 4.2 timeframe) and five of them are =
cases of missing 'break' (I plan to send corresponding fixes for 4.1 in few=
 days).=0A=
=0A=
Last time I checked gcc 'implicit-fallthrough' option was around five month=
s ago, and meanwhile some new code with missing annotation sneaked in. Howe=
ver, there is some news - it appears to me that gcc 8 improved that feature=
 significantly compared to gcc 7: some cases now detected by gcc 8 are simp=
ly went undetected by gcc 7. It appears that at least some of such cases ar=
e ignored by Coverity too.=0A=
=0A=
Great info! Thanks again!!=0A=
=0A=
Aleksandar=0A=
=0A=
=0A=
=0A=
=0A=
> Stefan=0A=

