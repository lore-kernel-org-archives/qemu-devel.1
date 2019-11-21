Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75C8BC432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 23:53:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BF16206C2
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 23:53:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="SxTbvDfE";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="mcqdvPG7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BF16206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46650 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXwGE-00013t-9N
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 18:53:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36950)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tsimpson@quicinc.com>) id 1iXwEw-0000Y1-1f
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 18:51:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tsimpson@quicinc.com>) id 1iXwEt-0004r4-05
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 18:51:57 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:39676)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tsimpson@quicinc.com>)
 id 1iXwEs-0004ou-Eu
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 18:51:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1574380314; x=1605916314;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=wmM8zxL5lXo0oYifSobfSCrN0LRhzsVpqiILD6060og=;
 b=SxTbvDfEXrziurEZmKII5MZuTnieF6C+XdBB3SFF+U8vaMLt3QRv9bQv
 uz35qK6XSB6lUsS/gCA3y1MxaBlU66nYorOfQP142vhFgmh0nfY+wzaBy
 m8mtzBnKEtyRfdk/anqh4J45GeREhMe/Az2hAzJSwM5Ezo6I2/vUDjmUN g=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
 by alexa-out-sd-01.qualcomm.com with ESMTP; 21 Nov 2019 15:51:53 -0800
IronPort-SDR: 1Y/yZ+uzNQt2UEvR3ZkRXNr6Er2sSugidkFgPLFb155JNCAB+vLofJHDApicSW8O3tne9hkKSC
 FH07AbTBm6VVV6nV/x4hc4eCQ4A3TWz6nXryaHpPe5NAfFnIigpHXwtlPCBPk1Q7q4cG0yJfvf
 CebNUiGVuZSqK+fu9cJfrUp14DwIHA8tsWh8wcJAyRfOik+KFe1d4vkE8IMi29mBXaIhyuH4bK
 B5/7zHr3mFbqpGmod077gCVQGx4DAaSUWdyKG89RonkppJeDoiShK5SJ75dkOU3NfroYeyXE+q
 REmyjc43ls9mRa0rSvyqJonF
Received: from nasanexm01g.na.qualcomm.com ([10.85.0.33])
 by ironmsg03-sd.qualcomm.com with ESMTP/TLS/AES256-SHA;
 21 Nov 2019 15:51:52 -0800
Received: from APSANEXR01B.ap.qualcomm.com (10.85.0.37) by
 NASANEXM01G.na.qualcomm.com (10.85.0.33) with Microsoft SMTP Server (TLS) id
 15.0.1473.3; Thu, 21 Nov 2019 15:51:52 -0800
Received: from nasanexm03f.na.qualcomm.com (10.85.0.47) by
 APSANEXR01B.ap.qualcomm.com (10.85.0.37) with Microsoft SMTP Server (TLS) id
 15.0.1473.3; Thu, 21 Nov 2019 15:51:49 -0800
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (199.106.107.6)
 by nasanexm03f.na.qualcomm.com (10.85.0.47) with Microsoft SMTP Server (TLS)
 id 15.0.1473.3 via Frontend Transport; Thu, 21 Nov 2019 15:51:48 -0800
Received: from BYAPR02MB4886.namprd02.prod.outlook.com (52.135.234.160) by
 BYAPR02MB4263.namprd02.prod.outlook.com (52.135.238.207) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.29; Thu, 21 Nov 2019 23:51:48 +0000
Received: from BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::b0e0:a44a:3fc6:e2b9]) by BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::b0e0:a44a:3fc6:e2b9%3]) with mapi id 15.20.2474.018; Thu, 21 Nov 2019
 23:51:47 +0000
From: Taylor Simpson <tsimpson@quicinc.com>
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Subject: RE: [PATCH] Add minimal Hexagon target - First in a series of patches
 - linux-user changes + linux-user/hexagon + skeleton of
 target/hexagon -
 Files in target/hexagon/imported are from another project and therefore do
 not conform to qemu coding standards
Thread-Topic: [PATCH] Add minimal Hexagon target - First in a series of
 patches - linux-user changes + linux-user/hexagon + skeleton of
 target/hexagon - Files in target/hexagon/imported are from another project
 and therefore do not conform to qemu coding standards
Thread-Index: AQHVnmwob37h/DrHSkKsyb+krTkIzKeWBJUAgAAH6tCAAA+9gIAAB7CA
Date: Thu, 21 Nov 2019 23:51:47 +0000
Message-ID: <BYAPR02MB4886A045E76443674DA0F198DE4E0@BYAPR02MB4886.namprd02.prod.outlook.com>
References: <1574121497-2433-1-git-send-email-tsimpson@quicinc.com>
 <CAL1e-=gFBMPj938nrPYjvkOPuMQZTEP9OFiitwLLjekgCxRaKA@mail.gmail.com>
 <BYAPR02MB48868819DDB0818111D4E972DE4E0@BYAPR02MB4886.namprd02.prod.outlook.com>
 <CAL1e-=gMvf-gx0WJ+xH0e8J84_JOkaACGA93B2XehuCAgiEyeQ@mail.gmail.com>
In-Reply-To: <CAL1e-=gMvf-gx0WJ+xH0e8J84_JOkaACGA93B2XehuCAgiEyeQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tsimpson@quicinc.com; 
x-originating-ip: [199.106.103.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: aebe241c-4598-4137-5306-08d76eddc5a5
x-ms-traffictypediagnostic: BYAPR02MB4263:
x-ms-exchange-purlcount: 3
x-microsoft-antispam-prvs: <BYAPR02MB42634DEBC6837CC1D653E1E2DE4E0@BYAPR02MB4263.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0228DDDDD7
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(346002)(136003)(366004)(39860400002)(376002)(189003)(13464003)(199004)(508600001)(256004)(102836004)(14444005)(2906002)(6116002)(316002)(54906003)(4326008)(3846002)(26005)(66446008)(64756008)(66946007)(5660300002)(14454004)(52536014)(99286004)(66066001)(7736002)(76116006)(6506007)(86362001)(305945005)(74316002)(6916009)(33656002)(561944003)(53546011)(6306002)(186003)(66476007)(6246003)(25786009)(66556008)(966005)(6436002)(9686003)(11346002)(55016002)(446003)(8936002)(81166006)(81156014)(76176011)(229853002)(7696005)(71190400001)(71200400001)(8676002)(219693003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR02MB4263;
 H:BYAPR02MB4886.namprd02.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZmCF5S6Qgdu1Wxeate7oGRN76G29KfAguZL/eB7Hk1BepxVvH7LOdcLxPNAMq945kA2NOIKCvnBVdv7AjZr7hDF63zyNHhJffRjES6XAOpFkG/Mv+YC8cw963jLKqElY6Wo1uIyxd1Gi3kDGxxladSQREOq3bBvLgwhLBpIbJx+Sk5vOHI75uDcDLEdwRZTDaq19uPE2loaSoKVqN/lJhujHYxRVBvAyKE2aQWijGecVXn0vnlvoiUgK/Qu3qtCVYM0PXk5VlyyjX630hE4G2OVAXRmSKadw+wd6Ywc3RDaZ8f5ouYl5+iHxIXPUH7igAk3pErB1rRXRdLYiKcHa4jKJtgP0OCAuGlmHtDTR+G3rFf0U1NDrKeiy9wtCdoOhqf/9gFGIYYYReHi+tXhSP1sATiztnO8h5jlTnEaOMv4EUWLdlhXfsyAmV1RKjjKsmFa/poJXZ32pFdkB9Z25opCoRGlkU78NaGBRGIvdP5o=
x-ms-exchange-transport-forked: True
arc-seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e8Jy+y1ikcessYPxf1WBHbk9FPVD2siL8MDdJZqVmQVSL5eKq3PPr+1h5yB03/sIdqO/EofPhcusObZJo60Deaf6E90OxBhgeJ7pRp7tnRtizLHYLNsTmnA5O4D7W+IgoGdzReT0MzvhWu5/4UJ1D31UheTWk9b6G6jwTWaWlSMrOqSu/MKCdiBOJFHFJax6HrrcsXcergSc4mSid2hKYgbpir/ArRebVfN7Y18mCrYUIHaGe9kn2JOBKmtTshdwaQ7N6wb19gBb6bwnnMgDBWMK/riAYAI+E22vqN/LS+/Rz/xcoTnFp8ahk7eafFkJEW1+hpnwU+YSd16aEfQJzQ==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SzPNW2O5ictCiOgFu3w/zqny6SwFWtNB2uWjQ5OgmyU=;
 b=Zbap/dKWUTn2YibhCgv2YtqSG2reMLO1fiRz96fMw+WA9kcYANGlfDjP1K0/GC3RYpgwIXO6OfYQZzvvNUQg4eLtdGw21q7WqQcEXC8zzvYaVVZBlssqRhp/hiXctVcbSmoPeDXU9HptaW7iujWfhoe+/1IDpOb+/Ohj9niarXwVZjJPGVok6sqZb/ey/y6H+HmV0L/nkHci7g07fFb8bD7GVKK0ImG2sZc6btbB/z0iVh0LOM8TcUFVBT+Y8aH6PaWJhXBU62QlQCLJ5qu5BdPQ7Uje4864ywBY95BNZZsQehs1+SiCdBYfOw1/iL0LyK1P8I75/FoVHS8NB7KTCA==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
dkim-signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SzPNW2O5ictCiOgFu3w/zqny6SwFWtNB2uWjQ5OgmyU=;
 b=mcqdvPG7TICur2+FUzsxVO+vXDorlB04Kr0ZouXDNlRfjHAwUdrnLsLUMBIDnpp7CEsSDcPWEJi2tKhgznEwsUgC2kCmleRvINDD1yRQvSly5bmHgdriu2nOY4idCwIPhLYuObqqSqY+tXno6Q2uy/04oPW/UjdTaRobk8ZPhuA=
x-ms-exchange-crosstenant-network-message-id: aebe241c-4598-4137-5306-08d76eddc5a5
x-ms-exchange-crosstenant-originalarrivaltime: 21 Nov 2019 23:51:47.7599 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: Iasv2/S6n4HBEBUdjbGUFOzFGiEb1FYvLg/ZZzAfuJOvSh2YvvkJe8+TlbcaEXAQkeDFSQUpFInlUCqA37KhhA==
x-ms-exchange-transport-crosstenantheadersstamped: BYAPR02MB4263
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: quicinc.com
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 199.106.114.38
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
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SGkgQWxla3NhbmRhciwNCg0KVGhlIGNvbXBsZXRlIHFlbXUtaGV4YWdvbiBpbXBsZW1lbnRhdGlv
biBjYW4gYmUgZm91bmQgaGVyZQ0KaHR0cHM6Ly9naXRodWIuY29tL3F1aWMvcWVtdQ0KDQpGcm9t
IHRoZSBiZWdpbm5pbmcsIEkga25ldyBJIHdvdWxkIGhhdmUgdG8gZGl2aWRlIGl0IHVwIGludG8g
c21hbGxlciBwYXRjaGVzIGZvciByZXZpZXcuICBUaGUgZGlzY3Vzc2lvbiBvbiBob3cgZGl2aWRl
IGl0IHdhcyBoZXJlDQpodHRwczovL2xpc3RzLmdudS5vcmcvYXJjaGl2ZS9odG1sL3FlbXUtZGV2
ZWwvMjAxOS0xMS9tc2cwMTk3MS5odG1sDQoNCkknbGwgc3VtbWFyaXplIHRoZSBwcm9wb3NhbA0K
ICAgIDEpIGxpbnV4LXVzZXIgY2hhbmdlcyArIGxpbnV4LXVzZXIvaGV4YWdvbiArIHNrZWxldG9u
IG9mIHRhcmdldC9oZXhhZ29uDQogICAgMikgQWRkIHRoZSBjb2RlIHRoaXMgaW1wb3J0ZWQgZnJv
bSB0aGUgSGV4YWdvbiBzaW11bGF0b3IgYW5kIHRoZSBxZW11IGhlbHBlciBnZW5lcmF0b3INCiAg
ICAzKSBBZGQgc3VwcG9ydCBmb3IgcGFja2V0IHNlbWFudGljcw0KICAgIDQpIEFkZCBzdXBwb3J0
IGZvciB3aWRlIHZlY3RvciBleHRlbnNpb25zDQogICAgNSkgQWRkIHRoZSBoZWxwZXIgb3ZlcnJp
ZGVzIGZvciBwZXJmb3JtYW5jZSBvcHRpbWl6YXRpb24NCg0KTXkgYXNzdW1wdGlvbiBpbiB0aGUg
cHJvcG9zYWwgd2FzIHRoYXQgZWFjaCBwaGFzZSBvZiB0aGUgc3VibWlzc2lvbiBzaG91bGQgY29t
cGlsZSBhbmQgZXhlY3V0ZSwgYW5kIGVhY2ggcGhhc2Ugc2hvdWxkIGV4cGFuZCB0aGUgY2FwYWJp
bGl0aWVzIG9mIHRoZSBIZXhhZ29uIHRhcmdldC4gIEkgYXBvbG9naXplIHRoYXQgaXQgd2Fzbid0
IGNsZWFyIGhvdyBsYXJnZSBlYWNoIG9mIHRoZSBwYXRjaGVzIHdvdWxkIGJlLg0KDQpJIGdyZWF0
bHkgYXBwcmVjaWF0ZSBhbGwgb2YgdGhlIGZlZWRiYWNrIG9uIHRoZSBwcm9wb3NhbCBhbmQgdGhl
IHBhdGNoLCBhbmQgSSBhbSBtYWtpbmcgdGhlIHJldmlzaW9ucy4gIEluIHNldmVyYWwgY2FzZXMs
IHRoZSBmZWVkYmFjayBhbHNvIGFwcGxpZXMgdG8gdGhlIHJlbWFpbmRlciBvZiB0aGUgY29kZS4g
IFNvLCBJIGFtIG1ha2luZyB0aGUgY2hhbmdlcyB0aGVyZSBhcyB3ZWxsLiAgRnJvbSB0aGF0IHBl
cnNwZWN0aXZlLCBJIHRoaW5rIGl0IHdpbGwgcmVkdWNlIHRoZSBvdmVyYWxsIGJ1cmRlbiBvbiB0
aGUgcmV2aWV3ZXJzLg0KDQpBcyBmYXIgYXMgd2hhdCBtaWdodCBjaGFuZ2UgaW4gdGhlIGltcG9y
dGVkIGZpbGVzIGdvZXMsIHRoZSBjdXJyZW50IHNpbXVsYXRvciAoaGV4YWdvbi1zaW0pIGhhcyBi
ZWVuIHVzZWQgaW4gcHJvZHVjdGlvbiBhcyBwYXJ0IG9mIHRoZSB0b29sY2hhaW4gZm9yIG92ZXIg
YSBkZWNhZGUgYW5kIGhhcyBiZWVuIHVzZWQgdG8gdmVyaWZ5IGV2ZXJ5IHZlcnNpb24gb2YgdGhl
IGNvcmUgdGhhdCB3ZSBoYXZlIHNoaXBwZWQuICBTaW5jZSBpdCBpcyB1c2VkIGluIHZlcmlmaWNh
dGlvbiwgaXQgaXMgY29uc2lkZXJlZCB0aGUgZ29sZCBzdGFuZGFyZCAtIG1vcmUgc28gdGhhbiB0
aGUgUERGIG1hbnVhbC4gIEFueSBjaGFuZ2VzIHRvIHRoYXQgY29kZSwgaW5jbHVkaW5nIHJlZm9y
bWF0dGluZywgd291bGQgcHV0IHFlbXUgYXQgcmlzayBvZiBub3QgYWNjdXJhdGVseSBlbXVsYXRp
bmcgdGhlIHByb2Nlc3Nvci4NCg0KVGF5bG9yDQoNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCkZyb206IEFsZWtzYW5kYXIgTWFya292aWMgPGFsZWtzYW5kYXIubS5tYWlsQGdtYWlsLmNv
bT4NClNlbnQ6IFRodXJzZGF5LCBOb3ZlbWJlciAyMSwgMjAxOSAyOjQ1IFBNDQpUbzogVGF5bG9y
IFNpbXBzb24gPHRzaW1wc29uQHF1aWNpbmMuY29tPg0KQ2M6IExhdXJlbnQgVml2aWVyIDxsYXVy
ZW50QHZpdmllci5ldT47IFJpa3UgVm9pcGlvIDxyaWt1LnZvaXBpb0Bpa2kuZmk+OyBRRU1VIERl
dmVsb3BlcnMgPHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4NClN1YmplY3Q6IFJlOiBbUEFUQ0hdIEFk
ZCBtaW5pbWFsIEhleGFnb24gdGFyZ2V0IC0gRmlyc3QgaW4gYSBzZXJpZXMgb2YgcGF0Y2hlcyAt
IGxpbnV4LXVzZXIgY2hhbmdlcyArIGxpbnV4LXVzZXIvaGV4YWdvbiArIHNrZWxldG9uIG9mIHRh
cmdldC9oZXhhZ29uIC0gRmlsZXMgaW4gdGFyZ2V0L2hleGFnb24vaW1wb3J0ZWQgYXJlIGZyb20g
YW5vdGhlciBwcm9qZWN0IGFuZCB0aGVyZWZvcmUgZG8gbm90IGNvbmZvcm0gdG8gcWVtdSBjb2Rp
bmcgc3RhbmRhcmRzDQoNCk9uIFRodSwgTm92IDIxLCAyMDE5IGF0IDg6NTIgUE0gVGF5bG9yIFNp
bXBzb24gPHRzaW1wc29uQHF1aWNpbmMuY29tPiB3cm90ZToNCj4NCj4gVGhleSBhcmUgaW1wb3J0
ZWQgZnJvbSB0aGUgZXhpc3RpbmcgSGV4YWdvbiBzaW11bGF0b3IuICBQbGVhc2UgdW5kZXJzdGFu
ZCB0aGF0IHRoaXMgcGF0Y2ggaXMgdGhlIGZpcnN0IGluIGEgc2VyaWVzLiAgTGF0ZXIgcGF0Y2hl
cyB3aWxsIGNvbnRhaW4gbW9yZSBlbGFib3JhdGUgY29udGVudHMgaW4gdGhhdCBkaXJlY3Rvcnku
ICBUaGUgcmVhc29uIEkgZG9uJ3Qgd2FudCB0byByZWZvcm1hdCB0aGVtIGlzIHRvIHN0YXkgaW4g
c3luYyB3aXRoIHRoZSBvdGhlciBzaW11bGF0b3IgaW4gdGhlIGZ1dHVyZS4gIFdoZW4gdGhlIG90
aGVyIHRlYW0gbWFrZXMgY2hhbmdlcyB0byB0aGUgY29kZSAoZWl0aGVyIHRvIGZpeCBidWdzIG9y
IGFkZCBmZWF0dXJlcyksIGl0IHdpbGwgYmUgZWFzaWVyIHRvIGlkZW50aWZ5IHRoZSBjaGFuZ2Vz
IGFuZCBicmluZyB0aGVtIGludG8gcWVtdS4NCj4NCj4gVGF5bG9yDQo+DQoNClRheWxvciwNCg0K
UGxlYXNlIHVuZGVyc3RhbmQgdGhhdCB0aGlzIHBhdGNoIGNhbid0IHJlbWFpbiBhIHNpbmdsZSBw
YXRjaC4gSXQgY2FuJ3QgcmVtYWluIGV2ZW4gYSBzZXQgb2YgMiBvciAzIHBhdGNoZXMgYXMgb3Ro
ZXJzIHN1Z2dlc3RlZC4gQSBwYXRjaCBpcyBhIGxvZ2ljYWxseSBjb25uZWN0ZWQgdW5pdCBvZiBj
b2RlIHdob3NlIHR5cGljYWwgc2l6ZSBpcyBsZXNzIHRoYW4NCjIwMCBsaW5lcy4gVGhlcmUgYXJl
IGxvdHMgb2Ygc3VjaCBsb2dpY2FsIHVuaXRzIGluIHRoaXMgc2luZ2xlIHBhdGggdGhhdCB5b3Ug
c2VudCwgYW5kIHlvdSBzaG91bGQgbm90IGhhdmUgc2VudCBpdCBpbiBpdHMgcHJlc2VudCBmb3Jt
LCBldmVuIGlmIHlvdSB3YW50ZWQganVzdCBjb21tZW50cyB0byBpdC4gWW91IHNob3VsZCBoYXZl
IHN1Ym1pdHRlZCBhIHNlcmllcyByYXRoZXIgdGhhbiBhIHNpbmdsZSBwYXRjaC4gQW5kIHlvdSBz
aG91bGQgaGF2ZSBzYWlkIHRoaXMgaXMgdjEgb2YgbXkgc2VyaWVzIHRoYXQgSSB3aWxsIGV4cGFu
ZCBsYXRlciBvbi4gR3VpZGVsaW5lcyBmb3Igc3VibWlzc2lvbnMgYXJlIGhlcmU6DQoNCmh0dHBz
Oi8vd2lraS5xZW11Lm9yZy9Db250cmlidXRlL1N1Ym1pdEFQYXRjaA0KDQpBcyBmYXIgYXMgImlt
cG9ydGVkIiBmaWxlcywgZnJhbmtseSwgSSBkaXNsaWtlIHRoZSBmYWN0IHRoYXQgeW91IGFyZSB3
aWxsaW5nIHRvIHNhY3JpZmljZSBvdXIgY29kaW5nIHN0eWxlIGd1aWRlbGluZXMgaW4gZmF2b3Ig
dG8geW91ciBjb252ZW5pZW5jZS4gQnV0LCBtb3JlIHRoYW4gdGhpcywgSSBhbHNvIGZpbmQgdmVy
eSBwcm9ibGVtYXRpYyB0aGF0IHlvdSBwcmFjdGljYWxseSBjcmVhdGUgYSBkZXBlbmRlbmN5IGJl
dHdlZW4gUUVNVSBhbmQgYW5vdGhlciBzaW11bGF0b3IuIFFFTVUgaW1wbGVtZW50YXRpb24gc2hv
dWxkIHJlbHkgb24gc3BlY2lmaWNhdGlvbnMsIGFuZCBvbmx5IG9uIHNwZWNpZmljYXRpb25zLCBh
bmQgY2VydGFpbmx5IHNob3VsZCBub3QgZGVwZW5kIG9uIGFub3RoZXIgc2ltdWxhdG9yLiBDdXJy
ZW50bHksIGluIFFFTVUsIHRoZXJlIGFyZSBzb21lIGNhc2VzIG9mIGltcG9ydGVkIGRpc2Fzc2Vt
YmxlcnMgb3Igc2ltaWxhciByZWxhdGl2ZWx5IHVuaW1wb3J0YW50IHRvb2xzLCBidXQgdGhvc2Ug
aW1wb3J0cyBjaGFuZ2UgdmVyeSByYXJlbHksIGFuZCBhcmUgbW9kaWZpZWQgdG8gY29tcGx5IHRv
IFFFTVUgY29kaW5nIHN0eWxlLiBJIGFtIG5vdCBhd2FyZSBvbiBkZXBlbmRlbmN5IG9mIFFFTVUg
b24gYW5vdGhlciBzaW11bGF0b3IgaW4gdGhlIGZvcm0geW91IHdhbnQgdG8gZG8gZm9yIEhleGFn
b24uIE15IHN0cm9uZyBpbXByZXNzaW9uIGlzIHRoYXQgeW91IHdpbGwgY3JlYXRlIG1vcmUgcHJv
YmxlbXMgdGhhbiBiZW5lZml0cyB3aXRoIHN1Y2ggZGVwZW5kZW5jeSwgYm90aCBmb3IgeW91IGFu
ZCBmb3IgUUVNVSBpbiBnZW5lcmFsLg0KDQpPbmNlIGEgQ1BVIG9yIGFueSBvdGhlciBkZXZpY2Ug
aXMgc3BlY2lmaWVkIHRob3VnaCBkb2N1bWVudGF0aW9uLCB0aGVzZSBzcGVjcyBkb24ndCBjaGFu
Z2UuIENvbnNlcXVlbnRseSwgdGhlaXIgZW11bGF0aW9uIGRvZXMgbm90IGNoYW5nZSB0b28sIGlu
IGZ1bmN0aW9uYWwgc2Vuc2UuIFRoZSBmYWN0IHRoYXQgeW91IGFudGljaXBhdGUgY2hhbmdlcyBp
biB0aGVzZSBmaWxlcyBpbXBvcnRlZCBmcm9tIGFub3RoZXIgc2ltdWxhdG9yLCBsZWF2ZXMgbWUg
d2l0aCBhIChwb3NzaWJseSB3cm9uZykgcGVyY2VwdGlvbiB0aGF0IG5laXRoZXIgSGV4YWdvbiBp
bnRlcm5hbCBzaW11bGF0b3Igbm9yIFFFTVUgaW1wbGVtZW50YXRpb24geW91IGFyZSB0cnlpbmcg
dG8gaW50ZWdyYXRlIGFyZSBjb21wbGV0ZS4gSWYgdGhhdCBpcyBub3QgdHJ1ZSwgY2FuIHlvdSBl
eHBsYWluIHdoYXQgZXhhY3RseSB5b3UgZXhwZWN0IHRvIGJlIGNoYW5naW5nIGluIGltcG9ydGVk
IGZpbGVzPw0KDQpZb3VycywNCkFsZWtzYW5kYXINCg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2Fn
ZS0tLS0tDQo+IEZyb206IEFsZWtzYW5kYXIgTWFya292aWMgPGFsZWtzYW5kYXIubS5tYWlsQGdt
YWlsLmNvbT4NCj4gU2VudDogVGh1cnNkYXksIE5vdmVtYmVyIDIxLCAyMDE5IDE6MjAgUE0NCj4g
VG86IFRheWxvciBTaW1wc29uIDx0c2ltcHNvbkBxdWljaW5jLmNvbT4NCj4gQ2M6IExhdXJlbnQg
Vml2aWVyIDxsYXVyZW50QHZpdmllci5ldT47IFJpa3UgVm9pcGlvDQo+IDxyaWt1LnZvaXBpb0Bp
a2kuZmk+OyBRRU1VIERldmVsb3BlcnMgPHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4NCj4gU3ViamVj
dDogUmU6IFtQQVRDSF0gQWRkIG1pbmltYWwgSGV4YWdvbiB0YXJnZXQgLSBGaXJzdCBpbiBhIHNl
cmllcyBvZg0KPiBwYXRjaGVzIC0gbGludXgtdXNlciBjaGFuZ2VzICsgbGludXgtdXNlci9oZXhh
Z29uICsgc2tlbGV0b24gb2YNCj4gdGFyZ2V0L2hleGFnb24gLSBGaWxlcyBpbiB0YXJnZXQvaGV4
YWdvbi9pbXBvcnRlZCBhcmUgZnJvbSBhbm90aGVyDQo+IHByb2plY3QgYW5kIHRoZXJlZm9yZSBk
byBub3QgY29uZm9ybSB0byBxZW11IGNvZGluZyBzdGFuZGFyZHMNCj4NCj4NCj4gPiAgY3JlYXRl
IG1vZGUgMTAwNjQ0IHRhcmdldC9oZXhhZ29uL2ltcG9ydGVkL2dsb2JhbF90eXBlcy5oDQo+ID4g
IGNyZWF0ZSBtb2RlIDEwMDY0NCB0YXJnZXQvaGV4YWdvbi9pbXBvcnRlZC9pc3NfdmVyX3JlZ2lz
dGVycy5oDQo+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NCB0YXJnZXQvaGV4YWdvbi9pbXBvcnRlZC9t
YXguaCAgY3JlYXRlIG1vZGUNCj4gPiAxMDA2NDQgdGFyZ2V0L2hleGFnb24vaW1wb3J0ZWQvcmVn
cy5oDQo+DQo+IFRheWxvciwgaWYgSSB1bmRlcnN0b29kIHlvdSB3ZWxsLCB0aGVzZSBmaWxlcyBk
b24ndCBjb25maXJtIHRvIFFFTVUgY29kaW5nIHN0YW5kYXJkLCBiZWNhdXNlIHRoZXkgYXJlIGlt
cG9ydGVkLiBCdXQsIGZyb20gd2hlcmU/IEFuZCB3aGF0IGlzIHRoZSByZWFzb24gdGhleSBuZWVk
IHRvIGJlIGltcG9ydGVkIChhbmQgbm90IGNyZWF0ZWQgaW5kZXBlbmRlbnRseSBieSB5b3Ugb3Ig
c29tZWJvZHkgZWxzZSwgYnV0IHdpdGhpbiBRRU1VIGNvZGUgc3R5bGUgZ3VpZGVsaW5lcykgPw0K
PiBUaGVpciBjb250ZW50IGxvb2tzIGZhaXJseSBzaW1wbGUgdG8gbWUuDQo+DQo+IFRoYW5rcywN
Cj4gQWxla3NhbmRhcg0K

